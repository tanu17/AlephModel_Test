# Extraction: Model A.7 More scientific Doc (gemini).docx
- Model version(s) specified: Model A.7 (with a history of A.1-A.6 and a list of gaps for A.8)
- One-paragraph summary of the file: A short Gemini-written summary of Model A.7, "Three-Dimensional Neurovascular Integration". It states the governing equations briefly: somatic potential with K_ATP shunt and ephaptic term, active dendrite (dCaAP), sodium debt ledger with ATP pumping, part of the six-pool metabolism, AIS leaky controller and threshold, 3D microvascular flow (reflected OU radii, Hagen-Poiseuille), and the bistable condensate-capture SDE. It also gives a species parameter table, explanation modes (Kramers forgetting power law, Q10 scaling, expansion dimension PR(K)), blind validations, A.8 gaps, the A.1-A.7 change history and an annex. The annex has three short validations: forward invariance of the sodium ledger, [0,1] bounds of the capture variable, and Kirchhoff flow uniqueness. Many symbols are not defined, and the file gives no units.
- Parts that could not be read (if any): none. All 36 images were read. The Hagen-Poiseuille conductance and the Kirchhoff equations are named but never written as formulas.

### E1: Somatic membrane potential with K_ATP shunt and ephaptic coupling
- Section in source: 1, Governing Mathematical Equations, "Somatic and Dendritic Signaling"
- Tier: 1
- Equation (LaTeX, transcribed faithfully): \tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) + G_s\zeta(1-\nu_{ACh})\sum_j (s_j W_{ij} x_{ij} r_j) + g_{ax}((v_{d,i} - v_i) + (V_e(x_{d,i}) - V_e(x_{s,i})))
- Symbols as defined in the source: none defined explicitly. From context: g_K(a_i) is the ATP-dependent K_ATP shunting conductance; the V_e terms give the ephaptic coupling (extracellular potential at the dendritic and somatic positions); v_{d,i} is the dendritic potential.
- Derivation or justification given in the source: none given. The text only says the model "is modeled with a K_ATP shunting component and ephaptic coupling".
- Physical law / prior model / literature it cites: ref 1 (Model_A4 Scientific Report, gemini)
- Corresponding Aleph 1 equation: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes vs earlier model versions that the source mentions: Section 5 says A.5 "improperly used a uniform extracellular field". The ephaptic V_e(x) term is position-dependent here, but the file does not tie the change to this equation explicitly.

### E2: Active dendritic compartment (dCaAP)
- Section in source: 1, "Somatic and Dendritic Signaling"
- Tier: 1
- Equation: C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i} - E_L) + \bar{A}_{Ca}\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i} - E_{HCN}) - g_{ax}(v_{d,i} - v_i)
- Symbols: not defined. From context: \Delta(u_{d,i}) is the dCaAP activation function, which allows non-linear XOR logic; g_{HCN}(DA) is a dopamine-dependent HCN conductance.
- Derivation/justification: none given. The text only says it is a "dCaAP mechanism enabling non-linear XOR logic operations".
- Cited: ref 1
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: Section 5 says the active dendritic compartment for dCaAPs was added in A.5.

### E3: Intracellular sodium debt ledger
- Section in source: 1, "Intracellular Sodium Debt & ATP Pumping"
- Tier: 1
- Equation: \frac{dn_i}{dt} = [\nu_{spk} r_i + \nu_{syn} G_s \sum_j (W_{ij} x_{ij} r_j) + \lambda_n + \frac{I_{ChR2}}{F\cdot Vol_i}](1 - \frac{n_i}{n_{eq}}) - \Pi_i
- Symbols: n_i is the sodium load; I_{ChR2} is the optogenetic (channelrhodopsin) current; F is presumably Faraday's constant (not stated); n_{eq} is the equilibrium bound. Other symbols are not defined.
- Derivation/justification: the text says spiking and ChR2 stimulation "induce a sodium load, bounded dynamically". The annex (E18-E21) gives the forward-invariance argument.
- Cited: ref 4 (Model A.6 four-caveat revision, claude)
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: Annex says "Earlier iterations faced unbounded sodium inflation at zero ATP". A.7 adds the driving-force limit term (1 - n_i/n_eq).

### E4: Na+/K+ pump extrusion
- Section in source: 1, "Intracellular Sodium Debt & ATP Pumping"
- Tier: 1 (couples to Tier 3)
- Equation: \Pi_i = \Pi_{max}\, m(a_i, K_a)\, m(n_i, K_n)
- Symbols: m(\cdot,K) is not defined (presumably a saturating function); a_i is ATP.
- Derivation/justification: none given
- Cited: ref 4
- Aleph 1: inherited Tier 1 sodium debt ledger / Tier 3 ATP consumption
- Changes: none mentioned

### E5: Six-pool metabolism, ATP balance
- Section in source: 1, "Multi-Substrate Metabolism"
- Tier: 3
- Equation: \frac{da}{dt} = 2v_{gn} + Y_{ox} v_{ox} - D
- Symbols: the pools are glucose G, lactate L, glycogen \Gamma, pyruvate p, oxygen o and ATP a. v_{gn} is neuronal glycolysis, which is "redox-coupled directly to Na+/K+ pumping demand". Y_{ox}, v_{ox} and D are not defined.
- Derivation/justification: none given. The factor 2 is not explained.
- Cited: ref 4
- Aleph 1: Tier 3 six-pool metabolism (ATP balance)
- Changes: Section 5 says A.6 "pruned ad-hoc ATP approximations in favor of a full 6-pool multi-substrate metabolism".

### E6: Six-pool metabolism, glucose balance
- Section in source: 1, "Multi-Substrate Metabolism"
- Tier: 3
- Equation: \frac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn}
- Symbols: not defined. From context: J_G is glucose supply and v_{ga} is presumably astrocytic glycolysis. The text says glycogenolysis mobilizes during severe glucose depletion. The other four pool equations are not given.
- Derivation/justification: none given
- Cited: ref 4
- Aleph 1: Tier 3 six-pool metabolism / carbon balance
- Changes: same as E5

### E7: AIS length leaky controller
- Section in source: 1, "Axon Initial Segment (AIS) Plasticity"
- Tier: 4
- Equation: \tau_L \frac{dL_i}{dt} = -(L_i - L_0) - G_L L_0(\bar{c}_i - 1)
- Symbols: L_i is AIS length and x_i is AIS position. \bar{c}_i is not defined (Section 5 mentions "Ca2+ proxies").
- Derivation/justification: none given. The text calls it a "slow, leaky structural controller".
- Cited: ref 4
- Aleph 1: Tier 4 AIS tri-variable leaky controller (L component)
- Changes: Section 5 says A.6 "replaced random AIS heuristics with a robust controller tied to Ca2+ proxies". No equation for x or g_AIS is given.

### E8: AIS threshold law
- Section in source: 1, "Axon Initial Segment (AIS) Plasticity"
- Tier: 4
- Equation: \theta_{AIS,i} = -k_B \ln(\frac{L_i}{L_0}) - k_x \ln(\frac{x_i}{x_0})
- Symbols: not defined beyond L and x.
- Derivation/justification: none given
- Cited: ref 4
- Aleph 1: Tier 4 threshold law
- Changes: none mentioned

### E9: Reflected OU flow (or force) factor
- Section in source: 1, "3D Microvascular Fluid Dynamics"
- Tier: 2
- Equation: f_c = \frac{F_c}{F_{c,0}}
- Symbols: not defined. The text says radii "follow a reflected Ornstein-Uhlenbeck (ROU) process" and flow uses "Hagen-Poiseuille conductances on a 3D capillary graph".
- Derivation/justification: none given. The ROU SDE itself is not written out.
- Cited: ref 8 (MDPI blood-flow modelling, rat somatosensory cortex)
- Aleph 1: Tier 2 inherited Hagen-Poiseuille conductance / Eq 5.6 Kirchhoff balance (context)
- Changes: Section 5 says A.6 used a 2D capillary graph with Kirchhoff laws, and A.7 moved to a strict 3D murine angiome network in which flow recovery bottlenecks at 6-10 branches (instead of 3-4). Section 4 says A.8 will use a damped reflected OU process.

### E10: Effective radius modulated by extracellular field
- Section in source: 1, "3D Microvascular Fluid Dynamics"
- Tier: 2
- Equation: r_e = r_0(1 + \beta_c \bar{\psi}_e)
- Symbols: not defined. \bar{\psi}_e is unclear (possibly a mean vasoactive or field signal).
- Derivation/justification: none given
- Cited: ref 8
- Aleph 1: Tier 2 (vessel radius feeding the Hagen-Poiseuille conductance)
- Changes: none specific

### E11: Bistable condensate capture SDE (called "Eq. 33" in the annex)
- Section in source: 1, "Memory Formation & Bistable Condensate Capture"
- Tier: 6
- Equation: \tau_c \frac{dc_{ij}}{dt} = \Omega_{ij}\pi(a)(1 - c_{ij}) + \beta_c \frac{c_{ij}^2(1-c_{ij})}{K_c^2 + c_{ij}^2} - \gamma_c c_{ij} + \sigma_c c_{ij}(1-c_{ij}) dB_{ij}
- Symbols: c is the capture variable. \pi(a) is presumably an ATP gate ("energy-gated"). dB_{ij} is Brownian noise. Other symbols are not defined.
- Derivation/justification: the text calls it "a self-sustaining bistable state driven by noise-induced Kramers escapes". The bounds argument is in the annex (E22-E25).
- Cited: ref 1
- Aleph 1: Tier 6 condensate capture SDE
- Changes: Section 5 says A.1-A.4 "eviction net loss" was resolved by matching potentiation to eviction variables.

### E12: Kramers-escape forgetting law
- Section in source: 2, "Memory Escapes"
- Tier: invariant (emergent forgetting law)
- Equation: P(t) \simeq \Gamma(1 + \frac{D}{\mu})(\frac{t}{\tau_0})^{-D/\mu}
- Symbols: not defined
- Derivation/justification: the text says "Forgetting mathematically maps to noise-driven Kramers escape over a bistable barrier". No steps are given.
- Cited: ref 5 (Model A.3 Species-Resolved)
- Aleph 1: Tier 6 (consequence of the capture SDE)
- Changes: none

### E13: Avian dendritic arbor scaling parameter
- Section in source: 2, "Thermodynamic Efficiency"
- Tier: other (species parameter)
- Equation: k \approx 1,500
- Symbols: "morphological dendritic arbor scaling parameter"
- Derivation/justification: the text says changing only this parameter solves the Avian Glucose Paradox.
- Cited: ref 1
- Aleph 1: none (species parameter, Tier 6 ontogenetic scaling context)
- Changes: none

### E14: Q10 temperature scaling
- Section in source: 2, "Temperature Effects"
- Tier: other (applies to all tiers)
- Equation: Q_{10} multipliers derived from T_b (inline symbols only; no formula is written)
- Symbols: T_b is the species body temperature.
- Derivation/justification: "Temperature limits scale all temporal rate constants via Q_10 multipliers derived directly from the provided species body temperature".
- Cited: ref 5
- Aleph 1: none explicit (global temperature scaling)
- Changes: none

### E15: Expansion representation dimension
- Section in source: 2, "Optimal Expansion In-Degree"
- Tier: other (emergent)
- Equation: PR(K) (inline quantity only)
- Symbols: representation dimension (participation ratio) as a function of in-degree K
- Derivation/justification: the text says an optimum (K = 4 in Drosophila Kenyon cells) emerges computationally by maximizing PR(K) "over the cost matrix". No formula is given.
- Cited: ref 5
- Aleph 1: none
- Changes: none

### E16: Capillary parameter
- Section in source: 6, "Capillary Network Response"
- Tier: 2
- Equation: f_{\alpha\alpha} = 0.43
- Symbols: not defined ("for typical branches")
- Derivation/justification: none
- Cited: ref 3 (Microvascular architecture, PMC)
- Aleph 1: Tier 2 (context)
- Changes: none

### E17: Driving-force limit (sodium ledger)
- Section in source: 7, Annex, "Validation of Sodium Ledger Forward Invariance"
- Tier: 1
- Equation: dn/dt \propto (1 - \frac{n_i}{n_{eq}})
- Derivation/justification: the annex says the driving-force limit term "correctly enforces physical bounds".
- Cited: ref 4
- Aleph 1: inherited Tier 1 sodium ledger
- Changes: added in A.7 to fix unbounded sodium inflation at zero ATP

### E18-E21: Sodium ledger forward-invariance argument
- Section in source: 7, Annex
- Tier: invariant
- Equations: at n_i = n_{eq}, the influx factor is exactly 0 and extrusion \Pi \geq 0, which gives dn/dt \leq 0. This guarantees that [0, n_{eq}] is forward-invariant.
- Derivation/justification: the steps are as quoted. The conclusion is that this "mathematically preclud[es] runaway depolarization during absolute occlusion".
- Cited: ref 4
- Aleph 1: inherited Tier 1 sodium ledger (bound)
- Changes: as in E17

### E22-E25: Capture variable bounds
- Section in source: 7, Annex, "Validation of Capture Variable Bounds"
- Tier: invariant
- Equations: the drift vanishes at c = 0 and is negative (-\gamma_c) at c = 1. The diffusion multiplier \sigma_c c_{ij}(1-c_{ij}) is zero at both boundaries, so the variable stays in [0,1].
- Derivation/justification: "Because the diffusion multiplier ... mathematically zeroes out at both boundaries, noise cannot force the variable outside the physical [0,1] interval."
- Cited: ref 1
- Aleph 1: Tier 6 condensate capture SDE
- Changes: none

### E26: Kirchhoff flow uniqueness (stated without a formula)
- Section in source: 7, Annex
- Tier: invariant (Tier 2)
- Equation: no formula is written. The claim is that the graph Laplacian is symmetric positive definite, so the pressure solution is unique. Numerically, interior divergence is 1.2 x 10^-14.
- Derivation/justification: "The network graph Laplacian applied to the 3D vascular structure is structurally symmetric and positive definite", so it "guarantees unique pressure solutions and absolute mass conservation". Section 2 also says fluid redistribution "obeys Kirchhoff's laws across the localized symmetric positive-definite graph Laplacian".
- Cited: refs 3 and 4
- Aleph 1: Aleph Eq. 5.6 (Kirchhoff microvascular balance)
- Changes: 2D (A.6) changed to 3D (A.7)
