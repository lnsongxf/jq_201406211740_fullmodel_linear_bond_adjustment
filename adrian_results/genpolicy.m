clear all
clc 
close all


%% Parameters that are used
% Bgrid = csvread('Bgridcuda.csv');
Kgrid = csvread('Kgrid.csv');
Zgrid = csvread('Zgrid.csv');
XXIgrid = csvread('XXIgrid.csv');
P = csvread('P.csv');

cd ../MATLAB
mypara;
cd ../adrian_results
nk = length(Kgrid);
nz = length(Zgrid);
nxxi = length(XXIgrid);

%% Read in shadow value and policy functions
MK_low = csvread('V1_low.csv');
MK_high = csvread('V1_high.csv');


koptcuda = csvread('kopt.csv');
coptcuda = csvread('copt.csv');
% Rcuda = csvread('../R.csv');
dcuda = csvread('dopt.csv');
ncuda = csvread('nopt.csv');
mmucuda = csvread('mmuopt.csv');
wagecuda = csvread('wopt.csv');

flagcuda = csvread('flag.csv');
% EEerrorcuda = csvread('EEerror.csv');

%% Reshape
MK_low = reshape(MK_low,[nk,nz,nxxi]);
MK_high = reshape(MK_high,[nk,nz,nxxi]);

koptcuda = reshape(koptcuda,[nk,nz,nxxi]);
coptcuda = reshape(coptcuda,[nk,nz,nxxi]);
%Rcuda = reshape(Rcuda,[nk,nz,nxxi]);
dcuda = reshape(dcuda,[nk,nz,nxxi]);
ncuda = reshape(ncuda,[nk,nz,nxxi]);
wagecuda = reshape(wagecuda,[nk,nz,nxxi]);
mmucuda = reshape(mmucuda,[nk,nz,nxxi]);

P = reshape(P,[nz*nxxi nz*nxxi]);

flagcuda = reshape(flagcuda,[nk,nz,nxxi]);

%% Find the gap between high and low
% dist_K = MK_high - MK_low;
% figure
% surf(Zgrid,Kgrid(end-20:end),squeeze(dist_K(end-20:end,:,ceil(nxxi/2))),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('Dist of Shadow Val Investment')
% 
% dist_K = MK_high - MK_low;
% figure
% surf(Zgrid,Kgrid(end-20:end),squeeze(flagcuda(end-20:end,:,ceil(nxxi/2))),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('Flags')


%%
% Linxxi: Paint Kopt for i_z=5, i_xxi=5

% One slice of captial policy
figure
tightness = 1;
tfp = 5;
subplot(3,3,1)
plot(Kgrid,koptcuda(:,tfp,tightness)-Kgrid);
xlabel('Capital'); ylabel('Change in Capital')
subplot(3,3,2)
plot(Kgrid,coptcuda(:,tfp,tightness));
xlabel('Capital'); ylabel('Consumption')
subplot(3,3,3)
plot(Kgrid,wagecuda(:,tfp,tightness));
xlabel('Capital'); ylabel('Wage');
subplot(3,3,4)
plot(Kgrid,dcuda(:,tfp,tightness));
xlabel('Capital'); ylabel('Dividend');
subplot(3,3,5)
plot(Kgrid,koptcuda(:,tfp,tightness));
xlabel('Capital'); ylabel('Capital Tmr');
subplot(3,3,6)
plot(Kgrid,ncuda(:,tfp,tightness));
xlabel('Capital'); ylabel('Hours');
subplot(3,3,7)
plot(Kgrid,mmucuda(:,tfp,tightness));
xlabel('Capital'); ylabel('LM');
subplot(3,3,8)
plot(Kgrid,koptcuda(:,tfp,tightness)-(1-ddelta)*Kgrid);
xlabel('Capital'); ylabel('Investment')
subplot(3,3,9)
plot(Kgrid,MK_low(:,tfp,tightness));
xlabel('Capital'); ylabel('Shadow Value')

leg=legend('Lower Shadow Value','High Shadow Value');
set(leg,'Orientation','horizontal','Position',[0.3144 0.0123 0.4014 0.02725],'FontSize',10);
legend boxoff;

Kgrid_occa = Kgrid;
Zgrid_occa = Zgrid;
XXIgrid_occa = XXIgrid;
koptcuda_occa = koptcuda;
coptcuda_occa = coptcuda;
wagecuda_occa = wagecuda;
dcuda_occa = dcuda;
ncuda_occa = ncuda;
mmucuda_occa = mmucuda;

% figure
% surf(Zgrid,Kgrid,squeeze(dist_K(:,:,ceil(nxxi/2))),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('Dist of Shadow Val Investment')


%%
% Shrinkage
dist_K = MK_high-MK_low;
% dist_B = MB_high-MB_low;

% 3D distance check
% figure
% plot(Kgrid,squeeze(dist_K(:,nz,1)))
% xlabel('Capital'); ylabel('Distance K');
% print -f -depsc2 '2ddistance1.eps'
% title('i_z=5, i_b=1')
% 
% % 3D distance check
% figure
% plot(Kgrid,squeeze(dist_K(:,1,nxxi)))
% xlabel('Capital'); ylabel('Distance K');
% print -f -depsc2 '2ddistance2.eps'
% title('i_z=5, i_b=1')

% 3D distance check
% figure
% plot(Kgrid,squeeze(dist_K(:,tfp,ceil(nxxi/2))))
% xlabel('Capital'); ylabel('Distance K');
% print -f -depsc2 '2ddistance2.eps'
% title('i_z=5, i_b=1')
% 
% figure
% surf(Zgrid,Kgrid,squeeze(dist_K(:,:,ceil(nxxi/2))),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('Dist of Shadow Val Investment')
% print -f -depsc2 '3ddistance_new.eps'
% 
% figure
% surf(Zgrid,Kgrid,squeeze(dist_K(:,:,end)),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('Dist of Shadow Val Investment')
% print -f -depsc2 '3ddistance_new.eps'
% 
% figure
% surf(Zgrid,Kgrid,squeeze(flagcuda(:,:,ceil(nxxi/2))))
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('flag')
% print -f -depsc2 '3dflag_new.eps'
% 
% figure
% surf(Zgrid,Kgrid,squeeze(mmucuda(:,:,ceil(nxxi/2))),'EdgeColor','none','LineStyle','none','FaceLighting','phong')
% xlabel('TFP Shock'); ylabel('Capital'); zlabel('\mu_t')
% print -f -depsc2 '3dmmu_new.eps'


%% Find Euler equation error
burnin = 1000;
interp_method = 'nearest';
T = 1000+burnin;
u = rand(1,T);
zindex = ones(1,T);
xxiindex = ones(1,T);
k = Kgrid(1)*ones(1,T);

for t = 1:T-1
    k(t+1) = interp1(Kgrid,koptcuda(:,zindex(t),xxiindex(t)),k(t),interp_method);
    cdf = cumsum(P(sub2ind([nz nxxi],zindex(t),xxiindex(t)),:));
    agg_shock = find(cdf>u(t),1,'first');
    [zindex(t+1),xxiindex(t+1)] = ind2sub([nz nxxi],agg_shock);
end

eee = zeros(1,T);
for i = burnin+1:T
    c = interp1(Kgrid,coptcuda(:,zindex(i),xxiindex(i)),k(i),interp_method);
    kplus = interp1(Kgrid,koptcuda(:,zindex(i),xxiindex(i)),k(i),interp_method);
    mmu = interp1(Kgrid,mmucuda(:,zindex(i),xxiindex(i)),k(i),interp_method);
    
    sum = 0;
    for i_zplus = 1:nz
        for i_xxiplus = 1:nxxi
            mmuplus = interp1(Kgrid,mmucuda(:,zindex(i_zplus),xxiindex(i_xxiplus)),kplus,interp_method);
            nplus = interp1(Kgrid,ncuda(:,zindex(i_zplus),xxiindex(i_xxiplus)),kplus,interp_method);
            cplus = interp1(Kgrid,coptcuda(:,zindex(i_zplus),xxiindex(i_xxiplus)),kplus,interp_method);
            sum = sum + bbeta*P(sub2ind([nz nxxi],zindex(i),xxiindex(i)),sub2ind([nz nxxi],i_zplus,i_xxiplus))*(1-ddelta+(1-mmuplus)*ttheta*Zgrid(i_zplus)*kplus^(ttheta-1)*nplus^(1-ttheta))/cplus;
        end
    end
    ctilde = (1-mmu*XXIgrid(xxiindex(i)))/sum;
    eee(i) = abs(ctilde/c-1);
end

eulererror = mean(eee(burnin+1:end))
