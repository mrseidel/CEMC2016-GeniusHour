import pygame #imports pygame for use
pygame.init() #initiates use of pygame
from random import randint
import math

textFont = pygame.font.SysFont("monospace", 20) #Sets font style to monospace at size 20

width = 800 #Size of game x
height = 600  #Size of game y
angurdsDisplay = pygame.display.set_mode((width, height)) #sets display screen width x height pixels
pygame.display.set_caption("Angurds") #names the program "Angurds"

icon = pygame.image.load("WarriorDown.png").convert_alpha() #Loads WarriorDown image as icon        
pygame.display.set_icon(icon) #Sets icon to the icon image

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
white = (255, 255, 255)
black = (0, 0, 0)

warriorUp = pygame.image.load("WarriorUp.png") #Loads Warrior up image
warriorDown = pygame.image.load("WarriorDown.png") #Loads Warrior Down image
warriorRight = pygame.image.load("WarriorRight.png") #Loads Warrior Right image
warriorLeft = pygame.image.load("WarriorLeft.png") #Loads Warrior Left image
xwarriorSize = 28 #Sets the warrior size X to 28
ywarriorSize = 32 #Sets the warrior size Y to 32
warriorRadius = 15 #Sets the warrior Range to 15

goblinRight= pygame.image.load("walking Right.png") #Loads the walking right image for goblin
goblinLeft = pygame.image.load("walking left.png") #Loads the walking left image for goblin
goblinUp = pygame.image.load("walking up.png") #Loads the walking up image for goblin
goblinDown = pygame.image.load("walking down.png") #Loads the walkind down for goblin
xgoblinSize = 60 #Sets goblin x size to 60
ygoblinSize = 60 #Sets goblin y size to 60
goblinRadius = 30 #Sets goblin range to 30

mapTypeOne = pygame.image.load("Map 1.png") #Loads map image background

downArrow = pygame.image.load("ArrowDown.png") #Loads arrow down image
upArrow = pygame.image.load("ArrowUp.png") #Loads arrow up image
leftArrow = pygame.image.load("ArrowLeft.png") #Loads arrow left image
rightArrow = pygame.image.load("ArrowRight.png") #Loads arrow right image

drugnaImage = pygame.image.load("Drugna.png") #Loads Drugna (final boss) image

frameRate = pygame.time.Clock() #initiates a time variable used to keep frame count

class Map():
    ''' Class holding the current map that the player is on
    '''
    def __init__(self):
        '''Default constructor
        '''        
        self.mapNumber = 0 
        self.mapLevel = 1
        self.canEnter = False
        
    def printMap(self):
        '''Prints the map display
        '''
        angurdsDisplay.blit(mapTypeOne, (0, 0)) #Loads the base grass background image
        if self.mapLevel == 1: 
            angurdsDisplay.blit(upArrow, (0, 0)) #Loads the arrow up on top of the background if the map level is 1, indicating which direction to go for the next level
        if self.mapLevel == 2:
            angurdsDisplay.blit(upArrow, (0, 0)) #Loads the arrow up again to indicate where to go for next level if current map is number 2
        if self.mapLevel == 3:
            angurdsDisplay.blit(rightArrow, (0, 0)) #Loads Right arrow if current map is level 3
        if self.mapLevel == 4:
            angurdsDisplay.blit(rightArrow, (0, 0))  #Loads right arrow if the map is 4
            textDisplay = textFont.render("Slay two goblins to proceed.", 1, white) #Sets a certain text to textDisplay if map is level 4
            angurdsDisplay.blit(textDisplay, (width/10, height/30))#Loads text display is map is level 4
        if self.mapLevel == 5:
            angurdsDisplay.blit(upArrow, (0, 0)) #Loads up arrow if level is 5
        if self.mapLevel == 6:
            angurdsDisplay.blit(leftArrow, (0, 0)) #Loads left arrow if the map is 6
            textDisplay = textFont.render("Slay four goblins to proceed.", 1, white) #Sets a certain text to textdisplay if map is 6
            angurdsDisplay.blit(textDisplay, (width/10, height/30)) #Displays textDisplay if map is level 6
        if self.mapLevel == 7:
            angurdsDisplay.blit(upArrow, (0, 0)) #Loads arrow up if map is level 7
        if self.mapLevel == 8:
            textDisplay = textFont.render("Final Boss: Defeat Drugna", 1, white) #sets a text to textDisplay if map is level 8
            angurdsDisplay.blit(textDisplay, (width/10, height/30)) #Displays textDisplay if map is level 8
            
    def mapScrolling(self, xheroPos, yheroPos):
        '''
        (x position of hero, y position of hero)
        
        Scrolls between different map levels
        '''
        self.mapExitSide = 0
        self.heroMoveBack = False
        if xheroPos <= 5: 
            self.mapExitSide = 3  #If statement used to reposition hero when he reaches an end of a screen if the screen has an exit side or not
        if (xheroPos + xwarriorSize) >= (width - 5):
            self.mapExitSide = 1  
        if yheroPos <= 5:
            self.mapExitSide = 4
        if (yheroPos + ywarriorSize) >= (height - 5):
            self.mapExitSide = 2
        if self.mapLevel == 1:
            if self.mapExitSide == 4:
                self.heroMoveBack = True
                self.mapLevel = 2
                self.canEnter = False
        elif self.mapLevel == 2:
            if self.mapExitSide == 4:
                self.heroMoveBack = True
                self.mapLevel = 3  
                self.canEnter = False
            if self.mapExitSide == 2:
                self.heroMoveBack = True
                self.mapLevel = 1
                self.canEnter = False
        elif self.mapLevel == 3:
            if self.mapExitSide == 2:
                self.heroMoveBack = True
                self.mapLevel = 2 
                self.canEnter = False
            if self.mapExitSide == 1:
                self.heroMoveBack = True
                self.mapLevel = 4
                self.canEnter = False
        elif self.mapLevel == 4:
            if self.mapExitSide == 1 and self.canEnter == True:
                self.heroMoveBack = True
                self.mapLevel = 5     
                self.canEnter = False   
        elif self.mapLevel == 5:
            if self.mapExitSide == 4:
                self.heroMoveBack = True
                self.mapLevel = 6     
                self.canEnter = False
        elif self.mapLevel == 6:
            if self.mapExitSide == 3 and self.canEnter == True:
                self.heroMoveBack = True
                self.mapLevel = 7     
                self.canEnter = False  
        elif self.mapLevel == 7:
            if self.mapExitSide == 4:
                self.heroMoveBack = True
                self.mapLevel = 8     
                self.canEnter = False   #Switches between maps which are indicated by number values when you exit the side of the screen
            
class Hero():
    ''' Hero class, class which player controls 
    '''
    def __init__(self):
        '''Default constructor
        '''
        self.x = width/2
        self.y = height - 50
        self.xspeed = 0
        self.yspeed = 0
        self.startingHealth = 150
        self.health = 150 
        self.distance = 0
        self.slashingDamage = 0
        self.isSlashing = False
        self.slashingRange = 75
        self.slashingCooldown = 0
        self.directionFacing = 4
        self.isAlive = True
        
    def displayHero(self):
        '''Displays the hero at its current (x, y) location
        '''       
        if self.directionFacing == 1:
            angurdsDisplay.blit(warriorRight, (self.x, self.y)) #loads character image
        if self.directionFacing == 2:
            angurdsDisplay.blit(warriorDown, (self.x, self.y)) #loads character image        
        if self.directionFacing == 3:
            angurdsDisplay.blit(warriorLeft, (self.x, self.y)) #loads character image  
        if self.directionFacing == 4:
            angurdsDisplay.blit(warriorUp, (self.x, self.y)) #loads character image
        pygame.draw.rect(angurdsDisplay, red, (self.x, self.y - 10, xwarriorSize, 7)) #loads red healthbar over hero
        pygame.draw.rect(angurdsDisplay, green, (self.x + 2, self.y - 8, xwarriorSize * (self.health/self.startingHealth) * .9 , 3)) #loads green health meter               
        
    def takeDamage(self, damageNumber, xlocation, ylocation, damageRange):
        '''Function called by other classes to deal damage to the hero
        '''
        self.distance = math.sqrt(math.pow(self.x - xlocation, 2) + math.pow(self.y - ylocation, 2)) #function to determine the range around the hero
        if self.distance <= damageRange:
            self.health -= damageNumber #Hero takes damage if he is within range of taking hits 
        if self.health <= 0:
            self.isAlive = False #Determines if hero lives or dies based on health being 0 or higher
        
    def slashing(self):
        '''Called by certain actions, preforms a slashing attack from Hero to deal damage
        '''
        if self.slashingCooldown == 0:
            self.slashingCooldown = 60 #Resets cooldown of slash attack if slash attack has timer has gone to 0
            self.slashingDamage = randint(15, 30) #Damage dealt by hero is determined by random value between 15 and 30
            self.isSlashing = True #Hero can attack
            
    def stopSlashing(self):
        '''stops the slashing attack and adds cooldown
        '''
        self.isSlashing = False 
        if self.slashingCooldown > 0:
            self.slashingCooldown -= 1 #Reduces cooldown of slash attack by one until it has reached 0        
        
    def moveHeroLeft(self):
        '''Moves character to the left
        '''        
        self.xspeed = -5 #Reduces xspeed value by 5 to make hero move left
        self.yspeed = 0
        self.directionFacing = 3 #Value used to load the left facing sprite when moving hero
        
    def moveHeroRight(self):
        '''Moves character to the right
        '''        
        self.xspeed = 5 #Increases value of xspeed by 5 to move hero right
        self.yspeed = 0 
        self.directionFacing = 1 #Loads right facing sprite when moving right
        
    def moveHeroDown(self):
        '''Moves character down
        '''        
        self.xspeed = 0
        self.yspeed = 5 #increases yspeed by 5 to make hero move down 
        self.directionFacing = 2 #Loads hero facing down sprite
        
    def moveHeroUp(self):
        '''Moves character up
        '''                
        self.xspeed = 0
        self.yspeed = -5 #Reduces yspeed by 5 to move hero up
        self.directionFacing = 4 #Loads facing up sprite of hero
    
    def stopMoving(self):
        '''Character stops all movment
        '''           
        self.yspeed = 0
        self.xspeed = 0
        
    def makeChanges(self):
        '''Adds all current speeds to the position of the hero
        '''           
        self.y += self.yspeed
        self.x += self.xspeed
        
    def checkEdges(self, exitingMap, exitDirection):
        '''Checks to see if the character is outside of the screen and returns them if so
        '''
        if self.x < 0 or self.x + xwarriorSize > width: #checks to see if hero reached edge of a screen to allow him to progress to another map or to hault movement
            self.x -= self.xspeed
        if self.y < 0 or self.y + ywarriorSize > height:
            self.y -= self.yspeed
        if exitingMap == True:
            if exitDirection == 1:
                self.x = 10 #Places hero at a new position in a new level if hero has exited another
            elif exitDirection == 2:
                self.y = 10
            elif exitDirection == 3:
                self.x = width - xwarriorSize - 10
            elif exitDirection == 4:
                self.y = height - ywarriorSize - 10
            

class Goblins():
    '''Class for goblins which try to attack and kill the hero
    '''    
    def __init__(self, xstartingPosition, ystartingPosition, speed, startingHealth):
        '''Default constructor
        '''
        self.x = xstartingPosition
        self.y = ystartingPosition
        self.speed = speed
        self.xspeed = 0
        self.yspeed = 0
        self.walkingTimer = 0
        self.randomDirection = 0
        self.health = startingHealth
        self.startingHealth = startingHealth
        self.damageToDeal = 0
        self.attackRandomizer = 0
        self.rangeOfAttack = 70
        self.didAttack = False
        self.didCollide = False
        self.isAggressive = False
        self.directionFacing = 1
        self.isAlive = True
        
    def displayGob(self):
        '''Displays the hero at its current (x, y) location
        '''        
        if self.directionFacing == 1:
            angurdsDisplay.blit(goblinRight, (self.x, self.y)) #loads goblin right sprite if facing right
        if self.directionFacing == 3:
            angurdsDisplay.blit(goblinLeft, (self.x, self.y)) #Loads goblin left sprite if facing left
        if self.directionFacing == 2:
            angurdsDisplay.blit(goblinDown, (self.x, self.y))  #Loads goblin down sprite if facing down
        if self.directionFacing == 4:
            angurdsDisplay.blit(goblinUp, (self.x, self.y)) #Loads goblin up sprite if facing up
        pygame.draw.rect(angurdsDisplay, red, (self.x, self.y - 10, xgoblinSize, 7)) #loads red healthbar over hero
        pygame.draw.rect(angurdsDisplay, green, (self.x + 1, self.y - 8, xgoblinSize * (self.health/self.startingHealth) * .94 , 3)) #loads green health meter 
        
    def takeDamage(self, damageNumber, xlocation, ylocation, damageRange):
        '''Function called by other classes to deal damage to the hero
        '''
        self.distance = math.sqrt(math.pow((self.x + xgoblinSize)  - (xlocation + xwarriorSize) , 2) + math.pow((self.y + ygoblinSize)  - (ylocation + ywarriorSize) , 2)) #Determines range around the goblin
        if self.distance <= damageRange:
            self.health -= damageNumber #Deals damage to hero if within range
        if self.health <= 0:
            self.isAlive = False #determines if goblin lives
        
    def attacking(self):
        '''Attacks the hero at random times
        '''             
        if self.attackRandomizer == 0: #if cooldown of attack has reached 0
            self.attackRandomizer = randint(200, 500) #sets a random cooldown for goblin to attack hero
            self.damageToDeal = randint(5, 15) #Damage goblin can deal (5 to 15 damage)
            self.didAttack = True
        else:
            self.attackRandomizer -= 1 #Reduces cooldown of goblin attack by 1
            self.didAttack = False
        
    def aggressive(self, xheroPos, yheroPos):
        '''Checks to see if character is a certain distance from hero, if so the character becomes aggressive
        '''
        self.distance = math.sqrt(math.pow((self.x + xgoblinSize)  - (xheroPos + xwarriorSize) , 2) + math.pow((self.y + ygoblinSize)  - (yheroPos + ywarriorSize) , 2))
        if self.distance < 200:
            self.isAggressive = True #Sets goblin to aggresive if within range of hero
        else:
            self.isAggressive = False
        
    def whatToMove(self, xheroPos, yheroPos):
        '''Determines what direction (if at all) to move in and how long
        '''    
        if self.didCollide == False:
            if self.isAggressive == False:           
                if self.walkingTimer == 0:
                    self.walkingTimer = randint(0, 240) #randon time value for walking, goblin.
                    self.randomDirection = randint(1, 100) #random value to determine which direction the goblin faces, 1 to 100
                    if self.randomDirection <= 15:
                        self.moveGobLeft()
                    elif self.randomDirection <= 30:
                        self.moveGobRight()
                    elif self.randomDirection <= 45:
                        self.moveGobDown()
                    elif self.randomDirection <= 60:
                        self.moveGobUp()    
                    else:
                        self.stopMoving()
                else:
                    self.walkingTimer -= 1
            else:
                if self.x + xgoblinSize < xheroPos:
                    self.moveGobRight()
                elif self.x > xheroPos + xwarriorSize:
                    self.moveGobLeft()
                else:
                    if self.y > yheroPos:
                        self.moveGobUp()
                    elif self.y < yheroPos:
                        self.moveGobDown()                   
                   
    def moveGobLeft(self):
        '''Moves character to the left
        '''        
        self.xspeed = -self.speed
        self.yspeed = 0
        self.directionFacing = 3 #Loads sprite goblin left
        
    def moveGobRight(self):
        '''Moves character to the right
        '''        
        self.xspeed = self.speed
        self.yspeed = 0 
        self.directionFacing = 1 #loads sprite goblin right
        
    def moveGobDown(self):
        '''Moves character down
        '''        
        self.xspeed = 0
        self.yspeed = self.speed
        self.directionFacing = 2 #loads goblin sprite down
        
    def moveGobUp(self):
        '''Moves character up
        '''                
        self.xspeed = 0
        self.yspeed = -self.speed
        self.directionFacing = 4 #loads goblin sprite up
    
    def stopMoving(self):
        '''Character stops all movment
        '''           
        self.yspeed = 0
        self.xspeed = 0
        
    def makeChanges(self):
        '''Adds all current speeds to the position of the hero
        '''
        self.y += self.yspeed
        self.x += self.xspeed
        
    def checkEdges(self):
        '''Checks to see if the character is outside of the screen and returns them if so
        '''
        if self.x < (-5 - xgoblinSize) or self.x > width + 5: #checks to see if goblin is walking into left or right wall
            self.x -= self.xspeed
        if self.y < (-5 - ygoblinSize) or self.y > height + 5: #checks to see if goblin is walking into top or bottom wall
            self.y -= self.yspeed  

    def checkCollide(self, xheroPos, yheroPos, heroDirection, xheroSpeed, yheroSpeed):
        '''Checks to see if the character has collided with the hero
        '''
        if self.distance < warriorRadius + goblinRadius:
            self.xspeed = 0
            self.yspeed = 0
            self.walkingTimer = 0
            self.x += xheroSpeed
            self.y += yheroSpeed
            self.didCollide = True #If the goblin is within the radius of hero and itself it will hault movement
        else:
            self.didCollide = False     

class Drugna():
    '''Final boss character
    '''
    def __init__(self):
        '''Default constructor
        '''
        self.damage = 20 
        self.health = 200
        self.startingHealth = 200
        self.distance = 0
        self.isAlive = True
        
    def displayDrugna(self):
        '''Displays the image of drugna
        '''
        angurdsDisplay.blit(drugnaImage, (320, 100)) 
        pygame.draw.rect(angurdsDisplay, red, (320,  90, 200, 7)) #loads red healthbar over hero
        pygame.draw.rect(angurdsDisplay, green, (321, 92, 200 * (self.health/self.startingHealth) * .985 , 3)) #loads green health meter         
        
    def takeDamage(self, damageNumber, xlocation, ylocation, damageRange):
        '''Function called by other classes to deal damage to the hero
        '''
        self.distance = math.sqrt(math.pow(420 - xlocation , 2) + math.pow(200  - ylocation , 2)) #Calculates distance for drugna
        if self.distance <= damageRange + 100:
            self.health -= damageNumber #Reduces drugna's health by the value of the damage from hero if in range
        if self.health <= 0:
            self.isAlive = False #Determines if drugna lives
        
def drawLoop(): 
    '''Central draw function of the program, calls all functions and actions
    '''
    gameClosed = False #variable known as alive determines whether program continues running

    score = 0
    mapBackground = Map()
    hero = Hero()
    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(11)] #Creates gobling with random location
    goblinAmount = 11
    drugna = Drugna()
    wonGame = False
    while not gameClosed: 
        frameRate.tick(60) #sets frame rate of game at 60 FPS
        
        for event in pygame.event.get(): #receives current actions of the player and acts upon them
            if event.type == pygame.QUIT: #if current action is exiting out, the draw function closes by setting alive as false
                gameClosed = True
            if event.type == pygame.KEYDOWN: #Keys used to control movement of hero and the attack hotkey
                if event.key == pygame.K_w:
                    hero.moveHeroUp()
                elif event.key == pygame.K_a:
                    hero.moveHeroLeft()
                elif event.key == pygame.K_s:
                    hero.moveHeroDown()
                elif event.key == pygame.K_d:
                    hero.moveHeroRight()
                elif event.key == pygame.K_y:
                    hero.slashing()
            elif event.type == pygame.KEYUP: #If keys are unpressed hero remains unmoved
                hero.stopMoving()       
        
        #section to call functions
        if hero.isAlive == True:
            mapBackground.printMap()
            mapBackground.mapScrolling(hero.x, hero.y)
            if mapBackground.heroMoveBack == True:
                if mapBackground.mapLevel > 0 and mapBackground.mapLevel < 4:
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(11)]  
                    goblinAmount = 11 #10 goblins in first to third level
                if mapBackground.mapLevel == 4:
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(6)]
                    goblinAmount = 6 #5 goblins in fourth level
                if mapBackground.mapLevel == 5:
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(11)]  
                    goblinAmount = 11 #10 goblins in fifth level 
                if mapBackground.mapLevel == 6: 
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(8)]
                    goblinAmount = 8 #7 goblins in sixth level    
                if mapBackground.mapLevel == 7:
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(11)]  
                    goblinAmount = 11 #10 goblins in seventh level
                if mapBackground.mapLevel == 8:
                    goblin = [Goblins(randint(0, width), randint(0, height - 150), 2, 100) for i in range(15)]  
                    goblinAmount = 15 #14 goblins in the final level

            if mapBackground.mapLevel == 4 and score >= 2:
                mapBackground.canEnter = True #Hero allowed to progress passed fourth level once score has reached 2 or more, score being goblin kills
                
            if mapBackground.mapLevel == 6 and score >= 4:
                mapBackground.canEnter = True #Hero allowed to progress passed sixth level once score has reached 4 or more, score being goblin kills
            
            hero.displayHero()
            hero.makeChanges()
            hero.checkEdges(mapBackground.heroMoveBack, mapBackground.mapExitSide)
            score = 0
            for i in range (1, goblinAmount): #For loop to simulate goblin a.i and run all the functions
                if goblin[i].isAlive == True:
                    goblin[i].displayGob()
                    goblin[i].attacking()
                    goblin[i].aggressive(hero.x, hero.y)
                    goblin[i].checkCollide(hero.x, hero.y, hero.directionFacing, hero.xspeed, hero.yspeed)
                    goblin[i].whatToMove(hero.x, hero.y)
                    goblin[i].makeChanges()
                    goblin[i].checkEdges()
                    if goblin[i].didAttack == True:
                        hero.takeDamage(goblin[i].damageToDeal, goblin[i].x, goblin[i].y, goblin[i].rangeOfAttack) #Determines when goblin attacks and if it hits the hero
                    if hero.isSlashing == True:
                        goblin[i].takeDamage(hero.slashingDamage, hero.x, hero.y, hero.slashingRange) #Determines when hero attacks and if it hits goblins
                else:
                    score += 1  #If goblin died from taking damage score increase by 1
                    
            if mapBackground.mapLevel == 8:      
                drugna.displayDrugna()
                if hero.isSlashing == True:
                    drugna.takeDamage(hero.slashingDamage, hero.x, hero.y, hero.slashingRange)  #if hero attacks in range of drugna, drugna takes damage
                if drugna.isAlive == False:
                    wonGame = True
            hero.stopSlashing()
            
        if hero.isAlive == False:
            angurdsDisplay.fill(black)
            endWords = textFont.render("You have died. Click the top right to exit.", 1, white) #set endwords to certain text if hero lives at final level
            angurdsDisplay.blit(endWords, (5*width/24, height/2)) #display endWords
        if wonGame == True:
            angurdsDisplay.fill(black)
            endWords = textFont.render("You have defeated Drugna and saved Angurdia, You win!", 1, white) #set endwords to certain text if here dies at final level
            angurdsDisplay.blit(endWords, (width/8, height/2)) #display endwords
            
        pygame.display.update() #updates display with all changes
    
    
drawLoop()
pygame.quit() #exits pygame to shut off program
quit() #quits out of program