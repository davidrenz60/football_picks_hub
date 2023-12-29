class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def dashboard_layout
        return "turbo_rails/frame" if turbo_frame_request?

        "dashboard"
    end
end