class SessionsController < ApplicationController

  def new
    redirect_to root_url if current_user
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.email_confirmed && @user.admin?
        log_in @user
        redirect_to new_admin_question_path
      elsif @user.email_confirmed && !@user.admin?
        log_in @user
        redirect_to admin_questions_url
      else
        flash.now[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
      # if @user.email_confirmed
      #   log_in @user
      #   redirect_to admin_questions_url
      # else
      #   flash.now[:error] = 'Please activate your account by following the
      #   instructions in the account confirmation email you received to proceed'
      #   render 'new'
      # end
      #redirect_to :controller => "admin_questions", :action => "index", :id => @user.id
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end
end
