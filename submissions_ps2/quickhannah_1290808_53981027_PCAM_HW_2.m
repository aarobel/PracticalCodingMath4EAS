%% PCAM HW 2, Basic Plotting
% Hannah Quick
% September 5, 2024
%% Load the data

% Read in the Atlanta and Seattle temperature data into separate matrices/arrays. 
% In MATLAB, use csvread or the "Import Data” utility.

% Load data for Atlanta
atl = readmatrix("/Users/mmamer3/Downloads/ATL_MonMeanTemp_1879_2020.csv");

% Load data for Seattle
sea = readmatrix("/Users/mmamer3/Downloads/SEA_MonMeanTemp_1894_2020.csv");

%% Remove NaNs
sea(sea==-999) = NaN;
atl(sea==-999)= NaN;
% -999 is used in these datasets as a placeholder for NaN.

%% Plot temperature data for Semptember
% Plot the time series of September temperature data from 1900 to 2020. 
% Make sure to label all axes and make everything readable.

% Plot for Atlanta
figure()
subplot(2, 1, 1)
plot(atl(:, 1), atl(:, 10), ".-")
xlim([1900, 2020])
xlabel('Year')
ylabel('Temperature')
title("Atlanta September Temperatures, 1900-2000")

% Plot for Seattle 
subplot(2, 1, 2)
 plot(sea(:, 1), sea(:, 10), ".-")
 xlim([1900, 2020])
 xlabel('Year')
 ylabel('Temperature')
title("Seattle September Temperatures, 1900-2000")

%% Temperature Data as PColor Plots
% Plot all Atlanta/Seattle data as a contour or pcolor plot with year on x-axis and month on y-axis. 
% Use a sensible colormap and label axes.
month=1:12;

% Atlanta
figure()
subplot(2, 1, 1)
pcolor(atl(:, 1), month, atl(:, 2:end)')
ylabel("Month Number")
xlabel("Year")
colormap('cool')
clim([30 85])
colorbar
title("Atlanta temperature matrix")

% Seattle
subplot(2, 1, 2)
pcolor(sea(:, 1), month, sea(:, 2:end)')
ylabel("Month Number")
xlabel("Year")
colormap('cool')
colorbar
clim([30 85])
title("Seattle temperature matrix")

%% Make box plots of monthly temperature
% In a row of two subplots (one for each city), make box plots showing the range of monthly temperature.
% Make sure the y-axes are the same so the difference between the cities is obvious.

figure()
lims = [25, 90]; % Limits for temp data
% Atlanta
subplot(2, 1, 1)
boxplot(atl(:, 2:end))
title("Atlanta Temperature Ranges")
xlabel("Month Number")
ylabel("Temperature")
ylim(lims)

% Seattle
subplot(2, 1, 2)
boxplot(sea(:, 2:end))
title("Seattle Temperature Ranges")
xlabel("Month Number")
ylabel("Temperature")
ylim(lims)


%% Make histograms of July Atlanta temperatures
% Plot a histogram of July temperatures in Atlanta. 
% Then plot a curve on top of it using the equation for a Gaussian. 

figure()
std_dv= std(atl(:, 8));
data_mean=mean(atl(:, 8));
Gaussian= ((2*pi*std_dv)^-0.5).*exp(-0.5.*((atl(:, 8)-data_mean)./std_dv));
bin_num=10;
histogram(atl(:, 8), bin_num)
hold on
[Nx, Edges]=histcounts(atl(:, 8), bin_num);
plot((Edges(1:end-1)+Edges(2:end))./2, Nx)
xlabel("Temperature")
ylabel("Number of Data Points")
title("Distribution of Atlanta July Temperatures")
hold off
%% Scatter, Atlanta and Seattle temperatures
% Make a scatter plot of Atlanta temperatures vs Seattle temperatures for corresponding months.

% Filter Atlanta data so that it begins when Seattle data begins (make
% matrices the same size)

figure()
Atl_idx = atl(:, 1)>=1894;
plot(sea(:, 2:end),atl(Atl_idx, 2:end),  ".")
ylabel("Atlanta temperatures")
xlabel("Seattle temperatures")
xlim(lims)
ylim(lims)
legend("January", "February", "March", "April", "May", "June", "July",...
    "August", "September", "October", "November", "December", "Location","northwest")
title("Atlanta temperatures vs Seattle temperatures")
