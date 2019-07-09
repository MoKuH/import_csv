class User < ApplicationRecord
	attr_accessor :file

	validates_presence_of :name,:number,:date,:description
	validates_numericality_of :number
	validates_date :date
	validates_presence_of :file, if: :must_validate?


	PERMIT_ATTRIBUTES = [:name,:number,:date,:description]

	def must_validate?
		self.attributes.all?{|i,a|a.nil?}
	end
end
