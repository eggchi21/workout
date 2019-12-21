class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t('errors.messages.invalid_date_format') unless /\A\d{1,4}\-\d{1,2}\-\d{1,2}\Z/ =~ value.to_s
  end
end
