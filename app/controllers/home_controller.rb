class HomeController < ApplicationController
    
    def about
    end

    def history
        @user = current_user
    end
end
