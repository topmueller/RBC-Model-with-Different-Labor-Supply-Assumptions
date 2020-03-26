// Technology Shock

//standard deviations of shocks
shocks;
var eta_z = 1;   // Technology Shock
end;


//performs a stochastic simulation of the model (10 Periods)
stoch_simul(order=1, irf=50, nograph);


//save var_names
var_names = oo_.var_list;
//save var_names long
var_names_long = M_.endo_names_long;


//create Matlab file
@#if preferences
if exist('GHH_irfs.mat', 'file') == 0
	GHH_irfs = struct;
  //save IRFS
  GHH_irfs.eta_z = oo_.irfs;
  save 'GHH_irfs.mat' 'GHH_irfs'  'var_names' 'var_names_long'
else
	load GHH_irfs.mat;
  //save IRFS
  GHH_irfs.eta_z = oo_.irfs;
  save('GHH_irfs.mat', 'GHH_irfs', '-append');
end;

@#else
if exist('KPR_irfs.mat', 'file') == 0
	KPR_irfs = struct;
  //save IRFS
  KPR_irfs.eta_z = oo_.irfs;
  save 'KPR_irfs.mat' 'KPR_irfs'  'var_names'
else
	load KPR_irfs.mat;
  //save IRFS
  KPR_irfs.eta_z = oo_.irfs;
  save('KPR_irfs.mat', 'KPR_irfs', '-append');
end;

@#endif



//Plotting the IRFS
figure;
//looping over all variables
for jj=1:1:length(var_names)
subplot(5,2,jj);
plot(1:50, oo_.irfs.([var_names{jj} '_eta_z'])(1:50), 'b', 'linewidth', 2); hold on;
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
@#if preferences
legend('Greenwood Hercowitz Huffman preferences','fontSize',10); //add legend
@#else
legend('King Plosser Rebelo preferences', 'fontSize',10); //add legend
@#endif
end

title([M_.endo_names_long{jj} ' (' var_names{jj} ')']); //Use variable names stored in M_.endo_names
sgtitle('IRFs to a Technology Shock', 'fontSize',14);

end
