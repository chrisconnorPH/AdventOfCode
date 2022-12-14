$stoneHash={}
$sandHash={}
$doneAry=[]
top=-99999
left=99999
grains=0
right=-99999
startSize=0
File.open("input14.txt").each do |l|
    last=[]

    l.chomp().split(" -> ").each do |e|
        v=[e.split(",")[0].to_i, e.split(",")[1].to_i]
        r=[]
        if v[0]<left then left=v[0] end
        if v[0]>right then right=v[0] end
        if v[1]>top then top=v[1] end
   
        if last!=[]
            if v[0]>last[0]
                for i in last[0]...v[0]+1
                    r=i.to_s+"_"+last[1].to_s
                    $stoneHash[r]=1
                end
            elsif v[0]<last[0]
                for i in v[0]...last[0]+1
                    r=i.to_s+"_"+last[1].to_s
                    $stoneHash[r]=1
                end
            elsif v[1]>last[1]
                for i in last[1]...v[1]+1
                    r=last[0].to_s+"_"+i.to_s
                    $stoneHash[r]=1
                end

            elsif v[1]<last[1]
                for i in v[1]...last[1]+1
                    r=last[0].to_s+"_"+i.to_s
                    $stoneHash[r]=1
                end
            end 
        end
        last=v        
    end
end
p "stones loaded"
top=top+1
$top=top
bottom=0
$bottom=bottom
left=left-1
$left=left
right=right+1
dropPoint=[500,0]
p [top,bottom,left,right]
for y in 250...750
    lineAry=[]
    for x in 0...top+3
        lineAry.push(0)
    end
    $doneAry.push(lineAry)
end
def convert(x1,y1)
    x2=x1-250
    y2=y1
    return x2,y2
end
$stoneHash.each do |e|
    v=e[0].split("_")
    x,y=convert(v[0].to_i,v[1].to_i)
    $doneAry[x][y]=1
end
def testBelow(coord)
    if isOpen([coord[0],coord[1]+1])
        coord[1]=coord[1]+1
        return coord,true
    elsif isOpen([coord[0]-1,coord[1]+1])
        coord[0]=coord[0]-1
        coord[1]=coord[1]+1
        return coord,true
    elsif isOpen([coord[0]+1,coord[1]+1])
        coord[0]=coord[0]+1
        coord[1]=coord[1]+1
        return coord,true
    end
    return coord,false
end

def isOpen(coord)
    tx,ty=convert(coord[0],coord[1])
    if ty==$top+2
        return false
    end
    if $doneAry[tx][ty]>0
        return false
    end
    return true
end
maxLevel=0
done=false
sandPath=[[500,0]]

while sandPath.length>0 do
    sand=[sandPath[sandPath.length-1][0],sandPath[sandPath.length-1][1]]
    lastLevel=sand[1]-1
    while lastLevel<sand[1] do
        lastLevel=sand[1]
        sand2,found=testBelow(sand)
        sand=sand2
        if found
            sandPath.push([sand2[0],sand2[1]])
        end
        if lastLevel==sand[1] || top==sand[1]
            break
        end
    end
    if sand[1]>maxLevel
        maxLevel=sand[1]
    end
    xd,yd=convert(500,0)

    if $doneAry[xd][yd]==0
        grains=grains+1

        x,y=convert(sand[0],sand[1])
     #   system 'clear'
        buf=""
        $doneAry[x][y]=2
        if grains%100==0
            for i in 0...$doneAry[1].length
                for j in 0...$doneAry.length
                    r=$doneAry[j][i]
                    if r==1
                        buf=buf+"\e[36m#\e[0m"
                    elsif r==2
                        buf=buf+"\e[33mO\e[0m"
                    else
                        buf=buf+" "
                    end
                end
                buf=buf+"\n"
            end
            print buf
        end
    
        if sand[0]==sandPath[sandPath.length-1][0] && sand[1]==sandPath[sandPath.length-1][1]
            sandPath.pop()
        end
    else   
        done=true
        break
    end
   
end
buf=""
for i in 0...$doneAry[1].length
    for j in 0...$doneAry.length
        r=$doneAry[j][i]
        if r==1
            buf=buf+"\e[36m#\e[0m"
        elsif r==2
            buf=buf+"\e[33mO\e[0m"
        else
            buf=buf+" "
        end
    end
    buf=buf+"\n"
end
print buf

p grains