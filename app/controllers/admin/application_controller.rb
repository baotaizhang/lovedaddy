class Admin::ApplicationController < ActionController::Base
  layout 'admin/layouts/application'

  protect_from_forgery with: :exception
  http_basic_authenticate_with name: 'lovedaddy?', password: 'lovedaddy!' unless Rails.env.development?
  before_action :require_login
  before_action :require_admin

  private

    def not_authenticated
      redirect_to login_path, alert: "ログインしてない場合、ご利用になれません。"
    end

    def require_admin
      redirect_to root_path unless current_user.role.admin?
    end
end
