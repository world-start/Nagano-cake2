class ApplicationController < ActionController::Base
  #applicationControllerを継承するコントローラー内のすべてのアクションが実行される前に、before_actionが実行される。
  #configure_permitted_parametersはストロングパラメーターを反映させる
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin #Adminモデル
      admin_root_path #遷移先のパス
    when Customer
      root_path              
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    # case resource
    if resource_or_scope == :admin
    # when Admin #Adminモデル
      new_admin_session_path #遷移先のパス
    # when Customer
    else
      root_path              
    end
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
