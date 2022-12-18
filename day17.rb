rockList=[]
fallList=[]
leftList=[]
rightList=[]
topList=[]

rockList.push([[1,1,1,1]])
fallList.push([[-1,0],[-1,1],[-1,2],[-1,3]])
leftList.push([[0,-1]])
rightList.push([[0,4]])
topList.push([[0,0],[0,1],[0,2],[0,3]])

rockList.push([[0,1,0],[1,1,1],[0,1,0]])
fallList.push([[0,0],[-1,1],[0,2]])
leftList.push([[0,0],[1,-1],[2,0]])
rightList.push([[0,2],[1,3],[2,2]])
topList.push([[1,0],[2,1],[1,2]])

rockList.push([[1,1,1],[0,0,1],[0,0,1]])
fallList.push([[-1,0],[-1,1],[-1,2]])
leftList.push([[0,-1],[1,1],[2,1]])
rightList.push([[0,3],[1,3],[2,3]])
topList.push([[0,0],[0,1],[2,2]])

rockList.push([[1],[1],[1],[1]])
fallList.push([[-1,0]])
leftList.push([[0,-1],[1,-1],[2,-1],[3,-1]])
rightList.push([[0,1],[1,1],[2,1],[3,1]])
topList.push([[3,0]])

rockList.push([[1,1],[1,1]])
fallList.push([[-1,0],[-1,1]])
leftList.push([[0,-1],[1,-1]])
rightList.push([[0,2],[1,2]])
topList.push([[1,0],[1,1]])

windAry=File.open("day17.txt").read.chomp.split("")
$room=[]
for i in 0...1000000
    $room.push([0,0,0,0,0,0,0])
end



def addToRoom(rock,bottom,left)
    for i in 0...rock.length
        for j in 0...rock[0].length
            if rock[i][j]==1
                $room[i+bottom][j+left]=rock[i][j]
            end
        end
    end
end

def printRoom(rock,bottom,left,height,dir)
    p ["b:",bottom,left,height,dir]
    frameBottom=bottom-25
    if frameBottom<0
        frameBottom=0
    end
    frameTop=frameBottom+30
    for i in $room.length-frameTop...$room.length-frameBottom
        ip=$room.length-i-1
        $room[ip].each_with_index do |e,j|
            filled=false
            if e==1
                print "#"
                filled=true
            elsif rock!=nil
                posY=ip-bottom
                posX=j-left
                if posY>=0 && posY<rock.length && posX>=0 && posX<rock[0].length
                    if rock[posY][posX]==1
                        print dir
                        filled=true
                    end
                end
            end
            if !filled
                print "."
            end

        end
        print "\n"
    end
end
rockCount=0
done=false
currentRock=-1
currentWind=-1
height=0
testRock=7
base=0
minColumns=[-1,-1,-1,-1,-1,-1,-1]
rocksToDrop=1000000000000
matchColumn=[0,0,0,0,0,1,0]
startRocks=2052
cycleLength=1735
cycles=(rocksToDrop-startRocks)/cycleLength
cycleHeight=2781
rocksLeft=rocksToDrop-cycles*cycleLength
p [startRocks,cycles,rocksLeft]
#sleep(10)
heightFromCycles=cycles*cycleHeight
while !done
    if minColumns.map{|e| e-minColumns.min()}==matchColumn
        p ["flat:",currentRock,currentWind,height,base,rockCount]
        p minColumns.map{|e| e-minColumns.min}
        p [minColumns.min(),minColumns.max()]
        printRoom(nil,height+3,2,height,"V")
        sleep(1)
    end
    currentRock=(currentRock+1)%rockList.length
    rockCount=rockCount+1
    bottom=height+3-base
    left=2
    rock=rockList[currentRock]
  #  sleep(1)
    landed=false
    while !landed
        currentWind=(currentWind+1)%windAry.length
        if windAry[currentWind]=="<"
            if left>0
                leftClear=true
                leftList[currentRock].each do |l|
   #                 p [bottom,left,height,base,l]
                    if $room[bottom+l[0]][left+l[1]]==1
                        leftClear=false
                    end
                end
                if leftClear
                    left=left-1
                end
            end
        else
            if left+rock[0].length<7
                rightClear=true
                rightList[currentRock].each do |r|
                    if $room[bottom+r[0]][left+r[1]]==1
                        rightClear=false
                    end
                end
                if rightClear
                    left=left+1
                end
            end
        end
        if currentRock==testRock
            printRoom(rock,bottom,left,height,windAry[currentWind])
            sleep(0.2)
        end
        
        fallClear=true
        if bottom==0
            fallClear=false
        else
            fallList[currentRock].each do |f|
                if $room[bottom+f[0]][left+f[1]]==1
                    fallClear=false
                end
            end
        end
        if fallClear
            bottom=bottom-1
            if currentRock==testRock
                printRoom(rock,bottom,left,height,"v")
                sleep(0.2)
            end            
        else
            addToRoom(rockList[currentRock],bottom,left)
            if currentRock==testRock
                printRoom(nil,bottom,left,height,windAry[currentWind])
                sleep(1)
            end
            top=bottom+rockList[currentRock].length+base
            if top>height
                height=top
            end
            landed=true
        end
    end
    if rockCount>=1970 &&rockCount<1980
  #      printRoom(nil,bottom,left,height,"U")
  #      p [rockCount,1000000000000-rockCount,currentRock,height,bottom,left,base]
    end
    topList[currentRock].each do |t|
        if minColumns[t[1]+left]<t[0]+bottom
            minColumns[t[1]+left]=t[0]+bottom
        end
    end

    if rockCount>=rocksLeft
        p [height,heightFromCycles,height+heightFromCycles]
        done=true
    end

end

