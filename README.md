# Mortal-Kombat [visit](https://mkombat.herokuapp.com/)

This is a small Ruby On Rails application, simulating the famous Mortal Kombat game

# How does it work ?

## Landing page [view](https://mkombat.herokuapp.com/)

In the landing page, the user can access
- The fighters crud
- The weapons crud
- Fights history
- The arena

## The fighters page [view](https://mkombat.herokuapp.com/fighters)
Here is implemented a full crud for the fighters, creation, listing and modification
The fighter's attributes are his **name** and his **alias**
The listing contains each fighter experience based on his wins

## The weapons page [view](https://mkombat.herokuapp.com/weapons)
Here is implemented a full crud for the weapons, creation, listing and modification
The weapon's attributes are its **name**, its **damage level** *(the value that will be substracted from the enemy's score if this weapon is used)* , and its **alias**

## Fights history [view](https://mkombat.herokuapp.com/fights)
In this page, the user will find a list of the previous fights. He can view a fight log, and he can delete it also.

## The arena [view](https://mkombat.herokuapp.com/prepare)
This is the most important part of the application
In this page, the user choses the two fighters, and assign one or many weapons for each of them *(by default, every fighter have a shield, its use is based on a random boolean value)*
When he's done, the "start fight" button appears.
Based on the user's choices, a small algorithm will be executed to simulate the fight *(the "arena" action under the FrontController)*, trace every move, verify every time if one of the fighters is dead, then the algorithm returns the result to the view

# Technical specifications
## Models
### _Fighters
#### ____name
#### ____photo
#### ____experience

### _Weapons
#### ____name
#### ____photo
#### ____damage_level

### _Fights
#### ____winner
#### ____loser
#### ____winner_score
#### ____loser_score
#### ____log

### _Photo
#### ____url

## Other
#### The app is deployed in [Heroku](https://heroku.com/)
#### The photos are stored in [Cloudinary](https://cloudinary.com/)
