class Reference < ApplicationRecord
  belongs_to :attrs, class_name: 'Attributes::Base', foreign_key: 'attributes_id'
  belongs_to :referrer_doc, class_name: 'Document'
  belongs_to :referral_doc, class_name: 'Document'
end
