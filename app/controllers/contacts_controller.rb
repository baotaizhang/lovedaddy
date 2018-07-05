class ContactsController < ApplicationController
  skip_before_action :require_login

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.to_operator(@contact).deliver_now!
      ContactMailer.to_user(@contact).deliver_now!
      redirect_to action: :thanks
    else
      render :new
    end
  end

  def thanks
  end

  private

    def contact_params
      params.require(:contact).permit(:title, :email, :content)
    end
end
