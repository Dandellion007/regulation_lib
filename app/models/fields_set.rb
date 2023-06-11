class FieldsSet < ApplicationRecord
  belongs_to :document

  has_many :references

  enum :acceptance_level, [:international, :foreign, :national, :organizations]
  enum :activity_status, [:active, :canceled, :replaced]
  enum :set_type, [:original, :shift]

  validates_presence_of :designation, if: -> { set_type.to_sym == :original }

  def inactive_refs
    return [] unless unknown_refs

    unknown_refs[1..-2].split(', ').map { |x| x[1..-2] }
  end

  def refs
    references.map do |ref|
      if ref.referral_doc
        {
          name: ref.referral_doc.last_values[:designation],
          path: Rails.application.routes.url_helpers.document_path(ref.referral_doc),
        }
      else
        {name: '', path: ''}
      end
    end
  end
end
