class PostsController < ApplicationController
 def validate
   username=params[:username]
   user=User.find_by_email(username)
   if user.nil?
     message='free'
 else
   message='taken'
   end
  @message=message
    render :partial=>'message'
end

  def new
    @post = Post.new
    
    @preview =UploadPreview.new(:post_ident=>@post.getIdent)
    @post.build_location

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post}
    end
  end

  def create
    #params_temp=params[:post].clone
    #location_temp=params[:post][:location].clone
    #params_temp.delete(:location)
    #params_temp.merge!(:location_attributes=>location_temp)

    @post = Post.new(params[:post])
    
    content = @post.content
    ident_= params[:ident]
    @post.ident=ident_    
    logger.debug("controllercreate #{ident_}")
    #logger.debug "Post attribute#{@post.uploads}"

    respond_to do |format|
      if @post.save!
        format.html { redirect_to(@post, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @post, :status => :created }
     else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end


 def show
    @post = Post.find(params[:id])
      respond_to do |format|
       format.html  
   end
  end

end
