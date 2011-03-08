module ApplicationHelper
  def getCategories
    @categories = Category.all
    @categories_label = Category.findCategory
  end
  def title
    main_title = "Sprzedaj stara"
    if @title.nil?
      main_title
    else   
      "#{main_title}, #{@title}"   
    end
  end
  
  def newUser
    @user=User.new  
  end
end
