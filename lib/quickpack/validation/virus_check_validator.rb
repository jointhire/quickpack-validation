# coding : utf-8
require 'clamav'

class VirusCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    clam=ClamAV.instance
    p "==========================="
    p value.tempfile
    p "==========================="
    clam.loaddb
    File.open('./tmp/files/'+ value.original_filename, 'wb') do |of|
      of.write(value.read)
    end
    p path = "./tmp/files/"+value.original_filename
    check = clam.scanfile(path)
    if check != 0
      record.errors.add(attribute, 'ƒEƒCƒ‹ƒXŠ´õ‚Ì‹^‚¢‚ª‚ ‚è‚Ü‚·')
      File.delete('./tmp/files/'+ value.original_filename)
    end
  end
end
