module Tokenable
  extend ActiveSupport::Concern
  included do
    before_create :generate_token
	end

	def generate_token
		data = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
    self.token = loop do
			random_token = 10.times.reduce("") {|sum, n| "#{sum}#{data[rand(15)]}"}
      break random_token unless self.class.exists?(token: random_token)
    end
	end
end
