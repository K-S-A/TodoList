require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:all) { @user = FactoryGirl.create(:user) }

  subject { FactoryGirl.build(:project, user: @user) }

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to have_many(:tasks).dependent(:destroy) }

  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_length_of(:title).is_at_least(5) }
  it { expect(subject).to validate_length_of(:title).is_at_most(55) }

  it do
    expect(subject).to validate_uniqueness_of(:title)
      .scoped_to(:user_id)
      .case_insensitive
  end
  it { expect(subject).to validate_length_of(:description).is_at_most(250) }

  it { expect(subject).to respond_to(:title, :description) }
end
