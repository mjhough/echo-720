class VideosController < ApplicationController
  before_action :find_video!, only: %i(show)
  before_action :authenticate_user!, only: %i(index show)
  before_action :authenticate_access, only: %i(show)
  before_action :is_admin?, only: %i(new edit create update)

  def index
    @videos = user_videos
  end

  def show
  end

  private

  def user_videos
    current_user.videos
  end

  def find_video!
    Video.find(params[:id])
  end

  def authenticate_access
    if !current_user.can_access_video(@video)
      redirect_to root_path, alert: 'Access Denied'
    end
  end
end
