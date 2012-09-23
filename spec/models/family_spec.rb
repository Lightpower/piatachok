require 'spec_helper'

describe Family do
  it { should have_many(:users) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:head) }

end
