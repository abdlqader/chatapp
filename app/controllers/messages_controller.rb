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
        @message = Message.new(message: params[:message], chat_id: @chat.id, number: @message_number)

        if @message.save
            render json: @message.as_json(:except => [:id, :chat_id]), status: :created
        else
            render json: @message.errors, status: :unprocessable_entity
        end
    end

    private
    #use chat_id between functions
    def set_chat
      application = Application.find_by_token(params[:application_id])
      @chat = Chat.where(application_id: application.id, number: params[:chat_id]).last
    end

    def set_message_number
      message = Message.where(chat_id: @chat.id).last
      if message == nil
        @message_number = 1
      else
        @message_number = message.number + 1
      end
    end
    #Only allow message paramter.
    def message_params
      params.require(:message).permit(:chat_id, :message)
    end
end
