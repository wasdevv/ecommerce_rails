class ActivityLogsController < ApplicationController
    before_action :authenticate_user!

    def index
        @activity_logs = ActivityLog.all
    end
end
