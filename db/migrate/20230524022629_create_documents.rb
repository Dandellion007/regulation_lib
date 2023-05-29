class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.boolean :archived, comment: 'Документ архивирован', default: false, null: false
      t.timestamps
    end
  end
end
