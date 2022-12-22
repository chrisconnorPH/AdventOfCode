$ary=[]
onMap=true
maxRows=0
maxCols=0
height=0
$commandStr=""
$oldX=0
$oldY=0
stitchAry={}
isTest=false
setPause=false

if isTest
    for i in 0...4
        stitchAry[[0,8+i,"up"]]=[4,3-i,"down"]
        stitchAry[[4,3-i,"up"]]=[0,8+i,"down"]

        stitchAry[[i,8,"left"]]=[4,4+i,"down"]
        stitchAry[[4,4+i,"up"]]=[i,8,"right"]

        stitchAry[[i,11,"right"]]=[8+i,15,"left"]
        stitchAry[[8+i,15,"right"]]=[i,11,"left"]

        stitchAry[[4+i,0,"left"]]=[11,15-i,"up"]
        stitchAry[[11,15-i,"down"]]=[4+i,0,"right"]

        stitchAry[[4+i,11,"right"]]=[8,15-i,"down"]
        stitchAry[[8,15-i,"up"]]=[4+i,11,"left"]

        stitchAry[[7,i,"down"]]=[11,11-i,"up"]
        stitchAry[[11,11-i,"down"]]=[7,i,"up"]
        
        stitchAry[[7,4+i,"down"]]=[11-i,7,"right"]
        stitchAry[[11-i,8,"left"]]=[7,4+i,"up"]
    end
else
    for i in 0...50
        stitchAry[[0,i+50,"up"]]=[i+150,0,"right"]
        stitchAry[[i+150,0,"left"]]=[0,i+50,"down"]

        stitchAry[[0,i+100,"up"]]=[199,i,"up"]
        stitchAry[[199,i,"down"]]=[0,i+100,"down"]

        stitchAry[[i,50,"left"]]=[149-i,0,"right"]
        stitchAry[[149-i,0,"left"]]=[i,50,"right"]

        stitchAry[[i,149,"right"]]=[149-i,99,"left"]
        stitchAry[[149-i,99,"right"]]=[i,149,"left"]

        stitchAry[[49,100+i,"down"]]=[50+i,99,"left"]
        stitchAry[[50+i,99,"right"]]=[49,100+i,"up"]

        stitchAry[[50+i,50,"left"]]=[100,i,"down"]
        stitchAry[[100,i,"up"]]=[50+i,50,"right"]

        stitchAry[[149,50+i,"down"]]=[150+i,49,"left"]
        stitchAry[[150+i,49,"right"]]=[149,50+i,"up"]
    end
end

def printBoard(str)
   # system 'clear'
    for t in 0...$ary.length
        for l in 0...$ary[t].length
            if t==$y && l==$x
                print "O"
            elsif t==$oldY && l==$oldX
                print "Q"
            else
                print $ary[t][l]
            end
        end
        print "\n"
    end
    p [$oldDir,$dir,$x,$y, str, $commandStr.length]
end


File.open("input22.txt").each_line do |line|
    if line.chomp.length==0
        onMap=false
    end
    if onMap
        row=[]
        strAry=line.chomp.split("")
        strAry.each_with_index do |e,i|
            row.push(e)
        end
        if row.length>maxCols
            maxCols=row.length
        end
        $ary.push(row)
        maxRows=maxRows+1
    end
    if !onMap && line.length>0
        $commandStr=line.chomp
    end
end

$ary.each do |row|
    while row.length<maxCols
        row.push(" ")
    end
end

$ary.each do |row|
    p row
end

$x=0
$y=0
$dir="right"
$ary[0].each_with_index do |e,i|
    if e!=" "
        $x=i
        break
    end
end

p [$x,$y,$dir]

p $commandStr
def getCommand()
    str=""
    type=""
    i=-1
    stopFlag=false
    while stopFlag==false && $commandStr.length>0
        i=i+1
        v=$commandStr[0]
        p [v,$commandStr.length]
        if $commandStr.length==1
            str=str+v
            $commandStr=$commandStr[1...]
            stopFlag=true
        elsif v.to_i.to_s==v
            if type==""
                type="number"
                str=str+v
                $commandStr=$commandStr[1...]
            elsif type=="number"
                str=str+v
                $commandStr=$commandStr[1...]
            else
                $commandStr
                stopFlag=true
            end            
        else
            if type=="number"
                type=""
                stopFlag=true
            else
                str=str+v
                $commandStr=$commandStr[1...]
                stopFlag=true
            end
        end
        
        if stopFlag
            return str
        end
    end
end


while $commandStr.length>0
    cmd=getCommand()
    if cmd=="L"
        if $dir=="right"
            $dir="up"
        elsif $dir=="up"
            $dir="left"
        elsif $dir=="left"
            $dir="down"
        elsif $dir=="down"
            $dir="right"
        end
    elsif cmd=="R"
        if $dir=="right"
            $dir="down"
        elsif $dir=="down"
            $dir="left"
        elsif $dir=="left"
            $dir="up"
        elsif $dir=="up"
            $dir="right"
        end
    else
        dist=cmd.to_i
        $oldX=$x
        $oldY=$y
        $oldDir=$dir
        while dist>0
            nextY=$y
            nextX=$x
            nextDir=$dir
            if stitchAry[[$y,$x,$dir]]!=nil
                nextY=stitchAry[[$y,$x,$dir]][0]
                nextX=stitchAry[[$y,$x,$dir]][1]
                nextDir=stitchAry[[$y,$x,$dir]][2]
                p ["tunnel",[$y,$x,$dir],stitchAry[[$y,$x,$dir]]]
            elsif $dir=="right"
                if $x+1==$ary[0].length     
                    nextX=0
                else
                    nextX=$x+1
                end
            elsif $dir=="up"
                if $y==0     
                    nextY=$ary.length-1
                else
                    nextY=$y-1
                end
            elsif $dir=="left"
                if $x==0     
                    nextX=$ary[0].length-1
                else
                    nextX=$x-1
                end
            elsif $dir=="down"
                if $y+1==$ary.length     
                    nextY=0
                else
                    nextY=$y+1
                end
            end


            if $ary[nextY][nextX]=="#"
                dist=0
            elsif $ary[nextY][nextX]=="."
                dist=dist-1
                $x=nextX
                $y=nextY
                $dir=nextDir
            else
                printBoard(cmd)
                p "error"
                
                p [$x,$y,$dir,nextX,nextY,nextDir]
                sleep 100
            end
        end
        if setPause
            printBoard(cmd)
            gets
        end
    end
end
p [$x+1,$y+1,$dir]
score=($y+1)*1000+($x+1)*4
if $dir=="down"
    score=score+1
elsif $dir=="left"
    score=score+2
elsif $dir=="up"
    score=score+3
end
p $ary.length,$ary[0].length
p score