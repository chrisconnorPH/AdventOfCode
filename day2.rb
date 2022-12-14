

#for part 1
def scoreLine(str)
    case str
    when "A X"
        return 1,1,3,3
    when "A Y"
        return 1,2,0,6
    when "A Z"
        return 1,3,6,0
    when "B X"
        return 2,1,6,0
    when "B Y"
        return 2,2,3,3
    when "B Z"
        return 2,3,0,6
    when "C X"
        return 3,1,0,6
    when "C Y"
        return 3,2,6,0
    when "C Z"
        return 3,3,3,3
    end
end

#for part 2
def strategyLine(str)
    case str
    when "A X"
        return 1,3,6,0
    when "A Y"
        return 1,1,3,3
    when "A Z"
        return 1,2,0,6
    when "B X"
        return 2,1,6,0
    when "B Y"
        return 2,2,3,3
    when "B Z"
        return 2,3,0,6
    when "C X"
        return 3,2,6,0
    when "C Y"
        return 3,3,3,3
    when "C Z"
        return 3,1,0,6
    end
end
elfScore1=0
humanScore1=0
elfScore2=0
humanScore2=0


File.open("input2.txt").each_line do |line|
    line=line.chomp
    #part 1
    v1=scoreLine(line)
    #part 2
    v2=strategyLine(line)
   elfScore1=elfScore1+v1[0]+v1[2]
    humanScore1=humanScore1+v1[1]+v1[3]
    elfScore2=elfScore2+v2[0]+v2[2]
    humanScore2=humanScore2+v2[1]+v2[3]
end
p "first round:"
p ["elf:",elfScore1]
p ["human:",humanScore1]
p ""
p "second round:"
p ["elf:",elfScore2]
p ["human:",humanScore2]
p"------"
p File.read('input2.txt').scan(/^([ABC]) ([XYZ])$/).map{|p,q| [p.ord-64,q.ord-87]}.map {|p,q| q + ((q-p+1) % 3) * 3 }.sum