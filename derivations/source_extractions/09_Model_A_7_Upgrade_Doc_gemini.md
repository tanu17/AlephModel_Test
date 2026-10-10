# Extraction: Model A.7 Upgrade Doc (gemini).docx
- Model version(s) specified: A.7 (upgrade from A.6; also lists remediation targets for A.8)
- One-paragraph summary of the file: A narrative report (Gemini-written) describing the A.6 -> A.7 transition. It says A.7 replaces the 2D Voronoi vascular mesh with a 3D hierarchical microvascular graph (Hagen-Poiseuille segments, graph Laplacian/Kirchhoff, Fahraeus-Lindqvist apparent viscosity, reflected Ornstein-Uhlenbeck vessel radii). It removes "phenomenological bloat": dual-sigmoid glycogenolysis becomes competitive mass-action with glucose allosteric inhibition; ANLS becomes direct neuronal glycolysis/LDH redox coupling; a PCr buffer is added; the sleep product gate becomes ATP/ADP plus ROS-leak driven downscaling; the logarithmic AIS threshold shift becomes 1D cable theory (input resistance, Nav1.6 density). It also covers sodium-ledger forward invariance through a driving-force (Nernst) multiplier, a condensate-capture SDE (Kramers escape), a two-compartment ephaptic field, an SPD Laplacian, carbon/oxygen ledger closure, six-species double-blind validation, fast ripples from PV depolarization block, optogenetic Na+ ledger costs and BOLD/fNIRS forward modeling. The file writes NO equations explicitly. Every mechanism is described in prose. The only mathematical content is 9 small inline images holding numbers or symbols.
- Parts that could not be read (if any): none. All 9 images were read: image1 = \mu, image2 = I_h, image3 = 2.63, image4 = -3, image5 = -2, image6 = 0.43, image7 = -4, image8 = 0.37, image9 = 2.45.

### E1: Parameter-reduction table (numeric relations)
- Section in source: Sec. 2 table (after 2.3)
- Tier: other
- Equation (LaTeX): Glycogenolysis $-4$ parameters; Sleep Gating $-3$; AIS Excitability $-2$; Lactate Shuttle $-3$; Glymphatic Flow $-2$
- Symbols as defined in the source: parameter-count changes, A.6 -> A.7
- Derivation or justification given in the source: the source says each change follows from replacing a fitted construct with a mechanism: dual sigmoids -> competitive mass-action inhibition; product gate -> thermodynamic ATP/ADP & ROS leak; log threshold shift -> cable impedance & conductance; multi-compartment tuning -> direct neuronal redox coupling; fitted oscillators -> interstitial pressure gradients. It does not show how the counts were derived.
- Physical law / prior model / literature it cites: A.6 caveat doc [1]; Peredox/Laconic biosensors [8-11]; cable theory [12]
- Corresponding Aleph 1 equation: Tier 3 (glycogen, lactate), Tier 4 (AIS), Tier 6 (sleep pruning, glymphatic)
- Changes vs earlier model versions that the source mentions: as listed in the table

### E2: Normalized network self-influence of a capillary branch
- Section in source: 3.2
- Tier: 2
- Equation (LaTeX): $\text{self-influence} \approx 0.43$
- Symbols as defined in the source: normalized network self-influence for a typical capillary branch (dimensionless)
- Derivation or justification given in the source: "Analytical calculations on 3D biological networks". The source gives a consequence: a 10% local dilation gives a 46% conductance increase (consistent with $r^4$ Poiseuille scaling; this is implied, not stated) but only a 22% flow increase, which matches RBC-resolved simulations. No formula is shown.
- Physical law / prior model / literature it cites: Ji et al. 2026 PNAS [15]; Hagen-Poiseuille; Kirchhoff via graph Laplacian
- Corresponding Aleph 1 equation: Aleph Eq. 5.6 Kirchhoff microvascular balance / inherited Hagen-Poiseuille conductance
- Changes vs earlier model versions that the source mentions: 3D topology replaces 2D Voronoi mesh

### E3: Flow-to-oxygen coupling ratio
- Section in source: 3.2
- Tier: 2
- Equation (LaTeX): A.6: $0.37$; in vivo range: $2.45$ to $2.63$ (A.7 is claimed to fall in this range)
- Symbols as defined in the source: flow-to-oxygen (CBF/CMRO2) coupling ratio
- Derivation or justification given in the source: the source says the 3D topology "naturally bottlenecks supply through hierarchical branching", and that flow controllers at the inflow branches of diverging nodes guarantee local downstream flow increase. No formula is given.
- Physical law / prior model / literature it cites: [1], [5]
- Corresponding Aleph 1 equation: Aleph Eq. 5.6 (emergent output)
- Changes vs earlier model versions that the source mentions: the A.6 value of 0.37 is called erroneous

### E4: HCN current symbol
- Section in source: 5.5
- Tier: 1
- Equation (LaTeX): $I_h$
- Symbols as defined in the source: current through HCN channels. The source says D1 -> cAMP -> PKA modulates it, and the dual mechanism gives the dopamine inverted-U.
- Derivation or justification given in the source: qualitative only. It says D1 enhancement dominates at low concentration and HCN shunting at high concentration. No equation.
- Physical law / prior model / literature it cites: [20] (Guanfacine/HCN)
- Corresponding Aleph 1 equation: none directly (inherited Tier 1 neuromodulation / Black-Leff operational model, closest)
- Changes vs earlier model versions that the source mentions: replaces A.6's single monotonic shunt

### E5: Human glucose consumption rate (unit symbol)
- Section in source: 5.6
- Tier: other
- Equation (LaTeX): predicted $281\ \mu\text{mol/min}$ vs measured $280\ \mu\text{mol/min}$
- Symbols as defined in the source: $\mu$ = micro prefix; 20 W budget, 86.1B neurons, gyrification index 2.56
- Derivation or justification given in the source: "Processing this budget against the massive Na+/K+ pumping requirements". No formula.
- Physical law / prior model / literature it cites: A.4 report [2]
- Corresponding Aleph 1 equation: none (validation output; Tier 3 ledger)
- Changes vs earlier model versions that the source mentions: none

## Prose-only mechanisms (no equation written in source; recorded for coverage)
- Sodium ledger forward invariance (Sec. 4): a driving-force multiplier sends dNa/dt to 0 as [Na]_i approaches the Nernst limit. The source claims this proves forward invariance (invariant). It maps to the inherited Tier 1 sodium debt ledger.
- Condensate capture SDE (Sec. 4): Kramers escape over a bistable barrier. Drift and diffusion vanish at the boundaries, and survival follows a power law in noise/barrier. Maps to Tier 6 condensate capture SDE.
- Two-compartment ephaptic field (Sec. 4): a uniform field gives zero perturbation; a gradient polarizes the two compartments oppositely. Tier 1 (dendritic potential).
- SPD graph Laplacian giving a unique pressure solution and mass conservation (Sec. 4): invariant, maps to Eq. 5.6.
- Carbon/oxygen ledger closure (Sec. 4): invariant, maps to Tier 3 carbon balance.
- PCr equilibrium buffer and glycogen phosphorylase mass-action with glucose inhibition (Sec. 2.1): Tier 3. A 3:1 glucose:oxygen increment ratio is claimed.
- Fahraeus-Lindqvist viscosity and reflected OU vessel radii (Sec. 3.1): Tier 2.
- Validation numbers (Sec. 5 table): K=4 vs 4.4-5.4; 11.7 vs 11.9 synapses; 0.38x surface scalar giving 0.34x vs 0.32x glucose; reciprocity 1.39x vs 1.37x; rate band 3.6-7.9 Hz vs 4.2 Hz; 18.5 ms delays giving 4-7 wave packets.
