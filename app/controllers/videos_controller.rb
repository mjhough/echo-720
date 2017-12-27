class VideosController < ApplicationController
  before_action :find_video!

  def index
    @videos = Video.all
  end

  def show
  end

  private

  def find_video!
    Video.find(params[:id])
  end

end
