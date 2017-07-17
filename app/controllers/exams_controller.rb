class ExamsController < ApplicationController
	before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :index, :edit, :show]
  def new
  	@exam = Exam.new
  end

  def index
  	@exams = Exam.all
  end

  def create
  	@exam = Exam.new(exam_params)
    if @exam.save
      redirect_to exams_path
    else
      render 'new'
    end
  end

  def edit
  	#binding.pry
  	@exam = Exam.find(params[:id])
  end

  def show
	#@exams = Exam.all
  #binding.pry
	  @exam_questions = Question.where("exam_id = ?", params[:id])
    @exam_id = params[:exam]
    @user_id = params[:id]
  end

  def update
    @exam = Exam.find(params[:id])
    if @exam.update(params[:exam].permit(:title))
      redirect_to @exam
    else 
      render 'edit'
    end
  end

  def destroy
 	  @exam = Exam.find(params[:id])
    @exam.destroy
    redirect_to exams_path
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:title)
  end

  def admin_user
    redirect_to (root_url) unless current_user.admin?
  end
end

