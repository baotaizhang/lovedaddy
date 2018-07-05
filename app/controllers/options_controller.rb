class OptionsController < ApplicationController

  def index
    @current_option_ids = current_user.user_options.pluck(:option_id)
  end

  def create
    @current_option_ids = usable_option_ids

    UserOption.transaction do
      now_option_ids = current_user.options.pluck(:id)
      old_option_ids = now_option_ids - @current_option_ids 
      new_option_ids = @current_option_ids - now_option_ids

      current_user.user_options.where(option_id: old_option_ids).each(&:destroy!)

      new_option_ids.each do |option_id|
        user_option = current_user.user_options.build(option_id: option_id)
        authorize! :manage, user_option
        current_user.user_options.create!(option_id: option_id)
      end
    end

    flash[:notice] = '設定を更新しました'
    redirect_to action: :index
  rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordInvalid
    redirect_to action: :index, alert: '設定の更新に失敗しました'
  end

  private

    def usable_option_ids
      params[:option_ids] || []
    end
end
