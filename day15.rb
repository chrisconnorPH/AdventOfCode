
class Sensor
    def initialize(sensor,beacon)
        @sensor=[sensor[0].to_i,sensor[1].to_i]
        @beacon=[beacon[0].to_i,beacon[1].to_i]
        @distance=distance(@sensor,@beacon)
    end
    def getCoverage(row)
        perpendicular=(@sensor[1]-row).abs
        parallel=@distance-perpendicular
        if parallel<0
            return nil
        end
        p1=@sensor[0]-parallel
        p2=@sensor[0]+parallel
        return [p1,p2]

    end
    def beacon()
        return @beacon
    end
end

def addCoverages(coverage1,coverage2)
    if coverage1==nil || coverage2==nil
        return nil,nil,false
    end

    if coverage1[0]<coverage2[0] && coverage1[1]>=coverage2[0] && coverage1[1]<coverage2[1]
        return [coverage1[0],coverage2[1]],nil,true
    elsif coverage1[1]>coverage2[1] && coverage1[0]<=coverage2[1] && coverage2[0]<coverage1[0]
        return [coverage2[0],coverage1[1]],nil,true
    elsif coverage1[0]>=coverage2[0] && coverage1[1]<=coverage2[1]
        return [coverage2[0],coverage2[1]],nil,true
    elsif coverage1[0]<=coverage2[0] && coverage1[1]>=coverage2[1]
        return [coverage1[0],coverage1[1]],nil,true
    elsif coverage1[1]+1==coverage2[0]
        return [coverage1[0],coverage2[1]],nil,true
    elsif coverage1[0]-1==coverage2[1]
        return [coverage2[0],coverage1[1]],nil,true
    end
    return coverage1,coverage2,false
    end

def distance(v1,v2)
    return (v2[0]-v1[0]).abs+(v2[1]-v1[1]).abs
end

def getSum(sensorAry,row)
    coverageAry=[]
    sensorAry.each_with_index do |sensor,i|
        cvg=sensor.getCoverage(row)
        if cvg!=nil
            foundList=[]
            sum=[cvg[0],cvg[1]]
            coverageAry.each_with_index do |old_coverage,i|
                sumNew,_,found=addCoverages(sum,old_coverage)
                if found
                    foundList.push(i)
                    sum=sumNew
                end
            end
            for j in 0...foundList.length
                i=foundList.length-j-1
                index=foundList[i]
                coverageAry.delete_at(index)
            end
            coverageAry.push(sum)
        end
    end
    return coverageAry
end

sensorAry=[]
coverageAry=[]
File.open("day15.txt").each_line do |l|
    l=l.chomp()[12...]
    lAry=l.split(": closest beacon is at x=").map{|r| r.split(", y=")}
    sensor=Sensor.new(lAry[0],lAry[1])
    sensorAry.push(sensor)
end
for row in 0...4000001
    if row%10000==0
        p row
    end
    res=getSum(sensorAry,row)
    if res[0][0]>0 || res[0][1]<4000000
        if res[0][0]-1<=4000000 && res[0][0]>=0
            column=res[0][0]-1
        elsif res[0][1]+1<=4000000 && res[0][1]>=0
            column=res[0][1]+1
        end
        p [row,column, row+column*4000000]
        p res
        break
    end
end

    #left over from part 1
#sum=0
#beaconsFoundAry={}
#coverageAry.each do |c|
#    sum=sum+c[1]-c[0]+1
#    sensorAry.each do |s|
#        if s.beacon()[1]==$row && c[0]<=s.beacon()[0] && c[1]>=s.beacon()[0]
#            beaconsFoundAry[s.beacon[0]]=1
#        end
#    end
#end
#sum=sum-beaconsFoundAry.length()
#p sum

#part 2
#x: 3334479
#y: 3186981