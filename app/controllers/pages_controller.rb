class PagesController < ApplicationController
  def home
    @title="Sprzedaj stara"
  end

  def contact
    @title="Sprzedaj stara, Kontakt"
  end

  def help
    @title="Sprzedaj stara, Pomoc"
  end

end
