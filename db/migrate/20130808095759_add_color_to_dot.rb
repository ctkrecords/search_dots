class AddColorToDot < ActiveRecord::Migration[6.1]
  def up
  	add_column :dots, :color, :string 
  end

  def down
  	remove_column :dots, :color
  end
end
