class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update ]

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    @postcode = Postcode.find_by(postcode: @address.postcode_id)
  end

  # GET /addresses/new
  def new
    @address = Address.new

  end

  # GET /addresses/1/edit
  def edit
    @postcode = Postcode.find_by(postcode: @address.postcode_id)
  end

  # POST /addresses or /addresses.json
  def create

    @address = Address.new(address_params)
    
    @postcode = Postcode.new(postcode_params)

    @postcode.postcode = @address.postcode_id
    
    @postcode.save

    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update

    @postcode = Postcode.find_by(postcode: params[:address][:postcode_id])

    if @postcode.nil?
      @postcode = Postcode.new(postcode_params)

      @postcode.postcode = params[:address][:postcode_id]
      @postcode.state = params[:postcode][:state]
      @postcode.save
    end

    respond_to do |format|
      if @address.update(address_params) && @postcode.update(postcode_params)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :unit_type, :unit_num, :lvl_type, :lvl_num, :street_type, :street_num, :street_name, :suburb, :postcode_id)
    end

    def postcode_params
      params.require(:postcode).permit(:state)
    end
end
