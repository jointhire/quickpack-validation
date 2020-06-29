require 'quickpack/validation'

class UrlCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # schemesはString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    schemes = [options[:schemes]] if options[:schemes].class == String
    schemes = options[:schemes] if options[:schemes].class == Array

    # オプション指定の設定
    if options[:allowallschemes] == true
      allow_schemes = "[a-z]+"
    elsif schemes  
      allow_schemes = "(#{schemes.join("|")})"
    else
      allow_schemes = "(https?|ftp)"
    end

    allow_slashes = options[:allow2slashes] == false ? '' : '\/\/'
    
    allow_path = "\\w:%#\$&\?\(\)~\.=\+\-"
    allow_path = allow_path.sub("#","") if options[:nofragments] == false

    column_name = options[:column_name] ? options[:column_name] : attribute

    # MainProcess
    flg = value =~ /^#{allow_schemes}:#{allow_slashes}[#{allow_path}]+\/?$/

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.url_check'))
      else
        record.errors.add(column_name, options[:message])
      end
    end

  end
end
