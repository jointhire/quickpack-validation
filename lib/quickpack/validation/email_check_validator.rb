require 'quickpack/validation'

class EmailCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # 設定パラメータのチェック
    type_mst = ['email', 'domain', 'account'] 
    msg1 = "EmailCheckValidatorのtype属性には「#{type_mst.join("、")}」のいずれか1つを設定してください。"
    if options[:type]
      raise msg1 unless type_mst.include?(options[:type])
    end

    msg2 = "EmailCheckValidatorではmobile属性とexcludes_mobile属性の同時指定はできません。"
    raise msg2 if options[:mobile] && options[:excludes_mobile]    

    # carrireはString or Array のどちらかの形式で指定できる為、後続処理用にArray変数に再格納
    carriers = [options[:carriers]] if options[:carriers].class == String
    carriers = options[:carriers] if options[:carriers].class == Array

    # オプション指定の設定
    type = options[:type] ? options[:type] : 'email'
    special_chars = options[:special_chars] ? options[:special_chars] : '!#$%&\'*+-.\/=?^_`|~\[\]' 
    mobile = options[:mobile] == true ? true : false
    excludes_mobile = options[:excludes_mobile] == true ? true : false
    
    column_name = options[:column_name] ? options[:column_name] : attribute
    
    # type属性で指定されている範囲についてMailフォーマットとして正しいかチェック
    case type
    when "email"
      format = "^[a-zA-Z0-9#{special_chars}]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}+$"
    when "domain"
      format = "@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"
    when "account"
      format = "^[a-zA-Z0-9#{special_chars}]+@"
    end

    flg = value =~ /#{format}/

    # 前処理のフォーマットチェク結果で flg = true、且つmobileまたはexcludes_mobile属性が指定されている場合、
    # ドメイン部分が許可しているものかどうかもチェック

    if flg && ( mobile || excludes_mobile )
      allow_domain = CHAR_RANGE["default_mobile_domain"]
      if carriers
        carriers.each do |item|
          allow_domain << "|#{item}"
        end
      end     
      
      flg = value =~ /@(#{allow_domain})$/ if mobile
      flg = value !~ /@(#{allow_domain})$/ if excludes_mobile
    end

    unless flg
      if options[:message].nil?
        record.errors.add(column_name, I18n.t('errors.messages.email_check'))
      else
        record.errors.add(column_name, options[:message])
      end
    end
  end
end
