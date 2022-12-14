class Monkey

    def initialize(index)
        @index=index
        @bucket=[]
        @divisible=-1
        @operation=""
        @operationAmount=-1
        @trueMonkey=-1
        @falseMonkey=-1
        @inspections=0
    end
    def getDivisible()
        @divisible
    end
    def setTrueMonkey(t)
        @trueMonkey=t
    end
    def setFalseMonkey(t)
        @falseMonkey=t
    end
    def addItem(item)
        @bucket.push(item)
    end
    def removeItem()
        
        @bucket.shift().to_i
    end
    def hasItem()
        if @bucket.length>0
            return true
        end

        return false
    end
    def itemList()
        @bucket
    end
    def setDivisible(d)
        @divisible=d
    end
    def testDivisible(t)
        v=t.to_f/@divisible.to_f
        if v.floor==v
    
            return true
        end

        return false
    end
    def setOperation(o,amt)
        @operation=o
        @operationAmount=amt
    end
    def runOperation(item)
        res=0
        if @operation=="+"
            if @operationAmount=="old"
                res=((item+item.to_i)).floor()
            else
                res=((item+@operationAmount.to_i)).floor
            end
        
        elsif @operation=="*"

            if @operationAmount==0
                res=((item*item.to_i)).floor
            else
                res=((item*@operationAmount.to_i)).floor
            end
        end
        return res%$commonDiv
    end
    def inspections()
        @inspections
    end
    def throwItem()
        @inspections=@inspections+1
        item=runOperation(removeItem())
        if testDivisible(item)
            return item,@trueMonkey
        end
        return item,@falseMonkey
    end
end

$commonDiv=1
monkeyAry=[]
File.open("input11.txt").read.split("\n\n").each do |section|
    ary=section.split("\n").map{|l| l.chomp}
    monkey=Monkey.new(ary[0].split(" ")[1][0...1].to_i)
    bucketAry=ary[1].split(" ")[2...ary[1].split(" ").length].map{|l| l.split(",")[0].to_i}
    bucketAry.each do |b|
        monkey.addItem(b)
    end
    monkey.setOperation(ary[2].split(" ")[4],ary[2].split(" ")[5].to_i)
    monkey.setDivisible(ary[3].split(" ")[3].to_i)
    monkey.setTrueMonkey(ary[4].split(" ")[5].to_i)
    monkey.setFalseMonkey(ary[5].split(" ")[5].to_i)
    monkeyAry.push(monkey)
    $commonDiv=$commonDiv*monkey.getDivisible()
end
p ["div",$commonDiv]
for i in 0...10000 do
    p ["round",i]
    for j in 0...monkeyAry.length
        while monkeyAry[j].hasItem()
            item,to=monkeyAry[j].throwItem()
            monkeyAry[to].addItem(item)
        end

    end
    top=0
    second=0
    for j in 0...monkeyAry.length
        print "Monkey ",j," ",monkeyAry[j].inspections()," "
        monkeyAry[j].itemList().each do |e|
            print " ",e
        end
        if monkeyAry[j].inspections()>=top
            second=top
            top=monkeyAry[j].inspections()
        elsif monkeyAry[j].inspections()>second
            second=monkeyAry[j].inspections()
        end

        print "\n"
    end
end

p [top,second,top*second]