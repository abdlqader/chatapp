class ApplicationsController < ApplicationController
    before_action :set_application, only: %i[ show update ]
    before_action :set_application_token, only: %i[ create ]
    # GET /applications
    def index
        @applications = Application.all.as_json(:except => :id)
        render json: @applications
    end
    # GET /applications/1
    def show
        render json: @application.as_json(:except => :id)
    end
    # POST /applications
    def create 
        puts @applicationToken
        @application = Application.new(token: @applicationToken, name: params[:name])
        if @application.save
            render json: @application.as_json(:except => :id), status: :created, location: @application
        else
            render json: @application.errors, status: :unprocessable_entity
        end
    end
    # PATCH /applications/1
    def update
        if @application.update(application_params)
            render json: @application.as_json(:except => :id)
        else 
            render json: @application.errors, status: :unprocessable_entity
        end
    end
    private
        #Get application by token to share functionality
        def set_application
            @application = Application.find_by_token(params[:id])
        end

        # Get Random token
        def set_application_token
            while true
                @applicationToken = rand(36**10).to_s(36)
                results = Application.where(token: @applicationToken)
                if results.length == 0
                    break
                end
            end
        end

        #Application params validation whiitelist
        def application_params
            params.require(:application).permit(:name)
        end
end
