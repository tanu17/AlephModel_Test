# Extraction: Model A.3 Species-Resolved Model for Macaque, Rat, Zebrafish and Fly.docx
- Model version(s) specified: Model A.3 (builds on A.2, formerly "Model B"; next revision named A.4)
- One-paragraph summary of the file: A.3 keeps all twelve A.2 equations (not restated here) and adds six pieces: a species parameter vector Theta_s, a transmitter-to-equation map (sign / Na+ load / modulator), a Q10 temperature law, a continuous-time sleep gate replacing A.2's SWS map, a bistable (condensate) capture equation replacing A.2's capture equation, and optogenetic/systemic terms in the Na+ ledger. A "Checked maths" section gives closed-form results (expansion in-degree optimum, sleep law, zebrafish synapse relaxation, Kramers-escape forgetting power law, lateralisation instability, per-neuron cost law, optogenetic Na+ steady state, temperature scaling), each said to be checked numerically in code (modela/species.py). Tests against fly, rat, zebrafish and macaque data follow.
- Parts that could not be read (if any): None. Equations are present as LaTeX text, not images. The two images (image1.png, image2.png) are data charts (zebrafish synapse counts; sleep law vs data) per their captions; not equations. The twelve A.2 equations are referenced but not reproduced in this file.

### E1: Species parameter vector
- Section in source: What A.3 adds to A.2, item 1
- Tier: other (parameterisation across all tiers)
- Equation: \Theta_s = \big(N,\ \{f_\tau\},\ \{\text{NT}_j\},\ k,\ T_b,\ \text{supply type},\ \{\text{expansion layers}\},\ G_s\big)
- Symbols: N neuron count; f_tau cell-type fractions; NT_j each neuron's transmitter; k synapses per neuron; T_b body temperature; supply type (glial-tracheal vs capillary); expansion layers (mushroom-body Kenyon cells / cerebellar granule cells); G_s systemic energy-status gain. Values per species in table (fly 139,255 neurons, ~390 syn/neuron, ~25 C; zebrafish ~100,000, 28.5 C; rat 200 million, ~8,000 cortical, 37 C; macaque 6.38 billion, ~6,000 cortical, 37 C).
- Derivation: none given; stated that every species-dependent number enters only through this vector.
- Cites: FlyWire (Schlegel 2024), mouse atlas (Yao 2023), Herculano-Houzel 2011, etc.
- Aleph 1: none (Tier 6 ontogenetic scaling tensor is the nearest analogue)
- Changes: new in A.3.

### E2: Transmitter map (sign rule)
- Section: item 2
- Tier: 1
- Equation: s = +1 (glutamate AMPA/NMDA, nicotinic ACh; Na+ load, ATP cost); s = -1 (GABA_A, glycine, GluCl; Cl-, no Na+ load); modulators (DA^+, DA^- in plasticity; gain g(NE); ACh balance \nu)
- Symbols: s synapse sign.
- Derivation: inhibitory synapses cheaper because current carried by Cl- not Na+; fly 44% inhibitory input implies lower energy per synapse.
- Cites: none specific.
- Aleph 1: inherited Tier 1 sodium debt ledger (Na+ load), Aleph Eq 5.3 GABA_A (loosely)
- Changes: new in A.3.

### E3: Q10 temperature law
- Section: item 3
- Tier: other (applies to all rate constants and costs; thermal)
- Equation: \tau(T_b)=\tau(T_0)\,Q_{10}^{-(T_b-T_0)/10},\qquad c(T_b)=c(T_0)\,Q_{10}^{(T_b-T_0)/10}
- Symbols: tau any time constant; c any cost; T_b body temperature; T_0 reference temperature; Q10 = 2.3 (Checked maths).
- Derivation: none; result: fly at 25 C spends 0.37x mammalian energy per synapse, zebrafish at 28.5 C 0.49x. Fly prediction 7-49 fW vs measured 20-110 fW: "not supported".
- Cites: Metaboplasticity (arXiv 2025) uses Q10 as proxy.
- Aleph 1: none (Aleph Eq 5.8 Pennes bioheat is the thermal tier, different form)
- Changes: new in A.3.

### E4: Continuous-time sleep gate
- Section: item 4
- Tier: 6
- Equation: \frac{dS}{dt}=\begin{cases} g_w & \text{wake}\\ -k\,u(\mathrm{Ado},\mathrm{NE})\,\big(S-S_{set}\big) & \text{sleep}\end{cases}
- Symbols: S synapse count/synaptic level; S_set set point; S-S_set synaptic excess since set point (A.2 headroom saturation at one-neuron level); g_w wake gain rate (fit 1.65 synapses/h, zebrafish); k rate; u gate needing high adenosine and low noradrenaline.
- Derivation: SWS map of A.2 turned into a rate to compare with overnight synapse imaging; gate per Suppermpool et al. 2024 experiments.
- Cites: Suppermpool et al. 2024 Nature.
- Aleph 1: Tier 6 circadian sleep pruning tensor / synaptic headroom
- Changes: replaces A.2 discrete SWS map. Limits: first-order law fails late night (predicts -5.2, measured +0.8); u needs a time course (A.4).

### E5: Bistable capture SDE
- Section: item 5
- Tier: 6
- Equation: \tau_c\dot c = \Omega\,\pi(e_Q)(1-c) + \beta_c\frac{c^{2}}{K_c^{2}+c^{2}} - \gamma_c c + \sqrt{2D}\,\xi(t)
- Symbols: c capture variable; tau_c time constant; Omega tag; pi(e_Q) energy-gated capture function; beta_c, K_c Hill self-sustaining gain/half-point; gamma_c decay; D noise intensity; xi(t) white noise. (tau_Omega made energy-dependent per Commun Biol 2025.)
- Derivation: capture made self-sustaining like phase-separated postsynaptic condensates; consolidated synapses persist without decay, forgetting = noise-driven escape.
- Cites: Brangwynne, Hyman, Rosen (condensates, Citation Laureates 2025); local mitochondrial ATP papers 2025 supporting pi(e).
- Aleph 1: Tier 6 condensate capture SDE
- Changes: replaces A.2 capture equation.

### E6: Expansion representation dimension (participation ratio)
- Section: Checked maths, Expansion in-degree K*
- Tier: other
- Equation: PR(K) = (\Sigma\lambda)^2/\Sigma\lambda^2
- Symbols: n inputs, M cells each sampling K inputs, threshold to 10% coding level; lambda eigenvalues of odor/input covariance (of expansion representation).
- Derivation: numeric; PR peaks at K=4 (fly 69 glomeruli), K=5 (200 or 1,000 mossy fibres), 95% of peak by K=3.
- Cites: Litwin-Kumar et al. 2017.
- Aleph 1: none
- Changes: generalises Kenyon cells into expansion layer.

### E7: Energy-normalised expansion objective
- Section: same
- Tier: other
- Equation: PR(K)/(c_0 + K\cdot c_{syn}), with c_0/c_{syn} = 20
- Symbols: c_0 fixed per-cell cost; c_syn per-input cost.
- Derivation: charging each cell a fixed plus per-input cost; optimum K*=4 (fly), 2-3 (cerebellum). Predicts K ~ 3-5 in all species (matched: fly 4.4-5.4, vertebrates ~4).
- Cites: Litwin-Kumar 2017; Attwell-Laughlin.
- Aleph 1: none
- Changes: new.

### E8: Daily headroom balance
- Section: Checked maths, Sleep law
- Tier: 6
- Equation: s_w\cdot t_{wake} = s_s\cdot t_{sleep}
- Symbols: s_w wake fill rate proportional to mass-specific brain energy use B; s_s species-invariant SWS emptying rate.
- Derivation: assumption that wake potentiation fills headroom at rate prop. to B and SWS empties at invariant rate; daily cycle balances.
- Aleph 1: Tier 6 synaptic headroom / sleep pruning
- Changes: new.

### E9: Sleep law
- Section: same
- Tier: 6 (invariant-like scaling law)
- Equation: \frac{t_{sleep}}{t_{wake}} = \kappa B \quad\Rightarrow\quad t_{sleep} = 24\,\frac{\kappa B}{1+\kappa B}\ \text{h}
- Symbols: kappa = 1.63 (calibrated on rat); B mass-specific brain energy use (e.g. rat 0.68, macaque 0.36 umol glucose/min/g).
- Derivation: from E8 with s_w/s_s = kappa B and t_sleep + t_wake = 24 h. Predicts log-log slope 1; fitted 0.66 +/- 0.36 (r=0.67) across six mammals; macaque 8.9 h vs 11.1-11.8 h.
- Cites: Herculano-Houzel 2011; Siegel compilation; Hsieh 2008.
- Aleph 1: none direct
- Changes: new.

### E10: Zebrafish synapse relaxation and rate fit
- Section: Checked maths, Zebrafish synapse dynamics
- Tier: 6
- Equation: S(t) = S_{set} + \big(S_0 - S_{set}\big)e^{-kt},\qquad k = -\frac{1}{\Delta t}\ln\!\Big(1-\frac{L}{E}\Big)
- Symbols: S_0 initial count; L control-night loss = 6.28 synapses; Delta t = 5 h; E day excess = 1.65 synapses/h x 13 h = 21.4; k = 0.069 /h.
- Derivation: integrating E4 with u = 1 gives exponential relaxation.
- Cites: Suppermpool et al. 2024 (Ext Data Fig 8c).
- Aleph 1: Tier 6 sleep pruning
- Changes: new.

### E11: Recovery-sleep loss prediction
- Section: same
- Tier: 6
- Equation: -(21.4 + 13.0)(1 - e^{-6k}) = -11.7 \text{ synapses}
- Symbols: 13.0 synapses added by 4 h deprivation; 6 h recovery.
- Derivation: applying E10; measured -11.9.
- Aleph 1: Tier 6 sleep pruning
- Changes: new.

### E12: Kramers escape time
- Section: Checked maths, Forgetting as escape
- Tier: 6
- Equation: \tau = \tau_0\cdot e^{\Delta U/D} (rate 1/\tau)
- Symbols: tau_0 attempt time; Delta U barrier height, exponentially distributed with mean mu; D noise.
- Derivation: consolidated synapse leaves bistable state at Kramers rate.
- Cites: Kramers; classical counterpart of macroscopic tunnelling (Physics Nobel 2025).
- Aleph 1: Tier 6 condensate capture SDE
- Changes: replaces A.2 assumed lifetime distribution.

### E13: Power-law forgetting
- Section: same
- Tier: invariant
- Equation: P(t) = \mathbb{E}\big[e^{-t/\tau}\big] \simeq \Gamma\!\left(1+\tfrac{D}{\mu}\right)\left(\tfrac{t}{\tau_0}\right)^{-D/\mu}
- Symbols: P surviving fraction; exponent D/mu (noise over mean barrier).
- Derivation: average of e^{-t/tau} over exponential barrier distribution (steps not shown). Simulated 400,000 synapses: exponents 0.499 (pred 0.5), 0.250 (pred 0.25).
- Aleph 1: Tier 6 condensate capture (emergent)
- Changes: new.

### E14: Lateralisation threshold
- Section: Checked maths, Lateralisation threshold
- Tier: invariant
- Equation: x^* = a/(a + c),\quad \lambda = x^*(c - a); unstable iff c > a
- Symbols: a self-limitation; c cross-inhibition between two hemispheric populations; lambda antisymmetric eigenvalue.
- Derivation: linearisation of symmetric state (model equations not shown). Numerics: 1% bias decays at c=0.5, 0.9; grows to index 1.00 at c=1.1, 1.5.
- Cites: Kagan, Soai (Chemistry Nobel 2026) autocatalysis/nonlinear effects, shared mathematics.
- Aleph 1: none
- Changes: new.

### E15: Per-neuron cost law
- Section: Checked maths, Per-neuron cost across species
- Tier: 1/3 (energy budget)
- Equation: c_n = P_{rest} + \rho(c_{AP} + k\cdot c_{syn})
- Symbols: P_rest resting cost; rho firing rate; c_AP cost per spike; k synapses per neuron; c_syn per-synapse cost (Attwell-Laughlin values).
- Derivation: linear in k; k=6,000 vs 8,000 gives ratio 0.900 at equal rate (measured 0.81 whole-brain). Sustainable rate bands: rodent 3.8-8.1 Hz, macaque 4.3-9.1 Hz.
- Cites: Attwell & Laughlin 2001; Herculano-Houzel 2011.
- Aleph 1: inherited Tier 3 ATP balance / Tier 1 sodium debt ledger
- Changes: none stated (carried from A.2 sources).

### E16: Optogenetic Na+ debt steady state
- Section: Checked maths, Optogenetic energy ledger
- Tier: 1
- Equation: \nu\cdot r + \lambda = \Pi_{max}\cdot m(e)\cdot m(n)
- Symbols: nu Na+ per spike (load); r firing rate; lambda leak/added Na+ load (light current adds here) [as written; not further defined]; Pi_max max pump rate; m(e) ATP/energy dependence; m(n) Na+ dependence; n Na+ debt.
- Derivation: Na+ debt steady state; ChR2 adds Na+-loading current, if faster than ATP-limited pump, n rises and firing fails; light-driven Cl-/H+ pumps add no Na+, ATP rises. Predictions (model units, 120 s): ChR2 firing 16-31 Hz -> ~6 Hz, ATP 0.58 -> 0.17-0.33; pump silencing ATP 0.58 -> 0.83 (+42%).
- Cites: Deisseroth, Hegemann, Nagel (Medicine Nobel 2026).
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: optogenetic terms new in A.3; G_s written as function of leptin, ghrelin, GLP-1 (no explicit formula given).
