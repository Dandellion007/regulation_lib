class FieldsSet < ApplicationRecord
  belongs_to :document

  has_many :references

  enum :acceptance_level, [:international, :foreign, :national, :interstate, :organizations]
  enum :activity_status, [:active, :canceled, :replaced]
  enum :set_type, [:original, :shift]

  validates_presence_of :designation, if: -> { set_type.to_sym == :original }
end
