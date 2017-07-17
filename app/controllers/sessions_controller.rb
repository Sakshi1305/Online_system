class SessionsController < ApplicationController

  def new
    redirect_to root_url if current_user
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      if @user.admin? 
        redirect_to  new_admin_question_path
    

   else 
    
        redirect_to admin_questions_url
      #redirect_to :controller => "admin_questions", :action => "index", :id => @user.id
    # else
    #   # Create an error message.
    # flash.now[:danger] = 'Invalid email/password combination'
    # render 'new'
   end
  end
 end
 
  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end
end
