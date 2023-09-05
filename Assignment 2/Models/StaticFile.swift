/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

//enum state for each screen
enum Page {
    case menuPage
    case gameContinuePage
    case gamePage
    case gameLevelPage
    case leaderboardPage
    case howToPlayPage
    case profilePage
    case switchUser
}


//Using for How to Play View
let intro = """
------------- DARKFALL ------------------

    The player “Darkfall” will be the adventurer, exploring dungeon. There will be 3 type of dungeons, easy, medium, and hard, and player’s mission is to defeat the monster along the dungeon. The game will be harder when level is up. Thus, enjoy and have fun with “Darkfall”
"""

let turns = """
At the start of a match, you draw three cards. To play cards you have to spend mana, and each player only has a set amount each turn.

"""

let battle_field = """
The battlefield is 4x4, each square contains a monster card to play
"""

let card = """
    A character card has:
    •    Attack
    •    HP
    •    Direction
    •    Skill/Mana
"""

let attack = """
The character attacks when it is playing next to another monster and the directions of the monster is point at that monster. The monster can re-attack if a new monster play to it direction.
"""

let goal = """
    The goal is to use the power of each of your characters on the field to deal damage to an opponent's health points. Each player starts with 15 health points and when that’s reduced to zero, they lose.
"""
