require 'jwt'
require 'active_support'

class Tokens
    #@logger = Logger.new(STDOUT)

  def expires_in (number_of_days)
    date = Time.now + (number_of_days * 24 * 60 * 60)
    date.to_i
  end

  #
  # didn't use secure compare
  # ActiveSupport::SecurityUtils.secure_compare(token, token)
  #
  # return a new token
  def generate_token (id, number_of_days)
    JWT.encode({ :user_id => id, :expires => expires_in(number_of_days) }, 'somesecrethere')
  end

  # return user if all goes well
  # return nil if there is no user with id
  # return nil if token is expired
  def get_user_by_token(token)
    decoded = JWT.decode(token, 'somesecrethere')
    now = Time.now().to_i

    if (decoded[0][:expires] < now)
      return nil
    end

    user = User.find_by uuid: decoded[0][:user_id]
    if (!user)
      return nil
    end

    return user
  end
end
