class AddColummsPrivateToPins < ActiveRecord::Migration
  def change
    add_column :pins, :private, :boolean
  end
end
