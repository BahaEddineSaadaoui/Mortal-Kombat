class FrontController < ApplicationController

  def index
  end

  def prepare
    @fighters = Fighter.all
    @weapons = Weapon.all
  end

  def arena
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

    first_fighter = {:id => 1, :fighter => f_one, :weapons => w_one, :lifes => 100, :log => "" }
    second_fighter = {:id => 2, :fighter => f_two, :weapons => w_two, :lifes => 100, :log => "" }

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
      beater[:log] += "#{beater[:fighter].name} is attacking,<br>"
      beaten[:log] += "<br>"
      if beater[:weapons].blank?
        beater[:log] += " and is out of weapons<br>"
        beaten[:log] += "<br>"
        hit_damage = [5, 10, 15, 20].sample
        if shield_used.sample
          beater[:log] += "<br>"
          beaten[:log] += "#{beaten[:fighter].name} is using his shield for protection<br>"
          if beater[:fighter].is_stronger(beaten[:fighter])
            beater[:log] += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},<br>"
            beaten[:log] += "<br>"
            if experience_considered.sample
              beater[:log] += " he hit #{beaten[:fighter].name}<br>"
              beaten[:log] += "<br>"
              (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
              beaten[:log] += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
              beater[:log] += "<br>"
            else
              beater[:log] += " he tried to attack but<br>"
              beaten[:log] += "<br>"
              beater[:log] += "<br>"
              beaten[:log] += " #{beaten[:fighter].name} avoided the attack with his shield<br>"
            end
          end
        else
          beater[:log] += "<br>"
          beaten[:log] += "#{beaten[:fighter].name} couldn't use his shield,<br>"
          beater[:log] += "#{beater[:fighter].name} hit #{beaten[:fighter].name}<br>"
          beaten[:log] += "<br>"
          (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
          beaten[:log] += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
          beater[:log] += "<br>"
        end
      else
        beater[:log] += " and still have weapons<br>"
        beaten[:log] += "<br>"
        weapon = beater[:weapons].sample
        beater[:log] += " he will use his #{weapon.name}<br>"
        beaten[:log] += "<br>"
        if shield_used.sample
          beaten[:log] += "#{beaten[:fighter].name} is using his shield for protection<br>"
          beater[:log] += "<br>"
          if beater[:fighter].is_stronger(beaten[:fighter])
            beater[:log] += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},<br>"
            beaten[:log] += "<br>"
            if experience_considered.sample
              beater[:log] += " #{beater[:fighter].name} attacked #{beaten[:fighter].name} with his #{weapon.name}<br>"
              beaten[:log] += "<br>"
              (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
              beaten[:log] += "#{beaten[:fighter].name} lost #{weapon.damage_level} points<br>"
              beater[:log] += "<br>"
              beater[:weapons].delete(weapon)
            else
              beater[:log] += " he tried to attack but<br>"
              beaten[:log] += "<br>"
              beaten[:log] += "#{beaten[:fighter].name} avoided the attack with his shield<br>"
              beater[:log] += "<br>"
            end
          end
        else
          beaten[:log] += "#{beaten[:fighter].name} couldn't use his shield,<br>"
          beater[:log] += "<br>"
          (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
          beaten[:log] += " he lost #{weapon.damage_level} points<br>"
          beater[:log] += "<br>"
          beater[:weapons].delete(weapon)
        end
      end
      if first_fighter[:lifes] <= 0
        first_fighter[:log] += "<p class='loser-label'>#{first_fighter[:fighter].name} lost the fight</p><br>"
        second_fighter[:log] += "<p class='winner-label'>#{second_fighter[:fighter].name} is the winner !</p><br>"
        @winner = second_fighter
        @loser = first_fighter
        fight = Fight.new
        fight.winner_id = @winner[:fighter].id
        fight.loser_id = @loser[:fighter].id
        fight.log = "#{@winner[:log]}|#{@loser[:log]}"
        fight.save
        @winner[:fighter].experience += 1
        @winner[:fighter].save
        break
      elsif second_fighter[:lifes] <= 0
        second_fighter[:log] += "<p class='loser-label'>#{second_fighter[:fighter].name} lost the fight</p><br>"
        first_fighter[:log] += "<p class='winner-label'>#{first_fighter[:fighter].name} is the winner !</p><br>"
        @winner = first_fighter
        @loser = second_fighter
        fight = Fight.new
        fight.winner_id = @winner[:fighter].id
        fight.loser_id = @loser[:fighter].id
        fight.log = "#{@winner[:log]}|#{@loser[:log]}"
        fight.winner_score = 100 - @loser[:lifes]
        fight.loser_score = 100 - @winner[:lifes]
        fight.save
        @winner[:fighter].experience += 1
        @winner[:fighter].save
        break
      end
    end

  end

end
