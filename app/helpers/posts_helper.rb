module PostsHelper
  
  def getCategories
    @categories=Category.all
    @categories_label = Category.find_by_sql("select*from Categories where parent_id=22")
  end
end