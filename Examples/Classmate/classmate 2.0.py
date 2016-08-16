#-- coding: utf-8 --
#^doest run otherwise using play


#Made by: 4 people (S, M, R, and A)
#Submitted on May 23rd, 2014
#TYPL™


#Used a GUI builder called TKINTER

from tkinter import *
from urllib.request import *




import tkinter
import tkinter.messagebox as msg
import tkinter.commondialog

#This is the function that deletes the individual class buttons in the save menu
def deleteclass(name,window):
    
    '''
    (Text,Text) -> (Text)
    Reads from html and outputs to a text file
    
    '''
    with open("savelinks.txt","r") as inf:
        hold = inf.readlines()
    hold1 = []
    for i in range(0,len(hold)):
        if hold[i] == name + "\n":
            hold1 = hold[0:i-1] + hold[i+2:]
            break
        if i == len(hold) - 1:
            hold1 = hold
    #stores inside a text file and reads it in the save menu
    with open("savelinks.txt","w") as ou:
        for i in range(0,len(hold1)):
            ou.write(hold1[i])
    window.destroy()      
        
    
            
#Writes the items in the textfile      

def savelink(link,winname):
    '''
    (Text,Text) -> (Text)
    Reads from html and outputs links of saved courses to a text file
    
    '''    
    with open("savelinks.txt","a") as ou:
        ou.write(winname + "\n")
        ou.write(link + "\n")
        ou.write("***\n")

#This is the save menu        
def opensave():
    savedc = Tk()
    savedc.title("Saved Courses")
    savedc.configure(background='white')
    savedc.geometry("600x500")
    with open("savelinks.txt","r") as inf:#reads text file that stores saved courses
        hold = inf.readlines()
    savedcs = []
    temp3 = []
    for i in range(0,(len(hold))):
        if hold[i] == "***" or hold[i] == "***\n" : 
            temp3.append(hold[i-2][:-1])
            temp3.append(hold[i-1][:-1])
            savedcs.append(temp3)
            temp3 = []
    b4 = []
    deletebtn = []
    for i in range(0,(len(savedcs))):
        b4.append(Button(savedc, text = savedcs[i][0],background = "black",foreground = "white",command = lambda y = i: link_click(savedcs[y][1],savedcs[y][0])))
        deletebtn.append(Button(savedc, text = "x",background = "black",foreground = "white", command = lambda z = i: deleteclass(savedcs[z][1],savedc),width = 1, height = 1))
    for i in range(0,len(b4)):
        b4[i].place(x = 0, y = i * 25)
        deletebtn[i].place(x = 580 ,y = i * 25)
        
        
            
    
#This takes the link from the john fraser site and creates a new page for each grade and class
def link_click(link,winname):
      
    info = Tk()
    info.title(winname)
    info.configure(background='white') #All of this is the page setup 
    info.geometry("600x500")
    info.resizable (width=False, height=False)
    savebtn = Button(info,text ="Save",height = 5, width = 10, command = lambda: savelink(link,winname))
    savebtn.place(x=490,y = 400)
    savebtn.configure(background='black',foreground='white',font= ("Georgia Bold", 10))
    print (link)
    print ("http://myclass.peelschools.org" + link + "/default.aspx")
    link1 = urlopen("http://myclass.peelschools.org" + link + "/default.aspx")#Opens up the link 
    
    rawtext = link1.read() #reads the html text in the link
    rawtext = str(rawtext) #saves the html text in the link
    temprarray2 = []
    #finds the announcements of each individual class
    #This is done using a signature that each announcement contains in the html format
    while rawtext.find('<li class="query-header with-attachments">') != -1:
        x = rawtext.find('<li class="query-header with-attachments">') 
        y = len('<li class="query-header with-attachments">')
        temprarray2.append(rawtext[x+y:x+400+y])#stores anouncements
        rawtext = rawtext[x+400:]
    print (temprarray2)    
    tempraw = []
    finarray = []
    labels = []
    for i in range(0,len(temprarray2)):
        tempraw.append(temprarray2[i][0:(temprarray2[i].find("<"))])
        tempraw.append(temprarray2[i][(temprarray2[i].find("ExternalClass")+46):(temprarray2[i].find("</div>"))])
        if tempraw[1].find("<div>") != -1: #this is the signature that each announcemet has
            tempraw[1] = tempraw[1][5:]
        finarray.append(tempraw) #stores each announcemets 
        tempraw = []    
    for i in range(0,len(finarray)):
        labels.append(Label(info, text =finarray[i][0] + "-" + finarray[i][1])) #displays the name of the class and class code in individual buttons for each grade
 
    if len(labels)==0:
        errormsg=Label(info,text="There are no announcements to display ") # if not announcements displays this
        errormsg.configure(background='white',font= ("Georgia", 20))
        errormsg.place(x=60, y=230) 
    #Builds the announcements page and changes the setup
        
    elif len(labels) > 5:
        for i in range(0,5):
            labels[i].place(x = 7, y = i*60)
            labels[i].configure(background='white',foreground='black',font = ("Georgia", 11),wraplength=580,justify=LEFT)
           
    else:
        for i in range(0,len(labels)):
            labels[i].place(x = 7, y = i*60)
            labels[i].configure(background='white',foreground='black',font = ("Georgia", 11),wraplength=580,justify=LEFT ) 
            
          
            
        
#Reads the html text from myclass site and seperates it 
#according to each grade



#Builds the class buttons and configures the setup
    
def g9_click(): 
    main_link = "http://myclass.peelschools.org/PDSBWS/wsecondarySiteList.aspx?SchoolNumber=2652"
    g9 = Tk()
    g9.title("Classmate: Grade 9")
    g9.configure(background='white')
    g9.resizable (width=False, height=False)
    g9.geometry("600x500")
    Gradenine= Label(g9,text= "Grade 9")
    Gradenine.place(x=300,y=420)
    Gradenine.configure(background='white',font=("Times New Roman",60))
    
    barray = []
    for i in range(0,(len(g9_classes))):
        barray.append(Button(g9,text =g9_classes[i][0] + "-" + g9_classes[i][1],height = 1, width = 40, command = lambda y=i: link_click(g9_classes[y][2],g9_classes[y][0] + "-" + g9_classes[y][1] + " Announcements :")))
    for i in range(0,(len(barray))):
        if i < 17:
            barray[i].place(x = 7, y = i*25)
            barray[i].configure(background='black',foreground='white')
        else:
            barray[i].place(x =300, y = (i-17)*25)
            barray[i].configure(background='black',foreground='white')
            
def g10_click():
    main_link = "http://myclass.peelschools.org/PDSBWS/wsecondarySiteList.aspx?SchoolNumber=2652"
    g10 = Tk()
    g10.title("Classmate: Grade 10")
    g10.configure(background='white')
    g10.resizable (width=False, height=False)    
    g10.geometry("600x500")
    Gradeten= Label(g10,text= "Grade 10")
    Gradeten.place(x=280,y=420)
    Gradeten.configure(background='white',font=("Times New Roman",60))    
    barray2 = []
    
    for i in range(0,(len(g10_classes))):
        barray2.append(Button(g10,text =g10_classes[i][0] + "-" + g10_classes[i][1],height = 1, width = 40, command = lambda y = i: link_click(g10_classes[y][2],g10_classes[y][0] + "-" + g10_classes[y][1] + " Announcements :")))
    for i in range(0,(len(barray2))):
        if i < 17:
            barray2[i].place(x = 7, y = i*25)
            barray2[i].configure(background='black',foreground='white')
        else:
            barray2[i].place(x =300, y = (i-17)*25)
            barray2[i].configure(background='black',foreground='white')
            
def g11_click():
    main_link = "http://myclass.peelschools.org/PDSBWS/wsecondarySiteList.aspx?SchoolNumber=2652"
    g11 = Tk()
    g11.title("Classmate: Grade 11")
    g11.configure(background='white')
    g11.resizable (width=False, height=False)
    g11.geometry("600x500")
    Gradeeleven= Label(g11,text= "Grade 11")
    Gradeeleven.place(x=280,y=420)
    Gradeeleven.configure(background='white',font=("Times New Roman",60))        
    barray3 = []
    
    for i in range(0,(len(g11_classes))):
        barray3.append(Button(g11,text =g11_classes[i][0] + "-" + g11_classes[i][1],height = 1, width = 40,command = lambda y = i: link_click(g11_classes[y][2],g11_classes[y][0] + "-" + g11_classes[y][1] + " Announcements :")))
    for i in range(0,(len(barray3))):
        if i < 17:
            barray3[i].place(x = 7, y = i*25)
            barray3[i].configure(background='black',foreground='white')
        else:
            barray3[i].place(x =300, y = (i-17)*25)
            barray3[i].configure(background='black',foreground='white')
    
def g12_click():
    main_link = "http://myclass.peelschools.org/PDSBWS/wsecondarySiteList.aspx?SchoolNumber=2652"
    g12 = Tk()
    g12.title("Classmate: Grade 12")
    g12.configure(background='white')
    g12.geometry("600x500")
    g12.resizable (width=False, height=False)
    Gradetwelve= Label(g12,text= "Grade 12")
    Gradetwelve.place(x=280,y=420)
    Gradetwelve.configure(background='white',font=("Times New Roman",60))        
    barray4 = []
    for i in range(0,(len(g12_classes))):
        barray4.append(Button(g12,text =g12_classes[i][0] + "-" + g12_classes[i][1],height = 1, width = 40, command = lambda y = i: link_click(g12_classes[y][2],g12_classes[y][0] + "-" + g12_classes[y][1] + " Announcements :")))
    for i in range(0,(len(barray4))):
        if i < 17:
            barray4[i].place(x = 7, y = i*25)
            barray4[i].configure(background='black',foreground='white')
        else:
            barray4[i].place(x =300, y = (i-17)*25)
            barray4[i].configure(background='black',foreground='white')
 
    
link = urlopen("http://myclass.peelschools.org/PDSBWS/wsecondarySiteList.aspx?SchoolNumber=2652")#link where html code for jfss myclass site is found
raw_text = link.read()
raw_text = str(raw_text)

temparray = []

while raw_text.find('target="_blank">') != -1: #This is a signature used to find each course page
    i = raw_text.find('target="_blank">') 
    temparray.append(raw_text[i-80:i+80])
    raw_text = raw_text[i+40:]
    
codes = []
descrip = []
courselink = []
temp1 = [] 
output = []
g9_classes = []
g10_classes = []
g11_classes = []
g12_classes = []
    
for i in range (0,(len(temparray))):
    if temparray[i].find('<td width="36%">') != -1: #Signature to find each course code
        y = temparray[i].find('<td width="36%">')
        codes.append(temparray[i][y+16:y+23])
    if temparray[i].find('target="_blank">') != -1:
        x = temparray[i].find('target="_blank">')
        y = temparray[i].find('</a></td>')
        descrip.append(temparray[i][x+16:y])
    if temparray[i].find('<td width="64%"><a href="') != -1: #Signature to find the class name
        x = temparray[i].find('<td width="64%"><a href="')
        y = temparray[i].find('target="_blank">')
        courselink.append(temparray[i][x+25:y-2])  
for i in range (0,len(codes)):
    temp1.append(codes[i])
    temp1.append(descrip[i+1]) #Stores each course code with its corresponding name
    temp1.append(courselink[i])
    output.append(temp1)
    temp1 = []
for i in range(0, (len(output))):
    if output[i][0][3] == "1":
        g9_classes.append(output[i])
    elif output[i][0][3] == "2":
        g10_classes.append(output[i]) #Division according to each grade
    elif output[i][0][3] == "3":
        g11_classes.append(output[i])
    elif output[i][0][3] == "4":
        g12_classes.append(output[i])
    else:
        g9_classes.append(output[i])
        
temparray = []
codes = []
descrip = []
courselink = []
temp1 = [] 
output = []

main = Tk()

main.title("Classmate")#Configuration of the main page
main.geometry("500x500")
main.resizable (width=False, height=False)
main.configure(background='white')

g9x = Button(main,text ="Grade 9",height = 5, width = 10, command = g9_click) #Button configurations
g9x.configure(background='black',foreground= 'white', font = ("Copperplate Gothic Bold", 10))
g10x = Button(main,text ="Grade 10",height = 5, width = 10, command = g10_click)
g10x.configure(background='black',foreground= 'white', font = ("Copperplate Gothic Bold", 10))
g11x = Button(main,text ="Grade 11",height = 5, width = 10, command = g11_click)
g11x.configure(background='black',foreground= 'white', font = ("Copperplate Gothic Bold", 10))
g12x = Button(main,text ="Grade 12",height = 5, width = 10, command = g12_click)
g12x.configure(background='black',foreground= 'white', font = ("Copperplate Gothic Bold", 10))

#Button and label configurations below

welcomeText = Label(main,text= "Welcome to Classmate, for JFSS. Choose your grade.")
welcomeText.configure(background='white', font=("Elephant", 12))




B1 = Button(main, text = "Saved Courses", command = opensave)
B1.configure(background='black',foreground ='white' , font=("Copperplate Gothic Bold", 10))
B1.place(x=375,y=5)

typltext= Label(main, text = "#TYPL™")
typltext.configure(background="white")


source = PhotoImage(file="logo.gif")

pic = Label(main, image=source)
pic.configure(background='white')
pic.source = source
pic.place(x=130,y=40)




g9x.place(x=0, y=0)

g10x.place(x=0, y=100)
g11x.place(x=0, y=200)
g12x.place(x=0, y=300)


welcomeText.place(x=35,y=425)
typltext.place (x=450,y=475)
main.mainloop()



'''
Bibliography: We used ideas from the following links to implement the program

https://docs.python.org/2/using/cmdline.html
file:///C:/Python27/Lib/site-packages/wx-3.0-msw/docs/MigrationGuide.html
https://code.google.com/p/gui2py/source/browse/sample.pyw
http://www.tutorialspoint.com/python/tk_button.htm
http://stackoverflow.com/questions/10927234/setting-the-position-on-a-button-in-python
http://www.secnetix.de/olli/Python/lambda_functions.hawk
http://www.daniweb.com/software-development/python/threads/166751/tkinter-button-widget-passing-parameter-to-function
http://stackoverflow.com/questions/15457504/python-how-to-set-font-size-of-tkinter-text
http://effbot.org/tkinterbook/label.htm
http://stackoverflow.com/questions/9987624/how-to-close-a-tkinter-window-by-pressing-a-button
#TYPL

'''

