class AddActivationCodeToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :activation_code, :integer
  end
end
