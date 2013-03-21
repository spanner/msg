module Msg
  class EnvelopesController < Msg::EngineController
    respond_to :png
    skip_before_filter :authenticate_user!, :only => [:show]
    before_filter :get_envelope, :only => [:show]

    # envelopes#show is pinged when a message is opened.
    #
    def show
      @envelope.mark_as_read(Time.now)
      # return a png dot
      head :ok
    end
  
  protected
  
    def get_envelope
      @envelope = Msg::Envelope.find(params[:id])
    end
  
  end
end
