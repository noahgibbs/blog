class PostsController < ApplicationController
  before_filter :authenticate, :except => [:index,:show]

  FindOpts = { :order => 'posts.created_at DESC, posts.id DESC',
    	     	:readonly => true }

  # GET /posts
  # GET /posts.xml
  def index
    @page = (params[:page] || "1").to_i
    @tag = params[:tag]
    @keywords = Tag.find(:all).map { |t| t.name }

    options = FindOpts.merge({
			:page => @page, :tag => @tag,
			:total_entries => Post.tag_counter(@tag),
			:finder => :tag_finder,
			:per_page => PostsHelper::PostsPerPage
			})

    @posts = Post.paginate(options)

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
    @keywords = @post.tag_list.split

    nextOpts = FindOpts.merge({ :conditions => [ "id > ?", @post.id ] })
    prevOpts = FindOpts.merge({ :conditions => [ "id < ?", @post.id ] })

    @nextpost = Post.find(:last, nextOpts)
    @prevpost = Post.find(:first, prevOpts)

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
