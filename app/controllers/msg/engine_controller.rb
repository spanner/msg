module Msg
  class EngineController < ::ApplicationController
    
    before_filter :authenticate_user!
    before_filter :require_admin!
    layout :no_layout_if_pjax
    
  protected
    
    def require_admin!
      raise Msg::PermissionDenied unless current_user.admin?
    end
    
    def no_layout_if_pjax
      if request.headers['X-PJAX']
        false
      else
        Msg.layout
      end
    end
    
  end
end