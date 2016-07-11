class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Muito obrigado pela sua mensagem, responderemos assim que possível!'
    else
      flash.now[:error] = 'Algo deu errado e não pudemos enviar sua mensagem :('
      render :new
    end
  end
end