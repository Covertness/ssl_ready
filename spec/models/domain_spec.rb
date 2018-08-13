require 'rails_helper'

RSpec.describe Domain, type: :model do
  it { should have_one(:flux).dependent(:destroy) }

  it { should validate_presence_of(:source_host) }
end
