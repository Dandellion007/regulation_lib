json.extract! document, :id, :description, :title, :created_at, :updated_at
json.url document_url(document, format: :json)
