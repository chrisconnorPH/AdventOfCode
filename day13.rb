require 'yaml'
pairAry=File.open("input13.txt").read.split("\n\n").map{|a| a.split("\n")}

#p pairAry
$depth=0
sum=0
def compareBrackets(left,right)
#    p ["L:",left,"R:",right]
    $depth=0
    tie=false
    if left==nil && right!=nil
        return "RIGHT"
    end
    right.each_with_index do |r,i|
        $depth=$depth+1
  #      p ["beep",[left[i],left[i].class],[r,r.class],tie]


        if left[i]==nil
     #       p ["HERE",left[i],r,i]
        #    sleep(60)
            return "RIGHT"
        end

        if left[i].is_a?(Integer) && r.is_a?(Array)
            left[i]=[left[i]]
        elsif left[i].is_a?(Array) && r.is_a?(Integer)
            r=[r]
        end

        res=""
        if left[i].is_a?(Array) && r.is_a?(Array)
            res=compareBrackets(left[i],r)
            if res=="WRONG"
                return "WRONG"
            elsif res=="RIGHT"
  #              p "resright"
                return "RIGHT"
            elsif res=="TIE"
  #              p "gotTie"
                tie=true
            end
        else
            if left[i]>r
  #              p ["larger"]
                return "WRONG"
            elsif left[i]<r
  #              p ["smaller"]
                return "RIGHT"
            elsif left[i]==r
  #              p ["tie"]
                tie=true
            end
        end
        if i==right.length-1 && left[right.length]!=nil
   #         p ["left",left,right]
   #         p right.length
   #         p left[right.length]
         #   sleep 60
            return "WRONG"
        end

    end
    if left.length>right.length
   #     p "length"
        return "WRONG"
    end
    if tie
   #     p "itsa tye!"
        return "TIE"
    end
#    p "default"
    return "RIGHT"
end
$x=0
packetAry=[[[2]],[[6]]]

orderAry=[]
orderAry.push("z")
orderAry.push("z")
pairAry.each_with_index do |l,i|
    v=YAML::load(l[0])
    w=YAML::load(l[1])
   packetAry.push(v)
   packetAry.push(w)
   orderAry.push("z")
   orderAry.push("z")
end

packetAry.each_with_index do |e,i|
    if i==0
        orderAry[0]=e
    else
        for j in 0...orderAry.length do
            if orderAry[j]=="z"
                orderAry[j]=e
                break
            else
                if compareBrackets(e,orderAry[j])!="WRONG"
                    p ["ACTIVE",e,orderAry[j]]
                    for k in 0...orderAry.length-j do
                        kp=orderAry.length-k-1
                        if orderAry[kp]!="z"
                            p [kp,orderAry[kp+1]]
                            p [kp,orderAry[kp]]
                            orderAry[kp+1]=orderAry[kp]
                        end
                    end
                    orderAry[j]=e
                    break

                end
            end
        end
    end
    p "----"
    p ["order:",orderAry.length,orderAry]
    #sleep (1)
end

p "packet Array"
packetAry.each do |l|
    p l
end
#sleep 10
p "----"
orderAry.each do |l|
    p l
end
t2=[[2]]
t6=[[6]]
twoSpot=-1
sixSpot=-1
orderAry.each_with_index do |e,i|
    if e==t2
        twoSpot=i+1
    elsif e==t6
        sixSpot=i+1
    end
end

p twoSpot,sixSpot,twoSpot*sixSpot


#    bracketLeft=YAML::load(l[0])
#    bracketRight=YAML::load(l[1])
#    res=compareBrackets(bracketLeft,bracketRight)
