module Attributes
  class Base < ApplicationRecord
    belongs_to :document

    has_many :references, foreign_key: 'attributes_id'


  end
end
