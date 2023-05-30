class Document < ApplicationRecord
  has_one :original, -> { where(set_type: :original) }, class_name: 'FieldsSet'
  has_one :shift, -> { where(set_type: :shift) }, class_name: 'FieldsSet'

  has_many :original_references, through: :original, source: 'references'
  has_many :shift_references, through: :shift, source: 'references'

  # :archived=>false,

  class << self
    def all_fields
      [:strings, :dates, :texts, :enums].map { |s| send(s) }.inject(:|)
    end

    def strings
      [
        :designation, :denomination, :oks_code, :okpd_code, :developer,
        :replacement_for, :doc_content_link, :amendments,
      ]
    end

    def dates
      [:acceptance_date, :introduction_date, :desc_update_date]
    end

    def texts
      [:head_content, :key_phrases, :key_words]
    end

    def enums
      [:acceptance_level, :activity_status]
    end

    def acceptance_level_for_select
      FieldsSet.acceptance_levels.map { |k, v| [(I18n.t "model.document.acceptance_level_values.#{k}"), v] }
    end

    def activity_status_for_select
      FieldsSet.activity_statuses.map { |k, v| [(I18n.t "model.document.activity_status_values.#{k}"), v] }
    end
  end

  def last_values
    return @last_values if @last_values

    @last_values = {}
    self.class.all_fields.each do |field|
      @last_values[field] = if shift && !shift.send(field).nil?
                              shift.try(:send, "#{field}_before_type_cast")
                            else
                              original.try(:send, "#{field}_before_type_cast")
                            end
    end
    @last_values
  end
end
