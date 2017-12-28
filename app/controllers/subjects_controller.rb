class SubjectsController < ApplicationController
  before_action :find_subject!, only: %i(show edit update)

  def index
    @subjects = user_subjects
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def create
    unless subject = Subject.find_by(title: subject_params[:title])
      subject = Subject.new(subject_params)
      subject.users << current_user
      if subject.save
        redirect_to root_path, notice: "#{subject.title} successfully created."
      else
        redirect_to new_subject_path, alert: 'There was an issue. Please check that you entered the correct information and try again.'
      end
    else
      redirect_to edit_subject_path(subject), alert: 'Subject already exists. Please edit the subject instead.' 
    end
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      redirect_to subjects_path, notice: 'Successfully updated subject.'
    else
      redirect_to edit_subject_path, alert: 'There was an issue. Please check that you entered the correct information and try again.'
    end
  end

  def user_subjects
    # Subject.joins(:user_subjects).where(user_subjects: {user: User.last})
    current_user.subjects
  end
  
  private

  def find_subject!
    @subject =  Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:title, :user_emails)
  end
end
