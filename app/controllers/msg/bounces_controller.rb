module Msg
  class BouncesController < Msg::EngineController
    respond_to :json
    
    # this is going to be called from a separate mail-receiving process
    #
    def create
      @bounce.update_attributes(params[:bounce])
      respond_with @bounce
    end
    
  protected
  
    def build_bounce
      @bounce = Msg::Bounce.new(params[:bounce])
    end
  
  end
end
