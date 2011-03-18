class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if simple_captcha_valid?  
      if @user.save
        Confirmation.send_confirmation(@user).deliver
        redirect_to(@user, :notice => 'Utworzono konto uzytkownika')
      else
        flash[:error]='Wystapil blad podczas rejestracji. Powtorz czynnosc'
        redirect_back_or :root
      end
    else
      flash[:error]='Nie poprawnie wprowadzony kod autoryzacji'
      redirect_back_or :root
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def validate_registration
    @error_out={}
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    email=params[:email]
    
    user=User.find_by_email(email)
    if user.nil?
      @error_out[:taken]=false
    else
      @error_out[:taken]=true
    end    

    if email.size()>6
      @error_out[:size]=true
    else
      @error_out[:size]=false
    end
    
    if email =~ email_regex
      @error_out[:format]=true
    else
      @error_out[:format]=false
    end
    
    render :partial=>'email_validation_message'

  end
private

  def authenticate
    deny_access unless signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
