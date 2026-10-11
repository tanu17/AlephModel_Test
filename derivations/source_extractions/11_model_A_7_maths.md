# Extraction: model A.7 maths.docx
- Model version(s) specified: A.7 (by filename; text itself names no version)
- One-paragraph summary of the file: A short summary of the model's core equations grouped by function: two-compartment soma/dendrite potentials (Tier 1), sodium debt ledger and Na/K pump (Tier 1), six-pool metabolism (Tier 3), AIS length/position and threshold (Tier 4), vascular radius, Hagen-Poiseuille and Kirchhoff (Tier 2), condensate capture SDE and adenosine sleep pressure (Tier 6). It ends with five "derivations/validations": sodium-ledger forward invariance, capture-probability bounds, Kirchhoff mass conservation, ephaptic field geometry, and carbon mass balance.
- Parts that could not be read (if any): none

### E1: Somatic membrane potential
- Section in source: 1. Somatic and Dendritic Signaling (Tier 1)
- Tier: 1
- Equation: $\tau_{v}\frac{dv_{i}}{dt} = -(v_{i}-v_{rest}) - g_{K}(a_{i})(v_{i}-E_{K}) + G_{s}\zeta(1-\nu_{ACh})\sum_{j}s_{j}W_{ij}x_{ij}r_{j}(t-\tau_{ij}) + G_{s}(1+\nu_{ACh})I_{i}(t) + g_{ax}[(v_{d,i}-v_{i}) + (V_{e}(x_{d,i})-V_{e}(x_{s,i}))]$
- Symbols: only described collectively: passive leak, ATP-dependent K shunting g_K(a_i), delayed synaptic inputs (delay tau_ij), axial current from dendrite. nu_ACh, zeta, s_j, W_ij, x_ij, r_j, G_s, I_i not individually defined. No units.
- Derivation: none given beyond the description; ephaptic term justified in Validation 4 (see E22).
- Cites: none
- Aleph 1: Aleph Eq. 5.1 (somatic potential; A.7 has g_K(a) K_ATP-type term)
- Changes: none mentioned

### E2: Dendritic membrane potential
- Section: 1 (Tier 1)
- Tier: 1
- Equation: $C_{d}\frac{dv_{d,i}}{dt} = -g_{L}(v_{d,i}-E_{L}) + \overline{A}_{Ca}\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i}-E_{HCN}) - g_{ax}[(v_{d,i}-v_{i}) + (V_{e}(x_{d,i})-V_{e}(x_{s,i}))]$
- Symbols: dCaAP term \bar A_Ca Delta(u_{d,i}); HCN shunting conductance controlled by dopamine (DA). Others undefined.
- Derivation: none given
- Cites: none
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: none mentioned

### E3: Sodium load ledger
- Section: 2. Intracellular Sodium Debt and Pumping (Tier 1)
- Tier: 1
- Equation: $\frac{dn_{i}}{dt} = [\nu_{spk}r_{i} + \nu_{syn}G_{s}\sum_{j}W_{ij}x_{ij}r_{j} + \lambda_{n} + \frac{I_{ChR2,Na}}{F\cdot Vol_{i}}](1-\frac{n_{i}}{n_{eq}}) - \Pi_{i}$
- Symbols: n_i sodium load; n_eq physical equilibrium; I_ChR2,Na optogenetic Na current; F Faraday; Vol_i volume; lambda_n basal leak [not defined explicitly].
- Derivation: see Validation 1 (E20): driving-force limit factor (1 - n_i/n_eq) added.
- Cites: none
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: "Previous models suffered from unbounded sodium inflation when ATP dropped to zero"; the limit factor was added.

### E4: Na+/K+ pump extrusion
- Section: 2 (Tier 1)
- Tier: 1
- Equation: $\Pi_{i} = \Pi_{\max}m(a_{i},K_{a})m(n_{i},K_{n})$
- Symbols: a_i intracellular ATP, n_i sodium debt; m(.,K) saturating function [unclear: form not given].
- Derivation: "pump operation scales directly with available intracellular ATP and accumulated sodium debt."
- Cites: none
- Aleph 1: inherited Tier 1 sodium debt ledger (pump term)
- Changes: none

### E5: Intracellular ATP
- Section: 3. Multi-Substrate Metabolism (Tier 3)
- Tier: 3
- Equation: $\frac{da}{dt} = 2v_{gn} + Y_{ox}v_{ox} - D$
- Symbols: v_gn neuronal glycolysis; v_ox oxidative phosphorylation; Y_ox yield; D demand.
- Derivation: none given
- Cites: none
- Aleph 1: Tier 3 six-pool metabolism (ATP pool a)
- Changes: none

### E6: Tissue glucose
- Section: 3; Tier: 3
- Equation: $\frac{dG}{dt} = J_{G} - v_{gn} - v_{ga} - v_{syn}$
- Symbols: J_G glucose transport in; v_ga astrocytic glycolysis [inferred name not given]; v_syn glycogen synthesis.
- Derivation: none (closure in E23)
- Cites: none; Aleph 1: Tier 3 pool G; Changes: none

### E7: Tissue glycogen
- Section: 3; Tier: 3
- Equation: $\frac{d\Gamma}{dt} = v_{syn} - v_{gly}$
- Symbols: v_gly glycogenolysis. Derivation: none. Cites: none. Aleph 1: Tier 3 pool Gamma. Changes: none

### E8: Lactate
- Section: 3; Tier: 3
- Equation: $\frac{dL}{dt} = 2(v_{ga}+v_{gly}) + v_{ex} - J_{L}$
- Symbols: v_ex pyruvate-lactate exchange; J_L lactate efflux. Derivation: none. Cites: none. Aleph 1: Tier 3 pool L / lactate shuttle. Changes: none

### E9: Pyruvate
- Section: 3; Tier: 3
- Equation: $\frac{dp}{dt} = 2v_{gn} - v_{ox} - v_{ex}$
- Derivation: none. Cites: none. Aleph 1: Tier 3 pool p. Changes: none

### E10: Oxygen
- Section: 3; Tier: 3
- Equation: $c_{O}\frac{do}{dt} = J_{O} - 3v_{ox}$
- Symbols: c_O capacity; J_O oxygen supply. Derivation: none. Cites: none. Aleph 1: Tier 3 pool o. Changes: none

### E11: AIS length
- Section: 4. AIS Plasticity (Tier 4)
- Tier: 4
- Equation: $\tau_{L}\frac{dL_{i}}{dt} = -(L_{i}-L_{0}) - G_{L}L_{0}(\overline{c}_{i}-1)$
- Symbols: \bar c_i calcium proxy. Derivation: none ("shifts slowly in response to calcium proxies"). Cites: none. Aleph 1: Tier 4 AIS controller (L). Changes: no g_AIS variable in A.7 (two variables only).

### E12: AIS position
- Section: 4; Tier: 4
- Equation: $\tau_{x}\frac{dx_{i}}{dt} = -(x_{i}-x_{0}) + G_{x}(\overline{c}_{i}-1)$
- Derivation: none. Cites: none. Aleph 1: Tier 4 AIS controller (x). Changes: none

### E13: AIS threshold shift
- Section: 4; Tier: 4
- Equation: $\theta_{AIS,i} = -k_{B}\ln(\frac{L_{i}}{L_{0}}) - k_{x}\ln(\frac{x_{i}}{x_{0}})$
- Derivation: none. Cites: none. Aleph 1: Tier 4 threshold law. Changes: none

### E14: Vessel radius
- Section: 5. Vascular Fluid Dynamics (Tier 2)
- Tier: 2
- Equation: $r_{e} = r_{0}(1+\beta_{c}\overline{\psi}_{e})$
- Symbols: \bar psi_e [unclear: vasoactive signal, not defined]; beta_c (same symbol as capture gain in E16). Derivation: none. Aleph 1: inherited Tier 2 dilation (precursor to NsMJ/Kir2.1). Changes: none

### E15: Hagen-Poiseuille conductance
- Section: 5; Tier: 2
- Equation: $G_{e} = \frac{r_{e}^{4}}{\mathcal{l}_{e}}$
- Symbols: l_e segment length. Derivation: none; named Hagen-Poiseuille (constant pi/8mu omitted as written). Aleph 1: inherited Hagen-Poiseuille conductance. Changes: none

### E16: Kirchhoff flow rule
- Section: 5; Tier: 2
- Equation: $\sum_{e\in c}G_{e}(p_{c}-p_{c'}) = c_{a}r_{a}^{4}(P_{a}-p_{c}) - G_{v}p_{c}$
- Symbols: p_c node pressure, P_a arterial pressure, r_a arteriole radius, G_v venous conductance.
- Derivation: Validation 3 (E21). Cites: Kirchhoff. Aleph 1: Aleph Eq. 5.6. Changes: none

### E17: Bistable condensate capture SDE
- Section: 6. Memory Capture and Sleep Mechanisms (Tier 6)
- Tier: 6
- Equation: $\tau_{c}\frac{dc_{ij}}{dt} = \Omega_{ij}\pi(a)(1-c_{ij}) + \beta_{c}\frac{c_{ij}^{2}(1-c_{ij})}{K_{c}^{2}+c_{ij}^{2}} - \gamma_{c}c_{ij} + \sigma_{c}c_{ij}(1-c_{ij})dB_{ij}$
- Symbols: Omega_ij tag drive, pi(a) ATP gate, dB Brownian increment. Referred to as "Eq 33".
- Derivation: "noisy escape over a bistable barrier"; bounds in Validation 2 (E19).
- Aleph 1: Tier 6 condensate capture SDE. Changes: bounds "resolving prior numerical stability failures".

### E18: Adenosine sleep pressure
- Section: 6; Tier: 6
- Equation: $\frac{d[Ado]}{dt} = \eta\Pi_{Q} - \lambda_{u}[Ado] - v_{glymph}[Ado]$
- Symbols: Pi_Q [unclear: pump/energy flux]; lambda_u uptake; v_glymph glymphatic clearance. Derivation: none. Aleph 1: Tier 6 circadian sleep / glymphatic clearance. Changes: none

### E19: Capture probability bounds
- Section: Key Derivations 2
- Tier: invariant
- Equation: c_ij in [0,1] invariant; drift vanishes at c=0 [as stated], drift = $-\gamma_c<0$ at c=1; noise $\sigma_{c}c_{ij}(1-c_{ij})$ zero at both ends.
- Derivation: quoted: "the drift factor vanishes at c = 0, and is negative (-gamma_c < 0) at c = 1 ... noise multiplier zeroes out at both ends ... neither numerical noise nor signal drift can force the variable outside [0,1]". (Note: at c=0 the drift as written equals Omega pi(a) >= 0, not zero; recorded as stated.)
- Aleph 1: Tier 6 capture SDE bounds

### E20: Sodium ledger forward invariance
- Section: Key Derivations 1; Tier: invariant
- Equation: at $n_i=n_{eq}$, influx factor $(1-n_i/n_{eq})=0$, $\Pi_i\ge0 \Rightarrow dn_i/dt\le0$; $[0,n_{eq}]$ forward-invariant.
- Derivation: as quoted; no argument given for lower boundary n=0.
- Aleph 1: inherited Tier 1 sodium ledger

### E21: Kirchhoff mass conservation
- Section: Key Derivations 3; Tier: invariant (Tier 2)
- Statement: graph Laplacian matrix symmetric positive definite on connected graph -> unique pressures; numeric inflow-outflow residual $1.8\times10^{-15}$.
- Aleph 1: Eq. 5.6

### E22: Ephaptic field geometry
- Section: Key Derivations 4; Tier: invariant (Tier 1)
- Equation: axial term $V_{e}(x_{d,i}) - V_{e}(x_{s,i})$; uniform field -> 0.
- Derivation: "Uniform extracellular fields physically exert no net perturbation on point neurons"; nonuniform gradient gives opposite soma/dendrite polarization.
- Aleph 1: Eq. 5.1 / dendritic potential

### E23: Carbon mass balance
- Section: Key Derivations 5; Tier: invariant (Tier 3)
- Equation: $\frac{d}{dt}[G + \Gamma + \frac{(L+p)}{2}]$ = glucose in minus oxygen consumed minus lactate efflux (only stated in words; no explicit right side given).
- Derivation: "sum of changes in glucose, glycogen, and half of combined lactate and pyruvate balances glucose transported in, minus oxygen consumed and lactate effluxed out". Aleph 1: Tier 3 carbon balance
