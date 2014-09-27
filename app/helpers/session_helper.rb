module SessionHelper
  
  def signedin_user? user
    user == current_user
  end
  
end
