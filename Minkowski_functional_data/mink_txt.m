function [output] = mink_txt(prefix)
%MINK_TXT takes file prefix appends '_C001H001S0001000001.tif' from 1-7 and
%will write txt files of minkowski functionals for ascending values of
%threshold (0-256), Needs function files to work
%   Detailed explanation goes here

prefix1 = append(prefix,'_');

for i = 1:7
    prefix2 = append(prefix1,int2str(i));
    file_name = append(prefix2,'_C001H001S0001000001.tif');
    [a,b,c] = Minkowski_plots(file_name);
    Area = a(:);
    Perimeter = b(:);
    Euler = c(:);
    T = table(Area,Perimeter,Euler);
    txt_name = append(prefix2,'_mink.txt');
    writetable(T,txt_name);

end



output = 1;
end

