class ChatsController < ApplicationController
    before_action :set_application
    before_action :set_chat_number, only: %i[ create ]

    # GET applications/1/chats
    def index
        @chats = Chat.where(application_id: @application).all.as_json(:except => [:id, :application_id])
        render json: @chats
    end

    # POST applications/1/chats
    def create
        chatObject = {
            application_id: @application.id,
            chat_number: @chat_number
        }
        handler = PublishHandler.new
        handler.send_message($chatQueueName, chatObject)
        render :json => {"number": @chat_number}, status: :created
    end
    
    private
        #use application_id between functions
        def set_application
            @application = Application.find_by_token(params[:application_id])
        end

        #chat number increment
        def set_chat_number
            redis_key = "chat_number_for_" + @application.id.to_s
            redis_handler = RedisHandler.new
            @chat_number = redis_handler.incr_key(redis_key)
        end
end
