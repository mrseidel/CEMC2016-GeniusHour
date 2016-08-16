"""
Programmer Names: E.H., K.W., A.B.
Last Date Updated: December 7, 2014
Version: 0.6
Description: A chess game with many backbone functions implemented. No GUI.
Collective time spent on code: Worked on for 10 hours
"""
chessBoard=[]

def clearBoard(board):#Creates empty board or empties the board
    if len(board)==0:
        for i in range(8):
            board.append(['OO']*8)
        board.append(['Turn', 'WLC', 'WRC', 'BLC', 'BRC', 'WKx', 'WKy', 'WKSafe', 'BKx', 'BKy', 'BKSafe'])
    elif len(board)>0:
        for i in range(len(board)-1):
            board[i]=['OO']*8
        board[len(board)-1]=['Turn', 'WLC', 'WRC', 'BLC', 'BRC', 'WKx', 'WKy', 'WKSafe', 'BKx', 'BKy', 'BKSafe']

def newBoard(board):#Sets pieces onto the board
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

def restart(board):#Clears board and sets the pieces
    clearBoard(board)
    newBoard(board)

def printBoard(board):#Displays board
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

def detectInt(min, max, str):#Finds integer between two numbers
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

def setPiece(board):#Sets any piece on any position
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

def removePiece(board):#Makes any position empty
    x=detectInt(1, len(board)-1, 'Piece X:')
    y=detectInt(1, len(board)-1, 'Piece Y:')
    board[y-1][x-1]='OO'

def checkPiece(board, intX, intY, newX, newY):#Check if the move is legal
    #Only moves if king would be safe
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

def checkKingSafe(board, intX, intY, newX, newY):#Check if the king is safe after a move
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

def checkP(board, intX, intY, newX, newY):#Check if the pawn move is legal
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

def checkR(board, intX, intY, newX, newY):#Check if the rook move is legal
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

def checkH(board, intX, intY, newX, newY):#Check if the horse move is legal
    tmp=False
    if intX!=newX and intY!=newY:
        if abs(intX-newX)+abs(intY-newY)==3:
            tmp=True
    return tmp

def checkB(board, intX, intY, newX, newY):#Check if the bishop move is legal
    tmp=False
    count=1
    if abs(intX-newX)==abs(intY-newY):
        tmp=True
        if intX<newX and intY<newY:#Checks SW
            while count<newX-intX:
                if board[intY-1+count][intX-1+count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX>newX and intY<newY:#Checks SE
            while count<intX-newX:
                if board[intY-1+count][intX-1-count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX<newX and intY>newY:#Checks NE
            while count<newX-intX:
                if board[intY-1-count][intX-1+count]!='OO':
                    tmp=False
                    break
                count+=1
        elif intX>newX and intY>newY:#Checks NW
            while count<intX-newX:
                if board[intY-1-count][intX-1-count]!='OO':
                    tmp=False
                    break
                count+=1
    return tmp

def checkQ(board, intX, intY, newX, newY):#Check if the queen move is legal
    tmp=False
    if (intX==newX or intY==newY) and (intX!=newX or intY!=newY):
        tmp=checkR(board, intX, intY, newX, newY)
    elif abs(intX-newX)==abs(intY-newY):
        tmp=checkB(board, intX, intY, newX, newY)
    return tmp

def checkK(board, intX, intY, newX, newY):#Check if the king move is legal
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

def checkSafe(board, x, y, turn):#Check whether a position is safe
    tmp=True

    count=1
    while count<len(board)-1-y and count<len(board)-1-x and tmp==True:#Checks SW
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
    while count<len(board)-1-y and count<x and tmp==True:#Checks SE
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
    while count<y and count<len(board)-1-x and tmp==True:#Checks NW
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
    while count<y and count<x and tmp==True:#Checks NE
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
                if board[y-1][x-1-count][1] in 'R':
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
                if board[y-1][x-1+count][1] in 'R':
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

def detectMove(board):#Finds initial position and new position
    while(True):
        intX=detectInt(1, len(board)-1, 'Piece X:')
        intY=detectInt(1, len(board)-1, 'Piece Y:')
        if board[intY-1][intX-1]=='OO' or board[intY-1][intX-1][0]!=board[8][0]:
            print ('Try Again')
            continue
        else:
            break
    while(True):
        newX=detectInt(1, len(board)-1, 'To X:')
        newY=detectInt(1, len(board)-1, 'To Y:')
        if (newX==intX and newY==intY):
            print ('Try Again')
            continue
        else:
            break
    movePiece(board, intX, intY, newX, newY)

def movePiece(board, intX, intY, newX, newY):#Checks if initial position and new position conflicts in some way and makes the move if not
    if checkPiece(board, intX, intY, newX, newY)==True and board[newY-1][newX-1][0]!=board[8][0]:
        board[newY-1][newX-1]=board[intY-1][intX-1]
        board[intY-1][intX-1]='OO'
        print (checkSafe(chessBoard, newX, newY, board[8][0]))

        count=1
        if board[8][0]=='W':#Flips turn to black
            while count<len(board):
                if board[1-1][count-1]=='WP':#Checks if pawn reaches the end and changes into new piece
                    while(True):
                        try:
                            piece=input('Piece:')
                            if len(piece)!=1 or piece not in 'RHBQ':
                                print ('Try Again')
                                continue
                            else:
                                break
                        except:
                            print ('Try Again')
                            continue
                    board[1-1][count-1]='W'+piece
                    board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
                    board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
                count+=1
            board[8][0]='B'
        elif board[8][0]=='B':#Flips turn to white
            while count<len(board):
                if board[8-1][count-1]=='BP':#Checks if pawn reaches the end and changes into new piece
                    while(True):
                        try:
                            piece=input('Piece:')
                            if len(piece)!=1 or piece not in 'RHBQ':
                                print ('Try Again')
                                continue
                            else:
                                break
                        except:
                            print ('Try Again')
                            continue
                    board[8-1][count-1]='B'+piece
                    board[8][7]=checkSafe(board, board[8][5], board[8][6], 'W')
                    board[8][10]=checkSafe(board, board[8][8], board[8][9], 'B')
                count+=1
            board[8][0]='W'
    else:
        print ('Try Again')

print ('Command help for instructions')
while(True):
    restart(chessBoard)
    printBoard(chessBoard)
    while(True):
        command=input('Command:')
        if command=='help':
            print ('helpful')
        elif command=='print':
            printBoard(chessBoard)
        elif command=='restart':
            break
        elif command=='clear':
            clearBoard(chessBoard)
            printBoard(chessBoard)
        elif command=='set':
            setPiece(chessBoard)
            printBoard(chessBoard)
        elif command=='remove':
            removePiece(chessBoard)
            printBoard(chessBoard)
        elif command=='move':
            detectMove(chessBoard)
            printBoard(chessBoard)
        else:
            print ('Try Again')
