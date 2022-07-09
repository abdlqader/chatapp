class ChatsController < ApplicationController
    before_action :set_application
    before_action :set_chat_number, only: %i[ create ]

    # GET applications/1/chats
    def index
        @chats = Chat.where(application_id: @application_id).all.as_json(:except => [:id, :application_id])
        render json: @chats
    end

    # POST applications/1/chats
    def create
        @chat = Chat.new(application_id: @application_id.id, number: @chat_number)

        if @chat.save
            render json: @chat.as_json(:except => [:id, :application_id]), status: :created
        else
            render json: @chat.errors, status: :unprocessable_entity
        end
    end
    
    private
        #use application_id between functions
        def set_application
            @application_id = Application.find_by_token(params[:application_id])
        end

        #chat number increment
        def set_chat_number
            chat = Chat.where(application_id: @application_id.id).last
            if chat == nil
                @chat_number = 1
            else
                @chat_number = chat.number + 1
            end
        end
end
