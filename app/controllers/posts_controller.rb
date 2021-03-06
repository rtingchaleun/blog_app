# require 'elasticsearch/model'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_session_params, only: [:index]
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks


  # GET /posts
  # GET /posts.json
  def index
    console
    @users = User.all
    @categories = Category.all
    @posts = Post.all.order("created_at DESC")

    if params[:q].present?
      @posts = @posts.where('title LIKE ?', "%" + params[:q] + "%").or(@posts.where('body LIKE ?', "%" + params[:q] + "%"))
    end

    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @posts = @posts.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def my_posts
    @posts = Post.where(user_id: current_user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
   def show
     console
    @post.update(views: @post.views + 1)
  end

  # GET /posts/new
  def new
    console
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "'#{@post.title}' was created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "'#{@post.title}' was updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "'#{@post.title}' was deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_session_params
      session[:q] = params[:q]
      session[:category] = params[:category]
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :banner, :category_id)
    end

    # Only allow json on search action
    # def force_json
    #   request.format = :json
    # end
end

# Post.import
