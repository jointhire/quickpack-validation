require 'quickpack/validation'

class ByteCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    # 設定パラメータのチェック
    msg1 = "オプションにmaximum（必須）を指定してください。"
    raise msg1 unless options[:maximum]

    # 文字コード指定がある場合は文字列をエンコード
    if options[:encode].blank?
      str = value
    else
      str = value.encode!(options[:encode])
    end

    target_size = (options[:only_number].nil? ? str.bytesize : str.split(//).size)

    if target_size > options[:maximum]
      if options[:message].nil?
        record.errors.add(attribute, I18n.t('errors.messages.byte_check',
                                            :maximum => options[:maximum]))
      else
        record.errors.add(attribute, options[:message],:maximum => options[:maximum])
      end
    end
  end
end