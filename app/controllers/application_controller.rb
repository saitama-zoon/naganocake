class ApplicationController < ActionController::Base
#サインイン後の遷移先指定
protected
 def after_sign_in_path_for(resource)
	home_path

 end
 #サインアップ後の遷移先指定
 def after_sign_up_path_for(resource)
　　home_path
 end
 #ログアウト後の遷移先指定
 def after_sign_out_path_for(resource)
   home_path
 end

 before_action :configure_permitted_parameters, if: :devise_controller?

 protected

 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, :is_member])
 end
end
