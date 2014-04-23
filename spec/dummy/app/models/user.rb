class User < ActiveRecord::Base
  receives_messages({})

  def for_email
    {
      :name => name,
      :email => email,
      :foo => "bar"
    }
  end
end