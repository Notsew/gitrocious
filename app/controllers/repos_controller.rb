class ReposController < ApplicationController
  before_action :is_logged_in?, except:[:index,:show, :download]
  before_action :set_repo, only: [:show, :edit, :update, :destroy]

  # GET /repos
  # GET /repos.json
  def index
    @repos = Repo.all
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
  end

  # GET /repos/new
  def new
    @repo = Repo.new
  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos
  # POST /repos.json
  def create
    @repo = Repo.new(repo_params)

    respond_to do |format|
      if @repo.save
        format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @repo }
      else
        format.html { render :edit }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to repos_url, notice: 'Repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_branch
    @repo = Repo.find(params[:repo_id])
    branch = params[:branch]
    path = "#{@repo.path_to_repo}/#{branch}.zip"
    Dir.chdir("#{@repo.path_to_repo}") do 
      `git archive --format=zip -o #{branch}.zip #{branch}`
      send_file path, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@repo.name}_#{branch}.zip"
    end
  end

  def download_hook
    repo = Repo.find(params[:repo_id])
    hook = params[:hook]
    path = "#{repo.path_to_repo}/hooks/#{hook}"
    send_file path, :type => "application/text", :disposition => "attachment", :filename => "#{repo.name}_#{hook}_hook"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name, :user_ids => [], :group_ids => [])
    end
end
