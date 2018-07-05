class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.logical_destroy!
    redirect_back fallback_location: admin_dashboards_url, notice: '退会させました'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
