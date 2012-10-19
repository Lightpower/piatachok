# encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :family_id, :username

  attr_accessor :username

  belongs_to :family
  has_many   :invites

  # filters
  before_create  :validate_login_and_email
  after_create   :create_default_family,     if: Proc.new { self.family.blank? }

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

  # function to handle user's signing in via email or login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username).downcase
      where(conditions).where("login=? or email=?", username, username).first
      #where(conditions).where('$or' => [ {:login => /^#{Regexp.escape(username)}$/i}, {:email => /^#{Regexp.escape(username)}$/i} ]).first
    else
      where(conditions).first
    end
  end

  private

  # Filter for creating Family for new user
  def create_default_family
    self.create_family(name: "Семья #{self.show_name}", head: self)
    self.save
  end

  ##
  # Login OR email should not be nil
  # If login is not nil it should be unique
  # If email is not nil it should be unique
  def validate_login_and_email
    self.errors.add(:login, "и Email не могут быть пустыми одновременно") if(login.blank? && email.blank?)
    self.errors.add(:login, "уже есть в нашей базе")                      if(login.present? && User.where(login: login).present?)
    self.errors.add(:email, "уже есть в нашей базе")                      if(email.present? && User.where(email: email).present?)
    self.errors.messages.blank?
  end


end
