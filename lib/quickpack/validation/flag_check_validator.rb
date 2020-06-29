require 'quickpack/validation'

class FlagCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # オプション指定の設定
    flag = (options[:flag].nil? ? "0|1" : options[:flag].join("|"))

    # 正規表現に整形
    format = /\A(#{flag})\z/

    # MainProcess
    flg = value =~format

    unless flg
      if options[:message].nil?
        record.errors.add(attribute, I18n.t('errors.messages.flag_check'))
      else
        record.errors.add(attribute, options[:message])
      end
    end
  end
end
