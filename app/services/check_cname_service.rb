require 'resolv'

# check dns cname
class CheckCnameService
  def call(domain)
    r = Resolv::DNS.open do |dns|
      dns.getresource(domain, Resolv::DNS::Resource::IN::CNAME)
    end
    r.name.to_s == ENV['FRONT_SERVER_DOMAIN']
  rescue Resolv::ResolvError => e
    false
  end
end
