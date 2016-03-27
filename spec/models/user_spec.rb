require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to have_many(:projects) }
  it { expect(subject).to have_many(:tasks).through(:projects) }
  it { expect(subject).to have_many(:comments).through(:tasks) }
end
