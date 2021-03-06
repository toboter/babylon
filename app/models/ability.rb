class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # can :read/create/update/destroy||manage, 'String'/Class||:all, restrictions

    if user.role? :guest #kann 'published' db Informationen lesen, Bilder herunterladen
      can :read, :all# , :published => true
      cannot :read, 'Aspects'
      cannot :read, Issue
      cannot :read, Todo
      # can :read, 'downloads'
      # can :read, 'info'
      cannot [:destroy, :edit, :create], :all
      can [:edit, :update], Person, :user_id => user.id # User sollen ihr eigenes Personenprofil editieren können
    end

    if user.role? :fellow #kann Informationen lesen die noch nicht published sind
      can :read, :all
      cannot :read, Todo
      cannot [:destroy, :edit, :create], :all

      can [:read, :create, :update], Todo, :project => { :members => { :id => user.id }} #@Todo.project.members.include?(current_user)
      # can :read, 'downloads'
      # can :read, 'info'
      can [:read, :create], Issue
      can [:edit, :update], Project, :memberships => { :user_id => user.id, :role => 'admin' }
      can [:create, :edit, :update], Person, :user_id => user.id # User sollen ihr eigenes Personenprofil editieren können
      can [:edit], ['Profile']
    end

    if user.role? :author #kann Informationen hinzufügen, Datensätze anlegen, nichts löschen
      can :manage, :all
      cannot [:create, :edit, :update, :destroy], [Cluster, Group, Institution, Collection, Item, Snippet]
      can [:edit, :update], Group, group_admin: user
      can [:edit, :update], Cluster, cluster_admin: user
      cannot :destroy, :all
      cannot [:edit, :update], Person # User sollen sich als Personenprofil selbst und unverbundene Profile editieren können
      can [:edit, :update], Person, :user_id => nil
      can [:edit, :update], Person, :user_id => user.id
      cannot :destroy, Asset
      cannot :manage, ['curation', 'project-assignments', 'publishing', 'roles', 'recreate-versions', 'development', 'personal-informations', 'settings']
    end

    if user.role? :editor #kann hinzugefügte Informationen auf published setzen, Standardseiten editieren
      can :manage, :all
      cannot [:create, :edit, :update, :destroy], [Cluster, Collection]
      can :create, Group
      can [:edit, :update], Group, group_admin: user
      can [:edit, :update], Cluster, cluster_admin: user
      can [:edit, :update], [Group, Cluster], creator: user
      cannot [:edit, :update, :destroy], Person # User sollen sich als Personenprofil selbst und unverbundene Profile editieren und löschen können
      can [:edit, :update, :destroy], Person, :user_id => nil
      can [:edit, :update, :destroy], Person, user_id: user.id
      cannot :manage, ['project-assignments', 'roles', 'recreate-versions', 'development', 'personal-informations', 'Memberships']
    end

    if user.role? :admin 
    # kann Rollen editieren (außer su), Module hinzufügen (in seinen Modulen Gruppen und Projekte 
    # hinzufügen. Da kann das aber auch der Modul-/Gruppenadmin), Collections editieren 
    # und Items Collections neu zuweisen.
      can :manage, :all
      cannot :manage, ['development']
    end

    if user.role? :superuser 
    # kann alles, überall
      can :manage, :all
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
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
