class ApplicationController < ActionController::Base
    include Pagy::Backend

    # ログアウト後のリダイレクト先を設定
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, alert: "権限がありません。"
    end
end
