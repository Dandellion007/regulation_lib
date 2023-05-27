class Document < ApplicationRecord
  has_one :original, class_name: 'Attributes::Original'
  has_one :shift, class_name: 'Attributes::Shift'

end
