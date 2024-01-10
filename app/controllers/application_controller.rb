class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def dashboard_layout
        return "turbo_rails/frame" if turbo_frame_request?

        "dashboard"
    end

    def require_admin
        redirect_to :root_path, alert: "Not authorized to view that page" unless current_user&.admin?
    end
end