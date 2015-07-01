class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :industry_id
      t.integer :nature_id
      t.integer :scale_id
      t.text :detail_introduce
      t.string :website
      t.string :zip_code
      t.timestamps null: false
    end
  end
end
