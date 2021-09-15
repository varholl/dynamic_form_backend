require 'csv'

class GrupasController < ApplicationController
	def create
		grupa = grupa_params

		GrupaMailer.with(csv: GrupaCsv.to_csv(grupa)).send_form_email.deliver_now
		
		render status: :ok
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
