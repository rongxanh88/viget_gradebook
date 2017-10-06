require 'rails_helper'

RSpec.describe Semester, type: :model do
  describe "valid attributes" do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:semester_courses) }
    it { should have_many(:courses) }
  end
end