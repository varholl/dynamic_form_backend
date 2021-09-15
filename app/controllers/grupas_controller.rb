require 'csv'

class GrupasController < ApplicationController
	def create
		grupa = grupa_params

		headers = ['Nombre', 'Provincia']
		(2012..2020).each do |year|
			['Integrantes', 'Usuarios Mudados?', 'Cantidad Mudados', 'Mudados Siguen', 'Mudados Municipio', 'Base Grupa', 'Otras Zonas'].each do |sub_header|
				headers << "#{year} #{sub_header}"
			end
		end
		csv_file = ::CSV.generate(col_sep:"|") do |csv|
			csv << headers
			row =[grupa[:nombre], grupa[:provincia]]
			grupa[:years].each do |year|
				
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

		GrupaMailer.with(csv: csv_file).send_form_email.deliver_now
		#render json: grupa
	end

	private

	def grupa_params
		params.require(:grupa).permit(:nombre, 
			:provincia, 
			years:[ :year, data:[
				:integrantes, :usuarios_mudaron, :catidad_mudanza, :mudados_siguen_participando, :mudados_siguen_participando_donde, :base_grupa, :otras_zonas
			]])
	end
end
