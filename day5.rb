ary=[]
loadDone=false
File.open("input5.txt").each_line do |line|
    line=line.chomp
    if ary.length==0
        p (line.length+1)/4
        for i in 0...(line.length+1)/4 do
            ary=ary.push("")
        end
    end
    if line==""
        loadDone=true
    end

    if !loadDone
        for i in 0...(line.length+1)/4 do
            v=line[i*4+1]
            if v!=" " and v.to_i.to_s!=v
                ary[i]=v+ary[i]
            end
        end
    else
        cmd=line.split(" ")
        v0=cmd[1].to_i
        v1=cmd[3].to_i-1
        v2=cmd[5].to_i-1
        ary[v2]=ary[v2]+ary[v1][ary[v1].length-v0...ary[v1].length]
        ary[v1]=ary[v1][0...ary[v1].length-v0]
    end
end
p ary
res=""
for ary.each do |line|
    res=res+line[line.length-1]
end
p res