require "msg/receivers"
require "msg/engine"

module Msg
  mattr_accessor :user_class,
                 :layout,
                 :email_layout,
                 :default_from_address,
                 :default_from_name,
                 :email_bcc,
                 :email_values,
                 :messaging_groups,
                 :receiving_classes,
                 :sanitized_allowed_tags,
                 :sanitized_allowed_attributes,
                 :sending_domain,
                 :ses_access_key_id,
                 :ses_secret_access_key
  
  class MsgError < StandardError; end
  class EmailInvalid < MsgError; end
  
  class << self
    
    def setup
      yield self
    end

    def layout
      @@user_class ||= "User"
    end

    def layout
      @@layout ||= "msg/default"
    end

    def email_layout
      @@email_layout ||= "msg/email"
    end

    def default_from_address
      @@default_from_address ||= "please_configure_email_in_msg_initializer@example.com"
    end

    def default_from_name
      @@default_from_name ||= "Someone Unknown"
    end
    
    def default_from
      "#{default_from_name} <#{default_from_address}>"
    end

    def email_values
      @@email_values ||= {}
    end

    def messaging_groups
      @@group_scopes ||= {}
    end
    
    def add_group_scope(scope)
      group_scopes.push(scope)
    end

    def receiving_classes
      @@receiving_classes ||= []
    end
    
    def tags_allowed_in_email
      @@permitted_tags ||= ActionView::Base.sanitized_allowed_tags
    end
    
    def attributes_allowed_in_email
      @@permitted_attributes ||= ActionView::Base.sanitized_allowed_attributes
    end
    
    def sending_domain
      @@sending_domain ||= ActionMailer::Base.default_url_options[:host]
    end





    def add_receiving_class(klass, options)
      klass = klass.to_s
      receiving_classes << klass unless receiving_classes.include?(klass)
      messaging_groups[klass.underscore] = options[:groups] || []
    end

  end
end
