require 'quickpack/validation'

class AlphaCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation
 
  def validate_each(record, attribute, value)

    allow_word = CHAR_RANGE["hankaku_eiji"]

    # オプション指定の設定
    allow_word << options[:allow_word] if options[:allow_word]
    column_name = options[:column_name] ? options[:column_name] : attribute

    flg = value =~ /^[#{allow_word}]+$/
    record.errors.add(column_name, I18n.t('errors.messages.alpha_check')) unless flg
  end
end
