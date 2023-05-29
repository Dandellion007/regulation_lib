class Reference < ApplicationRecord
  belongs_to :fields_set
  belongs_to :referrer_doc, class_name: 'Document'
  belongs_to :referral_doc, class_name: 'Document'
end
