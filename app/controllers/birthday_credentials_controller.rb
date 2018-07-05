class BirthdayCredentialsController < ApplicationController
  def index
  end

  def new
    @birthday_credential = BirthdayCredential.new
  end

  def create
    @birthday_credential = current_user.birthday_credentials.build(birthday_credential_params)
    @birthday_credential.status = :waiting

    if @birthday_credential.save
      BirthdayCredentialMailer.to_operator(current_user, @birthday_credential).deliver_now!
      redirect_to action: :thanks
    else
      render :new
    end
  end

  def thanks
  end

  private

    def birthday_credential_params
      params.require(:birthday_credential).permit(:photo_1, :photo_2, :photo_3)
    end
end
