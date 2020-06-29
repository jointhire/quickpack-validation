require 'quickpack/validation'

class CharacterCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    types_master=[ 'hankaku_eiji', 'zenkaku_eiji', 'hankaku_suuji', 'zenkaku_suuji',
      'hankaku_katakana', 'zenkaku_katakana', 'hiragana', 'hankaku_kigou', 'zenkaku_kigou',
      'jis_kanji', 'jis_zenkaku', 'zenkaku_gaikokumoji' ]

    # typesはString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    types = [options[:types]] if options[:types].class == String
    types = options[:types] if options[:types].class == Array

    # 設定パラメータのチェック
    msg1 = "CharacterCheckValidatorのパラメータにtypes属性(必須)を指定して下さい。"
    raise msg1 unless types

    msg2 = "CharacterCheckValidatorのtypes属性に指定出来るのは#{types_master.join('、')}です。"
    types.each do |item|      
      raise msg2 unless types_master.include?(item)
    end

    # typesに対応する文字を格納
    allow_word = ''
    types.each do |item|
      allow_word << CHAR_RANGE[item]
    end

    # オプション指定した文字を格納
    allow_word << "\s　" if options[:allowblank] == true
    allow_word << "\n\r" if options[:allowcrlf] == true
    allow_word << "\t\n\f\r" if options[:allowspace] == true
    allow_word << "\x00-\x1F\x7F" if options[:allowcontrolchar] == true
    if options[:allowspecialchar] == true
      allow_word << "#{CHAR_RANGE['nec_tokushu']}"
      allow_word << "#{CHAR_RANGE['nec_sentei_ibm_kakucho']}"
      allow_word << "#{CHAR_RANGE['ibm_kakucho']}"
    end

    # オプション指定の設定
    allow_word << options[:allow_word] if options[:allow_word]
    column_name = options[:column_name] ? options[:column_name] : attribute

    # MainProcess
    flg = value =~/^[#{allow_word}]+$/

    # flag=falseの場合、error文字を抽出
    unless flg
      error_word = value.scan(/[^#{allow_word}]/).uniq
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.character_check',
                                              :error_word => error_word.join('、')))
      else
        record.errors.add(column_name, options[:message],:error_word => error_word.join('、'))
      end
    end
  end
end
