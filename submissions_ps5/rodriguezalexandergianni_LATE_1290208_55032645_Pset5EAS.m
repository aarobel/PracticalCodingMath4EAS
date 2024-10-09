clc
clear
close all


data = importdata("charleston.csv").data;
date = data(:,1);
sealvl = data(:,2);

dtrng = zeros(length(date),2);
slrng = zeros(length(sealvl),2);
for d = 1:1:length(date)
    if date(d) >= 1923 && date(d) < 1943
        dtrng(d,1) = date(d);
        slrng(d,1) = sealvl(d);
    elseif date(d) >= 2003 && date(d) < 2023
        dtrng(d,2) = date(d);
        slrng(d,2) = sealvl(d);
    end
end
dtrng1 = nonzeros(dtrng(:,1));
slrng1 = nonzeros(slrng(:,1));
dtrng2 = nonzeros(dtrng(:,2));
slrng2 = nonzeros(slrng(:,2));

figure(1)
hold on
h1 = histogram(slrng1); %dtrng(:,1),
h2 = histogram(slrng2);
hold off
legend({'1923-1942', '2003-2022'})
xlabel('Sea Level')

sl1mean = mean(slrng1);
fprintf("1923-42 mean: %f2.8\n", sl1mean)
sl2mean = mean(slrng2);
fprintf("2003-2022 mean: %f2.8\n", sl2mean)

nyr = 10;
tval1 = (sl1mean - mean(sealvl))/(std(slrng1)/sqrt(nyr-1));
fprintf("1923-42 t-val: %f2.8\n",tval1)
tval2 = (sl2mean - mean(sealvl))/(std(slrng2)/sqrt(nyr-1));
fprintf("2003-2022 t-val: %f2.8\n", tval2)