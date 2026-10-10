# Aleph 1 (Model A.10.1) Equation Inventory, Tiers 1–6

This file is the master list of the equations that make up **Aleph 1 (Model A.10.1)**, Tiers 1 to 6. It is the work list for reconstructing the step-by-step derivations that were lost in earlier model files. Each equation has a stable key (T1.1, T1.2, …), its canonical form as the latest source states it, symbol definitions, version-by-version lineage, the derivation material that survives, a derivation plan and a status hint.

**How it was built.** Both Aleph 1 sources (`Model_Aleph_1_only equations.docx` and `Model_Aleph_1_Comprehensive_Scientific_Report.docx`) were read in full. They print only Eqs. 4.1, 4.2 and 5.1–5.11 (Tiers 1, 2 and 6). Everything that Aleph's Sec. 2 lineage table or Sec. 3 conservation-law list declares active is taken from the most recent complete statement: A.10, then A.9, then A.8, then earlier versions. That rule is relaxed only where a later version names a term without its formula. In those cases the last explicit formula is used and the entry says so. Transcriptions from the 23 reader extractions were cross-checked where they looked suspicious: all A.9 equation images were re-read, and the A.10, A.8 and A.6 equations were spot-checked against the converted source texts.

**Conventions.**

- **Aleph label.** "Aleph Eq. x" means the equation is printed in Aleph 1. "inherited: …" names the version and equation that supplies the canonical form. "claimed: …" marks a component that Aleph says is active but that no source ever writes as an equation; its canonical form is NOT STATED IN ANY SOURCE.
- **Canonical form.** Transcribed from the source named in the label, with notation kept as printed. Printed defects (truncations, literal ellipses) are kept and flagged rather than repaired. Suggested repairs appear only in the derivation plan and are marked as reconstructions.
- **Status hint.** One of *exact*, *approximations*, *phenomenological* or *incomplete-in-source*, sometimes with a short qualifier.
- **Units.** Sources rarely state units. Values quoted come from the sources. Units marked "implied" are inferred and should be confirmed by the derivation author.
- **Source codes.** Xnn refers to an extraction file, and "E7" means entry E7 in that file. Lean theorems are cited by name; the `.lean` files are in the repository root. Version caveats: the file named "A4 (gemini)" specifies A.5, the file named "A.5 validation" is the A.4 validation report, and the two "Model A" files are the A.1 precursor lineage.

**Global issues the derivation authors should carry through.**

1. *Mixed units.* Eq. 5.1 and the dendritic and CA1 equations are written in voltage-normalized form, with conductances relative to leak and synaptic terms written as currents. No source states the normalization.
2. *Symbol clashes.* $\tau_v$ is used for both the membrane and the vascular time constant (T1.1, T2.10); $\tau_c$ for both the AIS proxy and capture (T4.1, T6.8); $\tau_w$ for both adaptation and weights (T1.8, T6.4); $\beta_c$ for both capillary dilation and capture (T2.14, T6.8); $n_c$ for both the critical Na and the node activity (T1.20, T2.1); $K_A$ for both K_ATP and Black–Leff (T1.6, T1.13); $\psi$ for both salience and the pericyte state; $\Pi$ for the pump rate and $\Pi_Q$ for the potentiation drive; $\pi$ for the energy gate and $\pi_R$ for REM pruning; $\theta$ for thresholds and $\theta(a)$ for ADP feedback; $\rho$ and $\lambda$ are each used several times.
3. *Printed defects.* Eq. 5.3 is truncated ($\tau_s\cdot(\ldots)$). The A.9/A.10 vasomotion equation contains a literal ellipsis. The Aleph lineage table prints the thermal dilation without $r_{e0}$.
4. *Claimed but never written.* PCr/Cr dynamics (T3.12), OXPHOS–ROS coupling (T3.13), lactate → pericyte coupling (T3.14), PV depolarization block (T5.4), the reflected OU radius process (T2.14), and the forms of $h_K$, $\Phi$, $\mathcal{F}_{A2B}$, $I_{NsMJ}$, $I_{AMPA}$, $b_m$ and $f^\pm_{ij}$.
5. *Definitions that drifted between versions.* $h_Q$ (weight cost in A.2–A.5, energy demand in A.8), the placement of $E_{ij}$ inside or outside the plasticity brake, $Y_{ox}$ (14.5 in A.6, 27.5 in A.8/Lean), the circadian gating sign ($\Theta_{circ}$ in A.8, $1-\Theta_{circ}$ in A.10), and the glymphatic description ($v_{glymph}$ in A.5–A.8, $J_v$/$Pe$ in A.9–A.10).
6. *Lean coverage.* The A.8 Lean files prove only algebraic facts: ephaptic cancellation, dCaAP below threshold, Na-ledger boundary signs, Poiseuille positivity, basal arteriole equilibrium, carbon closure, CK equilibrium, AIS fixed point, Ca recovery, capture boundary lemmas, and the zolpidem limit. The Kirchhoff SPD theorem is announced but never implemented.

**Source legend.** Extraction files (one per source document, written by the reader agents) live in [`source_extractions/`](source_extractions/). Original files are in the repository root.

| Code | Extraction file | Original source | Version |
|---|---|---|---|
| X01 | `01_Model_A_Biological_Neuroenergetics_Specification.md` | `Model_A_Biological_Neuroenergetics_Specification.pdf` | Model A reduced core (precursor lineage, not A.1–A.10 numbering) |
| X02 | `02_Model_A_2_Repaired_Specification_and_Validation.md` | `Model A.2 Repaired Specification and Validation.docx` | A.2 |
| X03 | `03_Model_A_3_Species_Resolved_Model_for_Macaque_Rat_Zebrafish_and_Fly.md` | `Model A.3 Species-Resolved Model for Macaque, Rat, Zebrafish and Fly.docx` | A.3 |
| X04 | `04_Model_A4_Scientific_Report_and_Formal_Specification_gemini.md` | `Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf` | A.5 specification despite the A4 filename |
| X05 | `05_Model_A_5_validation_against_experimental_data.md` | `Model A.5  validation against experimental data.docx` | A.4 validation report despite the A.5 filename |
| X06 | `06_Model_A_6_four_caveat_revision_verified_equations_and_experimental_validation_claude.md` | `Model A.6 four-caveat revision, verified equations and experimental validation (claude).docx` | A.6 |
| X07 | `07_A_7_research_report.md` | `A.7-research-report.md` | audit of A.7, proposals for A.8 |
| X08 | `08_Model_A_7_More_scientific_Doc_gemini.md` | `Model A.7 More scientific Doc (gemini).docx` | A.7 summary |
| X09 | `09_Model_A_7_Upgrade_Doc_gemini.md` | `Model A.7 Upgrade Doc (gemini).docx` | A.7 narrative, no explicit equations |
| X10 | `10_Model_A_7_with_all_equations.md` | `Model A.7 with all equations.docx` | A.7 annex Eqs. 1–39 |
| X11 | `11_model_A_7_maths.md` | `model A.7 maths.docx` | A.7 short maths |
| X12 | `12_Model_A8_model_only.md` | `Model_A8_model only.docx` | A.8 |
| X13 | `13_Model_A8_Scientific_Report.md` | `Model_A8_Scientific_Report.docx` | A.8 with inferences and Lean |
| X14 | `14_Model_A8_Scientific_Report.md` | `Model_A8_Scientific_Report.pdf` | A.8, numbered Eqs. (1)–(20) |
| X15 | `15_Model_A8_All_Equations.md` | `Model_A8_All_Equations.lean` | A.8 Lean |
| X16 | `16_Model_A8_All_Equations_patched.md` | `Model_A8_All_Equations_patched.lean` | A.8 Lean (patched) |
| X17 | `17_Model_A8_FormalVerification.md` | `Model_A8_FormalVerification.lean` | A.8 Lean verification |
| X18 | `18_Model_A9_changes_from_a8.md` | `Model_A9_changes from a8.docx` | A.9 |
| X19 | `19_Model_A10_Comprehensive_Scientific_Report.md` | `Model_A10_Comprehensive_Scientific_Report.docx` | A.10 (own numbering Eq. 1.1–6.3) |
| X20 | `20_Model_A_Changelog_Audit_and_Fixes.md` | `Model_A_Changelog_Audit_and_Fixes.md` | Model A (A.1) |
| X21 | `21_Model_Aleph_1_only_equations.md` | `Model_Aleph_1_only equations.docx` | Aleph 1 = A.10.1 (primary) |
| X22 | `22_Model_Aleph_1_Comprehensive_Scientific_Report.md` | `Model_Aleph_1_Comprehensive_Scientific_Report.docx` | Aleph 1 = A.10.1 (primary) |
| X23 | `23_Model_Aleph_Equation_Derivations_GPT.md` | `Model_Aleph_Equation_Derivations_GPT.docx` | GPT derivation audit of Aleph 1 |

**Counts.**

| Tier | Title | Entries | Not stated in any source |
|---|---|---|---|
| 1 | Membrane electrophysiology and pharmacodynamics | 21 | 0 |
| 2 | Microvascular fluid mechanics and thermal operators | 17 | 0 |
| 3 | Six-pool substrate metabolism | 14 | 3 |
| 4 | Axon initial segment tri-variable leaky controller | 5 | 0 |
| 5 | CA1 conductance-based spiking layer, PV block and node eviction | 6 | 1 |
| 6 | Plasticity, epigenetics and decay | 21 | 0 |
| All | | 84 | 4 |

## Tier 1: Membrane electrophysiology and pharmacodynamics

Aleph prints Eqs. 5.1–5.5. The remaining entries are closures of Eq. 5.1 and the inherited Tier 1 components named in Aleph's lineage table (Black–Leff, Gq-PLC-IP3-Ca²⁺, receptor internalization, dendritic potential, sodium debt ledger, firing-rate transfer).

### T1.1 Somatic membrane potential with K_ATP metabolic brake

- **Aleph label:** Aleph Eq. 5.1
- **Status hint:** approximations (KCL is exact; current-based synapses and unit normalization are modelling choices)

**Canonical form:**

$$
\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap}\, w_i\,(v_i - E_K) + G_s\,\zeta\,(1 - \nu_{ACh}) \sum_j \left[ s_j W_{ij} x_{ij} r_j(t - \tau_{ij}) \right] + G_s (1 + \nu_{ACh})\, I_i(t) + I_{ax,i}
$$

- **Symbols:** Aleph defines none of these; definitions are from A.8 (docx Tier 1). $v_i$ somatic potential of neuron/node $i$ (mV, voltage-normalized form); $\tau_v$ membrane time constant (ms); $v_{rest}$ resting potential (about −70 mV); $g_K(a_i)$ ATP-sensitive K conductance (T1.6), dimensionless relative to leak (implied); $a_i$ intracellular ATP (mM); $E_K$ K reversal (−85 mV); $g_{adap}$ adaptation conductance and $w_i$ adaptation variable (T1.8); $G_s$ baseline synaptic gain; $\zeta$ global synaptic scaling; $\nu_{ACh}\in[0,1]$ cholinergic tone (suppresses recurrent, boosts feedforward input); $s_j\in\lbrace -1,+1\rbrace$ Dale sign; $W_{ij}$ synaptic weight (T6.4); $x_{ij}\in[0,1]$ releasable resource fraction (T1.9); $r_j$ presynaptic rate (Hz, T1.20); $\tau_{ij}$ axonal delay (ms); $I_i(t)$ feedforward input (type and units never stated); $I_{ax,i}$ axial plus ephaptic current (T1.7).
- **Lineage:** Model A/A.1 (X20 E14, X01 E10): $\tau_v\dot v_i=-(v_i-v_{rest})+\zeta(1-\nu ACh)\sum_j s_jW_{ij}x_{ij}r_j-c_aa_Q+(1+\nu ACh)I_i$; K_ATP only as a threshold shift $\Delta\theta(e_i)$ in the rate law. A.2 (X02 E2): K_ATP becomes a conductance $-g_K(e_i)(v_i-E_K)$; gain $G$. A.5 Eq. 1 (X04 E11, file labelled "A4 gemini"): adds delays $\tau_{ij}$, a point ephaptic term $-g_{eph}(v_i-V_e)$ and axial $g_{axial}(v_{d,i}-v_i)$. A.6 Eq. 1 (X06 E2): ephaptic coupling moved into the axial-gradient term; $g_K$ reads produced ATP $a_i$. A.7 annex Eq. 1 (X10 E14; X11 E1; X08 E1 short form): unchanged. A.8 PDF Eqs. (1)-(2) (X12 E1, X13 E1, X14 E2-E3; Lean dv_s_dt, X15/X16 E1): adds the adaptation current and names the axial term $I_{ax,i}$. A.10 Eq. 1.1 (X19 E3): identical to Aleph. Aleph Eq. 5.1 (X21 E17, X22 E17): identical.
- **Derivation material:** X23 E2-E3 (GPT docx §3.1: Kirchhoff current law, Ohmic terms, normalization by a reference conductance; unit warning). X15/X16 E2 (Lean theorem ephaptic_coupling_cancels_in_uniform_field). X06 E50 (A.6 property P10, field-polarisation formula, 0.118 mV per V/m). X13 E1 (term-by-term interpretation). X11 E22 (A.7 ephaptic geometry argument).
- **Derivation plan:** Start from charge conservation for a somatic compartment, $C_m\,dV/dt=\sum I$. (1) Leak $-g_L(V-V_{rest})$. (2) K_ATP Ohmic current $-g_K(a)(V-E_K)$ with $g_K(a)$ from T1.6. (3) Adaptation as a slow K conductance $g_{adap}w$ sharing $E_K$. (4) Synaptic drive as a rate-coded current: sum over presynaptic $j$ of Dale sign × weight × resource × delayed rate (current-based approximation, no driving force). (5) Cholinergic modulation as gains $(1\mp\nu_{ACh})$ on recurrent and feedforward input. (6) Axial current from the two-compartment cable (T1.7). Divide by $g_L$ so that $\tau_v=C_m/g_L$ and every conductance is relative to $g_L$; list the units each coefficient must carry. Reproduce the uniform-field cancellation (Lean) and the steady polarization (A.6 P10). Flag: mixed normalized and physical units (GPT); synapses current-based while K terms are conductance-based; $I_i(t)$ undefined.

### T1.2 Woodhull voltage-dependent NMDA open-channel block

- **Aleph label:** Aleph Eq. 5.2
- **Status hint:** exact under two-state equilibrium assumptions (approximation for use-dependent trapping)

**Canonical form:**

$$
I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}\,(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}\exp(-\alpha_{Mg}\, v) + \frac{[B]}{K_B}\exp\left(-\frac{z\,\delta_B F v}{R\,T_b}\right)\right]^{-1}
$$

- **Symbols:** $I_{NMDA}$ NMDA current; $\bar g_{NMDA}$ maximal conductance; $v$ (dendritic) membrane potential (mV); $E_{rev}$ NMDA reversal (value not stated); $[Mg^{2+}]_e$ extracellular Mg (mM); $\delta_{Mg}$ Mg block constant (written as $\delta$ but acts as a concentration, cf. 3.57 mM in Jahr–Stevens; not stated); $\alpha_{Mg}$ Mg voltage sensitivity (1/mV; not stated); $[B]$ blocker concentration (ketamine, memantine, MK-801); $K_B$ blocker dissociation constant at 0 mV; $z$ blocker valence (+1 in A.10); $\delta_B$ fractional electrical depth of the site (0.65 in A.10 Insight 2); $F$ Faraday constant; $R$ gas constant; $T_b$ body temperature (K).
- **Lineage:** No NMDA block term before A.10 (A.8 has none; A.10 says Eq. 1.3 "resolves earlier A.9 error" for ketamine). A.10 Eq. 1.3 (X19 E5): identical. Aleph Eq. 5.2 (X21 E18, X22 E18): identical; Aleph Sec. 3.1 names its basis $\Delta G(v)=\Delta G_0+z\delta_BFv$ (X22 E7).
- **Derivation material:** X23 E4-E5 (GPT §3.2: Boltzmann weighting, availability fraction, current; caveats on sign convention, equilibrium block versus kinetic trapping, additive Mg plus drug). X22 E7 / X21 E7 (Aleph Sec. 3.1 free-energy statement). X19 E21 (A.10 Insight 2 single-blocker reduction $P_{open}(v)$; the invariant itself is out of scope).
- **Derivation plan:** Two-state open-channel block with the site at electrical depth $\delta_B$. (1) Free energy of the bound state $\Delta G(v)=\Delta G_0+z\delta_BFv$. (2) Boltzmann: $K_B(v)=K_B(0)\exp(z\delta_BFv/RT_b)$. (3) Unblocked fraction $1/(1+[B]/K_B(v))$. (4) Treat Mg²⁺ as a second, mutually exclusive blocker with empirical Jahr–Stevens parameters, giving additive terms in the binding polynomial. (5) Multiply by the Ohmic driving force $\bar g(v-E_{rev})$. Fix the sign convention (cationic blocker from outside; hyperpolarization strengthens block). Flag: equilibrium binding, not trapping kinetics, despite the "trap law" name; $\delta_{Mg}$ is a concentration, not a fraction; mutual exclusivity of Mg and drug is an assumption.

### T1.3 Vectorized Hall–Ehlert GABA_A allosteric ternary-complex law

- **Aleph label:** Aleph Eq. 5.3
- **Status hint:** incomplete-in-source

**Canonical form:**

$$
\left(\frac{E}{E_{max}}\right)_{GABA} = \sum_s f_s(x)\cdot\left[\frac{[A]/K_{A,s} + \alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})}{1 + [A]/K_{A,s} + [B]/K_{B,s} + \alpha_s([A]/K_{A,s})([B]/K_{B,s}) + \tau_s\cdot(\ldots)}\right]
$$

- **Symbols:** $s$ GABA_A subunit-class index (β2/β3 assemblies per the lineage table); $f_s(x)$ class weight (argument $x$ never defined); $[A]$ orthosteric agonist (endogenous GABA); $[B]$ allosteric modulator (benzodiazepine, etomidate, ...); $K_{A,s}$, $K_{B,s}$ dissociation constants (concentration); $\alpha_s$ binding cooperativity (dimensionless); $\beta_s$ efficacy cooperativity (undefined in Aleph; A.10 calls β "operational activation efficacy cooperativity"); $\tau_s$ operational efficacy (A.10: $\tau_{eff}$); $(\ldots)$ literal ellipsis printed in both Aleph files.
- **Lineage:** A.9 introduced the Black–Leff operational model for GPCRs only (T1.13). A.10 Eq. 1.4 (X19 E6), scalar and complete: $E/E_{max}=\frac{[A]/K_A+\alpha\beta([A]/K_A)([B]/K_B)}{1+[A]/K_A+[B]/K_B+\alpha([A]/K_A)([B]/K_B)+\tau_{eff}([A]/K_A+\alpha\beta([A]/K_A)([B]/K_B))}$. Aleph Eq. 5.3 (X21 E19, X22 E19) vectorizes over subunit classes with weights $f_s(x)$; the $\tau_s$ term is truncated as $\tau_s\cdot(\ldots)$ in the Aleph sources themselves (source defect, not an extraction error).
- **Derivation material:** X23 E6 (GPT §3.3: binding polynomial with weights 1, [A]/K_A, [B]/K_B, α[A][B]/(K_AK_B); efficacy weighting; flags τ_s·(...) as undefined). X19 E6 (complete A.10 scalar form); X19 E19-E20 (A.10 limits [B]→∞ and [A]→0, useful algebra checks; the invariant is out of scope). Aleph Sec. 3.1 (Gibbs/mass-action thermodynamic cycle of a two-state receptor).
- **Derivation plan:** Allosteric ternary complex model: states R, AR, BR, ABR with statistical weights 1, $a=[A]/K_A$, $b=[B]/K_B$, $\alpha ab$ (closure of the thermodynamic cycle). Stimulus = efficacy-weighted active states (AR with efficacy 1, ABR with efficacy β): numerator $a+\alpha\beta ab$. Pass through the Black–Leff hyperbolic transducer with $\tau$ to reproduce A.10 Eq. 1.4; this identifies $(\ldots)=[A]/K_{A,s}+\alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})$. Sum over subunit classes with $\sum_sf_s=1$. Flag: the standard operational model of allosterism (Ehlert; Leach et al.) also carries $\tau$ in the numerator (maximum $\tau/(1+\tau)$), but A.10/Aleph do not; $\beta_s$, $f_s(x)$ and $x$ are undefined; the coupling of this fraction to $I_{GABA}$ in T1.10 is never written.

### T1.4 Connexin-36 gap-junction current between PV interneurons (graph Laplacian)

- **Aleph label:** Aleph Eq. 5.4
- **Status hint:** exact

**Canonical form:**

$$
I_{gap,k} = \sum_{j \in \mathrm{PV\ neighbors}} g_{gap}\,(v_{PV,j} - v_{PV,k}) = -g_{gap}\left[L_{gap}\, v_{PV}\right]_k
$$

- **Symbols:** $I_{gap,k}$ gap-junction current into PV cell $k$; $g_{gap}$ junction conductance (uniform); $v_{PV}$ vector of PV-interneuron potentials; $L_{gap}=D-A$ graph Laplacian of the Cx36 network ($A$ adjacency, $D$ degree matrix).
- **Lineage:** A.5 change log mentions $g_{gap}$ only verbally (X04 E10). New as an operator in Aleph (A.10.1 "final fix"; lineage-table short form $I_{gap}=-g_{gap}L_{gap}v_{PV}$, X21 E2/X22 E2), motivated by the failed ketamine gamma test (#4, fixed in #65).
- **Derivation material:** X23 E7 (GPT §3.4: Ohmic junction, adjacency sum, Laplacian identity, charge conservation, synchrony not guaranteed).
- **Derivation plan:** Ohm's law per junction; sum over neighbours with adjacency $A_{kj}$; rewrite $\sum_jA_{kj}(v_j-v_k)=-(Dv-Av)_k$. Show $\mathbf{1}^TI_{gap}=0$ (charge conservation) and that $L_{gap}$ is symmetric positive semidefinite. Generalize to a weighted Laplacian for heterogeneous junctions. Note that where $I_{gap}$ enters (PV membrane in Tier 5 or rate layer) is not stated.

### T1.5 Competitive monoamine transporter reuptake ledger (SERT/DAT/NET)

- **Aleph label:** Aleph Eq. 5.5
- **Status hint:** approximations (QSSA); release term unspecified

**Canonical form:**

$$
\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}\,[M]_{syn}}{K_{m,T}\left(1 + [Inhibitor]/K_i\right) + [M]_{syn}} - k_{clear}[M]_{syn}
$$

- **Symbols:** $[M]_{syn}$ extracellular monoamine (5-HT, DA, NE) concentration; $R_{release}(r_{presyn})$ firing-dependent vesicular release rate (form never given); $V_{max,T}$, $K_{m,T}$ transporter maximal rate and Michaelis constant; $[Inhibitor]$ competitive inhibitor (SSRI, modafinil, ...); $K_i$ inhibitor dissociation constant; $k_{clear}$ residual first-order clearance (1/time).
- **Lineage:** New in A.10 (Eq. 1.7, X19 E9, "Reuptake Corrected"). Aleph Eq. 5.5 (X21 E21, X22 E21): identical.
- **Derivation material:** X23 E8 (GPT §3.5: mass balance plus competitive Michaelis–Menten, quasi-steady-state assumptions).
- **Derivation plan:** Mass balance of extracellular transmitter in a fixed volume: release − transporter uptake − other clearance. Transporter as an enzyme with a competitive inhibitor: quasi-steady state on E, ES, EI gives $v=V_{max}S/(K_m(1+I/K_i)+S)$. Add diffusion/enzymatic loss as first order. State QSSA validity (fast transporter binding, reversible competitive inhibition). Flag: $R_{release}$ unspecified; concentration versus voxel-average not stated.

### T1.6 K_ATP conductance law (closure of Eq. 5.1)

- **Aleph label:** inherited: A.8 Tier 1 inline (symbol g_K(a_i) in Aleph Eq. 5.1)
- **Status hint:** phenomenological (Hill inhibition)

**Canonical form:**

$$
g_K(a) = \frac{\bar g_K}{1 + (a/K_A)^{n_K}}
$$

- **Symbols:** $\bar g_K$ maximal K_ATP conductance; $a$ intracellular ATP (mM); $K_A$ half-inhibition ATP level (same symbol as the Black–Leff $K_A$, a clash); $n_K$ Hill exponent.
- **Lineage:** Model A: brake as threshold shift $\Delta\theta(e_i)$ (X20 E15). A.2 (X02 E3): $g_K(e)=\bar g_K/(1+(e/K_A)^n)$ on lumped energy. A.5 Eq. 2 (X04 E12). A.6 Eq. 1 (X06 E2) on produced ATP $a$. A.8 inline (X12 E2, X13 E2, X14 E4); the A.8 Lean files treat $g_K$ as a free input (X15 E1). A.10 and Aleph keep only the symbol $g_K(a_i)$.
- **Derivation material:** No derivation in any source; only the statement that the conductance opens as ATP falls and hyperpolarizes toward −85 mV (X02 E2-E3, X13 E2, X13 Inference 2).
- **Derivation plan:** K_ATP (Kir6.2/SUR) open probability inhibited by ATP binding: Hill inhibition $P_o=1/(1+(a/K_A)^{n_K})$ (concerted multi-site binding), $g_K=\bar g_KP_o$. Discuss MgADP activation (ignored). Show the limits $a\to0$ (full brake) and $a\gg K_A$ (brake off).

### T1.7 Axial plus ephaptic soma–dendrite current (closure of Eq. 5.1)

- **Aleph label:** inherited: A.8 PDF Eq. (2) (symbol I_ax,i in Aleph Eq. 5.1)
- **Status hint:** exact (within the two-compartment model)

**Canonical form:**

$$
I_{ax,i} = g_{ax}\left[(v_{d,i} - v_i) + \left(V_e(x_{d,i}) - V_e(x_{s,i})\right)\right]
$$

- **Symbols:** $g_{ax}$ soma–dendrite axial conductance; $v_{d,i}$ dendritic transmembrane potential; $V_e(x)$ extracellular potential at position $x$; $x_{d,i}$, $x_{s,i}$ dendritic and somatic coordinates. The dendritic equation (T1.10) receives $-I_{ax,i}$.
- **Lineage:** A.5 (X04 E11): separate $-g_{eph}(v_i-V_e(x_i))$ and $g_{axial}(v_{d,i}-v_i)$ terms; the point-cell uniform-field term has no physical effect (A.5 validation X05 E19; A.6 change C15). A.6 Eqs. 1-2 (X06 E2-E3): axial-gradient form. A.7 Eqs. 1-2 (X10 E14-E15). A.8 PDF Eq. (2) (X14 E3) names it $I_{ax,i}$. A.10 and Aleph use $I_{ax,i}$ without restating it.
- **Derivation material:** X15/X16 E2 (Lean theorem ephaptic_coupling_cancels_in_uniform_field). X06 E50 (A.6 P10: $v_s=-\frac{(g_{ax}/g_s)E\ell}{1+g_{ax}/g_d+g_{ax}/g_s}$, soma 0.118 mV per V/m, dendrite 0.176 opposite sign). X11 E22. X13 E1 (Bikson 2004 coupling coefficient).
- **Derivation plan:** Two-compartment cable: axial current is driven by the intracellular potential difference, with $\phi_{in}=v+V_e$ in each compartment. Write $I_{ax}=g_{ax}(\phi_{in,d}-\phi_{in,s})$ and substitute to obtain the printed form. Prove cancellation for uniform $V_e$; derive steady soma/dendrite polarization for a uniform field $E$ over length $\ell$ (reproduce A.6 P10).

### T1.8 Spike-frequency adaptation variable

- **Aleph label:** inherited: A.8 Tier 1 inline (symbol w_i in Aleph Eq. 5.1)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_w \frac{dw_i}{dt} = -w_i + m_w r_i
$$

- **Symbols:** $w_i$ adaptation variable (enters Eq. 5.1 as a conductance factor and T1.20 as a subtractive threshold); $\tau_w$ time constant (same symbol as the weight time constant in T6.4); $m_w$ gain; $r_i$ firing rate.
- **Lineage:** A.2 (X02 E5): $\tau_{ad}\dot a_i=-a_i+m\,r_i$ (adaptation then called $a_i$). A.5 Eq. 6 (X04 E16). A.6 Eq. 7 renames it $w_i$ (X06 E8). A.7 Eq. 7 (X10 E20). A.8 inline (X12 E3, X13 E3, X14 E5). A.10 and Aleph: symbol only.
- **Derivation material:** No derivation in the sources (A.8: slow Ca- or Na-activated K channels).
- **Derivation plan:** First-order kinetics of a slow K(Ca)/K(Na) gate incremented by each spike; averaging spike-triggered increments over rate $r$ gives the linear drive $m_wr$. Flag: $w_i$ is used both as a conductance factor in Eq. 5.1 and as a subtractive threshold in T1.20 (double counting and unit mismatch).

### T1.9 Presynaptic resource (Tsodyks–Markram) dynamics for x_ij

- **Aleph label:** inherited: A.5 Eq. 16 (symbol x_ij in Aleph Eq. 5.1)
- **Status hint:** approximations (standard mean-field model); not restated after A.5

**Canonical form:**

$$
\frac{dx_{ij}}{dt} = \frac{1 - x_{ij}}{\tau_{rec}} - U\,x_{ij}\,r_j
$$

- **Symbols:** $x_{ij}\in[0,1]$ readily releasable resource fraction; $\tau_{rec}$ recovery time constant; $U$ release fraction per spike; $r_j$ presynaptic rate.
- **Lineage:** Model A / v7.3 vesicle resource; A.2 restores it (X02 E15); A.5 Eq. 16 (X04 E26) is the last explicit statement. A.6–A.10 and Aleph use $x_{ij}$ ("Tsodyks–Markram short-term depression", A.8 docx) without restating the dynamics; A.8 Inference 5 uses NsMJ vesicle depletion $x$ 0.8 → 0.15.
- **Derivation material:** None in the sources (cited as Tsodyks–Markram).
- **Derivation plan:** Mean-field Tsodyks–Markram: each spike releases fraction $U$ of available resource; recovery is first order. Averaging over Poisson spikes at rate $r$ gives the ODE; steady state $x^*=1/(1+U\tau_{rec}r)$.

### T1.10 Active dendritic membrane potential

- **Aleph label:** inherited: A.10 Eq. 1.2 / A.8 PDF Eq. (3)
- **Status hint:** approximations; incomplete-in-source (I_AMPA, u_d undefined)

**Canonical form:**

$$
C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i} - E_L) + \bar A_{Ca}\,\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i} - E_{HCN}) + I_{AMPA} + I_{NMDA} + I_{GABA} - I_{ax,i}
$$

- **Symbols:** $C_d$ dendritic capacitance; $g_{leak}$, $E_L$ leak; $\bar A_{Ca}$ dCaAP amplitude (Aleph Table 3: human 38, macaque 18, rat 6.5, mouse 4.5 mV; fly, zebrafish, pigeon 0); $\Delta(u)$ dCaAP activation (T1.11); $u_{d,i}$ integrated apical drive (computation never stated); $g_{HCN}(DA)$ (T1.12); $E_{HCN}$ HCN reversal; $I_{AMPA}$ (never defined); $I_{NMDA}$ from Eq. 5.2; $I_{GABA}$ (presumably scaled by Eq. 5.3, not stated); $I_{ax,i}$ (T1.7).
- **Lineage:** A.5 Eq. 3 (X04 E13) with undefined $I_{dCaAP}$. A.6 Eq. 2 (X06 E3): explicit $\Delta(u)$ and apical sum $\sum_{j\in apical}W_{ij}x_{ij}r_j(t-\tau_{ij})$. A.7 Eq. 2 (X10 E15; short forms drop terms). A.8 PDF Eq. (3) (X14 E6; Lean dv_d_dt, X15/X16 E4). A.10 Eq. 1.2 (X19 E4) replaces the apical sum with $I_{AMPA}+I_{NMDA}+I_{GABA}$. Aleph lists "dendritic potential" as inherited; the A.10 form is the latest.
- **Derivation material:** X15/X16 E5 (Lean theorem dCaAP_zero_below_threshold). X13 E4 (interpretation).
- **Derivation plan:** KCL on the apical compartment as in T1.1: leak, active dCaAP generator, HCN shunt, synaptic currents now resolved pharmacologically (Woodhull NMDA, Hall–Ehlert GABA_A), and the mirror axial current. Flag: $\bar A_{Ca}$ is in mV yet is added to currents (units); $I_{AMPA}$ undefined; how $u_{d,i}$ is formed is not stated; A.10 dropped the delayed apical sum of A.8.

### T1.11 Dendritic Ca action potential (dCaAP) activation function

- **Aleph label:** inherited: A.8 PDF Eq. (4)
- **Status hint:** phenomenological

**Canonical form:**

$$
\Delta(u) = \mathcal{H}(u - u_{th})\cdot\exp\left(-\frac{u - u_{th}}{w_{Ca}}\right)
$$

- **Symbols:** $\mathcal{H}$ Heaviside step; $u$ apical drive; $u_{th}$ dCaAP threshold (made dynamic in A.9, T1.17); $w_{Ca}$ decay width (human 12 mV).
- **Lineage:** A.5: $I_{dCaAP}$ undefined. A.6 Eq. 2 (X06 E3; change C17: peaks at threshold, decays above). A.7 Eq. 2. A.8 PDF Eq. (4) (X14 E7); Lean piecewise dCaAP_activation (X15/X16 E3). A.9 floating threshold (T1.17).
- **Derivation material:** X15/X16 E5 (Lean theorem). X06 E3 justification: a monotone activation gives OR, not XOR (Gidon et al. 2020).
- **Derivation plan:** Empirical fit to the Gidon et al. 2020 dCaAP amplitude-versus-input curve: zero below threshold, maximal at threshold, exponential decline above. Demonstrate the XOR property for two inputs that are each suprathreshold alone. No first-principles derivation is expected.

### T1.12 D1 dopamine inverted-U pair: HCN shunt and non-preferred-input suppression

- **Aleph label:** inherited: A.8 Tier 1 inline / A.10 Eq. 1.2 (g_HCN(DA))
- **Status hint:** phenomenological

**Canonical form:**

$$
g_{HCN}(DA) = \frac{\bar g_{HCN}\,DA^3}{K_D^3 + DA^3}, \qquad s_{np}(DA) = 1 - \frac{\sigma_1\,DA^2}{K_1^2 + DA^2}
$$

- **Symbols:** $DA$ dopamine level; $\bar g_{HCN}$ maximal HCN conductance; $K_D$, $K_1$ half-activation levels; $\sigma_1$ maximal suppression; $s_{np}$ gain on non-preferred inputs (the term it multiplies is never written).
- **Lineage:** A.4: monotone DA gain (X04 E10 change log). A.5 Eq. 4: Hill-3 HCN (X04 E14). A.6 Eqs. 3-4 (X06 E4-E5) add $s_{np}$. A.7 Eqs. 3-4 (X10 E16-E17). A.8 inline (X12 E6, X13 E6-E7, X14 E8-E9). A.10 Eq. 1.2 keeps $g_{HCN}(DA)$. The Aleph lineage table says A.8's "fixed gain scalars (G_s, g_HCN)" were superseded by Black–Leff in A.9, but no Black–Leff form for D1→HCN is ever written.
- **Derivation material:** Justification only (Arnsten 2011): D1 → cAMP → HCN opening; the product of the two limbs gives the inverted-U (X06 E4, X13 E6-E7).
- **Derivation plan:** Hill binding of cAMP (n = 3) to the HCN cyclic-nucleotide domain after D1 activation; a second Hill function (n = 2) for suppression of non-preferred inputs. Derive the inverted-U of selectivity as the product of a rising limb (suppression) and a falling limb (shunt). Optionally re-express DA → D1 occupancy with Black–Leff (T1.13) to match the A.9 claim.

### T1.13 Black–Leff operational model of GPCR agonism (with K_A from binding free energy)

- **Aleph label:** inherited: A.9 (Aleph Sec. 2 lineage table)
- **Status hint:** exact given operational-model assumptions; K_A relation missing a reference concentration

**Canonical form:**

$$
\frac{E}{E_{max}} = \frac{\tau[L]}{K_A + (\tau + 1)[L]}, \qquad K_A = e^{-\Delta G/RT}
$$

- **Symbols:** $E/E_{max}$ fractional response; $[L]$ ligand concentration; $K_A$ equilibrium dissociation constant; $\tau$ transducer ratio (efficacy); $\Delta G$ binding free energy; $R$, $T$ gas constant and temperature.
- **Lineage:** A.8 used fixed gains. A.9 (X18 E3-E4, equation images checked) introduced both relations. A.10 embeds the form with pathway-specific transducers $\tau_{arr}$, $\tau_{Gq}$ in Eqs. 1.5-1.6 (T1.14, T1.15). The Aleph lineage table repeats $E/E_{max}$ (X21 E1, X22 E1).
- **Derivation material:** X23 E26 (GPT §8.1: occupancy-response model with receptor reserve and transduction).
- **Derivation plan:** Black & Leff 1983: occupancy $[AR]/R_0=[L]/(K_A+[L])$; hyperbolic transducer $E=E_{max}[AR]/(K_E+[AR])$; define $\tau=R_0/K_E$; eliminate $[AR]$. For $K_A$: $K_d=c^\circ\exp(\Delta G^\circ_{bind}/RT)$ with a standard concentration $c^\circ$. Flag: the A.9 form lacks $c^\circ$, and its sign requires $\Delta G$ to be the dissociation (positive) free energy.

### T1.14 Receptor internalization and tachyphylaxis (β-arrestin-2 biased)

- **Aleph label:** inherited: A.10 Eq. 1.5
- **Status hint:** phenomenological (mass action with Black–Leff gating)

**Canonical form:**

$$
\frac{d[R_{surf}]}{dt} = -k_{endo}\left[\frac{\tau_{arr}[L]}{K_A + (\tau_{arr} + 1)[L]}\right][R_{surf}] + k_{recycle}\left(R_{total} - [R_{surf}]\right)
$$

- **Symbols:** $[R_{surf}]$ surface receptor density; $R_{total}$ total receptor pool (conserved); $k_{endo}$ endocytosis rate constant; $k_{recycle}$ recycling rate constant; $\tau_{arr}$ β-arrestin-2 transducer efficacy; $[L]$, $K_A$ as in T1.13.
- **Lineage:** None before A.10. A.10 Eq. 1.5 (X19 E7). Aleph names "receptor internalization/tachyphylaxis" and, in Sec. 3.4, clathrin-coated-pit kinetics, without a formula.
- **Derivation material:** X19 E24 (A.10 Insight 4: residency-time argument and stretched-exponential recovery; the invariant is out of scope, but note that Eq. 1.5 alone gives a pure exponential).
- **Derivation plan:** Two-pool receptor trafficking with $R_{surf}+R_{int}=R_{total}$: internalization flux ∝ β-arrestin-engaged fraction (Black–Leff with $\tau_{arr}$) × surface receptors; first-order recycling. For constant $[L]$: exponential relaxation at rate $k_{endo}\phi+k_{recycle}$ to $R^*=k_{recycle}R_{total}/(k_{recycle}+k_{endo}\phi)$, where $\phi$ is the bracket.

### T1.15 Gq-biased PLC → IP3 second-messenger generation

- **Aleph label:** inherited: A.10 Eq. 1.6 (A.9 Gq-PLC-IP3 cascade)
- **Status hint:** phenomenological

**Canonical form:**

$$
\frac{d[IP_3]_i}{dt} = k_{PLC}\left[\frac{\tau_{Gq}[L]}{K_A + (\tau_{Gq} + 1)[L]}\right][R_{surf}] - \gamma_{IP3}[IP_3]_i
$$

- **Symbols:** $[IP_3]_i$ intracellular IP3; $k_{PLC}$ PLC production constant; $\tau_{Gq}$ Gq transducer efficacy; $[R_{surf}]$ from T1.14; $\gamma_{IP3}$ IP3 degradation rate.
- **Lineage:** A.9 (X18 E5, image checked): $d[IP_3]_i/dt=k_{PLC}(E/E_{max})-\gamma_{IP3}[IP_3]_i$. A.10 Eq. 1.6 (X19 E8): Gq-biased Black–Leff fraction × surface receptors. Aleph lineage table: "Gq-PLC-IP3-Ca2+ cascade" (no formula).
- **Derivation material:** X23 E27 (GPT §8.2 states the A.9 algebra was illegible to its author; the A.9 equation images are legible and are transcribed in X18).
- **Derivation plan:** IP3 balance: production = PLC activity ∝ number of active Gq-coupled receptors (fractional Gq response × surface receptors); degradation by IP3 3-kinase/5-phosphatase, first order. Flag: multiplying a fractional response by $[R_{surf}]$ changes the units of $k_{PLC}$ relative to A.9.

### T1.16 Intracellular Ca²⁺ with IP3-receptor ER release

- **Aleph label:** inherited: A.9 (Gq-PLC-IP3-Ca2+ cascade)
- **Status hint:** incomplete-in-source

**Canonical form:**

$$
\frac{d[Ca^{2+}]_i}{dt} = -\gamma_{Ca}\left([Ca^{2+}]_i - Ca_{rest}\right) + I_{VGCC}(v_d) + k_{IP3}\,[m(IP_3)]^3\,h^3\left([Ca^{2+}]_{ER} - [Ca^{2+}]_i\right)
$$

- **Symbols:** $[Ca^{2+}]_i$ cytosolic Ca; $\gamma_{Ca}$ clearance rate; $Ca_{rest}$ resting Ca; $I_{VGCC}(v_d)$ voltage-gated Ca influx at dendritic potential $v_d$ (current-to-concentration factor missing); $k_{IP3}$ IP3R flux constant; $m(IP_3)$ IP3 activation gate and $h$ inactivation gate (neither defined; $h$ has no dynamics); $[Ca^{2+}]_{ER}$ ER calcium (no balance equation).
- **Lineage:** New in A.9 (X18 E6, image checked). Not restated in A.10 or Aleph (Aleph names the cascade only).
- **Derivation material:** None (A.9 gives one sentence; GPT §8.2 gives only the mechanism chain).
- **Derivation plan:** Cytosolic Ca balance: pump/leak relaxation to rest; VGCC influx converted to flux by $1/(2F\,Vol)$; IP3R flux = open probability × gradient, with a De Young–Keizer / Li–Rinzel open probability $m_\infty^3h^3$, $m_\infty=\frac{[IP_3]}{[IP_3]+d_1}\frac{[Ca]}{[Ca]+d_5}$ and $dh/dt=(h_\infty-h)/\tau_h$ (supplied by the derivation author, flagged as not in source). Flag missing ER balance and Ca conservation.

### T1.17 Floating dendritic (dCaAP) threshold

- **Aleph label:** inherited: A.9
- **Status hint:** phenomenological

**Canonical form:**

$$
u_{th}(t) = u_{th,0} - \alpha_{Gq}\log\left(1 + [IP_3]_i\right)
$$

- **Symbols:** $u_{th}$ dCaAP threshold used in T1.11; $u_{th,0}$ baseline; $\alpha_{Gq}$ coupling coefficient; $[IP_3]_i$ from T1.15 (dimensionless inside the log, so implicitly normalized).
- **Lineage:** New in A.9 (X18 E7, image checked). Not restated in A.10 or Aleph.
- **Derivation material:** None. Inconsistency: the A.9 text says the calcium pool sets the threshold, but the equation uses IP3.
- **Derivation plan:** Phenomenological logarithmic saturation of threshold lowering with second-messenger level; state the normalization of $[IP_3]$; decide between IP3 and Ca as the driver (source conflict).

### T1.18 Intracellular sodium debt ledger with driving-force saturation

- **Aleph label:** inherited: A.8 PDF Eq. (5)
- **Status hint:** approximations

**Canonical form:**

$$
\frac{dn_i}{dt} = \left[\nu_{spk} r_i + \nu_{syn} G_s \sum_j W_{ij} x_{ij} r_j + \lambda_n + \frac{I_{ChR2,Na}}{F\cdot Vol_i}\right]\left(1 - \frac{n_i}{n_{eq}}\right) - \Pi_i
$$

- **Symbols:** $n_i$ intracellular Na⁺ load (mM; A.6 calls it normalized); $\nu_{spk}$ Na per spike; $\nu_{syn}$ AMPA Na per unit synaptic drive; $\lambda_n>0$ resting leak; $I_{ChR2,Na}$ optogenetic Na current; $F$ Faraday; $Vol_i$ intracellular volume; $n_{eq}\approx12$ mM "electrochemical equilibrium"; $\Pi_i$ pump extrusion (T1.19).
- **Lineage:** Model A: no Na state, $P_{ATP}\approx\Delta G_{ATP}/(3q_e)\lvert I_{Na}\rvert$ (X20 E13). A.2 (X02 E6) introduces $\dot n=\nu_{spk}r+\nu_{syn}G\sum Wxr+\lambda_n-\Pi$. A.3 adds optogenetic loading (X03 E16). A.5 Eq. 7 (X04 E17) with $I_{ChR2}/(z_{Na}F\,Vol_i)$. A.5 validation shows $n$ unbounded at zero ATP (X05 E10). A.6 Eq. 5 (X06 E6) adds $(1-n_i/n_{eq})$. A.7 Eq. 5 (X10 E3, E18). A.8 PDF Eq. (5) (X14 E10); Lean dn_dt (X15 E8, X17 E4). Aleph: "sodium debt ledger" inherited.
- **Derivation material:** Lean: Model_A8_FormalVerification.lean sodium_ledger_upper_invariant and sodium_ledger_lower_invariant (X17 E5-E6); Model_A8_All_Equations(_patched).lean sodium_boundary_invariant (X15/X16 E9). X06 E41 (A.6 P1, max n 11.45 < 12). X13 E60 (A.8 capacitive Na per spike $\Delta n_{spk}=\frac{C_{membrane}(V_{peak}-V_{rest})}{F\,Vol_i}(1-n_i/n_{eq})$). X23 E18 (GPT §5.3 amount balance).
- **Derivation plan:** Amount balance $d(Vol_i\,n_i)/dt=J_{in}-J_{out}$, divided by $Vol_i$. Influx: spike charge $C_m\Delta V/F$ per spike × rate; Na fraction of AMPA charge; leak; ChR2 photocurrent$/(F\,Vol_i)$. Driving-force factor: linearize $I_{Na}\propto(E_{Na}-v)$ with $E_{Na}=(RT/F)\ln(n_o/n)$, or a GHK flux near equilibrium, to obtain $(1-n/n_{eq})$; state that it is a first-order surrogate. Pump from T1.19 ($\Pi$ is in Na units; ATP use is $\Pi/3$ in T3.3). Prove forward invariance of $[0,n_{eq}]$ (boundary signs, Nagumo). Flag: the Lean lower-bound proof needs a sign hypothesis on $\nu_{syn}G_s$ (X17); $n_c=4$ mM (T1.20) lies inside $[0,n_{eq}]$.

### T1.19 Na⁺/K⁺-ATPase pump rate (dual Michaelis–Menten)

- **Aleph label:** inherited: A.8 PDF Eq. (6)
- **Status hint:** approximations

**Canonical form:**

$$
\Pi_i = \Pi_{max}\, m(a_i, K_a)\, m(n_i, K_n), \qquad m(z, K) = \frac{z}{z + K}
$$

- **Symbols:** $\Pi_{max}$ maximal pump rate; $a_i$ ATP; $n_i$ Na load; $K_a\approx0.15$ mM; $K_n\approx10$ mM (A.8); stoichiometry 1 ATP : 3 Na⁺ out : 2 K⁺ in.
- **Lineage:** A.2 (X02 E7): $\Pi=\Pi_{max}m(e)m(n)$. A.5 Eq. 8 (X04 E18). A.6 Eq. 6 (X06 E7, "3 Na⁺ per ATP"). A.7 Eq. 6. A.8 PDF Eq. (6) (X14 E11); Lean pump_rate / pump (X15 E7, X17 E2). A.8 pigeon branch adds $\Pi_{max}(T_b)=\Pi_{max,0}Q_{10}^{(T_b-37)/10}$ (X13 E59).
- **Derivation material:** None beyond "dual Michaelis–Menten kinetics" (X12 E8). Positivity used in the Lean invariance proofs (X17 E5).
- **Derivation plan:** Two-substrate enzyme with independent (rapid-equilibrium, random-order) sites gives a product of Michaelis–Menten saturations. Note that the real pump binds Na cooperatively (Hill about 3), so the product form is an approximation. Record positivity and monotonicity for use in T1.18.

### T1.20 Firing-rate transfer function with Na-gradient failure gate

- **Aleph label:** inherited: A.8 Tier 1
- **Status hint:** phenomenological; incomplete-in-source (h_K, Phi undefined)

**Canonical form:**

$$
r_i = \left[1 + \left(\frac{n_i}{n_c}\right)^6\right]^{-1} h_K(k_c)\cdot\Phi\left(g(NE)\left(v_i - \theta_i - w_i - \theta_0 - \theta_{AIS,i}\right)\right)
$$

- **Symbols:** $n_c\approx4$ mM critical Na (the same symbol is the node activity in Eq. 5.6); $h_K(k_c)$ extracellular-K⁺ scaling (form never given); $k_c$ extracellular K⁺ at the capillary node (T2.13); $\Phi$ sigmoid (form never given; A.2: type-specific $\phi_\tau$); $g(NE)$ noradrenergic gain; $\theta_i$ fast homeostatic threshold (T1.21); $\theta_0$ baseline threshold; $\theta_{AIS,i}$ AIS shift (T4.5); $w_i$ adaptation (T1.8).
- **Lineage:** Model A (X20 E15, X01 E11): $r=h_K(k_Q)\phi_\tau(g_\tau(NE)(v-\theta-a-\Delta\theta(e)))$. A.2 (X02 E4) adds the gate $[1+(n/n_c)^6]^{-1}$ and drops $\Delta\theta(e)$. A.5 Eq. 5 (X04 E15). A.6 Eq. 7 (X06 E8) adds $\theta_{AIS}$. A.7 Eq. 7 (X10 E20). A.8 (X12 E9, X13 E11). Aleph: inherited.
- **Derivation material:** None (interpretation only: above $n_c$ the cell enters depolarization block from loss of the Na reversal gradient, X13 E11).
- **Derivation plan:** Constitutive rate law: sigmoidal f–I curve with NE-set gain; subtractive thresholds; multiplicative failure factor from Na-gradient collapse (Hill-6 surrogate for a step at $n_c$ as $E_{Na}$ falls); K⁺ factor. Show the Hill-6 factor as a smooth approximation; no first-principles derivation exists. Flag: $h_K$ and $\Phi$ undefined; dual use of $w_i$.

### T1.21 Energy-aware fast homeostatic threshold

- **Aleph label:** inherited: A.8 Tier 1 inline (chi form from A.7 annex Eq. 31)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_\theta \frac{d\theta_i}{dt} = r_i - \rho_i\,\chi(a_i/a_0), \qquad \chi(e) = \frac{e^4}{e^4 + e_h^4}
$$

- **Symbols:** $\theta_i$ homeostatic threshold; $\tau_\theta$ time constant; $\rho_i$ target rate (A.6: $\ln\rho_i\sim N(\mu_\rho,\sigma_\rho^2)$); $\chi$ energy scaling of the set point; $a_0$ reference ATP; $e_h$ half-point.
- **Lineage:** Model A (X20 E20): $\tau_\theta\dot\theta=r-\rho_\tau$ projected onto bounds. A.2 (X02 E13-E14): energy-aware $\chi(e)$. A.5 Eq. 15 (X04 E25). A.6 Eq. 31 (X06 E32). A.7 Eq. 31 (X10 E43a), last statement of the $\chi$ form. A.8 inline in Tier 1 (X12 E10, X13 E12) without the $\chi$ form. Aleph: not named separately; it feeds T1.20.
- **Derivation material:** X02 E28 (A.2 Property 5, $r^*=\rho\chi(e^*)$, no controller conflict). X06 E48 (A.6 P8, unique equilibrium only with leaky AIS controllers).
- **Derivation plan:** Integral controller on the rate error with a Hill-4 energy-scaled set point, so that a supply cut lowers the target and the controller does not fight the K_ATP brake. Derive the steady state $r^*=\rho\chi$; show that a pure-integral AIS plus this controller gives a continuum of equilibria and that leaky AIS controllers (Tier 4) restore uniqueness.

## Tier 2: Microvascular fluid mechanics and thermal operators

Aleph prints Eqs. 5.6–5.9 and 4.2. The remaining entries are the inherited Tier 2 components from the lineage table and Sec. 3: Hagen–Poiseuille, wall shear, NsMJ + Kir2.1 dilation, noradrenergic vasomotion, perivascular flux and Péclet number.

### T2.1 3D Kirchhoff microvascular node balance with linear neurovascular source

- **Aleph label:** Aleph Eq. 5.6
- **Status hint:** exact balance + constitutive closures; neurovascular source dimensionally unresolved

**Canonical form:**

$$
\sum_{e \ni c} G_e\,(p_c - p_{c'}) = c_a\, r_a^4\,(P_a - p_c)\,\mathbf{1}_{c\in Art} - G_v\, p_c\,\mathbf{1}_{c\in Ven} + \frac{k'\, n_c}{V_{cortex}}
$$

- **Symbols:** $c$ graph node; $e\ni c$ edges incident on $c$ and $c'$ their other endpoints; $G_e$ edge hydraulic conductance (T2.7); $p_c$ nodal pressure (A.6: relative, $P_a=1$); $c_ar_a^4$ arteriolar inlet conductance ($c_a$ constant, $r_a$ arteriole radius, T2.9); $P_a$ systemic arterial pressure; $G_v$ venous drainage conductance (venous pressure taken as 0); $\mathbf{1}$ indicator of arteriole-root or venule nodes; $n_c$ local neural activity at node $c$ (A.8 PDF; same symbol as the critical Na in T1.20); $k'$ linear neurovascular-coupling coefficient; $V_{cortex}$ cortical volume.
- **Lineage:** Model A, A.2, A.5: discrete supply domains Q with lumped supply (X02 E9, X04 E21). A.6 Eq. 9 (X06 E10): 2D capillary graph, Kirchhoff with arteriole roots and venules. A.7 Eq. 9 (X10 E22, X11 E16): 3D murine angiome; neurovascular coupling was quadratic, $F=kn^2$ (X07 E2, X14 E1). A.8 PDF Eq. (7) (X12 E13, X13 E15, X14 E13) adds the linear volumetric source $k'n_c/V_{cortex}$ after the A.7 audit's dimensional fix (X07 E1-E2). A.10: prose only. Aleph Eq. 5.6 (X21 E22, X22 E22): identical to A.8 Eq. (7); Aleph Sec. 3.2 also gives the interior form $\sum G_e(p_c-p_{c'})=0$ (X22 E11).
- **Derivation material:** X23 E9 (GPT §4.1: Poiseuille edge flows plus nodal volume conservation; flags the units of the neural source and of $c_a$). X12 E13-E14 and X13 E15-E16 (SPD Laplacian uniqueness argument). X06 E44 (A.6 P4: Laplacian + $G_v$ SPD, divergence 1.2e-14). X10 E46, X11 E21. X17 E15 (Lean Kirchhoff theorem announced in the header but not implemented).
- **Derivation plan:** (1) Edge flow $q_e=G_e(p_c-p_{c'})$ from Hagen–Poiseuille (T2.7). (2) Incompressible mass conservation at node $c$: net edge outflow = boundary inflow − boundary outflow + sources. (3) Boundary nodes: arteriole-root inlet as a series conductance $c_ar_a^4$ to the reservoir $P_a$; venules drain to 0 through $G_v$. (4) Assemble $(L_G+B)p=b$ with $L_G$ the weighted graph Laplacian and $B$ the diagonal boundary conductances; prove symmetric positive definiteness on a connected graph with at least one boundary node, hence unique pressures. (5) Analyse the neurovascular term: as printed it is an injected source per cortical volume; derive the units $k'$ must carry (flow) or reinterpret it as a conductance/radius modulation. Flag: a node source term breaks closed-network flow balance unless compensated at the venous boundary; A.8 claims dimensional consistency without showing it.

### T2.2 Stuart–Landau locus coeruleus noradrenergic limit cycle

- **Aleph label:** Aleph Eq. 5.7
- **Status hint:** approximations (local normal form)

**Canonical form:**

$$
\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\,\omega_{LC})\,NE_{LC} - \lvert NE_{LC}\rvert^2\, NE_{LC} - g_{GABA}\, NE_{LC} - g_{\alpha 2}\, NE_{LC}
$$

- **Symbols:** $NE_{LC}$ complex LC noradrenergic amplitude (its real part drives vasomotion, T2.10); $\lambda_{LC}$ linear growth rate; $\omega_{LC}$ angular frequency (0.01–0.1 Hz band; 0.032 Hz NREM peak); $g_{GABA}$ GABAergic inhibition and $g_{\alpha2}$ α2-autoreceptor inhibition, computed in A.9 from Black–Leff occupancy of their ligands, $g_{GABA}([L_{GABA}])$, $g_{\alpha2}([L_{\alpha2}])$; rates in 1/time (implied).
- **Lineage:** A.8: heuristic/Boolean sleep gate, no LC oscillator. A.9 (X18 E8, image checked): $dNE_{LC}/dt=f_{oscillator}(NE_{LC})-g_{GABA}([L_{GABA}])NE_{LC}-g_{\alpha2}([L_{\alpha2}])NE_{LC}$, Stuart–Landau named but not written. A.10 Eq. 2.1 (X19 E10): explicit normal form. Aleph Eq. 5.7 (X21 E23, X22 E23): identical.
- **Derivation material:** X23 E10-E11 (GPT §4.2: Hopf normal form; $NE_{LC}$ must be a complex amplitude). Aleph Sec. 3.3 (supercritical Hopf bifurcation explains the glymphatic–sedation paradox: uniform GABA_A agonism collapses vasomotion to a fixed point).
- **Derivation plan:** Centre-manifold reduction near a supercritical Hopf bifurcation, $\dot Z=(\lambda+i\omega)Z-c\lvert Z\rvert^2Z$, rescaled to $c=1$. Inhibitory inputs reduce the linear rate: $\lambda_{eff}=\lambda_{LC}-g_{GABA}-g_{\alpha2}$. Polar form $\dot\rho=\lambda_{eff}\rho-\rho^3$, $\dot\phi=\omega_{LC}$: limit cycle $\rho^*=\sqrt{\lambda_{eff}}$ for $\lambda_{eff}>0$, stable focus otherwise (zolpidem collapse versus dexmedetomidine preservation). Flag: no mapping from the complex amplitude to a physical NE concentration; units of the $g$ terms.

### T2.3 Pennes bioheat equation with optical source

- **Aleph label:** Aleph Eq. 5.8 (first relation)
- **Status hint:** exact balance + Pennes perfusion approximation

**Canonical form:**

$$
\rho\, C_p\,\frac{\partial T}{\partial t} = k_{th}\,\nabla^2 T - \omega_b\, C_b\,(T - T_b) + Q_{laser}(x,\lambda)
$$

- **Symbols:** $T(x,t)$ tissue temperature; $\rho$ tissue density; $C_p$ tissue specific heat; $k_{th}$ thermal conductivity; $\omega_b$ blood perfusion rate (volumetric versus mass basis not stated); $C_b$ blood specific heat; $T_b$ arterial/body temperature (Aleph Table 3: human 37.0, mouse 36.9, rat 37.7, macaque 38.0, pigeon 41.2, zebrafish 28.5, fly 25.0 °C); $Q_{laser}$ optical heat source (T2.6).
- **Lineage:** New in Aleph (A.10.1 final fix; failed photothermal test #52, fixed in #68). Same form in Aleph Sec. 3.2 (X22 E14). Aleph Eq. 5.8 (X21 E24, X22 E24).
- **Derivation material:** X23 E12-E13 (GPT §4.3: first law, Fourier's law, Pennes perfusion term; unit check on $\omega_b$).
- **Derivation plan:** Energy conservation in a control volume, $\rho C_p\partial_tT=-\nabla\cdot q+$ sources. Fourier's law $q=-k_{th}\nabla T$. Pennes assumption: perfusing blood enters at $T_b$ and leaves equilibrated with tissue, giving the sink $\omega_b\rho_bC_b(T-T_b)$ (state whether $\omega_b$ already includes $\rho_b$). Add metabolic heat (absent in source) and boundary conditions. Optionally give the steady Green's function for a Gaussian beam.

### T2.4 Thermal (photothermal) vessel dilation

- **Aleph label:** Aleph Eq. 5.8 (second relation)
- **Status hint:** phenomenological

**Canonical form:**

$$
\Delta r_{e,thermal} = r_{e0}\,\kappa_T\,\max(0,\, T - T_b)
$$

- **Symbols:** $\Delta r_{e,thermal}$ radius increment of edge $e$; $r_{e0}$ baseline radius; $\kappa_T$ thermal dilation coefficient (1/K, value not given); $T$ local tissue temperature from T2.3.
- **Lineage:** New in Aleph Eq. 5.8. The Aleph lineage table prints $\Delta r_{thermal}=\kappa_T(T-T_b)_+$ without $r_{e0}$ (X21 E4, X22 E4), an internal inconsistency.
- **Derivation material:** X23 E12 (GPT: a separate phenomenological relation, not derived from Pennes).
- **Derivation plan:** First-order (linear-response) expansion of vascular tone in temperature above baseline, rectified at $T_b$. Give units for $\kappa_T$; choose the relative ($r_{e0}$) or absolute form; state how $\Delta r$ enters the radius used in $G_e\propto r^4$ (additive to T2.9/T2.14 radii; not stated in source).

### T2.5 Discrete stochastic capillary stall probability and conductance switch

- **Aleph label:** Aleph Eq. 5.9
- **Status hint:** phenomenological

**Canonical form:**

$$
P(stall_e) = \left[1 + \exp\left(-\left(\beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}\left(\frac{r_{crit}}{r_e}\right)^2 - \beta_{shear}\frac{\tau_{w,e}}{\tau_{crit}}\right)\right)\right]^{-1}, \qquad G_e = S_e\cdot G_{Poiseuille}
$$

- **Symbols:** $P(stall_e)$ probability that edge $e$ is stalled; $[ICAM\text{-}1]_e$ endothelial adhesion-molecule level; $r_{crit}$ critical radius; $r_e$ radius; $\tau_{w,e}$ wall shear stress (T2.8); $\tau_{crit}$ critical shear; $\beta_{adh}$, $\beta_{geom}$, $\beta_{shear}$ coefficients; $S_e$ patency switch (never defined; presumably Bernoulli, 1 patent, 0 stalled); $G_{Poiseuille}$ from T2.7.
- **Lineage:** New in Aleph (A.10.1; fixes the 12-month stall test #58, fixed in #69). Aleph Eq. 5.9 (X21 E25, X22 E25).
- **Derivation material:** X23 E15 (GPT §4.5: logistic link plus Bernoulli switch; statistical, not derived from Navier–Stokes or adhesion mechanics).
- **Derivation plan:** Option A (statistical): logistic link for a Bernoulli outcome with a linear predictor. Option B (physical): two-state (stalled/flowing) Boltzmann occupancy with a free-energy difference linear in adhesion energy, a confinement term ∝ $(r_{crit}/r)^2$ and shear work, giving $P=1/(1+e^{\Delta G/k_BT})$. Then $S_e\sim\mathrm{Bernoulli}(1-P)$ and $G_e=S_eG_{Poiseuille}$. Flag: a dimensionless argument requires $\beta_{adh}$ in 1/concentration; temporal correlation, reopening and update rate are unspecified.

### T2.6 Optical heat deposition from radiative transport and Beer–Lambert absorption

- **Aleph label:** Aleph Eq. 4.2
- **Status hint:** exact definition + diffusion approximation (fluence equation not printed)

**Canonical form:**

$$
Q(x,\lambda) = \mu_a(\lambda)\cdot\Phi(x), \qquad \mu_a(\lambda) = \ln(10)\cdot\left[[HbO_2]\,\varepsilon_{HbO_2}(\lambda) + [HbR]\,\varepsilon_{HbR}(\lambda)\right] + \mu_{a,water}(\lambda) + \mu_{a,lipid}(\lambda)
$$

- **Symbols:** $Q$ absorbed optical power density (equal to $Q_{laser}$ in T2.3, implied); $x$ position; $\lambda$ wavelength; $\mu_a$ absorption coefficient; $\Phi(x)$ photon fluence (rate), "solved via the diffusion approximation" with reduced scattering $\mu_s'(\lambda)$ (Aleph Table 3 at 473 nm: fly 0.2, zebrafish 0.4, mouse 1.2, rat 1.5, macaque 2.5, human 2.9, pigeon 1.8 mm⁻¹); $[HbO_2]$, $[HbR]$ molar concentrations; $\varepsilon$ molar decadic extinction coefficients (source: $\varepsilon_{HbO_2}(473\,\mathrm{nm})=3.2\times10^4$ cm⁻¹/(mol/L)); $\mu_{a,water}$, $\mu_{a,lipid}$ background absorption.
- **Lineage:** A.7 audit (X07 E8) proposed a Beer–Lambert activated volume $V_{act}(z)=V_0e^{-\mu_az}e^{-\mu_s'z}$. Aleph Sec. 4.2 Eq. 4.2 (X21 E16, X22 E16) introduces $Q$ as a derived quantity replacing an arbitrary laser scalar.
- **Derivation material:** X23 E14 (GPT §4.4: absorbed power = $\mu_a$ × fluence rate; ln 10 conversion; units; diffusion-approximation validity). X22 E16 (Aleph one-paragraph justification).
- **Derivation plan:** (1) Radiative transfer: absorbed power per volume = $\mu_a$ × fluence rate (radiance integrated over $4\pi$). (2) Beer–Lambert with decadic extinction, $A=\varepsilon c\ell$, converts to a natural attenuation coefficient $\ln(10)\varepsilon c$; absorbers add. (3) Diffusion approximation for $\Phi$: $-\nabla\cdot(D\nabla\Phi)+\mu_a\Phi=S$ with $D=1/[3(\mu_a+\mu_s')]$ and $\mu_{eff}=\sqrt{3\mu_a(\mu_a+\mu_s')}$ (not printed in source; supply and flag). Flag: $\Phi$ must be a fluence rate (W/m²) for $Q$ in W/m³; the diffusion approximation fails near the fibre tip.

### T2.7 Hagen–Poiseuille edge conductance

- **Aleph label:** inherited: Aleph Sec. 3.2 / A.8 Tier 2
- **Status hint:** exact (rigid tube, Newtonian); approximation for capillaries

**Canonical form:**

$$
G_e = \frac{\pi\, r_e^4}{8\,\eta_{blood}\,\ell_e}
$$

- **Symbols:** $r_e$ lumen radius; $\ell_e$ segment length (A.6: median 45 µm); $\eta_{blood}$ blood viscosity, written $\eta_{blood}(r_e)$ (Fåhræus–Lindqvist) in A.8.
- **Lineage:** A.6 Eq. 8 and A.7 Eq. 8: $G_e=r_e^4/\ell_e$, constants absorbed (X06 E9, X10 E21, X11 E15). A.8 (X12 E11, X13 E13, X14 E12): full Poiseuille form with $\eta_{blood}(r_e)$; Lean poiseuille_conductance (X15/X16 E10). Aleph Sec. 3.2 (X22 E10): $G_e=\pi r_e^4/(8\eta_{blood}\ell_e)$, "Navier–Stokes lubrication approximation"; Eq. 5.9 multiplies it by $S_e$.
- **Derivation material:** X23 E29 (GPT §8.4: steady laminar Newtonian flow in a rigid tube). Lean theorem poiseuille_conductance_strictly_positive (X15/X16 E11).
- **Derivation plan:** Stokes flow in a rigid circular tube: $\frac{1}{r}\frac{d}{dr}\left(r\frac{du}{dr}\right)=-\frac{\Delta p}{\eta\ell}$ with no-slip gives a parabolic profile; integrate $Q=\int_0^R2\pi ru\,dr=\frac{\pi R^4}{8\eta\ell}\Delta p$. Discuss Fåhræus–Lindqvist as an effective $\eta(r)$ and the limits for red-cell-sized capillaries.

### T2.8 Poiseuille wall shear stress

- **Aleph label:** inherited: Aleph Sec. 3.2 (used in Eq. 5.9)
- **Status hint:** exact (Poiseuille flow)

**Canonical form:**

$$
\tau_w = \frac{4\,\eta\, Q}{\pi\, r_e^3}
$$

- **Symbols:** $\tau_w$ wall shear stress; $\eta$ viscosity; $Q$ volumetric flow in the edge; $r_e$ radius.
- **Lineage:** New in Aleph Sec. 3.2 (X21 E12, X22 E12); feeds $\tau_{w,e}$ in Eq. 5.9.
- **Derivation material:** X23 E30 (GPT §8.4).
- **Derivation plan:** From the Poiseuille profile, $\tau_w=\eta\lvert du/dr\rvert_{r=R}=\Delta pR/(2\ell)$; eliminate $\Delta p$ with $Q=\pi R^4\Delta p/(8\eta\ell)$.

### T2.9 Dual-pathway arteriole dilation (NsMJ + Kir2.1 + astrocytic A2B + capillary signal)

- **Aleph label:** inherited: A.8 PDF Eq. (8)
- **Status hint:** phenomenological; incomplete-in-source (F_A2B, I_NsMJ unspecified)

**Canonical form:**

$$
\tau_a\frac{dr_a}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\frac{I_{NsMJ}(t)}{I_0} + \beta_a\frac{\Phi_{root}(a)}{A_K} + \beta_{astro}\,\mathcal{F}_{A2B}(Ado, cAMP) + \beta_d\sum_c \omega_{ac}\psi_c\right] - r_a
$$

- **Symbols:** $r_a$ arteriole radius; $r_{a0}$ baseline (Aleph Table 3: mouse 4.8, rat 6.0, macaque 11.2, human 16.5, zebrafish 1.8, pigeon 4.2 µm); $\tau_a$ time constant (2 s, A.6); $I_{NsMJ}$ neuron-to-smooth-muscle junction (AMPA/NMDA) current, latency under 150 ms, form never given; $I_0$ normalization; $\Phi_{root}(a)$ conducted Kir2.1 hyperpolarization at the root of arteriole $a$ (T2.11; here $a$ is an arteriole index, not ATP); $A_K$ scale; $\mathcal{F}_{A2B}$ astrocytic adenosine–A2B–cAMP signal (form never given); $\omega_{ac}\propto e^{-\lvert x_a-x_c\rvert/\ell_d}$, $\sum_c\omega_{ac}=1$ (A.6); $\psi_c$ capillary/pericyte state (T2.14); gains $\beta$ (A.6: $\beta_a=2.74$, $\beta_d=2.94$).
- **Lineage:** A.2 (X02 E11): flow ODE $\tau_f\dot f_Q=-(f_Q-1)+\kappa_N(u_Q/\bar u_Q-1)+\kappa_K(k_Q-k_{rest})$; A.5 Eq. 10 (X04 E20). A.6 Eq. 15 (X06 E16): radius dynamics with Kir2.1 plus diffusible capillary signal. A.7 Eq. 15 (X10 E28). A.8 PDF Eq. (8) (X12 E15, X13 E17, X14 E14) adds NsMJ and A2B; Lean dr_a_dt (X15/X16 E12; $A_K$ declared but unused). A.10 Eq. 2.2 merges this bracket, printed as "...", with NE vasomotion (T2.10). Aleph lineage table: "dual fast NsMJ + slow Kir2.1 dilation".
- **Derivation material:** X15/X16 E13 (Lean theorem arteriolar_basal_equilibrium). No derivation; literature justification only (Zhang 2024, Longden 2017, Theparambil 2024).
- **Derivation plan:** First-order relaxation of radius toward an activity-dependent target $r_{a0}(1+\sum$ pathway drives$)$, i.e. a linear superposition of normalized vasodilatory signals; motivate as linearized smooth-muscle tone dynamics about rest. Show the basal equilibrium (Lean). Flag: $\mathcal{F}_{A2B}$ and $I_{NsMJ}$ never specified; Lean omits $A_K$; $\tau_a$ here versus $\tau_v$ in A.9/A.10.

### T2.10 Noradrenergic vasomotion coupling of vessel radius to the LC oscillator

- **Aleph label:** inherited: A.10 Eq. 2.2 (A.9 vasomotion)
- **Status hint:** incomplete-in-source (literal ellipsis)

**Canonical form:**

$$
\tau_v\frac{dr_e}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\left(\frac{I_{NsMJ}}{I_0}\right) + \ldots\right] - r_e - \kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_e
$$

- **Symbols:** $r_e$ vessel radius (A.10 writes $r_e$ with baseline $r_{a0}$); $\tau_v$ vascular time constant (same symbol as the membrane $\tau_v$ in Eq. 5.1); $\kappa_{NE}$ NE constriction gain; $\mathrm{Re}(NE_{LC})$ real part of the T2.2 amplitude; "…" is literal in the source and stands for the remaining dilation terms of T2.9.
- **Lineage:** A.9 (X18 E9, image checked): $\tau_v\,dr_e/dt=\cdots-\kappa_{NE}NE_{LC}(t)\,r_e$ (literal ⋯). A.10 Eq. 2.2 (X19 E11) adds $\mathrm{Re}(\cdot)$ and the NsMJ term, rest elided. Aleph lineage table: "$-\kappa_{NE}\cdot r_e$" (X21 E3, X22 E3).
- **Derivation material:** None (one-sentence motivation in A.9; Hauglund 2025).
- **Derivation plan:** Add a multiplicative NE constriction to T2.9 (linearized α1-adrenergic smooth-muscle tension in NE). Reconstruct the full equation as the T2.9 bracket minus $\kappa_{NE}\mathrm{Re}(NE_{LC})r_e$ and flag it as a reconstruction. Derive the vasomotion amplitude by linear response of a first-order filter forced by the limit cycle: amplitude $\approx\kappa_{NE}\rho^*r^*/\sqrt{1+(\omega_{LC}\tau_v)^2}$.

### T2.11 Kir2.1 retrograde conducted hyperpolarization (Green's-function kernel with bifurcation cost)

- **Aleph label:** inherited: A.8 Tier 2 (Pathway 2a)
- **Status hint:** phenomenological (reduced cable model)

**Canonical form:**

$$
\Phi_m(t) = \Phi_{max}\tanh\left(\sum_n e^{-C_{nm}}\,\frac{s_n(t - d_{nm}/v_c)}{\Phi_{max}}\right), \qquad C_{nm} = \frac{\ell_e}{\lambda_c}\ (\mathrm{upstream}), \quad C_{nm} = \frac{\ell_e}{\lambda_c} + \ln b\ (\mathrm{lateral\ or\ downstream})
$$

- **Symbols:** $\Phi_m$ conducted hyperpolarization at node $m$ (mV; $\Phi_{max}=60$ mV, A.6); $s_n$ K⁺-driven source at node $n$ (T2.12); $d_{nm}$ path distance; $v_c\approx2$ mm/s conduction speed; $\lambda_c$ length constant (2 mm, A.6); $b\approx2$ branching factor; $C_{nm}$ least path cost from $n$ to $m$, summed per step.
- **Lineage:** A.6 Eq. 12 (X06 E13): introduced as the Green's function of a regenerative endothelial cable (a passive cable gave only 0.03 mV at the arteriole). A.7 Eq. 12 (X10 E25). A.8 (X12 E16, X13 E18-E19): "asymmetric Green's kernel (ln b)". Aleph: Kir2.1 pathway inherited.
- **Derivation material:** X06 E13 (A.6 justification: regenerative cable reduced to measured $v_c$ and $\lambda_c$; $\ln b$ = current division at branch points; isotropic kernel dilated every arteriole).
- **Derivation plan:** Linear cable on a tree: steady attenuation $e^{-\ell/\lambda_c}$ per segment; at a junction with $b$ daughters the current divides, giving a factor $1/b$, i.e. cost $\ln b$. Represent Kir2.1 regeneration as a travelling front at $v_c$ (delay $d/v_c$). Superpose sources, then saturate with tanh. Flag: the upstream/downstream asymmetry is imposed, not derived.

### T2.12 Kir2.1 extracellular-K⁺ source term

- **Aleph label:** inherited: A.7 annex Eq. 11 / A.6 Eq. 11
- **Status hint:** phenomenological; not restated after A.7

**Canonical form:**

$$
s_c = A_K\left[\sigma\left(\frac{k_c - k_{th}}{s_k}\right)\sigma\left(\frac{k_{off} - k_c}{s_{off}}\right) - \sigma\left(\frac{k_{rest} - k_{th}}{s_k}\right)\sigma\left(\frac{k_{off} - k_{rest}}{s_{off}}\right)\right]
$$

- **Symbols:** $s_c$ source at capillary node $c$; $k_c$ extracellular K⁺ (mM); $k_{th}=6.8$ mM, $s_k=0.5$ mM, $k_{off}=20$ mM (Longden 2017); $s_{off}$ width; $k_{rest}$ resting K⁺; $A_K=255$ effective gain (A.6, calibrated to 23 mV at 500 µm); $\sigma$ logistic. A.6 writes the second product as "(same at $k_{rest}$)".
- **Lineage:** A.6 Eq. 11 (X06 E12). A.7 Eq. 11 (X10 E24), the last explicit statement. A.8 refers to a "K⁺-driven" source $s_n$ without a formula.
- **Derivation material:** X06 E12 (A.6 development log: source referenced to rest because 823 nodes × 0.015 mV summed to a 7 mV standing hyperpolarization).
- **Derivation plan:** Kir2.1 activation by modest K⁺ elevation and loss of hyperpolarization at high K⁺ gives a band-pass product of two sigmoids; subtract the rest value so baseline sources vanish. Phenomenological fit to Longden et al. 2017.

### T2.13 Extracellular K⁺ with glial clearance and glymphatic washout (supports h_K and s_c)

- **Aleph label:** inherited: A.5 Eq. 13 (k_c used without dynamics from A.6 on)
- **Status hint:** phenomenological; not restated after A.5 (domain-based)

**Canonical form:**

$$
\tau_K\frac{dk_Q}{dt} = -m(e_Q)\,(k_Q - k_{rest}) + \gamma_K\,\bar r_Q - v_{glymph}(t)\,(k_Q - k_{CSF})
$$

- **Symbols:** $k_Q$ extracellular K⁺ in supply domain $Q$ (mM; capillary node $k_c$ from A.6 on); $\tau_K$ time constant; $m(e_Q)$ energy-dependent glial clearance (astrocytic α2 pump); $k_{rest}$ resting K⁺; $\gamma_K$ K⁺ release per unit mean rate $\bar r_Q$; $v_{glymph}$ glymphatic velocity (T6.16); $k_{CSF}$ CSF K⁺.
- **Lineage:** A.2 (X02 E12) without the washout term. A.5 Eq. 13 (X04 E23) adds glymphatic washout; last explicit statement. A.6–A.8 use $k_c$ at capillary nodes inside $h_K(k_c)$ and $s_c$ but never restate its dynamics. Not named in the Aleph lineage table; included because T1.20 and T2.12 depend on it.
- **Derivation material:** X02 E12 (A.2: K⁺ clearance costs energy via the α2 pump isoform). X05 E16 (A.4 validation: glymphatic term units).
- **Derivation plan:** K⁺ balance in extracellular space: release ∝ firing, energy-dependent (Michaelis–Menten) glial uptake, convective washout toward CSF. Re-index from domains $Q$ to capillary nodes $c$ to match the A.6+ graph. Flag: units of $v_{glymph}$ in a rate equation (velocity, not 1/time).

### T2.14 Pericyte/capillary relaxation state and capillary radius

- **Aleph label:** inherited: A.8 Tier 2 inline
- **Status hint:** phenomenological; ROU process incomplete-in-source

**Canonical form:**

$$
\tau_\psi\frac{d\psi_c}{dt} = -\psi_c + q_c, \qquad r_e = r_0\left(1 + \beta_c\,\bar\psi_e\right)
$$

- **Symbols:** $\psi_c$ capillary/pericyte relaxation state; $q_c$ neuro-glial messenger drive (A.6: local neural/glutamate activity); $\tau_\psi=1.2$ s (A.6); $r_0$ capillary baseline radius (rat 2.2 µm); $\beta_c=0.07$ (Hall 2014; same symbol as the capture gain in T6.8); $\bar\psi_e$ segment average. Radii are said to stay in $[r_{min},r_{max}]$ through a (damped) reflected Ornstein–Uhlenbeck process that is never written.
- **Lineage:** A.6 Eqs. 13-14 (X06 E14-E15). A.7 Eqs. 13-14 (X10 E26-E27; X11 E14; X08 E10), ROU named. A.8 inline (X12 E17, X13 E20-E21), "damped ROU with mechanical vessel inertia" named. Aleph A.10.1 claims direct astrocytic-lactate → pericyte coupling (see T3.14).
- **Derivation material:** None. A.8 open-failure note: capillary dilation gives only 4.2% of the flow increase (X12 E17).
- **Derivation plan:** Low-pass filtering of a messenger signal; linear radius response; average over segment endpoints. Supply and flag the missing reflected OU: $dr=\theta(r^*-r)\,dt+\sigma\,dW$ with reflection at $r_{min}$, $r_{max}$.

### T2.15 Normalized node flow (input to GLUT1 and O2 delivery)

- **Aleph label:** inherited: A.6/A.7 Eq. 10 (f = F/F_0 in A.8)
- **Status hint:** exact (definition and conservation identity)

**Canonical form:**

$$
f_c = \frac{F_c}{F_{c,0}}, \qquad F_c = \frac{1}{2}\sum_{e\ni c}\lvert q_e\rvert
$$

- **Symbols:** $f_c$ normalized flow at node $c$; $F_c$ throughflow; $F_{c,0}$ resting throughflow; $q_e$ edge flow from T2.1.
- **Lineage:** A.6 Eq. 10 (X06 E11). A.7 Eq. 10 (X10 E23; X08 E9). A.8 writes only $f=F/F_0$ (X13 E31).
- **Derivation material:** None.
- **Derivation plan:** At an interior node inflow equals outflow, so the throughflow is half the sum of absolute incident flows; prove the identity from T2.1. Discuss boundary nodes (inlet/outlet terms).

### T2.16 Perivascular (glymphatic) flux driven by vessel-wall motion

- **Aleph label:** inherited: A.10 Eq. 2.3 (A.9)
- **Status hint:** phenomenological; incomplete-in-source (units, v and R_PVS links)

**Canonical form:**

$$
J_v(t) = \frac{1}{R_{PVS}}\int\left\lvert\frac{\partial r_e(t)}{\partial t}\right\rvert dt
$$

- **Symbols:** $J_v$ perivascular flow rate; $R_{PVS}$ perivascular resistance (dependence on $L_p$, T6.2, never written); $r_e$ vessel radius (T2.10). The fluid velocity $v$ used in T2.17 is said to be "derived from $J_v$", but the conversion is not given.
- **Lineage:** A.9 (X18 E11, image checked). A.10 Eq. 2.3 (X19 E12) together with $Pe$. Aleph lineage table: A.10 "coupled autonomic brainstem limit cycle to perivascular flux $J_v(t)$" (X22 E3).
- **Derivation material:** None.
- **Derivation plan:** Peristaltic pumping: wall motion displaces perivascular fluid at a rate ∝ $2\pi r\ell\lvert\partial_tr\rvert$; with a net-directional (rectification) assumption and a resistance law, mean flow ∝ $\lvert\dot r\rvert/R_{PVS}$. Show that the printed form (time integral of $\lvert\dot r\rvert$ divided by a resistance) is not a flow dimensionally, and propose a time-averaged form; link $R_{PVS}$ to $L_p$ and the PVS geometry.

### T2.17 Péclet number for perivascular advection versus diffusion

- **Aleph label:** inherited: Aleph Sec. 3.2 / A.10 Eq. 2.3
- **Status hint:** exact (definition)

**Canonical form:**

$$
Pe = \frac{v\,L}{D}
$$

- **Symbols:** $v$ perivascular fluid velocity; $L$ transport length; $D$ solute diffusivity. Benchmarks used: $Pe$ 0.42 (wake) → 2.85 (NREM).
- **Lineage:** A.9 (X18 E10). A.10 Eq. 2.3 (X19 E12). Aleph Sec. 3.2 (X21 E13, X22 E13).
- **Derivation material:** X23 E28 (GPT §8.3: ratio of diffusion to advection time scales).
- **Derivation plan:** Nondimensionalize $\partial_tc+v\cdot\nabla c=D\nabla^2c$ with $\tilde x=x/L$, $\tilde t=tD/L^2$; the advective coefficient is $Pe=vL/D$, equivalently $(L^2/D)/(L/v)$. Note that $Pe$ alone does not establish net clearance.

## Tier 3: Six-pool substrate metabolism

Aleph prints no Tier 3 equation except the Sec. 3 carbon balance. The canonical forms come from A.10 Eq. 3.1 and A.8, with A.7/A.6 used for fluxes that A.8 only names.

### T3.1 Substrate pool balances for glucose, lactate, glycogen, pyruvate and oxygen

- **Aleph label:** inherited: A.8 PDF Eqs. (9)-(11) (Aleph Sec. 2: six closed pools G, L, Gamma, p, o, a)
- **Status hint:** exact bookkeeping given the stated stoichiometric assumptions

**Canonical form:**

$$
\frac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn}
$$

$$
\frac{dL}{dt} = 2(v_{ga} + v_{gly}) + v_{ex} - J_L
$$

$$
\frac{d\Gamma}{dt} = v_{syn} - v_{gly}
$$

$$
\frac{dp}{dt} = 2v_{gn} - v_{ox} - v_{ex}
$$

$$
c_O\frac{do}{dt} = J_O - 3v_{ox}
$$

- **Symbols:** $G$ tissue glucose (mM; rest 1.2, A.6); $L$ lactate (rest 0.8); $\Gamma$ glycogen in glucosyl units (rat $\Gamma_0=7.0$ mM; species values in Aleph Table 3); $p$ pyruvate; $o$ tissue O₂ (rest 0.035 mM); $J_G$ GLUT1 influx (T3.5); $v_{gn}$ neuronal glycolysis (T3.7); $v_{ga}$ astrocytic glycolysis (T3.8); $v_{syn}$, $v_{gly}$ glycogen synthesis and breakdown (T3.9); $v_{ex}$ LDH/MCT exchange and $J_L$ lactate washout (T3.11); $v_{ox}$ oxidative flux (T3.10); $J_O$ O₂ delivery (T3.6); $c_O$ O₂ capacity factor (never defined). The ATP pool $a$ is T3.2.
- **Lineage:** Model A, A.2, A.5: lumped energy $e_i$, no substrate pools (X20 E16, X02 E8, X04 E19). A.6 Eq. 23 (X06 E24) introduces the pools. A.7 Eq. 23 (X10 E36; X11 E6-E10; X08 E6 partial). A.8 PDF Eqs. (9)-(11) (X14 E15-E17; X12 E18-E22; X13 E22-E26); Lean codes G, L, Γ, p only (X15/X16 E14-E17, X17 E10-E13). A.10: "closed six-pool" prose (X19 E13). Aleph Sec. 2 and 3: retained.
- **Derivation material:** X23 E16 (GPT §5.1 control-volume balance with stoichiometric coefficients). Carbon-closure Lean proofs (T3.4). X06 E45-E47 (A.6 P5 ledgers, P6 rest-state Jacobian eigenvalues, P7 slow-manifold reduction to the A.2 energy equation).
- **Derivation plan:** Write control-volume balances per voxel with explicit stoichiometry: neuronal glycolysis glucose → 2 pyruvate; astrocytic glycolysis and glycogenolysis → 2 lactate (glycolysis plus LDH lumped); glycogen glucosyl ↔ glucose; LDH exchange p ↔ L; oxidation consumes pyruvate with 3 O₂ per pyruvate (6 per glucose, which assumes glycolytic NADH is oxidized via a shuttle; pyruvate alone needs 2.5). Verify every coefficient and state the redox assumption. Flag: $c_O$ undefined; astrocytic glycolysis bypasses the pyruvate pool.

### T3.2 Neuronal ATP balance with creatine-kinase / phosphocreatine buffer

- **Aleph label:** inherited: A.10 Eq. 3.1 / A.8 PDF Eq. (12)
- **Status hint:** approximations; Y_ox value inconsistent across versions

**Canonical form:**

$$
\frac{da_i}{dt} = 2v_{gn} + Y_{ox}\,v_{ox} + k_{CK}\left([PCr][ADP] - \frac{[Cr][ATP]}{K_{eq}}\right) - D_i
$$

- **Symbols:** $a_i$ neuronal ATP (mM; rest 2.5, A.6; also written [ATP]); $Y_{ox}$ ATP yield per oxidized pyruvate (A.6: 14.5, i.e. 29 ATP per glucose; A.8 docx: "≈ 27.5 ATP per pyruvate"; the A.8 Lean files hard-code 27.5); $k_{CK}$ creatine-kinase rate constant; $K_{eq}$ CK equilibrium constant; $[PCr]$, $[Cr]$, $[ADP]$ (no dynamics given, see T3.12); $D_i$ ATP demand (T3.3).
- **Lineage:** Model A ATP buffers (X20 E16). A.2 ATP balance with $-\frac13\Pi_i$ and $m(e_i)$-weighted costs (X02 E8). A.5 Eq. 9 (X04 E19). A.6 Eq. 24 (X06 E25): $da/dt=2v_{gn}+Y_{ox}v_{ox}-D$. A.7 Eq. 24 (X10 E37). A.8 PDF Eq. (12) adds the CK term (X14 E18; X12 E23; X13 E27; Lean da_dt X15/X16 E19). A.10 Eq. 3.1 (X19 E14): identical to A.8. Aleph: CK/PCr buffer retained (lineage table).
- **Derivation material:** X15/X16 E20 (Lean theorem ck_equilibrium_preserves_atp_flux). X23 E17 (GPT §5.2: bookkeeping, not a thermodynamic law). X13 E27 (CK reaction and the ±1.2% ATP claim).
- **Derivation plan:** ATP bookkeeping: 2 ATP per glucose through glycolysis (per unit $v_{gn}$), $Y_{ox}$ per pyruvate through OXPHOS, plus the CK reaction PCr + ADP + H⁺ ⇌ Cr + ATP with mass-action net rate $k_{CK}([PCr][ADP]-[Cr][ATP]/K_{eq})$ (H⁺ absorbed into $K_{eq}$), minus demand. Show the CK-equilibrium reduction (Lean). Reconcile $Y_{ox}$ from P/O ratios: per pyruvate about 12.5 ATP, up to about 15 if shuttled glycolytic NADH is credited; 27.5 looks like a per-glucose figure. Add adenine-nucleotide conservation for [ADP] (not stated).

### T3.3 ATP demand (pump plus maintenance and plasticity costs)

- **Aleph label:** inherited: A.7 annex Eq. 24 / A.6 Eq. 24 (A.8 writes only D_i)
- **Status hint:** phenomenological; not restated after A.7

**Canonical form:**

$$
D = D_{set}\frac{m(a, K_{aD})}{m(a_0, K_{aD})}, \qquad D_{set} = \frac{\Pi}{3} + m(a)\left[P_0 + \beta\sum W + \kappa\sum\left\lvert\frac{dW}{dt}\right\rvert + \kappa_c\sum\frac{dc^+}{dt}\right]
$$

- **Symbols:** $D_{set}$ demand at full ATP; $\Pi$ pump flux in Na units (T1.19), so $\Pi/3$ is ATP; $m(z,K)=z/(z+K)$; $K_{aD}=0.5$ mM; $a_0$ reference ATP; $P_0$ basal cost; $\beta$ maintenance cost per unit weight; $\kappa$ plasticity cost; $\kappa_c$ capture cost (positive part of $dc/dt$); sums over the neuron's synapses.
- **Lineage:** Model A power demand $p_i$ (X20 E17, X01 E15). A.2: consumption terms inside the energy equation (X02 E8). A.5 Eq. 9 (X04 E19). A.6 Eq. 24 (X06 E25) moves them into $D_{set}$. A.7 Eq. 24 (X10 E37), the last explicit statement. A.8–A.10: $D_i$ named ("demand (pump)") without a formula.
- **Derivation material:** X06 E25 (A.6: "the A.2 consumption terms are kept intact inside D_set"). X02 E24-E25 (A.2 energy-balance and Na⁺ integral identities).
- **Derivation plan:** Demand = Na/K pump ATP (1 ATP per 3 Na⁺) + housekeeping + synaptic maintenance + plasticity costs, scaled by a Michaelis–Menten availability factor so demand falls as ATP falls. Flag: $m(a)$ inside the bracket has no stated constant; $\beta$ here should match the $\beta$ in T6.6 and T6.15.

### T3.4 Exact carbon mass balance

- **Aleph label:** inherited: Aleph Sec. 3.1 (First Law statement) / A.8 Tier 3
- **Status hint:** exact (algebraic identity of T3.1)

**Canonical form:**

$$
\frac{d}{dt}\left[G + \Gamma + \frac{L + p}{2}\right] = J_G - \frac{J_L}{2} - \frac{v_{ox}}{2}
$$

- **Symbols:** Pools and fluxes as in T3.1; weights are glucose-equivalents (6-carbon pools weight 1, 3-carbon pools weight 1/2).
- **Lineage:** A.6 P5 (X06 E45, numerical residual 1.4e-4). A.7 Validation 5 (words only, X11 E23). A.8 (X12 E30, X13 E37, X14 E19) with Lean proofs. A.10 inline (X19 E13). Aleph Sec. 3.1 (X21 E8, X22 E8).
- **Derivation material:** Lean: Model_A8_FormalVerification.lean carbon_mass_balance_closure (X17 E14); Model_A8_All_Equations(_patched).lean carbon_mass_balance (X15/X16 E18); X13 E68.
- **Derivation plan:** Weight each pool of T3.1 by its carbon content in glucose-equivalents, sum, and show all internal fluxes ($v_{gn}$, $v_{ga}$, $v_{syn}$, $v_{gly}$, $v_{ex}$) cancel, leaving boundary fluxes and the oxidative sink ($v_{ox}/2$ glucose-equivalents leave as CO₂). Note: Aleph attributes it to the First Law of Thermodynamics, but it is carbon-atom (mass) conservation; O₂ and ATP are outside the ledger.

### T3.5 GLUT1 glucose transport with flow-dependent capillary recruitment

- **Aleph label:** inherited: A.8 PDF Eq. (9)
- **Status hint:** approximations (symmetric carrier) + phenomenological recruitment

**Canonical form:**

$$
J_G = T_G\left[1 + \gamma_G(f - 1)\right]\left[\frac{G_b}{G_b + K_T} - \frac{G}{G + K_T}\right]
$$

- **Symbols:** $T_G$ maximal transport; $\gamma_G\approx0.5$ recruitment coefficient (assumed); $f$ normalized flow (T2.15); $G_b$ blood glucose (5 mM); $K_T$ transporter affinity (5 mM).
- **Lineage:** A.6 Eq. 16 (X06 E17), forced by data (without it tissue glucose fell 80%). A.7 Eq. 16 (X10 E29). A.8 PDF Eq. (9) (X14 E15; X12 E24; X13 E28). A.10: "stabilized substrate delivery under extreme hyperperfusion" (no formula). Aleph Sec. 3.4: Michaelis–Menten for GLUT1 $J_G$. The fly branch $J_G=D_{trachea}\nabla^2G$ is out of scope.
- **Derivation material:** X06 E17 (A.6 justification by data).
- **Derivation plan:** Symmetric simple-carrier (facilitated diffusion) model with equal affinities on both faces gives a net flux proportional to the difference of saturations; capillary recruitment scales the effective transporter number by $1+\gamma_G(f-1)$. Derive the carrier flux from the four-state carrier cycle under the symmetric, rapid-equilibrium assumption.

### T3.6 O₂ delivery with Buxton flow-dependent extraction

- **Aleph label:** inherited: A.8 Tier 3
- **Status hint:** approximations (Buxton model)

**Canonical form:**

$$
J_O = J_{O0}\, f\,\frac{E(f)}{E_0}\cdot\frac{o_a - o}{o_a - o_0}, \qquad E(f) = 1 - (1 - E_0)^{1/f}
$$

- **Symbols:** $J_{O0}$ resting O₂ delivery; $f$ normalized flow; $E(f)$ O₂ extraction fraction; $E_0$ resting extraction; $o_a$ arterial O₂; $o_0$ resting tissue O₂.
- **Lineage:** A.2 domain supply with Buxton extraction (X02 E9-E10). A.5 Eqs. 11-12 (X04 E21-E22). A.6 Eq. 17 (X06 E18). A.7 Eq. 17 (X10 E30). A.8 (X12 E25, X13 E30). Aleph Sec. 3.4 lists E(f) under Michaelis–Menten/Hill kinetics.
- **Derivation material:** X02 E9 (A.2: delivery rises less than flow because extraction falls, giving positive BOLD).
- **Derivation plan:** Buxton–Frank oxygen-limitation model: plug-flow capillary with permeability-limited extraction $E=1-\exp(-PS/F)$; with $PS$ fixed (no recruitment) $E(f)=1-(1-E_0)^{1/f}$; delivery $=F\,E\,C_a$; the factor $(o_a-o)/(o_a-o_0)$ normalizes the back-pressure of tissue O₂ to rest. Note the tension with the capillary recruitment assumed in T3.5.

### T3.7 Pump-coupled neuronal glycolysis with ADP feedback

- **Aleph label:** inherited: A.8 Tier 3
- **Status hint:** phenomenological

**Canonical form:**

$$
v_{gn} = V_{gn}\, m(G, K_G)\,\theta(a)\left[1 + \chi_g\left(\frac{D_{set}}{D_0} - 1\right)\right]_+, \qquad \theta(a) = \frac{a_{max} - a}{a_{max} - a + K_d}
$$

- **Symbols:** $V_{gn}$ maximal rate; $K_G=0.5$ mM; $\chi_g\approx1.49$ pump-demand coupling (calibrated); $D_{set}/D_0$ demand ratio (T3.3); $\theta(a)$ ADP feedback (implicitly ADP $=a_{max}-a$; symbol clashes with thresholds $\theta$); $a_{max}$, $K_d$ constants; $[\cdot]_+$ positive part.
- **Lineage:** A.6 Eq. 18 (X06 E19). A.7 Eq. 18 (X10 E31). A.8 (X12 E26, X13 E32-E33). The A.7 Upgrade doc (X09) claims "direct neuronal glycolysis/LDH redox coupling" replaced ANLS but gives no formula.
- **Derivation material:** X06 E19 (A.6: glycolysis and OXPHOS both driven by ADP; the pump draws preferentially on glycolytic ATP, which makes lactate rise; without it lactate fell 4%).
- **Derivation plan:** Michaelis–Menten in glucose; ADP activation with adenine-nucleotide conservation (ADP = $a_{max}-a$) as a Michaelis–Menten factor; feedforward on pump demand. Phenomenological; state each assumption and the calibration of $\chi_g$.

### T3.8 Astrocytic glycolysis coupled to glutamate uptake (astrocyte–neuron lactate shuttle)

- **Aleph label:** inherited: A.8 Tier 3
- **Status hint:** phenomenological

**Canonical form:**

$$
v_{ga} = m(G, K_G)\left(V_{ga0} + \phi\, V_{glu}\, u\right)
$$

- **Symbols:** $V_{ga0}$ basal astrocytic glycolysis; $V_{glu}$ glutamate-coupled rate; $u$ glutamate cycling/uptake; $\phi\in[0,1]$ ANLS share (default 0.5; not identifiable from bulk data).
- **Lineage:** A.6 Eq. 19 (X06 E20). A.7 Eq. 19 (X10 E32). A.8 (X12 E27, X13 E34). Aleph lineage: lactate shuttle preserved and (A.10.1) coupled to pericyte dilation (T3.14).
- **Derivation material:** X13 E34 (φ sweep 0→1 moves the lactate rise from +21.5% to +26.2%).
- **Derivation plan:** Basal glycolysis plus coupling to Na⁺-dependent glutamate uptake (EAAT → Na/K pump ATP → glycolysis; Pellerin–Magistretti stoichiometry of one glucose per glutamate), scaled by $\phi$.

### T3.9 Glycogen synthesis and glycogenolysis fluxes

- **Aleph label:** inherited: A.8 Tier 3 (v_syn) / A.7 annex Eq. 21 (v_gly)
- **Status hint:** phenomenological; conflicting statements for v_gly

**Canonical form:**

$$
v_{syn} = V_{syn}\, m(G, K_{Gs})\left(1 - \frac{\Gamma}{\Gamma_{max}}\right)
$$

$$
v_{gly} = V_{gl}\, m(\Gamma, K_\Gamma)\left[1 + c_K(u - 1)_+ + c_{NE}\,NE + c_h\,\sigma\left(\frac{G_h - G}{s_h}\right) + c_{h2}\,\sigma\left(\frac{G_{h2} - G}{s_{h2}}\right)\right]
$$

- **Symbols:** $V_{syn}$, $V_{gl}$ maximal rates; $K_{Gs}$, $K_\Gamma$ affinities; $\Gamma_{max}$ glycogen capacity; $c_K$ K⁺/activity activation; $c_{NE}$ noradrenergic activation; $c_h=4$, $c_{h2}=40$ hypoglycaemic activation gains with thresholds $G_h=0.4$, $G_{h2}=0.12$ mM and widths $s_h$, $s_{h2}$.
- **Lineage:** A.6 Eqs. 20-21 (X06 E21-E22). A.7 Eqs. 20-21 (X10 E33-E34), the last explicit $v_{gly}$. A.8 gives $v_{syn}$ explicitly (X13 E35) and $v_{gly}$ only in words ("accelerated by K⁺, NE and G < G_h"). Conflict: the A.7 Upgrade doc (X09 E1) says glycogenolysis became competitive mass action with glucose allosteric inhibition (4 fewer parameters), with no formula.
- **Derivation material:** X06 E22 (graded glycogenolysis under severe glucose lack forced by data, Wender 2000; 34 min aglycaemic survival).
- **Derivation plan:** Synthesis: Michaelis–Menten in glucose with capacity limitation. Breakdown: phosphorylase activation by K⁺, NE (cAMP) and hypoglycaemia expressed as additive sigmoidal activators. Phenomenological; record the version conflict.

### T3.10 Oxidative phosphorylation flux

- **Aleph label:** inherited: A.8 Tier 3
- **Status hint:** phenomenological

**Canonical form:**

$$
v_{ox} = V_{ox}\, m(p, K_p)\, m(o, K_o)\,\theta(a)
$$

- **Symbols:** $V_{ox}$ maximal rate; $K_p=50$ µM, $K_o=3$ µM (A.6); $\theta(a)$ ADP feedback from T3.7.
- **Lineage:** A.6 Eq. 22 (X06 E23). A.7 Eq. 22 (X10 E35). A.8 (X12 E29, X13 E36). A.9 "coupled oxidative phosphorylation to ROS" (no formula; T3.13).
- **Derivation material:** None.
- **Derivation plan:** Bi-substrate Michaelis–Menten in pyruvate and O₂ times ADP respiratory control (state-3/state-4 behaviour).

### T3.11 LDH/MCT pyruvate–lactate exchange and lactate washout

- **Aleph label:** inherited: A.7 annex Eq. 22 / A.6 Eq. 22 (named only in A.8)
- **Status hint:** approximations (linearized near equilibrium)

**Canonical form:**

$$
v_{ex} = k_{ex}\left(p - \frac{L}{\rho}\right), \qquad J_L = k_{Lb}(L - L_b)
$$

- **Symbols:** $k_{ex}=1$ s⁻¹; $\rho=10$ equilibrium L/p ratio (symbol clashes with densities and set points); $k_{Lb}$ washout rate; $L_b=0.715$ mM blood lactate.
- **Lineage:** A.6 Eq. 22 (X06 E23). A.7 Eq. 22 (X10 E35), the last explicit statement. A.8 names $v_{ex}$ (LDH/MCT) and $J_L$ (washout) without formulas.
- **Derivation material:** X06 E23 (exchange through LDH/MCT toward $L/p=\rho$).
- **Derivation plan:** Near-equilibrium linearization of LDH (mass-action ratio $\rho=K_{LDH}[NADH]/[NAD^+]$) and first-order MCT efflux to blood. These two fluxes with $v_{ga}$ (T3.8) constitute the astrocyte–neuron lactate shuttle.

### T3.12 Phosphocreatine / creatine pool dynamics for the CK buffer

- **Aleph label:** claimed: Aleph Sec. 2 lineage table (CK PCr/Cr buffer) — no PCr equation
- **Status hint:** incomplete-in-source

**Canonical form:**

**NOT STATED IN ANY SOURCE**

- **Symbols:** $[PCr]$, $[Cr]$ (and $[ADP]$) appear only inside the CK term of T3.2.
- **Lineage:** The A.7 Upgrade doc says "PCr buffer added" (prose, X09). A.8 adds the CK term to the ATP equation; no $d[PCr]/dt$ appears in A.8, the Lean files, A.10 or Aleph.
- **Derivation material:** None.
- **Derivation plan:** Flag as missing. Natural closure for the derivation author to propose (marked as reconstruction): $d[PCr]/dt=-k_{CK}([PCr][ADP]-[Cr][ATP]/K_{eq})$ with $[PCr]+[Cr]$ and $[ATP]+[ADP]$ conserved, or a rapid-equilibrium elimination giving an effective buffering capacity consistent with the ±1.2% ATP claim.

### T3.13 OXPHOS–ROS coupling

- **Aleph label:** claimed: Aleph Sec. 2 lineage table (A.9: coupled oxidative phosphorylation to ROS)
- **Status hint:** incomplete-in-source

**Canonical form:**

**NOT STATED IN ANY SOURCE**

- **Symbols:** None defined.
- **Lineage:** A.2 colleague note: sleep pressure from mitochondrial electron leak, proposed readout $m(e)(1-C/C_{max})$ (X02 E30, not simulated). A.7 Upgrade doc: synaptic downscaling driven by the ATP/ADP ratio and ROS leak (prose, X09). Aleph lineage table: A.9 "coupled oxidative phosphorylation to ROS". No equation in A.9, A.10 or Aleph.
- **Derivation material:** None.
- **Derivation plan:** Flag as missing. If reconstructed: ROS production ∝ electron-leak fraction × $v_{ox}$, rising when ADP is low (high membrane potential), with first-order scavenging; specify where ROS feeds back (sleep gate, T6.12). Mark any form as reconstruction.

### T3.14 Astrocytic lactate shuttle → local pericyte dilation coupling

- **Aleph label:** claimed: Aleph Sec. 2 lineage table (A.10.1 Tier 3 final fix)
- **Status hint:** incomplete-in-source

**Canonical form:**

**NOT STATED IN ANY SOURCE**

- **Symbols:** None defined. Nearest stated pieces: $v_{ga}$ (T3.8), $v_{ex}$ and $J_L$ (T3.11), pericyte state $\tau_\psi\,d\psi_c/dt=-\psi_c+q_c$ (T2.14), $\beta_{astro}\mathcal{F}_{A2B}$ in the arteriole equation (T2.9).
- **Lineage:** A.7 audit proposed an astrocyte A2B–lactate cascade (no formula, X07 E10). A.8 adds an astrocytic A2B term to arteriole (not pericyte) dilation. Aleph lineage table: A.10.1 "couples astrocytic lactate shuttling directly to local pericyte dilation" — no equation anywhere.
- **Derivation material:** None.
- **Derivation plan:** Flag as missing. A consistent reconstruction would make the pericyte drive $q_c$ in T2.14 a function of astrocytic lactate output (e.g. $q_c\propto v_{ga}$ or lactate concentration via a Hill term); mark as reconstruction.

## Tier 4: Axon initial segment tri-variable leaky controller

Aleph prints no Tier 4 equation. The canonical forms come from A.10 Eq. 4.1 and A.8 Eqs. (13)–(15).

### T4.1 Slow Ca²⁺/activity proxy driving the AIS controller

- **Aleph label:** inherited: A.8 PDF Eq. (13)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_c\frac{d\bar c_i}{dt} = -\bar c_i + c_i(t)
$$

- **Symbols:** $\bar c_i$ filtered proxy; $c_i(t)$ Ca²⁺/depolarization proxy, normalized so $c=1$ at normal activity (A.6); $\tau_c\approx1$ h (A.8; calcineurin/CaMKII timescale; same symbol as the capture time constant in T6.8).
- **Lineage:** A.6 Eq. 25 (X06 E26). A.7 Eq. 25 (X10 E38). A.8 PDF Eq. (13) (X14 E20; X12 E31; X13 E38). Not in the Lean files. A.10 and Aleph: "tri-variable leaky AIS controller" (proxy implicit).
- **Derivation material:** X06 E26 (A.6: both AIS changes act through L-type Ca²⁺ and calcineurin, hence a shared proxy).
- **Derivation plan:** First-order low-pass filter of a Ca²⁺ signal (biochemical integration by calcineurin/CaMKII); give the convolution solution and define $c_i(t)$ from the rate or voltage layer (not stated in source).

### T4.2 AIS length leaky controller (with developmental baseline)

- **Aleph label:** inherited: A.10 Eq. 4.1 (first relation) / A.8 PDF Eq. (13)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_L\frac{dL_i}{dt} = -\left(L_i - L_0(t_g)\right) - G_L\, L_0\,(\bar c_i - 1)
$$

- **Symbols:** $L_i$ AIS length ($L_0=22$ µm, A.6); $\tau_L=5.7$ h; $G_L=0.33$ (Evans 2015); $t_g$ developmental (gestational) age, new in A.10; $\bar c_i$ from T4.1.
- **Lineage:** A.6 Eq. 26 (X06 E27), projected onto $[L_{min},L_{max}]$. A.7 Eq. 26 (X10 E39; X11 E11; X08 E7). A.8 PDF Eq. (13) (X14 E20); Lean dL_dt / dL_ais_dt (X15/X16 E21). A.10 Eq. 4.1 (X19 E15) adds $L_0(t_g)$ in the relaxation term only.
- **Derivation material:** Lean theorem ais_unique_fixed_point (X15/X16 E25; X15 notes a proof flaw: all three cases use $1/L_0>0$ and no $\tau>0$ hypotheses exist). X06 E27 and E48 (A.6: relaxation terms required, otherwise AIS and threshold controllers form two integrators on one error). X23 E19 (GPT §6.1).
- **Derivation plan:** Leaky first-order relaxation toward an activity-shifted target; equilibrium $L^*=L_0[1-G_L(\bar c-1)]$; show uniqueness and stability and why the leak is needed (compare pure-integral control). Flag the mixed $L_0(t_g)$ / $L_0$ in the same equation (A.10).

### T4.3 AIS position leaky controller

- **Aleph label:** inherited: A.8 PDF Eq. (14)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_x\frac{dx_i}{dt} = -(x_i - x_0) + G_x(\bar c_i - 1)
$$

- **Symbols:** $x_i$ AIS distance from soma ($x_0=25$ µm); $\tau_x=24$ h; $G_x=6$ µm (A.6, assumed; carries length units because no $x_0$ factor).
- **Lineage:** A.6 Eq. 26 (X06 E27). A.7 Eq. 26 (X10 E39; X11 E12). A.8 PDF Eq. (14) (X14 E21); Lean dx_dt (X15/X16 E22). A.10 mentions position $x_i$ without writing the equation.
- **Derivation material:** As T4.2 (Lean fixed-point theorem covers x).
- **Derivation plan:** Same leaky-relaxation analysis; depolarization ($\bar c>1$) moves the AIS distally (Grubb & Burrone 2010). Note the asymmetric gain normalization relative to T4.2 and T4.4.

### T4.4 AIS Na-channel density leaky controller

- **Aleph label:** inherited: A.8 PDF Eq. (14)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_g\frac{dg_{AIS,i}}{dt} = -(g_{AIS,i} - g_0) - G_g\, g_0\,(\bar c_i - 1)
$$

- **Symbols:** $g_{AIS,i}$ AIS Na-channel density/conductance; $g_0$ baseline; $\tau_g$ time constant; $G_g$ gain.
- **Lineage:** New in A.8 PDF Eq. (14) (X14 E21; X13 E40), resolving the Jamann deprivation result (rheobase −4.5% → −24.2%); Lean dg_dt (X15/X16 E23). A.10 and Aleph: "tri-variable (L, x, g_AIS)".
- **Derivation material:** As T4.2 (Lean fixed-point theorem covers g).
- **Derivation plan:** Same leaky-relaxation analysis as T4.2.

### T4.5 AIS threshold law

- **Aleph label:** inherited: A.10 Eq. 4.1 (second relation) / A.8 PDF Eq. (15)
- **Status hint:** approximations (resistive-coupling theory); phenomenological as printed

**Canonical form:**

$$
\theta_{AIS,i} = -k_B\ln\left(\frac{L_i}{L_0}\right) - k_x\ln\left(\frac{x_i}{x_0}\right) - k_g\ln\left(\frac{g_{AIS,i}}{g_0}\right)
$$

- **Symbols:** $\theta_{AIS,i}$ threshold shift entering T1.20; $k_B$, $k_x$ slopes (5 mV each, A.6); $k_g$ slope (value not given).
- **Lineage:** A.6 Eq. 27 (X06 E28): L and x terms. A.7 Eq. 27 (X10 E40). A.8 PDF Eq. (15) adds the $k_g$ term (X14 E22; X13 E41); Lean theta_AIS (X15/X16 E24). A.10 Eq. 4.1 (X19 E15).
- **Derivation material:** Lean theorem theta_ais_zero_at_equilibrium (X15/X16 E26). X23 E20 (GPT §6.1: constitutive, not implied by cable theory). X06 E28 (resistive coupling, Goethals & Brette 2020).
- **Derivation plan:** Resistive-coupling theory (Brette 2013; Goethals & Brette 2020): spike threshold $V_{th}\approx V_{1/2}-k_a\ln(\cdot)$ where the argument is proportional to the axial resistance to the AIS (∝ $x$) times the total AIS Na conductance (∝ $g_{AIS}L$). Expanding about the reference gives a sum of logarithms with a common slope $k_a$ (Na-activation Boltzmann slope, about 4–6 mV), i.e. $k_B=k_x=k_g=k_a$. Flag: A.8 prose says distal relocation reduces excitability, which contradicts this sign for $k_x>0$; resolve the sign convention.

## Tier 5: CA1 conductance-based spiking layer, PV block and node eviction

Aleph prints no Tier 5 equation. The canonical forms come from A.8, with the eviction criterion from the Aleph lineage table.

### T5.1 CA1 conductance-based leaky integrate-and-fire membrane with channel noise

- **Aleph label:** inherited: A.8 Tier 5
- **Status hint:** approximations (LIF reduction)

**Canonical form:**

$$
\tau_m\frac{dV_k}{dt} = -(V_k - E_L) - g_{e,k}(t)(V_k - E_e) - g_{i,k}(t)(V_k - E_i) + \sigma_{ch}\sqrt{2\tau_m}\,\xi_k(t)
$$

- **Symbols:** $V_k$ membrane potential of cell $k$ ($N_E=400$ pyramidal, $N_I=80$ PV basket cells, A.8 PDF); $\tau_m$ membrane time constant; $E_L$, $E_e$, $E_i$ reversal potentials; $g_{e,k}$, $g_{i,k}$ excitatory and inhibitory conductances relative to leak (T5.2); $\sigma_{ch}$ channel-noise amplitude; $\xi_k$ unit white noise. Spike at $V_{th}$, reset and refractory period (A.6).
- **Lineage:** A.5: channel-noise hypothesis for fast ripples (text only). A.6 Eq. 28 (X06 E29). A.7 Eq. 28 (X10 E41). A.8 Tier 5 (X12 E34, X13 E42). A.10: prose only. Aleph: "CA1 conductance-based spiking" maintained (lineage table).
- **Derivation material:** X23 E21 (GPT §6.2: conductance-based membrane from $C_m\,dV/dt=-\sum g_j(V-E_j)+I$).
- **Derivation plan:** KCL with leak and synaptic conductances, divided by $g_L$; diffusion approximation of channel noise, where the $\sigma\sqrt{2\tau_m}$ scaling gives a stationary voltage SD of $\sigma$; threshold-reset rule. State that Eq. 5.4 gap currents should enter PV cells here (not written).

### T5.2 Exponential synaptic conductances driven by delayed spike trains

- **Aleph label:** inherited: A.8 Tier 5
- **Status hint:** approximations (standard synapse model)

**Canonical form:**

$$
\frac{dg_{e,k}}{dt} = -\frac{g_{e,k}}{\tau_{AMPA}} + \sum_j W^E_{kj}\,\delta(t - t^E_j - d), \qquad \frac{dg_{i,k}}{dt} = -\frac{g_{i,k}}{\tau_{GABA}} + \sum_m W^I_{km}\,\delta(t - t^I_m - d)
$$

- **Symbols:** $\tau_{AMPA}=1.0$ ms, $\tau_{GABA}=1.5$ ms, delay $d=0.6$ ms (A.6); $W^E$, $W^I$ synaptic weights; $t_j$ presynaptic spike times.
- **Lineage:** A.6 Eq. 29 (X06 E30) as jump-and-decay. A.7 Eq. 29 (X10 E42). A.8 (X12 E35, X13 E43).
- **Derivation material:** None.
- **Derivation plan:** First-order kinetic scheme with instantaneous rise: integrate the delta train to obtain jumps of size $W$ followed by exponential decay; tuned so ripples sit near 150 Hz.

### T5.3 Extracellular Ca²⁺ depletion truncating fast-ripple bursts

- **Aleph label:** inherited: A.8 PDF Eq. (16) (Aleph lineage: PV block with [Ca2+]e cutoff)
- **Status hint:** phenomenological; incomplete-in-source (influx and release coupling)

**Canonical form:**

$$
\tau_{Ca}\frac{d[Ca^{2+}]_e}{dt} = -I_{Ca,burst} + \frac{[Ca^{2+}]_{e,0} - [Ca^{2+}]_e}{\tau_{ref}}
$$

- **Symbols:** $[Ca^{2+}]_e$ interstitial Ca (rest $[Ca^{2+}]_{e,0}=1.2$ mM, falling below 0.6 mM during bursts); $I_{Ca,burst}$ burst-driven Ca influx (form never given); $\tau_{Ca}$, $\tau_{ref}$ time constants (redundant scaling).
- **Lineage:** New in A.8 PDF Eq. (16) (X14 E23; X12 E36; X13 E44): A.7 fast ripples ran over 90 ms as seizures. Lean dCa_dt (X15/X16 E27). A.10: prose ("truncated by interstitial calcium depletion d[Ca2+]e/dt", X19). Aleph lineage table: A.8 "CA1 PV depolarization block with [Ca2+]e cutoff".
- **Derivation material:** Lean theorem calcium_recovery_equilibrium (X15/X16 E28). X13 E44 (burst ends after 10–30 ms, model 22.4 ms, cluster lags 2.75 ms).
- **Derivation plan:** Extracellular Ca balance in a fixed ECS volume: influx through VGCC/NMDA during bursts (∝ population spike rate × charge$/(2F\,Vol)$), refill by diffusion from bath/blood as first order. Flag: $I_{Ca,burst}$ unspecified; the coupling of $[Ca^{2+}]_e$ to release probability (e.g. Dodge–Rahamimoff $p\propto[Ca]^4$) is only verbal.

### T5.4 PV interneuron depolarization block rule

- **Aleph label:** claimed: Aleph Sec. 2 lineage table (A.8 CA1 PV depolarization block)
- **Status hint:** incomplete-in-source

**Canonical form:**

**NOT STATED IN ANY SOURCE**

- **Symbols:** None defined for the spiking layer.
- **Lineage:** A.6 Eq. 30 (X06 E31): "pathology = PV cells in depolarisation block + recurrent E–E clusters" (no formula). A.7 Eq. 30. A.8 Tier 5 text (Schlingloff 2025). The rate layer has only the Na-fatigue surrogate $[1+(n_i/n_c)^6]^{-1}$ (T1.20).
- **Derivation material:** None.
- **Derivation plan:** Flag as missing. A reconstruction could impose a Na-inactivation-based block (spike failure when $V_k$ stays above a block voltage for longer than a set time) or reuse the Na-fatigue factor per PV cell; mark as reconstruction.

### T5.5 Per-spike Na⁺ load linking spiking events to the sodium ledger

- **Aleph label:** inherited: A.7 annex Eq. 30 / A.6 Eq. 30
- **Status hint:** approximations

**Canonical form:**

$$
\Delta n_i = \nu_{spk}\quad \text{per spike}
$$

- **Symbols:** $\Delta n_i$ Na increment of the ledger (T1.18) per spike; $\nu_{spk}$ Na per spike.
- **Lineage:** A.6 Eq. 30 (X06 E31), A.7 Eq. 30 (X10 E43): spikes share the Na ledger of Eq. 5. A.8 Inference 2: a fast-ripple event costs about 25 $\nu_{spk}$ (X13 E61); A.8 gives the capacitive basis of $\nu_{spk}$ (X13 E60).
- **Derivation material:** X13 E60 (capacitive Na per spike formula).
- **Derivation plan:** Event-driven form of the T1.18 influx: Na per action potential ≈ $C_m\Delta V/(F\,Vol)$ times an overlap (inefficiency) factor; connects Tier 5 events to Tier 1 and Tier 3 energetics.

### T5.6 Apoptotic node eviction rule

- **Aleph label:** inherited: Aleph Sec. 2 lineage table (A.9 apoptotic eviction protocol)
- **Status hint:** phenomenological (event rule); incomplete-in-source

**Canonical form:**

$$
a_i < 0.05\, a_0 \;\Rightarrow\; \text{node } i \text{ is evicted}
$$

- **Symbols:** $a_i$ node ATP; $a_0$ baseline ATP.
- **Lineage:** A.9: "graceful apoptotic eviction protocol" named, no equation (X18 E12 note). Aleph lineage table, A.9 column, gives the criterion "$a_i<0.05\,a_0$" (X21 E5, X22 E5). A.10: "permanently depolarized nodes undergo graceful apoptotic eviction" (prose). Aleph: maintained.
- **Derivation material:** X23 E21 (GPT §6.2: a hybrid-system event rule needs a death criterion, threshold, hysteresis and bookkeeping).
- **Derivation plan:** Hybrid-system event rule: specify the trigger (ATP-based in the table versus "permanently depolarized" in A.10; reconcile), the removal of the node's states, redistribution or deletion of its $W_{ij}$, and conservation of the Na, ATP and carbon ledgers after removal. The 0.05 threshold is a parameter, not derivable.

## Tier 6: Plasticity, epigenetics and decay

Aleph prints Eqs. 5.10, 5.11 and 4.1. The remaining entries are the inherited Tier 6 components (headroom, capture SDE, circadian pruning, REM projection, glymphatic peristalsis, ontogenetic tensor, angiogenesis, AQP4 degradation, TrkB-BDNF, set-point remodeling) and the Sec. 3 Kramers forgetting law.

### T6.1 Epigenetic HDAC chromatin condensation operator and BDNF silencing

- **Aleph label:** Aleph Eq. 5.10
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_{epig}\frac{dH_{HDAC}}{dt} = k_{stress}\,F_{chronic\_stress} - k_{acetyl}\,a_i\,H_{HDAC}, \qquad k_{BDNF,eff} = \frac{k_{BDNF}}{1 + \exp\left(\gamma_{silence}(H_{HDAC} - \theta_{epig})\right)}
$$

- **Symbols:** $H_{HDAC}$ HDAC2/5 chromatin-condensation state (units never defined); $\tau_{epig}$ time constant; $k_{stress}$ stress integration rate (T6.3; Aleph Table 3: mouse 0.080, rat 0.060, zebrafish 0.020, pigeon 0.015, macaque 0.010, human 0.003 d⁻¹, fly 0); $F_{chronic\_stress}$ chronic-stress forcing (never defined); $k_{acetyl}$ acetylation rate; $a_i$ ATP; $k_{BDNF}$ baseline BDNF/TrkB coupling (T6.20); $\gamma_{silence}$ logistic slope; $\theta_{epig}$ threshold.
- **Lineage:** New in Aleph (A.10.1 final fix for multi-year depression; failed spine-deficit test #25, fixed in #66). Aleph Eq. 5.10 (X21 E26, X22 E26). No precursor.
- **Derivation material:** X23 E24 (GPT §7.4: driven first-order state plus logistic repression; phenomenological; units of $H$ undefined).
- **Derivation plan:** Linear driven first-order ODE: closed-form solution for constant inputs, steady state $H^*=k_{stress}F/(k_{acetyl}a_i)$, relaxation time $\tau_{epig}/(k_{acetyl}a_i)$; justify the ATP factor (acetyl-CoA / HAT activity). Logistic repression as a two-state (open/condensed) promoter occupancy with free energy linear in $H$. Flag: $k_{BDNF,eff}$ presumably replaces $k_{BDNF}$ in T6.20 (not stated); normalization and units of $H$, $F$.

### T6.2 Regularized non-singular hydraulic floor for AQP4-dependent conductivity

- **Aleph label:** Aleph Eq. 5.11
- **Status hint:** phenomenological (bounds exact)

**Canonical form:**

$$
L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp\left(\lambda\,(P_{AQP4}(t) - 1)\right)
$$

- **Symbols:** $L_p$ trans-astrocytic hydraulic conductivity; $L_{p,0}$ baseline; $L_{p,min}$ floor; $\lambda$ decay constant (dimensionless; symbol reused widely); $P_{AQP4}\in[0,1]$ AQP4 polarity (T6.19).
- **Lineage:** A.9 (X18 E13, image checked): $L_p(t)=L_{p,0}e^{\lambda(P_{AQP4}(t)-1)}$, no floor. A.10 Eq. 6.3 (X19 E18) adds the floor to prevent $R_{PVS}\to\infty$ stiffness. Aleph Eq. 5.11 (X21 E27, X22 E27): identical to A.10; lineage table "$L_p\ge L_{p,min}$".
- **Derivation material:** X23 E23 (GPT §7.3: bounds check, requires $\lambda$ dimensionless and $L_{p,0}>L_{p,min}\ge0$).
- **Derivation plan:** Algebraic properties: for $P\in[0,1]$, $L_p\in[L_{p,min}+(L_{p,0}-L_{p,min})e^{-\lambda},L_{p,0}]$, monotone in $P$, equal to $L_{p,0}$ at $P=1$, never zero. State the (missing) relation $R_{PVS}\propto1/L_p$ used in T2.16. The exponential map itself is constitutive.

### T6.3 Glucocorticoid-receptor stress integration rate

- **Aleph label:** Aleph Eq. 4.1
- **Status hint:** approximations (Hill occupancy)

**Canonical form:**

$$
k_{stress} = k_{transloc}\cdot\left[\frac{([CORT]_{free})^{n_H}}{(K_{d,GR})^{n_H} + ([CORT]_{free})^{n_H}}\right]
$$

- **Symbols:** $[CORT]_{free}$ free glucocorticoid (cortisol in primates, corticosterone in rodents; nM); $K_{d,GR}$ GR dissociation constant (2.4 nM human, 4.8 nM rodent, in vitro); $n_H\approx1.8$ Hill coefficient attributed to GR homodimerization; $k_{transloc}$ nuclear import rate constant (1/time).
- **Lineage:** New in Aleph Sec. 4.1 (X21 E15, X22 E15), replacing an empirically fitted rate.
- **Derivation material:** X23 E25 (GPT §7.5: Hill occupancy × translocation rate; dimensionally plausible; not first-principles for dimerization). X22 E15.
- **Derivation plan:** Cooperative ligand binding to GR leads to a Hill occupancy (limit of concerted $n$-site binding; non-integer $n_H$ is empirical); nuclear translocation is rate-limiting, so the effective rate is $k_{transloc}$ × occupied fraction. Optionally derive from an explicit monomer–dimer equilibrium and compare with the Hill approximation. Check the species values in Table 3 (needs $[CORT]$ and $k_{transloc}$, which are not given).

### T6.4 Three-factor synaptic weight dynamics with headroom gate and eviction

- **Aleph label:** inherited: A.8 PDF Eq. (17) (Aleph: synaptic headroom)
- **Status hint:** phenomenological; barrier property exact under A.2/A.5 definitions

**Canonical form:**

$$
\tau_w\frac{dW_{ij}}{dt} = (1 - b_m)\left[(s_Q + \psi(1 - s_Q))\,DA^+ f^+_{ij}(w_{max} - W_{ij}) - (1 + DA^-)\,f^-_{ij}W_{ij} - E_{ij}\right] - \gamma(1 - P_{ij})W_{ij}
$$

- **Symbols:** $W_{ij}$ synaptic weight; $\tau_w$ time constant (same symbol as adaptation, T1.8); $b_m$ learning brake (never defined in any version); $DA^\pm$ positive/negative dopamine prediction error; $f^\pm_{ij}$ potentiation/depression eligibility (never defined; Model A: $f^\pm(r_i,r_j)$); $s_Q$ supply gate (T6.6); $\psi\in[0,1]$ salience gate (A.2; same symbol as the pericyte state); $w_{max}$ ceiling; $E_{ij}$ eviction current (T6.6); $\gamma$ decay of unprotected weight; $P_{ij}$ persistence (T6.7).
- **Lineage:** Model A T13' (X20 E18, X01 E18): gate $DA^+s_Qf^+$, eviction outside. A.2 (X02 E16): matched gate $s+\psi(1-s)$ and eviction. A.5 Eq. 17 (X04 E27): $E_{ij}$ outside the bracket. A.6 Eq. 32 (X06 E33): $E_{ij}$ inside the $(1-b_m)$ bracket. A.7 Eq. 32 (X10 E43b). A.8 PDF Eq. (17) (X14 E25; X12 E37; X13 E45). Aleph: "synaptic headroom" inherited.
- **Derivation material:** X02 E26 (A.2 Property 3, exact energy barrier: summing over a domain cancels the extra potentiation against eviction, giving $\dot h_Q\ge-\gamma_hh_Q$ and $h_Q(t)\ge h_Q(0)e^{-\gamma_ht}$). X04 E7 (A.5 change log). X05 E12 (A.4 validation of Theorem 3).
- **Derivation plan:** Three-factor rule: Hebbian eligibility × dopamine, soft bounds $(w_{max}-W)$ and $W$, energetic gate $s_Q$, eviction, decay of unprotected synapses. Re-derive the barrier invariance: sum over $Q$, substitute T6.6, apply Gronwall. Flag: A.8 redefines $h_Q$ in demand units (T6.5), so the A.2/A.5 proof must be redone or the definitions reconciled; whether $E_{ij}$ sits inside or outside the brake changes the cancellation.

### T6.5 Vascular metabolic headroom of a supply territory

- **Aleph label:** inherited: A.8 Tier 6 (Aleph: synaptic headroom)
- **Status hint:** exact (definition); constraint maintained by T6.6 and T6.15

**Canonical form:**

$$
h_Q = D_{cap} - \sum_{k\in Q} D_k \ge 0
$$

- **Symbols:** $h_Q$ headroom of territory $Q$ (set of synapses/nodes drawing on one capillary node, A.6); $D_{cap}$ vascular supply capacity; $D_k$ demand of member $k$ (T3.3).
- **Lineage:** Model A: $h_{C,Q}=C_{max,Q}-\beta\sum_{kl\in Q}W_{kl}$ (X01 E17). A.2 (X02 E17) and A.5 Eq. 18 (X04 E28): same weight-cost form. A.6 Eq. 35 uses $h_Q$. A.8 (X12 E38, X13 E47, X14 E24) redefines it in demand units with the explicit constraint $\ge0$; "as $h_Q\to0$, $s_Q\to0$" (verbal).
- **Derivation material:** X02 E26 (barrier proof under the weight-cost definition).
- **Derivation plan:** Definition plus invariant statement. Show how $s_Q$ (T6.6) and $\lambda_Q$ (T6.15) keep $h_Q\ge0$; reconcile the two definitions (energy demand versus $\beta\sum W$) and the meaning of $\beta$ (energy per unit weight).

### T6.6 Headroom supply gate and salience-weighted eviction allocation

- **Aleph label:** inherited: A.5 Eqs. 18-19 (s_Q, E_ij used without formula from A.6 on)
- **Status hint:** exact (barrier construction); not restated after A.5

**Canonical form:**

$$
s_Q = \min\left\lbrace 1, \frac{D_Q + \gamma_h\tau_w h_Q/\beta}{\Pi_Q}\right\rbrace, \qquad h_Q = C_{max,Q} - \beta\sum_{kl\in Q}W_{kl}
$$

$$
E_{ij} = \psi(1 - s_Q)\,\Pi_Q\left[\frac{\omega_{ij}}{\sum_{kl\in Q}\omega_{kl}}\right], \qquad \omega_{ij} = (1 - P_{ij})\,W_{ij}\exp(-f^+_{ij}/f_0)
$$

- **Symbols:** $D_Q$ total depression plus decay in $Q$; $\Pi_Q$ total potentiation drive in $Q$ (same letter as the pump rate, a clash); $\gamma_h$ barrier rate; $\beta$ cost per unit weight; $C_{max,Q}$ weight-cost cap; $f_0$ recency scale; $\omega_{ij}$ eviction weights favouring unprotected, strong, non-recent synapses.
- **Lineage:** Model A Eqs. 7-8 (X01 E19-E20; X20 E19): $s_Q$ with $\Delta_Q$ and $\bar\Pi_Q+\varepsilon$; eviction weights $(1-\Omega+\varepsilon)W$. A.2 (X02 E16-E17). A.5 Eqs. 18-19 (X04 E28-E29), the last explicit statement. A.6 refers to "$s_Q$, $E_{ij}$ as in A.4 Eqs. 15-16"; A.8 states only that $s_Q\to0$ as $h_Q\to0$.
- **Derivation material:** X02 E26 (A.2 exact barrier proof). X04 E7 (A.5 change log: eviction cancellation guarantees $h_Q\ge0$, "Theorem 3"). X05 E12.
- **Derivation plan:** Choose $s_Q$ as the largest gate ≤ 1 such that the domain-summed weight change satisfies $\beta\sum_Q\dot W\le\gamma_hh_Q$; allocate the excess potentiation $\psi(1-s_Q)\Pi_Q$ as eviction proportional to $\omega_{ij}$ so the domain sums cancel exactly. Treat the non-smooth $\min$ with Filippov solutions. Flag: Aleph uses the A.8 demand-based $h_Q$ (T6.5), inconsistent with this weight-based $h_Q$.

### T6.7 Synaptic tag dynamics and persistence variable

- **Aleph label:** inherited: A.7 annex Eq. 34 (Omega) / A.8 Tier 6 (P_ij)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_\Omega\frac{d\Omega_{ij}}{dt} = \kappa_\Omega\,DA^+ f^+_{ij}(1 - \Omega_{ij}) - \Omega_{ij}, \qquad P_{ij} = \max(\Omega_{ij}, c_{ij})
$$

- **Symbols:** $\Omega_{ij}\in[0,1]$ synaptic tag; $\tau_\Omega$ time constant; $\kappa_\Omega$ tagging gain; $c_{ij}$ capture variable (T6.8); $P_{ij}$ persistence protecting a synapse from decay.
- **Lineage:** Model A: Benna–Fusi cascade, $\Omega=u^1$ (X20 E21, X01 E22). A.2 (X02 E18): bounded fast tag. A.5 Eqs. 20, 22 (X04 E30, E32). A.6 Eq. 34 (X06 E35). A.7 Eq. 34 (X10 E43d), the last explicit $\Omega$ dynamics. A.8: $P_{ij}=\max(\Omega_{ij},c_{ij})$ (X12 E37, X13 E46).
- **Derivation material:** X02 E23 (A.2 Property 1: logistic forms keep the state box forward-invariant).
- **Derivation plan:** Logistic-bounded first-order tag driven by dopamine-gated eligibility; prove invariance of $[0,1]$; persistence as the maximum of tag and capture.

### T6.8 Energy-gated bistable condensate capture SDE

- **Aleph label:** inherited: A.8 PDF Eq. (18) (Aleph: condensate capture SDE on [0, 1])
- **Status hint:** phenomenological; boundary invariance exact

**Canonical form:**

$$
\tau_c\, dc_{ij} = \left[\Omega_{ij}\,\pi(a_i)(1 - c_{ij}) + \beta_c\frac{c_{ij}^2(1 - c_{ij})}{K_c^2 + c_{ij}^2} - \gamma_c\, c_{ij}\right]dt + \sigma_c\, c_{ij}(1 - c_{ij})\, dB_{ij}
$$

- **Symbols:** $c_{ij}\in[0,1]$ capture (condensate) variable; $\tau_c$ time constant (same symbol as the AIS proxy, T4.1); $\Omega_{ij}$ tag (T6.7); $\pi(a_i)$ energy gate (T6.9); $\beta_c$ cooperative self-recruitment gain (same symbol as the capillary gain, T2.14); $K_c$ Hill constant; $\gamma_c$ dissolution rate; $\sigma_c$ noise amplitude; $B_{ij}$ Brownian motion.
- **Lineage:** A.2 (X02 E19): deterministic $\tau_c\dot c=\Omega\pi(e_Q)(1-c)-\gamma_cc$. A.3 (X03 E5): bistable Hill term $\beta_cc^2/(K_c^2+c^2)$ with additive noise $\sqrt{2D}\xi$. A.5 Eq. 21 (X04 E31): same. A.4/A.5 validation (X05 E10): $c$ exceeds 1 if $\beta_c>\gamma_c(1+K_c^2)$; proposes $c^2(1-c)$ and $\sigma c(1-c)dW$. A.6 Eq. 33 (X06 E34): repaired form. A.7 Eq. 33 (X10 E13; mixes $dc/dt$ and $dB$). A.8 PDF Eq. (18) (X14 E26; X12 E39; X13 E48); Lean drift and diffusion (X15/X16 E29-E30, X17 E7-E8).
- **Derivation material:** Lean: Model_A8_FormalVerification.lean capture_diffusion_vanishes_at_zero, capture_diffusion_vanishes_at_one, capture_drift_nonnegative_at_zero, capture_drift_negative_at_one (X17 E9); capture_diffusion_boundary_zero (X15/X16 E31). X06 E42 (A.6 P2: 0 of 20,000 paths leave [0,1]). X23 E22 (GPT §7.1: Itô/Stratonovich caveat; Kramers approximation).
- **Derivation plan:** Drift = energy-gated, tag-driven capture + cooperative (Hill-2) self-recruitment of the scaffold condensate + first-order dissolution; multiplicative Wright–Fisher-type noise $c(1-c)$. Prove forward invariance of $[0,1]$ (Feller boundary classification, or Itô plus drift signs at the boundaries). Note that the drift at $c=0$ is $\Omega\pi\ge0$, not zero: the A.6/A.8 prose saying the drift vanishes at both ends is wrong, and the Lean lemmas are right. Analyse the bistability of the deterministic drift (conditions on $\beta_c$, $K_c$, $\gamma_c$).

### T6.9 Capture energy gate

- **Aleph label:** inherited: A.5 Eq. 22 (pi(a_i) used without form from A.6 on)
- **Status hint:** phenomenological; not restated after A.5

**Canonical form:**

$$
\pi(e) = \frac{e^4}{e^4 + e_\pi^4}
$$

- **Symbols:** $e$ normalized energy (A.2–A.5 lumped energy; presumably $a_i/a_0$ from A.6 on, as for $\chi$); $e_\pi$ half-point.
- **Lineage:** A.2 (X02 E20). A.5 Eq. 22 (X04 E32), the last explicit statement. A.6–A.8 write $\pi(a)$ or $\pi(a_i)$ without a form.
- **Derivation material:** X02 E19 (A.2: capture gated by local mitochondrial metabolism; starvation and spacing effects).
- **Derivation plan:** Hill-4 gate (cooperative ATP dependence of condensate formation/local translation); state the normalization $e=a/a_0$.

### T6.10 Kramers-escape power-law forgetting (retention curve)

- **Aleph label:** inherited: Aleph Sec. 3.1 (Kramers escape) / A.8 Tier 6
- **Status hint:** approximations (Kramers limit, assumed barrier distribution); the averaging integral is exact

**Canonical form:**

$$
P(t) \propto t^{-\sigma_c^2/\mu} \quad (\text{Aleph}), \qquad P(t) \simeq \Gamma\left(1 + \frac{\sigma_c^2}{\mu}\right)\left(\frac{t}{\tau_0}\right)^{-\sigma_c^2/\mu}, \quad p(\Delta U) \propto \exp(-\Delta U/\mu) \quad (\text{A.8})
$$

- **Symbols:** $P(t)$ surviving (retained) fraction; $\sigma_c$ capture noise amplitude (T6.8); $\mu$ mean barrier depth; $\Delta U$ barrier height; $\tau_0$ attempt time; $\Gamma$ gamma function. A.3/A.7 write the exponent as $D/\mu$ with noise intensity $D$.
- **Lineage:** A.2 (X02 E31): lifetime density $\propto\gamma^{a-1}$ gives $t^{-a}$ "by construction". A.3 (X03 E12-E13): Kramers escape $\tau=\tau_0e^{\Delta U/D}$ averaged over exponential barriers (simulated exponents 0.499 and 0.250). A.4/A.5 validation, Theorem 5 (X05 E13). A.6 P11 (X06 E51): the exponential barrier distribution is an assumption. A.7 Sec. 2 (X10 E43j). A.8 (X12 E40, X13 E49-E50, E63); A.8 PDF quotes $P\propto t^{-0.35}$ (X14 E34). Aleph Sec. 3.1 (X21 E9, X22 E9).
- **Derivation material:** X03 E12-E13 (closed form, numerical checks). X05 E13. X06 E51. X23 E22 (GPT: a power law does not follow automatically from an arbitrary double-well SDE).
- **Derivation plan:** (1) Kramers rate for escape from the captured well of the T6.8 drift, $k=\tau_0^{-1}\exp(-\Delta U/D)$, with an effective noise intensity $D$ derived from $\sigma_c$ (evaluate $\sigma_c^2c^2(1-c)^2/2$ at the well; state the approximation). (2) Survival of one synapse $e^{-kt}$. (3) Average over $p(\Delta U)=\mu^{-1}e^{-\Delta U/\mu}$: with $y=(t/\tau_0)e^{-\Delta U/D}$, $P(t)=(D/\mu)(t/\tau_0)^{-D/\mu}\gamma(D/\mu,t/\tau_0)\to\Gamma(1+D/\mu)(t/\tau_0)^{-D/\mu}$ for $t\gg\tau_0$. (4) Identify $D$ with $\sigma_c^2$ and flag that $p(\Delta U)$ is assumed, not derived.

### T6.11 Wake accumulation and circadian-gated sleep downscaling of synapse number

- **Aleph label:** inherited: A.8 PDF Eq. (19) (Aleph: pre-dawn circadian sleep pruning)
- **Status hint:** exact (closed form of the stated ODE); model phenomenological

**Canonical form:**

$$
\text{Wake: } \frac{dS_i}{dt} = g_w\,\mathcal{C}(t)\,(1 + \alpha A_r)
$$

$$
\text{Sleep: } S_i(t) = S_{set} + \left(S_i(t_0) - S_{set}\right)\exp\left(-k_{down}\int_{t_0}^{t}\Theta_{circ}(t')\,u(t')\,dt'\right)
$$

- **Symbols:** $S_i$ synapse number/synaptic level; $g_w$ wake gain (zebrafish 1.65 synapses/h); $\mathcal{C}(t)$ circadian wake factor ($\to0$ under constant light in zebrafish); $\alpha$ arousal gain; $A_r$ arousal (never defined); $S_{set}$ set point (dynamic from A.10, T6.21); $k_{down}$ downscaling rate (zebrafish fit 0.069/h, A.3); $\Theta_{circ}$ circadian tensor (T6.13); $u$ sleep gate (T6.12).
- **Lineage:** Model A / A.2: SWS map $W\leftarrow(1-\delta(1-P))W$ (X02 E21, X01 E23). A.3 (X03 E4, E10-E11): continuous gate $dS/dt=-ku(S-S_{set})$ and exponential relaxation with $k$ fitted from loss/excess. A.5 Eq. 24 (X04 E34). A.4/A.5 validation (X05 E3, E14) proposes the exact flow and $g_w=g_0\mathcal{C}(t)(1+\mathrm{arousal})$. A.6 Eq. 37 (X06 E38): unified operator. A.7 Eq. 37 (X10 E43g); the A.7 Upgrade doc claims an ATP/ADP–ROS gate (no formula). A.8 PDF Eq. (19) adds $\Theta_{circ}$ (X14 E27; X12 E41-E42; X13 E51-E52). A.10 Eq. 6.2 makes $S_{set}$ dynamic.
- **Derivation material:** X03 E10-E11 (integration of the gated relaxation; zebrafish numbers −11.7 predicted versus −11.9 observed). X05 E14. X13 E52.
- **Derivation plan:** Write the sleep ODE $dS/dt=-k_{down}\Theta_{circ}(t)u(t)(S-S_{set})$; it is linear with a time-varying rate, so an integrating factor gives the printed closed form. Reproduce the zebrafish fit $k=-\ln(1-L/E)/\Delta t$. Generalize by variation of constants when $S_{set}$ evolves (T6.21). Flag: the A.7 ROS gate conflicts with the A.8 adenosine/NE gate.

### T6.12 Adenosine/noradrenaline product sleep gate

- **Aleph label:** inherited: A.8 Tier 6 (unnumbered, between Eqs. 19 and 20)
- **Status hint:** phenomenological

**Canonical form:**

$$
u(t) = \sigma\left(\frac{[Ado] - \theta_A}{s_A}\right)\left[1 - \sigma\left(\frac{NE - \theta_N}{s_N}\right)\right]
$$

- **Symbols:** $\sigma$ logistic; $[Ado]$ interstitial adenosine (T6.14); $NE$ noradrenaline level (its link to $NE_{LC}$ of Eq. 5.7 is not stated); $\theta_A$, $\theta_N$ thresholds; $s_A$, $s_N$ widths.
- **Lineage:** A.3: gate needs high Ado and low NE (X03 E4). A.5 Eq. 25 (X04 E35). A.4 validation fits the product gate (X05 E1). A.6 Eq. 37 (X06 E38). A.7 Upgrade doc claims replacement by ATP/ADP and ROS (no formula). A.8 (X14 E28; X12 E43; X13 E53); Lean sigmoidal_gate (X15/X16 E32).
- **Derivation material:** X05 E1 (model comparison: best χ², the only variant giving loss only for 2-chloroadenosine + clonidine).
- **Derivation plan:** Product of independent logistic occupancies (A1 receptor activation by adenosine; α2/β-adrenergic suppression by NE). Phenomenological; tie $NE$ to $\mathrm{Re}(NE_{LC})$ or its mean if the derivation author unifies with T2.2.

### T6.13 Pre-dawn circadian pruning tensor

- **Aleph label:** inherited: A.8 PDF Eq. (20)
- **Status hint:** phenomenological

**Canonical form:**

$$
\Theta_{circ}(t) = \frac{1}{1 + \exp\left(\frac{t - t_{dawn}}{\tau_{circ}}\right)}
$$

- **Symbols:** $t_{dawn}$ subjective dawn; $\tau_{circ}$ transition width. Called a "tensor" but scalar in every source; zebrafish branch uses a 14:10 photoperiod form (not written).
- **Lineage:** New in A.8 PDF Eq. (20) (X14 E29; X12 E43; X13 E53): arrests pruning in the last 2 h before dawn. A.8 Inference 4: barrier elevation $\Delta U_{eff}(t)=\Delta U_0[1+\zeta_{circ}\sigma((t-t_{dawn})/\tau_{circ})]$ (X13 E64). A.10 Eq. 6.2 uses $1-\Theta_{circ}$ (T6.21). Aleph lineage table: "pre-dawn circadian sleep pruning tensor $\Theta_{circ}(t)$".
- **Derivation material:** X13 E64 (A.8 inference, +45% barrier before dawn).
- **Derivation plan:** Logistic switch in clock time; phenomenological. Flag: A.8 gates pruning by $\Theta_{circ}$ (pruning stops near dawn) while A.10 Eq. 6.2 gates pruning by $1-\Theta_{circ}$ (pruning starts near dawn), an apparent sign inversion; $\Delta U_{eff}$ uses the complementary sigmoid.

### T6.14 Interstitial adenosine (sleep pressure) dynamics

- **Aleph label:** inherited: A.7 annex Eq. 36 / A.6 Eq. 36
- **Status hint:** phenomenological; not restated after A.7

**Canonical form:**

$$
\frac{d[Ado]}{dt} = \eta\,\Pi_Q - \lambda_u[Ado] - v_{glymph}[Ado]
$$

- **Symbols:** $[Ado]$ interstitial adenosine; $\eta$ yield per pump turnover; $\Pi_Q$ pump flux over territory $Q$; $\lambda_u$ uptake rate; $v_{glymph}$ glymphatic clearance (T6.16).
- **Lineage:** A.5 Eq. 23 (X04 E33). A.4 validation: clearance time constant 0.56 h fitted (X05 E2). A.6 Eq. 36 (X06 E37). A.7 Eq. 36 (X10 E43f; X11 E18), the last explicit statement. A.8 uses $[Ado]$ in $u(t)$ without restating its dynamics.
- **Derivation material:** None.
- **Derivation plan:** Adenosine balance: production ∝ ATP turnover by the pump (ATP → ADP → AMP → adenosine), first-order uptake, convective glymphatic washout. Flag: $v_{glymph}$ is a velocity used as a rate constant (units).

### T6.15 REM weight jump with headroom projection

- **Aleph label:** inherited: A.8 Tier 6
- **Status hint:** exact (projection construction); map phenomenological

**Canonical form:**

$$
\Delta W = \lambda_Q\,\eta_R\,P\,(w_{max} - W) - \pi_R\,(1 - P)\,\sigma\left(\frac{w_p - W}{s_w}\right)W, \qquad \lambda_Q = \min\left\lbrace 1, \frac{h_Q/\beta + \sum \mathrm{dec}}{\sum \mathrm{inc}}\right\rbrace
$$

- **Symbols:** $\eta_R$ REM strengthening rate; $P$ persistence (T6.7); $\pi_R$ pruning strength (letter clash with the energy gate $\pi$); $w_p$ pruning threshold; $s_w$ width; $\lambda_Q$ headroom projection scalar; $\sum\mathrm{inc}$, $\sum\mathrm{dec}$ total increments and decrements in $Q$; $\beta$ cost per unit weight.
- **Lineage:** Model A REM map $W\leftarrow W+\eta_R\Omega(w_{max}-W)$ (X20 E22, X01 E24). A.2 adds pruning (X02 E22) and a contraction bound (X02 E27). A.4/A.5 validation proposes the projection $\min(1,h/(\beta\sum\Delta W^+))$ (X05 E12). A.6 Eq. 35 (X06 E36). A.7 Eq. 35 (X10 E43e). A.8 (X12 E44-E45, X13 E54-E55).
- **Derivation material:** X06 E43 (A.6 P3: $\beta(\lambda_Q\sum\mathrm{inc}-\sum\mathrm{dec})\le h_Q$; headroom 0.0028 → 0.000). X02 E27 (A.2 Property 4: Lipschitz constant $\le1+\pi_Rw_p/(4s_w)$).
- **Derivation plan:** Discrete map: derive $\lambda_Q$ as the largest scalar in $[0,1]$ keeping post-jump headroom non-negative; derive the Lipschitz bound of the pruning term (maximum slope of $W\sigma((w_p-W)/s_w)$). Flag the $h_Q$ definition mismatch (T6.5).

### T6.16 Glymphatic peristalsis velocity driven by infraslow NE oscillations

- **Aleph label:** inherited: A.8 Tier 6 (Aleph: glymphatic peristalsis)
- **Status hint:** phenomenological; possibly superseded by J_v/Pe

**Canonical form:**

$$
v_{glymph} = v_0 + v_1\cdot\mathbf{1}_{NREM}\cdot\left(\frac{AQP4}{AQP4_0}\right)\cdot\frac{\mathcal{A}_{NE}}{\mathcal{A}_{NE} + K_{NE}}\cdot\left[1 - \sigma\left(\frac{\overline{NE} - \theta_g}{s_g}\right)\right]
$$

- **Symbols:** $v_0$ baseline velocity; $v_1$ NREM increment; $\mathbf{1}_{NREM}$ NREM indicator; $AQP4/AQP4_0$ relative AQP4 polarity; $\mathcal{A}_{NE}$ amplitude of 0.01–0.05 Hz NE oscillations (Hauglund 2025); $K_{NE}$ half-saturation; $\overline{NE}$ mean NE; $\theta_g$, $s_g$ gate threshold and width.
- **Lineage:** A.5 Eq. 14 (X04 E24), without $\mathcal{A}_{NE}$ (predicted a wrong-sign +71% for zolpidem). A.6 Eq. 38 (X06 E39) adds $\mathcal{A}_{NE}$. A.7 Eq. 38 (X10 E43h). A.8 (X12 E46, X13 E56); Lean v_glymph (X15/X16 E33). A.9/A.10 recast glymphatic advection as $J_v$ and $Pe$ (T2.16, T2.17); no source says whether $v_{glymph}$ is retired.
- **Derivation material:** Lean theorem zolpidem_pulsatility_loss_collapses_glymphatic (X15/X16 E34; proves $v_{glymph}=v_0$ when $\mathcal{A}_{NE}=0$, i.e. baseline, not zero).
- **Derivation plan:** Phenomenological product of gates. If unifying with Tier 2, set $\mathcal{A}_{NE}$ to the Stuart–Landau amplitude $\rho^*=\sqrt{\lambda_{eff}}$ (T2.2) and $AQP4/AQP4_0$ to $P_{AQP4}$ (T6.19); these links are not stated in any source.

### T6.17 Ontogenetic scaling tensor for structural connectivity

- **Aleph label:** inherited: A.9 (Aleph Sec. 2 lineage table: dW_ij/dt_g)
- **Status hint:** phenomenological; incomplete-in-source (dimensions, noise)

**Canonical form:**

$$
\frac{dW_{ij}}{dt_g} = \mathcal{M}_{ij}(t_g)\cdot\nabla\rho(x_i, t_g) + \eta(t_g)
$$

- **Symbols:** $W_{ij}$ structural connectivity; $t_g$ gestational/developmental age; $\mathcal{M}_{ij}(t_g)$ axon-guidance chemotactic gradient tensor; $\rho(x_i,t_g)$ cytoarchitectural cell density at position $x_i$ ($\rho$ reused elsewhere); $\eta(t_g)$ developmental noise (additive or multiplicative not stated).
- **Lineage:** Model A and A.3 species vector $\Theta_s$ (X01 E25, X03 E1). A.8: static population scalar $N$ and fixed $W_{ij}$. A.9 (X18 E1, image checked). Aleph lineage table, A.9 column (X22 E6). A.10 couples $L_0(t_g)$ in the AIS law (T4.2).
- **Derivation material:** GPT docx §7.2 (text only, no extracted entry in X23): tensor dimensions, density-to-connection mapping, noise type and non-negativity must be specified.
- **Derivation plan:** Chemotactic growth: rate of connection change = guidance tensor contracted with the density gradient + developmental noise (an SDE in gestational time). Specify dimensions and the contraction; enforce $W_{ij}\ge0$. No derivation available in the sources.

### T6.18 Hypoxia-driven angiogenesis

- **Aleph label:** inherited: A.9 (ontogenetic scaling)
- **Status hint:** phenomenological

**Canonical form:**

$$
\frac{d\mathcal{E}}{dt_g} = \kappa_{angio}\sum_c\left(1 - \frac{o_c}{o_{target}}\right)_+
$$

- **Symbols:** $\mathcal{E}$ set/count of vascular edges; $\kappa_{angio}$ rate; $o_c$ O₂ at node $c$ (T3.1); $o_{target}$ target O₂; $(\cdot)_+$ positive part.
- **Lineage:** New in A.9 (X18 E2, image checked). Not restated in A.10 or Aleph (Aleph names the ontogenetic tensor only).
- **Derivation material:** None.
- **Derivation plan:** Hypoxia (HIF-1α/VEGF) driven sprouting with rate proportional to the rectified O₂ deficit summed over nodes; interpret $\mathcal{E}$ as the expected edge count of a counting process; specify where new edges attach in the T2.1 graph.

### T6.19 AQP4 polarity degradation (pathological degradation tensor)

- **Aleph label:** inherited: A.9 (Aleph Sec. 2 lineage table: P_AQP4 -> 0)
- **Status hint:** phenomenological; incomplete-in-source (invariance, driver)

**Canonical form:**

$$
\tau_{path}\frac{dP_{AQP4}}{dt} = -k_{toxic}\cdot\mathcal{H}\left([Ca^{2+}]_e - Ca_{thresh}\right)\cdot\mathcal{F}_{inflam} + k_{recover}\left(1 - P_{AQP4}\right), \qquad P_{AQP4} \in [0,1]
$$

- **Symbols:** $P_{AQP4}$ AQP4 polarity index (basal values, Aleph Table 3: human 0.94, macaque 0.92, rat 0.88, mouse 0.86, pigeon 0.72, zebrafish 0.45, fly 0); $\tau_{path}$ time constant; $k_{toxic}$, $k_{recover}$ rates; $\mathcal{H}$ Heaviside; $[Ca^{2+}]_e$ extracellular Ca (T5.3); $Ca_{thresh}$ threshold; $\mathcal{F}_{inflam}$ neuroinflammation level.
- **Lineage:** A.5 Eq. 14 uses a static factor $AQP4/AQP4_0$ (X04 E24). A.9 (X18 E12, image checked) introduces the dynamics. Aleph lineage table: "AQP4 Polarity Degradation ($P_{AQP4}\to0$)" (A.9 column).
- **Derivation material:** None. Inconsistency: the A.9 text says it is driven by toxic solute accumulation (e.g. $C_{tau}$), but the equation uses a Heaviside function of extracellular Ca²⁺.
- **Derivation plan:** Leaky integrator with thresholded toxic drive and first-order recovery to full polarity; steady state $P^*=1-(k_{toxic}/k_{recover})\mathcal{H}\mathcal{F}$. Show that $P\in[0,1]$ is not invariant without a projection or a $P$-proportional loss term (e.g. $-k_{toxic}\mathcal{H}\mathcal{F}P$); resolve the driver (Ca²⁺ versus tau).

### T6.20 TrkB neurotrophic phosphorylation

- **Aleph label:** inherited: A.10 Eq. 6.1 (Aleph: delayed TrkB-BDNF synaptogenesis)
- **Status hint:** phenomenological

**Canonical form:**

$$
\tau_{TrkB}\frac{d[TrkB^*]}{dt} = -[TrkB^*] + k_{BDNF}\left([5\text{-}HT]_{syn} - 5HT_{basal}\right)_+\cdot a_i
$$

- **Symbols:** $[TrkB^*]$ phosphorylated TrkB; $\tau_{TrkB}$ time constant; $k_{BDNF}$ coupling (silenced to $k_{BDNF,eff}$ by T6.1, link implied); $[5\text{-}HT]_{syn}$ synaptic serotonin from Eq. 5.5; $5HT_{basal}$ baseline; $a_i$ ATP.
- **Lineage:** New in A.10 Eq. 6.1 (X19 E16). Aleph lineage table: A.10 "delayed TrkB-BDNF synaptogenesis"; Eq. 5.10 defines $k_{BDNF,eff}$.
- **Derivation material:** X19 E22-E23 (A.10 SSRI slow-fast system built on Eqs. 1.7, 6.1, 6.2; the latency invariant itself is out of scope).
- **Derivation plan:** First-order activation driven by the rectified serotonergic excess (an indirect proxy for BDNF release) and gated by ATP; give the linear-filter solution and its delay. State explicitly whether $k_{BDNF}$ is replaced by $k_{BDNF,eff}$.

### T6.21 Structural synaptic set-point remodeling

- **Aleph label:** inherited: A.10 Eq. 6.2
- **Status hint:** phenomenological

**Canonical form:**

$$
\frac{dS_{set}}{dt} = \kappa_{BDNF}[TrkB^*] - \gamma_{prune}\left(1 - \Theta_{circ}(t)\right)S_{set}
$$

- **Symbols:** $S_{set}$ synaptic set point (used in T6.11); $\kappa_{BDNF}$ synaptogenic gain; $[TrkB^*]$ from T6.20; $\gamma_{prune}$ pruning rate; $\Theta_{circ}$ from T6.13.
- **Lineage:** $S_{set}$ constant in A.3–A.8 (X03 E4, X13 E52). New dynamics in A.10 Eq. 6.2 (X19 E17). Aleph: synaptic set-point remodeling inherited.
- **Derivation material:** X19 E22-E23 (A.10 slow-fast analysis; out of scope as an invariant).
- **Derivation plan:** Production–loss balance: synaptogenesis ∝ active TrkB, pruning first order and circadian-gated; steady state $S^*=\kappa_{BDNF}[TrkB^*]/(\gamma_{prune}(1-\Theta_{circ}))$ (or its time average). Flag the $1-\Theta_{circ}$ versus $\Theta_{circ}$ gating conflict with T6.11/T6.13.

## Appendix: Out of scope

These are excluded from the derivation inventory as instructed. They are listed so the derivation authors know they exist and where their sketches are.

**A. Aleph Sec. 9: five emergent invariants (prose only in Aleph; derivation sketches in A.10 Sec. 4, X19 E19–E25; critiques in GPT §10, X23).**

1. Allosteric ceiling and fail-safe isoelectricity: $\lim_{[A]\to0}E/E_{max}\equiv0$ from Eq. 5.3, so $r_{min}>0$.
2. Asymmetric interneuron disinhibition (ketamine paradox): Woodhull ratio $R_{block}=\exp[z\delta_BF(\langle v_{PV}\rangle-\langle v_{Pyr}\rangle)/(RT_b)]\approx1.48$, × 3.2 gives 4.74-fold.
3. Canard / saddle-node SSRI latency: slow 5-HT1A desensitization, $t_{crit}\approx16.2$ d (also listed in Aleph Sec. 3.3).
4. Fractal receptor-internalization scaling: residency time $t_{res}>12$ s, stretched-exponential resensitization, 5.8-day half-life.
5. Cross-species neurovascular coordination $\Pi_{neurovasc}$: gyrification GI > 1.5 requires NsMJ latency < 150 ms.

**B. Aleph Sec. 9.1: ten new invariants (formulas as printed; GPT critiques in X23 E31–E40).**

1. $\Pi_{stall}=\sum_{e\in stalled}\ell_e/\sum_{e\in total}\ell_e\ge p_c^*\approx0.075$
2. $\Omega_{DBS}=f_{DBS}/f_{beta}\ge1/(\pi\,\tau_{GABA,I}\,f_{beta})\approx4.3$
3. $\Lambda_{glymph}=(k_0L_{p,0}\Delta p_{PVS})/(\dot m_{prod}R_{PVS})>1$
4. $K_{ischemia}=([PCr]_0+2[ATP]_0+2\Gamma_0)/(\lambda_n\,n_{eq}\,F_{Faraday})$
5. $\Psi_{pore}=\frac{k_{off}}{k_{on}[Glu]_{peak}}\exp(z\delta_BFv_{spike}/(RT_b))\ge1$
6. $\Sigma_{sync}=(g_{gap}\lambda_2(L_{gap}))/(\bar g_{GABA}\sigma_v^2)\ge1$
7. $\Xi_{BDNF}=(\kappa_{BDNF}k_{BDNF}a_i)/[\gamma_{prune}(1+\exp(\gamma_{silence}(H_{HDAC}-\theta)))S_{set,0}]$ (no threshold printed)
8. $\Phi_{peristalsis}=\frac{\omega_{LC}\tau_v}{\sqrt{1+(\kappa_{stiff}C_{amyloid})^2}}\cdot\frac{r_{a0}^4}{8\eta R_{PVS}D}\ge1$
9. $c_{ictal}=2\sqrt{D_K[(\nu_Kr_{max}h_K(k_c)/\Delta k_c)-1/\tau_K]}$
10. $\Theta_{optothermal}=\frac{\mu_a(\lambda)P_{laser}\delta_{pulse}}{(\omega_bC_b+k_{th}/r_{beam}^2)\cdot0.5\,{}^{\circ}\mathrm{C}}<1$

**C. Other material deliberately not inventoried.**

- *Aleph Sec. 3 analysis results without their own formula.* The supercritical-Hopf glymphatic–sedation paradox is covered inside the T2.2 derivation plan. The SSRI saddle-node is invariant A3. Clathrin-pit residency kinetics belong to invariant A4.
- *Species-branch relations that Aleph assigns to Model A.8.* These are fly tracheal supply $J_G=D_{trachea}\nabla^2G$, pigeon arbor scaling $A_{membrane}\propto k_{syn}^{2/3}=0.313\times$ rodent, the Q10 temperature laws (A.3; A.8 pigeon pump $Q_{10}^{0.42}=1.365$), and the human 21.9 W energetics.
- *A.8 "emergent inferences".* Capacitive Na per spike (referenced in T1.18 and T5.5), the fast-ripple Na load, the circadian barrier elevation $\Delta U_{eff}$ (referenced in T6.13), and CBF/CMRO₂ $n\approx2.5$.
- *Mechanisms dropped before A.8 and never re-adopted.* Theta phase precession (A.5–A.7 Eq. 39), theta–gamma slot capacity (A.5), the A.5 point-source ephaptic field (Eq. 27), the A.3 sleep law $t_{sleep}/t_{wake}=\kappa B$, the lateralisation threshold, and the expansion participation ratio $PR(K)$.
- *Model A precursor-audit relations.* Kabanov capacity, participation-ratio corrections, sheaf cohomology, contraction criteria and the proportional-penalty overshoot (X01, X20).
- *Proven properties of earlier versions.* A.2 Properties 1–5 and A.6 P1–P11 are not equations of the model. They are cited as derivation material in the relevant entries.
