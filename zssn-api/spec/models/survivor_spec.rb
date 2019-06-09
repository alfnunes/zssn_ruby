require 'rails_helper'

RSpec.describe Survivor, type: :model do
  describe "Associations" do
    it{ is_expected.to have_one :inventory }
    it{ is_expected.to have_many(:inventory_resources).through(:inventory) }
  end
end