module ExpCalcul

  def calcul_getexp(exp, kill)
  level_data = [
    [68, 1],
    [369, 2],
    [1168, 3],
    [2884, 4],
    [6038, 5],
    [11287, 6],
    [19423, 7],
    [31378, 8],
    [48229, 9],
    [71202, 10],
    [101677, 11],
    [141193, 12],
    [191454, 13],
    [254330, 14],
    [331867, 15],
    [426288, 16],
    [540000, 17],
    [675596, 18],
    [835862, 19],
    [920357, 20],
    [1015431, 21],
    [1123336, 22],
    [1246808, 23],
    [1389235, 24],
    [1554904, 25],
    [1749413, 26],
    [1980499, 27],
    [2260321, 28],
    [2634751, 29],
    [2844287, 30],
    [3093068, 31],
    [3389496, 32],
    [3744042, 33],
  ]
    level_data.each_with_index do |data, i|
      if exp <= data[0]
        previous_exp = i > 0 ? level_data[i - 1][0] : 0
        current_exp = data[0]
        progress = (exp - previous_exp).to_f / (current_exp - previous_exp) * 100
        if kill == false
          return [i + 1, progress]
        elsif kill == true
          procent = 4
          cuts_progress = progress - procent 

          if cuts_progress < 0 
            previous_level = i > 0 ? i : 1
            if previous_level  > 1
              preprelvlexp = level_data[i - 2][0]
            else
              preprelvlexp = 0
            end
            explvl =  previous_exp - preprelvlexp
            cutprog = 100 + cuts_progress

            remaining_exp = (explvl * cutprog / 100).round
            remaining_exp += preprelvlexp
            if i == 0
              cutprog = progress
              remaining_exp = exp
            end
            return [previous_level, cutprog, remaining_exp]
          else
            remaining_exp = ((current_exp - previous_exp) * cuts_progress / 100).round
            remaining_exp += previous_exp
            return [i + 1, cuts_progress, remaining_exp]
          end
        end
          


      
      end
    end


  nil # Experience exceeds maximum level 
  end
 
end