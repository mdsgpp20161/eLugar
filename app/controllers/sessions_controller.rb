class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  # def create_face
  #   auth = request.env["omniauth.auth"]
  #   session[:omniauth] = auth.except('extra')
  #   user = User.sign_in_from_omniauth(auth)
  #   if user
  #     session[:user_id] = user.id
  #     redirect_to root_url, notice: "LOGADO"
  #   else
  #     render 'new'
  #   end
  # end

  def create_face
  begin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
  end
  redirect_to root_path
end

  def destroy_face
    if current_user
      session.delete(:user_id)
      redirect_to root_path, notice: "SIGNED OUT"
    end
      
  end

end
