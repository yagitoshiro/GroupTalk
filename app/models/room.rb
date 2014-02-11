class Room < ActiveRecord::Base
	include Tokenable
	scope :active_room, lambda{|token| where("created_at >= ? AND token = ?", 1.days.ago, token).first }
	scope :validated_room, lambda{|code| where("created_at >= ? AND activation_code = ?", 1.days.ago, code).first }
end
