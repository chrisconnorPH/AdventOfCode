ary=File.open("input8.txt").read.split("\n").map{|r| r.split("")}

doneAry=[]
for i in 0...ary.length do
    doneAry.push([])
    for j in 0...ary[0].length do
        doneAry[i].push(1)
    end
end


for i in 0...ary.length
    for j in 0...ary[0].length
        treeSize=ary[i][j].to_i
        leftScore=0
        rightScore=0
        upScore=0
        downScore=0
        for k in 1...ary.length+ary[0].length
            if j+k>=ary[0].length
                break
            end
                rightScore=rightScore+1

            if treeSize<=ary[i][j+k].to_i 
#                p [i,j,k,treeSize,ary[i][i+k]]
                break
            end            
        end
        for k in 1...ary.length+ary[0].length
            if j-k<0
                break
            end
                leftScore=leftScore+1
                p [treeSize,ary[i][j-k],leftScore]
            if treeSize<=ary[i][j-k].to_i 
                break
            end            
        end
        for k in 1...ary.length+ary[0].length 
            if i+k>=ary.length
                break
            end
                upScore=upScore+1
            if treeSize<=ary[i+k][j].to_i 
                break
            end            
        end
        for k in 1...ary.length+ary[0].length 
            if i-k<0
                break
            end
                downScore=downScore+1
            if treeSize<=ary[i-k][j].to_i
                break
            end            
        end
        doneAry[i][j]=upScore*downScore*leftScore*rightScore
         p [i,j,upScore,downScore,leftScore,rightScore]
    end
end 
p doneAry
p doneAry.map{|r| r.max}.max