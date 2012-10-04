class Invite < ActiveRecord::Base

  belongs_to :family
  belongs_to :user
  belongs_to :user, foreign_key: :created_by
end
