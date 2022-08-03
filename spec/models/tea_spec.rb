require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "relationships" do
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:subscriptions).through(:tea_subscriptions) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temp) }
    it { should validate_presence_of(:brew_time) }
    it { should validate_uniqueness_of(:title) }
  end

  describe "class methods" do
  end
end
