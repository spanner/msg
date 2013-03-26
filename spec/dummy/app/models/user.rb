class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable# ,
         #          :confirmable
  receives_messages

  def for_email
    {
      :name => name,
      :email => email,
      :foo => "bar"
    }
  end
end