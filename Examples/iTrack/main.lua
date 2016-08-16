--main screen
local w = display.contentWidth
local h = display.contentHeight

local background = display.newImage("background.jpg")
background: translate(159, 250)
background: scale(1.2,1.2)


local largelogo = display.newImage("iconthr.png")
largelogo: scale(0.2,0.2)
largelogo: translate(w/2,h/2)

local txttaptobegin = display.newText("Tap to Begin", 100, 100, "Calibri", 20)
    txttaptobegin.x = w/1.5
    txttaptobegin.y = h/1.3

function blink()
    if(txttaptobegin.alpha < 1) then
        transition.to( txttaptobegin, {time=490, alpha=1})
    else
        transition.to( txttaptobegin, {time=490, alpha=0.1})
    end
end

txtblink = timer.performWithDelay(500, blink, 0)

local txtiTracktitle = display.newText("iTrack",w/2,h/10, native.FontBold,60)
txtiTracktitle: setFillColor(0.9,0.7,0.55)

local mainscnobject = display.newGroup()
mainscnobject:insert(largelogo)
mainscnobject:insert(txtiTracktitle)
mainscnobject:insert(txttaptobegin)

function largelogo: tap(event)
	mainscnobject.isVisible = false

end
largelogo:addEventListener("tap", largelogo)


--WelcometoiTrack screen
local WelcometoiTrack = display.newText( "Welcome to iTrack", 160, 55,"Calibri",38)
WelcometoiTrack: setFillColor(1,1,1)

local login = display.newText("Login", 50, 125, "Calibri", 35)
login: setFillColor(1,1,1)

local username = display.newText("username:", 90, 165, "Calibri", 25)
local password = display.newText("password:", 90,200,"Calibri", 25)
local unbox = native.newTextField( 220, 165, 130, 25)
local pwbox = native.newTextField( 220, 200, 130, 25)
local forgotpassword = display.newText("Forgot password ?", 220,222,"Calibri", 15)
forgotpassword: setFillColor(1,1,1)
local nacbox = display.newRect(70,320,120,40)
nacbox: setFillColor(0.69,0.9,1)

local newaccount = display.newText("Register", 70,320,"Calibri", 27)
newaccount: setFillColor(1,1,1)

local startbutton = display.newRect(70,260,120,40)
startbutton:setFillColor(0.69,0.9,1)

local start = display.newText("Start", 72, 260, "Calibri", 27)
start: setFillColor(1,1,1)
start:toFront()

local icon = display.newImage("icondesign.png")
icon: scale(0.05,0.05)
icon: translate(w/1.1,h/4.53)

local questionbutton = display.newCircle(290,450,15)
questionbutton:setFillColor(1,1,1)

local question = display.newText("?", 290, 450, "Calibri", 28)
question: setFillColor(0,0,0)

local btnbackmainscn = display.newImage("back.png")
btnbackmainscn: scale(0.15,0.15)
btnbackmainscn: translate(w/11,h/1.05)

local btnbackwelcometoitrackscn = display.newImage("back.png")
btnbackwelcometoitrackscn: scale(0.15,0.15)
btnbackwelcometoitrackscn: translate(w/11,h/1.05)

local btnbackitrackprofilescn = display.newImage("back.png")
btnbackitrackprofilescn: scale(0.15,0.15)
btnbackitrackprofilescn: translate(w/11,h/1.05)

local welcometoitrackscnobject = display.newGroup()
welcometoitrackscnobject:insert(WelcometoiTrack)
welcometoitrackscnobject:insert(login)
welcometoitrackscnobject:insert(username)
welcometoitrackscnobject:insert(unbox)
welcometoitrackscnobject:insert(password)
welcometoitrackscnobject:insert(pwbox)
welcometoitrackscnobject:insert(forgotpassword)
welcometoitrackscnobject:insert(nacbox)
welcometoitrackscnobject:insert(newaccount)
welcometoitrackscnobject:insert(startbutton)
welcometoitrackscnobject:insert(start)
welcometoitrackscnobject:insert(btnbackmainscn)


--iTrackProfile screen
local iTrackProfiletitle = display.newText( "iTrack Profile",160, 55,"Calibri",38)
iTrackProfiletitle: setTextColor(1,1,1)
local diabetestype = display.newText( "Diabetes Type : ", 116, 150,"Calibri", 25 )
local diabeteslevelbox = display.newRect(226,150,30,30)
diabeteslevelbox: setFillColor(1,1,1)
local diabeteslevel = display.newText("",225,150,"Calibri", 25)
diabeteslevel: setFillColor(0,0,0)
local createnewnot = display.newRect(150, 250, 250, 50)
createnewnot: setFillColor(0.69,0.9,1)
local txtcreatenewnot = display.newText("Create new notification",150,250,"Calibri",22)
txtcreatenewnot:setFillColor (1,1,1)
local recordsuglv = display.newRect(150, 325, 250, 50)
recordsuglv: setFillColor(0.69,0.9,1)
local txtrecordsuglv = display.newText("Record sugar level", 150, 325, "Calibri", 22)
txtrecordsuglv:setFillColor (1,1,1)
local viewentries = display.newRect(150, 400, 250, 50)
viewentries: setFillColor(0.69,0.9,1)
local txtviewentries = display.newText("View Entries", 150, 400, "Calibri", 22)
txtviewentries:setFillColor (1,1,1)

local iTrackprofilescnobject = display.newGroup()
iTrackprofilescnobject:insert(iTrackProfiletitle)
iTrackprofilescnobject:insert(diabetestype)
iTrackprofilescnobject:insert(diabeteslevel)
iTrackprofilescnobject:insert(diabeteslevelbox)
iTrackprofilescnobject:insert(createnewnot)
iTrackprofilescnobject:insert(recordsuglv)
iTrackprofilescnobject:insert(viewentries)
iTrackprofilescnobject:insert(txtviewentries)
iTrackprofilescnobject:insert(txtrecordsuglv)
iTrackprofilescnobject:insert(txtcreatenewnot)
iTrackprofilescnobject:insert(btnbackwelcometoitrackscn)

--Register screen
local register = display.newText("Register",160, 55,"Calibri",38)
register: setFillColor(1,1,1)
local txtfirstname = display.newText("First Name: ",70, 125, "Calibri", 25 )
txtfirstname: setFillColor(1,1,1)
local txtboxfirstname = native.newTextField( 200,125,120, 25)
local txtlastname = display.newText("Last Name: ",70, 160, "Calibri", 25 )
txtlastname:setFillColor(1,1,1)
local txtboxlastname = native.newTextField( 200,160,120,25)
local regscndiabetestype = display.newText("Diabetes Type: ",90, 220, "Calibri", 25 )
local txtboxregscndiabetestype = native.newTextField(200,225,40,25)
local txtcreateusername = display.newText("Create Username: ",110, 300, "Calibri", 25 )
txtcreateusername:setFillColor (1,1,1)
local txtboxcreateusername = native.newTextField( 260,305,100,25)
local txtcreatepassword = display.newText("Create password: ",105, 330, "Calibri", 25 )
txtcreateusername: setFillColor(1,1,1)
local txtboxcreatepassword = native.newTextField( 260,335,100,25)

local regscnboxsave = display.newRect(w/1.2, h/1.2, 90, 40)
regscnboxsave: setFillColor(0.69,0.9,1)

local regscntxtsave = display.newText("Save", w/1.2, h/1.2,"Calibri",20)
regscntxtsave:setFillColor (1,1,1)

local regscnboxcancel = display.newRect(w/5, h/1.2,90,40)
regscnboxcancel: setFillColor(0.69,0.9,1)

local regscntxtcancel = display.newText("Cancel", w/5, h/1.2,"Calibri",20)
regscntxtcancel:setFillColor (1,1,1)

local regscnobject = display.newGroup()
regscnobject:insert(register)
regscnobject:insert(txtfirstname)
regscnobject:insert(txtboxfirstname)
regscnobject:insert(txtlastname)
regscnobject:insert(txtboxlastname)
regscnobject:insert(regscndiabetestype)
regscnobject:insert(txtboxregscndiabetestype)
regscnobject:insert(txtcreateusername)
regscnobject:insert(txtboxcreateusername)
regscnobject:insert(txtcreatepassword)
regscnobject:insert(txtboxcreatepassword)
regscnobject:insert(regscnboxsave)
regscnobject:insert(regscnboxcancel)
regscnobject:insert(regscntxtsave)
regscnobject:insert(regscntxtcancel)


--iTrackNotification screen
local iTrackNotificationtitle = display.newText( "iTrack Notification", 160, 60,"Calibri", 38 )
iTrackNotificationtitle: setTextColor(1,1,1)
title = display.newText( "Title : ", 50, 130,"Calibri", 30 )

local titleipbox = native.newTextField( 160, 175, 300, 35)

local lineuntitle = display.newLine(10,210,300,210)
lineuntitle.strokeWidth = 5
txtsetnotification = display.newText( "Set notification : ", 120, 240,"Calibri", 30 )

local time = display.newText( "Time", 40,280,"Calibri", 22)
local timeipbox = native.newTextField(60, 310, 90, 25)
local day = display.newText( "Day", 197,280,"Calibri", 22)
local dayipbox = native.newTextField(220, 310, 90, 25)
local lineunsetnot = display.newLine(10,340,300,340)
lineunsetnot.strokeWidth = 5

local notboxsave = display.newRect(60, 380, 90, 40)
notboxsave: setFillColor(0.69,0.9,1)

local txtsave = display.newText("SAVE",60,380,"Calibri",20)
txtsave:setFillColor (1,1,1)

local notboxcancel = display.newRect(160, 380, 90, 40)
notboxcancel: setFillColor(0.69,0.9,1)

local txtcancel = display.newText("CANCEL",160,380,"Calibri",20)
txtcancel:setFillColor (1,1,1)

local iTracknotificationscnobject = display.newGroup()
iTracknotificationscnobject:insert(iTrackNotificationtitle)
iTracknotificationscnobject:insert(title)
iTracknotificationscnobject:insert(titleipbox)
iTracknotificationscnobject:insert(lineuntitle)
iTracknotificationscnobject:insert(txtsetnotification)
iTracknotificationscnobject:insert(time)
iTracknotificationscnobject:insert(day)
iTracknotificationscnobject:insert(timeipbox)
iTracknotificationscnobject:insert(dayipbox)
iTracknotificationscnobject:insert(lineunsetnot)
iTracknotificationscnobject:insert(txtsave)
iTracknotificationscnobject:insert(notboxsave)
iTracknotificationscnobject:insert(notboxcancel)
iTracknotificationscnobject:insert(txtsave)
iTracknotificationscnobject:insert(txtcancel)
iTracknotificationscnobject:insert(btnbackitrackprofilescn)

--Record screen
local titlerecord = display.newText("Record",w/2,h/9, native.FontBold,38)

local txtsugarlv = display.newText("Sugar Level: ",w/3.7,h/3, "Calibri",30)
local txtboxsugarlv = native.newTextField(w/1.65,h/2.9, 60, 30)
local unitmgdL = display.newText("mg/dL",w/1.24,h/2.8, "Calibri",20)


local txtbloodpre = display.newText("Blood Pressure: ",w/3,h/2.1, "Calibri",30)
local txtboxbloodpre = native.newTextField(w/1.4,h/2.05, 50, 30)
local unitmmHg = display.newText("mmHg",w/1.1,h/2, "Calibri",20)

local btnbackweeklyscn = display.newImage("back.png")
btnbackweeklyscn: scale(0.15,0.15)
btnbackweeklyscn: translate(w/11,h/1.05)

local recrodscnboxsave = display.newRect(w/1.2, h/1.2, 90, 40)
recrodscnboxsave: setFillColor(0.69,0.9,1)

local recrodscntxtsave = display.newText("Save", w/1.2, h/1.2,"Calibri",20)
recrodscntxtsave:setFillColor (1,1,1)

local recrodscnobject = display.newGroup()
recrodscnobject:insert(titlerecord)
recrodscnobject:insert(txtsugarlv)
recrodscnobject:insert(txtboxsugarlv)
recrodscnobject:insert(unitmgdL)
recrodscnobject:insert(txtbloodpre)
recrodscnobject:insert(txtboxbloodpre)
recrodscnobject:insert(unitmmHg)
recrodscnobject:insert(btnbackweeklyscn)
recrodscnobject:insert(recrodscnboxsave)
recrodscnobject:insert(recrodscntxtsave)


--weekly screen
local weekly = display.newText( "Weekly",160, 55,"Calibri",38)
local imgweek = display.newImage("week.jpg")
imgweek: translate(w/2,h/1.8)
imgweek: scale(1.2,1.2)

local btnbackitrackprofilescn2 = display.newImage("back.png")
btnbackitrackprofilescn2: scale(0.15,0.15)
btnbackitrackprofilescn2: translate(w/11,h/1.05)

local weeklyscnobject = display.newGroup()
weeklyscnobject:insert(weekly)
weeklyscnobject:insert(imgweek)
weeklyscnobject:insert(btnbackitrackprofilescn2)

--help centre page
local txthelpcentre = display.newText("Help Centre",  160, 55,"Calibri",38)
local txtwhatisitrack = display.newText("What is iTrack?", w/3.3, h/3.5,"Calibri", 30)
local txtwhatisitrackcontent = display.newText("iTrack is an app that targets diabetic patients and is used to provide efficiency.  The app is a personal tracking device that allows patients to record their insulin intake and keep track of their sugar levels. The app is basically formatted to be a visual time table that allows patients to access and organize important information regarding their health requirements.", w/2, h/1.2,w-10,h-10,"Calibri", 16)
local txtenterquestion = display.newText("Enter question:", w/3.3, h/1.3, "Calibri", 30)
local txtboxquestion = native.newTextField( w/2.5, h/1.17, w/1.3, 30)
local txtenter = display.newText("ENTER", w/1.5, h/1.06,"Calibri",20)
txtenter:setFillColor (1,1,1)
local boxenterquestion = display.newRect(w/1.5, h/1.06, 90, 40)
boxenterquestion: setFillColor(0.69,0.9,1)

local btnbackmainscn1 = display.newImage("back.png")
btnbackmainscn1: scale(0.15,0.15)
btnbackmainscn1: translate(w/11,h/1.05)

local helpcentrescnobject = display.newGroup()
helpcentrescnobject:insert(txthelpcentre)
helpcentrescnobject:insert(txtwhatisitrack)
helpcentrescnobject:insert(txtwhatisitrackcontent)
helpcentrescnobject:insert(boxenterquestion)
helpcentrescnobject:insert(txtboxquestion)
helpcentrescnobject:insert(txtenter)
helpcentrescnobject:insert(txtenterquestion)
helpcentrescnobject:insert(btnbackmainscn1)

--thank you page
local txtthankyou = display.newText("Thank You",  w/2, h/2.5,"Calibri",45)
local txtwewillanswerurquestionasap = display.newText("We will answer your question as soon as possible",  w/1.9, h/1.01,w-50,h,"Calibri",28)

local btnbackmainscn2 = display.newImage("back.png")
btnbackmainscn2: scale(0.15,0.15)
btnbackmainscn2: translate(w/11,h/1.05)

local thankyouscnobject = display.newGroup()
thankyouscnobject:insert(txtthankyou)
thankyouscnobject:insert(txtwewillanswerurquestionasap)
thankyouscnobject:insert(btnbackmainscn2)

------------------------------------------------------------------

welcometoitrackscnobject.alpha = 0
iTrackprofilescnobject.alpha = 0
iTracknotificationscnobject.alpha = 0
helpcentrescnobject.alpha = 0
thankyouscnobject.alpha = 0
regscnobject.alpha = 0
weeklyscnobject.alpha = 0
recrodscnobject.alpha = 0

function largelogo: tap(event)
	mainscnobject.alpha = 0
	welcometoitrackscnobject.alpha = 1

end
largelogo:addEventListener("tap", largelogo)

function startbutton: tap(event)
		welcometoitrackscnobject.alpha = 0
		iTrackprofilescnobject.alpha = 1

end
startbutton:addEventListener( "tap", startbutton )

function createnewnot:tap (event)
	iTrackprofilescnobject.alpha = 0
	iTracknotificationscnobject.alpha = 1

end
createnewnot:addEventListener( "tap", createnewnot)

function questionbutton: tap(event)
	mainscnobject.alpha = 0
	welcometoitrackscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 0
	iTracknotificationscnobject.alpha = 0
	thankyouscnobject.alpha = 0
	regscnobject.alpha = 0
	weeklyscnobject.alpha = 0
	recrodscnobject.alpha = 0
	helpcentrescnobject.alpha = 1


end
questionbutton:addEventListener( "tap", questionbutton )

function btnbackmainscn: tap(event)
	welcometoitrackscnobject.alpha = 0
	mainscnobject.alpha = 1
end
btnbackmainscn:addEventListener("tap",btnbackmainscn)

function btnbackmainscn1: tap(event)
	helpcentrescnobject.alpha = 0
	mainscnobject.alpha = 1
end
btnbackmainscn1:addEventListener("tap",btnbackmainscn1)

function btnbackmainscn2: tap(event)
	thankyouscnobject.alpha = 0
	mainscnobject.alpha = 1
end
btnbackmainscn2:addEventListener("tap",btnbackmainscn2)

function btnbackwelcometoitrackscn: tap(event)
	iTrackprofilescnobject.alpha = 0
	welcometoitrackscnobject.alpha = 1
end
btnbackwelcometoitrackscn:addEventListener("tap",btnbackwelcometoitrackscn)


function btnbackitrackprofilescn: tap(event)
	iTracknotificationscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 1
end
btnbackitrackprofilescn:addEventListener("tap",btnbackitrackprofilescn)

function boxenterquestion:tap(event)
	helpcentrescnobject.alpha = 0
	thankyouscnobject.alpha = 1
end
boxenterquestion:addEventListener("tap",boxenterquestion)

function regscnboxsave: tap(event)
	regscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 1
end
regscnboxsave:addEventListener("tap",regscnboxsave)

function regscnboxcancel: tap(event)
	regscnobject.alpha = 0
	welcometoitrackscnobject.alpha = 1
end
regscnboxcancel:addEventListener("tap",regscnboxcancel)


function nacbox: tap(event)
	welcometoitrackscnobject.alpha = 0
	regscnobject.alpha = 1
end
nacbox:addEventListener("tap",nacbox)

function btnbackitrackprofilescn2: tap(event)
	weeklyscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 1
end
btnbackitrackprofilescn2:addEventListener("tap",btnbackitrackprofilescn2)

function notboxsave: tap(event)
	iTracknotificationscnobject.alpha = 0
	weeklyscnobject.alpha = 1
end
notboxsave:addEventListener("tap",notboxsave)

function viewentries: tap(event)
	iTrackprofilescnobject.alpha = 0
	weeklyscnobject.alpha = 1
end
viewentries:addEventListener("tap",viewentries)

function btnbackweeklyscn: tap(event)
	recrodscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 1
end
btnbackweeklyscn:addEventListener("tap",btnbackweeklyscn)

function recordsuglv: tap(event)
	iTrackprofilescnobject.alpha = 0
	recrodscnobject.alpha = 1
end
recordsuglv:addEventListener("tap",recordsuglv)

function recrodscnboxsave: tap(event)
	recrodscnobject.alpha = 0
	weeklyscnobject.alpha = 1
end
recrodscnboxsave:addEventListener("tap",recrodscnboxsave)


function notboxcancel: tap(event)
	iTracknotificationscnobject.alpha = 0
	iTrackprofilescnobject.alpha = 1
end
notboxcancel:addEventListener("tap",notboxcancel)


----------------------------------------------------------------------


------------------------------------------------------------------

---------------------------------------------------------------------
-- SQLite specific tests and configurations.
-- $Id: sqlite3.lua,v 1.2 2007/10/16 15:42:50 carregal Exp $
---------------------------------------------------------------------

--[[DROP_TABLE_RETURN_VALUE = 1

---------------------------------------------------------------------
-- Produces a SQL statement which completely erases a table.
-- @param table_name String with the name of the table.
-- @return String with SQL statement.
---------------------------------------------------------------------
function sql_erase_table (table_name)
	return string.format ("delete from %s where 1", table_name)
end

function checkUnknownDatabase(ENV)
	-- skip this test
end


INSERT INTO test VALUES ('n.a', 'n');

INSERT INTO test VALUES ('s.g', 's');

INSERT INTO test VALUES ('c.k', 'c');]]--

-----------------------------------------------------------------------------------------------

-- This section of code is for creating a database using SQL (login system: username and password)
-- unfortunately we do not have sqlite

--require "sqlite3"
--local path = system.pathForFile("data.db", system.DocumentDirectory)
--local db = sqlite3.open( path )

--local tablesetup = [[CREATE TABLE IF NOT EXISTS test (username PRIMARY KEY autoincrement, password);]]
--db: exec (tablesetup)
--local insertQuery =[[INSERT INTO test VALUES ('n.a', 'n');]]
--db:exec(insetQuery)
--local accounts =
--{
--	{
--		username = s.g,
--		password = s,
--	},
--	{
--		username = c.k,
--		password = c,
--	}
--}
--for i=1, #accounts do
--	local q = [[INSERT INTO test VALUES (n.a,')]] .. accounts[i].username .. [[',']]
--		.. accounts[i].password .. [[',']]
--	db:exec(q)
--end

--local function onSystemEvent (event)
--	if event.type == "applicationExit" then
--		if db and db:isopen() then
--			db:close()
--		end
--	end
--end
--Runtime:addEventListener("system", onsystemEvent)

--------------------------------------------------------------------------------
