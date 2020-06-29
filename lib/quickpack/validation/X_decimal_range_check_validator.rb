# coding : utf-8
# 小数点・負の整数で範囲指定のうえ比較を行なう

require 'quickpack/validation'

class DecimalRangeCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)
    record.errors.add(attribute, I18n.t('errors.messages.decimal_range_check1')) unless value =~ /^(-?\d+(\.\d+)?$)/
    mini_chk = (options[:min] != nil ? (options[:moreThan] == true ? options[:min].to_f <= value.to_f : options[:min].to_f < value.to_f) : true)
    max_chk = (options[:max] != nil ? (options[:lessThan] == true ? options[:max].to_f >= value.to_f : options[:max].to_f > value.to_f) : true)
    record.errors.add(attribute, I18n.t('errors.messages.decimal_range_check2')) unless (mini_chk && max_chk)
  end
end
