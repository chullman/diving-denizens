class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit update destroy ]
  before_action :authorize_user, only: %i[edit update destroy]

  # GET /listings or /listings.json
  def index

    @listings = Listing.all

    if !params.nil? && params[:search].present?
      # ILIKE for case-insensitive search in postgresql
      # Note that we're running two search queries here:
      # The first one is to pattern match the search string param with every Listing title attribute
      # The second one is to pattern match the search string param with the name of every Listing's category relationship, hench why the SQL join is required
      # then we concatenate all the Listing results together and drop any (uniq!) duplicate found records resulting from both queries
      @listings = Listing.where("title ILIKE ?", "%" + params[:search].strip + "%") + Listing.joins(:categories).where("categories.name ILIKE ?", "%" + params[:search].strip + "%")
      @listings.uniq!
    end
    
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new

    @categories = Category.all
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)

    @listing.user_id = current_user.id

    @current_listing_fee = ListingFee.all.order(valid_from: :desc).first
    @listing.listing_fee = @current_listing_fee

  
    respond_to do |format|
      if @listing.save
        
        (params[:category][:name]).each do |cat|
          if !cat.empty?
            ListingCategory.create!(listing_id: @listing.id, category_id: Category.find_by!(name: cat).id)
          end
        end

        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def authorize_user
      if @listing.user_id != current_user.id && current_user.roles.name != "admin"
        flash[:alert] = "You are not authorised to do that!"
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:user_id, :title, :description, :outright_price, :negotiable, :quantity, :deliverable, :listing_fee_id, images: [])
    end
end
