str=File.open("input6.txt").read
#p str
windowSize=4
for i in windowSize...str.length do
    v=str[i-windowSize...i] 
    p v,v.split("").uniq
    if v.split("").uniq.length==windowSize
        p i
        break
    end
end


