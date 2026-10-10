# Extraction: Model_Aleph_1_only equations.docx
- Model version(s) specified: Model A.10.1 (= Aleph 1); lineage table also covers A.8, A.9, A.10.
- One-paragraph summary of the file: "Formal Multi-Scale Specification of Model A.10.1: Biophysical Operator Derivations". Executive summary (claims 109 tests / 31 datasets, 95.4% validation), Table 1 lineage audit A.8 -> A.10.1 per tier, Sec 3 list of foundational laws (with inline formulas), Sec 4 first-principles derivations of k_stress (Eq 4.1) and Q (Eq 4.2), Sec 5 boxed equations 5.1-5.11 (Tiers 1, 2, 6 only; no Tier 3/4/5 equations given explicitly), Sec 6 phylogenetic model selection by BIC (Table 2), Sec 7 multi-species parameter catalog (Table 3). Derivations in Sec 5 are NOT given: equations are just stated.
- Parts that could not be read (if any): Figure 1 (architecture diagram PNG) not inspected - captioned as a coupling diagram, not equations. Eq 5.3 denominator contains a literal ellipsis "τ_s·(...)" in the source (truncated in the document itself).

### E1: Black-Leff operational model (lineage table)
- Section in source: Table 1, Tier 1, Model A.9 column
- Tier: 1
- Equation: $E/E_{max} = \tau[L]/(K_A+(\tau+1)[L])$
- Symbols: τ efficacy, [L] ligand, K_A affinity (not further defined)
- Derivation: none given
- Cites: Black-Leff GPCR operational model
- Aleph 1: inherited Tier 1 Black-Leff
- Changes: introduced in A.9 (A.8 had fixed gain scalars Gs, gHCN)

### E2: Gap-junction current, short form (lineage table)
- Section: Table 1, Tier 1, A.10.1 column
- Tier: 1
- Equation: $I_{gap} = -g_{gap}\cdot L_{gap}\cdot v_{PV}$
- Symbols: see E19
- Derivation: none given
- Cites: Connexin-36
- Aleph 1: Aleph Eq. 5.4
- Changes: new in A.10.1

### E3: Noradrenergic vasomotion term
- Section: Table 1, Tier 2, A.9 column
- Tier: 2
- Equation: $-\kappa_{NE}\cdot r_e$
- Symbols: κ_NE gain, r_e vessel radius
- Derivation: none given
- Cites: none
- Aleph 1: inherited noradrenergic vasomotion
- Changes: added in A.9 along with Stuart-Landau LC and Péclet Pe

### E4: Thermal dilation (lineage table form)
- Section: Table 1, Tier 2, A.10.1 column
- Tier: 2
- Equation: $\Delta r_{thermal} = \kappa_T\cdot(T - T_b)_+$
- Symbols: κ_T thermal dilation coefficient, T_b body temperature
- Derivation: none given
- Cites: Pennes bioheat
- Aleph 1: Aleph Eq. 5.8 (note: here no r_e0 prefactor, unlike Eq 5.8)
- Changes: new in A.10.1

### E5: Apoptotic eviction criterion
- Section: Table 1, Tier 4&5, A.9 column
- Tier: 5
- Equation: $a_i < 0.05\,a_0$
- Symbols: a_i node ATP/energy, a_0 baseline
- Derivation: none given
- Cites: none
- Aleph 1: inherited apoptotic node eviction
- Changes: added in A.9, maintained in A.10.1

### E6: Hydraulic floor constraint
- Section: Table 1, Tier 6, A.10 column
- Tier: 6
- Equation: $L_p \ge L_{p,min}$
- Derivation: none given
- Aleph 1: Aleph Eq. 5.11
- Changes: added in A.10. Table also names (no formulas) dW_ij/dt_g ontogenetic tensor, P_AQP4 -> 0 (A.9), Θ_circ(t) (A.8), dH_HDAC/dt (A.10.1).

### E7: Woodhull electrochemical barrier
- Section: Sec 3.1
- Tier: 1
- Equation: $\Delta G(v) = \Delta G_0 + z\cdot\delta_B\cdot F\cdot v$
- Symbols: z blocker valence, δ_B electrical distance, F Faraday, v voltage
- Derivation: stated as basis: "Boltzmann Distribution in Electrical Fields: Derives the Woodhull pore-blocking equation from the electrochemical potential difference"
- Cites: Boltzmann distribution, Woodhull
- Aleph 1: Aleph Eq. 5.2 (underlying)
- Changes: none

### E8: Carbon mass conservation
- Section: Sec 3.1
- Tier: 3
- Equation: $\frac{d}{dt}[G + \Gamma + (L+p)/2] = J_G - J_L/2 - v_{ox}/2$
- Symbols: G glucose, Γ glycogen, L lactate, p pyruvate, J_G glucose influx, J_L lactate efflux, v_ox oxidation flux
- Derivation: justified by "First Law of Thermodynamics: enforces closed carbon mass conservation across all metabolic substrate pools"
- Aleph 1: inherited Tier 3 carbon balance
- Changes: A.8 six closed pools, preserved through A.10.1

### E9: Kramers forgetting power law
- Section: Sec 3.1
- Tier: 6 (invariant-like)
- Equation: $P(t) \propto t^{-\sigma_c^2/\mu}$
- Derivation: "derived from stochastic Brownian motion over molecular condensate energy barriers" (Kramers escape theory); no steps
- Aleph 1: inherited condensate capture SDE
- Changes: none

### E10: Hagen-Poiseuille conductance
- Section: Sec 3.2
- Tier: 2
- Equation: $G_e = \pi\cdot r_e^4/(8\cdot\eta_{blood}\cdot\ell_e)$
- Derivation: "Navier-Stokes Lubrication Approximation: Derives Hagen-Poiseuille conductances ... on the microvascular graph"
- Aleph 1: inherited Hagen-Poiseuille
- Changes: A.8 static graph

### E11: Kirchhoff vertex conservation
- Section: Sec 3.2
- Tier: 2
- Equation: $\sum G_e(p_c - p_{c'}) = 0$
- Derivation: "Enforces mass conservation at every vascular vertex"
- Aleph 1: Aleph Eq. 5.6 (homogeneous form)

### E12: Wall shear stress
- Section: Sec 3.2
- Tier: 2
- Equation: $\tau_w = 4\cdot\eta\cdot Q/(\pi\cdot r_e^3)$
- Derivation: "Poiseuille Wall Shear Stress Law ... for capillary stall dislodgement"
- Aleph 1: inherited wall shear stress (used in Eq 5.9)

### E13: Péclet number
- Section: Sec 3.2
- Tier: 2 (glymphatic)
- Equation: $Pe = v\cdot L/D$
- Derivation: quantifies glymphatic clearance; none further
- Aleph 1: inherited Péclet number

### E14: Pennes bioheat (Sec 3 form)
- Section: Sec 3.2
- Tier: 2
- Equation: $\rho C_p \partial T/\partial t = k_{th}\nabla^2 T - \omega_b C_b (T - T_b) + Q_{laser}$
- Derivation: cited law only
- Aleph 1: Aleph Eq. 5.8
- Sec 3.3/3.4 also name (no formulas): Stuart-Landau (LC 0.01-0.1 Hz), supercritical Hopf (uniform GABA_A agonism collapses vasomotion to fixed point), singular perturbation/saddle-node (14-21 d SSRI latency), Michaelis-Menten/Hill (J_G, E(f), SERT/DAT/NET), clathrin pit kinetics (internalization, tachyphylaxis).

### E15: Eq. 4.1 k_stress
- Section: 4.1
- Tier: 6
- Equation: $k_{stress} = k_{transloc}\cdot\left[\frac{([CORT]_{free})^{n_H}}{(K_{d,GR})^{n_H} + ([CORT]_{free})^{n_H}}\right]$
- Symbols: [CORT]_free free glucocorticoid (cortisol primates/humans, corticosterone rodents); K_d,GR = 2.4 nM human, 4.8 nM rodent (in vitro); n_H ≈ 1.8 Hill cooperativity of GR homodimerization; k_transloc nuclear import rate constant
- Derivation: "derived from the biochemical Hill binding kinetics of intracellular glucocorticoid receptors (GR) and their nuclear translocation rate" - replaces an empirical fitting rate; grounds k_stress in measurable titers.
- Cites: Hill kinetics
- Aleph 1: Aleph Eq. 4.1
- Changes: replaces empirical fitted k_stress (Table 3 still lists per-species k_stress values 0-0.08 d^-1)

### E16: Eq. 4.2 optical heat deposition
- Section: 4.2
- Tier: 2
- Equation: $Q(x,\lambda) = \mu_a(\lambda)\cdot\Phi(x),\quad \mu_a(\lambda) = \ln(10)\cdot[[HbO_2]\varepsilon_{HbO_2}(\lambda) + [HbR]\varepsilon_{HbR}(\lambda)] + \mu_{a,water}(\lambda) + \mu_{a,lipid}(\lambda)$
- Symbols: Φ(x) photon fluence from diffusion approximation of radiative transport with reduced scattering μ_s'(λ); ε molar extinction coefficients (473 nm: ε_HbO2 = 3.2×10^4 cm^-1/(mol/L)); μ_s' per species in Table 3 (0.2-2.9 mm^-1)
- Derivation: from radiative transport theory and Beer-Lambert law; eliminates Q as free parameter
- Aleph 1: Aleph Eq. 4.2
- Changes: replaces arbitrary laser scaling scalar

### E17: Eq. 5.1 somatic potential with K_ATP brake
- Section: 5, Tier 1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap} w_i (v_i - E_K) + G_s\zeta(1-\nu_{ACh})\sum[s_j W_{ij} x_{ij} r_j(t-\tau_{ij})] + G_s(1+\nu_{ACh}) I_i(t) + I_{ax,i}$
- Symbols: not defined in this file
- Derivation: none given
- Aleph 1: Aleph Eq. 5.1

### E18: Eq. 5.2 Woodhull open-channel trap law
- Tier: 1
- Equation: $I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}e^{-\alpha_{Mg} v} + \frac{[B]}{K_B}e^{-z\delta_B F v/(R T_b)}\right]^{-1}$
- Symbols: [B] blocker (e.g. ketamine), K_B, z, δ_B, F, R, T_b; others undefined
- Derivation: none in Sec 5; Sec 3 says derived from Boltzmann / ΔG(v) (E7)
- Aleph 1: Aleph Eq. 5.2
- Changes: added in A.10 (fix for ketamine pore-blockers)

### E19: Eq. 5.3 vectorized Hall-Ehlert
- Tier: 1
- Equation: $(E/E_{max})_{GABA} = \sum_s f_s(x)\left[\frac{[A]/K_{A,s} + \alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})}{1 + [A]/K_{A,s} + [B]/K_{B,s} + \alpha_s([A]/K_{A,s})([B]/K_{B,s}) + \tau_s\cdot(\ldots)}\right]$
- Symbols: s subunit assembly (β2/β3 per Table 1), f_s(x) fraction; α_s cooperativity, β_s efficacy modulation, τ_s; [unclear: "τ_s·(...)" literally truncated in source]
- Derivation: none here; Sec 3 says derived from Gibbs free energy/mass action thermodynamic cycles of a two-state receptor
- Aleph 1: Aleph Eq. 5.3
- Changes: Hall-Ehlert added A.10; vectorized over β2/β3 in A.10.1

### E20: Eq. 5.4 Cx36 gap junction
- Tier: 1
- Equation: $I_{gap,k} = \sum_{j\in PV\,nbrs} g_{gap}(v_{PV,j} - v_{PV,k}) = -g_{gap}[L_{gap} v_{PV}]_k$
- Derivation: none (equality to graph Laplacian stated)
- Aleph 1: Aleph Eq. 5.4; new A.10.1

### E21: Eq. 5.5 transporter reuptake ledger
- Tier: 1
- Equation: $\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}[M]_{syn}}{K_{m,T}(1+[Inhibitor]/K_i) + [M]_{syn}} - k_{clear}[M]_{syn}$
- Derivation: none; Sec 3 cites Michaelis-Menten (competitive inhibition)
- Aleph 1: Aleph Eq. 5.5; SERT/DAT ledger added A.10

### E22: Eq. 5.6 3D Kirchhoff microvascular balance
- Tier: 2
- Equation: $\sum_{e\ni c} G_e(p_c - p_{c'}) = c_a r_a^4 (P_a - p_c)\mathbf 1_{c\in Art} - G_v p_c \mathbf 1_{c\in Ven} + (k' n_c)/V_{cortex}$
- Derivation: none (Sec 3 Kirchhoff conservation)
- Aleph 1: Aleph Eq. 5.6

### E23: Eq. 5.7 Stuart-Landau LC
- Tier: 2
- Equation: $\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\omega_{LC})NE_{LC} - |NE_{LC}|^2 NE_{LC} - g_{GABA}NE_{LC} - g_{\alpha2}NE_{LC}$
- Derivation: none; Sec 3 names Stuart-Landau normal form and supercritical Hopf
- Aleph 1: Aleph Eq. 5.7; introduced A.9

### E24: Eq. 5.8 Pennes photothermal dilation
- Tier: 2
- Equation: $\rho C_p \frac{\partial T}{\partial t} = k_{th}\nabla^2 T - \omega_b C_b (T - T_b) + Q_{laser}(x,\lambda),\quad \Delta r_{e,thermal} = r_{e0}\kappa_T\max(0, T - T_b)$
- Derivation: none
- Aleph 1: Aleph Eq. 5.8; new A.10.1

### E25: Eq. 5.9 capillary stall percolation
- Tier: 2
- Equation: $P(stall_e) = \left[1 + \exp\left(-(\beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}(r_{crit}/r_e)^2 - \beta_{shear}(\tau_{w,e}/\tau_{crit}))\right)\right]^{-1},\quad G_e = S_e\cdot G_{Poiseuille}$
- Symbols: S_e stall state (undefined further)
- Derivation: none
- Aleph 1: Aleph Eq. 5.9; new A.10.1

### E26: Eq. 5.10 HDAC chromatin operator
- Tier: 6
- Equation: $\tau_{epig}\frac{dH_{HDAC}}{dt} = k_{stress}F_{chronic\_stress} - k_{acetyl}a_i H_{HDAC},\quad k_{BDNF,eff} = \frac{k_{BDNF}}{1 + \exp(\gamma_{silence}(H_{HDAC} - \theta_{epig}))}$
- Derivation: none
- Aleph 1: Aleph Eq. 5.10; new A.10.1 (HDAC2/5)

### E27: Eq. 5.11 hydraulic floor
- Tier: 6
- Equation: $L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp(\lambda(P_{AQP4}(t) - 1))$
- Derivation: none
- Aleph 1: Aleph Eq. 5.11; regularized floor added A.10

### E28: Tracheal glucose diffusion (Drosophila)
- Section: 6, Table 2
- Tier: other
- Equation: $J_G = D_{trachea}\nabla^2 G$
- Derivation: rationale for using A.8 in avascular insects
- Aleph 1: none

### E29: Avian membrane scaling
- Section: 6, Table 2 (Columba)
- Tier: other
- Equation: $A_{membrane}\propto k_{syn}^{2/3} = 0.313\times$ rodent
- Derivation: none
- Aleph 1: none
