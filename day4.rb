ct=0
File.open("input4.txt").each_line do |line|
    ary=line.chomp.split(",").map{|a| a.split("-")}.map{|x,y|[x.to_i,y.to_i]}
    if !(ary[0][1]<ary[1][0] || ary[0][0]>ary[1][1])
        p ary
        ct=ct+1
    end

end
p ct