class DocumentService
  def self.call(*args)
    new(*args).call
  end

  def call
    # matched_keys.map do |param|
    #   I18n.t("app.finders.companies.duplicate_clients.fields.#{param}", :"#{param}" => send(param))
    # end.join('; ')
  end

  private

  # attr_reader :prepared_companies

  def initialize(params)
    @strings = params
    @dates = params
    @texts = params
    @enums = params

    @prepared_companies = prepared_companies
  end
end

# def strings
#   [
#     'designation', 'denomination', 'oks_code', 'okpd_code', 'developer',
#     'replacement_for', 'doc_content_link', 'amendments',
#   ]
# end
# def dates
#   ['acceptance_date', 'introduction_date', 'desc_update_date']
# end
# def texts
#   ['head_content', 'key_phrases', 'key_words']
# end
# def enums
#   ['acceptance_level', 'activity_status']
# end
