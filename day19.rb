
$costMap={}
$robotList=["ore","clay","obsidian","geode"]
$timeFrame=32
$maxGeodes=0
totalScore=1
$count=0
def NextRobot(currentRobotList,currentRobotTime,currentRobots,currentOre)
    $count=$count+1
    if $count%1000000==0
        p $count
    end
    nowTime=currentRobotTime[currentRobotTime.length-1]
 #   p [nowTime,currentRobotList,currentRobotTime,currentRobots,currentOre]
 #   sleep(1)
    geodes=currentOre[3]+($timeFrame-nowTime)*currentRobots[3]
    if geodes>$maxGeodes
        $maxGeodes=geodes
        print $maxGeodes,": "
        for i in 0...currentRobotList.length
            print "[",currentRobotList[i],":",currentRobotTime[i],"] "
        end
        print "\n"
        p [nowTime,currentOre]
       # sleep(1)
    end
   
    for ip in 0...$robotList.length 
        r_index=ip
        r=$robotList[r_index]
        if currentRobots[0]>=$costMap["geode"][0] && currentRobots[2]>=$costMap["geode"][2] && currentOre[0]>=$costMap["geode"][0] && currentOre[2]>=$costMap["geode"][2]
            r_index=3
            r=$robotList[r_index]
            ip=5
        end
        if nowTime==31
            r_index=3
            r=$robotList[r_index]
            ip=5
        end
        if nowTime==30 && r_index==1
            next
        end
        cost=$costMap[r]
        purchaseDef=-1
        purchasable=true

        cost.each_with_index do |c,i|

            if c>0
                if currentRobots[i]>0
                   purchaseTest=((c-currentOre[i]).to_f/currentRobots[i]).ceil+1
                   if purchaseDef<purchaseTest
                        purchaseDef=purchaseTest
                   end
                   if $timeFrame<=nowTime+purchaseDef
                        purchasable=false
                   end
                else
                    purchasable=false
                end
            end

        end
        if purchasable && purchaseDef>0
#            p [geodes,nowTime,currentRobotList,r,purchaseDef,currentOre]
            currentRobotList.push(r)
            newNowTime=nowTime+purchaseDef
            currentRobotTime.push(newNowTime)
            #p ["o0",currentOre]
            #p currentRobotList
            #p ["r",r,newNowTime,nowTime,purchaseDef,currentRobots]
            newOre=[]
            currentOre.each_with_index do |c,i|
                modifier=(newNowTime-nowTime)*currentRobots[i]
                if i<3
                    modifier=modifier-$costMap[r][i]
                end
    
                newOre.push(currentOre[i]+modifier)
            end
            #p ["o1",newOre]
            currentRobots[r_index]=currentRobots[r_index]+1

            NextRobot(currentRobotList,currentRobotTime,currentRobots,newOre)

            currentRobots[r_index]=currentRobots[r_index]-1

            currentRobotTime.pop()
            currentRobotList.pop()
        end
    end
end


File.open("day19.txt").each_line do |l|
    v=l.scan(/\d+/).map{|i| i.to_i}
    index=v[0]
    $costMap["ore"]=[v[1],0,0]
    $costMap["clay"]=[v[2],0,0]
    $costMap["obsidian"]=[v[3],v[4],0]
    $costMap["geode"]=[v[5],0,v[6]]
    p index
    p $costMap
    currentRobotList=["ore"]
    currentRobotTime=[0]
    currentRobots=[1,0,0,0]
    currentOre=[0,0,0,0]
    $maxGeodes=0
    $count=0 
    NextRobot(currentRobotList,currentRobotTime,currentRobots,currentOre)
    p $maxGeodes
    totalScore=totalScore*$maxGeodes
end
p totalScore

    