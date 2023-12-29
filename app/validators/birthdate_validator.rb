# frozen_string_literal: true

class BirthdateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    return if valid_birthdate?(value)

    record.errors.add attribute, (options[:message] || 'is not valid')
  end

  private

  def valid_birthdate?(birthdate)
    age = Date.today.year - birthdate.year - (Date.today.month > birthdate.month || (Date.today.month == birthdate.month && Date.today.day >= birthdate.day) ? 0 : 1)
    age.between?(1, 110)
  end
end
