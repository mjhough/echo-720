class SubjectsController < ApplicationController
  before_action :find_subject!, only: %i(show)

  def index
    @subjects = user_subjects
  end

  def show
  end

  def user_subjects
    # Subject.joins(:user_subjects).where(user_subjects: {user: User.last})
    current_user.subjects
  end

  private

  def find_subject!
    @subject =  Subject.find(params[:id])
  end
end
