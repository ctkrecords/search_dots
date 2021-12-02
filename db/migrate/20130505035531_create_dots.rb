class CreateDots < ActiveRecord::Migration[6.1]
  def change
    create_table :dots do |t|
      t.string :name
      t.text :description
      t.references :company
      t.boolean :is_required
      t.boolean :is_universal
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
  end
end
