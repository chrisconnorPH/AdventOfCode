$outputHash={}
$nameHash={}
class Monkey
    def initialize(line)
        ary=line.chomp.split(": ")
        @name=ary[0]
        opAry=ary[1].split(" ")
        if opAry.length==1
            yellNumber(opAry[0].to_f)
        else
            @val1=opAry[0]            
            @val2=opAry[2]
            @op=opAry[1]
        end
    end
    def reset()
        if @op!=nil
            $outputHash[@name]=nil
            @result=nil
        end
    end
    def setValue(v)
        yellNumber(v)
    end
    def result
        @result
    end
    def name
        @name
    end
    def yellNumber(v)
        @result=v
 #       p v, @result
        $outputHash[@name]=@result
    end
    def isEqual()
        p $outputHash[@val1],$outputHash[@val2]
        if @val1==@val2
            return true
        else
            return false
        end
    end
    def testFunc()
        if @result==nil
            if $outputHash[@val1]!=nil && $outputHash[@val2]!=nil
                if @name=="root"
                    yellNumber($outputHash[@val1]-$outputHash[@val2])
                elsif @op=="+"
                    yellNumber($outputHash[@val1]+$outputHash[@val2])
                elsif @op=="-"
                    yellNumber($outputHash[@val1]-$outputHash[@val2])
                elsif @op=="*"
                    yellNumber($outputHash[@val1]*$outputHash[@val2])
                elsif @op=="/"
                    yellNumber($outputHash[@val1]/$outputHash[@val2])
                else
                    p Error
                end
            end
        end
    end
end
monkeyHash={}
File.open("input21.txt").each_line do |line|
    monkey=Monkey.new(line)
    monkeyHash[monkey.name]=monkey
    p monkey
end

p $outputHash

while monkeyHash["root"].result()==nil
    monkeyHash.each do |monkey|
        monkey[1].testFunc()
    end
end
startval=3353687995000
endval=3353700000000
for j in startval...endval
    i=j.to_f
    monkeyHash.each do |m|
        m[1].reset()
    end
    monkeyHash["humn"].setValue(i)
    while monkeyHash["root"].result()==nil
        monkeyHash.each do |monkey|
            monkey[1].testFunc()
        end
    end
    p ["humn",$outputHash["humn"],"root:",monkeyHash["root"].result()]
    if monkeyHash["root"].result()==0
        p "done"
        p ["humn",$outputHash["humn"],"root:",monkeyHash["root"].result()]
        p monkeyHash["root"].isEqual()
        break
    end
end

p monkeyHash["root"].result()


