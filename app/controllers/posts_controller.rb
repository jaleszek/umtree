# coding: utf-8

class PostsController < ApplicationController
  # username taken validation, ajax
  def validate
    @error_out={}
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    email=params[:username]
    
    user=User.find_by_email(email)
    if user.nil?
      @error_out[:taken]=false
    else
      @error_out[:taken]=true
    end    
    if !email.nil?
      if email.size()>6
        @error_out[:size]=true
      else
        @error_out[:size]=false
      end
    else
      @error_out[:size]=true
    end
    if email =~ email_regex
      @error_out[:format]=true
    else
      @error_out[:format]=false
    end
    
    render :partial=>'validation_message'

  end

  def new
    @title="Nowe ogloszenie"
    @post = Post.new    
    @preview =UploadPreview.new(:post_ident=>@post.getIdent)
    @post.build_location
    @categories=Category.all
    @categories_label = Category.findCategory

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
    @post.category_id=params[:category][:id]
    logger.debug("controllercreate #{ident_}")
    @post.terms=params[:terms][:accept]
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
    @support = Support.new(:id=>1)
    @post = Post.find(params[:id])
    store_location
    respond_to do |format|
      format.html  
    end
  end
 
  def index

    #fields
    keyword=params[:keyword]
    price_right=params[:price_right]
    price_left=params[:price_left]
    categories_ids=params[:categoriesids]

    #convert to array
    categories_ids_array=categories_ids.scan(/\d+/) if !categories_ids.nil?

    #flags
    one_word=params[:one_word]
    keyword_in_title=params[:key_word_in_title]
    keyword_in_content=params[:key_word_in_content]
    case_sensitive=params[:case_sensitive]
    photo_added=params[:photo_added]
    own_deliv=params[:own_deliv]
    params_out={}

    #title, content
    if keyword_in_title=='1' and keyword_in_content.nil?
      if one_word=='1'
        params_out[:title_equals]=keyword.to_s
      else
        params_out[:title_contains]=keyword.to_s
      end
    elsif keyword_in_content=='1' and keyword_in_title.nil?
      if one_word=='1'
        params_out[:content_equals]=keyword.to_s
      else
        params_out[:content_contains]=keyword.to_s
      end
    elsif keyword_in_content.nil? and keyword_in_title.nil?
      if one_word=='1'
        params_out[:content_or_title_equals]=keyword.to_s
      else
        params_out[:content_or_title_contains]=keyword.to_s
      end
    end
    
    #price
    if price_left.to_i<=0 and price_right.to_i<=0
      flash={:error=>'incorrect price range'}
    else
      params_out[:price_gte]=price_left.to_i
      params_out[:price_lte]=price_right.to_i
    end

    #photo attachment
    if photo_added
      params_out[:upload_previews_img_file_name_is_not_null]='1'
    end
    #category id
    params_out[:category_id_in]=categories_ids_array

    logger.debug"paramsarray #{params_out}"

    @search=Post.search(params_out)
    logger.debug("@search rowna sie #{@search.all}")
    @posts=@search.paginate(:page=>params[:page], :per_page=>10)
  end
end
