class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]


    def success
        plant_id = params[:plantId]
        p params
        Plant.find(plant_id).update(sold: true)
    end

    def webhook
        p "****************"
        p params
    end

end