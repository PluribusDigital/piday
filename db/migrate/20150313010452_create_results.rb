class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :iterations
      t.integer :hits
      t.string :source

      t.timestamps null: false
    end
  end
end
