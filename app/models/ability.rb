class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.id.present? # existing user
      can [:view, :read, :manage, :destroy], MoneyOperation,  family_id: user.family_id
      # default categories
      can :view, Category, family_id: nil
      # user categories
      can [:create, :manage, :view, :destroy], Category,  family_id: user.family_id

      can :view, User,     family_id: user.family_id
      can :view, Family,   id: user.family_id
      can :manage, Family, id: user.family_id, head: user

      # invite to Family from current user
      can :create, Invite
      # invite from Family to some user can be created by family's head only
      can :create_invite, Family,   head: user
      # invite can be accepted by recipient user (not sender)
      can :accept, Invite,   ["invites.created_by != ?", user.id] do |invite|
        invite.creator != user
      end
      # invite can be rejected by both of sender and recipient
      can :reject, Invite, Invite.all do |invite|
        invite.connected_with?(user)
      end
    else

    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
