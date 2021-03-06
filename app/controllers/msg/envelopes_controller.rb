module Msg
  class EnvelopesController < Msg::EngineController
    respond_to :png
    skip_before_filter :authenticate_user!, :only => [:show]
    skip_before_filter :require_admin!, :only => [:show]
    before_filter :get_envelope, :only => [:show]

    # envelopes#show is pinged when a message is opened.
    #
    def show
      @envelope.open!
      redirect_to view_context.image_path('msg/ping.png')
    end
  
  protected
  
    def get_envelope
      @envelope = Msg::Envelope.find(params[:id])
    end
  
  end
end
