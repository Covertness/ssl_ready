# domain
class DomainsController < ApplicationController
  skip_before_action :verify_authenticity_token # remove after add auth
  helper_method :domain

  def index
    json_response(domains.map { |d| domain_json(d) })
  end

  def create
    @domain = Domain.create!(domain_params)
    cache_dest

    GenerateCertificateWorker.perform_async(@domain.id)

    if request.format.json?
      json_response({ status: 0, data: @domain }, :created)
    else
      redirect_to(@domain)
    end
  end

  def show
    json_response(domain_json(domain)) if request.format.json?
  end

  def update
    domain.update(domain_params)
    cache_dest

    head :no_content
  end

  def destroy
    domain.destroy
    head :no_content
  end

  private

  def domain_params
    params.permit(:source_host, :dest_host)
  end

  def domains
    @domains ||= Domain.all
  end

  def domain
    @domain ||= Domain.find(params[:id])
  end

  def domain_json(domain)
    domain.as_json(
      only: %i[id source_host dest_host state renewal_date], 
      include: %i[flux]
    )
  end

  def cache_dest
    $redis_certificate.set("#{domain.source_host}-dest", domain.dest_host)
  end
end
