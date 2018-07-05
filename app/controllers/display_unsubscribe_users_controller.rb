class DisplayUnsubscribeUsersController < ApplicationController

  def index
    @users = current_user.message_users.includes(:user_options).order(created_at: :desc).decorate
  end

  def create
    authorize! :manage, DisplayUnsubscribeUser
    @display_unsubscribe = current_user.display_unsubscribe_relations.find_or_create_by!(display_unsubscribe_user_params)
    redirect_back fallback_location: @display_unsubscribe.to_user, notice: '特定非表示設定をしました'
  end

  def destroy
    @display_unsubscribe = current_user.display_unsubscribe_relations.find_by!(display_unsubscribe_user_params)
    authorize! :manage, @display_unsubscribe

    target_user = @display_unsubscribe.to_user
    @display_unsubscribe.destroy!
    redirect_back fallback_location: target_user, notice: '特定非表示設定を解除しました'
  end

  private

    def display_unsubscribe_user_params
      params.require(:display_unsubscribe_user).permit(:to_user_id)
    end
end
