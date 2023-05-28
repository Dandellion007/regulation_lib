class CreateReferences < ActiveRecord::Migration[7.0]
  def change
    create_table :references do |t|
      t.integer :attributes_id, null: false
      t.integer :referrer_doc_id, null: false
      t.integer :referral_doc_id, null: false

      t.timestamps
    end
  end
end
