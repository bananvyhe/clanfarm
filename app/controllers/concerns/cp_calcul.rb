module CpCalcul

  def calcul_cp(val)
    if ((current_user.avcpoints - val.to_i) >= 0)
      current_user.avcpoints -= val
      current_user.save
      return current_user.avcpoints
    else 
      return false
    end
  end
 
end