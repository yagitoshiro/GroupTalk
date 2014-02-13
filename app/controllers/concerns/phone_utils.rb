module PhoneUtils
  def parse_phone_number(number)
    number.gsub(/[^0-9+]/, '').gsub(/\A0/, '+81')
  end
end
