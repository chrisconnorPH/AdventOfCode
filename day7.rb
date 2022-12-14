path="/"
files={}
pathMap={}
File.open("input7.txt").each_line do |line|
    line=line.chomp
    if line[0]=="$"
        cmd=line.split(" ")
        case cmd[1]
        when "cd"
            case cmd[2]
            when "/"
                path="/"
            when ".."
                ary=path.split("/")
                path="/"
                for i in 1...ary.length-1 do
                    path=path+ary[i]+"/"
                end
            else
                path=path+cmd[2]+"/"       
                p cmd,path
            end
        end
    pathMap[path]=1
    else
        v=line.split(" ")
        if v[0]=="dir"
        else
            files[path+v[1]]=v[0].to_i
        end
    end
end
#p files
highScore=0

files.each do |f|
    p [f[0],f[1]]
    highScore=highScore+f[1].to_i
end
p ["high",highScore]
left=30000000-(70000000-highScore)
p ["left",left]
min=99999999999
pathMap.each do |r|
    p ["here",r]
    score=0
    files.each do |f|
        if f[0].include? r[0]
            score=score+f[1]
        end
    end
    p [score, left-score]
    #p p[0],score
    if score>=left && score<min then 
        min=score 
        puts ["low", min]
    end
    #if score<100000 then highScore=highScore+score end
end
p min