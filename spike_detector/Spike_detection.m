%% Spike distribution
% Spike detection

 clear
% load('AB_avgref.mat')
fs = 5000;
datatimeChan = data_AvgRef';
settings = [];
settings='-k1 5'; % envelope detection threshold

[DE,MARKER,envelope,background,discharges,envelope_pdf] = ...
    spike_detector_hilbert_v16_byISARG(datatimeChan,fs,settings);

filename3 = ['spike_result_',port];
save(filename3,'DE','MARKER','envelope','background','discharges','envelope_pdf');
