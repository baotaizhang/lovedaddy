class ApplicationController < ActionController::Base
  include UserSessionsHelper

  protect_from_forgery with: :exception
  http_basic_authenticate_with name: 'lovedaddy?', password: 'lovedaddy!' if Rails.env.staging?
  before_action :require_login
  before_action :user_deleted?, if: :logged_in?
  before_action :user_initialized?, if: :logged_in?
  before_action :update_last_logged_in_at
  before_action :notification_count, if: :logged_in?

  def user_initialized?
    unless (request.fullpath == initial_edit_users_path || request.fullpath == initial_update_users_path) ||
        current_user.initialized? ||
        controller_name == 'homes'
      redirect_to initial_edit_users_url 
    end
  end

  private

    def user_deleted?
      redirect_to root_path, alert: 'このアカウントは退会処理済です' if current_user.deleted_at?
    end

    def not_authenticated
      redirect_to login_path, alert: 'ログインしてない場合、ご利用になれません。'
    end

    def update_last_logged_in_at
      current_user.update_column(:last_logged_in_at, Time.current) if logged_in?
    end

    def notification_count
      @unread_message_user_count = current_user.receive_each_user_latest_messages.without_block_users(current_user).where(opened_at: nil).size
    end
end
