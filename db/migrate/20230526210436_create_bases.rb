class CreateBases < ActiveRecord::Migration[7.0]
  def change
    create_table :bases do |t|
      t.string :name
      t.integer :document_id

      t.timestamps
    end
  end
end
