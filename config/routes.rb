Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  # mengarah ke controller forum_threads_controller action index
  #root "home#index"
  root "forum_threads#index"

  resources :forum_threads, only: [:index, :show, :new, :create, :edit, :update, :destroy] do 
    #karena namanya tidak standar custom name action yaitu pinit kita perlu membuat route khusus
    #karena kita ingin mengupdate maka kita gunakan put :namaaction dan on: :member ini artinya berlaku untuk suatu data tertentu karena kita ingin mengupdate 1 pint atau
    #biasanya on: :member ini digunakan pada edit,update,delete intinya yg berkaitan dengan id
    #selain on: :member ada juga on: :collection biasanya digunakan kalo kita ingin membuat action post baru
    put :pinit, on: :member

    resources :forum_posts, only: [:create]
  end
  
  #untuk post kita tidak menggunakan resources seperti ini. karena pada detail thread kita juga akan mengiirim id dari thread untuk disimpan dipost
  #kita akan menggunakan cara nested resources atau resources di dalam resources agar id terkirim secara otomatis
  #resources :forum_posts, only: [:create]

end
