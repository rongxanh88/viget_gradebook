require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "valid attributes" do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:semester_courses) }
    it { should have_many(:semesters) }
  end
end