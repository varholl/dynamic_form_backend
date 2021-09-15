class GrupaMailer < ApplicationMailer
	def send_form_email
		attachments["#{Time.now.strftime("%Y%m%d%H%M%S")}_grupa_data.csv"] = {mime_type: 'text/csv', content: params[:csv]}
		mail(to: ENV['RECIPIENT_EMAIL'], subject: 'Nuevo formulario de Grupa')
	end
end
