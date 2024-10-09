clear
clc
clf

%atldat = readmatrix("ATL_MonMeanTemp_1879_2020.csv");
atldat = csvread("/Users/mmamer3/Downloads/ATL_MonMeanTemp_1879_2020.csv",1);
seadat = csvread("/Users/mmamer3/Downloads/SEA_MonMeanTemp_1894_2020.csv",1);
seadat(seadat == -999) = NaN;
D = datetime(2021,1,1):calmonths(1):datetime(2021,12,31);
D.Format = 'MMM';
atl = timeseries(atldat(22:end,2:13),1:12);
atl.Name = 'Atlanta';
atl.TimeInfo.Units = 'months';
sea = timeseries(seadat(7:end,2:13),1:12);
sea.Name = 'Seattle';
sea.TimeInfo.Units = 'months';

figure(1);
plot(atl);
legend(int2str(atldat(22:end,1)),'Location','northeastoutside','NumColumns',3);
xlim([1 12]);
xticklabels(categorical(D));
ylabel("Temperature (F)")
grid on

%% Missing this figure, you plot over it with the Atlanta heat map (-0.25)
figure(2);
plot(sea);
legend(int2str(seadat(7:end,1)),'Location','northeastoutside','NumColumns',3);
xlim([1 12]);
xticklabels(categorical(D));
ylabel("Temperature (F)")
grid on

%--------------------------------------------------------------------------
%% These figures x-axis are difficult to read, I would maybe only label 
%% every other year or every five years (-0.25)
figure(3);
contourf(atldat(:,2:13).');
colormap hot
c = colorbar;
c.Label.String = 'Temperature (F)';
yticklabels(categorical(D));
xticks(1:2:142);
xticklabels(atldat(1:2:end,1));
title('Atlanta')
grid on

figure(4);
contourf(seadat(:,2:13).');
colormap hot
c = colorbar;
c.Label.String = 'Temperature (F)';
yticklabels(categorical(D));
xticks(1:2:127);
xticklabels(seadat(1:2:end,1));
title('Seattle')
grid on

%--------------------------------------------------------------------------

figure(9)
tiledlayout(1,2)
nexttile
boxchart(atldat(:,2:13))
xticklabels(categorical(D));
ylim([0 90])
ylabel("Temperature (F)")
title('Atlanta')
grid on

nexttile
boxchart(seadat(:,2:13))
xticklabels(categorical(D));
ylim([0 90])
title('Seattle')
grid on

%--------------------------------------------------------------------------
%% Gaussian line is plotting incorrectly (-0.25)
figure(10)
hold on
histogram(atldat(:,8))
atlstd = std(atldat(:,8));
atlmn = mean(atldat(:,8));
x = 0:0.1:100;
plot( (1./(sqrt(2.*pi)*atlstd)) .* exp((-.5).*(((x-atlmn)./atlstd).^2)), 'red' )
xlabel("Temperature")
xlim([70 90])
hold off

%--------------------------------------------------------------------------
%% This is wrong, you're plotting atlanta data vs atlanta data
%% Did not need to take the monthly mean (-0.25)
figure(11)
means = zeros(2,12);
for t = 1:1:12
        means(1,t) = mean(atldat(:,t+1));
end
for t = 1:1:12
        means(2,t) = mean(atldat(:,t+1));
end
scatter(means(1,:),means(2,:))
xlabel('Atlanta Temperature')
ylabel('Seattle Temperature')
grid on; grid minor;