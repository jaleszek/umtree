class UploadPreviewsController < ApplicationController
  # GET /upload_previews
  # GET /upload_previews.xml
  def index
    @upload_previews = UploadPreview.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @upload_previews }
    end
  end

  # GET /upload_previews/1
  # GET /upload_previews/1.xml
  def show
    @upload_preview = UploadPreview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload_preview }
    end
  end

  # GET /upload_previews/new
  # GET /upload_previews/new.xml
  def new
    @upload_preview = UploadPreview.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload_preview }
    end
  end

  # GET /upload_previews/1/edit
  def edit
    @upload_preview = UploadPreview.find(params[:id])
  end

  # POST /upload_previews
  # POST /upload_previews.xml
  def create
    @upload_preview = UploadPreview.new(params[:upload_preview])
    
    if @upload_preview.save
      render :json => {:img_path => @upload_preview.img.url.to_s,:id=>@upload_preview.id, 
      :name => @upload_preview.img.instance.attributes["img_file_name"]}, :content_type => 'text/html'  
    else
      render :json => {:result => 'error'}, :content_type => 'text/html'
    end
  end

  # PUT /upload_previews/1
  # PUT /upload_previews/1.xml
  def update
    @upload_preview = UploadPreview.find(params[:id])

    respond_to do |format|
      if @upload_preview.update_attributes(params[:upload_preview])
        format.html { redirect_to(@upload_preview, :notice => 'Upload preview was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload_preview.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_previews/1
  # DELETE /upload_previews/1.xml
  def destroy
    @upload_preview = UploadPreview.find(params[:id])
    @upload_preview.destroy

    respond_to do |format|
      format.html { redirect_to(upload_previews_url) }
      format.xml  { head :ok }
    end
  end

end
