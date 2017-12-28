class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  has_many :videos, through: :subjects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true

  def students
    where(teacher: false)
  end

  def teacher?
    !!teacher
  end

  def can_access_video(video, subject)
    videos.include?(video) && subjects.include?(subject)
  end

  def can_access_subject(subject)
    subjects.include?(subject)
  end
end




