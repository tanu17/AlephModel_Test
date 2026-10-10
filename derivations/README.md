# Aleph 1 (Model A.10.1): step-by-step derivations, Tiers 1-6

## What this is

This directory reconstructs, step by step, the derivations of every equation in Tiers 1-6 of **Aleph 1 (Model A.10.1)**. The original derivations were lost. They are rebuilt here from the Model A series documents (Model A precursor, A.2 to A.10, the Aleph 1 reports, the A.8 Lean files and the GPT derivation audit), with standard physics, chemistry and mathematics filling the steps that no source contains.

Aleph 1 prints only 13 numbered equations (Eqs. 4.1, 4.2 and 5.1-5.11) and a list of conservation-law statements (Sec. 3). Its Sec. 2 lineage table declares many more components active. Each of those is taken from the most recent source that writes it out (A.10, then A.9, then A.8, and back to A.5 where later versions only name a term). The resulting work list has **84 equations**; 4 of them are claimed by Aleph but written in no source at all.

| File | Contents |
|---|---|
| [`00_Equation_Inventory.md`](00_Equation_Inventory.md) | Master equation list: canonical form, symbols, version lineage, surviving derivation material and derivation plan for every key |
| [`Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md`](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | T1.1-T1.21: somatic and dendritic potentials, receptor pharmacology, Na$^+$ ledger, rate law |
| [`Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md`](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | T2.1-T2.17: vascular network, radius control, LC oscillator, photothermal and stall operators, perivascular transport |
| [`Tier3_Substrate_Metabolism.md`](Tier3_Substrate_Metabolism.md) | T3.1-T3.14: substrate pools, ATP balance and demand, transport and enzyme fluxes, claimed PCr, ROS and lactate couplings |
| [`Tier4_AIS_Plasticity_Controller.md`](Tier4_AIS_Plasticity_Controller.md) | T4.1-T4.5: axon initial segment proxy, controllers and threshold law, plus a closed-loop analysis with T1.21 |
| [`Tier5_CA1_Spiking_Network.md`](Tier5_CA1_Spiking_Network.md) | T5.1-T5.6: CA1 spiking layer, Ca$^{2+}$ depletion, PV block, per-spike Na$^+$ load, node eviction |
| [`Tier6_Plasticity_Epigenetics_and_Degradation.md`](Tier6_Plasticity_Epigenetics_and_Degradation.md) | T6.1-T6.21: weights and headroom, capture and forgetting, sleep, development, AQP4, epigenetics, TrkB |
| [`Model_Aleph_1_Step_by_Step_Derivations.docx`](Model_Aleph_1_Step_by_Step_Derivations.docx) | This README plus Tiers 1-6 combined into one Word document with native Word equations |
| [`Model_Aleph_1_Step_by_Step_Derivations.pdf`](Model_Aleph_1_Step_by_Step_Derivations.pdf) | The same combined document as a PDF (about 220 A4 pages) |
| [`source_extractions/`](source_extractions/) | One file per source document: every equation it contains and the derivation text it gives, as extracted by the reader agents (cited as X01-X23 in the inventory) |

Each tier file opens with an overview of the tier's couplings, its symbol clashes and the parameter values the sources state, and closes with a status summary table.

## How each derivation is structured

Every entry follows the same template.

1. **Heading.** Key, name and Aleph label (see below).
2. **Equation as stated.** The equation is quoted from Aleph 1 or from the latest source that writes it, with the source named. Printed defects (truncations, literal ellipses, missing factors) are kept as printed and flagged, not silently repaired.
3. **Symbols and units.** A table of every symbol, its meaning and the units the equation requires. Units the sources do not state are marked "implied" or "required".
4. **Physical starting point.** The law or theory the equation rests on (charge conservation, mass action, Navier-Stokes, radiative transfer, Kramers theory, and so on), followed by numbered assumptions A1, A2, ...
5. **Derivation.** Numbered steps. Each step does one thing and names the assumption it uses.
6. **Result.** Whether the derivation reproduces the printed equation, what differs, and a corrected form where the printed one is wrong.
7. **Checks.** Dimensions, limiting cases, signs, positivity or invariance, steady states, and numerical checks against source values.
8. **Lineage.** The equation's history through the Model A versions, with file names.
9. **Derivation status.** One of the four labels below, with the approximations or gaps listed.

### The four status labels

| Label | Meaning |
|---|---|
| **Exact** | The equation follows with no further approximation from a stated physical law or idealization, or it is a definition or algebraic identity. Example: Hagen-Poiseuille for steady laminar Newtonian flow in a rigid tube (T2.7); the carbon identity (T3.4). |
| **Derived under approximations** | The equation follows from a physical law, but only through named approximations (linearization, quasi-steady state, mean field, diffusion approximation, weak noise, lumped compartments). Every approximation is listed in the status line. |
| **Phenomenological closure** | The functional form is a modelling choice. No first-principles derivation exists and none is invented. The entry states the motivation and the evidence the sources offer, and derives the exact properties the form has (bounds, steady states, stability, limits). Where a mechanistic reading is possible it is labelled "Reconstructed". |
| **Incomplete in source** | The equation cannot be derived or evaluated as printed: it is truncated, contains a literal ellipsis, uses undefined terms, is dimensionally inconsistent, or is not written in any source at all. The missing parts are supplied as labelled proposals. |

Many entries carry a primary label plus a qualifier, for example "Phenomenological closure (barrier exact)" or "Derived under approximations; incomplete in source". The primary label is the first one; the qualifier names the part of the equation it applies to.

## Notation conventions

- **Keys.** T*t*.*n*, where *t* is the tier (1-6) and *n* the entry number. Cross-references read "T2.16, Step 9" (entry T2.16, derivation step 9).
- **Aleph labels.** "Aleph Eq. *x*" means the equation is printed in Aleph 1. "inherited: *source*" names the version and equation that supplies the canonical form. "claimed: ..." marks a component that Aleph says is active but that no source writes as an equation.
- **Provenance labels inside the derivations.**
    - *Reconstructed*: a derivation step or form that no source contains, built from a named standard result.
    - *Proposal*: a form, closure or repair that no source states.
    - *Computed here*: a number obtained in this work by evaluating the source equations with source parameter values. It is not a source claim.
    - *Illustrative*: a number that uses textbook magnitudes or illustrative parameters, never presented as a model parameter.
- **Units.** SI unless a source value is quoted. Voltages in mV, concentrations in mM (A.6 equates mM with µmol/g), times in the unit the source uses (ms for spiking, s for metabolism, h for AIS and sleep, d for epigenetics). "Normalized form" means an equation divided by a leak conductance, so that conductances are dimensionless and every term is in mV.
- **Signs.** Membrane ionic currents are positive outward and enter a current balance with a minus sign. Synaptic, injected, axial and gap-junction currents are written as inward sources.
- **Shorthand functions.** $m(z,K) = z/(z+K)$; $\sigma(x) = 1/(1+e^{-x})$, so $1/(1+e^{x}) = 1-\sigma(x)$; $(x)_+ = \max(x,0)$; $\mathcal H$ is the Heaviside step.
- **Math formatting.** GitHub-flavoured Markdown. Inline math sits between single dollar signs; display math sits between double-dollar delimiters, each on its own line. There are no equation tags or labels, no alignment environments and no custom macros, so every display block holds one relation (or a few separated by commas).

### Symbol clashes carried through the files

The sources reuse many symbols. The derivations keep the source notation and flag each clash where it matters.

| Symbol | Meanings |
|---|---|
| $\tau_v$ | membrane time constant (T1.1); vascular time constant (T2.10, $\tau_a$ in T2.9) |
| $\tau_c$, $c$ | AIS Ca$^{2+}$ proxy (T4.1); capture time constant and variable (T6.8) |
| $\tau_w$ | adaptation (T1.8); weight plasticity (T6.4) |
| $\beta_c$ | capillary dilation gain (T2.14); capture self-recruitment (T6.8) |
| $n_c$ | critical Na$^+$ load (T1.20); node neural activity (T2.1) |
| $K_A$ | K_ATP half-inhibition (T1.6); Black-Leff dissociation constant (T1.13) |
| $\psi$ | salience gate (T6.4, T6.6); pericyte state (T2.14) |
| $\Pi$, $\Pi_Q$ | pump flux (T1.19, T6.14); potentiation drive of a territory (T6.6) |
| $\pi$, $\pi_R$ | capture energy gate (T6.9); REM pruning strength (T6.15) |
| $\theta$ | thresholds (T1.20, T1.21, T4.5); ADP feedback $\theta(a)$ (T3.7, T3.10) |
| $\Phi$ | rate sigmoid (T1.20); optical fluence rate (T2.6); conducted hyperpolarization (T2.11) |
| $k_{th}$ | thermal conductivity (T2.3); K$^+$ threshold (T2.12) |
| $\rho$, $\lambda$, $\eta$, $u$, $L$, $x$ | each used for several unrelated quantities (see the tier overviews) |

## Master table of equations

Status counts by primary label: **Exact 12**, **Derived under approximations 22**, **Phenomenological closure 41**, **Incomplete in source 9** (total 84). A further 15 entries carry an "incomplete in source" qualifier on part of the equation. Four entries (T3.12, T3.13, T3.14, T5.4) are not stated in any source.

| Key | Equation | Aleph label | File | Status |
|---|---|---|---|---|
| T1.1 | Somatic membrane potential with K_ATP metabolic brake | Aleph Eq. 5.1 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.2 | Woodhull voltage-dependent NMDA open-channel block | Aleph Eq. 5.2 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.3 | Vectorized Hall-Ehlert GABA_A allosteric ternary-complex law | Aleph Eq. 5.3 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Incomplete in source |
| T1.4 | Connexin-36 gap-junction current (graph Laplacian) | Aleph Eq. 5.4 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Exact |
| T1.5 | Competitive monoamine transporter reuptake ledger | Aleph Eq. 5.5 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.6 | K_ATP conductance law | inherited: A.8 Tier 1 inline ($g_K(a_i)$ in Eq. 5.1) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.7 | Axial plus ephaptic soma-dendrite current | inherited: A.8 PDF Eq. (2) ($I_{ax,i}$ in Eq. 5.1) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Exact |
| T1.8 | Spike-frequency adaptation variable | inherited: A.8 Tier 1 inline ($w_i$ in Eq. 5.1) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.9 | Tsodyks-Markram presynaptic resource $x_{ij}$ | inherited: A.5 Eq. 16 ($x_{ij}$ in Eq. 5.1) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.10 | Active dendritic membrane potential | inherited: A.10 Eq. 1.2 / A.8 PDF Eq. (3) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations; incomplete in source |
| T1.11 | Dendritic Ca$^{2+}$ action potential (dCaAP) activation | inherited: A.8 PDF Eq. (4) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.12 | D1 dopamine inverted-U pair (HCN shunt, non-preferred suppression) | inherited: A.8 Tier 1 inline / A.10 Eq. 1.2 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.13 | Black-Leff operational model with $K_A$ from binding free energy | inherited: A.9 (Aleph lineage table) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Exact (operational model); $K_A$ relation incomplete |
| T1.14 | Receptor internalization and tachyphylaxis | inherited: A.10 Eq. 1.5 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.15 | Gq-biased PLC to IP3 generation | inherited: A.10 Eq. 1.6 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.16 | Intracellular Ca$^{2+}$ with IP3-receptor ER release | inherited: A.9 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Incomplete in source |
| T1.17 | Floating dCaAP threshold | inherited: A.9 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T1.18 | Intracellular Na$^+$ debt ledger with driving-force saturation | inherited: A.8 PDF Eq. (5) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.19 | Na$^+$/K$^+$-ATPase pump rate | inherited: A.8 PDF Eq. (6) | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Derived under approximations |
| T1.20 | Firing-rate transfer function with Na-gradient failure gate | inherited: A.8 Tier 1 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure; incomplete in source |
| T1.21 | Energy-aware fast homeostatic threshold | inherited: A.8 Tier 1 inline; $\chi$ from A.7 annex Eq. 31 | [Tier 1](Tier1_Membrane_Electrophysiology_and_Pharmacodynamics.md) | Phenomenological closure |
| T2.1 | 3D Kirchhoff node balance with linear neurovascular source | Aleph Eq. 5.6 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Derived under approximations |
| T2.2 | Stuart-Landau locus coeruleus limit cycle | Aleph Eq. 5.7 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Derived under approximations |
| T2.3 | Pennes bioheat equation with optical source | Aleph Eq. 5.8 (first relation) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Derived under approximations |
| T2.4 | Photothermal vessel dilation | Aleph Eq. 5.8 (second relation) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure |
| T2.5 | Capillary stall probability and conductance switch | Aleph Eq. 5.9 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure |
| T2.6 | Optical heat deposition (radiative transport, Beer-Lambert) | Aleph Eq. 4.2 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Derived under approximations |
| T2.7 | Hagen-Poiseuille edge conductance | inherited: Aleph Sec. 3 / A.8 Tier 2 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Exact |
| T2.8 | Poiseuille wall shear stress | inherited: Aleph Sec. 3 (used in Eq. 5.9) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Exact |
| T2.9 | Dual-pathway arteriole dilation (NsMJ, Kir2.1, A2B, capillary signal) | inherited: A.8 PDF Eq. (8) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure; incomplete in source (inputs) |
| T2.10 | Noradrenergic vasomotion coupled to the LC oscillator | inherited: A.10 Eq. 2.2 (A.9) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Incomplete in source |
| T2.11 | Kir2.1 conducted hyperpolarization kernel | inherited: A.8 Tier 2 (Pathway 2a) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure |
| T2.12 | Kir2.1 extracellular-K$^+$ source term | inherited: A.7 annex Eq. 11 / A.6 Eq. 11 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure |
| T2.13 | Extracellular K$^+$ with glial clearance and glymphatic washout | inherited: A.5 Eq. 13 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure |
| T2.14 | Pericyte state and capillary radius | inherited: A.8 Tier 2 inline | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Phenomenological closure; reflected OU process incomplete in source |
| T2.15 | Normalized node flow | inherited: A.6/A.7 Eq. 10 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Exact |
| T2.16 | Perivascular flux driven by vessel-wall motion | inherited: A.10 Eq. 2.3 (A.9) | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Incomplete in source |
| T2.17 | Péclet number | inherited: Aleph Sec. 3 / A.10 Eq. 2.3 | [Tier 2](Tier2_Microvascular_Fluid_Mechanics_and_Thermal.md) | Exact |
| T3.1 | Substrate pool balances ($G$, $L$, $\Gamma$, $p$, $o$) | inherited: A.8 PDF Eqs. (9)-(11) | [Tier 3](Tier3_Substrate_Metabolism.md) | Derived under approximations |
| T3.2 | Neuronal ATP balance with CK term | inherited: A.10 Eq. 3.1 / A.8 PDF Eq. (12) | [Tier 3](Tier3_Substrate_Metabolism.md) | Derived under approximations |
| T3.3 | ATP demand | inherited: A.6 Eq. 24 / A.7 annex Eq. 24 | [Tier 3](Tier3_Substrate_Metabolism.md) | Phenomenological closure |
| T3.4 | Exact carbon mass balance | inherited: Aleph Sec. 3 ("First Law") / A.8 Tier 3 | [Tier 3](Tier3_Substrate_Metabolism.md) | Exact |
| T3.5 | GLUT1 glucose transport with capillary recruitment | inherited: A.8 PDF Eq. (9) | [Tier 3](Tier3_Substrate_Metabolism.md) | Derived under approximations |
| T3.6 | O$_2$ delivery with Buxton extraction | inherited: A.8 Tier 3 | [Tier 3](Tier3_Substrate_Metabolism.md) | Derived under approximations |
| T3.7 | Pump-coupled neuronal glycolysis with ADP feedback | inherited: A.8 Tier 3 | [Tier 3](Tier3_Substrate_Metabolism.md) | Phenomenological closure |
| T3.8 | Astrocytic glycolysis coupled to glutamate uptake | inherited: A.8 Tier 3 | [Tier 3](Tier3_Substrate_Metabolism.md) | Phenomenological closure |
| T3.9 | Glycogen synthesis and glycogenolysis | inherited: A.8 Tier 3 ($v_{syn}$) / A.7 annex Eq. 21 ($v_{gly}$) | [Tier 3](Tier3_Substrate_Metabolism.md) | Phenomenological closure |
| T3.10 | Oxidative phosphorylation flux | inherited: A.8 Tier 3 | [Tier 3](Tier3_Substrate_Metabolism.md) | Phenomenological closure |
| T3.11 | LDH/MCT exchange and lactate washout | inherited: A.7 annex Eq. 22 / A.6 Eq. 22 | [Tier 3](Tier3_Substrate_Metabolism.md) | Derived under approximations |
| T3.12 | Phosphocreatine/creatine dynamics | claimed: Aleph lineage table (CK buffer) | [Tier 3](Tier3_Substrate_Metabolism.md) | Incomplete in source (not stated anywhere) |
| T3.13 | OXPHOS-ROS coupling | claimed: Aleph lineage table (A.9) | [Tier 3](Tier3_Substrate_Metabolism.md) | Incomplete in source (not stated anywhere) |
| T3.14 | Astrocytic lactate to pericyte dilation coupling | claimed: Aleph lineage table (A.10.1) | [Tier 3](Tier3_Substrate_Metabolism.md) | Incomplete in source (not stated anywhere) |
| T4.1 | Slow Ca$^{2+}$/activity proxy | inherited: A.8 PDF Eq. (13) | [Tier 4](Tier4_AIS_Plasticity_Controller.md) | Phenomenological closure; incomplete in source |
| T4.2 | AIS length leaky controller (developmental baseline) | inherited: A.10 Eq. 4.1 / A.8 PDF Eq. (13) | [Tier 4](Tier4_AIS_Plasticity_Controller.md) | Phenomenological closure |
| T4.3 | AIS position leaky controller | inherited: A.8 PDF Eq. (14) | [Tier 4](Tier4_AIS_Plasticity_Controller.md) | Phenomenological closure |
| T4.4 | AIS Na-channel density leaky controller | inherited: A.8 PDF Eq. (14) | [Tier 4](Tier4_AIS_Plasticity_Controller.md) | Phenomenological closure; incomplete in source |
| T4.5 | AIS threshold law | inherited: A.10 Eq. 4.1 / A.8 PDF Eq. (15) | [Tier 4](Tier4_AIS_Plasticity_Controller.md) | Derived under approximations |
| T5.1 | CA1 conductance-based LIF membrane with noise | inherited: A.8 Tier 5 | [Tier 5](Tier5_CA1_Spiking_Network.md) | Derived under approximations; incomplete in source |
| T5.2 | Exponential synaptic conductances | inherited: A.8 Tier 5 | [Tier 5](Tier5_CA1_Spiking_Network.md) | Derived under approximations |
| T5.3 | Extracellular Ca$^{2+}$ depletion truncating fast ripples | inherited: A.8 PDF Eq. (16) | [Tier 5](Tier5_CA1_Spiking_Network.md) | Incomplete in source |
| T5.4 | PV interneuron depolarization block rule | claimed: Aleph lineage table (A.8) | [Tier 5](Tier5_CA1_Spiking_Network.md) | Incomplete in source (not stated anywhere) |
| T5.5 | Per-spike Na$^+$ load | inherited: A.7 annex Eq. 30 / A.6 Eq. 30 | [Tier 5](Tier5_CA1_Spiking_Network.md) | Derived under approximations |
| T5.6 | Apoptotic node eviction rule | inherited: Aleph lineage table (A.9) | [Tier 5](Tier5_CA1_Spiking_Network.md) | Phenomenological closure (event rule); incomplete in source |
| T6.1 | Epigenetic HDAC operator and BDNF silencing | Aleph Eq. 5.10 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure; incomplete in source |
| T6.2 | Regularized hydraulic floor for AQP4-dependent conductivity | Aleph Eq. 5.11 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure (bounds exact) |
| T6.3 | Glucocorticoid-receptor stress integration rate | Aleph Eq. 4.1 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Derived under approximations |
| T6.4 | Three-factor weight dynamics with headroom gate and eviction | inherited: A.8 PDF Eq. (17) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure (barrier exact) |
| T6.5 | Vascular metabolic headroom | inherited: A.8 Tier 6 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Exact (definition); invariance incomplete in source |
| T6.6 | Headroom supply gate and eviction allocation | inherited: A.5 Eqs. 18-19 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Exact (barrier construction) |
| T6.7 | Synaptic tag and persistence | inherited: A.7 annex Eq. 34 / A.8 Tier 6 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.8 | Energy-gated bistable capture SDE | inherited: A.8 PDF Eq. (18) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure (invariance exact) |
| T6.9 | Capture energy gate | inherited: A.5 Eq. 22 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.10 | Kramers-escape power-law forgetting | inherited: Aleph Sec. 3 / A.8 Tier 6 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Derived under approximations |
| T6.11 | Wake accumulation and circadian-gated sleep downscaling | inherited: A.8 PDF Eq. (19) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Exact (closed form); model phenomenological |
| T6.12 | Adenosine/noradrenaline product sleep gate | inherited: A.8 Tier 6 (unnumbered) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.13 | Pre-dawn circadian pruning switch | inherited: A.8 PDF Eq. (20) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure; incomplete in source |
| T6.14 | Interstitial adenosine dynamics | inherited: A.7 annex Eq. 36 / A.6 Eq. 36 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure; incomplete in source |
| T6.15 | REM weight jump with headroom projection | inherited: A.8 Tier 6 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Exact (projection); map phenomenological |
| T6.16 | Glymphatic peristalsis velocity | inherited: A.8 Tier 6 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.17 | Ontogenetic scaling tensor | inherited: A.9 (Aleph lineage table) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure; incomplete in source |
| T6.18 | Hypoxia-driven angiogenesis | inherited: A.9 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.19 | AQP4 polarity degradation | inherited: A.9 (Aleph lineage table) | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure; incomplete in source |
| T6.20 | TrkB neurotrophic phosphorylation | inherited: A.10 Eq. 6.1 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |
| T6.21 | Structural synaptic set-point remodeling | inherited: A.10 Eq. 6.2 | [Tier 6](Tier6_Plasticity_Epigenetics_and_Degradation.md) | Phenomenological closure |

## Errors and gaps found in Aleph 1 as printed

Each item names the defect and where the derivation supplies the corrected or completed form.

### Printed equations (Aleph Eqs. 4.1, 4.2 and 5.1-5.11)

1. **Eq. 5.1, somatic potential (T1.1).** The equation is in a normalized form (divided by the leak conductance) that no source declares, and Aleph defines none of its symbols. $G_s$ must be an integrated PSP area per spike (mV s), not the "conductance" A.8 calls it. $I_i(t)$ is undefined and can share the gain $G_s$ only if it is a rate. Synapses are current-based while the K$^+$ terms are conductance-based. The K_ATP brake drives $v$ toward, but never to, $E_K$. Physical-units form: T1.1 Result.
2. **Eq. 5.2, NMDA block (T1.2).** Named a "trap law", but it is the Woodhull equilibrium availability factor with no trapping kinetics. $\delta_{Mg}$ is a concentration (Jahr-Stevens), not an electrical depth. There is no glutamate gating. The current is outward-positive, yet the dendritic equation adds it as an inward source, so NMDA activation would hyperpolarize. Derivation and caveats: T1.2; sign repair: T1.10 Result (ii).
3. **Eq. 5.3, GABA_A allosteric law (T1.3).** The term $\tau_s\cdot(\ldots)$ is truncated in both Aleph files. The numerator lacks $\tau_s$, so the maximal response is $1/(1+\tau_s)$, which falls as efficacy rises, and the law does not reduce to Black-Leff at $[B]=0$. $\beta_s$, $f_s(x)$ and $x$ are undefined, and the coupling to $I_{GABA}$ is never written. Complete corrected form: T1.3 Result.
4. **Eq. 5.4, Cx36 gap junctions (T1.4).** Exact as an identity, but no membrane equation receives $I_{gap}$, so the claimed anti-desynchronization effect has no route into the model; synchrony is not guaranteed by the Laplacian. Coupled PV form: T5.1 Step 11 (proposal).
5. **Eq. 5.5, transporter ledger (T1.5).** $R_{release}(r_{presyn})$ is never specified, and whether $[M]_{syn}$ is a cleft or voxel concentration is not stated. Proposal: T1.5 Result.
6. **Eq. 5.6, Kirchhoff balance (T2.1).** The neural source $k'n_c/V_{cortex}$ is a flow only if $k'$ carries m$^6$ s$^{-1}$ per unit $n_c$; the A.7 audit's "dimensional fix" gives m$^{-3}$ s$^{-1}$. The source also creates blood volume: venous outflow exceeds arterial inflow by $\sum_cs_c$. $c_a = \pi/(8\eta\ell_a)$ hides viscosity and inlet length. Conductance-mediated replacement and dimensionally consistent source: T2.1 Steps 15-16 and Result; SPD uniqueness proof: Steps 10-11.
7. **Eq. 5.7, Stuart-Landau oscillator (T2.2).** A unit cubic coefficient needs a rescaled amplitude (s$^{-1/2}$) or time. A zero nonlinear frequency shift is assumed silently. No map from the complex amplitude to an NE concentration is given. $\omega_{LC}$ must be $2\pi f$. GABA and $\alpha_2$ inhibition enter identically, so the equation alone cannot separate zolpidem from dexmedetomidine. T2.2 Steps 5-9 and Result.
8. **Eq. 5.8, Pennes bioheat (T2.3).** The basis of $\omega_b$ is unstated: the term is right only for mass perfusion $\rho_bw_b$. Metabolic heat is omitted (equivalent to resting tissue temperature $T_b$). There are no boundary conditions, and perfusion is not tied to the computed flow. Corrected form: T2.3 Step 7 and Result.
9. **Eq. 5.8, thermal dilation (T2.4).** No saturation and no time constant; the reference must be resting tissue temperature if metabolic heat is restored; how $\Delta r$ combines with the dynamic radii is unstated; the lineage-table version omits $r_{e0}$. T2.4 Steps 5-7 and Result.
10. **Eq. 5.9, capillary stalls (T2.5).** No intercept, so an edge with no adhesion, a wide lumen and no shear has $P = 1/2$. A flow-based $\tau_w$ is zero in a stalled edge, making stalls self-sustaining. $S_e$ is undefined and there are no temporal dynamics. Corrected form with intercept, pressure-based shear and a two-state Markov switch: T2.5 Result and Step 9.
11. **Eq. 4.2, optical heat (T2.6).** $\Phi$ must be a fluence *rate* (W m$^{-2}$), not "photon fluence"; it depends on $\lambda$; the diffusion equation it is "solved" from is never printed. Supplied with validity limits: T2.6 Steps 7-11 and Checks.
12. **Eq. 5.10, HDAC operator (T6.1).** With $k_{stress}$ in d$^{-1}$ (Table 3), $\tau_{epig}$ must be dimensionless and is redundant. $H_{HDAC}$ and $F_{chronic\_stress}$ are undefined. The substitution $k_{BDNF}\to k_{BDNF,eff}$ in the TrkB equation is implied only by Invariant 7. Stress is counted twice ($[CORT]$ and $F$). The equation is linear and monotone, so it cannot produce the claimed hysteresis. Consistent form: T6.1 Step 4 and Result; explicit substitution: T6.20 Step 9.
13. **Eq. 5.11, hydraulic floor (T6.2).** The requirements $\lambda > 0$ and $L_{p,0} > L_{p,min} \ge 0$ are unstated, and the $L_p \to R_{PVS}$ relation is missing. The floor treats a symptom: the printed AQP4 equation lets $P_{AQP4}$ fall below 0. Series link: T6.2 Step 9 and T2.16 Step 9; invariant AQP4 dynamics: T6.19 Step 4.
14. **Eq. 4.1, glucocorticoid stress rate (T6.3).** The "first-principles" label is overstated: $n_H = 1.8$ is empirical, and the homodimerization it is attributed to gives an effective Hill slope of only 1.2-1.3. Table 3's species values cannot be reproduced because no $[CORT]_{free}$ or $k_{transloc}$ is given, and the $K_d$ values carry no citation. T6.3 Steps 4-11 and Result.

### Conservation-law statements (Aleph Sec. 3)

15. **"First Law of Thermodynamics" carbon balance (T3.4).** The identity is exact, but it is carbon (mass) conservation, not the First Law. It holds for any rate law, so it validates neither the O$_2$ coefficient nor $Y_{ox}$. An electron ledger that does test them: T3.1 Step 11.
16. **Kramers power-law forgetting, $P\propto t^{-\sigma_c^2/\mu}$ (T6.10).** For the multiplicative noise of the capture SDE the barrier is a quasi-potential, and the derived exponent is $\sigma_c^2/(2\tau_c\mu_\Phi)$; the prefactor $\Gamma(1+\alpha)\tau_0^\alpha$ is dropped; and the exponential barrier distribution is assumed, not produced by T6.8 (near the fold it gives $p(\Delta U)\propto\Delta U^{-1/3}$). T6.10 Steps 1-19.
17. **Wall shear $\tau_w = 4\eta Q/(\pi r_e^3)$ (T2.8).** Exact for Poiseuille flow, but zero in a stalled edge, which is exactly where Eq. 5.9 uses it. Use $\tau_w = r_e\Delta p/(2\ell_e)$: T2.8 Step 4, T2.5 Step 10.
18. **Hagen-Poiseuille conductance (T2.7).** The apparent viscosity $\eta_{blood}(r_e)$ it depends on for blood is named but never specified. T2.7 Step 10.
19. **Péclet number (T2.17).** $L$ is never specified, $v$ must be the period-averaged *net* velocity, and $Pe$ alone does not establish net clearance (oscillatory flow only enhances dispersion). T2.17 Result and Checks.
20. **Classifications.** GLUT1 transport and $E(f)$ are filed under "Michaelis-Menten & Hill enzyme kinetics" but are carrier transport and capillary exchange (T3.5, T3.6). The Hall-Ehlert law is an allosteric ternary complex with an operational transducer, not a two-state receptor cycle (T1.3). The "residency-time threshold" of internalization does not appear in A.10 Eq. 1.5, which also gives a pure, not stretched, exponential recovery (T1.14).

### Components the lineage table declares active

21. **Creatine-kinase (PCr/Cr) buffer.** No PCr, Cr or ADP dynamics exist anywhere. With dynamic PCr the steady-state ATP is unchanged, so the CK term cannot deliver the "ATP flat within ±1.2%" claim. Closure and buffered reduction: T3.12; T3.2 Checks.
22. **OXPHOS-ROS coupling (A.9).** No equation in any source. Proposal: T3.13.
23. **Lactate shuttle to pericyte dilation (A.10.1).** No equation in any source. Proposal: T3.14.
24. **CA1 PV depolarization block.** No rule in any source; the CA1 LIF provably cannot block. Proposals: T5.4.
25. **Apoptotic node eviction, $a_i < 0.05\,a_0$.** A.10's "permanently depolarized" trigger conflicts with it and cannot be represented (ATP failure hyperpolarizes through K_ATP). No bookkeeping is given. Derived bookkeeping and time to eviction: T5.6.
26. **"Unique homeostatic fixed points" (AIS controllers).** True only with leaky controllers and with an activity proxy normalized by the energy-scaled set point; A.6 P8's invariant has a sign slip. Closed-loop analysis: Tier 4, final section; T1.21 Step 4.
27. **Capture SDE on $[0,1]$.** Invariance holds (proved in T6.8 Steps 9-16), but the A.6-A.8 prose and the Lean docstring claim the drift vanishes at $c = 0$; it equals $\Omega\pi\ge0$.
28. **Pre-dawn circadian pruning tensor.** It is a scalar, not periodic as printed, "$t_{dawn}$" must mean the arrest time for the "final 2 h" claim, and A.10 Eq. 6.2 uses the opposite gating sign. T6.13 Steps 4-7; T6.21 Step 7.
29. **Ontogenetic scaling tensor.** Dimensions, contraction, noise type, non-negativity and saturation are unstated. Reconstruction: T6.17.
30. **AQP4 polarity degradation.** $[0,1]$ is not invariant, and the Ca$^{2+}_e$ driver cannot track pathology given T5.3. Invariant repair: T6.19 Step 4.
31. **Noradrenergic vasomotion.** The source equation (A.9, A.10 Eq. 2.2) contains a literal ellipsis. Reconstruction, positivity condition and amplitude: T2.10.
32. **Perivascular flux $J_v(t)$.** The printed form is not a flow (m$^4$ Pa$^{-1}$ s$^{-1}$) and grows without bound. Repaired forms: T2.16 Steps 5-10.
33. **Black-Leff replacement of fixed gains.** A.9's $K_A = e^{-\Delta G/RT}$ lacks the standard concentration and a sign convention (corrected in T1.13 Step 5). No Black-Leff form for D1 to HCN is ever written (T1.12).
34. **Gq-PLC-IP3-Ca$^{2+}$ cascade.** The Ca$^{2+}$ equation lacks gating, Ca activation, an ER balance and the current-to-flux factor; the floating threshold uses IP3 although the text names Ca$^{2+}$. Completed system: T1.16 Result; T1.17.
35. **Table 3 dCaAP amplitudes.** $\bar A_{Ca}$ is given in mV but added to currents in the dendritic equation. T1.10 Result (i).

### Inherited forms that Aleph carries by reference

36. **$Y_{ox} = 27.5$ ATP per pyruvate** (A.8 docx and both Lean files) implies P/O 4.58, above the NADH maximum of 2.5; A.6's 14.5 is consistent. T3.2 Steps 3-5.
37. **ATP demand** applies an extra ATP-availability factor to the pump term, breaking the 3 Na$^+$ : 1 ATP coupling except at rest. T3.3 Step 4; corrected form Step 5.
38. **Per-spike Na$^+$ jump** (A.6/A.7, additive) breaks the $[0, n_{eq}]$ invariance of the Na$^+$ ledger. Marcus jump: T5.5 Step 6.
39. **Extracellular Ca$^{2+}$ depletion** (A.8 Eq. (16)): $I_{Ca,burst}$ is unspecified, $\tau_{ref}$ must be dimensionless, and the printed form is not positivity-preserving. Corrected form: T5.3 Step 8.
40. **A.8 demand-based headroom** $h_Q = D_{cap} - \sum D_k \ge 0$ is not maintained by the supply gate or the REM projection when non-weight demand rises; "$s_Q\to0$ as $h_Q\to0$" is false. T6.5 Steps 4-9.
41. **$v_{glymph}$ used as a rate** in the adenosine and K$^+$ balances, although it is a velocity. T6.14 Step 5; T2.13 Step 6.
42. **AIS controllers** lose positivity for $\bar c > 1 + 1/G_L$, and A.10 mixes $L_0(t_g)$ with $L_0$. T4.2 Result.
43. **Homeostatic threshold** $\tau_\theta$ has units 1/mV, and $\chi(1)\ne1$ (T1.21). **Adaptation** $w_i$ is counted twice, as a conductance in Eq. 5.1 and as a threshold in the rate law (T1.8).
44. **A.8 Lean files.** The Kirchhoff SPD theorem is announced but missing (proof supplied in T2.1 Steps 10-11); `dr_a_dt` omits $1/A_K$ (T2.9); the Na$^+$ lower-bound proof uses `positivity` without sign hypotheses (T1.18); the original AIS fixed-point proof lacks $\tau > 0$ hypotheses and `dL_dt` is declared twice (T4.2). The Lean files were not compiled in this work.

## Out of scope

The **emergent invariants** are excluded: the five A.10/Aleph invariants (allosteric ceiling, asymmetric interneuron disinhibition, SSRI saddle-node latency, fractal internalization scaling, cross-species neurovascular coordination) and the ten new invariants of Aleph Sec. 9.1 ($\Pi_{stall}$, $\Omega_{DBS}$, $\Lambda_{glymph}$, $K_{ischemia}$, $\Psi_{pore}$, $\Sigma_{sync}$, $\Xi_{BDNF}$, $\Phi_{peristalsis}$, $c_{ictal}$, $\Theta_{optothermal}$). They are listed in the appendix of the inventory with their printed formulas. They are not derived here.

Some derivations touch these invariants in passing. These are observations, not derivations:

- the A.10 Insight 2 block ratio is inverted: the depolarized PV cell is *less* blocked (T1.2 Checks);
- $\Pi_{stall}$'s threshold $p_c^\ast\approx0.075$ cannot follow from Eq. 5.9 alone (T2.5 Checks);
- $\Theta_{optothermal}$ is dimensionless only if $\delta_{pulse}$ is a duty cycle (T2.3 Checks);
- $\Phi_{peristalsis}$ has units m$^5$ Pa$^{-2}$ s$^{-1}$, not dimensionless (T2.16 Checks);
- $\Xi_{BDNF}$ is the averaged set-point steady state but lacks a dimensional factor, and the T6.1-T6.20-T6.21 cascade cannot produce its claimed hysteresis (T6.21 Steps 8-9);
- $c_{ictal}$ presupposes an inter-node K$^+$ diffusion term that no source writes (T2.13 Result);
- $\Lambda_{glymph}$ uses $L_{p,0}$ and so ignores polarity and the floor (T6.2 Result);
- $K_{ischemia}$ is compared with the time to eviction in T5.6 Checks.

Also not inventoried: species-branch relations (fly tracheal supply, pigeon arbor scaling, $Q_{10}$ laws), A.8's "emergent inferences", mechanisms dropped before A.8, Model A precursor-audit relations, and the proven properties of earlier versions (A.2 Properties 1-5, A.6 P1-P11), which are cited as derivation material where relevant.

## Source documents

Originals are in the repository root. The derivations cite them by file name.

| Original file | Version |
|---|---|
| `Model_Aleph_1_only equations.docx` | Aleph 1 = A.10.1 (primary) |
| `Model_Aleph_1_Comprehensive_Scientific_Report.docx` | Aleph 1 = A.10.1 (primary) |
| `Model_Aleph_Equation_Derivations_GPT.docx` | GPT derivation audit of Aleph 1 |
| `Model_A10_Comprehensive_Scientific_Report.docx` | A.10 (own numbering, Eqs. 1.1-6.3) |
| `Model_A9_changes from a8.docx` | A.9 (equations as images; re-read for the inventory) |
| `Model_A8_model only.docx` | A.8 |
| `Model_A8_Scientific_Report.docx` | A.8 with inferences and Lean excerpts |
| `Model_A8_Scientific_Report.pdf` | A.8, numbered Eqs. (1)-(20) |
| `Model_A8_All_Equations.lean` | A.8 Lean definitions and theorems |
| `Model_A8_All_Equations_patched.lean` | A.8 Lean, patched |
| `Model_A8_FormalVerification.lean` | A.8 Lean verification |
| `A.7-research-report.md` | audit of A.7 with proposals for A.8 |
| `Model A.7 with all equations.docx` | A.7 annex, Eqs. 1-39 |
| `model A.7 maths.docx` | A.7 short mathematics |
| `Model A.7 More scientific Doc (gemini).docx` | A.7 summary |
| `Model A.7 Upgrade Doc (gemini).docx` | A.7 narrative (no explicit equations) |
| `Model A.6 four-caveat revision, verified equations and experimental validation (claude).docx` | A.6 |
| `Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf` | A.5 specification, despite the A4 file name |
| `Model A.5  validation against experimental data.docx` | A.4 validation report, despite the A.5 file name |
| `Model A.3 Species-Resolved Model for Macaque, Rat, Zebrafish and Fly.docx` | A.3 |
| `Model A.2 Repaired Specification and Validation.docx` | A.2 |
| `Model_A_Biological_Neuroenergetics_Specification.pdf` | Model A reduced core (precursor lineage) |
| `Model_A_Changelog_Audit_and_Fixes.md` | Model A (A.1) changelog and audit |

Standard textbook and literature results used in the reconstructions (for example Woodhull 1973, Black & Leff 1983, Hodgkin & Huxley 1952, Pennes 1948, Kramers 1940, Goethals & Brette 2020) are named in the step where they are used. The numerical claims attributed to Goethals & Brette 2020 in Tier 4 were checked against the published paper (eLife 9:e53432) during the final review.

## Review notes

A final coordinator review re-derived the key algebra of every entry and recomputed the numerical checks labelled "computed here" (among them the AIS Evans calibration table, the closed-loop Nyquist bound and eigenvalue scan, the monomer-dimer Hill slopes, the Kramers barrier, prefactor and averaging integral, the REM Lipschitz constants, the capture saddle-node, the lactate time constant and the zebrafish sleep fit). Corrections made in that pass are recorded in the tier files themselves; no git history was written.
