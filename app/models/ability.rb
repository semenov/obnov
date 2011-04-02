class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    
    can :manage, Stream, :user_id => user.id
    can :read, Stream, :member_ids => user.id
    
    can :manage, Post, :user_id => user.id
    can :manage, Post, :stream => { :user_id => user.id }
    can :read, Post, :stream_id.in => user.stream_ids
    
    can :manage, Comment, :user_id => user.id
    can :manage, Comment, :post => { :stream => { :user_id => user.id } }
    can :read, Comment, :post => { :stream_id.in => user.stream_ids }
    
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