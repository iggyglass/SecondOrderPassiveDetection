# Second Order Passive Detection
This is the git repository for both the simulation code and simulation results in our paper on passive, bistatic, 2nd order source localization. The code is a mess; my apologies.

## Repository Layout
The top level directory (primarily) contains some convenience functions for implementing simulations/tests/estimators/etc. It has the following subdirectories:
 - The `Tests` directory contains the code for tests and/or sanity checks which do not pertain to the performance of the detectors. As an example, this directory may contain code for testing the performance of algorithms used to actually implement the detectors.
 - The `Simulations` directory contains the code for running the actual simulations.
 - The `Estimators` directory contains code for the maximum likelihood estimators used in the simulations (since the GLRTs that we use require performing a maximum likelihood estimate both under $\mathcal{H}_0$ and $\mathcal{H}_1$).
 - The `Data` directory contains simulation results in CSV format. It has subdirectories for each type of simulation (one which contains probability of detection ($P_\mathrm{D}$) versus SNR, and one which contains the ROC of the detector). These subdirectories in turn contain subsubdirectories for each channel model (unknown, partially known, and fully known), each of which contain:
   - The results, in CSV format, for the cases which we consider in the paper.
   - The `Wrong` directory for simulation results when the model is misspecified (e.g. assumed equal channel variance when channel variance is unequal).
   - The `Diversity` directory for simulation results when the covariance between the two channels is ignored.
 - The `Plotting` directory contains functions to plot the simulation output data. Usage of these functions is detailed below.
  
### Data Format
All of the simulation data are stored in CSV files in the data directory. These data correspond to plots (either probability of detection versus SNR or ROC), and hence these CSVs have two rows: the first of which is for the $x$-axis data, the second of which is for the $y$-axis data.

### Plotting
The functions in the `Plotting` subdirectory plot the simulation results stored in the `Data` directory in a nice and presentable way. To plot ROC curves for a particular channel model, one uses the `PlotROC` function, and to plot $P_\mathrm{D}$ vs. SNR curves one uses the `PlotPDvsSNR` function. Both of these functions take in a single parameter which is a string that corresponds to a channel model subdirectory. For example, to plot ROC curves for the unknown channel case, one would write:
```matlab
PlotROC("Unknown")
```

For styling the legends in the plots, [legendflex](https://www.mathworks.com/matlabcentral/fileexchange/31092-legendflex-m-a-more-flexible-customizable-legend) is used. The legendflex code is already included in this project (within the `Plotting` directory), so there is no need to download it separately.
