# coding : utf-8
# 入力値を配列化し、要素数をチェック

require 'quickpack/validation'

class ArrayLengthCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)
    max_chk = (options[:maxarraylength] != nil ? options[:maxarraylength] >= value.split(",").length : true)
    mini_chk = (options[:minarraylength] != nil ? options[:minarraylength] <= value.split(",").length : true )
    record.errors.add(attribute, I18n.t('errors.messages.array_length_check')) unless (mini_chk && max_chk)
  end
end
