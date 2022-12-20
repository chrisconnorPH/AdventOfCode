ary=[]
doneAry=[]
indexAry=[]
cnt=0
key=811589153
File.open("input20.txt").each_line do |l|
    val=l.chomp.to_i*key
    ary.push(val)
    doneAry.push(false)
    indexAry.push(cnt)
    cnt=cnt+1
end
#p ary
i=0
for times in 0...10
    ct=0
    while ct<ary.length
        i=indexAry.find_index(ct)
        p [times,ct,i]
        value=ary[i]
        index=indexAry[i]

        v=value%(ary.length-1)
        pos=(i+v)%(ary.length-1)

        ary.delete_at(i)
        doneAry.delete_at(i)
        indexAry.delete_at(i)

        ary.insert(pos,value)
        doneAry.insert(pos,true)
        indexAry.insert(pos,index)
        ct=ct+1
    end
end
#p ary 
p ["length:",ary.length]
p ["max",ary.max]
p ["min",ary.min]
zeroPos=ary.index(0)
p ["zero",zeroPos]    
onePos=(zeroPos+1000)%ary.length
twoPos=(zeroPos+2000)%ary.length
threePos=(zeroPos+3000)%ary.length
p ["123",onePos,twoPos,threePos]
p ["v123",ary[onePos],ary[twoPos],ary[threePos]]

p ["sum",ary[onePos]+ary[twoPos]+ary[threePos]]