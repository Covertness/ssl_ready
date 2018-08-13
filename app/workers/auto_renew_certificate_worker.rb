class AutoRenewCertificateWorker
  include Sidekiq::Worker

  CERT_GENERATE_WINDOW_IN_MINUTES = [1, 5].freeze

  def perform
    expired_domains = Domain.where('renewal_date < ?', Time.now)
    expired_domains.each do |domain|
      GenerateCertificateWorker.perform_in(
        rand(CERT_GENERATE_WINDOW_IN_MINUTES[0]..CERT_GENERATE_WINDOW_IN_MINUTES[1]).minutes,
        domain.id
      )
    end
  end
end
