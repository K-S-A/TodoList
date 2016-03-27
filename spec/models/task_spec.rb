require 'rails_helper'

RSpec.describe Task, type: :model, focus: true do
  before(:all) { @project = FactoryGirl.create(:project) }

  subject { FactoryGirl.build(:task) }

  let(:first_task) { FactoryGirl.create(:task, project: @project) }

  let(:second_task) do
    FactoryGirl.create(:task, project: @project, priority: 0)
  end

  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to have_many(:comments).dependent(:destroy) }

  it { expect(subject).to validate_presence_of(:project) }
  it { expect(subject).to validate_presence_of(:name) }

  it do
    expect(subject).to validate_uniqueness_of(:name)
      .scoped_to(:project_id)
      .case_insensitive
  end

  it 'should set default scope to ASC order by priority' do
    first_task
    second_task

    expect(@project.tasks).to eq([second_task, first_task])
  end

  it { expect(subject).to respond_to(:name, :deadline, :completed, :priority) }
end
