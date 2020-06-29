require 'quickpack/validation'

class PasswordCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    types_master=['hankaku_eiji', 'hankaku_capital_eiji', 'hankaku_small_eiji', 'hankaku_suuji', 'hankaku_kigou']
    types_any=types_master.map {|i| '?' + i } # "?"が頭についた文字セットは任意項目とする
    types_all=types_master + types_any

    # typesはString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    types = [options[:types]] if options[:types].class == String
    types = options[:types] if options[:types].class == Array

    # 設定パラメータのチェック
    msg1 = "PasswordCheckValidatorのパラメータにtypes属性(必須)を指定して下さい。"
    raise msg1 unless types

    msg2 = "PasswordCheckValidatorのtypes属性に指定出来るのは#{types_master.join('、')}です。"
    types.each do |item|
      p item
      raise msg2 unless types_all.include?(item)
    end

    # typesに対応する文字を格納
    require_word = []
    types.each do |item|
      require_word.push(CHAR_RANGE[item]) if CHAR_RANGE[item] != nil
    end
    allow_word = []
    types.each do |item|
      item = item.delete('?')
      allow_word.push(CHAR_RANGE[item])
    end

    # typesに対応する文字種別を格納
    types_str = []
    types_str.push('半角英字') if types.include?('hankaku_eiji')
    types_str.push('半角英大字') if types.include?('hankaku_capital_eiji')
    types_str.push('半角英子字') if types.include?('hankaku_small_eiji')
    types_str.push('半角数字') if types.include?('hankaku_suuji')
    types_str.push('半角記号') if types.include?('hankaku_kigou')

    # オプション指定の設定
    column_name = options[:column_name] ? options[:column_name] : attribute

    flg = true
    # 指定typesがそれぞれ1文字以上含まれているか？
    require_word.each do |item|
      flg = false unless value =~ /[#{item}]+/
    end
    # 指定types以外の文字が含まれていないか？
    flg = false if value =~ /[^#{allow_word.join}]/

    # flag=falseの場合、error文字を抽出し、error_msgを生成
    unless flg
      error_word = value.scan(/[^#{allow_word.join}]/).uniq 
      if error_word.length == 0
        error_msg = "には「#{types_str.join('、')}」を1文字以上含めてください。"
      else
        error_msg = "には「#{error_word.join('、')}」は使用できません。"
      end
    end

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.password_check', :error_msg => error_msg))
      else
        record.errors.add(column_name, options[:message], :error_msg => error_msg)
      end
    end

  end
end
