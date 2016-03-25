module ReceivesMessages
  extend ActiveSupport::Concern
  
  included do
    has_many :envelopes, as: :recipient
    has_many :messages, through: :envelopes
  end

  # Return hash of values for interpolation into email messages.
  #
  def for_email(values={})
    as_json.merge(values)
  end

end
