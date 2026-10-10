# Extraction: Model_A8_Scientific_Report.docx
- Model version(s) specified: Model A.8 (with lineage comparisons to A.6, A.7, and mentions of A.1-A.5)
- One-paragraph summary of the file: A formal technical report for Model A.8. It gives the governing equations in six tiers: (1) a two-compartment soma/dendrite neuron with a K_ATP brake, spike adaptation, ephaptic gradient, dCaAP, DA-dependent HCN, a sodium debt ledger and a firing-rate transfer function; (2) 3D vascular graph Poiseuille/Kirchhoff hemodynamics with a linear NVC source, plus dual-pathway arteriole dilation (NsMJ, Kir2.1 conducted Phi, astrocyte A2B) and pericyte capillary radius; (3) six-pool metabolism (G, L, Gamma, p, o, a) with GLUT1, Buxton O2 extraction, glycolysis, OXPHOS, CK/PCr and carbon-balance closure; (4) a tri-variable leaky AIS controller and threshold law; (5) a CA1 conductance spiking layer with extracellular Ca2+ depletion; (6) synaptic weight with headroom, a condensate capture SDE with a power-law retention curve, circadian-gated sleep downscaling, REM projection and glymphatic flow. It then lists species-specific branches (fly, zebrafish, rat, macaque, human, pigeon), an A.6->A.7->A.8 lineage, a validation scorecard, six "emergent inferences" (some with small derivations: pigeon capacitance scaling, Q10 pump, K_ATP, Kramers barrier, glymphatic), and Lean 4 proofs of four theorems: Na ledger invariance (upper and lower bounds), capture SDE boundary invariance, and carbon mass balance.
- Parts that could not be read (if any): None. ASCII diagram boxes were readable. The "Kirchhoff Node Balance: Σ G_e·(p_c - p_c') = k'·n / V_cortex" in the diagram duplicates E14. There is no Lean proof for theorem 3 of the header list (Kirchhoff positive-definiteness); the Lean file only states it in the header comment.

### E1: Somatic membrane potential
- Section in source: Tier 1 / Somatic Membrane Potential Dynamics
- Tier: 1
- Equation (LaTeX, transcribed faithfully): \tau_v \frac{dv_i}{dt} = -(v_i - v_{\text{rest}}) - g_K(a_i)(v_i - E_K) - g_{\text{adap}} w_i (v_i - E_K) + G_s \zeta (1 - \nu_{\text{ACh}}) \sum_j s_j W_{ij} x_{ij} r_j(t - \tau_{ij}) + G_s (1 + \nu_{\text{ACh}}) I_i(t) + g_{\text{ax}} \left[(v_{d,i} - v_i) + \left(V_e(x_{d,i}) - V_e(x_{s,i})\right)\right]
- Symbols: v_rest resting potential (typ. -70 mV); g_K(a_i) K_ATP conductance; E_K potassium reversal (-85 mV); g_adap, w_i adaptation; G_s baseline synaptic conductance; ζ global scaling coefficient; ν_ACh ∈ [0,1] cholinergic tone (suppresses recurrent excitation); s_j ∈ {-1,+1} Dale sign; W_ij weight; x_ij ∈ [0,1] readily releasable fraction (Tsodyks-Markram); r_j presynaptic rate; τ_ij axonal delay; I_i(t) feedforward input; g_ax axial conductance; v_{d,i} dendritic potential; V_e extracellular field at dendritic x_{d,i} / somatic x_{s,i} coordinates.
- Derivation or justification: Term-by-term interpretation only. Leak drives to rest. K_ATP is a metabolic brake that activates as a_i -> 0 and hyperpolarizes toward E_K "to prevent excitotoxic demise". ACh suppresses recurrent input and enhances feedforward gain ("cue detection"). In the ephaptic term, a uniform field gives V_e(x_d) = V_e(x_s), so there is no net polarization; field gradients polarize soma and dendrite oppositely, with coupling 0.118 mV per V/m.
- Physical law / literature: Bikson et al. 2004 (ephaptic coupling coefficient); Tsodyks-Markram STD; Dale's law.
- Corresponding Aleph 1 equation: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes vs earlier versions: The diagram lists "Corrected Ephaptic Grad" and "Spike Adaptation g_adap" as Tier 1 A.8 features.

### E2: K_ATP conductance law
- Section: Tier 1 (inline). It is repeated in Emergent Inference 2.
- Tier: 1
- Equation: g_K(a) = \bar{g}_K / [1 + (a / K_A)^{n_K}]   (Inference 2 form: g_K(a_i) = \frac{\bar{g}_K}{1 + (a_i / K_A)^{n_K}})
- Symbols: \bar g_K maximal conductance; a intracellular ATP; K_A half-activation; n_K Hill exponent.
- Derivation: Stated. Under depletion (a -> 0) the conductance activates. In Inference 2, as a_i declines toward 1.2 mM, K_ATP hyperpolarizes toward -85 mV and clamps penumbral firing from 4.2 Hz to <0.5 Hz.
- Literature: none specific.
- Aleph: part of Aleph Eq. 5.1
- Changes: none mentioned.

### E3: Spike-frequency adaptation variable
- Section: Tier 1 (inline)
- Tier: 1
- Equation: \tau_w \frac{dw_i}{dt} = -w_i + m_w r_i
- Symbols: w_i adaptation variable; m_w increment gain; r_i firing rate; τ_w time constant. Interpreted as slow Ca- or Na-activated K channels.
- Derivation: none given ("stabilizing firing rates during prolonged stimulation").
- Literature: none
- Aleph: inherited Tier 1 (adaptation term in somatic potential / firing-rate law)
- Changes: Listed as an A.8 Tier 1 feature in the diagram. Note that τ_w is reused later for the synaptic weight equation (E36).

### E4: Active dendritic membrane potential
- Section: Tier 1 / Active Dendritic Membrane Potential Dynamics
- Tier: 1
- Equation: C_d \frac{dv_{d,i}}{dt} = -g_{\text{leak}} (v_{d,i} - E_L) + \bar{A}_{\text{Ca}} \Delta(u_{d,i}) - g_{\text{HCN}}(\text{DA}) (v_{d,i} - E_{\text{HCN}}) + \sum_{j \in \text{apical}} W_{ij} x_{ij} r_j(t - \tau_{ij}) - g_{\text{ax}} \left[(v_{d,i} - v_i) + \left(V_e(x_{d,i}) - V_e(x_{s,i})\right)\right]
- Symbols: C_d dendritic capacitance; g_leak, E_L leak; \bar A_Ca dCaAP amplitude (human 38 mV); u_{d,i} integrated apical synaptic drive; g_HCN(DA), E_HCN HCN current; the axial/ephaptic term is the mirror of E1.
- Derivation: Interpretation only. The HCN current shunts dendritic input. The axial term is equal and opposite to the somatic one.
- Literature: Gidon et al. 2020; Arnsten 2011.
- Aleph: inherited Tier 1 dendritic potential
- Changes: none stated.

### E5: dCaAP activation function
- Section: Tier 1
- Tier: 1
- Equation: \Delta(u) = \mathcal{H}(u - u_{\text{th}}) \cdot \exp\left(-\frac{u - u_{\text{th}}}{w_{\text{Ca}}}\right)
- Symbols: \mathcal H Heaviside step; u_th activation threshold; w_Ca characteristic width (human 12 mV).
- Derivation: Justified empirically. The waveform is maximal at threshold and decreases monotonically for larger inputs (Gidon 2020, human L2/3), which is the physical basis for dendritic XOR.
- Literature: Gidon et al. 2020
- Aleph: inherited Tier 1 dendritic potential
- Changes: none

### E6: Dopamine-dependent HCN conductance
- Section: Tier 1 (inline). It is repeated in the macaque branch.
- Tier: 1
- Equation: g_{\text{HCN}}(\text{DA}) = \bar{g}_{\text{HCN}} \text{DA}^3 / (K_D^3 + \text{DA}^3)
- Symbols: DA dopamine; K_D half-saturation; Hill exponent 3.
- Derivation: D1 receptors elevate cAMP, which opens HCN channels.
- Literature: Arnsten 2011
- Aleph: inherited Tier 1 (dendritic modulation)
- Changes: none

### E7: Dopamine suppression of non-preferred inputs
- Section: Tier 1 (inline); macaque branch
- Tier: 1
- Equation: s_{\text{np}}(\text{DA}) = 1 - \sigma_1 \text{DA}^2 / (K_1^2 + \text{DA}^2)
- Symbols: σ_1 maximal suppression; K_1 half-saturation.
- Derivation: Combined with E6, this "dual mechanism generates the classic inverted-U tuning curve". In the macaque it gives delay-period stability with d' = 0.94.
- Literature: Arnsten 2011
- Aleph: inherited Tier 1
- Changes: none

### E8: Intracellular sodium debt ledger
- Section: Tier 1 / Sodium Debt Ledger and Boundary-Invariant Pumping
- Tier: 1
- Equation: \frac{dn_i}{dt} = \left[ \nu_{\text{spk}} r_i + \nu_{\text{syn}} G_s \sum_j W_{ij} x_{ij} r_j + \lambda_n + \frac{I_{\text{ChR2,Na}}}{F \cdot \text{Vol}_i} \right] \left(1 - \frac{n_i}{n_{\text{eq}}}\right) - \Pi_i
- Symbols: ν_spk Na per spike; ν_syn AMPA Na entry; λ_n resting leak; I_ChR2,Na optogenetic current; F Faraday; Vol_i intracellular volume; n_eq ≈ 12 mM electrochemical equilibrium.
- Derivation: The factor (1 - n_i/n_eq) is a "thermodynamic driving-force saturation factor". In A.1-A.5 it was omitted, so n_i diverged to +∞ when a_i -> 0. As n_i -> n_eq the driving force vanishes, which gives forward-invariance of [0, n_eq]. This is formally proved in Lean (E59, E60).
- Literature: none
- Aleph: inherited Tier 1 sodium debt ledger
- Changes: The saturation factor is absent in A.1-A.5. The lineage box says A.7 introduced the "Forward-Invariant Sodium Bound (dn/dt * (1 - n/n_eq))".

### E9: Na+/K+ ATPase pump rate
- Section: Tier 1
- Tier: 1
- Equation: \Pi_i = \Pi_{\text{max}} m(a_i, K_a) m(n_i, K_n)
- Symbols: Π_max maximal rate. The pump hydrolyzes 1 ATP for 3 Na+ out and 2 K+ in.
- Derivation: "dual Michaelis-Menten kinetics" (see E10)
- Literature: none
- Aleph: inherited Tier 1 sodium ledger
- Changes: none

### E10: Michaelis-Menten operators (pump)
- Section: Tier 1 (inline)
- Tier: 1
- Equation: m(a_i, K_a) = a_i / (a_i + K_a); \quad m(n_i, K_n) = n_i / (n_i + K_n)
- Symbols: K_a ≈ 0.15 mM; K_n ≈ 10 mM. The general operator is also used in Tier 3, and the Lean code defines mm x K = x/(x+K).
- Derivation: none given (Michaelis-Menten)
- Aleph: inherited
- Changes: none

### E11: Firing-rate transfer function
- Section: Tier 1 / Neuronal Firing Rate Transfer Function
- Tier: 1
- Equation: r_i = \left[1 + \left(\frac{n_i}{n_c}\right)^6\right]^{-1} h_K(k_c) \cdot \Phi\left( g(\text{NE}) \left( v_i - \theta_i - w_i - \theta_0 - \theta_{\text{AIS},i} \right) \right)
- Symbols: n_c ≈ 4 mM critical sodium; h_K(k_c) extracellular K scaling (functional form not given); Φ sigmoid; g(NE) noradrenergic gain; θ_i fast homeostatic threshold; θ_0 baseline threshold; θ_AIS,i AIS shift.
- Derivation: Interpretive. Above n_c there is depolarization block / spike failure from loss of the Na reversal gradient.
- Aleph: inherited Tier 1 firing-rate transfer function
- Changes: none. Note that n_c ≈ 4 mM < n_eq ≈ 12 mM, and that w_i appears both as a conductance-weighted current in E1 and subtracted directly here.

### E12: Fast homeostatic threshold
- Section: Tier 1 (inline)
- Tier: 1
- Equation: \tau_\theta \frac{d\theta_i}{dt} = r_i - \rho_i \chi(a_i/a_0)
- Symbols: ρ_i set point; χ energy scaling (form not given); a_0 reference ATP.
- Derivation: none given ("maintaining firing near an energy-scaled set point")
- Aleph: inherited Tier 1 / Tier 4 interface
- Changes: none

### E13: Hagen-Poiseuille conductance
- Section: Tier 2 / Vascular Graph Laplacian
- Tier: 2
- Equation: G_e(t) = \frac{\pi r_e(t)^4}{8 \eta_{\text{blood}}(r_e) \ell_e}   (the diagram gives G_e = π·r_e^4 / (8·η·ℓ_e))
- Symbols: r_e lumen radius; ℓ_e length; η_blood(r_e) effective viscosity (Fåhræus-Lindqvist).
- Derivation: cites Hagen-Poiseuille. No derivation.
- Aleph: inherited Tier 2 Hagen-Poiseuille conductance
- Changes: none

### E14: Kirchhoff node balance (interior)
- Section: Tier 2
- Tier: 2
- Equation: \sum_{e \ni c} G_e (p_c - p_{c'}) = 0
- Derivation: "Conservation of fluid mass at every non-root capillary vertex requires Kirchhoff's current law." Inference 3 reuses it (Kirchhoff steal, which gives a negative BOLD surround of 8-14%).
- Aleph: Aleph Eq. 5.6 (Kirchhoff microvascular balance)
- Changes: none

### E15: Kirchhoff balance with boundary conditions and linear NVC source
- Section: Tier 2
- Tier: 2
- Equation: \sum_{e \ni c} G_e (p_c - p_{c'}) = c_a r_a^4 (P_a - p_c) \cdot \mathbf{1}_{\{c \in \text{Art}\}} - G_v p_c \cdot \mathbf{1}_{\{c \in \text{Ven}\}} + \frac{k' n_c}{V_{\text{cortex}}}
- Symbols: P_a systemic arterial pressure; c_a r_a^4 arteriolar inlet conductance; G_v venous drainage conductance; V_cortex tissue volume; k'n_c linear NVC source (F = k'n). Note that n_c here is presumably sodium/activity at node c, and the same symbol is used for the critical sodium in E11.
- Derivation: Uniqueness is argued as follows: "Because the weighted graph Laplacian L = D − A plus boundary conductances is symmetric positive definite across the connected vascular tree, nodal pressures p_c are guaranteed to have unique physical solutions."
- Aleph: Aleph Eq. 5.6
- Changes: A.6/A.7 used quadratic NVC, F = k n^2 ("massive hyperemic overestimation at 8-16 Hz"). A.8 uses the linear F = k' n / V_cortex ("dimensionally consistent"). A.7's audit identified dimensional errors.

### E16: Graph Laplacian
- Section: Tier 2 (inline)
- Tier: 2
- Equation: \mathbf{L} = \mathbf{D} - \mathbf{A}
- Derivation: Asserted to be SPD together with the boundary conductances. Listed as Lean theorem 3 in the header, but no proof is given.
- Aleph: Eq. 5.6 support
- Changes: none

### E17: Dual-pathway arteriole radius dynamics
- Section: Tier 2 / Dual-Pathway Neurovascular Dilation Dynamics
- Tier: 2
- Equation: \tau_a \frac{dr_a}{dt} = r_{a0} \left[ 1 + \underbrace{\beta_{\text{NsMJ}} \cdot \frac{I_{\text{NsMJ}}(t)}{I_0}}_{\text{Pathway 1: Direct Synaptic (Fast)}} + \underbrace{\beta_a \frac{\Phi_{\text{root}}(a)}{A_K}}_{\text{Pathway 2a: Endothelial Kir2.1}} + \underbrace{\beta_{\text{astro}} \mathcal{F}_{\text{A2B}}(\text{Ado}, \text{cAMP})}_{\text{Pathway 2b: Astrocyte Cascade (Slow)}} + \beta_d \sum_c \omega_{ac} \psi_c \right] - r_a
- Symbols: I_NsMJ fast AMPA/NMDA current into VSMCs (latency <150 ms); I_0 normalization; Φ_root conducted hyperpolarization at the root; A_K scale; \mathcal F_A2B astrocytic adenosine/A2B/cAMP metabolite secretion (form not given); ω_ac weights; ψ_c pericyte state.
- Derivation: Resolves the conflict between a fast (<1.5 s) vessel response and slow astrocytic cascades. Pathways are justified by literature only.
- Literature: Zhang et al. 2024 (NsMJ); Longden et al. 2017 (Kir2.1); Theparambil et al. 2024 (A2B).
- Aleph: inherited Tier 2 NsMJ + Kir2.1 dual dilation
- Changes: A.6/A.7 had Kir2.1 plus diffuse astrocyte only. A.8 adds the NsMJ, which reduced latency from 1.8 s to 1.29 s. Inference 5 states that NsMJ vesicle depletion (x_ij 0.8 -> 0.15 at 8-16 Hz) shifts control to A2B and produces the n-ratio decoupling.

### E18: Retrograde Kir2.1 conducted signal
- Section: Tier 2, Pathway 2a
- Tier: 2
- Equation: \Phi_m(t) = \Phi_{\text{max}} \tanh\left( \sum_n e^{-C_{nm}} \frac{s_n(t - d_{nm}/v_c)}{\Phi_{\text{max}}} \right)
- Symbols: s_n source at node n (K+-driven); d_nm path distance; v_c ≈ 2 mm/s propagation speed; Φ_max saturation.
- Derivation: Neural activity elevates perivascular k_c, and Kir2.1 triggers hyperpolarization that propagates upstream.
- Literature: Longden et al. 2017
- Aleph: inherited Tier 2 dual dilation
- Changes: none

### E19: Path cost with bifurcation penalty
- Section: Tier 2
- Tier: 2
- Equation: C_{nm} = \ell_e / \lambda_c (upstream); \quad C_{nm} = \ell_e / \lambda_c + \ln b (lateral/downstream)
- Symbols: λ_c length constant; b ≈ 2.
- Derivation: ln b "models current division at vascular bifurcations, preventing non-physiological diffuse dilation". The diagram calls it an "Asymmetric Green's Kernel (ln b)".
- Aleph: inherited Tier 2
- Changes: none

### E20: Pericyte relaxation state
- Section: Tier 2 (inline)
- Tier: 2
- Equation: \tau_\psi \frac{d\psi_c}{dt} = -\psi_c + q_c
- Symbols: q_c neuro-glial messenger drive.
- Derivation: none given
- Aleph: inherited Tier 2 (capillary/pericyte)
- Changes: none

### E21: Capillary radius
- Section: Tier 2 (inline)
- Tier: 2
- Equation: r_e = r_0 (1 + \beta_c \bar{\psi}_e), with r_e \in [r_{\text{min}}, r_{\text{max}}] enforced by a reflected Ornstein-Uhlenbeck process
- Symbols: r_0 (rat 2.2 µm); β_c = 0.07 (from the partial-results section, where capillaries give 4.2% of the flow increase).
- Derivation: none (no ROU equation is written)
- Aleph: inherited Tier 2
- Changes: A.6 static radii; A.7 ROU; A.8 "Damped ROU with mechanical vessel inertia" (no equation)

### E22-E27: Six-pool metabolism
- Section: Tier 3 / Dynamic Substrate Pool Formulations
- Tier: 3
- E22 glucose: \frac{dG}{dt} = J_G - v_{\text{gn}} - v_{\text{ga}} - v_{\text{syn}}
- E23 lactate: \frac{dL}{dt} = 2(v_{\text{ga}} + v_{\text{gly}}) + v_{\text{ex}} - J_L
- E24 glycogen: \frac{d\Gamma}{dt} = v_{\text{syn}} - v_{\text{gly}}
- E25 pyruvate: \frac{dp}{dt} = 2 v_{\text{gn}} - v_{\text{ox}} - v_{\text{ex}}
- E26 oxygen: c_O \frac{do}{dt} = J_O - 3 v_{\text{ox}}
- E27 ATP: \frac{da_i}{dt} = 2 v_{\text{gn}} + Y_{\text{ox}} v_{\text{ox}} + k_{\text{CK}} \left( [\text{PCr}] [\text{ADP}] - \frac{[\text{Cr}] [\text{ATP}]}{K_{\text{eq}}} \right) - D_i
- Symbols: J_G GLUT1 influx; J_L lactate washout (form not given); v_gn/v_ga neuronal/astrocytic glycolysis; v_syn/v_gly glycogen synthesis/breakdown; v_ex LDH/MCT exchange; v_ox OXPHOS; c_O O2 capacity; Y_ox ≈ 27.5 ATP per pyruvate; k_CK creatine kinase rate; K_eq CK equilibrium; D_i demand (pump).
- Derivation: Stoichiometric coefficients (2 per glucose, 3 O2 per pyruvate) are stated without derivation. The CK reaction is [PCr]+[ADP]+H+ ⇌ [Cr]+[ATP].
- Literature: Mangia et al. 2007 (31P-MRS; ATP flat within ±1.2%)
- Aleph: inherited Tier 3 six-pool metabolism / CK-PCr buffer
- Changes: A.6/A.7 had no PCr, and ATP dipped 10-16% (lineage table: -14.8% -> -1.1%). A.8 adds CK. A.7 omitted the consumption sink. A.8 adds a reaction-diffusion sink -γ_k C_k (diagram: "Sink Term: -γ·C"), but no full PDE is written.

### E28: GLUT1 glucose delivery
- Section: Tier 3
- Tier: 3
- Equation: J_G = T_G [1 + \gamma_G (f - 1)] \left[ \frac{G_b}{G_b + K_T} - \frac{G}{G + K_T} \right]
- Symbols: G_b blood glucose; T_G max transport; K_T affinity; γ_G ≈ 0.5 flow-dependent capillary recruitment; f normalized flow.
- Derivation: "Without γ_G, passive transport fails to match glucose demand during activation."
- Aleph: inherited Tier 3
- Changes: The diagram lists "J_G Flow Dependent" as an A.8 feature.

### E29: Fly avascular glucose diffusion branch
- Section: Species / Drosophila
- Tier: 3 (species branch)
- Equation: J_G = D_{\text{trachea}} \nabla^2 G
- Derivation: Tiers 2-3 bypass the capillary graph, and exchange happens through tracheal hemolymph diffusion.
- Aleph: none (species branch)

### E30: Oxygen delivery / Buxton extraction
- Section: Tier 3
- Tier: 3
- Equation: J_O = J_{O0} f \frac{E(f)}{E_0} \cdot \frac{o_a - o}{o_a - o_0}, \quad E(f) = 1 - (1 - E_0)^{1/f}
- Symbols: f = F/F_0; E_0 baseline extraction; o_a arterial O2; o_0 baseline tissue O2.
- Derivation: cites "Buxton's oxygen extraction fraction". No derivation.
- Aleph: inherited Tier 3 (O2 delivery)
- Changes: none

### E31: Normalized flow
- Equation: f = F / F_0 (inline). Tier 2/3.

### E32: Pump-coupled neuronal glycolysis
- Section: Tier 3
- Tier: 3
- Equation: v_{\text{gn}} = V_{\text{gn}} m(G, K_G) \theta(a) [1 + \chi_g (D_{\text{set}} / D_0 - 1)]_+
- Symbols: χ_g ≈ 1.49; D_set/D_0 pump demand ratio.
- Derivation: Couples glycolysis to pump demand, which reproduces the transient lactate rise.
- Aleph: inherited Tier 3

### E33: ADP energetic feedback
- Equation: \theta(a) = (a_{\text{max}} - a) / (a_{\text{max}} - a + K_d). Tier 3. "energetic feedback from accumulating ADP". The symbol θ is also used for thresholds.

### E34: Astrocytic glycolysis (ANLS)
- Equation: v_{\text{ga}} = m(G, K_G) (V_{\text{ga0}} + \phi V_{\text{glu}} u). Tier 3. u is glutamate uptake. φ ∈ [0,1] is the lactate-shuttle share (default 0.5). φ is unidentifiable from bulk data: sweeping it from 0 to 1 moves the lactate rise from +21.5% to +26.2% and the glucose:O2 ratio from 1.95 to 2.14.

### E35: Glycogen synthesis
- Equation: v_{\text{syn}} = V_{\text{syn}} m(G, K_{\text{Gs}}) (1 - \Gamma / \Gamma_{\text{max}}). Tier 3. v_gly is not given explicitly; it is accelerated by K+, NE and G < G_h. Rat values: Γ_0 = 7.0 mM, c_h = 4, c_h2 = 40.

### E36: OXPHOS rate
- Equation: v_{\text{ox}} = V_{\text{ox}} m(p, K_p) m(o, K_o) \theta(a). Tier 3. Y_ox ≈ 27.5 ATP. Inherited Tier 3 OXPHOS.

### E37: Carbon mass balance closure
- Section: Tier 3 / Conserved Metabolic Ledger Closure
- Tier: invariant (Tier 3)
- Equation: \frac{d}{dt} \left[ G + \Gamma + \frac{L + p}{2} \right] = J_G - \frac{J_L}{2} - \frac{v_{\text{ox}}}{2}
- Derivation: "Evaluating the time derivative of total tissue carbon" over E22-E25. Numerical residual < 1.4e-4. Lean theorem carbon_mass_balance_closure proves it by `ring` from the definitions dG_dt, dL_dt, dGamma_dt, dp_dt.
- Aleph: inherited Tier 3 carbon balance

### E38: Slow calcium proxy
- Section: Tier 4
- Tier: 4
- Equation: \tau_c \frac{d\bar{c}_i}{dt} = -\bar{c}_i + c_i(t)
- Symbols: τ_c ≈ 1 h; calcineurin/CaMKII. τ_c is reused in E43 for the condensate.
- Aleph: Tier 4 AIS controller

### E39: AIS length and position
- Equation: \tau_L \frac{dL_i}{dt} = -(L_i - L_0) - G_L L_0 (\bar{c}_i - 1), \quad \tau_x \frac{dx_i}{dt} = -(x_i - x_0) + G_x (\bar{c}_i - 1)
- Tier: 4
- Derivation: The leaky relaxation terms avoid competing double integrators with θ_i, which caused drifting equilibria in earlier pure-integral versions. They give a unique fixed point L=L_0, x=x_0, g=g_0 when \bar c = 1.

### E40: AIS Na-channel density
- Equation: \tau_g \frac{dg_{\text{AIS},i}}{dt} = -(g_{\text{AIS},i} - g_0) - G_g g_0 (\bar{c}_i - 1)
- Tier: 4
- Changes: A.6/A.7 had only (L, x). A.8 adds g_AIS ("tri-variable"), which resolves the Jamann deprivation result (-4.5% -> -24.2%).

### E41: AIS threshold law
- Equation: \theta_{\text{AIS},i} = -k_B \ln\left(\frac{L_i}{L_0}\right) - k_x \ln\left(\frac{x_i}{x_0}\right) - k_g \ln\left(\frac{g_{\text{AIS},i}}{g_0}\right)
- Tier: 4
- Derivation: Resistive cable coupling (Goethals & Brette 2020). Longer AIS or more density lowers threshold. The text says distal relocation "acts through input resistance shifts to reduce excitability", yet the -k_x ln(x/x_0) term with positive k_x would lower the threshold for x > x_0. This sign is ambiguous; k_x's sign is not given.

### E42: CA1 conductance-based membrane
- Section: Tier 5
- Tier: 5
- Equation: \tau_m \frac{dV_k}{dt} = -(V_k - E_L) - g_{e,k}(t) (V_k - E_e) - g_{i,k}(t) (V_k - E_i) + \sigma_{\text{ch}} \sqrt{2\tau_m} \xi_k(t)
- Symbols: ξ_k white noise; σ_ch channel noise.
- Derivation: none (N_E pyramidal, N_I PV basket)

### E43: Synaptic conductances
- Equation: \frac{dg_{e,k}}{dt} = -\frac{g_{e,k}}{\tau_{\text{AMPA}}} + \sum_j W_{kj}^E \delta(t - t_j^E - d), \quad \frac{dg_{i,k}}{dt} = -\frac{g_{i,k}}{\tau_{\text{GABA}}} + \sum_m W_{km}^I \delta(t - t_m^I - d)
- Tier: 5

### E44: Extracellular Ca2+ depletion
- Section: Tier 5, item 3
- Tier: 5
- Equation: \tau_{\text{Ca}} \frac{d[\text{Ca}^{2+}]_e}{dt} = -I_{\text{Ca,burst}} + \frac{[\text{Ca}^{2+}]_{e,0} - [\text{Ca}^{2+}]_e}{\tau_{\text{ref}}}
- Derivation: Bursting drives Ca_e from 1.2 to <0.6 mM. This lowers release probability and ends bursts after 10-30 ms (model: 22.4 ms) with cluster lags of 2.2-3.4 ms (2.75 ms). Cites Ibarz 2010, Schlingloff 2025, Bragin 2000, Stark 2014.
- Aleph: Tier 5 PV block with extracellular Ca2+ cutoff
- Changes: In A.7, fast ripples ran >90 ms like seizures. The Ca_e depletion is new in A.8.

### E45: Synaptic weight with headroom
- Section: Tier 6
- Tier: 6
- Equation: \tau_w \frac{dW_{ij}}{dt} = (1 - b_m) \left[ (s_Q + \psi(1 - s_Q)) \text{DA}^+ f^+_{ij} (w_{\text{max}} - W_{ij}) - (1 + \text{DA}^-) f^-_{ij} W_{ij} - E_{ij} \right] - \gamma (1 - P_{ij}) W_{ij}
- Symbols: b_m learning brake; DA± RPE; f± [unclear: plasticity eligibility functions, not defined]; E_ij eviction current; ψ [unclear: not defined, same symbol as pericyte state]; γ decay.
- Aleph: Tier 6 synaptic headroom

### E46: Persistence variable
- Equation: P_{ij} = \max(\Omega_{ij}, c_{ij}). Tier 6.

### E47: Vascular metabolic headroom
- Equation: h_Q = D_{\text{cap}} - \sum_{k \in Q} D_k \ge 0. Tier 6. As h_Q -> 0, s_Q -> 0. Aleph: synaptic headroom.

### E48: Condensate capture SDE
- Section: Tier 6
- Tier: 6
- Equation: \tau_c dc_{ij} = \left[ \Omega_{ij} \pi(a_i) (1 - c_{ij}) + \beta_c \frac{c_{ij}^2 (1 - c_{ij})}{K_c^2 + c_{ij}^2} - \gamma_c c_{ij} \right] dt + \sigma_c c_{ij} (1 - c_{ij}) dB_{ij}
- Derivation: Both drift and diffusion "vanish at c=0 and c=1, rigorously proving [0,1] is forward-invariant". Strictly, the drift at c=0 equals Ω π(a) ≥ 0 and the drift at c=1 equals -γ_c < 0; it does not vanish, and the Lean theorems prove exactly this, contradicting the prose. Cites Chen 2020 / Frey & Morris 1997 / Redondo & Morris 2011 (references list only). β_c is also used for the capillary coefficient.
- Aleph: Tier 6 condensate capture SDE

### E49: Barrier-depth distribution
- Equation: p(\Delta U) \propto \exp(-\Delta U / \mu). Tier 6.

### E50: Power-law retention curve
- Equation: P(t) \simeq \Gamma\left(1 + \frac{\sigma_c^2}{\mu}\right) \left(\frac{t}{\tau_0}\right)^{-\sigma_c^2 / \mu}
- Tier: invariant (Tier 6)
- Derivation: Kramers escapes driven by multiplicative noise, plus an exponential distribution of barrier depths, "analytically derives" a power law. No intermediate steps are given. Cites Wixted & Ebbesen 1991.

### E51: Wake synaptic accumulation
- Equation: \text{Wake: } \frac{dS_i}{dt} = g_w \mathcal{C}(t) (1 + \alpha A_r). Tier 6. \mathcal C(t) is a circadian drive; A_r is [unclear: undefined]. In zebrafish, g_w\mathcal C -> 0 under constant light.

### E52: Sleep downscaling (exact gated relaxation)
- Equation: \text{Sleep: } S_i(t) = S_{\text{set}} + (S_i(t_0) - S_{\text{set}}) \exp\left( -k_{\text{down}} \int_{t_0}^t \Theta_{\text{circ}}(t') \cdot u(t') dt' \right)
- Tier: 6
- Derivation: This is the stated exact solution of gated relaxation; the ODE dS/dt = -k_down Θ u (S - S_set) is implied but not written. The circadian tensor arrests pruning in the final 2 h. Cites Suppermpool 2024 (r = 0.58).
- Changes: A.6 static product gate; A.7 thermodynamic exhaustion gate; A.8 continuous relaxation plus Θ_circ.

### E53: Sleep gate and circadian tensor
- Equation: u(t) = \sigma\left(\frac{[\text{Ado}] - \theta_A}{s_A}\right) \left[ 1 - \sigma\left(\frac{\text{NE} - \theta_N}{s_N}\right) \right], \quad \Theta_{\text{circ}}(t) = \frac{1}{1 + \exp\left(\frac{t - t_{\text{dawn}}}{\tau_{\text{circ}}}\right)}
- Tier: 6. Aleph: circadian sleep pruning tensor.

### E54: REM weight jump
- Equation: \Delta W = \lambda_Q \eta_R P (w_{\text{max}} - W) - \pi_R (1 - P) \sigma\left(\frac{w_p - W}{s_w}\right) W
- Tier: 6

### E55: REM headroom projection scalar
- Equation: \lambda_Q = \min\left\{ 1, \frac{h_Q / \beta + \sum \text{dec}}{\sum \text{inc}} \right\}
- Tier: 6. It ensures h_Q ≥ 0 across the jump. β is undefined (presumably energy per unit weight).

### E56: Glymphatic peristalsis
- Equation: v_{\text{glymph}} = v_0 + v_1 \cdot \mathbf{1}_{\text{NREM}} \cdot \left(\frac{\text{AQP4}}{\text{AQP4}_0}\right) \cdot \frac{\mathcal{A}_{\text{NE}}}{\mathcal{A}_{\text{NE}} + K_{\text{NE}}} \cdot \left[ 1 - \sigma\left(\frac{\overline{\text{NE}} - \theta_g}{s_g}\right) \right]
- Tier: 6. \mathcal A_NE is the infra-slow (0.01-0.05 Hz) NE oscillation amplitude (Hauglund 2025). Inference 6 uses the reduced form v_glymph ∝ \mathcal A_NE/(\mathcal A_NE + K_NE): zolpidem cuts \mathcal A_NE by 78%, which gives a 47% drop in exchange. In A.7 the change was +71% (wrong sign).
- Aleph: Tier 6 glymphatic peristalsis

### E57: Thermal Q10 scaling (fly, pigeon)
- Equation: rates scale by Q_{10} (fly 2.0 from 25 °C; pigeon 2.1). Tier: other.

### E58: Pigeon membrane scaling
- Section: Species/pigeon and Inference 1
- Tier: other (allometric)
- Equations: C_{\text{membrane}} \propto k_{\text{syn}}^{2/3}; \quad A_{\text{membrane}} \propto k_{\text{syn}}^{2/3}; \quad \frac{C_{\text{pigeon}}}{C_{\text{rat}}} = \left(\frac{1{,}750}{10{,}000}\right)^{2/3} = 0.313
- Derivation: Fewer synapses give a smaller arbor and less capacitance, so less capacitive Na per spike. "Geometrical scaling" is asserted and the 2/3 exponent is not justified.

### E59: Q10 pump acceleration
- Equation: \Pi_{\text{max}}(T_b) = \Pi_{\text{max},0} \cdot Q_{10}^{(T_b - 37)/10} = 2.1^{0.42} \approx 1.365
- Tier: 1/other. Then "net sodium debt per spike is 0.427 of mammalian" (0.313 × 1.365). The argument that a faster pump "offsets" the area reduction by multiplying them is not explained.

### E60: Capacitive Na influx per spike
- Equation: \Delta n_{\text{spk}} = \frac{C_{\text{membrane}} (V_{\text{peak}} - V_{\text{rest}})}{F \cdot \text{Vol}_i} \left(1 - \frac{n_i}{n_{\text{eq}}}\right)
- Tier: 1. Gives a physical basis for ν_spk.

### E61: Fast-ripple Na load
- Equation: \Delta n_i \approx 25\ \nu_{\text{spk}} per event (30× a normal ripple). Tier 1/5 (Inference 2).

### E62: CBF/CMRO2 ratio
- Equation: n = \Delta\text{CBF}/\Delta\text{CMRO}_2 ≈ 2.5 at ≤4 Hz. Benchmark 2.45-2.63; A.8 gives 2.51 (A.7: 0.37). Tier 2/3.

### E63: Kramers escape probability
- Equation: P_{\text{escape}} \propto \exp\left(-\frac{\Delta U(a_i, \text{NE})}{\sigma_c^2}\right). Tier 6 (Inference 4).

### E64: Circadian barrier elevation
- Equation: \Delta U_{\text{eff}}(t) = \Delta U_0 \left[ 1 + \zeta_{\text{circ}} \sigma\left(\frac{t - t_{\text{dawn}}}{\tau_{\text{circ}}}\right) \right]
- Tier 6. Gives a +45% barrier in the last 2 h before dawn. Note: σ((t - t_dawn)/τ) rises toward dawn, whereas Θ_circ in E53 is its complement.

### E65-E68: Lean 4 theorems (invariant)
- E65 sodium_ledger_upper_invariant: dn_dt(n_eq, …) ≤ 0 for a, r, syn, I_ext ≥ 0. The proof sets 1 - n_eq/n_eq = 0, so dn/dt = -pump ≤ 0 (pump ≥ 0 by positivity of the MM factors). Lean dn_dt = (ν_spk r + ν_syn G_s syn + λ_n + I_ext)(1 - n/n_eq) - Π_max·mm(a,K_a)·mm(n,K_n).
- E66 sodium_ledger_lower_invariant: dn_dt(0, …) > 0. The pump is 0 at n=0, the factor is 1, and the drive is ≥ λ_n > 0.
- E67 capture boundaries: diffusion σ_c c(1-c) is 0 at c=0 and c=1; drift(0) = Ω π_a ≥ 0; drift(1) = -γ_c < 0.
- E68 carbon_mass_balance_closure: dG + dΓ + (dL + dp)/2 = J_G - J_L/2 - v_ox/2, proved by ring.
- The header lists "Positive-Definiteness and Uniqueness of Kirchhoff Graph Fluid Pressures", but no Lean proof is provided.
