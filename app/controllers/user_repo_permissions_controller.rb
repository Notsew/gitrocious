class UserRepoPermissionsController < ApplicationController
  before_action :set_user_repo_permission, only: [:show, :edit, :update, :destroy]

  # GET /user_repo_permissions
  # GET /user_repo_permissions.json
  def index
    @user_repo_permissions = UserRepoPermission.all
  end

  # GET /user_repo_permissions/1
  # GET /user_repo_permissions/1.json
  def show
  end

  # GET /user_repo_permissions/new
  def new
    @user_repo_permission = UserRepoPermission.new
  end

  # GET /user_repo_permissions/1/edit
  def edit
  end

  # POST /user_repo_permissions
  # POST /user_repo_permissions.json
  def create
    @user_repo_permission = UserRepoPermission.new(user_repo_permission_params)

    respond_to do |format|
      if @user_repo_permission.save
        format.html { redirect_to @user_repo_permission, notice: 'User repo permission was successfully created.' }
        format.json { render :show, status: :created, location: @user_repo_permission }
      else
        format.html { render :new }
        format.json { render json: @user_repo_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_repo_permissions/1
  # PATCH/PUT /user_repo_permissions/1.json
  def update
    respond_to do |format|
      if @user_repo_permission.update(user_repo_permission_params)
        format.html { redirect_to @user_repo_permission, notice: 'User repo permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_repo_permission }
      else
        format.html { render :edit }
        format.json { render json: @user_repo_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_repo_permissions/1
  # DELETE /user_repo_permissions/1.json
  def destroy
    @user_repo_permission.destroy
    respond_to do |format|
      format.html { redirect_to user_repo_permissions_url, notice: 'User repo permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_repo_permission
      @user_repo_permission = UserRepoPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_repo_permission_params
      params.require(:user_repo_permission).permit(:branch, :user_id, :repo_id)
    end
end
