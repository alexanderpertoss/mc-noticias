class CreateCurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :currencies do |t|
      t.string :official_dolar_purchase
      t.string :official_dolar_sell
      t.string :blue_dollar

      t.timestamps
    end
  end
end
