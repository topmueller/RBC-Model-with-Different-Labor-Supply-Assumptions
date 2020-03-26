////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                                                                                                                         //
// Tobias Mueller                                                                                                             //
// April 2020                                                                                                                 //
//                                                                                                                            //                                                                                                                          //
// Replication of a Standard RBC Model with Different Labor Supply Assumptions                                                //
// 1) King–Plosser–Rebelo preferences                                                                                         //
// 2) Greenwood-Hercowitz-Huffman preferences                                                                                 //
//                                                                                                                            //                                                                                                                        //
//                                                                                                                            //
// Dynare 4.6.1 and MATLAB R2019a are used for Computations                                                                     //
//                                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////
//                  Model Settings                   //
///////////////////////////////////////////////////////

//Switch On (1) and Off (0) between Various Model Settings
// KPR preferences vs. GHH preferences
// 0 = King–Plosser–Rebelo preferences
// 1 = Greenwood-Hercowitz-Huffman preferences
@#define preferences = 1


// Endogenous variables
var
y                 (long_name='Output')
w                 (long_name='Wages')
r                 (long_name='Capital Demand')
c                 (long_name='Consumption')
lambda            (long_name='Marginal Utility of Consumption')
h                 (long_name='Hours Worked')
g                 (long_name='Government Spending')
k                 (long_name='Capital')
z                 (long_name='Technology')
i                 (long_name='Investment')
;

// Exogenous variables
varexo eta_z eta_g;

// Parameters
parameters s_H s_K s_C s_G epsilon_KH phi beta delta rho_z rho_g sig_z sig_g chi;

// Initialization of parameters
s_H        = 0.67;       // Labor Share
s_K        = 0.33;       // Capital Share
s_C        = 0.65;       // Share of Consumption
s_G        = 0.20;       // Share of Government
epsilon_KH = 1;          // Allen Elasticity of Substitution
phi        = 0.25;       // Inverse Labor Supply Elasticity
beta       = 0.99;       // Discount Factor
delta      = 0.025;      // Depreciation Rate
rho_z      = 0.99;       // AR(1) Technology
rho_g      = 0.90;       // AR(1) Government
sig_z      = 1/s_H;      // Std of Technology Shock (in percent)
sig_g      = 1/s_G;      // Std of Government Shock (in percent)

chi        = 1;          // GHH Preferences: Scale Parameter


//the model
model;
@#if preferences
lambda = ( 1 / (s_C - chi * (s_H/1+phi))) * (s_C * c - chi * s_H * h);  // Marginal Utility of Consumption
h      = 1/phi * w;                                                     // Frisch Labor Supply
@#else
lambda = (-1) * c;                                                      // Marginal Utility of Consumption
h      = 1/phi * (w + lambda);                                          // Frisch Labor Supply
@#endif

lambda = (1 - beta + beta * delta) * r(+1) + lambda(+1);                // Euler Equation
y      = s_K/epsilon_KH * k(-1) + s_H/epsilon_KH * (z + h);             // Production Function
k      = (1-delta) * k(-1) + delta * i;                                 // Evolution of Capital
r      = s_H * (z + h - k(-1));                                         // Capital Demand
w      = s_K * (k(-1) - h) + s_H * z;                                   // Labor Demand
y      = s_C * c + s_G * g + (1 - s_C - s_G) * i;                       // Aggregate Constraint

z      = rho_z * z(-1) + sig_z * eta_z;                                 // AR(1) Technology Shock
g      = rho_g * g(-1) + sig_g * eta_g;                                 // AR(1) Government Shock
end;


//assign steady state values
initval;
y       = 0;
lambda  = 0;
c       = 0;
i       = 0;
z       = 0;
k       = 0;
h       = 0;
r       = 0;
w       = 0;
g       = 0;
end;

// Compute the steady state
steady;

// Check for the roots (eigenvalues), i.e. the law of motion for the solution
check;


///////////////////////////////////////////////////////
//       Including Codes to Generate Figures         //
///////////////////////////////////////////////////////


//@#include "Technology_Shock.mod"
@#include "Government_Spending_shock.mod"
