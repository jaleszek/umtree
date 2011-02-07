class PostsController < ApplicationController
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post}
    end
  end

  def create
    @post = Post.new(params[:post])
    content = @post.content
    textile_obj = RedCloth.new(temp)
    html = textile_obj.to_html
    @post.content=html

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@post, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
