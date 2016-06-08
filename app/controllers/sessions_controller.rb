class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.uid == nil
        log_in user
        redirect_to user
      else
        flash[:error] = "Login não foi efetuado com sucesso."
        render'new'
        flash[:error] = nil
      end
    else
      flash[:error] = "Login não foi efetuado com sucesso."
      render 'new'
      flash[:error] = nil
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def create_face
  begin
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user
      session[:user_id] = @user.id
    end
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
