class User < ApplicationRecord
	attr_accessor :file_csv

	validates_presence_of :name,:number,:date,:description
	validates_numericality_of :number
	validates_date :date

end
