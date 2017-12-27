class CreateUserSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_subjects do |t|
      t.belongs_to :user
      t.belongs_to :subject
    end
  end
end