class Ability
  include CanCan::Ability

  def initialize(manager)
    manager ||= Manager.new

    case manager.role
      when 'admin'
        can :manage, :all
        can :read, :all
        can :new, :all
        can :create, :all
        can :edit, :all
        can :update, :all
        can :destroy, :all
      when 'write'
        can :read, :all
        can :new, :all
        can :create, :all
        can :edit, :all
        can :update, :all
        can :destroy, :all
      when 'read'
        can :read, :all
    end
  end
end
