class DocumentService
  def create(params)
    params = params.to_h

    params = params.compact_blank
    document = Document.new
    document.build_original(enum_value_to_i(params))
    document.save
    document
  end

  def update(params, document)
    params = params.to_h.symbolize_keys
    params = params.filter { |k, v| v != document.last_values[k].to_s }
    params = enum_value_to_i(params)

    original_new_fields = document.original.attributes.symbolize_keys.slice(*params.keys).filter { |_, v| v.nil? }.keys

    # debugger

    document.original.update(params.slice(*original_new_fields))
    params.except!(*original_new_fields)

    if document.shift
      shift_new_fields = document.shift.attributes.symbolize_keys.slice(*params.keys).filter { |_, v| v.nil? }.keys
      document.shift.update(params.slice(*shift_new_fields))
      params.except!(*shift_new_fields)

      shift_fields = document.shift.attributes.symbolize_keys.slice(*params.keys)
      document.original.update(shift_fields)
      document.shift.update(params)
    else
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
