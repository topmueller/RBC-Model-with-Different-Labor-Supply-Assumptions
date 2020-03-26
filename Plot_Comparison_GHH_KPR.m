clear all
load KPR_irfs 
load GHH_irfs

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Government Spending Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotting the IRFS
figure(1);
%looping over all variables
for jj=1:1:length(var_names)
subplot(5,2,jj);
plot(1:50, GHH_irfs.eta_g.([var_names{jj} '_eta_g'])(1:50), 'r--', 'linewidth', 2); hold on;
plot(1:50, KPR_irfs.eta_g.([var_names{jj} '_eta_g'])(1:50), 'b', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('Greenwood Hercowitz Huffman preferences','King Plosser Rebelo preferences','fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Government Spending Shock', 'fontSize',14);

end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Technology Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotting the IRFS
figure(2);
%looping over all variables
for jj=1:1:length(var_names)
subplot(5,2,jj);
plot(1:50, GHH_irfs.eta_z.([var_names{jj} '_eta_z'])(1:50), 'r--', 'linewidth', 2); hold on;
plot(1:50, KPR_irfs.eta_z.([var_names{jj} '_eta_z'])(1:50), 'b', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('Greenwood Hercowitz Huffman preferences','King Plosser Rebelo preferences','fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Technology Shock', 'fontSize',14);

end

