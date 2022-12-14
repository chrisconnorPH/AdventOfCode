landedHash={}
#landedHash[["0_0"]]=1
head=[0,0]
tail=[0,0]
snake=[]
for i in 0...10
    snake.push([0,0])
end
p snake
ct2=0
endHash={}
File.read("input9.txt").each_line do |l|
    ary=l.chomp().split(" ")
    p l.chomp()
    for j in 0...ary[1].to_i do
        for i in 0...snake.length-1 do
            if i==0
                if ary[0]=="L"
                    snake[0][0]=snake[0][0]-1
                elsif ary[0]=="R"
                    snake[0][0]=snake[0][0]+1
                elsif ary[0]=="U"
                    snake[0][1]=snake[0][1]+1
                elsif ary[0]=="D"
                    snake[0][1]=snake[0][1]-1
                end
            end
            if snake[i+1][0]-snake[i][0]>=2 || snake[i+1][1]-snake[i][1]>=2 || snake[i+1][0]-snake[i][0]<=-2 || snake[i+1][1]-snake[i][1]<=-2
                if snake[i+1][0]-snake[i][0]>=1
                    snake[i+1][0]=snake[i+1][0]-1
                elsif snake[i+1][0]-snake[i][0]<=-1
                    snake[i+1][0]=snake[i+1][0]+1
                end
                if snake[i+1][1]-snake[i][1]>=1
                    snake[i+1][1]=snake[i+1][1]-1
                elsif snake[i+1][1]-snake[i][1]<=-1
                    snake[i+1][1]=snake[i+1][1]+1
                end

            end
            key=snake[9][0].to_s+"_"+snake[9][1].to_s
        

            landedHash[key]=1

        end
        p snake
    end

end
p "..."
p landedHash.length
p "---"
p snake

for j in -50...40
    jp=-j
    for i in -50...40
        key=i.to_s+"_"+jp.to_s
        if landedHash[key]==1
            print "#"
        else
            print "."
        end
    end
    print "\n"
end