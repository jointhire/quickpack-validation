# coding : utf-8
# 禁止文字列指定のHTML属性チェック

require 'quickpack/validation'

class SafetyHtmlCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)
    ng_pattern = value.scan(/#{yaml_load("ng_html").split(",").join("|")}+/)
    record.errors.add(attribute, I18n.t('errors.messages.safety_html_check', :ng_pattern => ng_pattern.join(","))) if value =~ /#{yaml_load("ng_html").split(",").join("|")}+/
  end
end
