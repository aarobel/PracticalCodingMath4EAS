clc
clear
close all


data = importdata("ps4_seaLevel.csv").data;
date = data(:,1);
sealvl = data(:,2);

figure(1)
plot(date,sealvl)
xlim([date(1) date(end)])
title("Sealevel Change over time")
grid on; grid minor

%lr = fitlm()
A = zeros(length(date),2);
A(:,1) = date;
A(:,2) = 1;
linfit = A\sealvl;

figure(2)
hold on
plot(date,sealvl,'.k')
plot(date,linfit(2)+linfit(1).*date,'r-','linewidth',4);
xlim([date(1) date(end)])
title("Sealevel Change over time w/ Linear Regression")
grid on; grid minor


slanom = sealvl-mean(sealvl);
fprintf("Anomolies:\n"); disp(slanom);
%lvlvar = slanom'*slanom / (length(sealvl)-1)
lvlvar = var(sealvl);
fprintf("Varience: %f2\n",lvlvar)

dint = 20;
dmin = 1923;
dmax = dmin + dint;
dval = date(1);
d = 0;
daterange = [];
lvlrange = [];
lvlrate = zeros(5,1);
for i = 1:1:5
    while dval < dmin
        d = d + 1;
        dval = date(d);
        if d >= 1227
            break
        end
    end
    while dval >= dmin && dval < dmax
        daterange(i,d) = dval;
        lvlrange(i,d) = sealvl(d);
        d = d + 1;
        dval = date(d);
    end
    if d >= 1227
            break
    end
    [ddmin,Imin] = min(daterange(i,:));
    [ddmax,Imax] = max(daterange(i,:));
    lvlrate(i,1) = (lvlrange(i,Imax)-lvlrange(i,Imin))/(ddmax-ddmin);

    dmin = dmin + dint;
    dmax = dmax + dint;
end

figure(3)
daterng = categorical({'1923-1942', '1943-1962', '1963-1982', '1983-2002',...
    '2003-2022'});
plot(daterng,lvlrate)
title("Rate of S.L. Change Over Time")
