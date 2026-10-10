# Extraction: Model_A8_model only.docx
- Model version(s) specified: Model A.8 (lineage audit mentions A.1–A.5, A.6, A.7)
- One-paragraph summary of the file: "Biophysical and Thermodynamic Formalization of Model A.8". Specifies the A.8 six-tier equations: Tier 1 bi-compartment soma/dendrite (K_ATP brake, adaptation, ACh gating, ephaptic gradient, dCaAP, DA-HCN inverted-U), sodium debt ledger with saturation factor, firing-rate transfer; Tier 2 3D vascular graph (Poiseuille, Kirchhoff with linear NVC source F=k'n, dual-pathway dilation NsMJ + Kir2.1 + astrocyte A2B, pericyte relaxation); Tier 3 six-pool metabolism with GLUT1 flow recruitment, Buxton O2 extraction, PCr/CK buffer and carbon ledger; Tier 4 leaky tri-variable AIS controller; Tier 5 CA1 conductance spiking layer with extracellular Ca2+ depletion; Tier 6 headroom-barrier plasticity, condensate capture SDE, power-law forgetting, circadian-gated sleep downscaling, REM projection, glymphatic flow. Then species table (fly, zebrafish, rat, macaque, human, pigeon) with branch differences, and open failures.
- Parts that could not be read (if any): All text readable. ASCII diagrams partially garbled but legible. The introduction promises a validation scorecard, emergent inferences, and a Lean 4 verification, but these sections are NOT present in this file ("model only" version).

### E1: Somatic membrane potential
- Section in source: Tier 1 / Somatic Membrane Potential Dynamics
- Tier: 1
- Equation: \tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap} w_i (v_i - E_K) + G_s \zeta (1 - \nu_{ACh}) \sum_j s_j W_{ij} x_{ij} r_j(t - \tau_{ij}) + G_s (1 + \nu_{ACh}) I_i(t) + g_{ax} [(v_{d,i} - v_i) + (V_e(x_{d,i}) - V_e(x_{s,i}))]
- Symbols: v_rest typically -70 mV; E_K -85 mV; g_K(a) K_ATP conductance; g_adap, w_i adaptation; G_s baseline synaptic conductance; ζ global scaling; ν_ACh∈[0,1] ACh tone suppressing recurrent excitation; s_j∈{-1,+1} Dale sign; W_ij weight; x_ij∈[0,1] releasable fraction (Tsodyks-Markram); r_j presynaptic rate; τ_ij axonal delay; I_i feedforward input; g_ax axial conductance; V_e extracellular field at dendritic x_{d,i} and somatic x_{s,i} coordinates.
- Derivation/justification: term-by-term interpretation only. Leak drives to rest; K_ATP activates as a_i→0 hyperpolarizing toward E_K "to prevent excitotoxic demise"; ACh enhances feedforward gain over recurrent; ephaptic term zero in uniform field, gradients polarize soma/dendrite oppositely, coupling 0.118 mV per V/m.
- Cites: Bikson et al., 2004; Tsodyks-Markram; Dale's law.
- Aleph 1: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes mentioned: Diagram lists "Corrected Ephaptic Grad" and "Spike Adaptation g_adap" as A.8 features.

### E2: K_ATP conductance
- Section: Tier 1, somatic bullets
- Tier: 1
- Equation: g_K(a) = \bar{g}_K / [1 + (a / K_A)^{n_K}]
- Symbols: a intracellular ATP; K_A, n_K Hill constants; \bar g_K max conductance.
- Derivation: none given (conductance activates under depletion).
- Cites: none
- Aleph 1: Aleph Eq. 5.1 (K_ATP brake)
- Changes: none mentioned

### E3: Adaptation variable
- Section: Tier 1, somatic bullets
- Tier: 1
- Equation: \tau_w \frac{dw_i}{dt} = -w_i + m_w r_i
- Symbols: w_i adaptation variable; m_w gain; r_i firing rate. (Note τ_w symbol reused in E23 for weight time constant.)
- Derivation: mediated by slow Ca- or Na-activated K channels; stabilizes rates.
- Cites: none
- Aleph 1: inherited Tier 1 (Eq 5.1 adaptation term)
- Changes: none

### E4: Dendritic membrane potential
- Section: Tier 1 / Active Dendritic Membrane Potential Dynamics
- Tier: 1
- Equation: C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i} - E_L) + \bar{A}_{Ca} \Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i} - E_{HCN}) + \sum_{j \in apical} W_{ij} x_{ij} r_j(t - \tau_{ij}) - g_{ax}[(v_{d,i} - v_i) + (V_e(x_{d,i}) - V_e(x_{s,i}))]
- Symbols: C_d dendritic capacitance; u_{d,i} integrated apical drive; \bar A_Ca dCaAP amplitude (human 38 mV).
- Derivation: term interpretation; axial term mirrors E1 with opposite sign.
- Cites: Gidon et al., 2020
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: none

### E5: dCaAP activation function
- Section: Tier 1 dendritic
- Tier: 1
- Equation: \Delta(u) = \mathcal{H}(u - u_{th}) \cdot \exp\left(-\frac{u - u_{th}}{w_{Ca}}\right)
- Symbols: H Heaviside; u_th threshold; w_Ca width (human 12 mV).
- Derivation: waveform maximal at threshold and decreasing monotonically for larger inputs (Gidon 2020), basis for dendritic XOR.
- Cites: Gidon et al., 2020
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: none

### E6: Dopamine-HCN conductance and non-preferred suppression
- Section: Tier 1 dendritic; repeated in Macaque species branch
- Tier: 1
- Equation: g_{HCN}(DA) = \bar{g}_{HCN} DA^3 / (K_D^3 + DA^3); \quad s_{np}(DA) = 1 - \sigma_1 DA^2 / (K_1^2 + DA^2)
- Symbols: DA dopamine; K_D, K_1 half-activation; σ_1 suppression depth.
- Derivation: D1 → cAMP → HCN opening; dual mechanism gives inverted-U; macaque: d' = 0.94 working-memory selectivity.
- Cites: Arnsten, 2011
- Aleph 1: inherited Tier 1 dendritic potential (neuromodulation)
- Changes: none

### E7: Sodium debt ledger
- Section: Tier 1 / Sodium Debt Ledger
- Tier: 1
- Equation: \frac{dn_i}{dt} = [\nu_{spk} r_i + \nu_{syn} G_s \sum_j W_{ij} x_{ij} r_j + \lambda_n + \frac{I_{ChR2,Na}}{F \cdot Vol_i}](1 - \frac{n_i}{n_{eq}}) - \Pi_i
- Symbols: ν_spk Na per spike; ν_syn AMPA Na entry; λ_n resting leak; I_ChR2,Na optogenetic current; F Faraday; Vol_i volume; n_eq ≈ 12 mM.
- Derivation: saturation factor (1 - n/n_eq): driving force vanishes at electrochemical equilibrium, establishing forward invariance of [0, n_eq].
- Cites: none
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: In A.1–A.5 the factor was omitted, letting n_i diverge to +∞ under metabolic collapse.

### E8: Na/K pump rate
- Section: Tier 1 ledger
- Tier: 1
- Equation: \Pi_i = \Pi_{max} m(a_i, K_a) m(n_i, K_n), with m(a_i,K_a) = a_i/(a_i+K_a), m(n_i,K_n) = n_i/(n_i+K_n)
- Symbols: K_a ≈ 0.15 mM; K_n ≈ 10 mM; stoichiometry 1 ATP : 3 Na out : 2 K in.
- Derivation: dual Michaelis-Menten.
- Cites: none
- Aleph 1: inherited Tier 1 sodium ledger / Tier 3 ATP demand
- Changes: none ("Na+ Boundary Invariance" in diagram)

### E9: Firing-rate transfer function
- Section: Tier 1 / Firing Rate Transfer
- Tier: 1
- Equation: r_i = [1 + (n_i/n_c)^6]^{-1} h_K(k_c) \cdot \Phi( g(NE)(v_i - \theta_i - w_i - \theta_0 - \theta_{AIS,i}) )
- Symbols: n_c ≈ 4 mM fatigue threshold; h_K(k_c) extracellular K scaling; Φ sigmoid; g(NE) noradrenergic slope; θ_0 baseline threshold; θ_AIS from E31.
- Derivation: Na fatigue cut-off models depolarization block from loss of Na gradient.
- Cites: none
- Aleph 1: inherited Tier 1 firing-rate transfer function
- Changes: none

### E10: Fast homeostatic threshold
- Section: Tier 1 rate bullets
- Tier: 1
- Equation: \tau_\theta \frac{d\theta_i}{dt} = r_i - \rho_i \chi(a_i/a_0)
- Symbols: ρ_i set point; χ energy scaling of set point.
- Derivation: none beyond "maintaining firing near energy-scaled set point".
- Cites: none
- Aleph 1: inherited Tier 1 transfer function / Tier 4 interplay
- Changes: discussed in E31 (double-integrator conflict with AIS).

### E11: Hagen-Poiseuille conductance
- Section: Tier 2 / Vascular Graph Laplacian
- Tier: 2
- Equation: G_e(t) = \frac{\pi r_e(t)^4}{8 \eta_{blood}(r_e) \ell_e}
- Symbols: r_e radius; ℓ_e length; η_blood Fåhræus-Lindqvist viscosity.
- Derivation: none (law stated).
- Cites: Hagen-Poiseuille; Fåhræus-Lindqvist; Blinder 2013, Ji 2021 for graph.
- Aleph 1: inherited Tier 2 Hagen-Poiseuille conductance
- Changes: none

### E12: Kirchhoff interior node balance
- Section: Tier 2
- Tier: 2
- Equation: \sum_{e \ni c} G_e (p_c - p_{c'}) = 0
- Symbols: p_c nodal pressure.
- Derivation: conservation of fluid mass at non-root vertices.
- Cites: Kirchhoff's current law
- Aleph 1: Aleph Eq. 5.6 (Kirchhoff microvascular balance)
- Changes: none

### E13: Kirchhoff boundary conditions with NVC source
- Section: Tier 2
- Tier: 2
- Equation: \sum_{e \ni c} G_e (p_c - p_{c'}) = c_a r_a^4 (P_a - p_c)\mathbf{1}_{\{c\in Art\}} - G_v p_c \mathbf{1}_{\{c\in Ven\}} + \frac{k' n_c}{V_{cortex}}
- Symbols: P_a arterial pressure; G_v venous conductance; V_cortex tissue volume; k' n_c linear NVC source (F = k' n). Diagram writes it as Σ G_e(p_c - p_c') = k'·n / V_cortex.
- Derivation: weighted Laplacian L = D - A plus boundary conductances is symmetric positive definite on connected tree → unique pressures.
- Cites: none
- Aleph 1: Aleph Eq. 5.6
- Changes: "corrected linear neurovascular source term (F = k' n)"; diagram "Linear NVC: F = k'·n". (Note n_c here overloads the symbol n_c ≈ 4 mM from E9.)

### E14: Graph Laplacian (invariant)
- Section: Tier 2
- Tier: invariant
- Equation: \mathbf{L} = \mathbf{D} - \mathbf{A}
- Symbols: degree and adjacency (weighted).
- Derivation: SPD with boundary conductances → uniqueness.
- Cites: none
- Aleph 1: Aleph Eq. 5.6 well-posedness
- Changes: none

### E15: Dual-pathway arteriole dilation
- Section: Tier 2 / Dual-Pathway NVC
- Tier: 2
- Equation: \tau_a \frac{dr_a}{dt} = r_{a0}[1 + \beta_{NsMJ} \frac{I_{NsMJ}(t)}{I_0} + \beta_a \frac{\Phi_{root}(a)}{A_K} + \beta_{astro}\mathcal{F}_{A2B}(Ado, cAMP) + \beta_d \sum_c \omega_{ac}\psi_c] - r_a
- Symbols: I_NsMJ fast AMPA/NMDA VSMC current (latency <150 ms); Φ_root Kir2.1 signal at root; F_A2B astrocytic adenosine/cAMP metabolite; ψ_c pericyte state; ω_ac weights.
- Derivation: resolves conflict between rapid (<1.5 s) vessel response and slow astrocytic cascade by cooperative pathways.
- Cites: Zhang et al., 2024 (NsMJ); Longden 2017; Theparambil 2024.
- Aleph 1: inherited Tier 2 NsMJ + Kir2.1 dual dilation
- Changes: NsMJ and slow A2B astrocyte path are new A.8 features (diagram).

### E16: Kir2.1 retrograde conducted signal
- Section: Tier 2 Pathway 2a
- Tier: 2
- Equation: \Phi_m(t) = \Phi_{max}\tanh(\sum_n e^{-C_{nm}} \frac{s_n(t - d_{nm}/v_c)}{\Phi_{max}}); C_{nm} = \ell_e/\lambda_c (upstream), C_{nm} = \ell_e/\lambda_c + \ln b (lateral/downstream)
- Symbols: v_c ≈ 2 mm/s; b ≈ 2 bifurcation; λ_c length constant; d_nm path distance; s_n source.
- Derivation: ln b penalty models current division at bifurcations, preventing network-wide diffuse dilation.
- Cites: Longden et al., 2017
- Aleph 1: inherited Tier 2 Kir2.1 dilation
- Changes: none explicit ("Asymmetric Green's Kernel (ln b)").

### E17: Pericyte relaxation and capillary radius
- Section: Tier 2
- Tier: 2
- Equation: \tau_\psi \frac{d\psi_c}{dt} = -\psi_c + q_c; \quad r_e = r_0(1 + \beta_c \bar\psi_e); r_e \in [r_{min}, r_{max}] via reflected OU
- Symbols: q_c messenger drive; β_c = 0.07; r_0 (rat 2.2 μm).
- Derivation: reflected Ornstein-Uhlenbeck keeps radii in bounds (no formula given). Open-failure note: capillaries contribute only 4.2% of flow increase.
- Cites: Hill 2015 vs Hall 2014
- Aleph 1: inherited Tier 2 (dilation); related to Eq 5.9 capillary stall
- Changes: none

### E18: Glucose pool
- Section: Tier 3
- Tier: 3
- Equation: \frac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn}
- Aleph 1: inherited Tier 3 six-pool. Derivation none. Changes none.
- Symbols: per E24–E29.
- Cites: none

### E19: Lactate pool
- Section: Tier 3; Tier 3
- Equation: \frac{dL}{dt} = 2(v_{ga} + v_{gly}) + v_{ex} - J_L
- Symbols: J_L washout; v_ex LDH/MCT exchange. Derivation none. Aleph 1: Tier 3 six-pool / lactate shuttle. Changes none.

### E20: Glycogen pool
- Tier 3. Equation: \frac{d\Gamma}{dt} = v_{syn} - v_{gly}. Derivation none. Aleph 1: Tier 3 six-pool.

### E21: Pyruvate pool
- Tier 3. Equation: \frac{dp}{dt} = 2 v_{gn} - v_{ox} - v_{ex}. Derivation none. Aleph 1: Tier 3 six-pool.

### E22: Oxygen pool
- Tier 3. Equation: c_O \frac{do}{dt} = J_O - 3 v_{ox}. c_O capacity factor (undefined). Derivation none. Aleph 1: Tier 3 six-pool / OXPHOS.

### E23: ATP pool with CK buffer
- Section: Tier 3; Tier 3
- Equation: \frac{da_i}{dt} = 2 v_{gn} + Y_{ox} v_{ox} + k_{CK}([PCr][ADP] - \frac{[Cr][ATP]}{K_{eq}}) - D_i
- Symbols: Y_ox ≈ 27.5 ATP/pyruvate; k_CK, K_eq CK constants; D_i demand.
- Derivation: CK reaction [PCr]+[ADP]+H+ ⇌ [Cr]+[ATP] buffers ATP drops.
- Cites: Mangia et al., 2007 (31P-MRS)
- Aleph 1: inherited Tier 3 ATP balance + creatine-kinase/PCr buffer
- Changes: A.7 ATP dipped 10–16% on activation; A.8 PCr keeps ATP within ±1.2%.

### E24: GLUT1 glucose delivery
- Tier 3. Equation: J_G = T_G[1 + \gamma_G(f - 1)][\frac{G_b}{G_b+K_T} - \frac{G}{G+K_T}]
- Symbols: G_b blood glucose; T_G max transport; γ_G ≈ 0.5 flow recruitment; f = F/F_0.
- Derivation: without γ_G passive transport fails to match demand → unphysical depletion.
- Aleph 1: inherited Tier 3 / carbon balance. Changes: diagram "J_G Flow Dependent" as A.8 feature. Fly branch replaces with J_G = D_{trachea}\nabla^2 G (E40).

### E25: Oxygen delivery and Buxton extraction
- Tier 3. Equation: J_O = J_{O0} f \frac{E(f)}{E_0}\cdot\frac{o_a - o}{o_a - o_0}, \quad E(f) = 1 - (1-E_0)^{1/f}
- Symbols: f = F/F_0; E_0 baseline extraction; o_a arterial O2.
- Derivation: "formalizing Buxton's oxygen extraction fraction".
- Cites: Buxton (Leontiev & Buxton 2007 in refs)
- Aleph 1: inherited Tier 3 (O2 pool)

### E26: Pump-coupled neuronal glycolysis
- Tier 3. Equation: v_{gn} = V_{gn} m(G,K_G)\theta(a)[1 + \chi_g(D_{set}/D_0 - 1)]_+, \quad \theta(a) = (a_{max}-a)/(a_{max}-a+K_d)
- Symbols: χ_g ≈ 1.49; θ(a) ADP feedback.
- Derivation: χ_g couples glycolysis to pump demand, reproducing transient lactate rise at onset.
- Aleph 1: Tier 3 six-pool

### E27: Astrocytic glycolysis / ANLS
- Tier 3. Equation: v_{ga} = m(G,K_G)(V_{ga0} + \phi V_{glu} u)
- Symbols: u glutamate uptake; φ∈[0,1] (default 0.5, unidentifiable: φ 0→1 shifts lactate rise +21.5%→+26.2%, glucose/O2 increment ratio 1.95→2.14).
- Aleph 1: Tier 3 lactate shuttle

### E28: Glycogen synthesis
- Tier 3. Equation: v_{syn} = V_{syn} m(G,K_{Gs})(1 - \Gamma/\Gamma_{max}); v_gly given verbally only (accelerated by K+, NE, G<G_h). Rat: Γ_0 = 7.0 mM, c_h = 4, c_h2 = 40, 34 min aglycemic CAP (Wender 2000).
- Aleph 1: Tier 3 six-pool

### E29: OXPHOS
- Tier 3. Equation: v_{ox} = V_{ox} m(p,K_p) m(o,K_o)\theta(a). Y_ox ≈ 27.5. Aleph 1: Tier 3 OXPHOS (ROS coupling absent here).

### E30: Carbon ledger closure
- Section: Tier 3; Tier: invariant
- Equation: \frac{d}{dt}[G + \Gamma + \frac{L+p}{2}] = J_G - \frac{J_L}{2} - \frac{v_{ox}}{2}
- Derivation: "evaluating the time derivative of total tissue carbon" verifies mass conservation; numerical residual < 1.4×10^{-4}. No algebra shown.
- Aleph 1: inherited Tier 3 carbon balance

### E31: AIS calcium proxy
- Section: Tier 4; Tier 4
- Equation: \tau_c \frac{d\bar c_i}{dt} = -\bar c_i + c_i(t)
- Symbols: τ_c ≈ 1 h (calcineurin/CaMKII). (τ_c symbol reused in condensate SDE E35.)
- Aleph 1: Tier 4 AIS controller

### E32: AIS length, position, conductance
- Tier 4. Equations: \tau_L \frac{dL_i}{dt} = -(L_i-L_0) - G_L L_0(\bar c_i - 1); \tau_x \frac{dx_i}{dt} = -(x_i-x_0) + G_x(\bar c_i - 1); \tau_g \frac{dg_{AIS,i}}{dt} = -(g_{AIS,i}-g_0) - G_g g_0(\bar c_i - 1)
- Derivation: leak terms ensure unique fixed point (L_0,x_0,g_0 at c̄=1).
- Aleph 1: Tier 4 tri-variable leaky controller
- Changes: earlier pure-integral form plus θ_i homeostat formed competing double-integrators on one error → drifting equilibria; A.8 leaky form fixes.

### E33: AIS threshold law
- Tier 4. Equation: \theta_{AIS,i} = -k_B\ln(L_i/L_0) - k_x\ln(x_i/x_0) - k_g\ln(g_{AIS,i}/g_0)
- Derivation: resistive cable coupling; longer AIS or higher g lowers threshold; distal shift reduces excitability via input resistance. (Note: sign of k_x term as written gives θ_AIS<0 for x>x_0 if k_x>0, which appears to contradict the stated "reduce excitability" unless k_x<0; recorded as written.)
- Cites: Goethals & Brette, 2020
- Aleph 1: Tier 4 threshold law

### E34: CA1 conductance-based membrane
- Section: Tier 5; Tier 5
- Equation: \tau_m \frac{dV_k}{dt} = -(V_k-E_L) - g_{e,k}(t)(V_k-E_e) - g_{i,k}(t)(V_k-E_i) + \sigma_{ch}\sqrt{2\tau_m}\xi_k(t)
- Aleph 1: Tier 5 CA1 spiking layer. Derivation none.

### E35: Synaptic conductances
- Tier 5. Equation: \frac{dg_{e,k}}{dt} = -\frac{g_{e,k}}{\tau_{AMPA}} + \sum_j W^E_{kj}\delta(t - t_j^E - d); \frac{dg_{i,k}}{dt} = -\frac{g_{i,k}}{\tau_{GABA}} + \sum_m W^I_{km}\delta(t - t^I_m - d)
- Aleph 1: Tier 5.

### E36: Extracellular calcium depletion
- Tier 5. Equation: \tau_{Ca}\frac{d[Ca^{2+}]_e}{dt} = -I_{Ca,burst} + \frac{[Ca^{2+}]_{e,0} - [Ca^{2+}]_e}{\tau_{ref}}
- Derivation: bursting drives Ca_e 1.2 → <0.6 mM, lowering release probability, terminating bursts after 10–30 ms with 2.2–3.4 ms out-of-phase clusters. Results: 342 Hz, 22.4 ms, 2.75 ms. Normal ripples 150 Hz (PING, Stark 2014); fast ripples 340 Hz via PV depolarization block (Schlingloff 2025) + sprouting (Bragin 2000).
- Cites: Ibarz 2010
- Aleph 1: Tier 5 PV depolarization block with extracellular Ca2+ cutoff
- Changes: in A.7 fast-ripple bursts ran >90 ms as seizures.

### E37: Synaptic weight with headroom
- Section: Tier 6; Tier 6
- Equation: \tau_w \frac{dW_{ij}}{dt} = (1-b_m)[(s_Q + \psi(1-s_Q))DA^+ f^+_{ij}(w_{max}-W_{ij}) - (1+DA^-)f^-_{ij}W_{ij} - E_{ij}] - \gamma(1-P_{ij})W_{ij}, with P_{ij} = \max(\Omega_{ij}, c_{ij})
- Symbols: b_m learning brake; DA± RPE; E_ij eviction current; P_ij persistence; Ω_ij tag.
- Aleph 1: Tier 6 synaptic headroom / plasticity

### E38: Vascular metabolic headroom
- Tier 6 (invariant constraint). Equation: h_Q = D_{cap} - \sum_{k\in Q} D_k \ge 0. As h_Q→0, s_Q→0. Aleph 1: Tier 6 synaptic headroom.

### E39: Condensate capture SDE
- Tier 6. Equation: \tau_c\, dc_{ij} = [\Omega_{ij}\pi(a_i)(1-c_{ij}) + \beta_c\frac{c_{ij}^2(1-c_{ij})}{K_c^2+c_{ij}^2} - \gamma_c c_{ij}]dt + \sigma_c c_{ij}(1-c_{ij})dB_{ij}
- Derivation: drift and diffusion vanish at 0 and 1 → [0,1] forward-invariant (stated as "rigorously proving"; note drift at c=0 equals Ω π(a) which is nonzero if Ω>0 — recorded as stated). β_c symbol overloads pericyte β_c=0.07.
- Cites: Chen 2020, Frey & Morris 1997, Redondo & Morris 2011 (refs list)
- Aleph 1: Tier 6 condensate capture SDE

### E40: Power-law retention (invariant)
- Tier: invariant. Equation: P(t) \simeq \Gamma(1 + \frac{\sigma_c^2}{\mu})(\frac{t}{\tau_0})^{-\sigma_c^2/\mu}
- Derivation: Kramers escapes driven by multiplicative noise; barrier depth distribution p(ΔU) ∝ exp(-ΔU/μ) "analytically derives" power law (steps not shown).
- Cites: Wixted & Ebbesen 1991 (DOI in text differs from ref list).
- Aleph 1: Tier 6 condensate SDE consequence

### E41: Wake synapse accumulation
- Tier 6. Equation: Wake: \frac{dS_i}{dt} = g_w \mathcal{C}(t)(1 + \alpha A_r). Zebrafish: g_w C(t) → 0 under constant light.
- Aleph 1: Tier 6 circadian sleep pruning tensor

### E42: Sleep downscaling (exact gated relaxation)
- Tier 6. Equation: S_i(t) = S_{set} + (S_i(t_0) - S_{set})\exp(-k_{down}\int_{t_0}^t \Theta_{circ}(t')u(t')dt')
- Derivation: none (closed form of gated relaxation). Aleph 1: Tier 6 circadian pruning tensor. Changes: A.8 embeds pre-dawn Θ_circ arresting pruning in final 2 h, resolving per-organism slope discrepancy (Suppermpool 2024).

### E43: Sleep gate and circadian tensor
- Tier 6. Equation: u(t) = \sigma(\frac{[Ado]-\theta_A}{s_A})[1 - \sigma(\frac{NE-\theta_N}{s_N})], \quad \Theta_{circ}(t) = \frac{1}{1+\exp(\frac{t - t_{dawn}}{\tau_{circ}})}
- Zebrafish: 14:10 light-dark photoperiod tensor. Aleph 1: Tier 6 circadian tensor.

### E44: REM weight jump
- Tier 6. Equation: \Delta W = \lambda_Q\eta_R P(w_{max}-W) - \pi_R(1-P)\sigma(\frac{w_p - W}{s_w})W
- Aleph 1: Tier 6 (REM reorganization)

### E45: REM headroom projection scalar
- Tier 6. Equation: \lambda_Q = \min\{1, \frac{h_Q/\beta + \sum dec}{\sum inc}\}
- Derivation: scales potentiation so h_Q ≥ 0 across the jump. Aleph 1: Tier 6 headroom.

### E46: Glymphatic flow
- Tier 6. Equation: v_{glymph} = v_0 + v_1\mathbf{1}_{NREM}(\frac{AQP4}{AQP4_0})\frac{\mathcal{A}_{NE}}{\mathcal{A}_{NE}+K_{NE}}[1 - \sigma(\frac{\overline{NE}-\theta_g}{s_g})]
- Symbols: A_NE amplitude of 0.01–0.05 Hz NE oscillations.
- Cites: Hauglund et al., 2025
- Aleph 1: Tier 6 glymphatic peristalsis (and AQP4 polarity)

### E47: Fly avascular diffusion branch
- Section: Species / Drosophila; Tier 3 (other: species branch)
- Equation: J_G = D_{trachea}\nabla^2 G; Q_10 = 2.0 from T_b = 25 °C. Also optimal mushroom-body in-degree K = 4 maximizing PR(K) (Litwin-Kumar 2017); reciprocity 19.4× vs 19.7× FlyWire.
- Aleph 1: Tier 2/3 species branch (ontogenetic/species scaling)

### E48: Pigeon membrane capacitance scaling
- Section: Species / Columba livia; Tier: other (species branch, Tier 1 parameter)
- Equation: C_{membrane} \propto k_{syn}^{2/3}; Q_10 = 2.1 at 41.2 °C
- Derivation: geometric scaling with smaller arbor (k_syn 1,750 vs 10,000) reduces capacitive Na influx per spike; 3.40×10^-9 μmol/min per cell.
- Aleph 1: none directly (relates to ontogenetic scaling tensor)

### E49: Species parameter table / human energetic baseline
- Tier: other. Values: per-neuron glucose × N = whole-brain (e.g., human 5.44e-9 × 8.61e10 = 467.8 μmol/min ≈ 21.9 W, 1.4 kg). Gyrification: macaque 1.73 (delays 3–25 ms, median 10), human 2.56 (5–40 ms, median 18.5, 4–7 item slots).
- Changes: resolves "arithmetic flaw of Model A.5 and A.7" (Herculano-Houzel 2011).
