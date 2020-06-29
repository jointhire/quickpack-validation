require 'quickpack/validation'

class HiraganaCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    allow_word = CHAR_RANGE["hiragana"]

    # オプション指定の設定
    allow_word << options[:allow_word] if options[:allow_word]
    column_name = options[:column_name] ? options[:column_name] : attribute

    flg = value =~ /^[#{allow_word}]+$/

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.hiragana_check'))
      else
        record.errors.add(column_name, options[:message])
      end
    end

  end
end
