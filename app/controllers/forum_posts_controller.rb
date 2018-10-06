class ForumPostsController < ApplicationController

  #agar user yg sudah login yg bisa membuat post
  before_action :authenticate_user!, only: [:create]  

  def create
    #cek kiriman dari form di console karena kita menggunakan puts 
    #puts params.inspect
    #@thread = ForumThread.find(params[:forum_thread_id])
    @thread = ForumThread.friendly.find(params[:forum_thread_id]) 
    #render plain: @thread.inspect
    @post = ForumPost.new(resources_params)

    @post.forum_thread = @thread 
    #untuk sementara kita hardcord dulu usernya harusnya berdasarkan user yg login
    #@post.user = User.first 
    
    #create post berdasarkan user yg sedang login 
    @post.user = current_user

    if @post.save 
      #redirect ke halaman detail thread 
      redirect_to forum_thread_path(@thread)  
    else
      render 'forum_threads/show'     
    end
  end


  private 

  def resources_params
    params.require(:forum_post).permit(:content)
  end

end 
