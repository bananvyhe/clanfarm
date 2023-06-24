module CpCalcul

  def calcul_cp(val)
    if ((current_user.cpoints - val.to_i) >= 0)
      current_user.cpoints -= val
      current_user.save
      return current_user.cpoints
    else 
      return false
    end
  end
 
end