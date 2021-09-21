require 'csv'

class GrupaCsv
	def self.to_csv(data)
		headers = ['Nombre', 'Provincia', 'Opera en Otra Provincia?', 'Notas']
		(2012..2020).each do |year|
			['Integrantes', 'Usuarios Mudados?', 'Cantidad Mudados', 'Mudados Siguen', 'Mudados Municipio', 'Base Grupa', 'Otras Zonas'].each do |sub_header|
				headers << "#{year} #{sub_header}"
			end
		end
		csv_file = ::CSV.generate(col_sep:"|") do |csv|
			csv << headers
			row =[data[:nombre], data[:provincia], data[:opera_otra_provicia], data[:notas]]
			data[:years].each do |year|
				
				row << year[:data][:integrantes]
				row << year[:data][:usuarios_mudaron]
				row << year[:data][:catidad_mudanza]
				row << year[:data][:mudados_siguen_participando]
				row << year[:data][:mudados_siguen_participando_donde]
				row << year[:data][:base_grupa]
				row << year[:data][:otras_zonas]
			end
			csv << row
		end

		return csv_file
	end
end