def score(x)
    if x<91
        return x-38
    end    
    return x-96
end

tally=0
line1=""
line2=""
line3=""
data=File.open("input3.txt").each_line do |line|
    line=line.chomp
    if line1==""
        line1=line
    elsif line2==""
        line2=line
    else
        line3=line
        s=score((line1.split("")&line2.split("")&line3.split(""))[0].ord)
        p s
        line1=""
        line2=""
        line3=""
        tally=tally+s
    end
end
p tally