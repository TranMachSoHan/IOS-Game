https://jsoneditoronline.org/#left=cloud.008d7c276af54af4b5ae2e6d12318c86

ref: https://colorhunt.co/palette/f8efd4edc988d7385e132743

Currently: 
1. Character on click and add to cell 
-> Add to cell 
-> 
Todo:
1. Add attribute to the cell
-> attackedCell
-> Protected Shield
-> isDead 

2. For loop through cells, 
-> Cell with character bloodPoint higher -> keep 
-> Cells with character shieldPoint lower -> change to dead -> remove character 
-> .onChange(of: triggerFlashAnimation) { (val) in
                if val {
                    triggerAnimationActions()
                }
            }

3. Add transition to the characterCell .transition(AnyTransition.slide)

4. Update text Score, Status: .animation(.spring(response: 0.7, dampingFraction: 0.3))

5. Initalize Character with random value 

6. Newbie Level 1: 
- Bot and character 
- Bot attack is 5 
- The Boss have 5 mana
- 

	Newbie level 2: 
- Only have the upAttack 
- Bot attack is 5 
- The Boss have 10 mana

	Newbie level 3: 
- Introduce downAttack 
- 

6. 
Medium: 
	-> Have diagnol direction 

Difficulty: 
	-> Monster can move randomly 

6. Save progress https://stackoverflow.com/questions/56453857/how-to-save-existing-objects-to-core-data 

level1 -> introduce character and the mana 
	-> character badge

level2 -> Show the bot will damage you -> Put up arrow before the bot to destroy it -> each round -> level up mana 
	-> mana badge

level3 -> Introduce down arrow

level4 -> right and left attack 

level 5 -> 
	-> increase blood back to normal 20
	-> [2, 2, 2, 1, 1, 1, 1, 1, 1]

level 6 -> code generation -> increase mana for card 
[2, 2, 2, 1, 1, 1, 1, 1, 1]

level 7 -> code generation -> increase mana for card 
[2, 2, 2, 2, 1, 1, 1, 1, 1]

level 8 -> code generation -> increase mana for card 
[3, 3, 2, 2, 2, 1, 1, 1, 1]


7. medium 
 normal play , bot can attack 
till level 3 introduce diagnnal


8. hard 
random
random move
