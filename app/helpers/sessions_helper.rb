module SessionsHelper
  def log_in(user)
    if user.uid == nil
      session[:user_id] = user.id
      current_user = user
      @current_user = user
    else
      #session[:user_id] = user.id
    end
  end

  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    current_user = nil
  end
end
