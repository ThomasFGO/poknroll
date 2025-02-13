class CreateExpansions < ActiveRecord::Migration[7.1]
  def change
    create_table :expansions do |t|
      t.integer :rank
      t.string :code
      t.string :fr_name
      t.string :fr_release
      t.string :en_name
      t.string :us_release
      t.string :jap_name
      t.string :jap_release
      t.integer :classic_size
      t.integer :full_size
      t.string :category
      t.string :fr_logo_url
      t.string :en_logo_url
      t.string :symbol_url
      t.references :bloc, null: false, foreign_key: true

      t.timestamps
    end
  end
end
