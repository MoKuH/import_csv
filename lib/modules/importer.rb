module Importer

	ACCEPTED_FORMATS = [:csv]

	#dynamically call the importer corresponding to the file extention
	# only support CSV for now
	# An exception is raise if the file extention is not accepted
	# klass model Class
	# fil UploadedFile
	def self.import klass, file
		ext = File.extname(file.original_filename).gsub(".","")
		raise InvalidFormat unless ACCEPTED_FORMATS.include? ext.try(:to_sym)
		"Importers::#{ext.capitalize}Importer".constantize.import(klass,file)
	end

	#method use to generate a file with #file_type extention from the data sent in parameter
	#An exception is raise if the file extention is not accepted
	# file_type String [csv]
	# data ActiveRecord list
	def self.generate file_type, data
		raise InvalidFormat unless ACCEPTED_FORMATS.include? file_type.try(:to_sym)
		"Importers::#{file_type.capitalize}Importer".constantize.generate(data)
	end

	class InvalidFormat < StandardError
		def message
			"Only support #{ACCEPTED_FORMATS.join(',')} file supported for now"
		end
	end

	#class returned by import process
	# return the total entries number and the failed ones
	class Result
		attr_accessor :failed_entries_objects,:total_entries
		def initialize failed_entries_objects, total_entries
			@failed_entries_objects = failed_entries_objects
			@total_entries = total_entries
		end

		def success?
			@failed_entries_objects.empty?
		end

		def failed?
			!success?
		end

		def total_failed
			@failed_entries_objects.size
		end

		def total_success
			@total_entries-total_failed
		end
	end

end