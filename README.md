# ORIP_XXI
ORIP_XXI software suite is developed for study of radioactive and stable isotope transmutation chains, i.e. networks with feedbacks. Using the programs from this suite it is possible to estimate various quantitative characteristics of a transmutation chain both for nuclide irradiations in neutron fluxes and in case of pure radioactive decays. The main parts of ORIP_XXI are {NKE}, the electronic nuclide chart, {ChainFinder}, the program for finding transmutation chains, and {ChainSolver}, the program for simulating transmutation. Some {Updates} are available at the moment. Only the open-source subprograms and licensed software products were used in the coding. NKE, ChainFinder, and ChainSolver codes are accessible via NEA OECD Computer Program Service and as Radiation Safety Information Computation Center (RSICC) code package C00731. All programs use a common data file. The data file contains nuclear constants and decay data for more than 2800 nuclides with atomic weights from 1 up to 293 (nuclear charge from 1 up to 118) and characteristics of chemical elements. The file includes data on fission product yields for thermal and fast neutron induced fission of 22 heavy isotopes. All data are taken from freely available public nuclear data libraries. NKE program is developed to visualize the data and to analyze the information on the total set of radioactive isotopes as the single whole. The main function of ChainFinder code is searching for nuclide networks to be realized in nuclear reactors. The transmutation calculation code ChainSolver enables to take into account neutron flux depression and self-shielding factors, the latter using additional data from the resolved resonance parameters file. Users may edit data necessary for carrying out transmutation calculations (initial values are loaded from the data file). The coefficients of ordinary differential equation (ODE) system arising from the transmutation network vary in time due to neutron flux changes and changes of nuclide concentrations, which alter depression and resonance self-shielding factors. Users can apply four ODE solvers: VODE, LSODA, RADAU, and MEBDF. Typical calculation time doesn't exceed one-two minutes. After calculations are finished, various characteristics are obtained from calculated isotope densities: isotope masses, element masses, activities (alpha, beta-, EC, IT, total), isotope specific activities per element gram, isotope parts, mass yields, depression coefficients, self-shielding factors, and fission energy deposition estimations for all time steps. 
{NKE_m} - Mobile electronic chart of isotopes (Windows Mobile-based Pocket PCs version) 
The author: E.G.Romanov
ORIP (Division of Radionuclide Sources and Preparations),Research Institute of Atomic Reactors, Dimitrovgrad-10, 433510, Russia 

ORIP_XXI Codes {Descriptions} 
Paper for American Nuclear Society Topical Meeting in Mathematics & Computations, {M&C2005} is available as {PDF file}. 

ORIP_XXI (NKE+ChainSolver+ChainFinder) {AllInOneORIP_XXI.zip file} about 4.5MB. 


{Evgeny Romanov Data Sheet} 
{E-mail to the author (roeug20@gmail.com) } 

The page was written with {UltraEdit} and tested with {Opera }

 64bit (latest) versions available at https://gitlab.com/orip_xxi
 
