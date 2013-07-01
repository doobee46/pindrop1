class AddImpressionsCountToPins < ActiveRecord::Migration
  def change
    add_column :pins, :impressions_count, :integer
  end
end
