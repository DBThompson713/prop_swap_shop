class PagesController < ApplicationController
    def home
        @plants = Plant.where(sold: false)
    end


end