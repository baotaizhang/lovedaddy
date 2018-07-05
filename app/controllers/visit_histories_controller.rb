class VisitHistoriesController < ApplicationController
  before_action :set_from_user_histories, only: [:destroy]

  def index
    @came_users = current_user.came_users.includes(:user_options).order('visit_histories.created_at DESC').group('visit_histories.from_user_id').decorate
  end

  def destroy
    @visit_histories.destroy_all
    redirect_to visit_histories_url, notice: '訪問履歴を削除しました'
  end

  private

    def set_from_user_histories
      @visit_histories = current_user.came_histories.where(from_user_id: params[:from_user_id])
    end
end
