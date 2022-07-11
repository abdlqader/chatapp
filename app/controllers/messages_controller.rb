class MessagesController < ApplicationController
    before_action :set_chat
    before_action :set_message_number, only: %i[ create ]
    # GET applications/1/chats/1/messages
    def index
        @messages = Message.where(chat_id: @chat.id)

        render json: @messages.as_json(:except => [:id, :chat_id])
    end

    # POST applications/1/chats/1/messages
    def create
        messageObject = {
          chat_id: @chat.id,
          message_number: @message_number,
          message: params[:content]
        }
        handler = PublishHandler.new
        handler.send_message($messageQueueName, messageObject)
        render :json =>{"number": @message_number}, status: :created
    end

    private
    #use chat_id between functions
    def set_chat
      application = Application.find_by_token(params[:application_id])
      @chat = Chat.where(application_id: application.id, number: params[:chat_id]).last
    end

    def set_message_number
      redis_key = "message_number_for_" + @chat.id.to_s
      redis_handler = RedisHandler.new
      @message_number = redis_handler.incr_key(redis_key)
    end
    #Only allow message paramter.
    def message_params
      params.require(:message).permit(:chat_id, :message)
    end
end
