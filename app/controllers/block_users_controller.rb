class BlockUsersController < ApplicationController

  def index
    authorize! :index, BlockUser
    @users = current_user.block_users.decorate
  end

  def create
    authorize! :manage, BlockUser
    @block_user = current_user.block_relations.find_or_create_by!(block_user_params)
    redirect_back fallback_location: @block_user.blocked_user, notice: 'ブロックしました'
  end

  def destroy
    @block_user = current_user.block_relations.find_by!(block_user_params)
    authorize! :manage, @block_user

    visiting_user = @block_user.blocked_user
    @block_user.destroy!
    redirect_back fallback_location: visiting_user, notice: 'ブロックを解除しました'
  end

  private

    def block_user_params
      params.require(:block_user).permit(:blocked_user_id)
    end
end
