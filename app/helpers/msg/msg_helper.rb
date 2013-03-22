module Msg
  module MsgHelper
    def shorten(text, length=64)
      length = length[:length] if length.is_a?(Hash)
      truncate(strip_tags(text), {:length => length, :separator => " "})
    end

    def action_menulink(thing, html_options={})
      classname = thing.class.to_s.downcase.underscore.split('/').last
      html_options.reverse_merge!({
        :class => "",
        :data => {:menu => "#{classname}_#{thing.id}"}
      })
      html_options[:class] << " menu"
      link_to t(:edit), "#", html_options if editable?(thing)
    end
    
    def action_menu(thing, locals={})
      if editable?(thing)
        type = thing.class.to_s.downcase.underscore
        classname = type.split('/').last
        locals[classname.to_sym] = thing
        render :partial => "#{type.pluralize}/action_menu", :locals => locals
      end
    end

    def visible?(thing)
      admin? || privileged? || current_user.can_see?(thing)
    end
    
    def editable?(thing)
      admin? || current_user == thing.created_by
    end

    def deletable?(thing)
      admin? || current_user == thing.created_by
    end

  end
end
