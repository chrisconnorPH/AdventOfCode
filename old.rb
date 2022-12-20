require 'json'
def scanTreeHash(tree)
    p ["hash",tree]
    tree.each do |e|
        p ["hashElem",e]
        if e.length==0
            if !scanTreeHash(e)
                p false
            end
        elsif e[1].is_a?(Array)
            if !scanTreeArray(e[1])
                p "falseArray"
            end
        elsif e[1]=="red"
            p ["red:",e]
            return false
        end
    end
end
def scanTreeArray(tree)
    p ["array:",tree.class,tree.length,tree]
    for ip in 0...tree.length
        i=ip-tree.length-1
        p ["arrayElem",ip,tree[i].class,tree[i]]
        if tree[i]=="red"
            p [tree[i],"red"]
            return false,nil
        
        elsif tree[i].class=="Hash"
            p [">",tree[i]]
            p "isAHash"
            if !scanTreeHash(tree[i])
                sleep(1)
            end
        
        elsif tree[i].is_a?(Array)
            p "isAnArray"
            return scanTreeArray(tree[i])
        else
            p ["not found",tree[i]]
        end
    end
    return true
end

v=JSON.parse(File.open("oldInput.txt").read())



p v

scanTreeHash(v[0])