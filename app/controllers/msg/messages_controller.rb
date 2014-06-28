module Msg
  class MessagesController < Msg::EngineController
    respond_to :html, :js

    before_filter :get_message, :only => [:show, :edit, :update, :destroy, :preview]
    before_filter :build_message, :only => [:new, :create]
    before_filter :get_transactional_messages, :only => [:index, :transactional]
    before_filter :get_saved_messages, :only => [:index, :saved]
    before_filter :get_receiver, :only => [:show, :preview]
    
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
      respond_with @message do |format|
        format.js { render :partial => "msg/messages/message" }
      end
    end

    def preview
      respond_with @message, :layout => Msg.email_layout
    end

    def new
      respond_with @message
    end

    def create
      @message.update_attributes(message_params)
      respond_with @message
    end

    def edit
      respond_with @message
    end

    def update
      @message.update_attributes(message_params)
      respond_with @message
    end

    def destroy
      @message.destroy
      head :ok
    end

  protected

    def build_message
      @message = Msg::Message.new
    end

    def get_message
      @message = Msg::Message.find(params[:id])
    end

    def get_transactional_messages
      @transactional_messages = Msg::Message.transactional
    end
    
    def message_params
      params.require(:message).permit(:subject, :body, :function, :description, :transactional, :saved, :from_name, :from_address)
    end

    def get_saved_messages
      @show = params[:show] || 10
      @page = params[:page] || 1
      @saved_messages = Msg::Message.saved.page(@page).per(@show)
    end
    
    def get_receiver
      klass = params[:receiver_type] || Msg.receiving_classes.first
      if id = params[:receiver_id]
        @receiver = klass.classify.constantize.find(id)
      else
        @receiver = klass.classify.constantize.first
      end
      
      Rails.logger.warn ">>> preview receiver will be #{@receiver.inspect}"
      
      raise ActiveRecord::RecordNotFound, "Cannot find a valid receiver for whom to preview message." unless @receiver
    end

  end
end
