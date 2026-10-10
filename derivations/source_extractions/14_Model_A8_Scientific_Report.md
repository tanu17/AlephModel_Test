# Extraction: Model_A8_Scientific_Report.pdf
- Model version(s) specified: Model A.8 (with lineage comparison to A.6 and A.7; mentions A.5 energetics arithmetic)
- One-paragraph summary of the file: 12-page LaTeX report "Unified Biophysical Dynamics, Cross-Species Benchmarking, and Formal Verification of Model A.8" (BrainComp Consortium, Oct 2026). Sec 1 lists six A.8 fixes over A.6/A.7 (linear volumetric NVC replacing quadratic F=kn^2, NsMJ fast pathway, six-pool metabolism + PCr buffer, tri-variable AIS controller, [Ca2+]e depletion truncating fast ripples, circadian tensor). Sec 2 gives Eqs (1)-(20) across six tiers. Sec 3 species parameter table and species-specific formula variants. Sec 4 lineage audit table A.6/A.7/A.8. Sec 5 28-benchmark scorecard (92.8%). Sec 6 six "emergent" derivations (verbal). Sec 7 external datasets. Sec 8 Lean 4 code proving sodium-ledger invariance, capture-SDE boundary behaviour, carbon mass balance. References [1]-[24].
- Parts that could not be read (if any): none; equations on pp.2-4 verified against PDF images.

### E1: Linear volumetric neurovascular coupling (replacing quadratic)
- Section in source: Sec 1 item 1; Sec 4; Table 2
- Tier: 2
- Equation: $F = k n^2 \;\rightarrow\; F = k' n / V_{\text{cortex}}$
- Symbols: F flow; n activity (neural); k, k' coupling constants; V_cortex cortical volume.
- Derivation: Quadratic law "unphysical", overestimated hyperemic flow at high frequencies (runaway at 8-16 Hz), "violated dimensional consistency"; linear form "dimensionally homogeneous".
- Cites: none
- Aleph 1: source term in Aleph Eq. 5.6 Kirchhoff balance
- Changes: A.6 and A.7 used F = kn^2; A.8 linear volumetric.

### E2: Somatic membrane potential
- Section: 2.1, Eq (1)
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{\text{rest}}) - g_K(a_i)(v_i - E_K) - g_{\text{adap}} w_i (v_i - E_K) + G_s\zeta(1-\nu_{\text{ACh}})\sum_j s_j W_{ij} x_{ij} r_j(t-\tau_{ij}) + G_s(1+\nu_{\text{ACh}}) I_i(t) + I_{\text{ax},i}$
- Symbols: v_i somatic potential; v_rest; g_K(a_i) ATP-dependent K conductance; E_K=-85 mV; g_adap, w_i adaptation; G_s gain; zeta; nu_ACh acetylcholine level; s_j sign; W_ij weight; x_ij release fraction [not defined in text]; r_j rate; tau_ij delay; I_i external input; I_ax,i axial current.
- Derivation: none given (bi-compartmental circuit described).
- Cites: none
- Aleph 1: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes: none stated

### E3: Axial + ephaptic current
- Section: 2.1, Eq (2)
- Tier: 1
- Equation: $I_{\text{ax},i} = g_{\text{ax}}[(v_{d,i}-v_i) + (V_e(x_{d,i}) - V_e(x_{s,i}))]$
- Symbols: g_ax axial conductance; v_{d,i} dendritic potential; V_e extracellular potential at dendrite x_{d,i} / soma x_{s,i}.
- Derivation: In uniform field V_e(x_d)=V_e(x_s), zero net polarization; non-uniform gradients polarize soma and dendrite oppositely, coupling coefficient 0.118 mV per V/m.
- Cites: Bikson et al. 2004 [2]
- Aleph 1: inherited Tier 1 dendritic potential coupling
- Changes: none stated

### E4: Metabolic K brake
- Section: 2.1 inline
- Tier: 1
- Equation: $g_K(a_i) = \bar g_K / [1 + (a_i/K_A)^{n_K}]$
- Symbols: \bar g_K max conductance; K_A ATP half-constant; n_K Hill coefficient.
- Derivation: hyperpolarizes membrane toward E_K=-85 mV under ATP depletion (a_i -> 0).
- Cites: none
- Aleph 1: K_ATP brake in Aleph Eq. 5.1
- Changes: none

### E5: Spike-frequency adaptation
- Section: 2.1 inline
- Tier: 1
- Equation: $\tau_w \dot w_i = -w_i + m_w r_i$
- Symbols: tau_w, m_w adaptation gain, r_i rate.
- Derivation: none given
- Aleph 1: inherited Tier 1 (Eq 5.1 adaptation term)
- Changes: none

### E6: Dendritic potential
- Section: 2.1, Eq (3)
- Tier: 1
- Equation: $C_d\frac{dv_{d,i}}{dt} = -g_{\text{leak}}(v_{d,i}-E_L) + \bar A_{\text{Ca}}\Delta(u_{d,i}) - g_{\text{HCN}}(\text{DA})(v_{d,i}-E_{\text{HCN}}) + \sum_{j\in\text{apical}} W_{ij}x_{ij}r_j(t-\tau_{ij}) - I_{\text{ax},i}$
- Symbols: C_d capacitance; g_leak, E_L; \bar A_Ca dCaAP amplitude (human 38 mV); u_{d,i} apical input; g_HCN, E_HCN.
- Derivation: tracks active calcium electrogenesis and dopamine-modulated shunting.
- Cites: Gidon 2020 [5]
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: none

### E7: dCaAP envelope
- Section: 2.1, Eq (4)
- Tier: 1
- Equation: $\Delta(u) = \mathcal{H}(u-u_{\text{th}})\cdot\exp\left(-\frac{u-u_{\text{th}}}{w_{\text{Ca}}}\right)$
- Symbols: H Heaviside; u_th threshold; w_Ca decay width.
- Derivation: non-monotonic, maximal at threshold, decreasing for suprathreshold inputs; physical basis for L2/3 dendritic XOR.
- Cites: Gidon 2020 [5]
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: none

### E8: Dopamine HCN shunting
- Section: 2.1 inline
- Tier: 1
- Equation: $g_{\text{HCN}}(\text{DA}) = \bar g_{\text{HCN}}\text{DA}^3/(K_D^3+\text{DA}^3)$
- Derivation: with E9 generates working-memory inverted-U.
- Cites: Arnsten 2011 [1]
- Aleph 1: inherited Tier 1 (dendritic)
- Changes: none

### E9: Non-preferred suppression
- Section: 2.1 inline
- Tier: 1
- Equation: $s_{\text{np}}(\text{DA}) = 1 - \sigma_1\text{DA}^2/(K_1^2+\text{DA}^2)$
- Derivation: as E8.
- Cites: [1]
- Aleph 1: inherited Tier 1
- Changes: none

### E10: Sodium debt ledger
- Section: 2.1, Eq (5)
- Tier: 1
- Equation: $\frac{dn_i}{dt} = \left[\nu_{\text{spk}}r_i + \nu_{\text{syn}}G_s\sum_j W_{ij}x_{ij}r_j + \lambda_n + \frac{I_{\text{ChR2,Na}}}{F\cdot\text{Vol}_i}\right]\left(1-\frac{n_i}{n_{\text{eq}}}\right) - \Pi_i$
- Symbols: n_i intracellular Na; nu_spk, nu_syn per-spike/per-synaptic loads; lambda_n leak; I_ChR2,Na optogenetic Na current; F Faraday; Vol_i volume; n_eq ≈ 12 mM.
- Derivation: driving-force factor (1 - n_i/n_eq) -> 0 as n_i -> n_eq, so [0, n_eq] strictly forward-invariant.
- Cites: none
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: none stated

### E11: Na/K pump
- Section: 2.1, Eq (6)
- Tier: 1
- Equation: $\Pi_i = \Pi_{\max}\left(\frac{a_i}{a_i+K_a}\right)\left(\frac{n_i}{n_i+K_n}\right)$
- Derivation: none given
- Aleph 1: inherited Tier 1 sodium ledger
- Changes: none

### E12: Hagen-Poiseuille conductance
- Section: 2.2 inline
- Tier: 2
- Equation: $G_e = \pi r_e^4/(8\eta_{\text{blood}}\ell_e)$
- Symbols: r_e radius, eta_blood viscosity, l_e length.
- Derivation: none (named law)
- Aleph 1: inherited Tier 2 Hagen-Poiseuille conductance
- Changes: none

### E13: Kirchhoff flow conservation
- Section: 2.2, Eq (7)
- Tier: 2
- Equation: $\sum_{e\ni c} G_e(p_c - p_{c'}) = c_a r_a^4(P_a - p_c)\cdot\mathbf{1}_{\{c\in\text{Art}\}} - G_v p_c\cdot\mathbf{1}_{\{c\in\text{Ven}\}} + \frac{k' n_c}{V_{\text{cortex}}}$
- Symbols: p_c node pressure; c_a arteriolar coefficient; r_a arteriole radius; P_a arterial pressure; G_v venous conductance; n_c local activity.
- Derivation: Kirchhoff flow conservation on 3D graph; last term is linear volumetric NVC (E1).
- Aleph 1: Aleph Eq. 5.6
- Changes: linear NVC term replaces quadratic (A.6/A.7).

### E14: Arteriole radius dual-pathway dynamics
- Section: 2.2, Eq (8)
- Tier: 2
- Equation: $\tau_a\frac{dr_a}{dt} = r_{a0}\left[1 + \beta_{\text{NsMJ}}\frac{I_{\text{NsMJ}}(t)}{I_0} + \beta_a\frac{\Phi_{\text{root}}(a)}{A_K} + \beta_{\text{astro}}\mathcal{F}_{A2B}(\text{Ado},\text{cAMP}) + \beta_d\sum_c\omega_{ac}\psi_c\right] - r_a$
- Symbols: I_NsMJ synaptic junction current, I_0 scale; Phi_root Kir2.1 retrograde signal (2 mm/s), A_K scale; F_A2B astrocytic adenosine-A2B function; omega_ac, psi_c capillary weights/signals.
- Derivation: NsMJ immediate inward currents on precapillary SMCs (<150 ms), then retrograde Kir2.1 hyperpolarization, then delayed astrocytic A2B. Mechanical compliance "governed by a damped reflected Ornstein-Uhlenbeck process" (no equation given).
- Cites: Zhang 2024 [24], Longden 2017 [16], Theparambil 2024 [22]
- Aleph 1: inherited Tier 2 NsMJ + Kir2.1 dual dilation
- Changes: A.6/A.7 lacked NsMJ (only Kir2.1 + astrocyte).

### E15: Glucose balance and transport
- Section: 2.3, Eq (9)
- Tier: 3
- Equation: $\frac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn},\quad J_G = T_G[1+\gamma_G(f-1)]\left[\frac{G_b}{G_b+K_T} - \frac{G}{G+K_T}\right]$
- Symbols: J_G transport; v_gn neuronal glycolysis, v_ga astrocytic glycolysis, v_syn glycogen synthesis; T_G; gamma_G = 0.5 flow recruitment; f flow; G_b blood glucose; K_T.
- Derivation: flow-dependent recruitment prevents glucose depletion.
- Aleph 1: Tier 3 six-pool metabolism
- Changes: none

### E16: Lactate and glycogen
- Section: 2.3, Eq (10)
- Tier: 3
- Equation: $\frac{dL}{dt} = 2(v_{ga}+v_{gly}) + v_{ex} - J_L,\quad \frac{d\Gamma}{dt} = v_{syn} - v_{gly}$
- Derivation: none
- Aleph 1: Tier 3 six-pool / lactate shuttle
- Changes: none

### E17: Pyruvate and oxygen
- Section: 2.3, Eq (11)
- Tier: 3
- Equation: $\frac{dp}{dt} = 2v_{gn} - v_{ox} - v_{ex},\quad c_O\frac{do}{dt} = J_O - 3v_{ox}$
- Derivation: none
- Aleph 1: Tier 3 six-pool
- Changes: none

### E18: Neuronal ATP with creatine kinase buffer
- Section: 2.3, Eq (12)
- Tier: 3
- Equation: $\frac{da_i}{dt} = 2v_{gn} + Y_{ox}v_{ox} + k_{CK}\left([\text{PCr}][\text{ADP}] - \frac{[\text{Cr}][\text{ATP}]}{K_{eq}}\right) - D_i$
- Symbols: Y_ox ATP yield; k_CK; K_eq; D_i demand.
- Derivation: CK equilibrium stabilizes steady-state [ATP] within ±1.2%.
- Aleph 1: Tier 3 CK/PCr buffer
- Changes: A.6/A.7 had no PCr (ATP drops 16%/15%).

### E19: Carbon conservation
- Section: 2.3 inline; Lean theorem carbon_mass_balance_closure (Sec 8)
- Tier: invariant (Tier 3)
- Equation: $\frac{d}{dt}[G+\Gamma+(L+p)/2] = J_G - J_L/2 - v_{ox}/2$
- Derivation: "Total carbon is conserved exactly"; Lean proof: sum dG_dt + dGamma_dt + (dL_dt + dp_dt)/2 using definitions of Eqs 9-11, closed by `ring`.
- Aleph 1: Tier 3 carbon balance
- Changes: none

### E20: AIS calcium proxy and length
- Section: 2.4, Eq (13)
- Tier: 4
- Equation: $\tau_c\frac{d\bar c_i}{dt} = -\bar c_i + c_i(t),\quad \tau_L\frac{dL_i}{dt} = -(L_i-L_0) - G_L L_0(\bar c_i - 1)$
- Derivation: leaky relaxation ensures unique homeostatic equilibrium.
- Cites: Jamann 2021 [12]
- Aleph 1: Tier 4 AIS controller
- Changes: A.6/A.7 leaky geometric law (rheobase shift -4.5% in A.7); A.8 tri-variable gives -24.2%.

### E21: AIS distance and Na channel density
- Section: 2.4, Eq (14)
- Tier: 4
- Equation: $\tau_x\frac{dx_i}{dt} = -(x_i-x_0) + G_x(\bar c_i-1),\quad \tau_g\frac{dg_{AIS,i}}{dt} = -(g_{AIS,i}-g_0) - G_g g_0(\bar c_i-1)$
- Derivation: as E20.
- Aleph 1: Tier 4
- Changes: as E20. Note x-equation gain G_x is not multiplied by x_0 (unlike L and g).

### E22: AIS threshold law
- Section: 2.4, Eq (15)
- Tier: 4
- Equation: $\theta_{AIS,i} = -k_B\ln\left(\frac{L_i}{L_0}\right) - k_x\ln\left(\frac{x_i}{x_0}\right) - k_g\ln\left(\frac{g_{AIS,i}}{g_0}\right)$
- Derivation: joint modulation captures sensory-deprivation rheobase changes.
- Cites: [12]
- Aleph 1: Tier 4 threshold law
- Changes: as E20

### E23: Interstitial calcium depletion
- Section: 2.5, Eq (16)
- Tier: 5
- Equation: $\tau_{Ca}\frac{d[\text{Ca}^{2+}]_e}{dt} = -I_{Ca,burst} + \frac{[\text{Ca}^{2+}]_{e,0} - [\text{Ca}^{2+}]_e}{\tau_{ref}}$
- Symbols: N_E=400 pyramidal, N_I=80 PV cells.
- Derivation: Ca depletion truncates fast-ripple (342 Hz, triggered by PV depolarization block + sprouting) bursts to 22.4 ms with 2.75 ms lags.
- Cites: Schlingloff 2025 [19], Stark 2014 [20]
- Aleph 1: Tier 5 PV block with extracellular Ca2+ cutoff
- Changes: A.6 channel-noise hypothesis; A.7 PV block + sprouting gave >90 ms bursts.

### E24: Synaptic headroom barrier
- Section: 2.6 inline
- Tier: 6
- Equation: $h_Q = D_{\text{cap}} - \sum D_k \ge 0$
- Derivation: none
- Aleph 1: Tier 6 synaptic headroom
- Changes: none

### E25: Weight plasticity
- Section: 2.6, Eq (17)
- Tier: 6
- Equation: $\tau_w\frac{dW_{ij}}{dt} = (1-b_m)\left[(s_Q+\psi(1-s_Q))\text{DA}^+f^+_{ij}(w_{\max}-W_{ij}) - (1+\text{DA}^-)f^-_{ij}W_{ij} - E_{ij}\right] - \gamma(1-P_{ij})W_{ij}$
- Symbols: b_m, s_Q, psi, f^±, E_ij, P_ij not defined in text.
- Derivation: "projected onto the local vascular metabolic headroom barrier".
- Aleph 1: Tier 6 synaptic headroom / plasticity
- Changes: none

### E26: Condensate capture SDE
- Section: 2.6, Eq (18); Lean capture theorems
- Tier: 6
- Equation: $\tau_c dc_{ij} = \left[\Omega_{ij}\pi(a_i)(1-c_{ij}) + \beta_c\frac{c_{ij}^2(1-c_{ij})}{K_c^2+c_{ij}^2} - \gamma_c c_{ij}\right]dt + \sigma_c c_{ij}(1-c_{ij})dB_{ij}$
- Derivation: forward-invariant on [0,1]; Lean proves diffusion vanishes at c=0 and c=1, drift ≥0 at 0 (given Omega, pi_a ≥ 0), drift <0 at 1 (since gamma_c>0). Sec 7: energy-gated Kramers escape over bistable condensates gives P(t) ∝ t^{-0.35}.
- Aleph 1: Tier 6 condensate capture SDE
- Changes: none (note tau_c reused for AIS calcium time constant).

### E27: Sleep downscaling relaxation
- Section: 2.6, Eq (19)
- Tier: 6
- Equation: $S_i(t) = S_{\text{set}} + (S_i(t_0)-S_{\text{set}})\exp\left(-k_{\text{down}}\int_{t_0}^t\Theta_{\text{circ}}(t')\cdot u(t')dt'\right)$
- Derivation: gated by adenosine, low NE, circadian tensor.
- Aleph 1: Tier 6 circadian sleep pruning tensor
- Changes: A.6 static product gate; A.7 thermodynamic exhaustion gate (drifted late-night); A.8 continuous relaxation + Theta_circ.

### E28: Sleep gate
- Section: 2.6 (unnumbered, between 19 and 20)
- Tier: 6
- Equation: $u(t) = \sigma\left(\frac{[\text{Ado}]-\theta_A}{s_A}\right)\left[1-\sigma\left(\frac{\text{NE}-\theta_N}{s_N}\right)\right]$
- Derivation: none
- Aleph 1: Tier 6 sleep pruning
- Changes: as E27

### E29: Circadian tensor
- Section: 2.6, Eq (20)
- Tier: 6
- Equation: $\Theta_{\text{circ}}(t) = \frac{1}{1+\exp\left(\frac{t-t_{\text{dawn}}}{\tau_{\text{circ}}}\right)}$
- Derivation: arrests downscaling before subjective dawn; Sec 6 item 4 says pre-dawn NE tone raises Kramers barrier ΔU_eff(t) by 45% via Θ_circ (no equation).
- Aleph 1: Tier 6 circadian sleep pruning tensor
- Changes: new in A.8

### E30: Drosophila tracheal glucose diffusion
- Section: 3 species formulations
- Tier: 3 (species variant)
- Equation: $J_G = D_{\text{trachea}}\nabla^2 G$
- Derivation: open tracheal hemolymph diffusion replaces vascular supply. Also Kenyon in-degree K=4 optimizing PR(K) (no formula).
- Aleph 1: species variant of Tier 3 J_G
- Changes: none

### E31: Pigeon membrane arbor scaling
- Section: 3; Sec 6 item 1
- Tier: other (species scaling, Tier 1 energetics)
- Equation: $A_{\text{membrane}} \propto k_{\text{syn}}^{2/3} = 0.313\times$ (rodent); Q_10 = 2.1 pump turnover 1.365×; net Na debt per spike 0.427× mammalian.
- Derivation: reduced arbor area lowers capacitive Na entry faster than Q10 thermal acceleration raises pump turnover.
- Aleph 1: none / ontogenetic-species scaling
- Changes: none

### E32: Human energetic baseline
- Section: 3; Table 2
- Tier: other
- Equation: 5.44×10^{-9} µmol/min/neuron ≈ 21.9 W
- Derivation: corrected Herculano-Houzel scaling.
- Cites: [10]
- Aleph 1: none
- Changes: A.6/A.7 used uncorrected A.5 arithmetic (13.4 W for 903 g brain).

### E33: Sodium ledger forward-invariance theorems (Lean)
- Section: 8
- Tier: invariant
- Equation: $\dot n|_{n=n_{eq}} \le 0$ and $\dot n|_{n=0} > 0$ for a,r,syn,I_ext ≥ 0, where Lean dn_dt = (nu_spk r + nu_syn G_s syn + lambda_n + I_ext)(1 - n/n_eq) - Pi_max·mm(a,K_a)·mm(n,K_n), mm(x,K)=x/(x+K).
- Derivation: upper: drive factor 1 - n_eq/n_eq = 0, pump ≥ 0 -> linarith. Lower: pump zero at n=0, drive ≥ lambda_n > 0.
- Aleph 1: invariant of inherited sodium ledger
- Changes: none

### E34: Power-law retention (emergent)
- Section: 7 item 6
- Tier: invariant
- Equation: $P(t) \propto t^{-0.35}$
- Derivation: energy-gated Kramers escape over bistable condensates c_ij (verbal only).
- Aleph 1: none
- Changes: none
