module Tokenable
  extend ActiveSupport::Concern
  included do
    before_create :generate_token
		scope :dupe_code, lambda{|code| where("created_at >= ? AND activation_code = ?", 1.days.ago, code) }
	end

	def generate_token
    self.token = loop do
			random_token = 10.times.reduce("") {|sum, n| "#{sum}#{rand(16).to_s(16)}"}
      break random_token unless self.class.exists?(token: random_token)
    end
		self.activation_code = loop do
			code = random_token = 6.times.reduce("") {|sum, n| "#{sum}#{rand(10).to_s}"}
			break code unless self.class.dupe_code(code).length > 0
		end
	end
end
