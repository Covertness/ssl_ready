class GenerateCertificateWorker
  include Sidekiq::Worker
  def perform(domain_id)
    domain = Domain.find(domain_id)
    return if domain.blank? || !domain.expired?

    GenerateCertificateService.new(domain).call
  end
end
