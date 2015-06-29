class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :base_url
      t.text :content
      t.string :author
      t.integer :read_num
      t.string :article_type
      t.timestamps null: false
    end
  end
end
