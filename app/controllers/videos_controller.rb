class VideosController < ApplicationController
  before_action :find_video!, only: %i(show edit)
  before_action :find_subject!, only: %i(create update edit new)
  before_action :authenticate_user!, only: %i(index show)
  before_action :authenticate_access, only: %i(show)
  before_action :is_admin?, only: %i(new edit create update)


  def index
    @videos = user_videos
  end

  def show
  end

  def new
    @video = Video.new 
    @send_to_url = subject_videos_path(@subject)
  end

  def create
    video = @subject.videos.build(video_params)
    if video.save
      redirect_to subject_video_path(@subject, video), alert: 'Video successfully created.'
    else
      redirect_to new_subject_video_path(@subject), alert: 'There was an error creating the video. Please check your entries and try again.'
    end
  end

  def edit
    @send_to_url = subject_video_path(@subject, @video)
  end

  def update
    raise params.inspect
  end

  private

  def video_params
    params.require(:video).permit(:title, :image, :description)
  end

  def user_videos
    current_user.videos
  end

  def find_subject!
    @subject = Subject.find(params[:subject_id])
  end

  def authenticate_access
    if !current_user.can_access_video(@video)
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  def is_admin?
    if !current_user.try(:teacher)
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  def find_video!
    @video = Video.find(params[:id])
  end
end
