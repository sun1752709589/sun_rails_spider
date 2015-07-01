class CreateScales < ActiveRecord::Migration
  def change
    create_table :scales do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
