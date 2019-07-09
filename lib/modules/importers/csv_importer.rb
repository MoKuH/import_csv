require 'csv'
module Importers
	module CsvImporter

		def self.import class_name, file
			i = 0
			not_imported = []
			CSV.foreach(file.path, headers: true) do |row|
				i+=1
				unless class_name.create(row.to_hash).persisted?
					#add not imported object in a list, in case we would like to see model errors
					not_imported << class_name.new(row.to_hash).valid?
				end
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