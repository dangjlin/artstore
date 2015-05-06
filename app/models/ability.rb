class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?  
      # not logged in 如果user沒登入
      cannot :manage, :all  ＃設置無法管理任何資源
      basic_read_only ＃呼叫基本權限設定 Medthod 
    elsif user.has_role?(:admin) 如果role 為 admin
      # admin
      can :manage, :all #管理所有資源
    elsif user.has_role?(:manager) 如果role 為 manager
      can :read, Product  ＃只能讀取 Product controller 中的 show 與 index action
    end
    
     protected

      def basic_read_only
        can :read,    Product
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
