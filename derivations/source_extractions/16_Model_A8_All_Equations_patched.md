# Extraction: Model_A8_All_Equations_patched.lean
- Model version(s) specified: Model A.8 (namespace ModelA8Full)
- One-paragraph summary of the file: Lean 4 (Mathlib) formalization, 342 lines, "Model A.8 exhaustive multi-tier proofs ... with corrected tactics and disambiguated identifiers". Defines one or more equations per tier (6 tiers) as Lean `def`s with parameter structures carrying positivity hypotheses, and proves 12 small algebraic theorems (equilibria, cancellations, boundary invariants). No literature citations; the "derivations" are Lean proof tactics. The patch is visible only through the header note ("corrected tactics and disambiguated identifiers"), e.g. distinct names dL_lactate_dt vs dL_ais_dt; no diff markers are in the file.
- Parts that could not be read (if any): none.

### E1: Somatic membrane potential (two-compartment, ephaptic, cholinergic gain)
- Section in source: Tier 1 (SomaticParams, dv_s_dt)
- Tier: 1
- Equation: $\frac{dv_s}{dt}=\frac{1}{\tau_v}\Big[-(v_s-v_{rest})-g_K(v_s-E_K)-g_{adap}\,w\,(v_s-E_K)+G_s\zeta(1-\nu_{ACh})I_{syn}+G_s(1+\nu_{ACh})I_{ext}+g_{ax}\big((v_d-v_s)+(V_{e,d}-V_{e,s})\big)\Big]$
- Symbols: tau_v>0; v_rest; E_K; g_adap; adaptation w; G_s gain; zeta; nu_ACh in [0,1]; g_ax axial conductance; v_d dendritic potential; V_e_d, V_e_s extracellular potentials at dendrite/soma; g_K; I_syn; I_ext. No units.
- Derivation: none given.
- Cites: none.
- Aleph 1: Aleph Eq. 5.1 (somatic potential) — note no K_ATP brake term here.
- Changes mentioned: none.

### E2: Theorem ephaptic_coupling_cancels_in_uniform_field
- Section: Tier 1
- Tier: invariant
- Equation: with $V_{e,d}=V_{e,s}=V_e$: $\frac{dv_s}{dt}=\frac{1}{\tau_v}[\dots+g_{ax}(v_d-v_s)]$
- Derivation: proof: unfold, $V_e-V_e=0$ (sub_self), add_zero.
- Aleph 1: property of Eq. 5.1.

### E3: dCaAP activation
- Section: Tier 1 (dCaAP_activation)
- Tier: 1
- Equation: $A(u)=\begin{cases}0 & u<u_{th}\\ \exp\!\big(-(u-u_{th})/w_{Ca}\big) & u\ge u_{th}\end{cases}$
- Symbols: u, u_th threshold, w_Ca width.
- Derivation: none given.
- Aleph 1: inherited dendritic potential.

### E4: Dendritic potential
- Section: Tier 1 (DendriticParams, dv_d_dt)
- Tier: 1
- Equation: $\frac{dv_d}{dt}=\frac{1}{C_d}\Big[-g_{leak}(v_d-E_L)+\bar A_{Ca}A(u)-g_{HCN}(v_d-E_{HCN})+I_{apical}-g_{ax}\big((v_d-v_s)+(V_{e,d}-V_{e,s})\big)\Big]$
- Symbols: C_d>0, E_L, A_Ca_bar, E_HCN, g_ax, g_leak, g_HCN, I_apical.
- Derivation: none given.
- Aleph 1: inherited dendritic potential.

### E5: Theorem dCaAP_zero_below_threshold
- Tier: invariant
- Equation: $u<u_{th}\Rightarrow \frac{dv_d}{dt}=\frac{1}{C_d}[-g_{leak}(v_d-E_L)-g_{HCN}(v_d-E_{HCN})+I_{apical}-g_{ax}((v_d-v_s)+(V_{e,d}-V_{e,s}))]$
- Derivation: unfold, if_pos, ring.

### E6: Michaelis-Menten helper
- Section: Tier 1 (mm)
- Tier: 1
- Equation: $\mathrm{mm}(x,K)=\frac{x}{x+K}$
- Derivation: none.

### E7: Na/K pump rate
- Section: Tier 1 (pump_rate)
- Tier: 1
- Equation: $\Pi(a,n)=\Pi_{max}\frac{a}{a+K_a}\frac{n}{n+K_n}$
- Symbols: a ATP, n sodium; Pi_max,K_a,K_n>0.
- Aleph 1: inherited sodium debt ledger.

### E8: Sodium debt ledger
- Section: Tier 1 (dn_dt)
- Tier: 1
- Equation: $\frac{dn}{dt}=(\nu_{spk}r+\nu_{syn}G_s\,\mathrm{syn\_drive}+\lambda_n+I_{opt})\left(1-\frac{n}{n_{eq}}\right)-\Pi(a,n)$
- Symbols: r firing rate, nu_spk, nu_syn, lambda_n>0 leak, n_eq>0, I_opt optical drive.
- Derivation: none.
- Aleph 1: inherited sodium debt ledger.

### E9: Theorem sodium_boundary_invariant
- Tier: invariant
- Equation: $a,r,\mathrm{syn},I_{opt}\ge0 \Rightarrow \frac{dn}{dt}\big|_{n=n_{eq}}\le 0$
- Derivation: $1-n_{eq}/n_{eq}=0$ kills drive; pump $\ge0$ since product of nonnegatives (Pi_max>0, a/(a+K_a)≥0, n_eq/(n_eq+K_n)≥0); linarith.

### E10: Poiseuille conductance
- Section: Tier 2 (VascularBranch)
- Tier: 2
- Equation: $G=\frac{\pi r^4}{8\eta l}$
- Symbols: radius, length, viscosity >0.
- Cites: (Hagen-)Poiseuille by name.
- Aleph 1: inherited Hagen-Poiseuille conductance.

### E11: Theorem poiseuille_conductance_strictly_positive
- Tier: invariant
- Equation: $0<G$; proof: numerator $\pi r^4>0$, denominator positive, div_pos.

### E12: Arteriolar dilation
- Section: Tier 2 (ArteriolarDilationParams, dr_a_dt)
- Tier: 2
- Equation: $\frac{dr_a}{dt}=\frac{1}{\tau_a}\Big[r_{a0}\Big(1+\beta_{NsMJ}\frac{I_{NsMJ}}{I_0}+\beta_a\Phi_{root}+\beta_{astro}F_{A2B}+\beta_d\,\mathrm{coupling\_sum}\Big)-r_a\Big]$
- Symbols: tau_a>0, I_0>0; A_K declared but unused.
- Aleph 1: inherited NsMJ + Kir2.1 dual dilation (retrograde conduction).

### E13: Theorem arteriolar_basal_equilibrium
- Tier: invariant
- Equation: $\frac{dr_a}{dt}(r_{a0},0,0,0,0)=0$; proof zero_div, ring.

### E14-E17: Six-pool metabolism (four pools given)
- Section: Tier 3 (MetabolicPools)
- Tier: 3
- Equations: $\frac{dG}{dt}=J_G-v_{gn}-v_{ga}-v_{syn}$; $\frac{dL}{dt}=2(v_{ga}+v_{gly})+v_{ex}-J_L$; $\frac{d\Gamma}{dt}=v_{syn}-v_{gly}$; $\frac{dp}{dt}=2v_{gn}-v_{ox}-v_{ex}$
- Symbols: J_G,J_L transport fluxes; v_gn neuronal glycolysis, v_ga astrocytic glycolysis, v_syn glycogen synthesis, v_gly glycogenolysis, v_ox oxidation, v_ex pyruvate-lactate exchange (names inferred from subscripts; not defined in file).
- Aleph 1: Tier 3 six-pool substrate metabolism (o pool absent; a in E19).

### E18: Theorem carbon_mass_balance
- Tier: invariant
- Equation: $\frac{dG}{dt}+\frac{d\Gamma}{dt}+\frac{1}{2}\left(\frac{dL}{dt}+\frac{dp}{dt}\right)=J_G-\frac{J_L}{2}-\frac{v_{ox}}{2}$
- Derivation: unfold, ring.
- Aleph 1: Tier 3 carbon balance.

### E19: ATP balance with creatine kinase
- Section: Tier 3 (CKBufferParams, da_dt)
- Tier: 3
- Equation: $\frac{da}{dt}=2v_{gn}+27.5\,v_{ox}+k_{CK}\left(\mathrm{PCr}\cdot\mathrm{ADP}-\frac{\mathrm{Cr}\cdot\mathrm{ATP}}{K_{eq}}\right)-D$
- Symbols: k_CK,K_eq>0, D demand; 27.5 ATP per oxidized pyruvate unit (stoichiometry not explained).
- Aleph 1: Tier 3 CK/PCr buffer, ATP balance.

### E20: Theorem ck_equilibrium_preserves_atp_flux
- Tier: invariant
- Equation: $\mathrm{PCr}\cdot\mathrm{ADP}=\mathrm{Cr}\cdot\mathrm{ATP}/K_{eq}\Rightarrow \frac{da}{dt}=2v_{gn}+27.5v_{ox}-D$

### E21-E23: AIS tri-variable controller
- Section: Tier 4
- Tier: 4
- Equations: $\frac{dL}{dt}=\frac{1}{\tau_L}[-(L-L_0)-G_LL_0(\bar c-1)]$; $\frac{dx}{dt}=\frac{1}{\tau_x}[-(x-x_0)+G_x(\bar c-1)]$; $\frac{dg}{dt}=\frac{1}{\tau_g}[-(g-g_0)-G_gg_0(\bar c-1)]$
- Symbols: c_bar normalized activity; all taus, L_0,x_0,g_0>0. Note x term lacks x_0 multiplier and has + sign.
- Aleph 1: Tier 4 AIS controller.

### E24: AIS threshold law
- Tier: 4
- Equation: $\theta_{AIS}=-k_B\ln(L/L_0)-k_x\ln(x/x_0)-k_g\ln(g/g_0)$
- Aleph 1: Tier 4 threshold law.

### E25: Theorem ais_unique_fixed_point
- Tier: invariant
- Equation: at $\bar c=1$, all three derivatives zero $\Rightarrow L=L_0,x=x_0,g=g_0$; proof: 1/tau ≠ 0, mul_eq_zero, linarith.

### E26: Theorem theta_ais_zero_at_equilibrium
- Tier: invariant
- Equation: $\theta_{AIS}(L_0,x_0,g_0)=0$; proof: div_self, log 1 = 0.

### E27: Extracellular calcium depletion
- Section: Tier 5
- Tier: 5
- Equation: $\frac{dCa_e}{dt}=\frac{1}{\tau_{Ca}}\left[-I_{burst}+\frac{Ca_0-Ca_e}{\tau_{ref}}\right]$
- Aleph 1: Tier 5 PV block extracellular Ca2+ cutoff.

### E28: Theorem calcium_recovery_equilibrium
- Tier: invariant
- Equation: $I_{burst}=0,\ dCa_e/dt=0\Rightarrow Ca_e=Ca_0$

### E29-E30: Condensate capture SDE drift and diffusion
- Section: Tier 6
- Tier: 6
- Equation: $dc=\Big[\Omega\pi_a(1-c)+\beta_c\frac{c^2(1-c)}{K_c^2+c^2}-\gamma_cc\Big]dt+\sigma_c c(1-c)\,dW$ (file defines drift and diffusion separately; dW implied)
- Aleph 1: Tier 6 condensate capture SDE.

### E31: Theorem capture_diffusion_boundary_zero
- Tier: invariant
- Equation: $c\in\{0,1\}\Rightarrow\sigma_cc(1-c)=0$

### E32: Sigmoidal gate
- Tier: 6
- Equation: $S(x;\theta,s)=\frac{1}{1+\exp(-(x-\theta)/s)}$

### E33: Glymphatic velocity
- Tier: 6
- Equation: $v_{glymph}=v_0+v_1\mathbb{1}_{NREM}\frac{AQP4}{AQP4_0}\frac{A_{NE}}{A_{NE}+K_{NE}}\big(1-S(\overline{NE};\theta_g,s_g)\big)$
- Aleph 1: Tier 6 glymphatic peristalsis / noradrenergic pulsatility.

### E34: Theorem zolpidem_pulsatility_loss_collapses_glymphatic
- Tier: invariant
- Equation: $A_{NE}=0\Rightarrow v_{glymph}=v_0$ (interpreted as zolpidem abolishing NE pulsatility).
