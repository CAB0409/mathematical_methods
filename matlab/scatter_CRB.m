Nh=10; Nu=40;
K=800; % Number iterations
Nx=Nu+Nh-1;
SNR=[-10:20]; % SNR in dB
h=1-[0:Nh-1]'/Nh; % filter
U=zeros(Nx,Nh);
MSE=zeros(size(SNR));
for iSNR=1:length(SNR),
u=10^(SNR(iSNR)/20)*randn(Nu,1);
for j=1:Nh,
U(j:j+Nu-1,j)=u;
end
invUU=inv(U'*U);
for iter=1:K,
x=U*h+randn(Nx,1); % Signal generation
hest=invUU*(U'*x); % Estimation
err=hest-h; % Metric evaluation (MSE)
MSE(iSNR)=MSE(iSNR)+(err'*err)/(K*Nh);
end
end
CRB=10.^(-SNR/10)/Nu; % asymptotic CRB (for Nu large)
semilogy(SNR,CRB,'-.',SNR,MSE,'.')
xlabel('SNR [dB]'); ylabel('MSE channel estimate')
title('MSE vs SNR')