class Admin::IncomeCredentialsController < Admin::ApplicationController
  before_action :set_income_credential, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  def index
    @income_credentials_waiting = IncomeCredential.where(status: :waiting)
  end

  def edit
  end

  def update
    if params[:approved].eql?("true")
      @income_credential.update(status: :approved)
      UserMailer.income_credential_approved_email(@user).deliver_now!
      redirect_to action: :index
    elsif params[:rejected].eql?("true")
      @income_credential.update(status: :rejected)
      redirect_to action: :index
    end
  end

  private

    def set_income_credential
      @income_credential = IncomeCredential.find(params[:id])
    end

    def set_user
      @user = @income_credential.user.decorate
    end

end
