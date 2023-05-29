class FieldsSet < ApplicationRecord
  belongs_to :document

  has_many :references, foreign_key: 'attributes_id'

  enum :acceptance_level, [:international, :foreign, :national, :interstate, :organizations]
  enum :activity_status, [:active, :canceled, :replaced]
  enum :set_type, [:original, :shift]
end
