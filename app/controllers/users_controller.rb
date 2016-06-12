class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    #@user.answer_quiz = [1,1,1]
    if params[:answer_quiz]
      @gv = @user.answer_quiz
      @gv.push params[:answer_quiz].to_i
      @user.answer_quiz = []
      @user.save!
      @user.answer_quiz = @gv
      @user.save!
    end
    if !@user.answer_quiz.to_a.empty?
      
      #redirect_to root_path
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:notice] = "Registrado com sucesso"
      render 'sessions/new'
      #log_in @user
  		#redirect_to @user
  	else
      flash[:error] = "Cadastro inválido"
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end


  
  private

   def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :answer_quiz)
   end

   

   def logged_in_user
      unless logged_in?
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end


