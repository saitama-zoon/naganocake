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

end