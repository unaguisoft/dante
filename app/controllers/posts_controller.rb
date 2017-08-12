class PostsController < ApplicationController

  before_action :only_authorize_admin!
  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /admin/posts
  def index
    @posts = Post.all.page(params[:page])
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'El post se ha creado con éxito'
    else
      flash[:error] = 'Ha ocurrido un error al crear el post'
      render :new
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PUT /posts/:id
  def update
    @post.body =
    if @post.update(post_params)
      redirect_to posts_path, notice: 'El post ha sido actualizado correctamente'
    else
      flash[:error] = 'Ha ocurrido un error al actualizar el post'
      render :edit
    end
  end

  # DELETE /posts/:id
  def destroy
    if @post.destroy
      flash[:notice] = 'El post ha sido eliminado exitosamente'
    else
      flash[:error] = 'El post no ha podido ser eliminado'
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :subtitle, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
