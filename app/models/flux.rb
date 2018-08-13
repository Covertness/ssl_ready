# flux
class Flux < ApplicationRecord
  belongs_to :domain

  validates_presence_of :rx, :tx
end
