require 'spec_helper'

describe Operation do

  it { should have_db_column(:type).of_type(:string) }
  it { should have_db_column(:amount).of_type(:integer) }
  it { should have_db_column(:category_id).of_type(:integer) }
  it { should have_db_column(:user_id).of_type(:integer) }
  it { should have_db_column(:created_by).of_type(:integer) }
  it { should have_db_column(:comment).of_type(:text) }

  it { should have_db_index(:category_id) }
  it { should have_db_index(:created_by) }
  it { should have_db_index(:type) }
  it { should have_db_index(:user_id) }

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:creator) }


end

