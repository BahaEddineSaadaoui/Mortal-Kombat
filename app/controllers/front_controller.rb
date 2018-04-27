class FrontController < ApplicationController

  def index
  end

  def prepare
    @fighters = Fighter.all
    @weapons = Weapon.all
  end

  # Fight algorithm
  def arena
    # Setting the fighters
    f_one = Fighter.find(params["fighter-one"])
    f_two = Fighter.find(params["fighter-two"])
    w_one = []
    w_two = []
    # Setting each fighter's weapons
    params["weapons-one"].split("").each do |w|
      w_one << Weapon.find(w)
    end
    params["weapons-one"].split("").each do |w|
      w_two << Weapon.find(w)
    end

    first_fighter = {:id => 1, :fighter => f_one, :weapons => w_one, :lifes => 100, :log => "" }
    second_fighter = {:id => 2, :fighter => f_two, :weapons => w_two, :lifes => 100, :log => "" }

    # Starting the fight, looping randomly until one of the fighters score become <= 0
    loop do
      # chances that the enemy will use his shield
      shield_used = [true, false, false, false, true, false, false]
      # chances that the beater's experience will be considered
      experience_considered = [true, false, false, false, true]
      # chosing randomly who's gonna be the first to beat during this loop
      # beater is the first to make a move
      # beaten will be attacked, there's a chance that he will be using his shield
      if [1,1,2,1,2,2,1,2].sample == 1
        beater = first_fighter
        beaten = second_fighter
      else
        beater = second_fighter
        beaten = first_fighter
      end
      beater[:log] += "#{beater[:fighter].name} is attacking,<br>"
      beaten[:log] += "<br>"
      # in case the beater ain't got weapons
      if beater[:weapons].blank?
        beater[:log] += " and is out of weapons<br>"
        beaten[:log] += "<br>"
        # he will be attacking using an ordinary hit
        # such us a punch or a kick
        # setting a random hit damage
        hit_damage = [5, 10, 15, 20].sample
        # will the enemy use his shield? deciding randomly
        # if yes
        if shield_used.sample
          beater[:log] += "<br>"
          beaten[:log] += "#{beaten[:fighter].name} is using his shield for protection<br>"
          # checkin wether the beater is stronger than the enemy
          # strength is measured by the count of wins
          # wich is a small method implemented in the Fighter model
          # in case the beater is more experienced than the enemy
          if beater[:fighter].is_stronger(beaten[:fighter])
            beater[:log] += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},<br>"
            beaten[:log] += "<br>"
            # deciding randomly if his strength will be taken into consideration
            # if yes
            if experience_considered.sample
              beater[:log] += " he hit #{beaten[:fighter].name}<br>"
              beaten[:log] += "<br>"
              # substract the hit damage from the enemy's lifes
              (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
              beaten[:log] += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
              beater[:log] += "<br>"
              # if the experience is ignored
            else
              beater[:log] += " he tried to attack but<br>"
              beaten[:log] += "<br>"
              beater[:log] += "<br>"
              beaten[:log] += " #{beaten[:fighter].name} avoided the attack with his shield<br>"
            end
          end
        # in case the enemy couldn't use his shield (the random value is false)
        else
          beater[:log] += "<br>"
          beaten[:log] += "#{beaten[:fighter].name} couldn't use his shield,<br>"
          beater[:log] += "#{beater[:fighter].name} hit #{beaten[:fighter].name}<br>"
          beaten[:log] += "<br>"
          # substract the hit damage from the enemy's lifes
          (beaten[:id] == 1) ? first_fighter[:lifes] -= hit_damage : second_fighter[:lifes] -= hit_damage
          beaten[:log] += "#{beaten[:fighter].name} lost #{hit_damage} points<br>"
          beater[:log] += "<br>"
        end
      # else if the beater still got weapons
      else
        beater[:log] += " and still have weapons<br>"
        beaten[:log] += "<br>"
        # chosing a random weapon to use (each weapon got its own damage value)
        weapon = beater[:weapons].sample
        beater[:log] += " he will use his #{weapon.name}<br>"
        beaten[:log] += "<br>"
        # in case the enemy will use his shield
        if shield_used.sample
          beaten[:log] += "#{beaten[:fighter].name} is using his shield for protection<br>"
          beater[:log] += "<br>"
          # checkin if the beater got more experience than the enemy
          if beater[:fighter].is_stronger(beaten[:fighter])
            beater[:log] += "#{beater[:fighter].name} is more experienced than #{beaten[:fighter].name},<br>"
            beaten[:log] += "<br>"
            # if his experience will be considered
            if experience_considered.sample
              beater[:log] += " #{beater[:fighter].name} attacked #{beaten[:fighter].name} with his #{weapon.name}<br>"
              beaten[:log] += "<br>"
              # substract the weapon's damage level from the enemy's lifes
              (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
              beaten[:log] += "#{beaten[:fighter].name} lost #{weapon.damage_level} points<br>"
              beater[:log] += "<br>"
              # remove the used weapon from the beater's weapon list
              beater[:weapons].delete(weapon)
            # if his experience is not considered
            else
              beater[:log] += " he tried to attack but<br>"
              beaten[:log] += "<br>"
              beaten[:log] += "#{beaten[:fighter].name} avoided the attack with his shield<br>"
              beater[:log] += "<br>"
            end
          end
        # else if the enemy couldn't use his shield
        else
          beaten[:log] += "#{beaten[:fighter].name} couldn't use his shield,<br>"
          beater[:log] += "<br>"
          # substract the weapon's damage level from the enemy's lifes
          (beaten[:id] == 1) ? first_fighter[:lifes] -= weapon.damage_level : second_fighter[:lifes] -= weapon.damage_level
          beaten[:log] += " he lost #{weapon.damage_level} points<br>"
          beater[:log] += "<br>"
          # remove the used weapon from the beater's weapon list
          beater[:weapons].delete(weapon)
        end
      end
      # after every loop, verifying if the fighers are still alive
      # checkin if the first fighter is alive
      # once dead, finalizing the fight
      if first_fighter[:lifes] <= 0
        first_fighter[:log] += "<p class='loser-label'>#{first_fighter[:fighter].name} lost the fight</p><br>"
        second_fighter[:log] += "<p class='winner-label'>#{second_fighter[:fighter].name} is the winner !</p><br>"
        @winner = second_fighter
        @loser = first_fighter
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
      # checkin if the second fighter is alive
      # once dead, finalizing the fight
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
