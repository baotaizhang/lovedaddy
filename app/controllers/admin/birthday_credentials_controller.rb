class Admin::BirthdayCredentialsController < Admin::ApplicationController
  before_action :set_birthday_credential, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  def index
    @birthday_credentials_waiting = BirthdayCredential.where(status: :waiting)
  end

  def edit
  end

  def update
    if params[:approved].eql?("true")
      @birthday_credential.update(status: :approved)
      UserMailer.birthday_credential_approved_email(@user).deliver_now!
      redirect_to action: :index
    elsif params[:rejected].eql?("true")
      @birthday_credential.update(status: :rejected)
      redirect_to action: :index
    end
  end

  private

    def set_birthday_credential
      @birthday_credential = BirthdayCredential.find(params[:id])
    end

    def set_user
      @user = @birthday_credential.user.decorate
    end

end
