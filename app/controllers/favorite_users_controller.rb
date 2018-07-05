class FavoriteUsersController < ApplicationController

  def index
    reverse_favorite_users = current_user.reverse_favorite_users
    favorite_users = current_user.favorite_users
    @users = (params[:others].present? ? reverse_favorite_users : favorite_users).order('favorite_users.created_at DESC').decorate
    @reverse_favorite_users_count = reverse_favorite_users.count
    @favorite_users_count = favorite_users.count
  end

  def create
    @favorite_user = current_user.favorite_relations.find_or_create_by!(favorite_user_params)
    redirect_back fallback_location: @favorite_user.to_user, notice: 'お気に入りに登録しました'
  end

  def destroy
    @favorite_user = current_user.favorite_relations.find_by!(favorite_user_params)
    visiting_user = @favorite_user.to_user
    @favorite_user.destroy!
    redirect_back fallback_location: visiting_user, notice: 'お気に入りから削除しました'
  end

  private

    def favorite_user_params
      params.require(:favorite_user).permit(:to_user_id)
    end
end
