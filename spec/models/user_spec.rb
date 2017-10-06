require 'rails_helper'

RSpec.describe User, type: :model do
  describe "valid attributes" do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:role) }

    it { should validate_uniqueness_of(:username) }

    it { should define_enum_for(:role) }

    it { should have_secure_password }
  end

  describe "relationships" do
    it { should have_many(:enrollments) }
    it { should have_many(:courses) }
  end
end
