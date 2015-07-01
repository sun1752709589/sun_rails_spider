class CreateNatures < ActiveRecord::Migration
  def change
    create_table :natures do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
