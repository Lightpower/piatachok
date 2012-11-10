require 'spec_helper'

describe Category do
  it { should have_db_column(:name) }
  it { should have_db_column(:family_id) }
  it { should have_db_column(:type) }

  it { should have_db_index(:name) }
  it { should have_db_index(:type) }
  it { should have_db_index(:family_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }

end
