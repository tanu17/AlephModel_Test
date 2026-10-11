# Extraction: Model_A8_All_Equations.lean
- Model version(s) specified: Model A.8 (namespace ModelA8Full)
- One-paragraph summary of the file: Lean 4 formalization "MODEL A.8 EXHAUSTIVE MULTI-TIER PROOFS" covering six tiers. It defines Lean `def`s for the governing ODE right-hand sides (somatic/dendritic potentials, sodium ledger, Poiseuille conductance, arteriolar dilation, six-pool metabolism (four pools coded), CK-buffered ATP balance, AIS tri-variable controller + threshold, extracellular Ca depletion, condensate capture SDE drift/diffusion, glymphatic velocity) and proves 12 small theorems (special-case simplifications, equilibria, positivity, conservation). Proofs are algebraic (dsimp/ring/linarith); no literature citations. Note: the "exhaustive" file contains no Black-Leff, Woodhull, Hall-Ehlert, Pennes, Stuart-Landau, Kirchhoff, stall, Q, HDAC, k_stress, hydraulic floor equations.
- Parts that could not be read (if any): none (359 lines, all read).

### E1: Somatic membrane potential dv_s/dt
- Section in source: Tier 1, `dv_s_dt`
- Tier: 1
- Equation: $\frac{dv_s}{dt}=\frac{1}{\tau_v}\Big[-(v_s-v_{rest})-g_K(v_s-E_K)-g_{adap}\,w\,(v_s-E_K)+G_s\zeta(1-\nu_{ACh})I_{syn}+G_s(1+\nu_{ACh})I_{ext}+g_{ax}\big((v_d-v_s)+(V_{e,d}-V_{e,s})\big)\Big]$
- Symbols: tau_v>0; v_rest; E_K; g_adap; G_s; zeta; nu_ACh in [0,1]; g_ax axial coupling; g_K (input, no K_ATP decomposition given); w adaptation; V_e_d,V_e_s extracellular potentials at dendrite/soma. No units.
- Derivation: none given (labelled "Eq. Tier 1").
- Cites: none.
- Aleph 1: Aleph Eq. 5.1 (somatic potential; here g_K is a free input, no explicit K_ATP brake term).
- Changes mentioned: none.

### E2 (invariant): Theorem 1.1 Ephaptic cancellation in uniform field
- Section: Tier 1, `ephaptic_coupling_cancels_in_uniform_field`
- Tier: invariant
- Equation: If $V_{e,d}=V_{e,s}=V_e$, then $\frac{dv_s}{dt}=\frac{1}{\tau_v}[-(v_s-v_{rest})-g_K(v_s-E_K)-g_{adap}w(v_s-E_K)+G_s\zeta(1-\nu_{ACh})I_{syn}+G_s(1+\nu_{ACh})I_{ext}+g_{ax}(v_d-v_s)]$
- Symbols: as E1.
- Derivation: unfold definition; $V_e-V_e=0$ (sub_self); drop "+0".
- Cites: none. Aleph 1: property of Eq. 5.1. Changes: none.

### E3: dCaAP activation
- Section: Tier 1, `dCaAP_activation`
- Tier: 1
- Equation: $A(u)=\begin{cases}0 & u<u_{th}\\ \exp(-(u-u_{th})/w_{Ca}) & u\ge u_{th}\end{cases}$
- Symbols: u drive, u_th threshold, w_Ca width.
- Derivation: none given. Cites: none (dendritic Ca action potential). Aleph 1: inherited Tier 1 dendritic potential. Changes: none.

### E4: Dendritic membrane potential dv_d/dt
- Section: Tier 1, `dv_d_dt`
- Tier: 1
- Equation: $\frac{dv_d}{dt}=\frac{1}{C_d}\Big[-g_{leak}(v_d-E_L)+\bar A_{Ca}A(u)-g_{HCN}(v_d-E_{HCN})+I_{apical}-g_{ax}\big((v_d-v_s)+(V_{e,d}-V_{e,s})\big)\Big]$
- Symbols: C_d>0, E_L, A_Ca_bar, E_HCN, g_ax, g_leak, g_HCN, I_apical.
- Derivation: none given. Cites: none. Aleph 1: inherited Tier 1 dendritic potential. Changes: none.

### E5 (invariant): Theorem 1.2 Sub-threshold dendritic Ca isolation
- Section: Tier 1, `dCaAP_zero_below_threshold`
- Tier: invariant
- Equation: $u<u_{th}\Rightarrow \frac{dv_d}{dt}=\frac{1}{C_d}[-g_{leak}(v_d-E_L)-g_{HCN}(v_d-E_{HCN})+I_{apical}-g_{ax}((v_d-v_s)+(V_{e,d}-V_{e,s}))]$
- Derivation: unfold, if_pos gives A=0, mul_zero, ring normalization.
- Cites: none. Aleph 1: property of inherited dendritic eq. Changes: none.

### E6: Michaelis-Menten helper
- Section: Tier 1, `mm`
- Tier: 1
- Equation: $mm(x,K)=\frac{x}{x+K}$
- Derivation: none. Aleph 1: inherited sodium debt ledger component.

### E7: Na/K pump rate
- Section: Tier 1, `pump_rate`
- Tier: 1
- Equation: $\Pi(a,n)=\Pi_{max}\frac{a}{a+K_a}\frac{n}{n+K_n}$
- Symbols: Pi_max>0, K_a>0, K_n>0; a ATP, n sodium.
- Derivation: none. Aleph 1: inherited sodium debt ledger.

### E8: Sodium ledger dn/dt
- Section: Tier 1, `dn_dt`
- Tier: 1
- Equation: $\frac{dn}{dt}=(\nu_{spk}r+\nu_{syn}G_s\,\text{syn\_drive}+\lambda_n+I_{opt})\left(1-\frac{n}{n_{eq}}\right)-\Pi(a,n)$
- Symbols: nu_spk, nu_syn, G_s, lambda_n>0, n_eq>0, r rate, I_opt optical load.
- Derivation: none. Aleph 1: inherited sodium debt ledger. Changes: none.

### E9 (invariant): Theorem 1.3 Sodium boundary forward invariance
- Section: Tier 1, `sodium_boundary_invariant`
- Tier: invariant
- Equation: for $a,r,\text{syn\_drive},I_{opt}\ge0$: $\frac{dn}{dt}\big|_{n=n_{eq}}\le 0$
- Derivation: $1-n_{eq}/n_{eq}=0$ so drive term vanishes, leaving $-\Pi(a,n_{eq})$; $\Pi\ge0$ as product of $\Pi_{max}>0$ and nonneg MM fractions (a≥0, K_a>0; n_eq>0, K_n>0); linarith.

### E10: Hagen-Poiseuille conductance
- Section: Tier 2, `poiseuille_conductance`
- Tier: 2
- Equation: $G_e=\frac{\pi r^4}{8\eta l}$
- Symbols: radius r>0, length l>0, viscosity eta>0.
- Derivation: none (named Hagen-Poiseuille). Aleph 1: inherited Hagen-Poiseuille conductance.

### E11 (invariant): Theorem 2.1 Strictly positive conductance
- Equation: $G_e>0$
- Derivation: numerator $\pi r^4>0$ (pi_pos, pow_pos), denominator $8\eta l>0$ (positivity), div_pos.

### E12: Arteriolar dilation dr_a/dt
- Section: Tier 2, `dr_a_dt`
- Tier: 2
- Equation: $\frac{dr_a}{dt}=\frac{1}{\tau_a}\Big[r_{a0}\big(1+\beta_{NsMJ}\frac{I_{NsMJ}}{I_0}+\beta_a\Phi_{root}+\beta_{astro}F_{A2B}+\beta_d\sum\text{coupling}\big)-r_a\Big]$
- Symbols: tau_a>0, r_a0, beta_NsMJ, I_0>0, beta_a, beta_astro, beta_d; A_K declared but unused; Phi_root, F_A2B, coupling_sum inputs.
- Derivation: none. Aleph 1: inherited NsMJ + Kir2.1 dual dilation (Kir2.1 implied via coupling_sum/Phi_root [unclear]).

### E13 (invariant): Theorem 2.2 Basal arteriolar equilibrium
- Equation: $\frac{dr_a}{dt}(r_a=r_{a0}, I_{NsMJ}=\Phi_{root}=F_{A2B}=\text{coupling}=0)=0$
- Derivation: unfold, ring_nf.

### E14: Glucose pool
- Section: Tier 3, `dG_dt` — Tier 3
- Equation: $\dot G=J_G-v_{gn}-v_{ga}-v_{syn}$
- Derivation: none. Aleph 1: Tier 3 six-pool (G).

### E15: Lactate pool
- Equation: $\dot L=2(v_{ga}+v_{gly})+v_{ex}-J_L$ — Tier 3, none given. Aleph 1: Tier 3 (L).

### E16: Glycogen pool Gamma
- Equation: $\dot\Gamma=v_{syn}-v_{gly}$ — Tier 3. Aleph 1: Tier 3 (Gamma).

### E17: Pyruvate pool p
- Equation: $\dot p=2v_{gn}-v_{ox}-v_{ex}$ — Tier 3. Aleph 1: Tier 3 (p). (o pool not coded; a in E19.)

### E18 (invariant): Theorem 3.1 Exact carbon mass conservation
- Equation: $\dot G+\dot\Gamma+\frac{\dot L+\dot p}{2}=J_G-\frac{J_L}{2}-\frac{v_{ox}}{2}$
- Derivation: unfold, ring. Aleph 1: carbon balance.

### E19: ATP balance with CK buffer
- Section: Tier 3, `da_dt`
- Equation: $\dot a=2v_{gn}+27.5\,v_{ox}+k_{CK}\left(PCr\cdot ADP-\frac{Cr\cdot ATP}{K_{eq}}\right)-D$
- Symbols: k_CK>0, K_eq>0, D demand; yields 2 (glycolysis) and 27.5 (oxidation) hard-coded.
- Derivation: none. Aleph 1: Tier 3 CK/PCr buffer + ATP balance.

### E20 (invariant): Theorem 3.2 CK equilibrium
- Equation: if $PCr\cdot ADP=Cr\cdot ATP/K_{eq}$ then $\dot a=2v_{gn}+27.5v_{ox}-D$
- Derivation: substitute, sub_self, mul_zero.

### E21: AIS length dL/dt
- Section: Tier 4 — Equation: $\frac{dL}{dt}=\frac{1}{\tau_L}[-(L-L_0)-G_LL_0(\bar c-1)]$ — Aleph 1: Tier 4 controller (L).
### E22: AIS position dx/dt
- Equation: $\frac{dx}{dt}=\frac{1}{\tau_x}[-(x-x_0)+G_x(\bar c-1)]$ — Tier 4.
### E23: AIS conductance dg/dt
- Equation: $\frac{dg}{dt}=\frac{1}{\tau_g}[-(g-g_0)-G_gg_0(\bar c-1)]$ — Tier 4.
- Symbols (E21-23): tau_L,tau_x,tau_g; L_0,x_0,g_0>0; gains G_L,G_x,G_g; c_bar normalized activity. Derivation none.
### E24: AIS threshold law
- Equation: $\theta_{AIS}=-k_B\ln(L/L_0)-k_x\ln(x/x_0)-k_g\ln(g/g_0)$ — Tier 4, none given.
### E25 (invariant): Theorem 4.1 Unique AIS fixed point
- Equation: at $\bar c=1$, $\dot L=\dot x=\dot g=0\Rightarrow L=L_0,x=x_0,g=g_0$
- Derivation: c-1=0 kills drive; product $(1/\tau)\cdot(-(\cdot))=0$, exclude first factor zero; note proof uses positivity of $1/L_0$ (h_L0_pos) in all three cases rather than tau positivity, and no tau>0 hypotheses exist in the structure — apparent proof flaw.
### E26 (invariant): Theorem 4.2 Zero threshold shift at fixed point
- Equation: $\theta_{AIS}(L_0,x_0,g_0)=0$ — Derivation: ratios =1, ln 1=0.

### E27: Extracellular Ca depletion
- Section: Tier 5, `dCa_dt`
- Equation: $\frac{dCa_e}{dt}=\frac{1}{\tau_{Ca}}\left[-I_{burst}+\frac{Ca_0-Ca_e}{\tau_{ref}}\right]$
- Symbols: tau_Ca>0, Ca_0>0, tau_ref>0. Derivation none. Aleph 1: Tier 5 PV block extracellular Ca cutoff.
### E28 (invariant): Theorem 5.1 Calcium recovery
- Equation: $I_{burst}=0,\ \dot{Ca}_e=0\Rightarrow Ca_e=Ca_0$ — Derivation: mul_eq_zero, 1/tau_Ca≠0, div_eq_zero with tau_ref≠0, linarith.

### E29: Condensate capture SDE drift
- Section: Tier 6, `capture_drift`
- Equation: $\mu(c)=\Omega\pi_a(1-c)+\beta_c\frac{c^2(1-c)}{K_c^2+c^2}-\gamma_cc$
- Symbols: Omega, pi_a, beta_c, gamma_c>0, K_c. Aleph 1: Tier 6 condensate capture SDE.
### E30: Capture diffusion
- Equation: $\sigma(c)=\sigma_cc(1-c)$ (full SDE $dc=\mu dt+\sigma dW$ not written explicitly).
### E31 (invariant): Theorem 6.1 Vanishing diffusion at boundaries
- Equation: $c\in\{0,1\}\Rightarrow\sigma(c)=0$ — ring.

### E32: Sigmoidal gate
- Equation: $S(x;\theta,s)=\frac{1}{1+\exp(-(x-\theta)/s)}$ — Tier 6.
### E33: Glymphatic velocity
- Equation: $v_{glymph}=v_0+[\text{NREM}]v_1\frac{AQP4}{AQP4_0}\frac{A_{NE}}{A_{NE}+K_{NE}}(1-S(\overline{NE};\theta_g,s_g))$
- Symbols: AQP4_0>0, K_NE>0, A_NE LC pulsatility amplitude, NE_bar mean NE. Aleph 1: glymphatic peristalsis (+AQP4 polarity).
### E34 (invariant): Theorem 6.2 Zolpidem pulsatility loss
- Equation: $A_{NE}=0\Rightarrow v_{glymph}=v_0$ — Derivation: 0/(0+K_NE)=0, mul_zero. Cites "Zolpidem Effect" (no reference). Note: title says "Complete Glymphatic Cessation" but result is baseline v_0, not zero.
