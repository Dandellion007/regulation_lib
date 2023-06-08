class AddUnknownRefsToFieldSet < ActiveRecord::Migration[7.0]
  def change
    add_column :fields_sets, :unknown_refs, :string
  end
end
