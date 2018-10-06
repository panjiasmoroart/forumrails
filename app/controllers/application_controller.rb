class ApplicationController < ActionController::Base
  #cara memanggil pundit
  include Pundit
  #menangani pesan error
  #http://localhost:3000/forum_threads/2/edit
  rescue_from Pundit::NotAuthorizedError, with: :pundit_error

  #setelah kita menambahkan form name pada registration,  buat callback di before_action 
  #:configure_permitted_parameters akan dijalankan jika controller yg kita akses adalah controller yg dibuat oleh devise bukan controller yg kita buat sendiri
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  #menampilkan pesan error jika user tidak memiliki hak akses 
  def pundit_error 
    flash[:notice] = 'Tidak memiliki hak akses'
    redirect_to root_path
  end
  
  def configure_permitted_parameters
    #karena disini penambahan name pada saat sign_up maka yg di permit adalah sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
