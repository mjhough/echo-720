class VideosController < ApplicationController
  before_action :find_video!, only: %i(show edit update)
  before_action :find_subject!, only: %i(create new show edit)
  before_action :authenticate_user!
  before_action :authenticate_access, only: %i(show edit)
  before_action :is_admin?, only: %i(new edit create update)


  def index
    @videos = user_videos
  end

  def show
  end

  def new
    @video = Video.new 
    @send_to_url = subject_videos_url(@subject)
  end

  def create
    @video = @subject.videos.build(video_params)
    if @video.save
      redirect_to subject_video_path(@subject, @video), alert: 'Video successfully created.'
    else
      @send_to_url = subject_videos_url(@subject)
      render :new,  alert: 'There was an error creating the video. Please check your entries and try again.'
    end
  end

  def edit
    @send_to_url = subject_video_url(@video.subject, @video)
  end

  def update
    if @video.update(video_params)
      redirect_to subject_video_path(@video.subject, @video), alert: "Successfully updated #{@video.title}."
    else
      redirect_to edit_subject_video_path(@video.subject, @video), alert: 'There was an issue updating the video. Please check that the information you entered is correct.'
    end
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
    if !current_user.can_access_video(@video, @subject)
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
