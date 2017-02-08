# Cellular-Network-Spectrum-Sharing-Demo
Author: Samyak Shah

Description: I demo a centralized model based on Pareto Optimality for cellular network spectrum sharing based on an algorithm developed by Kamal et al. from Télécom ParisTech.

Results are discussed here: https://samyakshahblog.wordpress.com/2016/12/17/cellular-network-spectrum-sharing-demo/

pareto_front.m is the executable script, outputs a graph of rewards as a function of user arrival rates and a graph of the pareto front

simple_mult.m is a helper funcion which generates rewards according to the centrailized model based on user defined parameters

simple_multx.m is a helper function which finds rewards as a function of user arrival rates using a 2nd degree polynomial fit

pick_index.m is a helper function which finds the minimum rewards
