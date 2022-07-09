class AddNumberToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :number, :integer, null: false
  end
end
