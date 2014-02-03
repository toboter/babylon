class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :guest #kann 'published' db Informationen lesen, Bilder herunterladen
      can :read, :all
      cannot :destroy, :all
    end

    if user.role? :fellow #kann Informationen lesen die noch nicht published sind
      can :follow, :all
      cannot :destroy, :all
    end

    if user.role? :author #kann Informationen hinzufügen, Datensätze anlegen
      can :edit, :all
    end

    if user.role? :editor #kann hinzugefügte Informationen auf published setzen, Standardseiten editieren
      can :publish, :all
    end

    if user.role? :admin #kann Rollen editieren (außer su), Module hinzufügen (in seinen Modulen Gruppen und Projekte hinzufügen. Da kann das aber auch der Modul-/Gruppenadmin)
      can :manage, :all
    end

    if user.role? :superuser #kann alles, überall
      can :administrate, :all
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
