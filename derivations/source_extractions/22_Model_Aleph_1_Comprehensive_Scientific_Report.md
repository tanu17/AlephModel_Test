# Extraction: Model_Aleph_1_Comprehensive_Scientific_Report.docx
- Model version(s) specified: Model A.10.1 (= Aleph 1). Lineage table also covers A.8, A.9, A.10.
- One-paragraph summary of the file: "Formal Multi-Scale Specification of Model A.10.1". Executive summary; lineage table (A.8 -> A.9 -> A.10 -> A.10.1 per tier); Section 3 lists the conservation laws/physics each operator is claimed to derive from (with short inline equations); Section 4 gives "first-principles" derivations of k_stress (Eq 4.1, GR Hill binding) and Q (Eq 4.2, Beer-Lambert); Section 5 states Eqs 5.1-5.11 (Tier 1, Tier 2, Tier 6 only; no Tier 3-5 equations written out); Section 6 phylogenetic BIC model selection; Section 7 species parameter catalog; Section 8 109-test validation scorecard; Section 9 five emergent invariants (prose); Section 9.1 ten new emergent invariants with formulas; references.
- Parts that could not be read (if any): Eq 5.3 is truncated in the source itself ("τ_s·(\...)" — ellipsis in original). Figure 1 (architecture diagram, image1.png) not inspected for equations; caption describes it as an inter-tier coupling diagram.

### E1: Black-Leff operational model (lineage table)
- Section in source: 2, Table 1, Tier 1, "Model A.9 Upgrade"
- Tier: 1
- Equation (LaTeX): $E/E_{max} = \tau[L]/(K_A+(\tau+1)[L])$
- Symbols: τ efficacy, [L] ligand, K_A affinity (not further defined)
- Derivation: none given
- Cites: Black-Leff GPCR Operational Model
- Corresponding Aleph 1 equation: inherited Tier 1 Black-Leff operational model
- Changes: introduced in A.9 (A.8 had fixed gain scalars Gs, gHCN); also Gq-PLC-IP3-Ca2+ cascade added in A.9 (no equation).

### E2: Cx36 gap current (lineage table form)
- Section: 2, Table 1, Tier 1, A.10.1 fix
- Tier: 1
- Equation: $I_{gap} = -g_{gap}\cdot L_{gap}\cdot v_{PV}$
- Symbols: as Eq 5.4
- Derivation: none given
- Cites: Connexin-36
- Aleph: Aleph Eq. 5.4
- Changes: new in A.10.1; also "vectorized GABAA β2/β3 allosteric assembly" new in A.10.1. A.10 added Woodhull, Hall-Ehlert, SERT/DAT reuptake ledger.

### E3: Noradrenergic vasomotion term (lineage table)
- Section: 2, Table 1, Tier 2, A.9
- Tier: 2
- Equation: $-\kappa_{NE}\cdot r_e$ (a term), and Péclet "Pe"
- Symbols: κ_NE noradrenergic constriction gain, r_e vessel radius (implied)
- Derivation: none given
- Cites: Locus Coeruleus Stuart-Landau oscillator
- Aleph: inherited Tier 2 noradrenergic vasomotion
- Changes: added in A.9; A.8 had static Hagen-Poiseuille graph, dual fast NsMJ + slow Kir2.1 dilation, heuristic sleep gate; A.10 coupled LC limit cycle to perivascular flux J_v(t), added hydraulic bounds.

### E4: Thermal dilation (lineage table form)
- Section: 2, Table 1, Tier 2, A.10.1
- Tier: 2
- Equation: $\Delta r_{thermal} = \kappa_T\cdot (T - T_b)_+$
- Symbols: κ_T thermal dilation coefficient, T tissue temp, T_b body temp
- Derivation: none given
- Cites: Pennes bioheat
- Aleph: Aleph Eq. 5.8 (note: here without the r_e0 factor that appears in Eq 5.8)
- Changes: new in A.10.1 together with discrete capillary stall percolation operator.

### E5: Apoptotic eviction criterion
- Section: 2, Table 1, Tier 4&5, A.9
- Tier: 5
- Equation: $a_i < 0.05\,a_0$
- Symbols: a_i node ATP/energy (implied), a_0 baseline
- Derivation: none; "excises degenerate nodes without crash"
- Aleph: Tier 5 apoptotic node eviction
- Changes: added A.9; A.8 had tri-variable AIS controller (L, x, gAIS) and CA1 PV depolarization block with [Ca2+]e cutoff; A.10.1 adds gap-junction coupling.

### E6: Hydraulic floor (lineage table form)
- Section: 2, Table 1, Tier 6, A.10
- Tier: 6
- Equation: $L_p \ge L_{p,min}$; also "dW_ij/dt_g" (ontogenetic scaling tensor), "P_AQP4 -> 0" (AQP4 degradation), Θ_circ(t), dH_HDAC/dt (named only)
- Derivation: none given
- Aleph: Aleph Eq. 5.11
- Changes: A.8: condensate capture SDE on [0,1], circadian pruning tensor Θ_circ(t); A.9: ontogenetic scaling tensor, AQP4 degradation; A.10: delayed TrkB-BDNF synaptogenesis, Lp floor; A.10.1: HDAC2/5 chromatin operator. Tier 3: A.9 coupled OXPHOS to ROS; A.10.1 couples astrocytic lactate shuttling to pericyte dilation (no equations).

### E7: Field-dependent free energy of blocker binding
- Section: 3.1 (Thermodynamics)
- Tier: 1
- Equation: $\Delta G(v) = \Delta G_0 + z\cdot\delta_B\cdot F\cdot v$
- Symbols: z valence, δ_B electrical distance, F Faraday, v voltage
- Derivation: stated as the basis: "Boltzmann Distribution in Electrical Fields: Derives the Woodhull pore-blocking equation from the electrochemical potential difference ΔG(v)". No intermediate steps.
- Cites: Boltzmann distribution, Woodhull (1973)
- Aleph: Aleph Eq. 5.2 (basis)
- Changes: none mentioned

### E8: Carbon mass conservation
- Section: 3.1
- Tier: 3
- Equation: $\frac{d}{dt}[G + \Gamma + (L + p)/2] = J_G - J_L/2 - v_{ox}/2$
- Symbols: G glucose, Γ glycogen, L lactate, p pyruvate, J_G glucose influx, J_L lactate efflux, v_ox oxidative flux
- Derivation: attributed to "First Law of Thermodynamics: Enforces closed carbon mass conservation across all metabolic substrate pools". No steps.
- Aleph: inherited Tier 3 carbon balance
- Changes: Table 1 says A.8 established exact carbon balance; maintained thereafter.

### E9: Power-law forgetting
- Section: 3.1
- Tier: 6
- Equation: $P(t) \propto t^{-\sigma_c^2/\mu}$
- Symbols: σ_c noise, μ drift (not defined)
- Derivation: "Kramers Escape Theory: Derives power-law forgetting curves ... from stochastic Brownian motion over molecular condensate energy barriers." No steps.
- Aleph: Tier 6 condensate capture SDE
- Changes: none

### E10: Hagen-Poiseuille conductance
- Section: 3.2
- Tier: 2
- Equation: $G_e = \pi r_e^4/(8\,\eta_{blood}\,\ell_e)$
- Symbols: r_e radius, η_blood viscosity, ℓ_e length
- Derivation: "Navier-Stokes Lubrication Approximation: Derives Hagen-Poiseuille conductances ... on the microvascular graph." No steps.
- Aleph: inherited Tier 2 Hagen-Poiseuille
- Changes: A.8 "static Hagen-Poiseuille graph".

### E11: Kirchhoff vertex conservation (simple form)
- Section: 3.2
- Tier: 2
- Equation: $\sum G_e (p_c - p_{c'}) = 0$
- Derivation: "Kirchhoff Flow Conservation: Enforces mass conservation at every vascular vertex". 
- Aleph: Aleph Eq. 5.6 (homogeneous form)
- Changes: none

### E12: Poiseuille wall shear stress
- Section: 3.2
- Tier: 2
- Equation: $\tau_w = 4\eta Q/(\pi r_e^3)$
- Symbols: Q flow, η viscosity
- Derivation: "Poiseuille Wall Shear Stress Law: Derives endothelial shear stress ... for capillary stall dislodgement."
- Aleph: inherited wall shear stress; feeds Eq 5.9
- Changes: none

### E13: Péclet number
- Section: 3.2
- Tier: 2
- Equation: $Pe = vL/D$
- Derivation: "Quantifies glymphatic waste clearance via the dimensionless Péclet number." 
- Aleph: inherited perivascular Péclet number
- Changes: Péclet advection added in A.9 (Table 1).

### E14: Pennes bioheat (Section 3 form)
- Section: 3.2
- Tier: 2
- Equation: $\rho C_p\,\partial T/\partial t = k_{th}\nabla^2 T - \omega_b C_b (T - T_b) + Q_{laser}$
- Derivation: "Pennes Bioheat Conduction Law: Governs optical laser thermal diffusion." 
- Aleph: Aleph Eq. 5.8
- Changes: new in A.10.1.

(Section 3.3-3.4 also name, without equations: Stuart-Landau normal form for LC (0.01-0.1 Hz); supercritical Hopf bifurcation for glymphatic-sedation paradox (uniform GABAA agonism collapses vasomotion to fixed point); singular perturbation/saddle-node for 14-21 day SSRI latency; Michaelis-Menten & Hill for GLUT1 J_G, oxygen extraction E(f), SERT/DAT/NET; clathrin-coated pit kinetics for GPCR internalization.)

### E15: Eq. 4.1 First-Principles Epigenetic Stress Derivation
- Section: 4.1
- Tier: 6
- Equation: $k_{stress} = k_{transloc}\cdot\left[\frac{([CORT]_{free})^{n_H}}{(K_{d,GR})^{n_H} + ([CORT]_{free})^{n_H}}\right]$
- Symbols: [CORT]_free free glucocorticoid titer (cortisol primates/humans, corticosterone rodents); K_d,GR GR dissociation constant (2.4 nM human; 4.8 nM rodent, in vitro); n_H ≈ 1.8 Hill cooperativity of receptor homodimerization; k_transloc nuclear import rate constant. Table 3 values of k_stress: Drosophila 0.000 (absent), zebrafish 0.020 d^-1, mouse 0.080, rat 0.060, macaque 0.010, human 0.003, pigeon 0.015 d^-1.
- Derivation: "derived from the biochemical Hill binding kinetics of intracellular glucocorticoid receptors (GR) and their nuclear translocation rate" — i.e. rate = translocation rate × Hill fractional occupancy. "This grounds k_stress directly in measurable endocrine titers and receptor binding affinities." No further steps.
- Cites: Hill binding kinetics, GR homodimerization
- Aleph: Aleph Eq. 4.1
- Changes: replaces an empirical fitting rate.

### E16: Eq. 4.2 First-Principles Radiative Heat Transport
- Section: 4.2
- Tier: 2
- Equation: $Q(x,\lambda) = \mu_a(\lambda)\cdot\Phi(x),\quad \mu_a(\lambda) = \ln(10)\cdot[[HbO_2]\varepsilon_{HbO_2}(\lambda) + [HbR]\varepsilon_{HbR}(\lambda)] + \mu_{a,water}(\lambda) + \mu_{a,lipid}(\lambda)$
- Symbols: Φ(x) photon fluence, solved via diffusion approximation of radiative transport with reduced scattering μ_s'(λ); ε molar extinction coefficients (at 473 nm, ε_HbO2 = 3.2×10^4 cm^-1/(mol/L)); μ_s'(473 nm) per Table 3: 0.2 (fly), 0.4 (zebrafish), 1.2 (mouse), 1.5 (rat), 2.5 (macaque), 2.9 (human), 1.8 (pigeon) mm^-1.
- Derivation: "derived from radiative transport theory and the Beer-Lambert law"; heat deposited = absorption coefficient × fluence; absorption = ln(10)-converted chromophore extinction sum plus water and lipid. "completely eliminates Q as a free parameter".
- Cites: Beer-Lambert law, radiative transport diffusion approximation
- Aleph: Aleph Eq. 4.2
- Changes: replaces "arbitrary laser scaling scalar".

### E17: Eq. 5.1 Somatic Potential with K_ATP Brake
- Section: 5, Tier 1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap} w_i (v_i - E_K) + G_s\zeta(1-\nu_{ACh})\sum_j [s_j W_{ij} x_{ij} r_j(t-\tau_{ij})] + G_s(1+\nu_{ACh}) I_i(t) + I_{ax,i}$
- Symbols: not defined in this file (g_K(a_i) ATP-dependent K_ATP conductance, w_i adaptation, ν_ACh cholinergic tone, s_j sign, W_ij weights, x_ij resources, r_j rates, τ_ij delays, I_ax axial current — names inferred only from notation; source gives none)
- Derivation: none given
- Aleph: Aleph Eq. 5.1
- Changes: none stated

### E18: Eq. 5.2 Woodhull Open-Channel Trap Law
- Section: 5, Tier 1
- Tier: 1
- Equation: $I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}e^{-\alpha_{Mg} v} + \frac{[B]}{K_B}\exp\left(-\frac{z\delta_B F v}{R T_b}\right)\right]^{-1}$
- Symbols: [B] blocker (ketamine) concentration, K_B, δ_B electrical distance, z valence; others undefined
- Derivation: Section 3 says derived from Boltzmann distribution with ΔG(v) = ΔG0 + zδ_B F v (E7). No steps.
- Cites: Woodhull (1973)
- Aleph: Aleph Eq. 5.2
- Changes: added in A.10 (Table 1). Invariant (Sec 9 #2): PV cells at -52 mV, 40-80 Hz are 4.74-fold more susceptible than pyramidal cells at -68 mV.

### E19: Eq. 5.3 Vectorized Hall-Ehlert Subunit Allosteric Law
- Section: 5, Tier 1
- Tier: 1
- Equation: $(E/E_{max})_{GABA} = \sum_s f_s(x)\left[\frac{[A]/K_{A,s} + \alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})}{1 + [A]/K_{A,s} + [B]/K_{B,s} + \alpha_s([A]/K_{A,s})([B]/K_{B,s}) + \tau_s\cdot(\ldots)}\right]$ — [unclear: denominator truncated with "(\...)" in source]
- Symbols: s subunit assembly (β2/β3 per Table 1), f_s(x) subunit fraction, A agonist (GABA), B allosteric modulator, α_s cooperativity, β_s efficacy modulation, τ_s efficacy
- Derivation: Section 3: "Gibbs Free Energy & Mass Action Equilibrium: Derives the Hall-Ehlert allosteric ternary complex model from the thermodynamic cycles of a two-state receptor." No steps.
- Cites: Hall (2000)
- Aleph: Aleph Eq. 5.3
- Changes: Hall-Ehlert added A.10; vectorized β2/β3 in A.10.1 (fixes etomidate test 41->67). Invariant: lim_{[A]→0} E/Emax ≡ 0 (E30).

### E20: Eq. 5.4 Connexin-36 Electrical Gap Junction Syncytium
- Section: 5, Tier 1
- Tier: 1
- Equation: $I_{gap,k} = \sum_{j\in PV\ neighbors} g_{gap}(v_{PV,j} - v_{PV,k}) = -g_{gap}[L_{gap} v_{PV}]_k$
- Symbols: L_gap graph Laplacian of PV gap network
- Derivation: none beyond the equality itself (sum of pairwise differences = negative Laplacian)
- Aleph: Aleph Eq. 5.4
- Changes: new A.10.1 (fixes ketamine gamma test 4->65).

### E21: Eq. 5.5 Competitive Transporter Reuptake Ledger
- Section: 5, Tier 1
- Tier: 1
- Equation: $\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}[M]_{syn}}{K_{m,T}(1 + [Inhibitor]/K_i) + [M]_{syn}} - k_{clear}[M]_{syn}$
- Derivation: Section 3: Michaelis-Menten kinetics govern SERT/DAT/NET reuptake (competitive inhibition form). No steps.
- Aleph: Aleph Eq. 5.5
- Changes: SERT/DAT reuptake ledger added in A.10.

### E22: Eq. 5.6 3D Kirchhoff Microvascular Balance
- Section: 5, Tier 2
- Tier: 2
- Equation: $\sum_{e\ni c} G_e(p_c - p_{c'}) = c_a r_a^4 (P_a - p_c)\mathbb{1}_{c\in Art} - G_v p_c \mathbb{1}_{c\in Ven} + \frac{k' n_c}{V_{cortex}}$
- Symbols: c_a r_a^4 arterial inflow conductance, P_a arterial pressure, G_v venous conductance, k' n_c / V_cortex [unclear: source term, undefined]
- Derivation: Kirchhoff flow conservation (Sec 3). 
- Aleph: Aleph Eq. 5.6
- Changes: none stated

### E23: Eq. 5.7 Stuart-Landau Locus Coeruleus Limit Cycle
- Section: 5, Tier 2
- Tier: 2
- Equation: $\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\omega_{LC})NE_{LC} - |NE_{LC}|^2 NE_{LC} - g_{GABA}NE_{LC} - g_{\alpha 2}NE_{LC}$
- Derivation: Stuart-Landau limit-cycle normal form (0.01-0.1 Hz); supercritical Hopf: uniform GABAA agonism collapses vasomotion into a fixed point (glymphatic-sedation paradox). No steps.
- Aleph: Aleph Eq. 5.7
- Changes: introduced A.9; A.10 coupled to perivascular flux J_v(t).

### E24: Eq. 5.8 Pennes Bioheat Photothermal Dilation Operator
- Section: 5, Tier 2
- Tier: 2
- Equation: $\rho C_p\frac{\partial T}{\partial t} = k_{th}\nabla^2 T - \omega_b C_b (T - T_b) + Q_{laser}(x,\lambda),\quad \Delta r_{e,thermal} = r_{e0}\kappa_T\max(0, T - T_b)$
- Derivation: Pennes bioheat law (Sec 3); Q from Eq 4.2.
- Aleph: Aleph Eq. 5.8
- Changes: new A.10.1 (fixes test 52->68). Table 1 form lacks r_e0.

### E25: Eq. 5.9 Discrete Stochastic Capillary Stall Percolation Operator
- Section: 5, Tier 2
- Tier: 2
- Equation: $P(stall_e) = \left[1 + \exp\left(-\left(\beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}(r_{crit}/r_e)^2 - \beta_{shear}(\tau_{w,e}/\tau_{crit})\right)\right)\right]^{-1},\quad G_e = S_e\cdot G_{Poiseuille}$
- Symbols: S_e stall indicator (implied 0/1), τ_w,e from E12
- Derivation: none given
- Aleph: Aleph Eq. 5.9
- Changes: new A.10.1 (fixes test 58->69).

### E26: Eq. 5.10 Epigenetic HDAC Chromatin Condensation Operator
- Section: 5, Tier 6
- Tier: 6
- Equation: $\tau_{epig}\frac{dH_{HDAC}}{dt} = k_{stress}F_{chronic\_stress} - k_{acetyl}a_i H_{HDAC},\quad k_{BDNF,eff} = \frac{k_{BDNF}}{1 + \exp(\gamma_{silence}(H_{HDAC} - \theta_{epig}))}$
- Derivation: none given (k_stress from Eq 4.1)
- Aleph: Aleph Eq. 5.10
- Changes: new A.10.1, HDAC2/5 (fixes test 25->66).

### E27: Eq. 5.11 Regularized Non-Singular Hydraulic Floor
- Section: 5, Tier 6
- Tier: 6
- Equation: $L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp(\lambda(P_{AQP4}(t) - 1))$
- Symbols: P_AQP4 basal values Table 3: 0.00/0.45/0.86/0.88/0.92/0.94/0.72 (fly/zebrafish/mouse/rat/macaque/human/pigeon)
- Derivation: none given
- Aleph: Aleph Eq. 5.11
- Changes: floor added in A.10.

### E28: Tracheal glucose diffusion (Drosophila)
- Section: 6, Table 2
- Tier: other (A.8 allocation for Drosophila; Tier 3 analogue)
- Equation: $J_G = D_{trachea}\nabla^2 G$
- Derivation: none; justification: avascular tracheal gas diffusion, A.8 eliminates 14 unidentifiable vascular params (BIC 182.4 vs 345.8).
- Aleph: none
- Changes: n/a

### E29: Avian membrane arbor scaling
- Section: 6, Table 2 (Columba livia)
- Tier: other
- Equation: $A_{membrane}\propto k_{syn}^{2/3} = 0.313\times$ rodent
- Derivation: none; "fully resolves high body temperature (41.2 °C) without mammalian columnar equations"
- Aleph: none

### E30: Allosteric Ceiling & Fail-Safe Isoelectricity Theorem
- Section: 9 #1
- Tier: invariant
- Equation: $\lim_{[A]\to 0} E/E_{max} \equiv 0$; $r_{min} > 0$
- Derivation: allosteric cooperativity requires endogenous transmitter; as firing → 0, hyperpolarizing efficacy self-terminates, giving thermodynamic lower bound on firing.
- Aleph: follows from Eq 5.3

### E31: Ketamine paradox invariant
- Section: 9 #2
- Tier: invariant
- Equation: (numeric) 4.74-fold susceptibility, PV at -52 mV vs pyramidal at -68 mV
- Derivation: "Derives from the Woodhull pore-block law" with 40-80 Hz tonic firing. No calculation shown.
- Aleph: Eq 5.2

### E32: Canard/saddle-node antidepressant latency
- Section: 9 #3
- Tier: invariant
- Equation: τ ≈ 14 days (autoreceptor desensitization), t_crit ≈ 16.2 days
- Derivation: slow-fast system of SERT inhibition, 5-HT1A auto-inhibition, TrkB synaptogenesis; slow manifold crosses saddle-node. No equations.
- Aleph: Eq 5.5, Tier 6 TrkB-BDNF

### E33: Tachyphylaxis internalization
- Section: 9 #4
- Tier: invariant
- Equation: $t_{res} > 12$ s ⇒ β-arrestin-2 endocytosis; recovery half-life 5.8 days
- Derivation: residency time vs clathrin-coated pit nucleation time; "analytically deriving" (not shown).
- Aleph: inherited receptor internalization

### E34: Cross-species neurovascular coordination invariant Π_neurovasc
- Section: 9 #5
- Tier: invariant
- Equation: no formula; GI > 1.5 ⇒ 2-s hypoxic delays; requires NsMJ latency < 150 ms
- Derivation: dimensional analysis across brain masses (not shown).

### E35: Invariant 1 Capillary Percolation Threshold
- Section: 9.1 #1
- Tier: invariant
- Equation: $\Pi_{stall} = \frac{\sum_{e\in stalled}\ell_e}{\sum_{e\in total}\ell_e} \ge p_c^* \approx 0.075$
- Justification: above 7.5% stalled fraction the minimum-cut flow path diverges → regional hypoxia despite >92% patent vessels.
- Aleph: Eq 5.9

### E36: Invariant 2 DBS Suppression Threshold
- Section: 9.1 #2
- Tier: invariant
- Equation: $\Omega_{DBS} = f_{DBS}/f_{beta} \ge 1/(\pi\,\tau_{GABA,I}\,f_{beta}) \approx 4.3 \Rightarrow f_{DBS}\ge 120\text{-}130$ Hz
- Justification: Tsodyks-Markram presynaptic vesicle depletion; 130 Hz works, 60 Hz fails.

### E37: Invariant 3 Glymphatic Stability Ratio
- Section: 9.1 #3
- Tier: invariant
- Equation: $\Lambda_{glymph} = \frac{k_0 L_{p,0}\Delta p_{PVS}}{\dot m_{prod} R_{PVS}} > 1.0$
- Justification: saddle-node tipping point vs tau accumulation driven by AQP4 depolarization.

### E38: Invariant 4 Ischemic Survival Horizon
- Section: 9.1 #4
- Tier: invariant
- Equation: $K_{ischemia} = \frac{[PCr]_0 + 2[ATP]_0 + 2\Gamma_0}{\lambda_n n_{eq} F_{Faraday}} \approx 2.5$ min (human), 34 min (rat optic)
- Justification: survival boundary before anoxic depolarization. No steps.

### E39: Invariant 5 Cognitive Safety Criterion
- Section: 9.1 #5
- Tier: invariant
- Equation: $\Psi_{pore} = \frac{k_{off}}{k_{on}[Glu]_{peak}}\exp\left(\frac{z\delta_B F v_{spike}}{R T_b}\right) \ge 1.0$
- Justification: voltage-dependent unblocking during spikes; memantine vs ketamine.

### E40: Invariant 6 Gap-Junction Gamma Sync
- Section: 9.1 #6
- Tier: invariant
- Equation: $\Sigma_{sync} = \frac{g_{gap}\lambda_2(L_{gap})}{\bar g_{GABA}\sigma_v^2} \ge 1.0$
- Justification: "Master stability function"; Lyapunov stability of high-gamma.

### E41: Invariant 7 Neurotrophic Hysteresis Index
- Section: 9.1 #7
- Tier: invariant
- Equation: $\Xi_{BDNF} = \frac{\kappa_{BDNF}k_{BDNF}a_i}{\gamma_{prune}(1 + \exp(\gamma_{silence}(H_{HDAC} - \theta)))S_{set,0}}$ (no threshold given)
- Justification: low-spine attractor / epigenetic hysteresis barrier.

### E42: Invariant 8 Fluid Peristalsis Invariant
- Section: 9.1 #8
- Tier: invariant
- Equation: $\Phi_{peristalsis} = \frac{\omega_{LC}\tau_v}{\sqrt{1 + (\kappa_{stiff}C_{amyloid})^2}}\cdot\frac{r_{a0}^4}{8\eta R_{PVS} D} \ge 1.0$
- Justification: amyloid wall stiffening extinguishes advective clearance.

### E43: Invariant 9 Ictal Wavefront Velocity
- Section: 9.1 #9
- Tier: invariant
- Equation: $c_{ictal} = 2\sqrt{D_K\left[\frac{\nu_K r_{max} h_K(k_c)}{\Delta k_c} - 1/\tau_K\right]} \approx 0.12\text{-}0.28$ mm/s
- Justification: traveling-wave speed (Fisher-KPP-like form; source does not name it).

### E44: Invariant 10 Safe Opto-Irradiance Boundary
- Section: 9.1 #10
- Tier: invariant
- Equation: $\Theta_{optothermal} = \frac{\mu_a(\lambda)P_{laser}\delta_{pulse}}{(\omega_b C_b + k_{th}/r_{beam}^2)\cdot 0.5\,°C} < 1.0 \Rightarrow P^*_{laser}\le 14.8$ mW/mm²
- Justification: max irradiance avoiding uncoupled photothermal vasodilation. Aleph: Eqs 4.2, 5.8.
