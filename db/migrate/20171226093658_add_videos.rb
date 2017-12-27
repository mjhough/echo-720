class AddVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.belongs_to :subject
      t.string :image
      t.timestamps null: false
    end
  end
end
