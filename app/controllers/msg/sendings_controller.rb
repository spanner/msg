module Msg
  class SendingsController < Msg::EngineController
    respond_to :html, :js

    before_filter :get_sending, :only => [:show]
    before_filter :build_sending, :only => [:new, :create]
    before_filter :get_sendings, :only => [:index]

    def index
      respond_with @sendings
    end

    def show
      respond_with @sending
    end

    def new
      respond_with @sending
    end

    def create
      @sending.update_attributes(params[:sending])
      respond_with @sending
    end

    def destroy
      @sending.destroy
      head :ok
    end

  protected

    def build_sending
      @sending = Msg::Sending.new(params[:sending])
    end

    def get_sending
      @sending = Msg::Sending.find(params[:id])
    end

    def get_sendings
      @show = params[:show] || 10
      @page = params[:page] || 1
      @sendings = Msg::Sending.page(@page).per(@show)
    end
  end
end
