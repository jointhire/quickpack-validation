# -*- encoding: utf-8 -*-
# stub: quickpack-validation 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "quickpack-validation".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "http://dummyserver.samubuc.co.jp" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Samubuc Co.,Ltd".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-05-20"
  s.description = "description".freeze
  s.email = ["info@samubuc.co.jp".freeze]
  s.files = [".gitignore".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/quickpack/validation.rb".freeze, "lib/quickpack/validation/X_array_length_check_validator.rb".freeze, "lib/quickpack/validation/X_code.yml".freeze, "lib/quickpack/validation/X_decimal_numeric_check_validator.rb".freeze, "lib/quickpack/validation/X_decimal_range_check_validator.rb".freeze, "lib/quickpack/validation/X_regformat_check_validator.rb".freeze, "lib/quickpack/validation/X_safety_html_check_validator.rb".freeze, "lib/quickpack/validation/alpha_check_validator.rb".freeze, "lib/quickpack/validation/alpha_or_numeric_check_validator.rb".freeze, "lib/quickpack/validation/byte_check_validator.rb".freeze, "lib/quickpack/validation/byte_size_check_validator.rb".freeze, "lib/quickpack/validation/byte_size_validation.rb".freeze, "lib/quickpack/validation/char.yml".freeze, "lib/quickpack/validation/character_check_validator.rb".freeze, "lib/quickpack/validation/character_code_range_check_validator.rb".freeze, "lib/quickpack/validation/date_check_validator.rb".freeze, "lib/quickpack/validation/email_check_validator.rb".freeze, "lib/quickpack/validation/file_extension_check_validator.rb".freeze, "lib/quickpack/validation/file_size_limit_check_validator.rb".freeze, "lib/quickpack/validation/flag_check_validator.rb".freeze, "lib/quickpack/validation/hankana_check_validator.rb".freeze, "lib/quickpack/validation/hiragana_check_validator.rb".freeze, "lib/quickpack/validation/ja.yml".freeze, "lib/quickpack/validation/katakana_check_validator.rb".freeze, "lib/quickpack/validation/password_check_validator.rb".freeze, "lib/quickpack/validation/url_check_validator.rb".freeze, "lib/quickpack/validation/version.rb".freeze, "lib/quickpack/validation/virus_check_validator.rb".freeze, "quickpack-validation.gemspec".freeze]
  s.homepage = "http://www.samubuc.co.jp".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "summary".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
