require "quickpack/validation/version"

# TODO: 固定loadではなく、auto_loadにしたい
require "quickpack/validation/character_check_validator"
require "quickpack/validation/hiragana_check_validator"
require "quickpack/validation/email_check_validator"
require "quickpack/validation/password_check_validator"
require "quickpack/validation/date_check_validator"
require "quickpack/validation/alpha_or_numeric_check_validator"
require "quickpack/validation/password_check_validator"
require "quickpack/validation/url_check_validator"
require "quickpack/validation/hankana_check_validator"
require "quickpack/validation/alpha_check_validator"
require "quickpack/validation/katakana_check_validator"
require "quickpack/validation/character_code_range_check_validator"
require "quickpack/validation/file_extension_check_validator"
require "quickpack/validation/file_size_limit_check_validator"
require "quickpack/validation/byte_size_check_validator"
require "quickpack/validation/flag_check_validator"
require "quickpack/validation/byte_check_validator"
#require "quickpack/validation/regformat_check_validator"

# 作ったが不要そうなので一旦コメントアウト
#require "quickpack/validation/array_length_check_validator"
#require "quickpack/validation/decimal_range_check_validator"
#require "quickpack/validation/decimal_numeric_check_validator"
#require "quickpack/validation/safety_html_check_validator"

module Quickpack
  module Validation
    # validationで使用する文字範囲をyamlから読み込み、loadしておく
    CHAR_RANGE = YAML.load_file(File.dirname(__FILE__) + "/validation/char.yml")

    # validationではなく関数的に利用しそうなものはmodule_methodとして定義しておく
    extend self
  end
end
