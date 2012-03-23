function [data] = writeread(ob1)

    %output = xlsread('colorList.xlsx')
    %inter = output(:,1);
    %range = find(output(:,1) == ob1);
    %data = output(range(1):range(end),:);
    data = zeros(1,10);
    if (isempty(data))
        display('it is empty');
    end
end