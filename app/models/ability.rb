class Ability
  include CanCan::Ability
  prepend Draper::CanCanCan

  # TODO: 拡張可能な権限のリファクタリング
  def initialize(user)
    if user.blank?
      ##### 未ログインユーザー #####

    elsif user.deleted_at?
      ##### 論理削除済ユーザー #####

    elsif user.role.general?
      ##### 一般ユーザー #####
      can :index, Message
      can :index, BoardPost
      can :show, BoardPost do |board_post|
        !board_post.user.display_deleted?(user)
      end
      can :index, BlockUser

      if user.sex.male?
        ### 男性会員全員 ###
        can :index, DisplayUnsubscribeUser

        # 見えるけれど設定出来ないオプション
        can :show, UserOption do |user_option|
          [:hide_online, :hide_visit_history].include?(user_option.option.code)
        end
      end

      if user.birthday_credentials.with_status(:approved).present?
        ### 年齢（本人）確認済 ###
        can :create, UserReport

        can :manage, BlockUser do |block_user|
          user == block_user.set_user
        end

        can :create, Message
        can :show, Message do |message|
          !message.partner_user(user).display_deleted?(user) && (user == message.from_user || user == message.to_user)
        end
        can :manage, Message do |message|
          user == message.from_user
        end

        can :create, BoardPost
        can :manage, BoardPost do |board_post|
          user == board_post.user
        end

        if user.sex.male?
          ## 男性で本人確認済 ##
          can :manage, DisplayUnsubscribeUser do |display_unsubscribe|
            user == display_unsubscribe.from_user
          end

        end
      end

      # オプション
      can :show, Option do |option|
        option.showable?(user)
      end

      can :manage, Option do |option|
        option.usable?(user)
      end

      can :manage, UserOption do |user_option|
        can? :show, user_option.option
      end

      can :manage, UserOption do |user_option|
        can? :manage, user_option.option
      end
    elsif user.role.admin?
      ##### 管理者 #####
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
