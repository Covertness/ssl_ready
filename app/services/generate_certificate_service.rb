require 'openssl'
require 'acme-client'

# generate ssl cert
class GenerateCertificateService
  TIMEOUT_LIMIT = 30 # in seconds

  def initialize(domain)
    @domain = domain
    @client = Acme::Client.new(
      private_key: OpenSSL::PKey::RSA.new($lc_config['private_key']),
      directory: 'https://acme-v02.api.letsencrypt.org/directory',
      kid: $lc_config['kid']
    )

    @order = @client.new_order(identifiers: [domain.source_host.chomp('.')])
    @authorization = @order.authorizations.first
  end

  def call
    $redis_challenge.set(verification_token[:query], verification_token[:answer])

    @domain.update!(state: :verifying)

    if challenge.request_validation
      timeout_guard = 0
      while challenge.status == 'pending' and timeout_guard < TIMEOUT_LIMIT
        timeout_guard += 1
        sleep 1
      end

      if challenge.status == 'valid'
        @domain.update!(state: :verified)
      else
        @domain.update!(state: :verify_failed)
        return challenge.error
      end
    end

    domain_private_key = OpenSSL::PKey::RSA.new(4096)
    csr = Acme::Client::CertificateRequest.new(private_key: domain_private_key, subject: { common_name: @domain.source_host })
    @order.finalize(csr: csr)
    sleep(1) while @order.status == 'processing'

    key = domain_private_key.to_pem
    cert = @order.certificate

    @domain.update!(
      public_key: cert,
      private_key: key,
      renewal_date: Time.now + 60.days
    )

    $redis_certificate.set("#{@domain.source_host}-key", key)
    $redis_certificate.set("#{@domain.source_host}-cert", cert)
  end

  private

  def verification_token
    @verification_token ||= {
      query: challenge.token,
      answer: challenge.file_content
    }
  end

  def challenge
    @challenge ||= @authorization.http
  end
end
