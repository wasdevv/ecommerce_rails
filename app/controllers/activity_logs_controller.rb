class ActivityLogsController < ApplicationController
    before_action :authenticate_user!

    def index
        @activity_logs = ActivityLog.all
    end
    
    def destroy
        activity_log = ActivityLog.find(params[:id])
        if current_user.admin?
            activity_log.destroy
        end
    end

    def show
        @activity_log = ActivityLog.find(params[:id])

        @product = @activity_log.product
        render 'products/show'
    end
end
