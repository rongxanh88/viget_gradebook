require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe "valid attributes" do
    it { should validate_presence_of(:grade) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
  end
end