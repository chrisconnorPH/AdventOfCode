
ary=File.open("input12.txt").read.split("\n").map{|a| a.split("")}
p ary

doneAry=[]
p doneAry
startPos=[]
endPos=[]

ary.each_with_index do |l,i1|
    doneLine=[]
    l.each_with_index do |v,i2|
        doneLine.push(9999999)
        if v=="S"
            ary[i1][i2]=1
        elsif v=="E"
            ary[i1][i2]=26
            startPos=[i1,i2]
            doneLine[i2]=0
        else
            ary[i1][i2]=ary[i1][i2].ord-96
        end
    end
    doneAry.push(doneLine)
end
p ary
p doneAry

done=false
while !done
    done=true
    ary.each_with_index do |l,i1|
        l.each_with_index do |e,i2|
            if doneAry[i1][i2]!=9999999
                if i1<ary.length-1
                    if ary[i1+1][i2]>=e-1 && doneAry[i1][i2]<doneAry[i1+1][i2]-1
                        doneAry[i1+1][i2]=doneAry[i1][i2]+1
                        done=false
                    end
                end
                if i1>0
                    if ary[i1-1][i2]>=e-1 && doneAry[i1][i2]<doneAry[i1-1][i2]-1
                        doneAry[i1-1][i2]=doneAry[i1][i2]+1
                        done=false
                    end
                end
                if i2<ary[0].length-1
                    if ary[i1][i2+1]>=e-1 && doneAry[i1][i2]<doneAry[i1][i2+1]-1
                        doneAry[i1][i2+1]=doneAry[i1][i2]+1
                        done=false
                    end
                end
                if i2>0
                    if ary[i1][i2-1]>=e-1 && doneAry[i1][i2]<doneAry[i1][i2-1]-1
                        doneAry[i1][i2-1]=doneAry[i1][i2]+1
                        done=false
                    end
                end
            end
        end
    end
    minA=9999999
    doneAry.each do |d|
        p d
    end

    ary.each_with_index do |e,i1|
        e.each_with_index do |v,i2|
            if doneAry[i1][i2]<minA && v==1
                minA=doneAry[i1][i2]
            end
        end

    end
    sleep(0.1)
end
p "done"
p minA
