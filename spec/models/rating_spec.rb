require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should validate_inclusion_of(:score).in_range(1..10) }
end
