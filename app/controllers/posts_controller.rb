class PostsController < ApplicationController
  before_filter :authenticate, :except => [:index,:show]

  # GET /posts
  # GET /posts.xml
  def index
    @page = (params[:page] || "1").to_i
    @tag = params[:tag]

    options = { :order => 'posts.created_at DESC, posts.id DESC',
    	     	:offset => (@page - 1) * PostsHelper::PostsPerPage,
    	     	:limit => PostsHelper::PostsPerPage, :readonly => true }
    if(@tag)
      @posts = Post.tagged_with(@tag, options)
    else
      @posts = Post.all(options)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.atom # index.atom.builder
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @title = @post.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    tags = params[:tag_list]
    params[:tag_list] = nil
    @post = Post.new(params[:post])
    @post.tag_with tags if tags

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    tags = params[:tag_list]
    params[:tag_list] = nil
    @post = Post.find(params[:id])
    @post.tag_with tags if tags

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == ENV["BLOG_PASSWORD"]
    end
  end
end
