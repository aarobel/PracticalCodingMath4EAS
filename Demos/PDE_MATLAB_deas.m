%% Intro
%This is a demo of the basic pde-solving capabilities of MATLAB. This does
%not include the more robust (and involved) capabilities included in the
%PDE toolbox.

% In general, pdepe expects a PDE of the form:
% c(x,t,u,du/dx)*du/dt = x^{-m}*d/dx(x^m * f(x,t,u,du/dx)) + s(x,t,u,du/dx)

% For example, the diffusion equation is: du/dt =  D * d^2u/dx^2
% So, c=1, m=0, f=du/dx and s=0
% An advection term can be added by changing s

%% Mesh
L = 1;
x = linspace(0,L,100);
t = linspace(0,0.5,1000);

%% Solve Equation
m = 0;
sol = pdepe(m,@heatpde,@heatic,@heatbc,x,t);

%% Plot
% figure
% colormap hot
% pcolor(x,t,sol)
% shading('flat')
% colorbar
% xlabel('Distance x','interpreter','latex')
% ylabel('Time t','interpreter','latex')
% title('PDE for $0 \le x \le 1$ and $0 \le t \le 5$','interpreter','latex')

for i=1:1000
    figure(1);
    plot(x,sol(i,:));
    ylim([0 1])
    pause(0.1);clf;
end

%% Functions

function [c,f,s] = heatpde(x,t,u,dudx)
    c = 1;
    f = dudx;
    s = -5*dudx;
end

function u0 = heatic(x)
    u0 = 0.5*exp(-10*(x-0.5)^2);
end

function [pl,ql,pr,qr] = heatbc(xl,ul,xr,ur,t)
    pl = ul;
    ql = 0;
    pr = ur;
    qr = 0;
end