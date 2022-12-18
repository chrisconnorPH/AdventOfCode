vectorHash={}
pairCount=0
top=-99
bottom=99
left=99
right=-99
front=-99
back=99

def dist(v1,v2)
    return abs(v1[0]-v2[0])+abs(v1[1]-v2[1]+abs(v1[2]-v2[2]))
end

File.open("day18.txt").each_line do |line|
    v=line.chomp.split(",").map{|e| e.to_i}
    if v[0]>top
        top=v[0]
    end
    if v[0]<bottom
        bottom=v[0]
    end
    if v[1]>front
        front=v[1]
    end
    if v[1]<back
        back=v[1]
    end
    if v[2]>right
        right=v[2]
    end
    if v[2]<left
        left=v[2]
    end
    vectorHash[v]=1
end
p vectorHash
p [top,bottom,front,back,left,right]
outerHash={}
oneHash={}
done=false
noneHash={}
while !done
    done=true
    oldSize=outerHash.length
    p ["OLDSIZE",oldSize]
    for z in bottom-1...top+2
        for y in back-1...front+2
            for x in left-1...right+2
                if outerHash[[z,y,x]]!=1
                    if z==bottom-1 || z==top+1 ||y==back-1 || y==front+1 || x==left-1 || x==right+1
                        outerHash[[z,y,x]]=1
                        if [z,y,x]==[2,2,5]
           #                 p [[z,y,x]]
            #                sleep(10)
                        end          
                        done=false
                    elsif vectorHash[[z,y,x]]==nil
                        if outerHash[[z-1,y,x]]==1 || outerHash[[z+1,y,x]]==1 || outerHash[[z,y-1,x]]==1 || outerHash[[z,y+1,x]]==1 || outerHash[[z,y,x-1]]==1 || outerHash[[z,y,x+1]]==1
                            outerHash[[z,y,x]]=1
                            oneHash[[z,y,x]]=1
         #                   p "here"
                            if [z,y,x]==[2,2,5]
          #                      p [[z,y,x],outerHash[[z-1,y,x]],outerHash[[z-1,y,x]],outerHash[[z,y-1,x]],outerHash[[z,y+1,x]],outerHash[[z,y,x-1]],outerHash[[z,y,x+1]]]
             #                   sleep(10)
                            end
                            done=false
                        end
                    
                    end
                end
                if vectorHash[[z,y,x]]==nil && outerHash[[z,y,x]]==nil
                   noneHash[[z,y,x]]=1
                else
                    noneHash.delete([z,y,x])
                end
                
            
            end
        end
    end
 #   p [".",outerHash[[2,2,5]]]
end
p outerHash.length
p oneHash.length
vectorHash.each do |v,_|
    if outerHash[[v[0]-1,v[1],v[2]]]==1
        pairCount=pairCount+1
    end
    if outerHash[[v[0]+1,v[1],v[2]]]==1
        pairCount=pairCount+1
    end
    if outerHash[[v[0],v[1]-1,v[2]]]==1
        pairCount=pairCount+1
    end
    if outerHash[[v[0],v[1]+1,v[2]]]==1
        pairCount=pairCount+1
    end
    if outerHash[[v[0],v[1],v[2]-1]]==1
        pairCount=pairCount+1
    end
    if outerHash[[v[0],v[1],v[2]+1]]==1
        pairCount=pairCount+1
    end

end
#p oneHash
p "DONE"
#p outerHash
p pairCount
p noneHash.length
