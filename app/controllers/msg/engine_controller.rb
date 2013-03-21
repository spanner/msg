module Msg
  class EngineController < ::ApplicationController
    helper Msg::MsgHelper
    before_filter :authenticate_user!
    
  protected
    
    def no_layout_if_pjax
      if request.headers['X-PJAX']
        false
      else
        Msg.layout
      end
    end
    
  end
end