require 'rails_helper'

RSpec.describe Flux, type: :model do
  it { should belong_to(:domain) }
  
  it { should validate_presence_of(:rx) }
  it { should validate_presence_of(:tx) }
end
