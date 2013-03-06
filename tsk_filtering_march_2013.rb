#!/usr/bin/env ruby

#This program reads in 4 variant files from two different populations of mice.  It looks for the variants which are the same between 
#each of the populations.  That is, the two mice from the 101 lineage, and the two mice from the 204 lineage.
#After confirming that each of the mice has the exact same variant, at the same place it then compares those two 
#variant populations for the ones which show different variants from the parent.


b    = "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/101B.txt" or abort("Can't open the 101B file: #{$!}\n")
e    = "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/101E.txt" or abort("Can't open the 101E file: #{$!}\n")
four = "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/2044.txt" or abort("Can't open the 2044 file: #{$!}\n")
five = "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/2045.txt" or abort("Can't open the 2045 file: #{$!}\n")

#Hashes for each file's variants
b_hash            = {}
e_hash            = {}
four_hash         = {}
five_hash         = {}

#Hashes for the combined population's SNPs, and the difference between those pops
snps_101          = {}
snps_204          = {}
snps_diff_101_204 = {}

File.open(b, 'r') do |f|
  while (l = f.gets) 
    array = l.split
    next if $. == 1 || array[1].to_i < 44676000 || array[1].to_i > 47212000
    b_hash[array[1]] = array[3..6]
  end
end

File.open(e, 'r') do |f|
  while (l = f.gets) 
    array = l.split
    next if $. == 1 || array[1].to_i < 44676000 || array[1].to_i > 47212000
    e_hash[array[1]] = array[3..6]
  end
end

File.open(four, 'r') do |f|
  while (l = f.gets) 
    array = l.split
    next if $. == 1 || array[1].to_i < 44676000 || array[1].to_i > 47212000
    four_hash[array[1]] = array[3..6]
  end
end

File.open(five, 'r') do |f|
  while (l = f.gets) 
    array = l.split
    next if $. == 1 || array[1].to_i < 44676000 || array[1].to_i > 47212000
    five_hash[array[1]] = array[3..6]
  end
end

#################################
#SNP exists in both 101B and 101E
total_count = 0
b_hash.each_entry do |s|
  if e_hash.has_key? s[0]
    total_count += 1 
    snps_101[s[0]] = s[1][1]
    puts s[0]+ "\t" + s[1].join("\t")
  end
end
puts "Total SNPs in the 101 lineage is "+total_count.to_s

#################################
#SNP exists in both 2044 and 2045
total_count = 0
four_hash.each_entry do |s|
  if five_hash.has_key? s[0]
    total_count += 1 
    snps_204[s[0]] = s[1][1]
  end
end
puts "Total SNPs in the 204 lineage is "+total_count.to_s

#################################
#SNPs different between 101 and 204
total_count = 0
puts "Position\tmm9\t101\t204"
snps_204.each_entry do |s|
  if snps_101.has_key? s[0]
    if  s[1] != snps_101[s[0]]
      total_count += 1
      snps_diff_101_204[s[0]] = s[1][1]
      puts s[0].to_s + "\t" + five_hash[s[0]][0] + "\t" + s[1].to_s + "\t" + snps_101[s[0]].to_s
    end
  end
end
puts "Total SNPs different between 101 and 204 lineages is "+total_count.to_s
