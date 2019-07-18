require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class PostsController < ApplicationController
  def index
    @markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      # if its current we need to make all other posts not current
      if @post.is_featured
        Post.all.each do |p|
          if p.id != @post.id
            p.is_featured = 0
            p.save
          end
        end
      end

      flash[:succ] = "Post Created"
      redirect_to @post
    else
      render '/posts/new'
    end
  end

  def show
    @markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      flash[:succ] = "Post updated successfully"
    else
      flash[:notice] = "Error, post not updated"
    end
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:succ] = "Post deleted"
    redirect_to posts_path
  end

  def make_not_hidden # make visible/make not hidden
    @post = Post.find(params[:id])
    @post.is_hidden = false
    @post.save
    flash[:succ] = "Post is now visible"
    redirect_to "/dashboard/manage_posts"
  end

  def make_hidden
    @post = Post.find(params[:id])
    @post.is_hidden = true
    @post.save
    flash[:succ] = "Post is now hidden"
    redirect_to "/dashboard/manage_posts"
  end

  def make_featured
    # need to make all other problems not current
    Post.all.each do |p|
      p.is_featured = 0
      if p.save
      else
        flash[:notice] = "Error making resetting other featured posts to 0"
      end
    end
    @post = Post.find(params[:id])
    @post.is_featured = true
    if @post.save
      flash[:succ] = "Post is now featured"
    else
      flash[:notice] = "Error making post featured"
    end
    redirect_to "/dashboard/manage_posts"
  end

  def make_not_featured
    @post = Post.find(params[:id])
    @post.is_featured = false
    @post.save
    flash[:succ] = "Post is now not featured"
    redirect_to "/dashboard/manage_problems"
  end

  def md_arguments
    {
      autolink: true,
      tables: true,
      autolink: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true
    }
  end

  def post_params
    params.require(:post).permit(:title, :tag_line, :body, :is_featured, :is_hidden)
  end
end
