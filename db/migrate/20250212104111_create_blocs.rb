class CreateBlocs < ActiveRecord::Migration[7.1]
  def change
    create_table :blocs do |t|
      t.integer :rank
      t.string :code
      t.string :fr_name
      t.string :en_name
      t.string :jap_name
      t.boolean :jap

      t.timestamps
    end
  end
end
