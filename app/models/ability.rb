class Ability
  include CanCan::Ability

  def initialize(manager)
    if manager
      if manager.role == 'admin'
        can :manage, :all
        can :read, :all
        can :new, :all
        can :create, :all
        can :edit, :all
        can :update, :all
        can :destroy, :all
      end
      if manager.role == 'write'
        can :read, :all
        can :new, :all
        can :create, :all
        can :edit, :all
        can :update, :all
        can :destroy, :all
      end
      if manager.role == 'read'
        can :read, :all
      end
    end
  end
end
