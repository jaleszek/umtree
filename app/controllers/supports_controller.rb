class SupportsController < ApplicationController

  def create
    @support = Support.new(params[:support])
    if @support.save
      flash[:error] = "Wiadomosc wyslano" 
    else
      flash[:error] = "Musisz uzupelnic wszystkie pola"
    end
     redirect_back_or :root
  end
end
