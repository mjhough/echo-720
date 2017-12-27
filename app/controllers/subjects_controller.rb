class SubjectsController < ApplicationController
  before_action :find_subject!, only: %i(show edit)

  def index
    @subjects = user_subjects
  end

  def show
  end

  def user_subjects
    # Subject.joins(:user_subjects).where(user_subjects: {user: User.last})
    current_user.subjects
  end

  def new
    @subject = Subject.new
    render partial: 'form', locals: { subject: @subject }
  end

  def create
    raise params.inspect
  end

  def edit

  end

  def update

  end

  private

  def find_subject!
    @subject =  Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:title, users: [:email])
  end

end
