class DocumentService
  def create(params)
    document = Document.new
    document.build_original(enum_value_to_i(params))
    document.save
    document
  end

  def update(params, document)
    if document.shift
      
      params = params.filter { |_, v| v }


      shift = document.shift
      new_fields = shift.attributes.symbolize_keys.except(:id, :created_at, :updated_at)  

      new_fields.keys.each do |key|
        if new_fields[key] == shift.send()

        end
      end

      document.original.update(new_fields)
      document.shift.update(params)
    else

      params = params.filter { |_, v| v != document.original.send(v) }
      params = enum_value_to_i(params)

      document.build_shift(params)
      document.save




    end
    document
  end

  private

  attr_reader :params

  # def initialize(params)
  #   @strings = params.slice(*Document.strings)
  #   @dates = params.slice(*Document.dates)
  #   @texts = params.slice(*Document.texts)
  #   @enums = params.slice(*Document.enums)
  # end

  def enum_value_to_i(params)
    enum_values = {}
    Document.enums.each { |k| enum_values[k] = params.delete(k) }
    enum_values.each { |k, v| params[k] = (v.present? ? v.to_i : '') }
    params
  end
end
