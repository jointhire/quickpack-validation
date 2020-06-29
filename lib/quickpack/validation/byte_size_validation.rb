require 'quickpack/validation'
      # ↓かえろ
class HiraganaCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)
# ↑触るな

    
    allow_word = CHAR_RANGE["hiragana"]

    # オプション指定の設定
    flg = value.size = options[:size] 

    record.errors.add(column_name, I18n.t('errors.messages.hiragana_check')) unless flg
  end
end
