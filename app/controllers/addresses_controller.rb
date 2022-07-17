class AddressesController < ApplicationController
  before_action :get_existing_user_address, only: %i[ show edit update find_address ]
  before_action :authenticate_user!, only: %i[ new show edit update ]
  before_action :authorize_user, only: %i[edit update ]
  

  def find_address

    params.permit(:query, :commit, :id)

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
  

    if !(params[:id].nil?)
      redirect_to edit_address_path(id: params[:id], results_hash: results_hash)
    else
      
      redirect_to new_address_path(results_hash: results_hash)
    end

  end

  # GET /addresses or /addresses.json
  # def index
  #   @addresses = Address.all
  # end

  # GET /addresses/1 or /addresses/1.json
  # def show
  #   @postcode = Postcode.find_by(postcode: @address.postcode_id)
  # end

  # GET /addresses/new
  def new

    if !params[:results_hash].nil?

      @address = Address.new(
        unit_type: params[:results_hash][:unit_type].to_s,

        lvl_type: params[:results_hash][:lvl_type].to_s,

        street_type: params[:results_hash][:street_type].to_s,
        street_num: params[:results_hash][:street_num].to_i,
        street_name: params[:results_hash][:street_name].to_s,
        suburb: params[:results_hash][:suburb].to_s,
        postcode_id: params[:results_hash][:postcode_id].to_i
      )

      @state_prepop = params[:results_hash][:state].to_s

      @address.unit_num = params[:results_hash][:unit_num].to_i if params[:results_hash][:unit_num].to_i != 0
      @address.lvl_num = params[:results_hash][:lvl_num].to_i if params[:results_hash][:lvl_num].to_i != 0
    else
      @address = Address.new
    end

  end

  # GET /addresses/1/edit
  def edit
    @postcode = Postcode.find_by(postcode: @address.postcode_id)

    if !params[:results_hash].nil?

      @address.unit_type = params[:results_hash][:unit_type].to_s

      @address.lvl_type = params[:results_hash][:lvl_type].to_s

      @address.street_type = params[:results_hash][:street_type].to_s
      @address.street_num = params[:results_hash][:street_num].to_i
      @address.street_name = params[:results_hash][:street_name].to_s
      @address.suburb = params[:results_hash][:suburb].to_s
      @address.postcode_id = params[:results_hash][:postcode_id].to_i

      @state_prepop = params[:results_hash][:state].to_s

      @address.unit_num = params[:results_hash][:unit_num].to_i if params[:results_hash][:unit_num].to_i != 0
      @address.lvl_num = params[:results_hash][:lvl_num].to_i if params[:results_hash][:lvl_num].to_i != 0
    end

  end

  # POST /addresses or /addresses.json
  def create

    @address = Address.new(address_params)
    
    @postcode = Postcode.new(postcode_params)

    if Postcode.find_by(postcode: @address.postcode_id).nil?
      @postcode.postcode = @address.postcode_id
      
      @postcode.save
    end

    if user_signed_in?
      @address.user_id = current_user.id
    else
      @address.user_id = nil
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

    attributes = address_params.clone
    attributes[:user_id] = set_user_id_if_exists

    respond_to do |format|
      if @address.update(attributes)
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
    def get_existing_user_address
      if user_signed_in?
        @address = Address.find_by(user_id: current_user.id)
      end
      # if !(params[:id].nil?) && !(params[:id].empty?)
      #   @address = Address.find(params[:id]) 
      # end
    end

    def set_user_id_if_exists
      if user_signed_in?
        return current_user.id
      else
        return nil
      end
    end

    def authorize_user
      if @address.user_id != current_user.id && current_user.roles.name != "admin"
        flash[:alert] = "You are not authorised to do that!"
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :unit_type, :unit_num, :lvl_type, :lvl_num, :street_type, :street_num, :street_name, :suburb, :postcode_id, :user_id)
    end

    def postcode_params
      params.require(:postcode).permit(:state)
    end
end
