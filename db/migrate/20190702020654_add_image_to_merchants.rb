class AddImageToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :image, :string
  end
end
