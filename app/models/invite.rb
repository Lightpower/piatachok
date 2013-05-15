class Invite < ActiveRecord::Base

  attr_accessible :family, :user, :creator, :is_sent_to_email

  belongs_to :family
  belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: :created_by

  ##
  # Is it invite from family to user?
  #
  def from_family?
    self.family.head_id == self.created_by
  end

  ##
  # Is invite created by user or intended for user
  #
  def connected_with?(user)
    self.user == user || self.family.head == user
  end

  ##
  # Define the name for showing in invite block for head of family
  #
  def name_for_family
    (user.present? ? user.show_name : email )
  end

  ##
  # Define the name for showing in invite block for user
  #
  def name_for_user
    family.name
  end

  ##
  # Accept the invite
  #
  def accept
    user = User.find_by_id(@invite.user_id).first
    if user.present?
      if user.family.users.size == 1
        user.family.destroy
      end
      user.family_id = @invite.family_id
      user.save!
    end
  end

end
