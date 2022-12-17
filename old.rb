done=false
i=0
v=13337919186981
p ["start:",v]
while !done
    i=i+1
    if i%10000000==0
        p [i, v-i]
    end
end