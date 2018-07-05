class IncomeCredentialsController < ApplicationController
  def new
    @income_credential = IncomeCredential.new
  end

  def create
    @income_credential = current_user.income_credentials.build(income_credential_params)
    @income_credential.status = :waiting

    if @income_credential.save
      IncomeCredentialMailer.to_operator(current_user, @income_credential).deliver_now!
      redirect_to action: :thanks
    else
      render :new
    end
  end

  def thanks
  end

  private

    def income_credential_params
      params.require(:income_credential).permit(:photo_1, :photo_2, :photo_3)
    end
end
