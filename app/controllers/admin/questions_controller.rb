class Admin::QuestionsController < ApplicationController
  before_action :admin_user, only: [:new, :edit]
  def new
	  @question = Question.new
  end
    
  def index 
    #binding.pry
    @exams = Exam.all
  end

  def edit
  	#binding.pry
	  @question = Question.find(params[:id])
  end

  def edit_question
	  @question = Question.find(params[:id])
  end
  
  def create
  	#binding.pry
    @question = Question.new(question_params)
    if @question.save
      redirect_to exams_path
    else
      render 'new'
    end
  end

  def update
  	#binding.pry
    @question = Question.find(params[:id])
    if @question.update(params[:question].permit(:question, :option1, :option2, :option3, :option4, :answer, :exam_id))
    flash[:success] = "Question Updated"  
      redirect_to @question.exam
    else 
      render 'edit'
    end
  end
 
 
  def show
  	#binding.pry
    #@exam_questions = Question.all
    @exam_questions = Question.where("exam_id = ?", params[:id])
    @exam_id = params[:id]
  end

  def result
    mark = 0
    #binding.pry
    params[:question].each do |key, value|
         #binding.pry
      if(key == "exam_id")
         @exam_id = value
      else
         k = key.to_i
         @question = Question.find(k)
          if(@question.answer == value)
            mark += 1
          end
      end
    end

    #exam_id = params[:question][:exam_id]
    @result = Result.create(mark: mark, user_id: current_user.id, exam_id: @exam_id )
    if @result.save
      redirect_to root_path
    else
      redirect_to admin_questions_path
    end 
  end 

  private
  
  def question_params
    params.require(:question).permit(:question, :option1, :option2,
                                   :option3, :option4, :answer, :exam_id)
  end
  
  def admin_user
    redirect_to (root_url) unless current_user.admin?
  end
end