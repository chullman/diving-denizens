class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update ]

  def find_address(address)

    params.permit(:query, :commit)
    query = params[:query]

    results_hash = {}
    
    if !query.nil?
      uri = URI("https://api.psma.com.au/v2/addresses/geocoder?address=#{query}")
      header_key = "Authorization"
      header_value = Rails.application.credentials.geoscape[:consumer_key]

      results = helpers.fetch(uri, header_key, header_value)

      json_results = helpers.try_parse_json(results)

      if !(json_results.nil?) && json_results["messages"].empty?     
        
        results_hash[:unit_type] = json_results["features"][0]["properties"]["complexUnitType"].to_s
        results_hash[:unit_num] = json_results["features"][0]["properties"]["complexUnitNumber"].to_i
        results_hash[:lvl_type] = json_results["parsedQuery"]["complexLevelType"].to_s
        results_hash[:lvl_num] = json_results["parsedQuery"]["complexLevelNumber"].to_i
        results_hash[:street_type] = json_results["features"][0]["properties"]["streetTypeDescription"].to_s
        results_hash[:street_num] = json_results["features"][0]["properties"]["streetNumber1"].to_i
        results_hash[:street_name] = json_results["features"][0]["properties"]["streetName"].to_s
        results_hash[:suburb] = json_results["features"][0]["properties"]["localityName"].to_s
        results_hash[:state] = json_results["features"][0]["properties"]["stateTerritory"].to_s
        results_hash[:postcode_id] = json_results["features"][0]["properties"]["postcode"].to_i
        
      end
    end
    return results_hash

  end

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

    if !(params[:query].nil?)

      found_address = find_address(@address)

      @address = Address.new(
        street_name: found_address[:street_name].to_s,
        unit_type: found_address[:unit_type].to_s,

        lvl_type: found_address[:lvl_type].to_s,

        street_type: found_address[:street_type].to_s,
        street_num: found_address[:street_num].to_i,
        street_name: found_address[:street_name].to_s,
        suburb: found_address[:suburb].to_s,
        postcode_id: found_address[:postcode_id].to_i
      )

      @state_prepop = found_address[:state].to_s

      @address.unit_num = found_address[:unit_num].to_i if found_address[:unit_num].to_i != 0
      @address.lvl_num = found_address[:lvl_num].to_i if found_address[:lvl_num].to_i != 0

    else
      @address = Address.new
    end
    

  end

  # GET /addresses/1/edit
  def edit
    @postcode = Postcode.find_by(postcode: @address.postcode_id)
  end

  # POST /addresses or /addresses.json
  def create

    @address = Address.new(address_params)
    
    @postcode = Postcode.new(postcode_params)

    if Postcode.find_by(postcode: @address.postcode_id).nil?
      @postcode.postcode = @address.postcode_id
      
      @postcode.save
    end

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
      # @postcode.state = params[:postcode][:state]
      @postcode.save
    end

    respond_to do |format|
      if @address.update(address_params)
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
