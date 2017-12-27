class SubjectsController < ApplicationController
  before_action :find_subject!

  def index
    @subjects = Subject.all
  end

  def show
  end

  private

  def find_subject!
    Subject.find(params[:id])
  end
end
