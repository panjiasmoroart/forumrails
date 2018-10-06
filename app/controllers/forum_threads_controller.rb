class ForumThreadsController < ApplicationController
  
  #agar user yg sudah login yg bisa membuat thread 
  before_action :authenticate_user!, only: [:new, :create]  

  def index
    #/?search=belajar   (contoh misalkan kita mempunyai params search dan valuenya ada belajar)
    #apakah ada params search 
    if params[:search]
      @threads = ForumThread.where('title like ?', "%#{params[:search]}%").order(id: :desc).paginate(per_page: 5, page: params[:page])
    else
      #@threads = ForumThread.all
      #urutkan dulu berdasarkan stiknya secara asc baru berdasarkan id secara desc
      @threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
      #render plain: @threads.inspect    
    end
    
  end

  def show
    #sebelum menggunakan slug 
    #@thread = ForumThread.find(params[:id])
    #sesudah menggunakan 
    #hasilnya object bukan collection
    @thread = ForumThread.friendly.find(params[:id]) 
    #render plain: @thread.inspect
    #buat create post pada detail thread 

    @post = ForumPost.new

    #buat menerapakan pagination kita ubah @thread.forum_posts dari view ke controller kemudian kita tampung kedalam variabel $posts 
    @posts = @thread.forum_posts.paginate(per_page: 3, page: params[:page])
  end

  def new
    #buat form di view dengan nama new
    @thread = ForumThread.new
  end

  def create
    #render plain: params.inspect
    @thread = ForumThread.new(resources_params)
    #hardcord dulu buat usernya
    #@thread.user = User.first

    #create thread berdasarkan user yg sedang login
    @thread.user = current_user

    if @thread.save
      redirect_to root_path
    else
      #kita debugging lagi
      #puts @thread.errors.full_messages

      #tampilkan kembali halaman form untuk menampilkan pesan error 
      render 'new'
    end  
  end

  def edit 
    @thread = ForumThread.friendly.find(params[:id]) 
    #render plain: @thread.inspect

    #buat pundit, secara ajaib jika kita memanggil authorize @thread seperti ini maka si pundit akan tahun bahwa @thread adalah objek dari class ForumThread 
    #berarti dia akan mencari policy dengan nama Forumthreadpolicy dan dia juga akan otomatis mencari method edit? pada Forumthreadpolicy  
    authorize @thread 
  end

  def update 
    @thread = ForumThread.friendly.find(params[:id]) 
    authorize @thread 
    
    if @thread.update(resources_params)
      #redire kehalaman detail
      redirect_to forum_thread_path(@thread)
    else
      render 'new'
    end    
  end

  def destroy
    @thread = ForumThread.friendly.find(params[:id]) 
    #render plain: @thread.inspect
    authorize @thread

    @thread.destroy 

    redirect_to root_path, notice: 'Thread berhasil dihapus'
  end

  def pinit
   @thread = ForumThread.friendly.find(params[:id]) 
   #ketika sebuah request memanggil method atau action pinit maka dia akan di pint atau sticky
   @thread.pinit!
   redirect_to root_path
  end

  private

  def resources_params
    params.require(:forum_thread).permit(:title, :content) 
  end

end
