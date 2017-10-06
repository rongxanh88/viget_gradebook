require 'rails_helper'

RSpec.describe SemesterCourse, type: :model do
  describe "relationships" do
    it { should belong_to(:semester) }
    it { should belong_to(:course) }

    it { should have_many(:enrollments) }
  end
end
