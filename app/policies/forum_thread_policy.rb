class ForumThreadPolicy < ApplicationPolicy


  #apakah boleh di edit, true berarti boleh false tidak boleh 
  def edit?
    #false

    #untuk mengecek bahwa user yang sedang login adalah user yang membuat thread 
    #apakah objek user user dari id yg login jika iya dia akan mengembalikan true jika tidak akan mengembalikan false           
    #dan hanya user level  admin yg bisa ngedit dan update semua thread
    user.id == record.user.id || user.admin?
  end  

  def update?
    user.id == record.user.id || user.admin?
  end

  def destroy?
    #hanya user admin yg boleh hapus semua thread
    user.admin?
  end
   
end
