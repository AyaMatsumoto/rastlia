class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.string :video_url, :null => false
      t.string :channel_url
      t.string :password, :null => false
      t.text :content

      t.timestamps
    end
  end
end
