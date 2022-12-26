minVal=[-2]
maxVal=[3]
$output=["0"]
def printNumber(number)
    str=""
    for i in 0...number.length
        ip=number.length-i-1
        str=number[i]+str
    end
    return str
end
def getValue(number)
    result=0
    for i in 0...number.length
        v=0
        if number[i]=="=" then v=-2 end
        if number[i]=="-" then v=-1 end
        if number[i]=="0" then v=0 end
        if number[i]=="1" then v=1 end
        if number[i]=="2" then v=2 end
        result=result+v*(5**i)
    end
    return result
end
def addRegister(register1,register2)
    if register1=="="
        if register2=="=" then return "1","-" end
        if register2=="-" then return "2","-" end
        if register2=="0" then return "=","0" end
        if register2=="1" then return "-","0" end
        if register2=="2" then return "0","0" end
    elsif register1=="-"
        if register2=="=" then return "2","-" end
        if register2=="-" then return "=","0" end
        if register2=="0" then return "-","0" end
        if register2=="1" then return "0","0" end
        if register2=="2" then return "1","0" end
    elsif register1=="0"
        if register2=="=" then return "=","0" end
        if register2=="-" then return "-","0" end
        if register2=="0" then return "0","0" end
        if register2=="1" then return "1","0" end
        if register2=="2" then return "2","0" end    
    elsif register1=="1"
        if register2=="=" then return "-","0" end
        if register2=="-" then return "0","0" end
        if register2=="0" then return "1","0" end
        if register2=="1" then return "2","0" end
        if register2=="2" then return "=","1" end
    elsif register1=="2"
        if register2=="=" then return "0","0" end
        if register2=="-" then return "1","0" end
        if register2=="0" then return "2","0" end
        if register2=="1" then return "=","1" end
        if register2=="2" then return "-","1" end
    end
end

def addNumbers(num1,num2)
    sum=[]
    num1.each do |n|
        sum.push(n)
    end
    while num2.length>=sum.length
        sum.push("0")
    end

    for i in 0...num2.length
        result,shifted=addRegister(sum[i],num2[i])
        sum[i]=result
        k=i
        while shifted!="0"
            k=k+1
            result,shifted=addRegister(sum[k],shifted)
            sum[k]=result
        end
    end
    while sum[sum.length-1]=="0"
        sum.pop()
    end
    return sum
end




File.open("input25.txt").each_line do |line|
    v=[]
    line.chomp.split("").each do |e|
        v.insert(0,e)
    end

    while minVal.length<v.length
        minVal.push(minVal[minVal.length-1]-2*(5**(minVal.length)))
        maxVal.push(maxVal[maxVal.length-1]+3*(5**(maxVal.length)))
    end
    p "-----"
    p ["n1:",printNumber(v),getValue(v)]
    p ["n2:",printNumber($output),getValue($output)]
    $output=addNumbers($output,v)
    p ["result:",printNumber($output),getValue($output)]
end

p minVal
p maxVal
p ["FINAL SUM:",printNumber($output),getValue($output)]