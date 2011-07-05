class Room < ActiveRecord::Base
  def letter_code
    # this generates a letter code - so the ID 0 would return 'a' etc.
    n = @id.to_i
    # this is currenly zero indexed. uncomment next line to change
    #n = n - 1
    letter_code = n.to_i.to_s(27).tr("0-9a-q", "a-z").downcase
    return letter_code
  end
  
  def self.letter_code_to_id(str)
    str.tr("a-z", "0-9a-q").upcase.to_i(27)
  end
end
