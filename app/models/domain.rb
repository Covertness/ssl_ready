# domain
class Domain < ApplicationRecord
  has_one :flux, dependent: :destroy

  validates_presence_of :source_host

  after_create :init_flux

  enum state: %i[unverified verifying verified verify_failed]

  def init_flux
    self.flux = Flux.create(rx: 0, tx: 0)
  end

  def expired?
    renewal_date.blank? || renewal_date <= Time.now
  end
end
