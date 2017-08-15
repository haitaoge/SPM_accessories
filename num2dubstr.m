function t = num2dubstr(n)
% creates length 2 strings from numbers
    if n < 10
        t = ['0' num2str(n)];
    else
        t = ['' num2str(n)];
    end
return