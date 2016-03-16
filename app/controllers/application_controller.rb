class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  $logger = Logger.new(STDOUT)

  def index
  end

  before_filter :authenticate_with_token

  # set user
  # return nil
  # redirect to index
  def authenticate_with_token
    # get the token from the header
    # get the token from the post body
    # get the token from json post
    
    token = request.headers["HTTP_AUTHORIZATION"]
    
    if (!token)
      if (not_protected self.controller_name, self.action_name)
        return nil
      end

      redirect_to controller: 'application', action: 'index' 
    end

    #@user = get_user_by_token(token)
  end

  # return false if a route is protected by tokens
  # return true if a route is not protected by tokens
  def not_protected (controller_name, action_name)
      if (!['users'].include? controller_name)
        return false
      end 

      if (!['create', 'new', 'index'].include? action_name)
        return false
      end

      return true
  end

end
