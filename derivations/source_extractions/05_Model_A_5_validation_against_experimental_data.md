# Extraction: Model A.5  validation against experimental data.docx
- Model version(s) specified: None new. The document is titled "Model A.4: validation against experimental data" (Oct 9, 2026). It is a validation report on A.4 and lists recommended fixes for A.5. Despite the filename, it does not specify A.5.
- One-paragraph summary of the file: Five "colleague" reviews test A.4 against data. The data are zebrafish synapse/sleep data (Suppermpool 2024), sleep in 58 mammals (Allison & Cicchetti), Herculano-Houzel glucose, pigeon glucose, Allen Neuropixels rates, MICrONS motifs and FlyWire Kenyon cells. The verdict over 24 checks: 6 hold, 7 hold in part, 9 fail, 1 is contested and 1 is housekeeping. The report checks the six A.4 theorems (1 false, 3 partly false), finds wrong numbers (pigeon 0.32x, Table 2) and proposes repaired equation forms for A.5. The equations appear inline as plain text, not as images.
- Parts that could not be read (if any): None. All 6 images (image1-6.png) are data charts/figures referenced only by caption. I did not open them because the text says they are plots. No equation images exist.

### E1: Product sleep gate
- Section in source: Colleague 1
- Tier: 6
- Equation (LaTeX): u = \sigma(\mathrm{Ado})\cdot[1-\sigma(\mathrm{NE})]
- Symbols: u = sleep gate for synapse loss; Ado = adenosine; NE = noradrenaline; σ = sigmoid.
- Derivation/justification: This is A.4's gate inside Eq. 20. Fitted to 9 group means against A.3 (loss whenever asleep), an NE-only gate and an Ado-only gate. It has the best χ² (4.6, AIC 12.6 vs 22.8). It is the only variant that gives loss only for 2-chloroadenosine + clonidine, which matches the paper's conclusion that loss needs high Ado and low NE. Held-out z-RMSE is 1.45 (Ado-only 1.17). It fails on per-fish slopes.
- Cites: Suppermpool et al. 2024
- Aleph 1: Tier 6 circadian sleep pruning (sleep gate); otherwise none
- Changes: A.3 used loss whenever asleep. A.5 should keep the product but slow adenosine clearance to hours (the fitted τ was 0.56 h).

### E2: Adenosine dynamics (Eq. 22, reduced, described only)
- Section: Colleague 1
- Tier: 6
- Equation: no explicit formula. Described as "build-up while awake, clearance while asleep" with clearance time constant τ = 0.56 h (fitted); forcing ≥2 h gives χ² 4.95 and held-out error 2.08.
- Derivation: none given
- Cites: rodent microdialysis (qualitative)
- Aleph 1: none / Tier 6 glymphatic
- Changes: none stated

### E3: Wake gain (A.4 Eq. 20, current and proposed)
- Section: Colleague 1; Fix 6
- Tier: 6
- Equation: A.4: synapses grow at a constant rate g_w while awake. Proposed: g_w = g_0\cdot C(t)\cdot(1+\mathrm{arousal})
- Symbols: g_0 = base gain; C(t) = circadian factor.
- Derivation: Constant-light larvae are awake but show no gain (−3.5 ± 4.2). Deprived fish gain 2.9/h vs 1.65/h by day. So growth tracks circadian phase and arousal.
- Cites: Suppermpool 2024
- Aleph 1: Tier 6 circadian sleep pruning / synaptic headroom
- Changes: proposed for A.5

### E4: Sleep law (energy-scaled)
- Section: Colleague 2
- Tier: other (sleep/energy scaling)
- Equation: t_{sleep}/t_{wake} = \kappa B ; \quad \frac{d\ln(t_{sleep}/t_{wake})}{d\ln B} = 1 ; \quad \frac{d\ln t_{sleep}}{d\ln B} = t_{wake}/24
- Symbols: B = brain glucose use per gram [inferred: from context]; κ calibrated on the rat only.
- Derivation: Both derivatives follow from the law. A.3 regressed ln(sleep/wake) (slope 0.66 ± 0.36). A.4's slope applies to a different regression (0.36 ± 0.19 vs predicted 0.54). So there is no A.3 "derivation error". Out of sample on 58 mammals: R² 0.30, equal to the best free fit. The observed slope on ln brain mass is −0.21 ± 0.04 vs −0.13 to −0.15 predicted.
- Cites: Allison & Cicchetti 1976; Herculano-Houzel 2011; Zepelin & Rechtschaffen 1974
- Aleph 1: none
- Changes: corrects A.4's claim about A.3

### E5: Glucose allometry
- Section: Colleague 2
- Tier: other
- Equation: B \propto M_{brain}^{-0.127} (or exponent −0.15)
- Derivation: fixed before any sleep data were used
- Cites: Herculano-Houzel 2011 six species; Karbowski 2007
- Aleph 1: none
- Changes: none

### E6: Ecological factor ξ_eco
- Section: Colleague 2; Fix 7
- Tier: other
- Equation: residual of ln(sleep/wake) changes by −0.35 ± 0.06 per danger-index level (Fix 7: ≈ −0.33 per level, one global coefficient)
- Derivation: empirical; p = 1.5e-7; R² 0.30 → 0.57
- Cites: Allison & Cicchetti danger index
- Aleph 1: none
- Changes: must be one global coefficient, not tuned per species

### E7: Log-normal set points
- Section: Colleague 2
- Tier: 4/5 (homeostatic set points)
- Equation: set points log-normal with σ_ρ = 1.5 (calibration)
- Derivation: fit to Allen log10 SD (0.56 vs 0.63)
- Aleph 1: Tier 4 controller set point (approximate)
- Changes: none

### E8: STDP window balance
- Section: Colleague 2
- Tier: 6
- Equation: A_- = 0.8\,A_+ (a potentiation-dominated case giving 2.96x reciprocity)
- Derivation: simulation only
- Aleph 1: none
- Changes: A.5 should state the window balance

### E9: Table 1 corrections (Kabanov capacity, participation ratio, sheaf)
- Section: Colleague 3
- Tier: invariant
- Equation: C = 100/(e\ln 2) = 53.1\ \mathrm{bit/s}; \quad PR = (1+r)/(1-r) = 3.89\ (7.64 if eigenvalues); \quad \dim H^1 = d\cdot b_1
- Derivation: recomputed as correct. PR applies when σ_k are singular values. H¹ holds under flat holonomy.
- Cites: Kabanov
- Aleph 1: none
- Changes: confirms the A.4 corrections

### E10: Theorem 1 (forward invariance) and Eq. 18 condensate repair
- Section: Colleague 3; Fix 2
- Tier: invariant (also Tier 6 condensate SDE)
- Equation: at e = 0: dn/dt = \lambda_n + \text{synaptic load} > 0; c exceeds 1 if \beta_c > \gamma_c(1+K_c^2); proposed term \beta_c c^2(1-c)/(K_c^2+c^2); noise \sigma c(1-c)\,dW (or a reflected SDE); Na⁺ influx \propto (E_{Na}-v), or a bound stated for J > J_min
- Derivation: The proof checked n = 0 but not N_max. Nagumo's theorem does not apply to an additive-noise SDE: 6% of paths leave [0,1] at D = 0.002 and 98% at D = 0.01.
- Cites: Nagumo
- Aleph 1: Tier 6 condensate capture SDE; Tier 1 sodium debt ledger
- Changes: adds the (1−c) factor

### E11: Theorem 2 energy balance
- Tier: invariant; holds (code residual 6e-6). No equation shown. Aleph 1: Tier 3 ledger.

### E12: Theorem 3 headroom with a projected REM step
- Section: Colleague 3; Fix 3
- Tier: invariant / Tier 6 headroom
- Equation: REM jump \Delta W = \eta_R P (w_{max}-W); projected: scale by \min(1, h/(\beta\sum \Delta W^+))
- Derivation: Holds for the wake flow. The REM jump takes h from +0.0028 to −0.011. Eq. 14's eviction term E_ij sits outside the (1−b_m) bracket, so cancellation needs Π_Q defined with (1−b_m).
- Aleph 1: Tier 6 synaptic headroom
- Changes: move E_ij inside the bracket

### E13: Theorem 5 power-law forgetting
- Tier: invariant
- Equation: P(t)\to\Gamma(1+D/\mu)(t/\tau_0)^{-D/\mu}; barrier \propto(\beta-\beta_c)^{1.51}
- Derivation: The integral is correct, but Eq. 18 does not give exponentially distributed barriers (KS p ≈ 0). This is Bouchaud's trap model (1992).
- Aleph 1: Tier 6 condensate
- Changes: state the barrier distribution as an assumption

### E14: Theorem 6 contraction and the sleep map
- Tier: invariant / Tier 6
- Equation: SWS map W \leftarrow (1-\delta(1-P))W; claimed rate (1-\delta)e^{-cT}; honest bound e^{-cT}\times 1; require \mu_2(J)\le -c; proposed exact flow W(T)=S_{set}+(W-S_{set})\exp(-k\int u\,dt)
- Derivation: The factor equals 1 for fully tagged synapses. The two sleep formalisms have different fixed points. The exact flow of Eq. 20 is non-expansive and gives Theorem 6.
- Aleph 1: Tier 6 sleep pruning tensor
- Changes: Fix 4 uses one formalism

### E15: Theorem 4 no controller conflict
- Tier: invariant; holds (ATP floor 0.27). No equation. Aleph 1: Tier 4.

### E16: Eq. 11 glymphatic units
- Tier: 6
- Equation: \tau_K\,dk/dt containing v_glymph (form not given)
- Derivation: v_glymph is dimensionless there but a rate elsewhere; one convention must be chosen.
- Aleph 1: glymphatic peristalsis

### E17: ChR2 Na⁺ loading (Eq. 5)
- Section: Colleague 4
- Tier: 1
- Equation: not given. Only the voltage-dependent Na⁺ fraction of the photocurrent should be loaded.
- Results: ATP 0.58 → 0.17, Na⁺ 4.7 > n_c = 4, f-I slope 16.3 → 1.2, threshold 0.55 → 1.61.
- Aleph 1: Tier 1 sodium debt ledger

### E18: Avian cost law scaling
- Section: Colleague 4; Fix 1
- Tier: 3 (energy cost)
- Equation: scale P_{rest} and c_{AP} by a membrane-area factor 0.38 → ratio 0.32x at k = 1800 (A.4 law gives 0.69x; floor 0.60x at k = 0)
- Cites: Attwell–Laughlin; von Eugen 2022
- Aleph 1: Tier 3 metabolism (approximate)

### E19: Ephaptic term (Eqs. 1, 24)
- Section: Colleague 5
- Tier: 1
- Equation: g_{eph}(v - V_e); activating function \partial^2 V_e/\partial x^2
- Derivation: A uniform V_e does not change transmembrane voltage, so the term acts like a leak reversal. Eq. 24 gives about 5 µV at 50 µm and is singular at |x − x_j| = 0.
- Aleph 1: Eq 5.4 gap junction (no direct counterpart)
- Changes: use two compartments or drop the term

### E20: Theta precession (Eq. 23)
- Section: Colleague 5; Fix 5
- Tier: 5
- Equation: with ω_0 = ω_θ: \Delta\phi=\kappa\int r\,dt = \kappa r_{peak}\sigma_x\sqrt{2\pi}/v; replacement d\phi/dt=\omega_\theta+2\pi v(t)/L_{field}
- Derivation: Precession scales with spike count (1436° vs 90°), but data show about one cycle. The O'Keefe–Recce form locks phase to distance.
- Cites: Huxter et al. 2003; O'Keefe & Recce 1993
- Aleph 1: none

### E21: KC sparseness bound
- Section: Colleague 5
- Tier: 5
- Equation: active fraction \le \rho/r_{on}
- Derivation: Homeostasis pins the mean rate at ρ.
- Aleph 1: none
