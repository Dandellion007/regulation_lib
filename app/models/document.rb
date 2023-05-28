class Document < ApplicationRecord
  has_one :original, class_name: 'Attributes::Original'
  has_one :shift, class_name: 'Attributes::Shift'

  has_many :original_references, through: :original, source: 'references'
  has_many :shift_references, through: :shift, source: 'references'

  class << self
    def all
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
  end
end
