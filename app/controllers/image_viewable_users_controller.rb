class ImageViewableUsersController < ApplicationController

  def index
    @users = current_user.image_viewable_users.includes(:user_options).decorate
  end

  def create
    @image_viewable_relation = current_user.image_viewable_relations.find_or_create_by!(image_viewable_user_params)
    redirect_back fallback_location: @image_viewable_relation.viewing_user, notice: 'プロフィール画像の閲覧を許可しました'
  end

  def destroy
    @image_viewable_relation = current_user.image_viewable_relations.find_by!(image_viewable_user_params)
    viewing_user = @image_viewable_relation.viewing_user
    @image_viewable_relation.destroy!
    redirect_back fallback_location: viewing_user, notice: 'プロフィール画像の閲覧許可を取り消しました'
  end

  private

    def image_viewable_user_params
      params.require(:image_viewable_user).permit(:viewing_user_id)
    end
end
