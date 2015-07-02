class AddDetailDescOnCompany < ActiveRecord::Migration
  def change
    add_column :companies, :detail_info_url, :string
    add_column :companies, :address, :string
  end
end
