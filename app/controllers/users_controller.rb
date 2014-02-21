class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # @user = User.find(params[:id]) esta linea se ejecuta en set_user
    if @user.nil?
      flash[:error] = "Usuario no encontrado"
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Legal Consulting Online"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    flash[:success] = "User " + @user.name + " deleted."
    @user.destroy    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue Exception => e
        @user = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      if !signed_in?
        store_location
        flash[:notice] = "Please sign in to perform this action." 
        redirect_to signin_url
      end
    end

    def correct_user
      unless current_user?(@user)
        flash[:notice] = "You're not allow to do that"
        redirect_to(root_url)
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
