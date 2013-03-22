module Msg
  class MessagesController < Msg::EngineController
    respond_to :html, :js

    before_filter :get_message, :only => [:show, :edit, :update, :destroy]
    before_filter :build_message, :only => [:new, :create]
    before_filter :get_transactional_messages, :only => [:index, :transactional]
    before_filter :get_saved_messages, :only => [:index, :saved]
    
    def index
      respond_with @saved_messages, @transactional_messages
    end

    def saved
      respond_with @saved_messages
    end

    def transactional
      respond_with @transactional_messages
    end

    def show
      respond_with @message
    end
    
    def preview
      respond_with @message
    end
    
    def new
      respond_with @message
    end
    
    def create
      @message.update_attributes(params[:message])
      respond_with @message
    end
    
    def edit
      respond_with @message
    end
    
    def update
      @message.update_attributes(params[:message])
      respond_with @message
    end
    
    def destroy
      @message.destroy
      head :ok
    end
    
  protected
  
    def build_message
      @message = Msg::Message.new(params[:message])
    end

    def get_message
      @message = Msg::Message.find(params[:id])
    end

    def get_transactional_messages
      @transactional_messages = Msg::Message.transactional
    end
    
    def get_saved_messages
      @show = params[:show] || 10
      @page = params[:page] || 1
      @saved_messages = Msg::Message.saved.page(@page).per(@show)
    end

  end
end
