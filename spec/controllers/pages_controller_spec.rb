require 'spec_helper'

describe PagesController do
render_views #defaultowo Rspec uruchamia tylko testy w kontrolerze, gwarantuje ze widok jest rzeczywiscie renderowany
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content=>"Sprzedaj stara")  
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content=>"Sprzedaj stara, Kontakt")
    end 
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content=>"Sprzedaj stara, Pomoc")
    end
  end

end
