require 'csv'
module Importers
	module CsvImporter

		def self.import class_name, file
			i = 0
			not_imported = []
			CSV.foreach(file.path, headers: true) do |row|
				i+=1
				data = row.to_hash.reject{|a|!User::PERMIT_ATTRIBUTES.include? a.to_sym}
				entry = class_name.new(data)
				#THIS IS A HACK TO PROTECT PUBLIC SERVER
				User.destroy_all if Rails.env.production? && class_name.count>200
				#add not imported object in a list, in case we would like to see model errors
				not_imported << entry unless entry.save
			end
			Importer::Result.new not_imported, i
		end

		def self.generate data
			CSV.generate(headers: true) do |csv|
				csv << data.klass.column_names
				data.each do |user|
					csv << data.klass.column_names.map{ |attr| user.send(attr) }
				end
			end
		end
	end
end