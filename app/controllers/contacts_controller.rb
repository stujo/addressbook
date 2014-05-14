class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = prep_pagination Contact.all
  end

  def over50s
    @today = Time.now
    @then = @today - 50.years
    @contacts = prep_pagination Contact.where('dob < :then', {then: @then})
    @filter_label = 'Over 50\'s'
    render 'filtered'
  end

  def males
    @contacts = prep_pagination Contact.where(gender: Contact::GENDER_MALE)
    @filter_label = 'Males'
    render 'filtered'
  end

  def females
    @contacts = prep_pagination Contact.females
    @filter_label = 'Females'
    render 'filtered'
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.phones.build
    @contact.addresses.build
  end

  # GET /contacts/1/edit
  def edit
    @contact.phones.build
    @contact.addresses.build
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to edit_contact_path(@contact), notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to edit_contact_path(@contact), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  # def destroy
  #   @contact.destroy
  #   respond_to do |format|
  #     format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :dob, :gender, :phones_attributes => [:digits, :phone_type], :addresses_attributes => [:street, :street_2, :city, :state, :zip, :phone_type])
  end
end
