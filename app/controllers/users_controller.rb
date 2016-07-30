class UsersController < ApplicationController
before_action :logged_in_user , only: [:edit, :update]
before_action :correct_user, only: [:edit, :update]

def index 
  @users =User.all 
end 

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params) #not the final implimentation 
    if @user.save 	
      log_in @user

      flash[:success] = "Welcome  #{@user.name.upcase}  , You are 50% away from having your Address!  Please continue by filling the form 
      "      #handles a successful save
	redirect_to new_location_path
else
  render 'new'
end
end

def edit
  @user =User.find(params[:id])
end 

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success]= "Profile Updated"
    redirect_to @user 
    #handle a successful update 
  else
    render 'edit' 
  end 
end 
private
	def user_params
      params.require(:user).permit(:name ,:email , :password , :password_confirmation)
	
    end
    #before filters 
    #confirm a logge-in user 
    def logged_in_user 
      unless logged_in?
        store_location 
        flash[:danger]= "Please log in."
        redirect_to login_url 
    end 
    end 
    #confirms the correct user
     def correct_user 
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user) 
     end 
end 

