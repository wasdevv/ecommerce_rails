class Admin::HomeController < AdminController
    before_action :authenticate_user!

    def index
    end

    def charts
    end

    def pages
    end
end