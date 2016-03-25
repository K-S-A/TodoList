require 'rails_helper'

RSpec.describe Task, type: :model do
  it { expect(subject).to belong_to(:project) }

  it { expect(subject).to validate_presence_of(:name) }

  it do
    expect(subject).to validate_uniqueness_of(:name)
      .scoped_to(:project_id)
      .case_insensitive
  end
end
