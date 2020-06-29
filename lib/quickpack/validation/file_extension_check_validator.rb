require 'quickpack/validation'

class FileExtensionCheckValidator  < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # typesはString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    types = [options[:types]] if options[:types].class == String
    types = options[:types] if options[:types].class == Array

    # 設定パラメータのチェック
    msg1 = "FileExtensionCheckValidatorのパラメータにtypes属性(必須)を指定して下さい。"
    raise msg1 unless types

    # オプション指定の設定
    column_name = options[:column_name] ? options[:column_name] : attribute

    # types指定が「.(ピリオド)」付き/無しのどちらでも良いように一旦削除 ->
    tmp_types = []
    types.each do |item|
      tmp_types.push item.sub(/^\./, '')
    end
    types.clear
    tmp_types.each do |item|
      types.push item.sub(/#{item}/, ".#{item}")
    end

    # MainProcess
    flg = value.original_filename =~/(#{types.join("|")})$/i

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.file_extension_check',
         :extensions => types.join('、').downcase))
      else
        record.errors.add(column_name, options[:message], :extensions => types.join('、').downcase)
      end
    end

  end
end
