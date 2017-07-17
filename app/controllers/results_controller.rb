class ResultsController < ApplicationController
  def new
  	result = Result.new
  end

  def index
  	results = Result.all
  end

  def show
  #binding.pry
   @list_of_user = Result.where("exam_id = ?", params[:format])
   redirect_to root_url unless current_user.admin?
  end
end
