# Extraction: Model_A9_changes from a8.docx
- Model version(s) specified: Model A.9 (with explicit changes from Model A.8)
- One-paragraph summary of the file: A report titled "Generalized Pharmacodynamic Biophysical Framework: Formal Specification and Evaluation of Model A.9". It lists the A.8 limitations and the A.9 changes in four areas: (1) an ontogenetic scaling tensor for connectivity, plus angiogenesis driven by gestational time (Tier 6); (2) the Black-Leff operational model, Gq-PLC-IP3 and an intracellular Ca2+ state with a floating dendritic threshold (Tier 1); (3) a Stuart-Landau-type locus coeruleus NE oscillator driving vasomotion of radii, glymphatic flux, and the Peclet number (Tiers 2/6); (4) a pathological degradation tensor: AQP4 polarity leaky integrator and exponential decay of hydraulic conductivity (Tiers 2/6). It then gives qualitative evaluations (DHARANI, psychedelics, dexmedetomidine vs zolpidem, Alzheimer's). None of the equations is derived. Each one is stated, with a short motivation and a citation.
- Parts that could not be read (if any): none. All equation images were transcribed.

### E1: Ontogenetic connectivity tensor
- Section in source: 1. Ontogenetic Scaling and Spatial Topology (Tier 6 Update)
- Tier: 6
- Equation: $\frac{dW_{ij}}{dt_g} = \mathcal{M}_{ij}(t_g)\cdot\nabla\rho(x_i,t_g) + \eta(t_g)$
- Symbols: $W_{ij}$ structural connectivity matrix (fixed in A.8); $t_g$ gestational age; $\rho(x_i,t_g)$ cytoarchitectural cell density at spatial coordinate $x_i$; $\mathcal{M}_{ij}$ axon-guidance chemotactic gradient tensor; $\eta(t_g)$ stochastic developmental noise. The source also refers to the whole tensor as "Ontogenetic Scaling Tensor ($dW_{ij}/dt_g$)". A.8 used a static population scalar $N$.
- Derivation: none given. It is motivated by the claim that A.8's static $N$ and $W_{ij}$ crashed on gestational fetal data.
- Cites: DHARANI fetal atlas (ref 1); Allen developing human brain atlas (verification)
- Aleph 1: Tier 6 ontogenetic scaling tensor
- Changes: replaces A.8's static scalar $N$ and fixed $W_{ij}$ with time-dependent tensors.

### E2: Angiogenesis
- Section: 1
- Tier: 6 (vascular growth; touches Tier 2)
- Equation: $\frac{d\mathcal{E}}{dt_g} = \kappa_{angio}\sum_c\left(1-\frac{o_c}{o_{target}}\right)_+$
- Symbols: $\mathcal{E}$ vascular edges (set/count of new vascular edges); $\kappa_{angio}$ rate (undefined); $o_c$ oxygen in compartment/cell $c$ (not defined explicitly); $o_{target}$ target; $(\cdot)_+$ positive part
- Derivation: "driven by localized hypoxic demand". No other justification.
- Cites: none
- Aleph 1: Tier 6 ontogenetic scaling (angiogenesis component); otherwise none
- Changes: new in A.9

### E3: Black-Leff operational model
- Section: 2. Generalized Operational Pharmacodynamics and Gq Signaling (Tier 1 Update)
- Tier: 1
- Equation: $\frac{E}{E_{max}} = \frac{\tau[L]}{K_A+(\tau+1)[L]}$
- Symbols: $E/E_{max}$ fractional biological response; $[L]$ ligand concentration; $K_A$ equilibrium dissociation constant; $\tau$ intrinsic efficacy transducer ratio
- Derivation: none given. It is "Black-Leff Operational Model of Agonism"; occupancy translates into signaling "based purely on thermodynamic binding affinities".
- Cites: ref 5 (Frontiers Pharmacol 2019 receptor model)
- Aleph 1: inherited Tier 1 Black-Leff operational model
- Changes: replaces A.8's phenomenological scalars (e.g. global synaptic gain $G_s$)

### E4: K_A from binding free energy
- Section: 2
- Tier: 1
- Equation: $K_A = e^{-\Delta G/RT}$
- Symbols: $\Delta G$ binding free energy, $R$ gas constant, $T$ temperature (not defined in the text)
- Derivation: none. Stated with ref 5. Note: it is written exactly as $e^{-\Delta G/RT}$, with no reference concentration.
- Aleph 1: inherited Tier 1 Black-Leff
- Changes: new in A.9

### E5: PLC-driven IP3 production
- Section: 2
- Tier: 1
- Equation: $\frac{d[\mathrm{IP}_3]_i}{dt} = k_{PLC}\cdot\left(\frac{E}{E_{max}}\right) - \gamma_{IP3}[\mathrm{IP}_3]_i$
- Symbols: $k_{PLC}$ PLC production rate; $\gamma_{IP3}$ decay rate; $[\mathrm{IP}_3]_i$ intracellular IP3
- Derivation: "For 5-HT2A (Gq-coupled) agonists, this fractional response drives Phospholipase C (PLC) to produce IP3"
- Cites: ref 4 implicitly (PLC); none directly
- Aleph 1: inherited Tier 1 Gq-PLC-IP3-Ca2+ cascade
- Changes: A.8 "lacked intracellular second-messenger tracking"

### E6: Intracellular calcium
- Section: 2
- Tier: 1
- Equation: $\frac{d[\mathrm{Ca}^{2+}]_i}{dt} = -\gamma_{Ca}([\mathrm{Ca}^{2+}]_i - Ca_{rest}) + I_{VGCC}(v_d) + k_{IP3}\cdot[m(\mathrm{IP}_3)]^3\cdot h^3\cdot([\mathrm{Ca}^{2+}]_{ER}-[\mathrm{Ca}^{2+}]_i)$
- Symbols: $\gamma_{Ca}$ clearance; $Ca_{rest}$ resting Ca; $I_{VGCC}(v_d)$ voltage-gated Ca current at dendritic voltage $v_d$; $k_{IP3}$ IP3R flux constant; $m(\mathrm{IP}_3)$ IP3 activation gate; $h$ inactivation gate; $[\mathrm{Ca}^{2+}]_{ER}$ ER calcium. The source does not define $m$ and $h$ further.
- Derivation: "The resulting IP3 surge triggers calcium release from the ER, tracked by the newly introduced intracellular calcium state variable". No other justification. The $m^3h^3$ form is Li-Rinzel/De Young-Keizer-like, but the source does not name it.
- Aleph 1: inherited Tier 1 Gq-PLC-IP3-Ca2+ cascade
- Changes: newly introduced state variable in A.9

### E7: Floating dendritic threshold
- Section: 2
- Tier: 1 (feeds the Tier 6 plasticity / dendritic potential)
- Equation: $u_{th}(t) = u_{th,0} - \alpha_{Gq}\log(1+[\mathrm{IP}_3]_i)$
- Symbols: $u_{th}$ dendritic action-potential threshold; $u_{th,0}$ baseline; $\alpha_{Gq}$ coupling
- Derivation: "This dynamic calcium pool dictates the dendritic action potential threshold, generating the floating threshold required for structural plasticity". Note: the text says calcium, but the equation uses $[\mathrm{IP}_3]_i$.
- Cites: ref 9 (intracellular calcium stores, synapse-specific plasticity)
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: new in A.9

### E8: Locus coeruleus NE oscillator
- Section: 3. Locus Coeruleus Limit Cycles and Glymphatic Fluid Dynamics (Tier 2 & 6)
- Tier: 2
- Equation: $\frac{d\mathrm{NE}_{LC}}{dt} = f_{oscillator}(\mathrm{NE}_{LC}) - g_{GABA}([L_{GABA}])\cdot\mathrm{NE}_{LC} - g_{\alpha2}([L_{\alpha2}])\cdot\mathrm{NE}_{LC}$
- Symbols: $\mathrm{NE}_{LC}$ LC noradrenaline; $f_{oscillator}$ generic oscillator term (unspecified); $g_{GABA}$ generalized inhibitory input; $g_{\alpha2}$ autoreceptor input; both are functions of ligand concentration "determined by the Black-Leff equations above"
- Derivation: the LC is described as "a Stuart-Landau nonlinear oscillator", but the Stuart-Landau form is not written out. Evaluation: zolpidem "induced a Hopf bifurcation, collapsing the limit cycle"; dexmedetomidine preserves 0.01-0.1 Hz oscillations.
- Cites: ref 6 (Hauglund et al. 2025); refs 7, 26
- Aleph 1: Eq 5.7 Stuart-Landau LC oscillator
- Changes: replaces A.8's Boolean sleep gate (1 sleep / 0 wake)

### E9: NE-driven vasomotion of radii
- Section: 3
- Tier: 2
- Equation: $\tau_v\frac{dr_e}{dt} = \cdots - \kappa_{NE}\cdot\mathrm{NE}_{LC}(t)\cdot r_e$ (the "$\cdots$" is literal in the source; the other terms are omitted)
- Symbols: $r_e$ microvascular radius of edge $e$; $\tau_v$ vascular time constant; $\kappa_{NE}$ NE constriction coefficient
- Derivation: "This oscillating NE_LC physically pumps the microvascular radii"
- Cites: refs 6 and 11
- Aleph 1: inherited Tier 2 noradrenergic vasomotion
- Changes: new in A.9

### E10: Péclet number
- Section: 3
- Tier: 2/6
- Equation: $Pe = \frac{v\cdot L}{D}$ (inline)
- Symbols: $v$ fluid velocity; $L$ length and $D$ diffusivity (not defined in the text)
- Derivation: "Glymphatic advection is redefined via the dimensionless Péclet number"
- Cites: refs 12, 13
- Aleph 1: inherited Tier 2 perivascular flux and Peclet number
- Changes: replaces the Boolean clearance gate

### E11: Perivascular flow rate
- Section: 3
- Tier: 2/6
- Equation: $J_v(t) = \frac{1}{R_{PVS}}\int\left|\frac{\partial r_e(t)}{\partial t}\right|dt$
- Symbols: $J_v$ perivascular flow rate, from which $v$ is derived; $R_{PVS}$ perivascular resistance
- Derivation: "fluid velocity v is derived from the perivascular flow rate J_v". No other derivation. The conversion from $J_v$ to $v$ is not given.
- Aleph 1: inherited Tier 2 perivascular flux; Tier 6 glymphatic peristalsis
- Changes: new in A.9

### E12: AQP4 polarity index
- Section: 4. Pathological Degradation Tensor (Tier 2 & 6)
- Tier: 6
- Equation: $\tau_{path}\frac{dP_{AQP4}}{dt} = -k_{toxic}\cdot\mathcal{H}([\mathrm{Ca}^{2+}]_e - Ca_{thresh})\cdot\mathcal{F}_{inflam} + k_{recover}(1-P_{AQP4})$, with $P_{AQP4}\in[0,1]$
- Symbols: $P_{AQP4}$ AQP4 polarity index; $\tau_{path}$ time constant; $k_{toxic}$, $k_{recover}$ rates; $\mathcal{H}$ (Heaviside, not stated as such); $[\mathrm{Ca}^{2+}]_e$ extracellular Ca; $Ca_{thresh}$ threshold; $\mathcal{F}_{inflam}$ neuroinflammation
- Derivation: "acts as a leaky integrator driven by toxic solute accumulation (e.g., $C_{tau}$) and neuroinflammation". Note: the text names $C_{tau}$, but the equation uses a Heaviside function of extracellular Ca2+, not $C_{tau}$.
- Cites: refs 29, 32 (verification)
- Aleph 1: Tier 6 AQP4 polarity degradation
- Changes: A.8 assumed constant hydraulic resistance and diverged after 48 h+ of toxic buildup. A.9 adds this index together with an "apoptotic eviction protocol", which has no equation.

### E13: Hydraulic conductivity decay
- Section: 4
- Tier: 6 (Tier 2 coupling)
- Equation: $L_p(t) = L_{p,0}\cdot e^{\lambda(P_{AQP4}(t)-1)}$
- Symbols: $L_p$ trans-astrocytic hydraulic conductivity; $L_{p,0}$ baseline; $\lambda$ decay constant
- Derivation: "decays exponentially as polarization is lost, drastically increasing perivascular resistance $R_{PVS}$ and stalling the Péclet advective flow". The source does not give an explicit relation between $L_p$ and $R_{PVS}$.
- Aleph 1: Tier 6 AQP4 polarity degradation / Eq 5.11 hydraulic floor (A.9 has no floor)
- Changes: new in A.9
