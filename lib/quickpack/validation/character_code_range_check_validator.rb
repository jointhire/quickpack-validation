require 'quickpack/validation'

class CharacterCodeRangeCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # 設定パラメータのチェック
    msg1  = "CharacterCodeRangeCheckValidatorではrange_expression属性もしくは"
    msg1 << "setting_yaml_file属性のどちらかを必須指定してください。"
    raise msg1 unless options[:range_expression] || options[:setting_yaml_file]

    # TODO: 時間掛かりそうなので文字コード指定は一旦utf-8のみ
=begin
    character_set_mst = ['UTF-8', 'MS932']
    msg2  = "CharacterCodeRangeCheckValidatorのcharacter_set属性で指定出来るのは"
    msg2 << "「#{character_set_mst.join("、")}」です。"
    if options[:character_set]
      raise msg2 unless type_mst.include?(options[:character_set])
    end
=end

    # range_expression属性はString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    range_expression = [options[:range_expression]] if options[:range_expression].class == String
    range_expression = options[:range_expression] if options[:range_expression].class == Array

    # オプション指定の設定
    column_name = options[:column_name] ? options[:column_name] : attribute

    deny_ranges = []
    if range_expression
      range_expression.each do |one_range|
        if one_range.match(/-/)
          deny_range = []
          one_range.split('-').each do |code|
            # codeを整形しdeny_rangeへpush("E291A0"を2文字毎に分割し、それぞれ先頭に"\\x"付加してjoin) 
            deny_range.push(code.scan(/.{2}/).map{|i| "\\x" << i}.join)
          end
          deny_ranges.push(deny_range.join('-'))
        else
          deny_ranges.push(one_range.scan(/.{2}/).map{|i| "\\x" << i}.join)
        end
      end
    end

    if options[:setting_yaml_file]
      YAML.load_file("#{options[:setting_yaml_file]}").each do |one_range|
        case one_range.class.to_s
        when "Hash"
          deny_range = []
          deny_range.push(one_range["start"].scan(/.{2}/).map{|i| "\\x" << i}.join)
          deny_range.push(one_range["end"].scan(/.{2}/).map{|i| "\\x" << i}.join)
          deny_ranges.push(deny_range.join('-'))
        when "String"
          deny_ranges.push(one_range.scan(/.{2}/).map{|i| "\\x" << i}.join)
        end
      end
    end

    flg =  value =~ /#{deny_ranges.join("|")}/

    # flag=trueの場合、error文字を抽出
    if flg
      error_word = value.scan(/[#{deny_ranges.join("|")}]/).uniq
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.character_code_range_check',
                                              :error_word => error_word.join('、')))
      else
        record.errors.add(column_name, options[:message], :error_word => error_word.join('、'))
      end
    end
  end
end
