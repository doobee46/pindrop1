class AddCountToPins < ActiveRecord::Migration
  def change
    add_column :pins, :count, :integer
  end
end
