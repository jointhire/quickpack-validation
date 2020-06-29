# 2byteの全角文字を半角2文字として計算

require 'quickpack/validation'

class ByteSizeCheckValidator < ActiveModel::EachValidator

  include Quickpack::Validation

  def validate_each(record, attribute, value)

    count = 0
    value.split(//).each do |v|
      v.bytesize > 1 ? count += 2 : count += 1
    end

    if count > options[:maximum]
      if options[:message].nil?
        record.errors.add(attribute, I18n.t('errors.messages.byte_size_check',
                                            :maximum => options[:maximum]))
      else
        record.errors.add(attribute, options[:message],:maximum => options[:maximum])
      end
    end
  end
end