class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @profile_quiz = ProfileQuiz.new
    if @user.profileQuiz_id == nil 
      if params[:uber] && params[:demographic_density] && params[:area] && params[:population]
            @profile_quiz.uber = params[:uber].to_i
            @profile_quiz.demographic_density = params[:demographic_density].to_i
            @profile_quiz.area = params[:area].to_i
            @profile_quiz.population = params[:population].to_i
            @profile_quiz.users_id = params[:id].to_i    
            @profile_quiz.save!
      else
        flash[:error] = "Precisa responder todos os campos!"
        render 'show'
        flash[:error] = nil
      end
      @user.profileQuiz_id = @profile_quiz.id
      @user.save!
    else
      #do nothing
    end

    @user = User.find(params[:id])	
 end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Registrado com sucesso"
      render 'sessions/new'
      flash[:notice] = nil
      #log_in @user
  		#redirect_to @user
    else
      flash[:error] = "Cadastro inválido"
      render 'new'
      flash[:error] = nil
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


