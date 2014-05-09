class BelongsToContactController < ApplicationController
  before_action :load_contact


  def load_contact
    @contact = Contact.find(params.require(:contact_id))
    redirect_to root_path unless @contact
  end
end
