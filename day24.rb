$blizzardAry=[]
$blizzardAry.push([])
$blizzardHash={}
$length=0
$height=0
$cycleLength=0
$cycleAry=[]
$cycleBackAry=[]
$testAry=[]
$testBackAry=[]
$posX=3
$posY=1
def printCycleAry(i)
    p i
    $cycleAry[i].each do |row|
        p row     
    end
end

  
def testLocation(v)
    i=v[0]
    x=v[1]
    y=v[2]
    if $blizzardHash[[(x-i)%$length,y]]==">"
        return false,">"
    elsif $blizzardHash[[(x+i)%$length,y]]=="<"
        return false,"<"
    elsif $blizzardHash[[x,(y-i)%$height]]=="v"
        return false,"v"
    elsif $blizzardHash[[x,(y+i)%$height]]=="^"
        return false,"^"
    end
    return true,""
end




def printBlizzard(i,locX,locY)
    p ["printing",i]
    for y in 0...$height
        for x in 0...$length
            found,res=testLocation([i,x,y])
            if found && locX==x && locY==y
               print "O"
            elsif found
                print "."
            else
                print res
            end
        end
        print "\n"
    end 
end
y=-1
File.open("input24.txt").each_line do |l|
    y=y+1
    if l[3]!="#"
        $height=$height+1
        $length=l.chomp.length-2
        ary=[]
        for i in 1...l.chomp.length-1
            if l[i...i+1]!="."
                $blizzardHash[[i-1,y-1]]=l[i]
            end
        end
    end
end


$cycleLength=$length*$height
p [$length,$height,$cycleLength]

def clearCycle()
    if $cycleAry.length==0
        p "here"
        for i in 0...$cycleLength
            table=[]
            for j in 0...$height
                row=[]
                for k in 0...$length
                    row.push(-1)
                end
                table.push(row)
            end
            $cycleAry.push(table)
        end
    else
        for i in 0...$cycleLength
            for j in 0...$height
                for k in 0...$length
                    $cycleAry[i][j][k]=-1
                end
            end
        end
    end
#    p $cycleAry
    p "cycle cleared"
end
p "loaded"
thereFlag=false
thereTime=-1
backFlag=false
backTime=-1
doneFlag=false
doneTime=-1
for i in 0...$cycleLength
    time=(i+1)%$cycleLength
    kalpa=((i+1).to_f/$cycleLength).floor
    $testAry.push([[time,0,0],kalpa])
    p [time,kalpa]
end
clearCycle()
while !doneFlag
    while $testAry.length>0
        landed=false
        v=$testAry.shift()
        testResult,_=testLocation(v[0])
        if testResult
            loc=$cycleAry[v[0][0]][v[0][2]][v[0][1]]
            if loc==-1
                $cycleAry[v[0][0]][v[0][2]][v[0][1]]=v[1]
                landed=true
            elsif loc>v[1]
                $cycleAry[v[0][0]][v[0][2]][v[0][1]]=v[1]
                landed=true
            end
            if landed
                newTime=(v[0][0]+1)%$cycleLength
                kalpa=v[1]+((v[0][0]+1).to_f/$cycleLength).floor
  
    

                if v[0][1]>0
                    $testAry.push([[newTime,v[0][1]-1,v[0][2]],kalpa])
                end
                if v[0][2]>0
                    $testAry.push([[newTime,v[0][1],v[0][2]-1],kalpa])
                end
                if v[0][1]<$length-1
                    $testAry.push([[newTime,v[0][1]+1,v[0][2]],kalpa])
                end
                if v[0][2]<$height-1
                    $testAry.push([[newTime,v[0][1],v[0][2]+1],kalpa])
                end
                $testAry.push([[newTime,v[0][1],v[0][2]],kalpa])     
            end
        end
   
        if $testAry.length==0
            posX=$length-1
            posY=$height-1
            if thereFlag && !backFlag
                posX=0
                posY=0
            end
         #   p ["xy",posX,posY]
            for i in 0...$cycleLength
         #       p $cycleAry[i][posY][posX]
            end
            minKalpa=-1
            minTime=$cycleLength
            for i in 0...$cycleLength
                kalpa=$cycleAry[i][posY][posX]
                if kalpa>=0
                    if kalpa<minKalpa || minKalpa==-1
                        minKalpa=kalpa
                        minTime=i
                    end
                end
            end
            if !thereFlag
                thereFlag=true
                thereTime=minKalpa*$cycleLength+minTime+1
                p ["there at ", thereTime]
                for i in 0...$cycleLength
                    startTime=(thereTime+i+1)%$cycleLength
              #      p startTime
             #       gets
                    startKalpa=((thereTime+i+1).to_f/$cycleLength).floor
                    $testAry.push([[startTime,$length-1,$height-1],startKalpa])
           #         p [startTime,startKalpa]  
            #        p $testAry

                end
                clearCycle()
           #     p $testAry
            elsif !backFlag
                for i in thereTime+1...thereTime+$cycleLength
           #         time=i%$cycleLength
           #         printCycleAry(time)
           #         sleep (1)
                end


                backFlag=true
                backTime=minKalpa*$cycleLength+minTime+1
                p ["back at ", backTime]
                for i in 0...$cycleLength
                    startTime=(backTime+i+1)%$cycleLength
                    startKalpa=((backTime+i+1).to_f/$cycleLength).floor
                    $testAry.push([[startTime,0,0],startKalpa])
          #          p [startTime,startKalpa]            
                end
                clearCycle()
            else
                doneTime=minKalpa*$cycleLength+minTime+1
                p ["done at ",doneTime]
                doneFlag=true
            end
        end
    end
end
p [minTime,minKalpa,minKalpa*$cycleLength+minTime+1]
p $thereTime
