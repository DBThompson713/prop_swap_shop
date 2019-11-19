class PlantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plant, only: [:show, :edit, :update, :destroy]

  # GET /plants
  # GET /plants.json
  def index
    @plants = Plant.all
  end

  # GET /plants/1
  # GET /plants/1.json
  def show
    session = Stripe::Checkout::Session.create(
            payment_method_types: ["card"],
            customer_email: current_user.email,
            line_items: [
                {
                    name: @plant.name,
                    description: @plant.description,
                    amount: @plant.price,
                    currency: "aud",
                    quantity: 1
                }
            ],
            payment_intent_data: {
                metadata: {
                    user_id: current_user.id,
                    plant_id: @plant.id
                }
            },
            success_url: "#{root_url}payment/success?userId=#{current_user.id}&plantId=#{@plant.id}",
            cancel_url: "#{root_url}plant/#{@plant.id}"
        )

        @session_id = session.id
        @public_key = Rails.application.credentials.dig(:stripe, :public_key)
  end

  # GET /plants/new
  def new
    @plant = Plant.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants
  # POST /plants.json
  def create
    @plant = Plant.new(plant_params)

    respond_to do |format|
      if @plant.save
        format.html { redirect_to @plant, notice: 'You have created a new Swap!' }
        format.json { render :show, status: :created, location: @plant }
      else
        format.html { render :new }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plants/1
  # PATCH/PUT /plants/1.json
  def update
    respond_to do |format|
      if @plant.update(plant_params)
        format.html { redirect_to @plant, notice: 'Your Swap whas been updated!' }
        format.json { render :show, status: :ok, location: @plant }
      else
        format.html { render :edit }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1
  # DELETE /plants/1.json
  def destroy
    @plant.destroy
    respond_to do |format|
      format.html { redirect_to plants_url, notice: 'Your Swap was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant
      @plant = Plant.find(params[:id])
    end

# -- WHITE LISTING SECTION -- 
    
    # ADD support for AWS S3  for photo storage -- active storage is already installed and just needs config. 
    # UPDATE permit to include image from AWS

    # Set :sold to FALSE perma -- mutatable


    def plant_params
      params.require(:plant).permit(:name, :proper_name, :price, :description, :plant_type, :sold, :picture)
    end

    def set_user_plant
      @plant = current_user.plants.find_by_id(params[:id])

      if @plant == nil
          redirect_to plants_path
      end
  end
end
