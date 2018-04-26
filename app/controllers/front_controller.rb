class FrontController < ApplicationController
  
  def index
  end

  def arena
  	@fighters = Fighter.all
  	@weapons = Weapon.all
  end

end
