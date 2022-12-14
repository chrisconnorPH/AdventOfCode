
f=File.open("input1.txt")
data=f.read

#solving day 1 the procedural way
max=0
max2=0
max3=0
v=data.split("\n\n").each do |e|
  s=e.split("\n").map(&:to_i).sum
  if max<=s
    max3=max2
    max2=max
    max=s
  elsif max2<=s
    max3=max2
    max2=s
  elsif max3<=s
    max3=s
  end

end
puts "#{max} #{max2} #{max3}"
puts max+max2+max3
puts "--------"

#solving day 1 the matrix (and PH) way
puts data.split("\n\n").map{|e| e.split("\n").map{|i| i.to_i}.sum}.max(3).sum
