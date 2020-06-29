require 'quickpack/validation'

class RegformatCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # 設定パラメータのチェック
    msg1 = "オプションにwith（必須）を指定してください。"
    raise msg1 unless options[:with]

    format = /#{options[:with]}/

    # MainProcess
    flg = value =~format

    unless flg
      if options[:message].nil?
        record.errors.add(attribute, I18n.t('errors.messages.regformat_check'))
      else
        record.errors.add(attribute, options[:message])
      end
    end
  end
end
