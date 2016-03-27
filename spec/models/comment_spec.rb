require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { expect(subject).to belong_to(:task) }

  it { expect(subject).to validate_presence_of(:task) }
  it { expect(subject).to validate_presence_of(:body) }

  it { expect(subject).to respond_to(:body, :file_link) }
end
