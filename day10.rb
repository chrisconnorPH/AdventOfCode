cycle=-1
x=1
sum=0
adding=false
addingVal=0
ary=File.open("input10.txt").read.split("\n")
#p ary
done=false
aryIndex=0
pixelAry=[]

while !done do
    cycle=cycle+1
    p [cycle,x,addingVal,adding]
    if x-1<=(cycle%40) && (cycle%40)<=x+1
        p [x,cycle,"#"]
        pixelAry.push("#")
    else
        p [x,cycle,"."]
        pixelAry.push(".")
    end
    if !adding
        input=ary[aryIndex].split(" ")
        p [cycle,ary[aryIndex]]
       
        aryIndex=aryIndex+1
        if input[0]=="noop"
        else
            addingVal=input[1].to_i
            adding=true
            p ["adding ",addingVal]
        end
    else
        x=x+addingVal
        addingVal=0
        adding=false 
        p [cycle,"x is now ",x]   
    end


    p [cycle,x,addingVal,adding]
    p pixelAry
    if aryIndex>=ary.length && !adding
        p "done at ",cycle
        done=true
    end
       
    if cycle==45
  #      done=true
    end
end
p pixelAry[41]
for i in 0...6
    for j in 0...40
        print pixelAry[i*40+j]
    end
    print "\n"
end