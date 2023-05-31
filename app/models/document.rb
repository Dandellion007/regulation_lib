class Document < ApplicationRecord
  has_one :original, -> { where(set_type: :original) }, class_name: 'FieldsSet', dependent: :destroy
  has_one :shift, -> { where(set_type: :shift) }, class_name: 'FieldsSet', dependent: :destroy

  has_many :original_references, through: :original, source: 'references', dependent: :destroy
  has_many :shift_references, through: :shift, source: 'references', dependent: :destroy

  scope :archived, -> { where archived: true }
  scope :active, -> { where archived: false }

  class << self
    def all_fields
      [:strings, :dates, :texts, :enums].map { |s| send(s) }.inject(:|)
    end

    def search_fields
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

    def search(search_params, scope = 'active')
      # ds.joins(:original).where(original: {documents: 'a'})
      search_params = search_params.to_h.filter { |_, v| v.present? }.symbolize_keys
      return Document.send(scope) if search_params.empty?

      hash = {}
      Document.active.map { |x| hash[x.id] = x.last_values }
      ids = hash.filter { |_, v| compare_fields(v, search_params) }.keys
      Document.send(scope).where(id: ids)
    end

    def compare_fields(values, params)
      params.each { |k, v| return false unless values[k].include?(v) }
      true
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
