# encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :family_id

  belongs_to :family
  has_many :invites

  # filters
  after_create :create_default_family,     if: Proc.new { self.family.blank? }

  # User can exist without family

  ##
  # Get the head of family which this user belongs to
  #
  def head_of_family
    self.family.head
  end

  ##
  # List of all users which are belong to the same family
  #
  # Params:
  #  include_this_user {boolean} - except this user from result list if true, otherwise include this user
  #
  # Returns {Array} - list of users which are belongs to the same family as this user
  def relatives(include_this_user=false)
    if include_this_user
      self.family.users
    else
      self.family.users.where("id <> ?", self.id)
    end
  end

  ##
  # Create the string with name of this user
  #
  def show_name
    return_string = ""
    if first_name.present? || last_name.present?
      return_string = "#{first_name} #{last_name}".strip
    end
    if login.present?
      return_string = return_string.blank? ? login : "#{return_string} (#{login})".strip
    end
    if return_string.blank?
      return_string = email
    end
    return_string
  end

  # Invites which are made by this user
  def invites_from_me
    invites.where(:created_by => self)
  end

  # Invites which are made FOR this user
  def invites_to_me
    invites.where("created_by != ?", self.id)
  end

  private

  # Filter for creating Family for new user
  def create_default_family
    #self.family = Family.create(name: "Семья #{self.show_name}", head: self)
    self.create_family(name: "Семья #{self.show_name}", head: self)
    self.save
  end


end
