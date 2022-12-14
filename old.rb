require "json"
def testObject(obj)
    obj.each do |k|
        p ["->",k]
        if k.length==2 && k[1]=="red"
            return true
        end       
    end
    return false
end

def runObject(obj)
    obj.each do |k1|
        if k1[1].class==Hash
            p [k1,k1.class,k1[1].class]
            if testObject(k1)
                obj.delete(k1)
            end
        end
    end
    obj.each do |k1|
        if obj.class==Array
            if k1.class==Hash || k1.class==Array
                p [">>",k1,k1.class]
                runObject(k1)
            end
        elsif obj.class==Hash
            if k1[1].class==Hash || k1[1].class==Array
                p [">>",k1[1],k1[1].class]
                runObject(k1)
            end
        end

    end   
end    

str=File.open("oldInput.txt").read
obj=JSON.parse(str)
p obj
runObject(obj)
p "...." 
p obj
#p hash
