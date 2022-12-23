
$elfAry=[]
$elfHash={}
$proposedHash={}
class Elf
    def initialize(x,y)
        @x=x
        @y=y
        $elfHash[[@x,@y]]=self
        @order=["north","south","east","west"]
    end
    def setXY(x, y)
        $elfHash.delete([@x,@y])
        @x=x
        @y=y
        $elfHash[[@x,@y]]=self
    end
    def consider()
        found=false
        resX=@x
        resY=@y
        cleared=false
        if $elfHash[[@x-1,@y-1]]==nil && $elfHash[[@x,@y-1]]==nil && $elfHash[[@x+1,@y-1]]==nil  &&$elfHash[[@x-1,@y+1]]==nil && $elfHash[[@x,@y+1]]==nil && $elfHash[[@x+1,@y+1]]==nil && $elfHash[[@x-1,@y]]==nil && $elfHash[[@x+1,@y]]==nil
            cleared=true
        else
            @order.each do |choice|
                if !found
                    if choice=="north"
                        if $elfHash[[@x-1,@y-1]]==nil && $elfHash[[@x,@y-1]]==nil && $elfHash[[@x+1,@y-1]]==nil
                            resX=@x
                            resY=@y-1
                            found=true
                        end
                    elsif choice=="south"
                        if $elfHash[[@x-1,@y+1]]==nil && $elfHash[[@x,@y+1]]==nil && $elfHash[[@x+1,@y+1]]==nil
                            resX=@x
                            resY=@y+1
                            found=true
                        end
                    elsif choice=="east"
                        if $elfHash[[@x+1,@y-1]]==nil && $elfHash[[@x+1,@y]]==nil && $elfHash[[@x+1,@y+1]]==nil
                            resX=@x+1
                            resY=@y
                            found=true
                        end
                    elsif choice=="west"
                        if $elfHash[[@x-1,@y-1]]==nil && $elfHash[[@x-1,@y]]==nil && $elfHash[[@x-1,@y+1]]==nil
                            resX=@x-1
                            resY=@y
                            found=true
                        end
                    end
                end
            end
            if found
                if $proposedHash[[resX,resY]]==nil
                    $proposedHash[[resX,resY]]=self
                else
                    $proposedHash[[resX,resY]]="crash"
                end
            end
        end
        v=@order[0]
        @order.shift()
        @order.push(v)
    end

end

def getFrame()
    left=1000000
    right=-10000000
    top=-100000
    bottom=10000
    $elfHash.each do |h|
        if h[0][0]<left
            left=h[0][0]
        end
        if h[0][0]>right
            right=h[0][0]
        end
        if h[0][1]>top
            top=h[0][1]
        end
        if h[0][1]<bottom
            bottom=h[0][1]
     
        end
    end
    return left,right,top,bottom
end
y=-1
File.open("input23.txt").each_line do |line|
    y=y+1
    ary=line.chomp.split("")
    ary.each_with_index do |e,x|
        if e=="#"
            newElf=Elf.new(x,y)
            $elfAry.push(newElf)
        end
    end
end
p $elfAry
p $elfHash

p getFrame()

noCount=0
round=0
while noCount<8
    round=round+1
    p [round,noCount]
    noCount=noCount+1
    moveCount=0
    $proposedHash.each do |p|
        if p[1]!="crash"
            noCount=0
            moveCount=moveCount+1
        end
        $proposedHash.delete(p[0])
    end
    p $proposedHash
    p moveCount
    sleep(0.1)
    if noCount>0 && round>1
        p round-1
#        sleep(1000)
    end

    $elfAry.each do |e|
        e.consider()
    end
    $proposedHash.each do |p|
        if p[1]!="crash"
            p[1].setXY(p[0][0],p[0][1])
        end
    end
    left,right,top,bottom=getFrame()
    p [left,right,top,bottom]
    groundCount=0
    for j in bottom...top+1
        for i in left...right+1
            if $elfHash[[i,j]]!=nil
                print "#"
            else
                print "."
                groundCount=groundCount+1
            end
        end
        print "\n"
    end
 #   p groundCount
 #   gets
end
