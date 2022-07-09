class ApplicationController < ActionController::Base
    #for some reason CSRF cannot be verified
    skip_before_action :verify_authenticity_token
end
