class MessagesController < ApplicationController
  before_action :authenticate_user!

  before_action do
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.find(params[:conversation_id])
    else
      @conversation = Conversation.new(message_params)
    end
  end

  def index
    @messages = @conversation.messages

    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)

    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.permit(:body, :user_id)
    end
end