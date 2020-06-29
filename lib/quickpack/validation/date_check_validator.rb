require 'quickpack/validation'
require 'date'

class DateCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # オプション指定の設定
    format = (options[:format].nil? ? "%Y/%m/%d" : options[:format])

    # MainProcess
    begin
      date_obj = Date.strptime(value, format)
      flg = true
    rescue
      flg = false
    end

    # options[:format] => true 且つMainProcessでDate変換出来た場合は
    # valueと同値であることをチェック
    if flg && options[:strict] == true
      flg = value == date_obj.strftime(format)
    end  

    unless flg
      if options[:message].nil?
        record.errors.add(attribute, I18n.t('errors.messages.date_check'))
      else
        record.errors.add(attribute, options[:message])
      end
    end
  end
end
