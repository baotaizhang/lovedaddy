class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if User.find_by(email: params[:email])&.deleted_at.nil? && @user = login(params[:email], params[:password], params[:remember])
      redirect_back_or_to(:users)
    else
      user = User.find_by(email: params[:email])
      msg = user&.login_locked? ? '一定回数ログインに失敗しましたので、アカウントがロックされました。しばらく経ってから再度お試しください。' : 'ログインに失敗しました'
      flash.now[:alert] = msg
      render action: 'new'
    end
  end

  def forgot
  end

  def destroy
    logout
    redirect_to(:users, notice: 'ログアウトしました')
  end
end
