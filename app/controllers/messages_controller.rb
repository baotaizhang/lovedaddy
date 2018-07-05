class MessagesController < ApplicationController
  before_action :set_to_user_and_messages, only: :show
  before_action :set_load_messages, only: :load

  def index
    authorize! :index, Message
    @messages = current_user.
      each_user_latest_messages.
      without_block_users(current_user).
      includes(to_user: [:user_options], from_user: [:user_options]).order('created_at DESC').decorate
  end

  def show
    authorize! :show, @messages.last || Message

    @message = Message.new
    @last_read_id = current_user.send_messages_with(@to_user).where.not(opened_at: nil).last&.id
    @unread_message_user_count -= 1 if current_user.message_open_with!(@to_user)
    render layout: 'unique_page'
  end

  # 送られてくるidから表示を更新するJSを返却する
  def load
    authorize! :show, @messages.last || Message

    @last_read_id = current_user.send_messages_with(@to_user).where.not(opened_at: nil).last&.id

    current_user.message_open_with!(@to_user)
    render layout: false
  end

  private

    def set_to_user_and_messages
      @to_user = User.find_by!(url_token: params[:url_token]).decorate
      redirect_to root_path and return if current_user?(@to_user)

      @messages = current_user.messages_with(@to_user).includes(:from_user, :to_user).decorate
    end

    def set_load_messages
      last_message_id = params[:last_message_id]
      @to_user = User.find_by(id: params[:to_user_id])
      raise '不正なメッセージです' unless last_message_id && @to_user

      @messages = current_user
        .messages_with(@to_user)
        .where('id > ?', last_message_id).decorate
    end
end
