module Msg
  class SendingsController < Msg::EngineController
    respond_to :html, :js

    before_filter :get_message, :only => [:new, :create]
    before_filter :get_sending, :only => [:show, :review]
    before_filter :build_sending, :only => [:new, :create]
    before_filter :get_sendings, :only => [:index]

    def index
      respond_with @sendings do |format|
        format.js { render :partial => "report"}
      end
    end

    def show
      respond_with @sending
    end
    
    def review
      respond_with @sending, :layout => Msg.email_layout
    end

    def new
      respond_with @sending
    end

    def create
      @sending.update_attributes(sending_params)
      respond_with @sending
    end

    def destroy
      @sending.destroy
      head :ok
    end

  protected

    def get_message
      @message = Msg::Message.find(params[:message_id])
    end

    def build_sending
      @sending = @message.sendings.build
    end

    def get_sending
      @sending = Msg::Sending.find(params[:id])
    end

    def get_sendings
      @show = params[:show] || 10
      @page = params[:page] || 1
      @sendings = Msg::Sending.order("created_at DESC").page(@page).per(@show)
    end
    
    def sending_params
      parameter_names = [:message_id, :envelopes_attributes] + Msg.receiving_classes.map{|klass| "#{klass.underscore}_group"}
      Rails.logger.warn "permitted parameter_names: #{parameter_names.inspect}"
      params.require(:sending).permit(*parameter_names)
    end
    
  end
end
