

"""
Programmer Names: E.H., K.W., A.B
Last Date Updated: December 7, 2014
Version: 0.8
Description: A chess game with most of the essential functions implemented
Limitations: Check function has a few bugs and no checkmate function
Collective time spent on code: Worked on for 18 hours
"""
from pygame import *  #Imports module
init()
screen = display.set_mode((600, 512))

def clearBoard(board):
    """Creates empty board or empties the board"""
    if len(board)==0:
        for i in range(8):
            board.append(['OO']*8)
        board.append(['Turn', 'WLC', 'WRC', 'BLC', 'BRC', 'WKx', 'WKy', 'WKSafe', 'BKx', 'BKy', 'BKSafe'])
    elif len(board)>0:
        for i in range(len(board)-1):
            board[i]=['OO']*8
        board[len(board)-1]=['Turn', 'WLC', 'WRC', 'BLC', 'BRC', 'WKx', 'WKy', 'WKSafe', 'BKx', 'BKy', 'BKSafe']

def newBoard(board):
    """Sets pieces onto the board"""
    for i in range(len(board)):
        if i==0:
            board[i]=['BR', 'BH', 'BB', 'BQ', 'BK', 'BB', 'BH', 'BR']
        elif i==1:
            board[i]=['BP']*8
        elif i==6:
            board[i]=['WP']*8
        elif i==7:
            board[i]=['WR', 'WH', 'WB', 'WQ', 'WK', 'WB', 'WH', 'WR']
        elif i==8:
            board[i]=['W', True, True, True, True, 5, 8, True, 5, 1, True]

def restart(board):
    """Clears board and sets the pieces"""
    clearBoard(board)
    newBoard(board)
def printBoard(board):
    """Displays board"""
    print (['xy', ['10', '20', '30', '40', '50', '60', '70', '80']])
    y=1
    for i in board:
        if y<=8:
            print (['0'+str(y), i])
            y+=1
        else:
            if board[8][7]==False:
                print (['Turn', i[0], 'White King in Check'])
            elif board[8][10]==False:
                print (['Turn', i[0], 'Black King in Check'])
            else:
                print (['Turn', i[0]])
    print (board[len(board)-1])

def detectInt(min, max, str):
    """Finds integer between two numbers and returns the resulting value, for testing purposes only"""
    tmp=0
    while(True):
        try:
            tmp=int(input(str))
            if tmp<min or tmp>max:
                print ('Try Again')
                continue
            else:
                break
        except:
            print ('Try Again')
            continue
    return tmp

def setPiece(board):
    """Sets any piece on any position, for testing purposes only"""
    x=detectInt(1, len(board)-1, 'Piece X:')
    y=detectInt(1, len(board)-1, 'Piece Y:')
    while(True):
        try:
            piece=input('Piece:')
            if len(piece)!=2 or piece[0] not in 'WB' or piece[1] not in 'PRHBQK':
                print ('Try Again')
                continue
            else:
                break

        except:
            print ('Try Again')
            continue
    board[y-1][x-1]=piece

def removePiece(board):
    """Makes any position empty, for testing purposes only"""
    x=detectInt(1, len(board)-1, 'Piece X:')
    y=detectInt(1, len(board)-1, 'Piece Y:')
    board[y-1][x-1]='OO'

def checkPiece(board, intX, intY, newX, newY):
    """Check if the move is legal and only moves if king is safe, returns true if the move is legal and the king is safe"""
    tmp=False
    if board[intY-1][intX-1][1]=='P':
        if checkP(board, intX, intY, newX, newY)==True:
            tmp=checkKingSafe(board, intX, intY, newX, newY)
    elif board[intY-1][intX-1][1]=='R':
        if checkR(board, intX, intY, newX, newY)==True:
            tmp=checkKingSafe(board, intX, intY, newX, newY)
    elif board[intY-1][intX-1][1]=='H':
        if checkH(board, intX, intY, newX, newY)==True:
            tmp=checkKingSafe(board, intX, intY, newX, newY)
    elif board[intY-1][intX-1][1]=='B':
        if checkB(board, intX, intY, newX, newY)==True:
            tmp=checkKingSafe(board, intX, intY, newX, newY)
    elif board[intY-1][intX-1][1]=='Q':
        if checkQ(board, intX, intY, newX, newY)==True:
            tmp=checkKingSafe(board, intX, intY, newX, newY)
    elif board[intY-1][intX-1][1]=='K':
        if checkK(board, intX, intY, newX, newY)==True:
            tmp=True
            if board[intY-1][intX-1][0]=='W':
                board[8][5]=newX
                board[8][6]=newY
            elif board[intY-1][intX-1][0]=='B':
                board[8][8]=newX
                board[8][9]=newY
    return tmp

def checkKingSafe(board, intX, intY, newX, newY):
    """Check if the king is safe after a move, returns true if safe"""
    tmp=True

    #Checks if king would be endangered
    piece=board[newY-1][newX-1]
    board[newY-1][newX-1]=board[intY-1][intX-1]
    board[intY-1][intX-1]='OO'
    board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
    board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
    board[intY-1][intX-1]=board[newY-1][newX-1]
    board[newY-1][newX-1]=piece

    if board[intY-1][intX-1][0]=='W' and board[8][7]==False:#Checks if white endangered
            tmp=False
            board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
            board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
    elif board[intY-1][intX-1][0]=='B' and board[8][10]==False:#Checks if black endangered
            tmp=False
            board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
            board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
    return tmp

def checkP(board, intX, intY, newX, newY):
    """Check if the pawn move is legal, returns true if legal"""
    tmp=False
    if abs(intX-newX)<=1:
        if board[intY-1][intX-1][0]=='W':#Checks for white pawns
            if intY==7 and intY-newY==2 and intX==newX and board[newY][newX-1]=='OO':
                tmp=True
            elif intY-newY==1:
                if intX==newX and board[newY-1][newX-1]=='OO':
                    tmp=True
                elif intX!=newX and board[newY-1][newX-1][0]=='B':
                    tmp=True
        elif board[intY-1][intX-1][0]=='B':#Checks for black pawns
            if intY==2 and newY-intY==2 and intX==newX and board[newY-2][newX-1]=='OO':
                tmp=True
            elif newY-intY==1:
                if intX==newX and board[newY-1][newX-1]=='OO':
                    tmp=True
                elif intX!=newX and board[newY-1][newX-1][0]=='W':
                    tmp=True
    return tmp

def checkR(board, intX, intY, newX, newY):
    """Check if the rook move is legal, returns true if legal"""
    tmp=False
    count=1
    if intX==newX:#Checks E and W
        tmp=True
        while count<9:
            if intY<count<newY or newY<count<intY:
                if board[count-1][intX-1]!='OO':
                    tmp=False
                    break
            count+=1
    elif intY==newY:#Checks N and S
        tmp=True
        while count<9:
            if intX<count<newX or newX<count<intX:
                if board[intY-1][count-1]!='OO':
                    tmp=False
                    break
            count+=1
    if intX==1 and intY==8:#Disable white left castling
        board[8][1]=False
    elif intX==8 and intY==8:#Disable white right castling
        board[8][2]=False
    elif intX==1 and intY==1:#Disable black left castling
        board[8][3]=False
    elif intX==8 and intY==1:#Disable black right castling
        board[8][4]=False
    return tmp

def checkH(board, intX, intY, newX, newY):
    """Check if the horse move is legal, returns true if legal"""
    tmp=False
    if abs(intX-newX)+abs(intY-newY)==3:
        if intX!=newX and intY!=newY:
            tmp=True
    return tmp

def checkB(board, intX, intY, newX, newY):
    """Check if the bishop move is legal, returns true if legal"""
    tmp=False
    count=1
    if abs(intX-newX)==abs(intY-newY):
        tmp=True
        if intX<newX and intY<newY:#Checks SE
            while count<newX-intX:
                if board[intY-1+count][intX-1+count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX>newX and intY<newY:#Checks SW
            while count<intX-newX:
                if board[intY-1+count][intX-1-count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX<newX and intY>newY:#Checks NW
            while count<newX-intX:
                if board[intY-1-count][intX-1+count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX>newX and intY>newY:#Checks NE
            while count<intX-newX:
                if board[intY-1-count][intX-1-count]!='OO':
                    tmp=False
                    break
                count+=1
    return tmp

def checkQ(board, intX, intY, newX, newY):
    """Check if the queen move is legal. returns true if legal"""
    tmp=False
    if (intX==newX or intY==newY) and (intX!=newX or intY!=newY):
        tmp=checkR(board, intX, intY, newX, newY)
    elif abs(intX-newX)==abs(intY-newY):
        tmp=checkB(board, intX, intY, newX, newY)
    return tmp

def checkK(board, intX, intY, newX, newY):
    """Check if the king move is legal, returns true if legal"""
    tmp=False
    if board[intY-1][intX-1][0]=='W':#Checks white king
        if abs(intX-newX)<=1 and abs(intY-newY)<=1:
            board[intY-1][intX-1]='OO'
            tmp=checkSafe(board, newX, newY, 'W')
            board[intY-1][intX-1]='WK'

            board[8][1]=False
            board[8][2]=False
        elif board[8][7]==True and board[8][1]==True and newX==3 and newY==8:#Checks left castling
            if board[8-1][2-1]=='OO' and board[8-1][3-1]=='OO' and board[8-1][4-1]=='OO':
                board[intY-1][intX-1]='OO'
                tmp=checkSafe(board, newX, newY, 'W')
                board[intY-1][intX-1]='WK'

                board[8][1]=False
                board[8][2]=False
                board[8-1][1-1]='OO'
                board[8-1][4-1]='WR'
        elif board[8][7]==True and board[8][2]==True and newX==7 and newY==8:#Checks right castling
            if board[8-1][7-1]=='OO' and board[8-1][6-1]=='OO':
                board[intY-1][intX-1]='OO'
                tmp=checkSafe(board, newX, newY, 'W')
                board[intY-1][intX-1]='WK'

                board[8][1]=False
                board[8][2]=False
                board[8-1][8-1]='OO'
                board[8-1][6-1]='WR'
    elif board[intY-1][intX-1][0]=='B':#Checks black king
        if abs(intX-newX)<=1 and abs(intY-newY)<=1:
            board[intY-1][intX-1]='OO'
            tmp=checkSafe(board, newX, newY, 'B')
            board[intY-1][intX-1]='BK'

            board[8][3]=False
            board[8][4]=False
        elif board[8][10]==True and board[8][3]==True and newX==3 and newY==1:#Checks left castling
            if board[1-1][2-1]=='OO' and board[1-1][3-1]=='OO' and board[1-1][4-1]=='OO':
                board[intY-1][intX-1]='OO'
                tmp=checkSafe(board, newX, newY, 'B')
                board[intY-1][intX-1]='BK'

                board[8][3]=False
                board[8][4]=False
                board[1-1][1-1]='OO'
                board[1-1][4-1]='BR'
        elif board[8][10]==True and board[8][4]==True and newX==7 and newY==1:#Checks right castling
            if board[1-1][7-1]=='OO' and board[1-1][6-1]=='OO':
                board[intY-1][intX-1]='OO'
                tmp=checkSafe(board, newX, newY, 'B')
                board[intY-1][intX-1]='BK'

                board[8][3]=False
                board[8][4]=False
                board[1-1][8-1]='OO'
                board[1-1][6-1]='BR'
    return tmp

def checkSafe(board, x, y, turn):
    """Check whether a position is safe, returns true if safe"""
    tmp=True

    count=1
    while count<len(board)-1-y and count<len(board)-1-x and tmp==True:#Checks SE
        if board[y-1+count][x-1+count]!='OO':
            if board[y-1+count][x-1+count][0]!=turn:
                if board[y-1+count][x-1+count][1] in 'BQ':
                    tmp=False
                elif count==1:
                    if board[y-1+count][x-1+count][1]=='K':
                        tmp=False
                    elif turn=='B' and board[y-1+count][x-1+count][1]=='P':
                        tmp=False
            break
        count+=1

    count=1
    while count<len(board)-1-y and count<x and tmp==True:#Checks SW
        if board[y-1+count][x-1-count]!='OO':
            if board[y-1+count][x-1-count][0]!=turn:
                if board[y-1+count][x-1-count][1] in 'BQ':
                    tmp=False
                elif count==1:
                    if board[y-1+count][x-1-count][1]=='K':
                        tmp=False
                    elif turn=='B' and board[y-1+count][x-1-count][1]=='P':
                        tmp=False
            break
        count+=1

    count=1
    while count<y and count<len(board)-1-x and tmp==True:#Checks NE
        if board[y-1-count][x-1+count]!='OO':
            if board[y-1-count][x-1+count][0]!=turn:
                if board[y-1-count][x-1+count][1] in 'BQ':
                    tmp=False
                elif count==1:
                    if board[y-1-count][x-1+count][1]=='K':
                        tmp=False
                    elif turn=='W' and board[y-1-count][x-1+count][1]=='P':
                        tmp=False
            break
        count+=1

    count=1
    while count<y and count<x and tmp==True:#Checks NW
        if board[y-1-count][x-1-count]!='OO':
            if board[y-1-count][x-1-count][0]!=turn:
                if board[y-1-count][x-1-count][1] in 'BQ':
                    tmp=False
                elif count==1:
                    if board[y-1-count][x-1-count][1]=='K':
                        tmp=False
                    elif turn=='W' and board[y-1-count][x-1-count][1]=='P':
                        tmp=False
            break
        count+=1

    count=1
    while count<x and tmp==True:#Checks W
        if board[y-1][x-1-count]!='OO':
            if board[y-1][x-1-count][0]!=turn:
                if board[y-1][x-1-count][1] in 'RQ':
                    tmp=False
                elif count==1:
                    if board[y-1][x-1-count][1]=='K':
                        tmp=False
            break
        count+=1

    count=1
    while count<len(board)-1-x and tmp==True:#Checks E
        if board[y-1][x-1+count]!='OO':
            if board[y-1][x-1+count][0]!=turn:
                if board[y-1][x-1+count][1] in 'RQ':
                    tmp=False
                elif count==1:
                    if board[y-1][x-1+count][1]=='K':
                        tmp=False
            break
        count+=1

    count=1
    while count<y and tmp==True:#Checks N
        if board[y-1-count][x-1]!='OO':
            if board[y-1-count][x-1][0]!=turn:
                if board[y-1-count][x-1][1] in 'RQ':
                    tmp=False
                elif count==1:
                    if board[y-1-count][x-1][1]=='K':
                        tmp=False
            break
        count+=1

    count=1
    while count<len(board)-1-y and tmp==True:#Checks S
        if board[y-1+count][x-1]!='OO':
            if board[y-1+count][x-1][0]!=turn:
                if board[y-1+count][x-1][1] in 'RQ':
                    tmp=False
                elif count==1:
                    if board[y-1+count][x-1][1]=='K':
                        tmp=False
            break
        count+=1

    xCount=-2
    while xCount<=2 and tmp==True:#Checks horses
        if xCount!=0:
            yCount=-2
            while yCount<=2 and tmp==True:
                if yCount!=0 and xCount!=yCount and y+yCount in range(1, len(board)) and x+xCount in range(1, len(board)):
                    if board[y-1+yCount][x-1+xCount][0]!=turn and board[y-1+yCount][x-1+xCount][1]=='H':
                        tmp=False
                yCount+=1
        xCount+=1
    return tmp

def detectMove(board, selectedobjectx, selectedobjecty, placeobjectx, placeobjecty):
    """Finds initial position and new position"""
    intX=selectedobjectx + 1 #Calls the location of the initial square and the final square inside the array
    intY=selectedobjecty + 1
    newX=placeobjectx + 1
    newY=placeobjecty + 1
    if (newX==intX and newY==intY): #Checks to see if initial square's location matches' final square's location
        return None
    if (board[intY-1][intX-1]!='OO' and board[intY-1][intX-1][0]==board[8][0] and board[newY-1][newX-1][0]!=board[8][0]): #Checks to see if move is valid

        movePiece(board, intX, intY, newX, newY)


def movePiece(board, intX, intY, newX, newY):
    """Checks if initial position and new position conflicts in some way and makes the move if not"""
    global switchpiece
    if checkPiece(board, intX, intY, newX, newY)==True and board[newY-1][newX-1][0]!=board[8][0]:
        board[newY-1][newX-1]=board[intY-1][intX-1]
        board[intY-1][intX-1]='OO'
        print (checkSafe(chessBoard, newX, newY, board[8][0]))
        count=1
        if board[8][0]=='W':#Flips turn to black
            while count<len(board):
                if board[1-1][count-1]=='WP':#Checks if pawn reaches the end and changes into new piece
                    switchpiece = True
                    board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
                    board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
                count+=1
            board[8][0]='B'
        elif board[8][0]=='B':#Flips turn to white
            while count<len(board):
                if board[8-1][count-1]=='BP':#Checks if pawn reaches the end and changes into new piece
                    switchpiece = True
                    board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
                    board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
                count+=1
            board[8][0]='W'
    else:
        print(1)
        print ('Try Again')
def pawnconvert(board, mouseX, mouseY):
    """Returns the string value of the piece that was selected during the pawn swap when the pawn reaches the end of the board"""
    if ((mouseX > 179 and mouseX < 243) and (mouseY > 179 and mouseY < 243)):
        return('R')
    elif ((mouseX > 243 and  mouseX < 307) and (mouseY > 179 and mouseY < 243)):
        return('H')
    elif ((mouseX > 179 and mouseX < 243) and (mouseY > 243 and mouseY < 307)):
        return('B')
    elif ((mouseX > 242 and mouseX < 306) and (mouseY > 241 and mouseY < 305)):
        return('Q')
    else:
        return None
"""---------------Variable Declaration---------------"""
chessBoard=[]
done = False
selected = False
placeobjectx = 0
placeobjecty = 0
selectedobjectx = 0
selectedobjecty = 0
selectedsquarex = 0
selectedsquarey = 0
switchpiece = False
helpmenu = False
"""------------------Declaring Images---------------------"""
chessboard = image.load('Photos/Chess Board.gif').convert_alpha()
BR = image.load('Photos/bRook.gif').convert_alpha()
BH = image.load('Photos/bKnight.gif').convert_alpha()
BB = image.load('Photos/bBishop.gif').convert_alpha()
BQ = image.load('Photos/bQueen.gif').convert_alpha()
BK = image.load('Photos/bKing.gif').convert_alpha()
BP = image.load('Photos/bPawn.gif').convert_alpha()
WR = image.load('Photos/wRook.gif').convert_alpha()
WH = image.load('Photos/wKnight.gif').convert_alpha()
WB = image.load('Photos/wBishop.gif').convert_alpha()
WQ = image.load('Photos/wQueen.gif').convert_alpha()
WK = image.load('Photos/wKing.gif').convert_alpha()
WP = image.load('Photos/wPawn.gif').convert_alpha()
restartbutton = image.load('Photos/restartbutton.gif').convert_alpha()
questionmark = image.load('Photos/questionmark.gif').convert_alpha()
donebutton = image.load('Photos/done.gif').convert_alpha()

"""-------------------------Main Loop--------------------------------"""
restart(chessBoard)
printBoard(chessBoard)
while not done:
    for evnt in event.get():
        if evnt.type == QUIT: #Clicking the close application closes the window
            done = True
        elif evnt.type == KEYDOWN:
            if evnt.key == K_ESCAPE: #Esc works as exit
                done = True
        elif evnt.type == MOUSEBUTTONDOWN:
            (mouseX, mouseY) = mouse.get_pos() #Retrieves x and y values of mouse if mouse is clicked
            if helpmenu == True: #Activates help menu if question mark is clicked
                if ((mouseX > 300 and mouseX < 350) and (mouseY > 440 and mouseY < 475)):
                    helpmenu = False
            else:
                if switchpiece == True: #Activates pawn exchange menu when pawn reaches end of board
                    tmp = pawnconvert(chessBoard, mouseX, mouseY)
                    if pawnconvert != None:
                        for b in range(len(chessBoard)-1):
                            if chessBoard[0][b] == 'WP':
                                chessBoard[0][b] = 'W' + tmp
                                switchpiece = False
                            elif chessBoard[7][b] == 'BP':
                                chessBoard[7][b] = 'B'+ tmp
                                switchpiece = False
                else:
                    for a in range(len(chessBoard)-1): #loops through the entire board to match mouse location with square location
                        for b in range(len(chessBoard)-1):
                            if ((mouseX > b*64 and mouseX < 64 + b*64) and (mouseY > a*64 and mouseY < 64 + a*64)):
                                if selected == True: #Toggles back and forth based on mouse click to retrieve initial square and final square
                                        placeobjectx = b
                                        placeobjecty = a
                                        selected = False
                                        detectMove(chessBoard, selectedobjectx, selectedobjecty, placeobjectx, placeobjecty)
                                elif selected == False:
                                    selectedobjectx = b
                                    selectedobjecty = a
                                    selected = True
                if ((mouseX > 550 and mouseX < 582) and (mouseY > 470 and mouseY < 502)): #Restart button
                    restart(chessBoard)
                if ((mouseX > 550 and mouseX < 582) and (mouseY > 430 and mouseY < 462)): #Help button
                    helpmenu = True
    display.set_caption("Chess")
    """--------------------Colors and Fonts--------------------"""
    WHITE = ( 255, 255, 255)
    BLACK = (0,0,0)
    GREY = (192, 192 , 192)
    GREEN = (128, 255, 0)
    font1 = font.Font(None, 25)
    font2 = font.Font(None, 16)
    font3 = font.Font(None, 20)
    """--------------Fills window with various images, shapes or text----------------"""
    screen.fill(WHITE)
    screen.blit(questionmark, (550, 430))
    screen.blit(restartbutton,(550, 470))
    screen.blit(chessboard,(0,0))
    if selected == True:
        draw.rect(screen, GREEN,(selectedobjectx*64, selectedobjecty*64, 64, 64))
    for Y in range(len(chessBoard)-1):
        for X in range(len(chessBoard)-1):
            if chessBoard[Y][X]=='BR':
                screen.blit(BR,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='BH':
                screen.blit(BH,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='BB':
                screen.blit(BB,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='BQ':
                screen.blit(BQ,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='BK':
                screen.blit(BK,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='BP':
                screen.blit(BP,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WR':
                screen.blit(WR,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WH':
                screen.blit(WH,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WB':
                screen.blit(WB,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WQ':
                screen.blit(WQ,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WK':
                screen.blit(WK,(5+X*64,5+Y*64))
            elif chessBoard[Y][X]=='WP':
                screen.blit(WP,(5+X*64,5+Y*64))

    if switchpiece == True: #Pawn exchange menu
        draw.rect(screen, BLACK, (173, 173, 132, 132))
        draw.rect(screen, WHITE, (176, 176, 62, 62))
        draw.rect(screen, WHITE, (240, 176, 62, 62))
        draw.rect(screen, WHITE, (176, 240, 62, 62))
        draw.rect(screen, WHITE, (240, 240, 62, 62))
        if chessBoard[8][0] == 'B':
            screen.blit(WR, (179, 179))
            screen.blit(WH, (243, 179))
            screen.blit(WB, (179, 243))
            screen.blit(WQ, (242, 241))
        elif chessBoard[8][0] == 'W':
            screen.blit(BR, (179, 179))
            screen.blit(BH, (243, 179))
            screen.blit(BB, (179, 243))
            screen.blit(BQ, (242, 241))

    if helpmenu == True: #Displays help menu
        draw.rect(screen, GREY,(0,0,600,512))
        text1 = font1.render("Help Manual", True, BLACK)
        screen.blit(text1, (260, 70))
        text2 = font2.render("Hi there! Welcome to Chess, a board game simulation based on the popular board game Chess!", True, BLACK)
        screen.blit(text2, (30, 130))
        text3 = font2.render("If you are unfamiliar with the rules of this game, please refer to User Manual that accompanies ", True, BLACK)
        screen.blit(text3, (30, 150))
        text4 = font2.render("this program.", True, BLACK)
        screen.blit(text4, (30, 160))
        text5 = font2.render("Do note that this program is currently still in its alpha testing stages and will not have all", True, BLACK)
        screen.blit(text5, (30, 180))
        text6 = font2.render("the required features for a full game. If you spot any bugs or discrepancies in the game, please", True, BLACK)
        screen.blit(text6, (30, 190))
        text7 = font2.render("let us know so that we may address it as quickly as possible. Other than this, please have fun!", True, BLACK)
        screen.blit(text7, (30, 200))
        text8 = font1.render("Developers", True, BLACK)
        screen.blit(text8, (260, 250))
        text9 = font3.render("Eric Huan, Kevin Weng, Arsala Bangash", True, BLACK)
        screen.blit(text9, (180, 290))
        text10 = font2.render("Version: 0.8",True, BLACK)
        screen.blit(text10, (530, 500))
        screen.blit(donebutton, (300, 440))

    display.flip()
quit() #Exits application if loop stops running
