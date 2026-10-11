# Extraction: Model_A10_Comprehensive_Scientific_Report.docx
- Model version(s) specified: Model A.10 (compared against A.8 and A.9; NOT Aleph 1 / A.10.1). Equation numbering is A.10's own (Eq. 1.1-1.7, 2.1-2.3, 3.1, 4.1, 6.1-6.3), which differs from Aleph 1 numbering (5.x).
- One-paragraph summary of the file: Report specifying Model A.10 as a six-tier multi-scale model generalizing A.9 to ionotropic pore blockers (ketamine), allosteric modulators (benzodiazepines), reuptake inhibitors (SSRIs) and invertebrates. Sec 2 is a cross-species BIC model-selection table (A.8 better for Drosophila, zebrafish, pigeon). Sec 3 lists governing equations for Tiers 1-6 (Tier 5 has no equation, text only). Sec 4 gives five "invariants" with short derivations (allosteric ceiling, ketamine disinhibition ratio, SSRI saddle-node latency, stretched-exponential resensitization, neurovascular dimensionless number). Sec 5 is an in-silico validation table on 14 OpenNeuro datasets; Sec 6 implementation checklist; Sec 7 references.
- Parts that could not be read (if any): None; equations were tables, fully read. The "..." inside Eq. 2.2 is in the source.

### E1: Drosophila tracheal diffusion flux (invertebrate branch)
- Section in source: Sec 2 Table 1 (Drosophila row); repeated Sec 6 Table item 7
- Tier: 3 (substrate supply; branch switch replacing Tier 2)
- Equation: $J_G = D_{trachea}\nabla^2 G$
- Symbols: J_G glucose flux; D_trachea tracheal diffusion coefficient; G glucose. No values.
- Derivation: none given; justified because Drosophila lacks closed endothelial vessels, PVS and AQP4 endfeet and respires via open tracheal hemolymph diffusion; imposing A.9/A.10 vascular dynamics adds 14 unidentifiable degenerate parameters. Item 7: "Eliminate microvascular division-by-zero errors when compiling Drosophila."
- Cites: Lin et al. 2024 (Drosophila connectome) in refs.
- Aleph 1: none (phylogenetic branch switch).
- Changes: Model A.8 "Avascular Branch" is optimal for Drosophila.

### E2: Avian membrane scaling
- Section: Sec 2 Table 1 (Columba livia row)
- Tier: other (cross-species scaling, Model A.8)
- Equation: $A_{membrane} \propto k_{syn}^{2/3} = 0.313\times$ rodent
- Symbols: A_membrane membrane arbor area; k_syn [unclear: synaptic scaling factor]; T_b = 41.2 °C.
- Derivation: none; states it offsets high body temperature, explaining "avian hyperthermic efficiency paradox"; with Q10 scaling.
- Cites: Model A.8.
- Aleph 1: none.
- Changes: A.8 fits pigeon better than A.10.

(Table 1 also lists parameter values: Γ0 = 7.0 mM (rat), GI = 1.73 macaque, d' = 0.94, Ā_Ca = 38 mV human, GI = 2.56 human, photoperiod 14:10 zebrafish.)

### E3: Somatic integration & metabolic brake (Eq. 1.1)
- Section: Sec 3, Tier 1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap} w_i (v_i - E_K) + G_s\zeta(1-\nu_{ACh})\sum_j [s_j W_{ij} x_{ij} r_j(t-\tau_{ij})] + G_s(1+\nu_{ACh}) I_i(t) + I_{ax,i}$
- Symbols: not defined in text; g_K(a_i) ATP-dependent K conductance ("thermodynamic metabolic braking"), w_i adaptation, ν_ACh cholinergic modulation, τ_ij delays, I_ax,i axial current.
- Derivation: none given ("Somatic integration retains thermodynamic metabolic braking and adaptation").
- Cites: none.
- Aleph 1: Aleph Eq. 5.1 (somatic potential with K_ATP brake).
- Changes: "retains" from earlier models.

### E4: Active dendritic membrane potential (Eq. 1.2)
- Section: Sec 3, Tier 1
- Tier: 1
- Equation: $C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i} - E_L) + \bar A_{Ca}\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i} - E_{HCN}) + I_{AMPA} + I_{NMDA} + I_{GABA} - I_{ax,i}$
- Symbols: Ā_Ca dendritic Ca amplitude (human 38 mV per Table 1); Δ(u) [unclear: dCaAP activation function]; g_HCN(DA) dopamine-dependent HCN conductance.
- Derivation: none; couples active Ca electrogenesis to three pharmacological operators.
- Cites: Gidon et al. 2020.
- Aleph 1: inherited Tier 1 dendritic potential.
- Changes: none stated.

### E5: Generalized Woodhull pore-block law (Eq. 1.3)
- Section: Sec 3, Tier 1, Module 1A
- Tier: 1
- Equation: $I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}\exp(-\alpha_{Mg} v) + \frac{[B]}{K_B}\exp\left(-\frac{z\delta_B F v}{R T_b}\right)\right]^{-1}$
- Symbols: [B] blocker (ketamine/memantine/MK-801), δ_B fractional electrical depth of binding site in pore, K_B, z charge, F, R, T_b body temperature; δ_Mg [unclear: Mg constant, written as δ_Mg], α_Mg.
- Derivation: "open-channel trap model where blocker [B] binds within the electrical field of the pore with fractional depth δ_B". No further steps.
- Cites: Woodhull 1973.
- Aleph 1: Aleph Eq. 5.2.
- Changes: Sec 5 says it "resolves earlier A.9 error" for ketamine.

### E6: Hall-Ehlert ternary allosteric operational law (Eq. 1.4)
- Section: Sec 3, Tier 1, Module 1B
- Tier: 1
- Equation: $\frac{E}{E_{max}} = \frac{[A]/K_A + \alpha\beta([A]/K_A)([B]/K_B)}{1 + [A]/K_A + [B]/K_B + \alpha([A]/K_A)([B]/K_B) + \tau_{eff}([A]/K_A + \alpha\beta([A]/K_A)([B]/K_B))}$
- Symbols: [A] endogenous transmitter, [B] allosteric modulator, α binding affinity cooperativity, β operational efficacy cooperativity, τ_eff efficacy, K_A, K_B.
- Derivation: "formalized through thermodynamic cooperativity". Corollary stated: when [A]=0, E/E_max ≡ 0 identically, so pure PAMs cannot gate directly.
- Cites: Hall 2000 (Ehlert implied).
- Aleph 1: Aleph Eq. 5.3 (vectorized Hall-Ehlert GABA_A law).
- Changes: new in A.10. Note: τ_eff appears in the denominator only, numerator has no τ factor (as written).

### E7: Receptor internalization & tachyphylaxis (Eq. 1.5)
- Section: Sec 3, Tier 1, Module 1C
- Tier: 1
- Equation: $\frac{d[R_{surf}]}{dt} = -k_{endo}\left[\frac{\tau_{arr}[L]}{K_A + (\tau_{arr}+1)[L]}\right][R_{surf}] + k_{recycle}(R_{total} - [R_{surf}])$
- Symbols: [L] ligand, τ_arr β-arrestin-2 transducer efficacy, k_endo, k_recycle, R_total.
- Derivation: none (Black-Leff-form occupancy term implied, not stated).
- Cites: none here.
- Aleph 1: inherited receptor internalization/tachyphylaxis.
- Changes: dual G-protein/β-arrestin bias new in A.10.

### E8: Biased Gq second-messenger generation (Eq. 1.6)
- Section: Sec 3, Tier 1
- Tier: 1
- Equation: $\frac{d[IP_3]_i}{dt} = k_{PLC}\left[\frac{\tau_{Gq}[L]}{K_A + (\tau_{Gq}+1)[L]}\right][R_{surf}] - \gamma_{IP3}[IP_3]_i$
- Symbols: τ_Gq Gq efficacy, k_PLC, γ_IP3 decay.
- Derivation: none.
- Cites: none.
- Aleph 1: inherited Gq-PLC-IP3-Ca2+ cascade / Black-Leff.
- Changes: none stated.

### E9: Competitive transporter reuptake (Eq. 1.7)
- Section: Sec 3, Tier 1, Module 1D
- Tier: 1
- Equation: $\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}[M]_{syn}}{K_{m,T}(1 + [Inhibitor]/K_i) + [M]_{syn}} - k_{clear}[M]_{syn}$
- Symbols: [M]_syn extracellular monoamine, R_release firing-dependent vesicular release, V_max,T, K_m,T, K_i, k_clear.
- Derivation: "Michaelis-Menten reuptake under competitive transporter inhibition".
- Cites: none.
- Aleph 1: Aleph Eq. 5.5.
- Changes: new in A.10 (Sec 5: "Reuptake Corrected").

### E10: Stuart-Landau LC oscillator (Eq. 2.1)
- Section: Sec 3, Tier 2
- Tier: 2
- Equation: $\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\omega_{LC})NE_{LC} - |NE_{LC}|^2 NE_{LC} - g_{GABA}NE_{LC} - g_{\alpha2}NE_{LC}$
- Symbols: complex NE_LC, λ_LC, ω_LC, g_GABA, g_α2.
- Derivation: none; LC tone "acts as a Stuart-Landau limit-cycle oscillator driving rhythmic vasomotion". Sec 5 claims 0.032 Hz peak.
- Cites: Hauglund 2025.
- Aleph 1: Aleph Eq. 5.7.
- Changes: introduced in A.9 (per Sec 1).

### E11: Coupled arteriolar vasomotion (Eq. 2.2)
- Section: Sec 3, Tier 2
- Tier: 2
- Equation: $\tau_v \frac{dr_e}{dt} = r_{a0}[1 + \beta_{NsMJ}(I_{NsMJ}/I_0) + \ldots] - r_e - \kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_e$
- Symbols: r_e, r_a0 arteriole radius; β_NsMJ; I_NsMJ; κ_NE. "..." in source (other terms: Kir2.1, A2B cascades per text).
- Derivation: none; text: dilation integrates NsMJ (<150 ms), endothelial Kir2.1 (2 mm/s), astrocytic A2B cascades; Kirchhoff on 3D Hagen-Poiseuille graph (no equation given).
- Cites: Zhang 2024; Blinder 2013.
- Aleph 1: inherited NsMJ+Kir2.1 dual dilation / noradrenergic vasomotion (Eq. 5.6 Kirchhoff only mentioned in prose).
- Changes: none.

### E12: Perivascular flux & Péclet (Eq. 2.3)
- Section: Sec 3, Tier 2
- Tier: 2
- Equation: $J_v(t) = \frac{1}{R_{PVS}}\int \left|\frac{\partial r_e(t)}{\partial t}\right| dt,\quad Pe = \frac{v L}{D}$
- Symbols: R_PVS perivascular resistance; v, L, D velocity, length, diffusivity.
- Derivation: none. Sec 5: Pe 0.42 wake, 2.85 sleep.
- Aleph 1: inherited perivascular flux and Péclet number.
- Changes: none.

### E13: Carbon mass balance
- Section: Sec 3, Tier 3 (inline)
- Tier: 3
- Equation: $\frac{d}{dt}[G + \Gamma + (L + p)/2] = J_G - J_L/2 - v_{ox}/2$
- Symbols: G glucose, Γ glycogen, L lactate, p pyruvate, J_G, J_L fluxes, v_ox oxidation.
- Derivation: none; "satisfy exact carbon mass balance". Text claims CK clamps ATP within ±1.2%.
- Aleph 1: Tier 3 carbon balance.
- Changes: none.

### E14: Metabolic energy ledger & PCr buffer (Eq. 3.1)
- Section: Sec 3, Tier 3
- Tier: 3
- Equation: $\frac{da_i}{dt} = 2v_{gn} + Y_{ox}v_{ox} + k_{CK}([PCr][ADP] - [Cr][ATP]/K_{eq}) - D_i$
- Symbols: a_i ATP, v_gn glycolysis, Y_ox ATP yield, k_CK, K_eq, D_i demand.
- Derivation: none.
- Aleph 1: Tier 3 CK/PCr buffer, ATP balance.
- Changes: none.

### E15: AIS morphological adaptation & threshold (Eq. 4.1)
- Section: Sec 3, Tier 4
- Tier: 4
- Equation: $\tau_L\frac{dL_i}{dt} = -(L_i - L_0(t_g)) - G_L L_0(\bar c_i - 1),\quad \theta_{AIS,i} = -k_B\ln(L_i/L_0) - k_x\ln(x_i/x_0) - k_g\ln(g_{AIS}/g_0)$
- Symbols: L_i length, x_i position, g_AIS density, t_g developmental age, c̄_i [unclear: normalized activity/Ca], G_L gain.
- Derivation: none; "unique homeostatic fixed points". Only L equation given; x and g dynamics not written.
- Aleph 1: Tier 4 AIS controller + threshold law (not Aleph Eq. 4.1 k_stress).
- Changes: none.

(Tier 5: no equation; text mentions d[Ca2+]e/dt, 150 Hz / 340 Hz ripples, apoptotic eviction.)

### E16: TrkB phosphorylation (Eq. 6.1)
- Section: Sec 3, Tier 6
- Tier: 6
- Equation: $\tau_{TrkB}\frac{d[TrkB^*]}{dt} = -[TrkB^*] + k_{BDNF}([5\text{-}HT]_{syn} - 5HT_{basal})_+ \cdot a_i$
- Derivation: none.
- Aleph 1: Tier 6 TrkB-BDNF synaptogenesis.
- Changes: new in A.10.

### E17: Synaptic set-point remodeling (Eq. 6.2)
- Section: Sec 3, Tier 6
- Tier: 6
- Equation: $\frac{dS_{set}}{dt} = \kappa_{BDNF}[TrkB^*] - \gamma_{prune}(1 - \Theta_{circ}(t))S_{set}$
- Symbols: Θ_circ circadian gate.
- Derivation: none.
- Aleph 1: Tier 6 TrkB-BDNF / circadian pruning.
- Changes: new.

### E18: Regularized hydraulic floor (Eq. 6.3)
- Section: Sec 3, Tier 6
- Tier: 6
- Equation: $L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp(\lambda(P_{AQP4}(t) - 1))$
- Symbols: P_AQP4 polarity, λ rate.
- Derivation: none; Sec 6 justification: prevents solver stiffness singularities (R_PVS → ∞) in 3xTg-AD.
- Aleph 1: Aleph Eq. 5.11.
- Changes: regularization new in A.10 (A.9 had singular AQP4 decay implied).

### E19: Infinite-PAM limit (Insight 1 step 1)
- Section: Sec 4 Insight 1
- Tier: invariant
- Equation: $\lim_{[B]\to\infty}\frac{E}{E_{max}} = \frac{\beta[A]/K_A}{1/\alpha + [A]/K_A + \tau_{eff}\beta[A]/K_A}$; also $[A]_{syn} = \gamma_{GABA} r_I$
- Derivation: from Eq. 1.4 with [B]→∞, GABA release proportional to interneuron firing.
- Aleph 1: invariant from Eq. 5.3.
- Changes: none.

### E20: Vanishing drive (Insight 1 step 2)
- Section: Sec 4 Insight 1
- Tier: invariant
- Equation: $\lim_{[A]\to 0}[\lim_{[B]\to\infty} E/E_{max}] = 0/(1/\alpha) \equiv 0$
- Derivation: as activity suppressed, r_I→0 so [A]→0; conclusion strictly positive lower bound r_min > 0, no isoelectric arrest under pure PAM.
- Aleph 1: Allosteric Ceiling theorem.

### E21: Woodhull unblock probability & blockade ratio (Insight 2)
- Section: Sec 4 Insight 2
- Tier: invariant
- Equation: $P_{open}(v) = [1 + ([B]/K_B)\exp(-z\delta_B F v/RT)]^{-1}$; $R_{block} = \frac{P_{open}(\langle v_{Pyr}\rangle)}{P_{open}(\langle v_{PV}\rangle)} = \exp[z\delta_B F(\langle v_{PV}\rangle - \langle v_{Pyr}\rangle)/(R T_b)]$
- Values: ⟨v_PV⟩ ≈ -52 mV (40-80 Hz), ⟨v_Pyr⟩ ≈ -68 mV (1-4 Hz), z=+1, δ_B=0.65, Δv=16 mV, 37 °C: R_block = exp(0.65·16/26.7) = exp(0.39) ≈ 1.48; ×3.2 NMDAR open probability → 4.74-fold trap rate on PV.
- Derivation: from Eq. 1.3. Note the ratio equality assumes the "1+" term negligible (not stated). Also exp(0.39)=1.48 is consistent, but 0.65·16/26.7 = 0.39 ✓; 1.48·3.2=4.74 ✓.
- Aleph 1: Ketamine Paradox invariant from Eq. 5.2.

### E22: Fast raphe manifold (Insight 3)
- Section: Sec 4 Insight 3
- Tier: invariant
- Equation: $\varepsilon\frac{dr_{DRN}}{dt} = r_0 - g_{1A}\frac{[5\text{-}HT]_{DRN}}{[5\text{-}HT]_{DRN}+K_{1A}} r_{DRN}$
- Derivation: singular perturbation slow-fast system from Eq. 1.7 + 5-HT1A autoinhibition + Eq. 6.1-6.2.

### E23: Slow 5-HT1A desensitization manifold (Insight 3)
- Section: Sec 4 Insight 3
- Tier: invariant
- Equation: $\frac{dK_{1A}(t)}{dt} = +\mu_{desens}[5\text{-}HT]_{DRN}(t)(K_{1A,max} - K_{1A}(t))$, τ ≈ 14 days
- Derivation: acute: r_DRN→0, trapped on low-firing slow manifold; K_1A drifts to fold (saddle-node) at t_crit ≈ 16.2 days, jump to high firing, dS_set/dt > 0. No calculation of t_crit shown. Sec 6 says 14-21 day.
- Aleph 1: Canard/saddle-node invariant.

### E24: Stretched-exponential resensitization (Insight 4)
- Section: Sec 4 Insight 4
- Tier: invariant
- Equation: $[R_{surf}](t) = R_{total}[1 - (1 - R_{min}/R_{total})\exp(-(t/\tau_{recycle})^{\alpha_{fractal}})]$; $t_{res} = 1/k_{off}$
- Values: τ_clathrin ≈ 12 s, 5-HT t_res ≈ 0.4 s, psychedelics t_res 18-90 s, α_fractal ≈ 0.62; full recovery 5.8 days.
- Derivation: residency-time vs clathrin assembly argument; claims "derives" trajectory from Eq. 1.5, but Eq. 1.5 solution would be pure exponential; stretched exponent asserted ("anomalous endosomal trafficking diffusion"), no steps.
- Aleph 1: Fractal internalization invariant.

### E25: Neurovascular coordination invariant (Insight 5)
- Section: Sec 4 Insight 5
- Tier: invariant
- Equation: $\tau_{wm} \propto GI\cdot M_{brain}^{1/3}$; $\tau_{cap} = \ell_{cap}/v_{blood}$; $\Pi_{neurovasc} = \frac{v_{axon}\ell_{cap}}{D_{metab}\,GI\,M_{brain}^{1/3}}$
- Values: mouse M=0.4 g, GI=1.0 → Π≈4.8; human 1400 g, GI 2.56 → Π≈0.18; 1.8-2.4 s delay; NsMJ <150 ms.
- Derivation: dimensional argument only; no computation shown. Note: Π not dimensionless as written (v·ℓ/D is dimensionless but M^{1/3} has units) and stated ratio (4.8/0.18≈27) vs (1400/0.4)^{1/3}·2.56≈39 not reconciled; τ_cap does not appear in Π.
- Aleph 1: Metabolic-gyrification invariant.
