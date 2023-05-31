class DocumentService
  def create(params)
    params = params.to_h

    params = params.compact_blank
    document = Document.new
    original = document.build_original(enum_value_to_i(params))

    original.save ? document.save : original.errors.messages.each { |k, v| document.errors.add(k, *v) }
    document
  end

  def update(params, document)
    params = params.to_h.symbolize_keys
    params = params.filter { |k, v| v != document.last_values[k].to_s }
    params = enum_value_to_i(params)

    original_new_fields = document.original.attributes.symbolize_keys.slice(*params.keys).filter { |_, v| v.nil? }.keys

    document.original.update(params.slice(*original_new_fields))
    params.except!(*original_new_fields)

    if document.shift
      shift_new_fields = document.shift.attributes.symbolize_keys.slice(*params.keys).filter { |_, v| v.nil? }.keys
      document.shift.update(params.slice(*shift_new_fields))
      params.except!(*shift_new_fields)

      shift_fields = document.shift.attributes.symbolize_keys.slice(*params.keys)
      document.original.update(shift_fields)
      shift = document.shift
      shift.errors.messages.each { |k, v| document.errors.add(k, *v) } unless shift.update(params)
    else
      shift = document.build_shift(params)
      shift.errors.messages.each { |k, v| document.errors.add(k, *v) } unless shift.save
    end
    document
  end

  def archive(document)
    document.update(archived: true)
    document
  end

  private

  attr_reader :params

  def enum_value_to_i(params)
    enum_values = {}
    Document.enums.each { |k| enum_values[k] = params.delete(k) if params.has_key?(k) }
    enum_values.each { |k, v| params[k] = (v.present? ? v.to_i : '') }
    params
  end
end
