class Api::MessagesController < ApplicationController
  def create
    authorize! :create, Message
    message = current_user.send_messages.create!(message_params)

    NotificationMailer.receive_message(message).deliver_now if message.notifiable?
    head :ok
  end

  def destroy
    message = current_user.send_messages.find(params[:id])
    authorize! :destroy, message

    message.destroy!
    head :ok
  end

  private

    def message_params
      params.require(:message).permit(:content, :to_user_id, :image_camera, :image_attachment)
    end
end
