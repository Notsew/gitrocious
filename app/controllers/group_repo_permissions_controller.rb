class GroupRepoPermissionsController < ApplicationController
  before_action :is_logged_in?
  before_action :set_group_repo_permission, only: [:show, :edit, :update, :destroy]

  # GET /group_repo_permissions
  # GET /group_repo_permissions.json
  def index
    @group_repo_permissions = GroupRepoPermission.all
  end

  # GET /group_repo_permissions/1
  # GET /group_repo_permissions/1.json
  def show
  end

  # GET /group_repo_permissions/new
  def new
    @group_repo_permission = GroupRepoPermission.new
  end

  # GET /group_repo_permissions/1/edit
  def edit
  end

  # POST /group_repo_permissions
  # POST /group_repo_permissions.json
  def create
    @group_repo_permission = GroupRepoPermission.new(group_repo_permission_params)

    respond_to do |format|
      if @group_repo_permission.save
        format.html { redirect_to @group_repo_permission, notice: 'Group repo permission was successfully created.' }
        format.json { render :show, status: :created, location: @group_repo_permission }
      else
        format.html { render :new }
        format.json { render json: @group_repo_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_repo_permissions/1
  # PATCH/PUT /group_repo_permissions/1.json
  def update
    respond_to do |format|
      if @group_repo_permission.update(group_repo_permission_params)
        format.html { redirect_to @group_repo_permission, notice: 'Group repo permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_repo_permission }
      else
        format.html { render :edit }
        format.json { render json: @group_repo_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_repo_permissions/1
  # DELETE /group_repo_permissions/1.json
  def destroy
    @group_repo_permission.destroy
    respond_to do |format|
      format.html { redirect_to group_repo_permissions_url, notice: 'Group repo permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_repo_permission
      @group_repo_permission = GroupRepoPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_repo_permission_params
      params.require(:group_repo_permission).permit(:branch, :group_id, :repo_id)
    end
end
