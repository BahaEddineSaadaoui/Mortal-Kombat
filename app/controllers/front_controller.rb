class FrontController < ApplicationController

  def index
  end

  def prepare
    @fighters = Fighter.all
    @weapons = Weapon.all
  end

  def arena
    @log = ""
    f_one = Fighter.find(params["fighter-one"])
    f_two = Fighter.find(params["fighter-two"])
    w_one = []
    w_two = []
    params["weapons-one"].split("").each do |w|
      w_one << Weapon.find(w)
    end
    params["weapons-one"].split("").each do |w|
      w_two << Weapon.find(w)
    end

    first_fighter = {:id => 1, :fighter => f_one, :weapons => w_one, :lifes => 100 }
    second_fighter = {:id => 2, :fighter => f_two, :weapons => w_two, :lifes => 100 }

    loop do
      shield_used = [true, false, false, false, true, false, false]
      experience_considered = [true, false, false, false, true]
      if [1,1,2,1,2,2,1,2].sample == 1
        beater = first_fighter
        beaten = second_fighter
      else
        beater = second_fighter
        beaten = first_fighter
      end
      @log += "#{beater[:fighter].name} is attacking,"
      if beater[:weapons].blank?
        @log += " and is out of weapons<br>"
        hit_damage = [5, 10, 15, 20].sample
        if shield_used.sample
          @log += "#{beaten[:fighter].name} is using his shield for protection<br>"
          if beater[:fighter].is_stronger(beaten[:fighter])
            @log += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},"
            if experience_considered.sample
              @log += " he hit #{beaten[:fighter].name}<br>"
              (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
              @log += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
            else
              @log += " he tried to attack but"
              @log += " #{beaten[:fighter].name} avoided the attack with his shield<br>"
            end
          end
        else
          @log += "#{beaten[:fighter].name} couldn't use his shield,"
          @log += "#{beater[:fighter].name} hit #{beaten[:fighter].name}<br>"
          (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
          @log += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
        end
      else
        @log += " and still have weapons"
        weapon = beater[:weapons].sample
        @log += " he will use his #{weapon.name}<br>"
        if shield_used.sample
          @log += "#{beaten[:fighter].name} is using his shield for protection<br>"
          if beater[:fighter].is_stronger(beaten[:fighter])
            @log += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},"
            if experience_considered.sample
              @log += " #{beater[:fighter].name} attacked #{beaten[:fighter].name} with his #{weapon.name}<br>"
              (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
              @log += "#{beaten[:fighter].name} lost #{weapon.damage_level} points<br>"
              beater[:weapons].delete(weapon)
            else
              @log += " he tried to attack but"
              @log += "#{beaten[:fighter].name} avoided the attack with his shield<br>"
            end
          end
        else
          @log += "#{beaten[:fighter].name} couldn't use his shield,"
          (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
          @log += " he lost #{weapon.damage_level} points<br>"
          beater[:weapons].delete(weapon)
        end
      end
      if first_fighter[:lifes] <= 0
        @log += "#{first_fighter[:fighter].name} lost the fight<br>"
        @log += "#{second_fighter[:fighter].name} is the winner !<br>"
        break
      elsif second_fighter[:lifes] <= 0
        @log += "#{second_fighter[:fighter].name} lost the fight<br>"
        @log += "#{first_fighter[:fighter].name} is the winner !<br>"
        break
      end
    end

  end

end
