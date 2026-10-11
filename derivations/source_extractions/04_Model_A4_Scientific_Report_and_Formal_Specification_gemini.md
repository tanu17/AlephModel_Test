# Extraction: Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf
- Model version(s) specified: Model A.5 (despite filename "A4"); title "Model A.5: Unified Biophysical Neuroenergetics Specification, Human Brain Extension, and Cross-Clade Validation", Oct 2026. Change log covers precursors v0.1-v5.0, Model A, A.3, A.4.
- One-paragraph summary of the file: 10-page monograph. Sec 1 lists six axioms (A1-A6). Sec 2 is a change-log table of flaws in precursor/A/A.3/A.4 with fixes (contains several inline formulas). Sec 3 gives the A.5 "18-equation" system, actually numbered Eq. 1-27 (somatic potential with K_ATP + ephaptic coupling, human dendritic dCaAP compartment, D1-HCN shunt, firing-rate gating, adaptation, Na+ debt and pump, ATP balance, neurovascular perfusion with Buxton extraction, K+ and glymphatic washout, energy-aware homeostat, Tsodyks-Markram vesicles, plasticity with headroom/eviction, tagging/condensate capture, adenosine and two-process sleep gate, theta phase, ephaptic field). Sec 4 human extension (theta-gamma slot capacity). Sec 5 species parameter table; Sec 6 caveats; Sec 7 references. No step-by-step derivations; only short justifications in the change-log table.
- Parts that could not be read (if any): None substantive. Text extraction was plain ASCII math (already linear notation); transcribed as-is into LaTeX. "II_SWS" in Eq. 14 is presumably an indicator function 1_SWS [unclear: rendered "II"].

### E1: Point-process channel capacity (1D cable paradox refutation)
- Section in source: Sec 2, Table 1 (Precursors)
- Tier: other
- Equation: $C_e = \lambda_0/(e\ln 2) = 53.1$ bits/s at 100 Hz
- Symbols: lambda0 = max rate (100 Hz); e = Euler number.
- Derivation or justification: none beyond "Refuted. Point-process channels convey Ce = ...; temporal coding transmits multi-dimensional signals."
- Physical law / literature: Kabanov (1978) Poisson channel capacity.
- Corresponding Aleph 1 equation: none
- Changes vs earlier versions: refutes precursor claim that 1D cable forbids multidimensional coding.

### E2: Global contraction fallacy condition (rejected)
- Section: Sec 2, Table 1
- Tier: invariant
- Equation: $\rho\left(\sum_k M_k W\right) < 1/\max(\sigma')$
- Symbols: rho spectral radius; M_k, W matrices; sigma' slope of activation.
- Derivation: "False. Non-normal matrices diverge despite rho<1. Global contraction destroys multistability and memory attractors. Replaced by local contraction in certified basins."
- Literature: Theorems T6 & T21.
- Aleph 1: none
- Changes: precursor criterion removed.

### E3: Euler-Poincare sheaf cohomology relation
- Section: Sec 2, Table 1
- Tier: invariant
- Equation: $\dim H^0 - \dim H^1 = d(1-b_1)$; under flat holonomy $\dim H^1 = d\, b_1$
- Symbols: d stalk dimension; b1 first Betti number.
- Derivation: "Algebraic error. By Euler-Poincare ... Under flat holonomy dim H1 = d*b1 (maximal). Replaced with Stiefel manifold synchronization."
- Literature: McRae & Boumal (2024).
- Aleph 1: none
- Changes: refutes precursor claim flat holonomy implies H1=0.

### E4: Participation ratio of exponential spectrum
- Section: Sec 2, Table 1
- Tier: invariant
- Equation: $PR = (1+r)/(1-r) = 3.89$
- Symbols: r spectral decay ratio.
- Derivation: "Arithmetic error. Geometric sum yields PR = ..." (precursors claimed D_eff in [12,16]); "Johnson-Nyquist noise is irrelevant to quantal synaptic noise."
- Literature: Litwin-Kumar (2017).
- Aleph 1: none
- Changes: corrects precursor D_eff.

### E5: Metabolic proportional penalty and overshoot (rejected)
- Section: Sec 2, Table 1
- Tier: other
- Equation: $\lambda = \max(0, \eta[P - P_{max}])$; steady state $P^* = P_{max} + \lambda^*/\eta > P_{max}$
- Symbols: P power, P_max cap, eta gain.
- Derivation: "Guarantees steady-state overshoot P* = Pmax + lambda*/eta > Pmax. Replaced with physical Na+ gradient failure and Control Barrier Functions."
- Literature: ledger conservation.
- Aleph 1: inherited sodium debt ledger (replacement)
- Changes: precursor penalty dropped.

### E6: Energy-dependent setpoint gate chi(e) (change log)
- Section: Sec 2 Table 1 (Model A); also Eq. 15
- Tier: 4/other (homeostat)  [see E21]
- Equation: $\rho\,\chi(e_i)$, $\chi(e) = e^4/(e^4+e_h^4)$
- Derivation: "Homeostat vs Brake conflict: integral controller fought K_ATP brake under ischemia. Set point made energy-dependent ... Prevents spreading depolarization collapse." Validated by "Ischemia survival test".
- Aleph 1: none directly (inherited homeostat, if any)
- Changes: new in A.5 fix of Model A.

### E7: Matched potentiation gate / eviction (change log)
- Section: Sec 2 Table 1 (Model A)
- Tier: 6
- Equation: gate $s_Q + \psi(1-s_Q)$ with eviction $\psi(1-s_Q)\Pi_Q$; previous net loss $(2s-1)\Pi_Q$; guarantee $h_Q(t)\ge 0$
- Derivation: "Ensures exact cancellation and guarantees h_Q(t) >= 0." Cites "Theorem 3 proof".
- Aleph 1: Tier 6 synaptic headroom
- Changes: Model A net loss (2s-1)Pi_Q caused runaway memory destruction.

### E8: Sleep law log-log slope
- Section: Sec 2 Table 1 (Model A.3)
- Tier: invariant
- Equation: $d(\ln t_{sleep})/d(\ln B) = t_{wake}/24 \approx 0.54$
- Symbols: B metabolic rate; t_wake wake hours.
- Derivation: "Derivation error. True analytical derivative ... Empirical slope 0.66 +- 0.36 validates model." Refers to "Section 4.2 derivation" (not in this file).
- Aleph 1: none
- Changes: A.3 had claimed slope 1.0.

### E9: Avian dendritic arbor cost scaling (inline)
- Section: Sec 2 Table 1 (A.3)
- Tier: other
- Equation: k~1,800 (pigeon) vs 8,000 (rodent) synapses; "Linear cost law derives 0.32x cost"
- Derivation: as stated only. Literature: von Eugen (2022).
- Aleph 1: none

### E10: D1-HCN shunting (change log form)
- Section: Sec 2 Table 1 (A.4); formal Eq. 4
- Tier: 1
- Equation: $g_{HCN} = \bar g\, DA^3/(K_D^3+DA^3)$
- Derivation: "Replaced monotonic gain with non-linear D1-cAMP-HCN channel shunting conductance" to give inverted-U under stress. Arnsten (2011).
- Aleph 1: none (Black-Leff operational model analogue at most)
- Changes: A.4 monotonic DA gain.
Other A.4 fixes stated verbally: V_forage(t) hunger drive; asymmetric STDP + priors W_ij^(0) (1.38x reciprocity); delta_Type4 = 0.0 sleep susceptibility factor delta_tau; 2-compartment pyramidals with g_gap (Buzsaki 2015).

### E11: Somatic membrane potential with K_ATP & ephaptic coupling (Eq. 1)
- Section: 3.1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(e_i)(v_i - E_K) + G_s\zeta(1-\nu ACh)\sum_j s_j W_{ij} x_{ij} r_j(t-\tau_{ij}) + G_s(1+\nu ACh) I_i(t) - g_{eph}(v_i - V_e(x_i,t)) + g_{axial}(v_{d,i} - v_i)$
- Symbols: none defined beyond names (ACh cholinergic modulation, nu its weight, zeta, s_j sign, x_ij vesicle resource, tau_ij delay, V_e extracellular field, v_d,i dendritic potential).
- Derivation: none given.
- Literature: Bikson (2004) for fields (ref list).
- Aleph 1: Aleph Eq. 5.1 somatic potential with K_ATP brake
- Changes: ephaptic and axial terms new (A6 axiom, A.4 2-compartment fix).

### E12: K_ATP conductance (Eq. 2)
- Section: 3.1; Tier 1
- Equation: $g_K(e) = \bar g_K / (1 + (e/K_A)^{n_K})$
- Derivation: none. Aleph 1: Eq. 5.1 K_ATP brake term.

### E13: Human dendritic dCaAP compartment (Eq. 3)
- Section: 3.2; Tier 1
- Equation: $C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i}-E_L) + I_{dCaAP}(v_{d,i}) + \sum_{j\in apical} W_{ij}x_{ij}r_j(t-\tau_{ij}) - g_{axial}(v_{d,i}-v_i) - g_{HCN}(DA)(v_{d,i}-E_{HCN})$
- Justification: "apical dendrites incorporate active calcium-mediated XOR logic (Gidon et al. 2020)". I_dCaAP form not given.
- Aleph 1: inherited dendritic potential.

### E14: D1-HCN conductance (Eq. 4)
- Section: 3.2; Tier 1
- Equation: $g_{HCN}(DA) = \bar g_{HCN}[DA^3/(K_D^3+DA^3)]$
- Derivation: see E10. Aleph 1: none.

### E15: Firing-rate gating (Eq. 5)
- Section: 3.3; Tier 1
- Equation: $r_i(t) = \frac{1}{1+(n_i/n_c)^6}\, h_K(k_Q)\, \phi_\tau\big(g_\tau(NE)(v_i - \theta_i - a_i - \theta_0)\big)$
- Symbols: n_i Na+ load, n_c critical; h_K potassium gate (undefined); phi_tau transfer fn; g_tau(NE) noradrenergic gain.
- Justification: change log: "Firing stalls when Na+ exceeds critical threshold n_c."
- Aleph 1: inherited firing-rate transfer function.
- Changes: Na+ gate introduced to fix Model A free-spiking leak.

### E16: Spike-frequency adaptation (Eq. 6)
- 3.3; Tier 1; $\tau_{ad}\, da_i/dt = -a_i + m_{ad} r_i$; none given; Aleph: inherited transfer function (part).

### E17: Sodium debt (Eq. 7)
- Section 3.4; Tier 1
- Equation: $\frac{dn_i}{dt} = \nu_{spk} r_i + \nu_{syn} G_s \sum_j W_{ij}x_{ij}r_j + \lambda_n + I_{ChR2}/(z_{Na} F\, Vol_i) - \Pi_i$
- Justification: "Spikes load Na+; only pump clears it. Ledger closes to 6e-6." I_ChR2 optogenetic current (Deisseroth ref).
- Aleph 1: inherited sodium debt ledger.

### E18: Na/K pump (Eq. 8)
- 3.4; Tier 1/3
- Equation: $\Pi_i = \Pi_{max}\, m(e_i)\, m(n_i)$, $m(z) = z/(z+K_z)$
- none given. Aleph: inherited sodium ledger / ATP balance.

### E19: Cellular ATP balance (Eq. 9)
- Section 3.5; Tier 3
- Equation: $\frac{de_i}{dt} = g_x(e_Q - e_i) - \tfrac13\Pi_i - m(e_i)\left[P_0 + \beta\sum_j W_{ij} + \kappa\sum_j |dW_{ij}/dt| + \kappa_c\sum_j dc^+_{ij}/dt\right]$
- Derivation: none (1/3 factor unexplained; presumably 3 Na+/ATP). Literature Attwell & Laughlin (2001) in refs.
- Aleph 1: inherited Tier 3 ATP balance (Aleph replaces lumped e_i with six pools; caveat 6.2.2 says A.5 lacks ANLS).

### E20: Neurovascular perfusion (Eq. 10)
- 3.6; Tier 2
- $\tau_f\, df_Q/dt = -(f_Q-1) + \kappa_N(u_Q/\bar u_Q - 1) + \kappa_K(k_Q - k_{rest})$
- none given. Aleph: Tier 2 Kir2.1/NsMJ dual dilation (precursor); Eq. 5.6 Kirchhoff replaces.

### E21: Domain ATP/oxygen supply (Eq. 11)
- 3.6; Tier 2/3
- $V_Q\, de_Q/dt = J_0[f_Q E(f_Q)/E_0](1-e_Q) - \sum_{i\in Q} g_x(e_Q-e_i) + D_A\sum_{Q'\sim Q}(e_{Q'}-e_Q)$
- none given; Leontiev & Buxton (2007). Aleph: precursor of Tier 2/3 supply.

### E22: Buxton oxygen extraction (Eq. 12)
- 3.6; Tier 2; $E(f) = 1-(1-E_0)^{1/f}$; Buxton named in heading; no derivation. Aleph: none explicit.

### E23: Extracellular K+ with glymphatic washout (Eq. 13)
- 3.7; Tier 2/6
- $\tau_K\, dk_Q/dt = -m(e_Q)(k_Q-k_{rest}) + \gamma_K \bar r_Q - v_{glymph}(t)(k_Q - k_{CSF})$
- none given. Aleph: Tier 6 glymphatic / perivascular flux.

### E24: Glymphatic velocity (Eq. 14)
- 3.7; Tier 6
- $v_{glymph}(t) = v_{wake} + v_{sleep}\,\mathbb{1}_{SWS}(t)\,(AQP4/AQP4_0)\,[1-\sigma(([NE](t)-\theta_{NE})/s_N)]$ (indicator rendered "II_SWS")
- none given; Fultz 2019, Nedergaard 2020 refs. Aleph: Tier 6 glymphatic peristalsis / AQP4 polarity.

### E25: Energy-aware homeostatic setpoint (Eq. 15)
- 3.8; Tier 4 (homeostatic controller)
- $\tau_\theta\, d\theta_i/dt = r_i - \rho_i\chi(e_i)$, $\chi(e)=e^4/(e^4+e_h^4)$, $\rho_i\sim \mathrm{LogNormal}(\mu_\rho,\sigma_\rho)$
- Justification: axiom A4 + E6. Aleph: Tier 4 AIS controller (partial analogue).

### E26: Tsodyks-Markram vesicles (Eq. 16)
- 3.9; Tier 1/6; $dx_{ij}/dt = (1-x_{ij})/\tau_{rec} - U x_{ij} r_j$; none given. Aleph: none listed.

### E27: Plasticity with headroom barrier & eviction (Eq. 17)
- 3.10; Tier 6
- $\tau_w\, dW_{ij}/dt = (1-b_m)\left[(s_Q+\psi(1-s_Q))DA^+ f^+_{ij}(w_{max}-W_{ij}) - (1+DA^-)f^-_{ij}W_{ij}\right] - \gamma(1-P_{ij})W_{ij} - E_{ij}$
- Justification: E7. Aleph: Tier 6 synaptic headroom.

### E28: Supply gate and headroom (Eq. 18)
- 3.10; Tier 6
- $s_Q = \min\{1, (D_Q + \gamma_h\tau_w h_Q/\beta)/\Pi_Q\}$, $h_Q = C_{max,Q} - \beta\sum_{kl\in Q}W_{kl}$
- none. Aleph: Tier 6 synaptic headroom.

### E29: Eviction allocation (Eq. 19)
- 3.10; Tier 6
- $E_{ij} = \psi(1-s_Q)\Pi_Q[\omega_{ij}/\sum_{kl\in Q}\omega_{kl}]$, $\omega_{ij} = (1-P_{ij})W_{ij}\exp(-f^+_{ij}/f_0)$
- Justification: exact cancellation (E7). Aleph: Tier 6 headroom.

### E30: Synaptic tag (Eq. 20)
- 3.11; Tier 6; $\tau_\Omega\, d\Omega_{ij}/dt = \kappa_\Omega DA^+ f^+_{ij}(1-\Omega_{ij}) - \Omega_{ij}$; none. Aleph: condensate capture SDE (tag input).

### E31: Bistable condensate capture SDE (Eq. 21)
- 3.11; Tier 6
- $\tau_c\, dc_{ij}/dt = \Omega_{ij}\pi(e_Q)(1-c_{ij}) + \beta_c[c_{ij}^2/(K_c^2+c_{ij}^2)] - \gamma_c c_{ij} + \sqrt{2D}\,\xi_{ij}(t)$
- none. Aleph: Tier 6 condensate capture SDE.

### E32: Energy gate and protection (Eq. 22)
- 3.11; Tier 6; $\pi(e)=e^4/(e^4+e_\pi^4)$, $P_{ij}=\max(\Omega_{ij},c_{ij})$; none. Aleph: condensate capture.

### E33: Interstitial adenosine (Eq. 23)
- 3.12; Tier 6; $d[Ado]_Q/dt = \eta_{ATP}\Pi_Q - \lambda_{uptake}[Ado]_Q - v_{glymph}(t)[Ado]_Q$; none. Aleph: circadian sleep pruning (input).

### E34: Two-process sleep downscaling (Eq. 24)
- 3.12; Tier 6; $dS/dt = g_w$ (wake); $dS/dt = -k\,u(Ado,NE,t)(S-S_{set})$ (sleep)
- Justification: change log A.3 zebrafish: constant u=1 mispredicted; "Early Ado decay and pre-dawn NE surge clamp dS/dt = 0." Suppermpool (2024). Aleph: circadian sleep pruning tensor.

### E35: Sleep gate (Eq. 25)
- 3.12; Tier 6; $u(Ado,NE,t) = \sigma(([Ado](t)-\theta_{Ado})/s_A)[1-\sigma(([NE](t)-\theta_{NE})/s_N)]$; same justification. Aleph: sleep pruning tensor.

### E36: Theta phase (Eq. 26)
- 3.13; Tier other; $d\phi_i/dt = \omega_0 + \kappa_{drive} r_i(t) - \omega_\theta$; none. Aleph: none (LC Stuart-Landau Eq. 5.7 is a different oscillator).

### E37: Ephaptic field potential (Eq. 27)
- 3.13; Tier 1; $V_e(x,t) = \frac{1}{4\pi\sigma_{eff}}\sum_j I_{trans,j}(t)/|x-x_j|$; none (point-source volume conductor). Aleph: none (Aleph uses Cx36 gap junctions Eq. 5.4 instead).

### E38: Theta-gamma slot capacity
- Sec 4 item 4; Tier invariant
- $N = T_\theta/T_\gamma \approx 4$ to 7 (T_theta~210 ms; T_gamma~25-35 ms)
- Justification: "explaining Cowan's 4+-1 and Miller's 7+-2 ... without fitted parameters." Lisman & Jensen (2013). Aleph: none.

### E39: Human energetics numbers (inline)
- Sec 4 item 3; other: 20.0 W, ~280 umol/min glucose (0.31 umol/g/min), per-neuron 3.25e-9 umol/min "exactly matching Herculano-Houzel (2011)". Aleph: none.
