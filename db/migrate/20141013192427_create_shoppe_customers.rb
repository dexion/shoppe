class CreateShoppeCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :shoppe_customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :phone

      t.timestamps
    end
  end
end
