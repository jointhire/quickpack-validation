require 'quickpack/validation'

class FileSizeLimitCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # limitsizeはString or Fixnum のどちらかの形式で指定できる為、後続処理用にString変数に再格納
    limit_size = options[:limitsize] if options[:limitsize].class == String
    limit_size = options[:limitsize].to_s if options[:limitsize].class == Fixnum

    # 設定パラメータのチェック
    msg1 = "FileSizeLimitCheckValidatorのパラメータにlimitsize属性(必須)を指定して下さい。"
    raise msg1 unless options[:limitsize]

    # オプション指定の設定
    column_name = options[:column_name] ? options[:column_name] : attribute

    # 単位をbyteに統一
    case limit_size
    when /^\d+$/
      byte = limit_size.to_i
    when /K$/i
      byte = limit_size.sub(/K$/i, '').to_i * 1024
    when /M$/i
      byte = limit_size.sub(/M$/i, '').to_i * ( 1024 ** 2 )
    when /G$/i
      byte = limit_size.sub(/G$/i, '').to_i * ( 1024 ** 3 )
    end

    # MainProcess
    flg = value.size <= byte

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.file_size_limit_check',
                                              :limit_size => limit_size.upcase))
      else
        record.errors.add(column_name, options[:message], :limit_size => limit_size.upcase)
      end
    end

  end
end
