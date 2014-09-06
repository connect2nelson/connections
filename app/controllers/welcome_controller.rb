class WelcomeController < ApplicationController

    def index
        @enabled_security = ENV["SECURITY_ENABLED"]
    end

    def about
        render "about"
    end
end
