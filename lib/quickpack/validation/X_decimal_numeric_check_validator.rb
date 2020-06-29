# coding : utf-8
# 負の整数・小数点も入力可能にする

require 'quickpack/validation'

class DecimalNumericCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)
    record.errors.add(attribute, I18n.t('errors.messages.decimal_numeric_check')) unless value =~ /^(-?\d+(\.\d+)?$)/
  end
end
