class Tunnel
    def initialize(valve1,valve2,distance)
        @origin=valve1
        @destination=valve2
        @distance=distance
        @midValves={}
        @midValves[origin.name]=1
        @midValves[destination.name]=1
        @completed=false
    end
    def addValve(valve)
        if @midValves[valve.name()]==1
            return self, false
        else
            
            new_tunnel=Tunnel.new(@origin,valve,@distance+1)
            @midValves.each do |v|
                new_tunnel.addMid(v[0])
            end
            new_tunnel.addMid(@destination.name())
            return new_tunnel,true
        end
    end
    def addMid(v)
        @midValves[v]=1
    end
    def origin()
        @origin
    end
    def destination()
        @destination
    end
    def pressure()
        @destination.pressure()
    end
    def distance()
        @distance
    end
    def tag()
        @origin.name()+@destination.name()
    end
    def midValves()
        @midValves
    end
    def isCompleted()
        @completed=true
    end
    def completed()
        @completed
    end
    def addDistance(v)
        @distance=@distance+v
    end
end
class Valve
    def initialize(line)
        v1=line.chomp.split(" has flow rate=")
        @name=v1[0][6...]
        v2=v1[1].split("; tunnels lead to valves ")
        if v2[1]==nil
            v2=v1[1].split("; tunnel leads to valve ")
        end
        @pressure=v2[0].to_i
        @pipeAry=v2[1].split(", ")
    end
    def name()
        @name
    end
    def pressure()
        @pressure
    end
    def pipeAry()
        @pipeAry
    end
end

valveHash={}
File.open("input16.txt").each_line do |l|
    v=Valve.new(l)
    valveHash[v.name()]=v
end
tunnelHash={}
valveHash.each do |hash|
    valve=hash[1]
    valve.pipeAry().each do |next_valve_name|
        next_valve=valveHash[next_valve_name]
        tunnel=Tunnel.new(valve,next_valve,1)
        tunnelHash[tunnel.tag()]=tunnel
    end
end

done=false
round=0
while !done
    round=round+1
    done=true
    newHash={}
    tunnelHash.each do |hash|
        tag=hash[0]
        tunnel=hash[1]
        if !tunnel.completed()
            tunnel.destination().pipeAry().each do |next_valve_name|
                next_valve=valveHash[next_valve_name]
                new_tunnel,found=tunnel.addValve(next_valve)
                if found
                    if tunnelHash[new_tunnel.tag()]==nil
                        newHash[new_tunnel.tag()]=new_tunnel
                        done=false
                    elsif tunnelHash[new_tunnel.tag()].distance()>new_tunnel.distance()
                        newHash[new_tunnel.tag()]=new_tunnel
                        done=false
                    end
                end
                if tunnel.pressure()==0
                    tunnel.isCompleted()
                end
            end
        end
    end
    newHash.each do |h|
        tunnelHash[h[0]]=h[1]
    end
    sleep(0.1)

end 

doneHash={}
pathHash={}
$count=0
tunnelHash.each do |t|
    if t[1].pressure==0
        doneHash[t[0]]=1
    else 
        if pathHash[t[1].origin().name]==nil
            pathHash[t[1].origin().name()]=[t[1].destination().name()]
        else
            pathHash[t[1].origin().name()]=pathHash[t[1].origin().name()].push(t[1].destination.name())
        end
    end
end
doneHash.each do |d|
    tunnelHash.delete(d[0])      
end
tunnelHash.each do |t|
    t[1].addDistance(1)
end
def nextPath(path,elephantPath,pathHash,tunnelHash,doneHash,valveHash,distance,elephantDistance,score)
    currentValve=valveHash[path[path.length-1]]
    currentElephantValve=valveHash[elephantPath[elephantPath.length-1]]
    $count=$count+1
    if $count%1000000==0
        p ["here:",$count,path,elephantPath]
    end

    if currentValve==nil
        p path,elephantPath,distance,elephantDistance,doneHash,score
    end
    if score>$highScore
        $highScore=score
        p ["score1:",score,distance,elephantDistance,path,elephantPath]        
    end
    if distance<=elephantDistance
        pathHash[currentValve.name].each do |next_path|
            if doneHash[next_path]!=1
                nextValve=valveHash[next_path]
                tunnel=tunnelHash[currentValve.name+nextValve.name]
                if distance+tunnel.distance<26
                    doneHash[next_path]=1
                    path.push(next_path)
                    newDistance=distance+tunnel.distance()
                    scoreAdd=(26-newDistance)*tunnel.pressure
                    newScore=score+scoreAdd
                    nextPath(path,elephantPath,pathHash,tunnelHash,doneHash,valveHash,newDistance,elephantDistance,newScore)
                    path.pop()
                    doneHash[next_path]=0
                end
            end
        end
    else
        pathHash[currentElephantValve.name].each do |next_path|
            if doneHash[next_path]!=1
                nextValve=valveHash[next_path]
                tunnel=tunnelHash[currentElephantValve.name+nextValve.name]
                if elephantDistance+tunnel.distance<26
                    doneHash[next_path]=1
                    elephantPath.push(next_path)
                    newDistance=elephantDistance+tunnel.distance()
                    scoreAdd=(26-newDistance)*tunnel.pressure
                    newScore=score+scoreAdd
                    nextPath(path,elephantPath,pathHash,tunnelHash,doneHash,valveHash,distance,newDistance,newScore)
                    elephantPath.pop()
                    doneHash[next_path]=0
                end
            end
        end
    end        
end

    

path=["AA"]
elephantPath=["AA"]
doneHash={}
$highScore=0
distance=0
elephantDistance=0
score=0
nextPath(path,elephantPath,pathHash,tunnelHash,doneHash,valveHash,distance,elephantDistance,score)

p $highScore