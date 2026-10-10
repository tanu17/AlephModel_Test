# Tier 3: Six-pool substrate metabolism

## Overview

Tier 3 is the energy budget of Aleph 1 (Model A.10.1). It takes glucose and oxygen delivered by the vascular tier, turns them into neuronal ATP, and charges that ATP for everything a neuron does. Aleph 1 itself prints only one Tier 3 relation, the carbon identity of its Sec. 3 (T3.4). Its Sec. 2 lineage table says the rest is retained: "six closed pools (G, L, Γ, p, o, a); exact carbon balance; Creatine Kinase (PCr/Cr) buffer" (A.8), "coupled oxidative phosphorylation to ROS" (A.9), "stabilized substrate delivery under extreme hyperperfusion" (A.10), and "couples astrocytic lactate shuttling directly to local pericyte dilation" (A.10.1). The canonical forms below therefore come from the most recent source that writes each equation: A.10 Eq. 3.1, A.8 PDF Eqs. (9)-(12), the A.8 docx, and, for flux laws that A.8 names but does not write, A.7 annex Eqs. 16-24 (the same as A.6 Eqs. 16-24).

**State variables.** The voxel pools live on each capillary node $c$ of the Tier 2 mesh (T2.1): tissue glucose $G$, lactate $L$, glycogen $\Gamma$ (glucosyl units), pyruvate $p$ (called "neuronal" but carried per voxel) and tissue O$_2$ $o$. Neuronal ATP $a_i$ lives on each neuron $i$. These six are the "six pools". The CK buffer adds $[PCr]$, $[Cr]$ and $[ADP]$, which no source gives dynamics for (T3.12).

**How the entries fit together.**

- *Balances.* The pool balances (T3.1) and the ATP balance (T3.2), with demand from T3.3.
- *Boundary fluxes.* GLUT1 glucose transport $J_G$ (T3.5), O$_2$ delivery $J_O$ (T3.6) and lactate washout $J_L$ (T3.11).
- *Internal fluxes.* Neuronal glycolysis $v_{gn}$ (T3.7), astrocytic glycolysis $v_{ga}$ (T3.8), glycogen synthesis and breakdown $v_{syn}$, $v_{gly}$ (T3.9), oxidation $v_{ox}$ (T3.10), and LDH/MCT exchange $v_{ex}$ (T3.11).
- *Invariant.* Carbon conservation (T3.4). A companion electron (oxidant) ledger, which no source states, is derived in T3.1 Step 11.
- *Claimed but never written.* PCr/Cr dynamics (T3.12), OXPHOS-ROS coupling (T3.13), and lactate → pericyte coupling (T3.14). For each, a clearly labelled proposal is derived.

**Couplings to other tiers.**

- *From Tier 2.* Normalized flow $f$ (T2.15) enters $J_G$ (T3.5) and $J_O$ (T3.6). Noradrenaline from the LC oscillator (T2.2) enters $v_{gly}$ (T3.9). Extracellular K$^+$ (T2.13) is named as a glycogenolysis activator, but the printed term reads the activity variable $u$ instead (T3.9).
- *From Tier 1.* The pump flux $\Pi_i$ (T1.19) enters $D_{set}$ (T3.3) and through it $v_{gn}$ (T3.7). Activity sets the glutamate cycling variable $u$ in $v_{ga}$ and $v_{gly}$.
- *From Tier 6.* Weights, weight changes and capture changes (T6.4, T6.8) enter $D_{set}$ (T3.3).
- *To Tier 1.* $a_i$ sets the K_ATP conductance (T1.6), the pump's ATP saturation (T1.19) and the energy-aware set point (T1.21).
- *To Tier 5 and Tier 6.* $a_i$ sets the capture gate $\pi(a)$ (T6.9) and the eviction rule $a_i < 0.05a_0$ (T5.6). The demands $D_k$ are summed into the headroom $h_Q$ (T6.5). The ROS proposal feeds the sleep gate (T6.12) (T3.13).
- *To Tier 2.* The lactate proposal sets the pericyte drive $q_c$ (T2.14) (T3.14). A.8 also has an astrocytic A2B term in the arteriole equation (T2.9).

**Status summary.**

| Key | Equation | Status |
|---|---|---|
| T3.1 | Pool balances $G, L, \Gamma, p, o$ | Derived under approximations |
| T3.2 | Neuronal ATP balance with CK term | Derived under approximations |
| T3.3 | ATP demand $D$, $D_{set}$ | Phenomenological closure |
| T3.4 | Carbon balance | Exact |
| T3.5 | GLUT1 transport with recruitment | Derived under approximations |
| T3.6 | O$_2$ delivery (Buxton) | Derived under approximations |
| T3.7 | Neuronal glycolysis $v_{gn}$ | Phenomenological closure |
| T3.8 | Astrocytic glycolysis $v_{ga}$ | Phenomenological closure |
| T3.9 | Glycogen fluxes $v_{syn}$, $v_{gly}$ | Phenomenological closure |
| T3.10 | Oxidative flux $v_{ox}$ | Phenomenological closure |
| T3.11 | LDH/MCT exchange $v_{ex}$, washout $J_L$ | Derived under approximations |
| T3.12 | PCr/Cr dynamics | Incomplete in source |
| T3.13 | OXPHOS-ROS coupling | Incomplete in source |
| T3.14 | Lactate → pericyte dilation | Incomplete in source |

**Conventions in this file.**

- $m(z,K) = z/(z+K)$, $\sigma(z) = 1/(1+e^{-z})$ and $(z)_+ = \max(z,0)$, as in A.6.
- Concentrations are in mM. A.6 equates mM with µmol/g, which assumes a tissue density of 1 g/mL. Fluxes are in mM/s. The sources quote µmol/g/min, and 1 µmol/g/min ≈ 1/60 mM/s.
- Flux units: $v_{gn}$, $v_{ga}$ and $J_G$ count glucose; $v_{syn}$ and $v_{gly}$ count glucosyl units; $v_{ox}$, $v_{ex}$ and $J_L$ count 3-carbon units; $J_O$ counts O$_2$ molecules.
- Rest values used in the checks are the ones A.6 prints (Model A.6 four-caveat revision ... (claude).docx, Sec. 4b): $G_0 = 1.2$, $L_0 = 0.8$, $\Gamma_0 = 7.0$, $o_0 = 0.035$, $a_0 = 2.5$ mM; CMRglc 0.30 µmol/g/min; OGI 5.3; aerobic glycolysis 11.7%; glycogen turnover 0.35 µmol/g/h; $G_b = K_T = 5$ mM; $K_G = 0.5$ mM; $K_p = 50$ µM; $K_o = 3$ µM; $Y_{ox} = 14.5$; $k_{ex} = 1$ s$^{-1}$; $\rho = 10$; $K_{aD} = 0.5$ mM; $L_b = 0.715$ mM; $\chi_g = 1.49$; $\gamma_G = 0.5$; $\phi = 0.5$. A.6 also reports rest-state time constants (P6): O$_2$ 0.9 s, ATP 2.1 s, pyruvate 10.5 s, lactate 63 s, glucose 5.5 min, glycogen 12.5 h. Any number computed here from these values is labelled "implied". No new parameter values are introduced.
- "Reconstructed" marks a derivation step or form that no source contains. Each is built from standard physics, chemistry or biochemistry, and the standard reference is named.

---

## T3.1: Substrate pool balances for glucose, lactate, glycogen, pyruvate and oxygen (inherited: A.8 PDF Eqs. (9)-(11); Aleph Sec. 2 "six closed pools")

**Equation as stated** (Model_A8_Scientific_Report.pdf, Eqs. (9)-(11), and Model_A8_Scientific_Report.docx; identical to A.6 Eq. 23 and A.7 annex Eq. 23; Aleph 1 prints none of these and keeps only the carbon identity T3.4):

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

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $G$ | tissue glucose | mM (rest 1.2) |
| $L$ | tissue lactate | mM (rest 0.8) |
| $\Gamma$ | glycogen, counted in glucosyl units | mM glucosyl (rat $\Gamma_0 = 7.0$; Aleph Table 3 gives 0.8-7.0 across species) |
| $p$ | pyruvate ("neuronal pyruvate" in A.6/A.8, but carried per voxel) | mM (rest not printed; ≈ $L_0/\rho = 0.08$, see Checks) |
| $o$ | free tissue O$_2$ | mM (rest 0.035) |
| $J_G$ | net GLUT1 glucose influx from blood (T3.5) | mM/s |
| $J_L$ | net lactate washout to blood (T3.11) | mM/s |
| $J_O$ | O$_2$ delivery from blood (T3.6) | mM/s |
| $v_{gn}$ | neuronal glycolysis, glucose → pyruvate (T3.7) | mM glucose/s |
| $v_{ga}$ | astrocytic glycolysis, glucose → lactate (T3.8) | mM glucose/s |
| $v_{syn}$, $v_{gly}$ | glycogen synthesis and glycogenolysis (T3.9) | mM glucosyl/s |
| $v_{ex}$ | net pyruvate → lactate conversion by LDH/MCT (T3.11) | mM/s |
| $v_{ox}$ | oxidation of 3-carbon units to CO$_2$ (T3.10) | mM/s |
| $c_O$ | "O$_2$ capacity factor", never defined in any source | dimensionless if $o$ is in mM (Step 9) |

**Physical starting point.** Conservation of mass in a fixed, well-mixed control volume (one voxel per capillary node). The balance is applied to a lumped reaction network with fixed stoichiometry. The coefficients are fixed by element (carbon) and degree-of-reduction (electron) balances, the standard bookkeeping of bioenergetics (e.g. Roels 1983). Assumptions:

- A1. Each voxel has a fixed volume and is well mixed. Neuronal, astrocytic and interstitial spaces are merged into one tissue volume for $G$, $L$, $\Gamma$, $p$ and $o$, with no volume fractions. Exchange between neighbouring voxels is neglected. A.8 calls the system "reaction-diffusion", but no diffusion term appears.
- A2. The reaction network is lumped into six steps:
    - $R_{gn}$: glucose → 2 pyruvate (neuronal glycolysis);
    - $R_{ga}$: glucose → 2 lactate (astrocytic glycolysis with LDH lumped in);
    - $R_{syn}$: glucose → 1 glycogen glucosyl unit;
    - $R_{gly}$: 1 glucosyl unit → 2 lactate (glycogenolysis, glycolysis and LDH lumped);
    - $R_{ex}$: pyruvate → lactate (LDH plus MCT transfer; negative when lactate is taken up);
    - $R_{ox}$: one 3-carbon unit from $p$ + 3 O$_2$ → 3 CO$_2$ (pyruvate dehydrogenase, TCA cycle and respiratory chain lumped).

  The boundary fluxes are $J_G$ (glucose in), $J_L$ (lactate out) and $J_O$ (O$_2$ in).
- A3. *Redox convention.* Cytosolic NAD$^+$/NADH is not a state variable. The two NADH made by glycolysis in $R_{gn}$ travel with the two pyruvates. They are re-oxidized either by LDH (when $R_{ex}$ turns $p$ into $L$) or by mitochondria through a shuttle (inside $R_{ox}$). So $p$ is effectively counted at the oxidation level of lactate ("pyruvate + NADH"). No source states this; Step 7 shows it is what the coefficient 3 requires.
- A4. Only $R_{ox}$ uses O$_2$. Astrocytic oxidative metabolism is absent. CO$_2$, H$_2$O, H$^+$, P$_i$, nucleotides and the ATP made in astrocytes are not tracked.
- A5. The rate law of each flux is specified separately (T3.5-T3.11). This entry concerns only stoichiometry.

**Derivation.**

1. *Control-volume balance (A1).* For a species $X$ with concentration $c_X$ in a voxel of volume $V$:
$$
\frac{d(Vc_X)}{dt} = V\left(J_X^{in} - J_X^{out}\right) + V\sum_r \nu_{Xr}\,v_r
$$
Here $\nu_{Xr}$ is the stoichiometric coefficient of $X$ in reaction $r$ (positive for a product, negative for a reactant), and $v_r$ is the reaction rate per unit volume. $V$ is constant, so dividing by $V$ gives
$$
\frac{dc_X}{dt} = J_X^{in} - J_X^{out} + \sum_r \nu_{Xr}\,v_r
$$

2. *Stoichiometric matrix (A2).* Order the species as $(G, L, \Gamma, p, \mathrm{O_2})$ and the fluxes as $\mathbf{v} = (v_{gn}, v_{ga}, v_{syn}, v_{gly}, v_{ex}, v_{ox})^T$. Steps 3-8 justify each row of the matrix
$$
N = \begin{pmatrix} -1 & -1 & -1 & 0 & 0 & 0 \\ 0 & 2 & 0 & 2 & 1 & 0 \\ 0 & 0 & 1 & -1 & 0 & 0 \\ 2 & 0 & 0 & 0 & -1 & -1 \\ 0 & 0 & 0 & 0 & 0 & -3 \end{pmatrix}
$$

3. *Glucose row.* $v_{gn}$, $v_{ga}$ and $v_{syn}$ are counted in glucose consumed, so each carries coefficient $-1$. Glucose enters at $J_G$. Step 1 gives
$$
\frac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn}
$$

4. *Glycogen row.* $\Gamma$ is counted in glucosyl units. $R_{syn}$ adds one unit per glucose, and $R_{gly}$ removes one. Hence
$$
\frac{d\Gamma}{dt} = v_{syn} - v_{gly}
$$

5. *Lactate row.* Carbon count: one 6-carbon unit gives two 3-carbon units, so $R_{ga}$ and $R_{gly}$ each make 2 lactate. $R_{ex}$ makes 1, and $J_L$ removes lactate. Hence
$$
\frac{dL}{dt} = 2v_{ga} + 2v_{gly} + v_{ex} - J_L = 2(v_{ga} + v_{gly}) + v_{ex} - J_L
$$
Redox check of $R_{ga}$: C$_6$H$_{12}$O$_6$ → 2 C$_3$H$_6$O$_3$ balances C, H and O, so it needs no external oxidant (the GAPDH NADH is consumed by LDH). $R_{gly}$ is the same reaction, with one water added to the polymer glucosyl unit (C$_6$H$_{10}$O$_5$ + H$_2$O → 2 C$_3$H$_6$O$_3$).

6. *Pyruvate row.* $R_{gn}$ makes 2 pyruvate per glucose. $R_{ex}$ removes 1 (pyruvate → lactate), and $R_{ox}$ removes 1. Hence
$$
\frac{dp}{dt} = 2v_{gn} - v_{ox} - v_{ex}
$$

7. *The O$_2$ coefficient, from a degree-of-reduction balance.* The number of electrons a neutral molecule C$_n$H$_m$O$_k$ can donate on complete oxidation to CO$_2$ and H$_2$O is $\gamma = 4n + m - 2k$:
    - glucose (C$_6$H$_{12}$O$_6$): $24 + 12 - 12 = 24$;
    - lactate (C$_3$H$_6$O$_3$): $12 + 6 - 6 = 12$;
    - pyruvate (C$_3$H$_4$O$_3$): $12 + 4 - 6 = 10$;
    - O$_2$ accepts 4 electrons ($\gamma = -4$); CO$_2$ and H$_2$O have $\gamma = 0$.

   Glycolysis to pyruvate: $24 = 2\times 10 + 4$. The missing 4 electrons are the 2 NADH (2 electrons each). There are two cases:
    - (a) If $p$ is pyruvate alone and its NADH is re-oxidized somewhere outside $R_{ox}$, then complete oxidation needs $10/4 = 2.5$ O$_2$ per $p$ (C$_3$H$_4$O$_3$ + 2.5 O$_2$ → 3 CO$_2$ + 2 H$_2$O).
    - (b) Under A3 each unit of $p$ carries one NADH, so it holds $10 + 2 = 12$ electrons, the same as lactate. Complete oxidation then needs $12/4 = 3$ O$_2$ (C$_3$H$_6$O$_3$ + 3 O$_2$ → 3 CO$_2$ + 3 H$_2$O).

   Every 3-carbon unit enters $p$ either from $R_{gn}$ (with its glycolytic NADH) or from lactate through reverse LDH (which makes one NADH). So under A3 the coefficient 3 is exact, and it is exact only under A3.

8. *O$_2$ row.* $R_{ox}$ uses 3 O$_2$ per unit, and O$_2$ enters at $J_O$. Using the total O$_2$ content of Step 9:
$$
c_O\frac{do}{dt} = J_O - 3v_{ox}
$$

9. *What $c_O$ must mean (Reconstructed).* Let $S(o)$ be the O$_2$ stored in the voxel in fast equilibrium with free O$_2$ (for example haemoglobin-bound O$_2$ in the capillary blood inside the voxel). The mass balance on total O$_2$ is
$$
\frac{d}{dt}\left[o + S(o)\right] = J_O - 3v_{ox}
$$
The chain rule gives $d S/dt = S'(o)\,do/dt$, so
$$
\left(1 + S'(o)\right)\frac{do}{dt} = J_O - 3v_{ox}, \qquad c_O \equiv 1 + \frac{dS}{do} \ge 1
$$
This is the same construction as the buffering factor of a rapidly buffered ion. A constant $c_O$ means $S$ is linear in $o$. Two alternatives also fit the printed form. If $o$ were a partial pressure, $c_O$ would carry a solubility (mM per mmHg). If $o$ were referred to a different volume than the fluxes, $c_O$ would be a volume ratio. No source gives a definition or a value.

10. *Assemble.* Steps 3-8 in vector form, with the boundary vector $\mathbf{b} = (J_G, -J_L, 0, 0, J_O)^T$, give
$$
\mathrm{diag}(1,1,1,1,c_O)\,\frac{d}{dt}(G, L, \Gamma, p, o)^T = N\mathbf{v} + \mathbf{b}
$$
This is the printed system, row by row.

11. *Exact ledgers from the left null space (consequence).* For any row vector $\mathbf{w}$, $\frac{d}{dt}(\mathbf{w}\cdot\mathbf{c}) = \mathbf{w}N\mathbf{v} + \mathbf{w}\cdot\mathbf{b}$. A component of $\mathbf{w}N$ that is zero means that internal flux cancels.
    - *Carbon*, $\mathbf{w}_C = (6, 3, 6, 3, 0)$. The column products are $-6+6 = 0$ ($v_{gn}$), $-6+6 = 0$ ($v_{ga}$), $-6+6 = 0$ ($v_{syn}$), $6-6 = 0$ ($v_{gly}$), $3-3 = 0$ ($v_{ex}$) and $-3$ ($v_{ox}$). The $-3$ is the 3 carbons that leave as CO$_2$, which is not tracked. Hence $\frac{d}{dt}(6G + 3L + 6\Gamma + 3p) = 6J_G - 3J_L - 3v_{ox}$. Dividing by 6 gives T3.4.
    - *Electrons*, $\mathbf{w}_e = (24, 12, 24, 12, -4)$ under A3. The column products are $-24+24 = 0$, $-24+24 = 0$, $-24+24 = 0$, $24-24 = 0$, $12-12 = 0$, and $-12 + (-4)(-3) = 0$. Every internal flux cancels, including oxidation. With constant $c_O$, and after dividing by 4 (O$_2$ equivalents):
$$
\frac{d}{dt}\left[6G + 6\Gamma + 3(L + p) - c_O\,o\right] = 6J_G - 3J_L - J_O
$$
    - If instead $p$ were weighted 10 (case (a) of Step 7), the column products would be $-4$ ($v_{gn}$), $+2$ ($v_{ex}$) and $+2$ ($v_{ox}$). The electron ledger would then leak $-4v_{gn} + 2v_{ex} + 2v_{ox}$. This confirms that the printed coefficient 3 and A3 belong together.

**Result.** Under A1-A5 the derivation reproduces the printed balances exactly, term for term. Several points need flagging:

- (i) *$c_O$ is undefined in every source* (A.6, A.7, A.8 PDF/docx, A.10, Aleph). Step 9 gives the consistent meaning, $c_O = 1 + dS/do$.
- (ii) *The coefficient 3 rests on an unstated redox convention.* For pyruvate proper it would be 2.5. It is exact only if $p$ carries the cytosolic NADH (A3). This convention must be carried into the ATP yield: $Y_{ox}$ must include the shuttle credit for that NADH (T3.2 Step 4).
- (iii) *Astrocytic routes bypass $p$.* $R_{ga}$ and $R_{gly}$ go straight to $L$. This is consistent, because both are redox-neutral. But their ATP is credited to no pool: 2 per glucose, and 3 per glucosyl unit from glycogen, since phosphorolysis saves the hexokinase ATP. The astrocyte energy budget lies outside the model.
- (iv) *All O$_2$ use is assigned to neuronal oxidation of $p$* (A4). Astrocytic oxidative metabolism is missing.
- (v) *Compartments are merged.* $p$ is called neuronal but lives on the voxel, while $a_i$ lives on the neuron (T3.2, point (iv)).
- (vi) *The Lean files encode only the $G$, $L$, $\Gamma$ and $p$ rows* (Model_A8_All_Equations.lean, the patched file, and Model_A8_FormalVerification.lean). They have no $o$ row.

**Checks.**

- *Dimensions.* Every right-hand term is in mM/s, and $c_O$ is dimensionless when $o$ is in mM.
- *Positivity.* Each outflow of a pool vanishes when that pool is empty, provided the rate laws keep their saturation factors:
    - $v_{gn}$, $v_{ga}$ and $v_{syn}$ all carry $m(G,\cdot)$;
    - $v_{gly}$ carries $m(\Gamma,\cdot)$;
    - $v_{ox}$ carries $m(p,\cdot)\,m(o,\cdot)$;
    - at $p = 0$, $v_{ex} = -k_{ex}L/\rho \le 0$, which feeds $p$; at $L = 0$, $v_{ex} = k_{ex}p \ge 0$ and $J_L = -k_{Lb}L_b < 0$, both of which feed $L$;
    - at $\Gamma = \Gamma_{max}$, $v_{syn} = 0$.

  So the box $G, L, p, o \ge 0$, $0 \le \Gamma \le \Gamma_{max}$ is forward invariant.
- *Rest budget (implied).* Take the rest state with glycogen at steady state ($v_{syn,0} = v_{gly,0}$). The O$_2$ row gives $J_{O0} = 3v_{ox,0}$, and the carbon ledger (Step 11) gives $J_{G0} = J_{L0}/2 + v_{ox,0}/2$. With OGI = CMRO$_2$/CMRglc = 5.3 and CMRglc = 0.30 µmol/g/min:
$$
v_{ox,0} = \frac{5.3 \times 0.30}{3} = 0.53, \qquad J_{L0} = 2(0.30) - 0.53 = 0.07 \quad \text{(µmol/g/min)}
$$
  The fraction of glucose that leaves as lactate is $J_{L0}/(2J_{G0}) = 1 - 5.3/6 = 11.7\%$. This is the "aerobic glycolysis 11.7%" A.6 uses, so A.6's three rest targets are consistent with the stoichiometry.
- *Rest pyruvate (implied).* At steady state $v_{ex,0} = 2v_{gn,0} - v_{ox,0}$, and $\lvert v_{ex,0}\rvert \le 0.6$ µmol/g/min = 0.01 mM/s. With $k_{ex} = 1$ s$^{-1}$, T3.11 gives $\lvert p_0 - L_0/\rho\rvert \le 0.01$ mM, so $p_0 \approx 0.08$ mM.
- *Respiratory quotient.* CO$_2$ produced ($3v_{ox}$) divided by O$_2$ used ($3v_{ox}$) is 1, as it should be for carbohydrate oxidation.
- *O$_2$ relaxation time.* Linearize the O$_2$ row about rest, using T3.6 for $J_O$ and T3.10 for $v_{ox}$:
$$
\tau_O = \frac{c_O}{\dfrac{J_{O0}}{o_a - o_0} + \dfrac{3v_{ox,0}K_o}{o_0(o_0 + K_o)}}
$$
  No source gives $o_a$ or $c_O$, so the 0.9 s O$_2$ time constant reported in A.6 (P6) cannot be checked.

**Lineage.**

- **Model A** (Model_A_Changelog_Audit_and_Fixes.md; Model_A_Biological_Neuroenergetics_Specification.pdf): lumped cellular and domain ATP buffers $e_i$, $e_Q$, with no substrate pools.
- **A.2** (Model A.2 Repaired Specification and Validation.docx) and **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eqs. 9-11): lumped $e_i$ supplied by a domain reserve $e_Q$ with Buxton delivery. A.5 says the ANLS is not modelled.
- **A.6** (Model A.6 four-caveat revision ... (claude).docx, Eq. 23): introduces the five balances exactly as printed today. P5 states the carbon and O$_2$ ledgers (with a carbon residual of $1.4\times10^{-4}$ from quadrature). P6 gives the rest Jacobian time constants. P7 reduces the system to the A.2 lumped equation on slow time scales.
- **A.7** (Model A.7 with all equations.docx, annex Eq. 23): unchanged. Model A.7 More scientific Doc (gemini).docx prints only $dG/dt$. model A.7 maths.docx states the carbon closure in words and says it balances "the oxygen consumed"; in fact the sink is $v_{ox}/2$ glucose equivalents, not O$_2$.
- **A.8** (Model_A8_Scientific_Report.pdf Eqs. (9)-(11); Model_A8_Scientific_Report.docx; Model_A8_model only.docx): unchanged. The Lean files encode $G$, $L$, $\Gamma$ and $p$ only.
- **A.10 and Aleph 1:** A.10 says "closed six-pool"; the Aleph lineage table says "six closed pools (G, L, Γ, p, o, a)". Aleph Table 3 gives species $\Gamma_0$ values (0.8-7.0 mM). The human value there is 4.8 mM, whereas A.6 based $\Gamma_0 = 7.0$ on Öz 2015 (7.8 µmol/g).

**Derivation status.** Derived under approximations. The stoichiometric bookkeeping is exact once the reaction scheme (A2) and the redox convention (A3) are fixed. The approximations are:

- well-mixed voxels with merged compartments and no inter-voxel diffusion (A1);
- lumped reaction steps (A2);
- an unstated redox convention that makes the O$_2$ coefficient 3 rather than 2.5 (A3);
- no astrocytic oxidation (A4).

$c_O$ is undefined in every source.

---

## T3.2: Neuronal ATP balance with creatine-kinase / phosphocreatine buffer (inherited: A.10 Eq. 3.1 / A.8 PDF Eq. (12))

**Equation as stated** (Model_A10_Comprehensive_Scientific_Report.docx, Eq. 3.1; identical to Model_A8_Scientific_Report.pdf Eq. (12) and the A.8 docx):

$$
\frac{da_i}{dt} = 2v_{gn} + Y_{ox}\,v_{ox} + k_{CK}\left([PCr][ADP] - \frac{[Cr][ATP]}{K_{eq}}\right) - D_i
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $a_i$ | neuronal ATP of neuron $i$; the same quantity is written $[ATP]$ inside the CK term | mM (rest 2.5) |
| $v_{gn}$ | neuronal glycolysis (T3.7) | mM glucose/s |
| $v_{ox}$ | oxidative flux of 3-carbon units (T3.10) | mM/s |
| $Y_{ox}$ | ATP made per unit $v_{ox}$ | ATP per 3-carbon unit (A.6: 14.5; A.8 docx and Lean: 27.5) |
| $k_{CK}$ | creatine-kinase rate constant (H$^+$ absorbed) | mM$^{-1}$ s$^{-1}$ |
| $K_{eq}$ | apparent CK equilibrium constant $[Cr][ATP]/([PCr][ADP])$ at fixed pH | dimensionless |
| $[PCr]$, $[Cr]$, $[ADP]$ | phosphocreatine, creatine, free ADP; no dynamics in any source (T3.12) | mM |
| $D_i$ | ATP demand of neuron $i$ (T3.3) | mM/s |
| $a_{max}$ | total adenine nucleotide, implied by $\theta(a)$ in T3.7 | mM (no value given) |

**Physical starting point.** The ATP mass balance of the neuronal cytosol: the rate of change equals the sum of ATP-producing rates times their yields minus ATP consumption. Yields are counted from the glycolytic and mitochondrial stoichiometry, using the consensus P/O ratios of 2.5 for NADH and 1.5 for ubiquinol (succinate) (Hinkle 2005). The CK (Lohmann) reaction PCr$^{2-}$ + MgADP$^-$ + H$^+$ ⇌ Cr + MgATP$^{2-}$ is treated by mass action. Assumptions:

- A1. The neuronal cytosol is well mixed. ATP from glycolysis and from mitochondria (exported by the adenine nucleotide translocase) joins one cytosolic pool.
- A2. Glycolysis from glucose to pyruvate yields net 2 ATP: hexokinase $-1$, phosphofructokinase $-1$, phosphoglycerate kinase $+2$, pyruvate kinase $+2$.
- A3. Each unit of $v_{ox}$ yields $Y_{ox}$ ATP from oxidative phosphorylation plus the GTP of succinyl-CoA synthetase. This includes the shuttle credit for the cytosolic NADH that $p$ carries (T3.1, A3).
- A4. The CK reaction follows reversible mass action, with $[H^+]$ held constant and absorbed into $k_{CK}$ and $K_{eq}$.
- A5. $D_i$ lumps every ATP-consuming process (T3.3).
- A6. Adenylate kinase and AMP are neglected, so $[ATP] + [ADP] = a_{max}$ is constant. The sources never state this, but the ADP feedback $\theta(a)$ in T3.7 presupposes it.

**Derivation.**

1. *Balance.* With $\nu_{ATP,r}$ the ATP yield per unit of reaction $r$,
$$
\frac{d[ATP]}{dt} = \sum_r \nu_{ATP,r}\,v_r - D
$$

2. *Glycolytic yield (A2).* Per glucose: $-1 - 1 + 2 + 2 = +2$. So $v_{gn}$ (glucose units) carries coefficient 2.

3. *Oxidative yield per pyruvate.* The NADH and ubiquinol made per pyruvate:
    - pyruvate dehydrogenase: 1 NADH;
    - isocitrate dehydrogenase, 2-oxoglutarate dehydrogenase and malate dehydrogenase: 3 NADH;
    - succinate dehydrogenase: 1 ubiquinol;
    - succinyl-CoA synthetase: 1 GTP (≈ ATP).

   With P/O = 2.5 for NADH and 1.5 for ubiquinol:
$$
4(2.5) + 1(1.5) + 1 = 12.5 \ \text{ATP per pyruvate}
$$

4. *Credit for the NADH carried in $p$ (A3).* The glycolytic NADH enters mitochondria through a shuttle. The malate-aspartate shuttle delivers it as matrix NADH (2.5 ATP); the glycerol-3-phosphate shuttle delivers it as ubiquinol (1.5 ATP). Hence
$$
Y_{ox} = 12.5 + 2.5 = 15 \ \text{(malate-aspartate)}, \qquad Y_{ox} = 12.5 + 1.5 = 14 \ \text{(glycerol-3-phosphate)}
$$
   A.6's $Y_{ox} = 14.5$ is the midpoint. Per glucose fully oxidized this gives $2 + 2(14.5) = 31$ ATP. A.6's note "29 ATP per glucose oxidised" counts the oxidative part only, $2 \times 14.5 = 29$. Pyruvate made from lactate by reverse LDH carries the NADH from that step, so the same yield applies.

5. *ATP per O$_2$ (consistency).* Each unit of $v_{ox}$ uses 3 O$_2$, which is 6 O atoms (T3.1). The implied P/O ratio is $Y_{ox}/6$:
    - $Y_{ox} = 14.5$: 4.83 ATP per O$_2$, P/O = 2.42. This lies between the ubiquinol (1.5) and NADH (2.5) values, as a mixed substrate should.
    - $Y_{ox} = 27.5$: 9.17 ATP per O$_2$, P/O = 4.58. This is above the P/O of the most efficient substrate (NADH, 2.5), so it is not physically possible.

6. *CK term by mass action (A4).* The forward rate (ATP synthesis) is $k_f[PCr][ADP][H^+]$ and the reverse rate is $k_r[Cr][ATP]$. The net ATP production is
$$
v_{CK} = k_f[H^+][PCr][ADP] - k_r[Cr][ATP]
$$
   Factor out $k_f[H^+]$:
$$
v_{CK} = k_f[H^+]\left([PCr][ADP] - \frac{k_r}{k_f[H^+]}[Cr][ATP]\right)
$$
   Define $k_{CK} \equiv k_f[H^+]$ and $K_{eq} \equiv k_f[H^+]/k_r$. At equilibrium ($v_{CK} = 0$) this gives $K_{eq} = [Cr][ATP]/([PCr][ADP])$ (detailed balance), so $K_{eq}$ is the apparent constant at the clamped pH. Hence
$$
v_{CK} = k_{CK}\left([PCr][ADP] - \frac{[Cr][ATP]}{K_{eq}}\right)
$$

7. *Sum (Steps 2, 4 and 6 in Step 1).*
$$
\frac{da_i}{dt} = 2v_{gn} + Y_{ox}v_{ox} + k_{CK}\left([PCr][ADP] - \frac{[Cr][ATP]}{K_{eq}}\right) - D_i
$$
   This is the printed equation.

8. *CK equilibrium (Lean `ck_equilibrium_preserves_atp_flux`, Model_A8_All_Equations.lean and the patched file).* If $[PCr][ADP] = [Cr][ATP]/K_{eq}$, the bracket is $x - x = 0$, so
$$
\frac{da_i}{dt} = 2v_{gn} + Y_{ox}v_{ox} - D_i
$$
   This is the A.6/A.7 Eq. 24. The theorem shows only that the term vanishes at equilibrium. It shows no buffering. Buffering appears only once the PCr balance is added (Step 9 and T3.12).

9. *Closure of the CK term (Reconstructed).* By A6, $[ADP] = a_{max} - a_i$. Creatine is conserved, so $[Cr] = C_{tot} - [PCr]$. The CK stoichiometry consumes one PCr per ATP formed, so $d[PCr]/dt = -v_{CK}$ (T3.12). Add this to Step 7. The CK term cancels from the sum, and the total high-energy phosphate $H = a_i + [PCr]$ obeys
$$
\frac{dH}{dt} = 2v_{gn} + Y_{ox}v_{ox} - D_i
$$
   CK only moves phosphate between ATP and PCr. It neither creates nor destroys it.

**Result.** Under A1-A6, with $Y_{ox} \approx 14$-15 per 3-carbon unit, the derivation reproduces the printed equation term for term. Several points need flagging:

- (i) *$Y_{ox}$ differs across versions.* A.6 uses 14.5, which is consistent (Steps 3-5). The A.8 docx says "$Y_{ox} \approx 27.5$ ATP equivalents per molecule of pyruvate oxidized", and both A.8 Lean files hard-code `27.5 * v_ox`. That value is impossible per pyruvate (Step 5). It falls in the range of a *per-glucose* oxidative yield: 25 from two pyruvates plus 3-5 from the shuttled glycolytic NADH, i.e. 28-30. It was most likely entered per pyruvate by mistake. Corrected: $Y_{ox} = 14.5$ (range 14-15).
- (ii) *Notation.* $a_i$ and $[ATP]$ denote the same variable. Write $[ATP] = a_i$ and $[ADP] = a_{max} - a_i$.
- (iii) *The CK term is not closed.* $[PCr]$, $[Cr]$ and $[ADP]$ have no dynamics in A.8, A.10, the Lean files or Aleph (T3.12).
    - If $[PCr]$ and $[Cr]$ are held fixed, the CK term becomes a linear restoring force toward $a^\dagger = K_{eq}[PCr]a_{max}/(K_{eq}[PCr] + [Cr])$, powered by an inexhaustible phosphagen store. That breaks high-energy-phosphate conservation (Step 9).
    - If $[PCr]$ is dynamic, the steady state is unchanged (see Checks). So the A.8/A.10 claim that CK "stabilizes steady-state [ATP] within ±1.2%" cannot come from this term at steady state.
- (iv) *Compartments.* $v_{gn}$ and $v_{ox}$ are voxel fluxes (T3.1) per unit tissue volume, while $a_i$ is per unit neuronal cytosol. The production terms should be divided by the neuronal volume fraction and shared among the neurons that draw on the voxel (A.6 uses neuron-node weights $K_{ic}$). No source writes this conversion.

**Checks.**

- *Dimensions.* $k_{CK}$ [mM$^{-1}$s$^{-1}$] × mM$^2$ = mM/s. $Y_{ox}$ and the factor 2 are pure numbers (ATP per flux unit). $D_i$ is in mM/s.
- *Forward invariance of $[0, a_{max}]$.* Use T3.7, T3.10 and T3.3.
    - At $a_i = 0$: $D_i = 0$, because $m(0, K_{aD}) = 0$. Also $v_{gn}, v_{ox} \ge 0$ and $v_{CK} = k_{CK}[PCr]a_{max} \ge 0$. So $da_i/dt \ge 0$.
    - At $a_i = a_{max}$: $\theta = 0$, so $v_{gn} = v_{ox} = 0$. Also $[ADP] = 0$, so $v_{CK} = -k_{CK}[Cr]a_{max}/K_{eq} \le 0$, and $D_i \ge 0$. So $da_i/dt \le 0$.
- *Steady state with dynamic PCr.* $d[PCr]/dt = 0$ forces $v_{CK} = 0$, and then $2v_{gn} + Y_{ox}v_{ox} = D_i$. This is the same condition, and the same $a^*$, as without CK. A rapid-equilibrium buffer changes only transients. T3.12 derives $da/dt = (2v_{gn} + Y_{ox}v_{ox} - D)/B(a)$ with $B > 1$.
    - The A.8 docx lineage table reports the activation ATP drop shrinking from -14.8% (A.7) to -1.1% (A.8). If this were a purely transient effect with the same energy deficit, it would imply $B(a_0) \approx 13.5$.
    - A sustained activation of minutes, much longer than $B\tau_{ATP}$, still reaches the unbuffered steady state.
    - Flat steady-state ATP must instead come from the steepness of the ADP feedback $\theta(a)$ (T3.7, T3.10).
- *Rest production (implied).* With $v_{ox,0} = 0.53$ µmol/g/min (T3.1 Checks) and $Y_{ox} = 14.5$, oxidation supplies $7.7$ µmol ATP/g/min. Glycolysis adds $2v_{gn,0} \le 0.6$. So more than 90% of neuronal ATP is oxidative at rest. With $Y_{ox} = 27.5$ the oxidative supply would be 14.6, and per glucose $2 + 2(27.5) = 57$ ATP.
- *Slow-manifold limit (A.6 P7).* If the substrate pools are fast and glycogen is frozen, the equation reduces to $da/dt = S(f, a) - D$, which is the A.2 form "supply minus consumption".

**Lineage.**

- **Model A** (Model_A_Changelog_Audit_and_Fixes.md): $de_i/dt = g(e_Q - e_i) - h(e_i)p_i$. ATP buffers with power demand, no production chemistry.
- **A.2** (Model A.2 Repaired Specification and Validation.docx): $\dot e_i = g_x(e_Q - e_i) - \tfrac13\Pi_i - m(e_i)[\ldots]$. Supply comes by exchange with the domain reserve.
- **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eq. 9): same as A.2.
- **A.6** (Eq. 24): $da/dt = 2v_{gn} + Y_{ox}v_{ox} - D$ with $Y_{ox} = 14.5$ ("29 ATP per glucose oxidised"). A.6's own validation reports ATP falling 10-16% on activation, against flat ATP in $^{31}$P-MRS, and names a PCr buffer as the fix.
- **A.7** (annex Eq. 24): unchanged. Model A.7 Upgrade Doc (gemini).docx says a "PCr equilibrium equation" was added in A.7, but none of the A.7 equation files contains one.
- **A.8** (Model_A8_Scientific_Report.pdf Eq. (12); docx; Lean `da_dt`): adds the CK term, with $Y_{ox} = 27.5$ in the docx and in Lean.
- **A.10** (Eq. 3.1): identical to A.8.
- **Aleph 1:** the lineage table retains the "Creatine Kinase (PCr/Cr) buffer". The Sec. 9.1 invariant $K_{ischemia}$ uses $[PCr]_0$ but gives no value.

**Derivation status.** Derived under approximations. The approximations are:

- a well-mixed cytosol (A1);
- consensus P/O ratios and an averaged shuttle credit, giving $Y_{ox} = 14.5$ (A3);
- mass-action CK kinetics at fixed pH (A4);
- AMP neglected (A6).

The equation is not closed as printed: the PCr, Cr and ADP closure is missing (T3.12), and A.8 and Lean use the impossible $Y_{ox} = 27.5$.

---

## T3.3: ATP demand (pump plus maintenance and plasticity costs) (inherited: A.7 annex Eq. 24 / A.6 Eq. 24; A.8-Aleph write only $D_i$)

**Equation as stated** (Model A.6 four-caveat revision ... (claude).docx, Eq. 24, the only source that writes $D_{set}$; A.7 annex Eq. 24 restates the first relation only; A.8 PDF Eq. (12), A.10 Eq. 3.1 and Aleph name $D_i$, "demand (pump)", with no formula):

$$
D = D_{set}\frac{m(a, K_{aD})}{m(a_0, K_{aD})}, \qquad D_{set} = \frac{\Pi}{3} + m(a)\left[P_0 + \beta\sum W + \kappa\sum\left\lvert\frac{dW}{dt}\right\rvert + \kappa_c\sum\frac{dc^+}{dt}\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $D$ ($D_i$) | ATP consumption rate of neuron $i$ | mM/s |
| $D_{set}$ | demand at the reference ATP $a_0$ (not at "full" ATP; see Result) | mM/s |
| $\Pi$ ($\Pi_i$) | Na$^+$/K$^+$-ATPase flux in Na$^+$ units (T1.19), $\Pi_{max}m(a,K_a)m(n,K_n)$ | mM Na$^+$/s |
| $m(a, K_{aD})$ | ATP availability factor, $K_{aD} = 0.5$ mM | dimensionless |
| $a_0$ | reference (rest) ATP, 2.5 mM | mM |
| $m(a)$ | the A.2 availability factor $a/(a+K)$; $K$ never stated | dimensionless |
| $P_0$ | housekeeping (basal) cost | mM/s |
| $\beta$ | maintenance cost per unit synaptic weight | mM/s per unit $W$ |
| $\kappa$ | cost per unit weight change | mM per unit $W$ |
| $\kappa_c$ | cost per unit increase of the capture variable | mM per unit $c$ |
| $W$, $dW/dt$, $dc^+/dt$ | weights (T6.4), their rates of change, and the positive part of the capture rate (T6.8), summed over the synapses of neuron $i$ | $W$ dimensionless; rates in s$^{-1}$ |

**Physical starting point.** ATP consumption is the sum of the fluxes through all ATPases. One term has a fixed stoichiometry: the Na$^+$/K$^+$-ATPase exchanges 3 Na$^+$ out for 2 K$^+$ in per ATP hydrolysed (Post & Jolly 1957). The other terms are cost models, and their functional forms are modelling choices. Assumptions:

- A1. Pump ATP use is $\Pi/3$.
- A2. Since A.2, spikes and synaptic currents load Na$^+$ into the ledger (T1.18), so their ion-pumping cost is paid only through $\Pi$. Nothing else charges for spikes.
- A3. Non-pump costs are a basal term $P_0$, a maintenance cost proportional to total synaptic weight, a plasticity cost proportional to $\lvert dW/dt\rvert$ (both potentiation and depression cost energy), and a capture cost proportional to the positive part of $dc/dt$.
- A4. Demand falls as ATP falls. A.2 multiplies the non-pump terms by $m(a)$. A.6 then multiplies the whole of $D_{set}$ by $m(a,K_{aD})/m(a_0,K_{aD})$.

**Derivation.** These steps build the stated form. Only Step 1 is a derivation in the strict sense; Steps 2-3 encode the modelling choices.

1. *Pump term (A1).* The pump extrudes $\Pi$ Na$^+$ per unit time, and each ATP extrudes 3, so the pump uses $\Pi/3$ ATP per unit time.
2. *Non-pump terms (A3, A.2 weighting).*
$$
D_{np} = m(a)\left[P_0 + \beta\sum_j W_{ij} + \kappa\sum_j\left\lvert\frac{dW_{ij}}{dt}\right\rvert + \kappa_c\sum_j\left(\frac{dc_{ij}}{dt}\right)_+\right]
$$
   $D_{set} = \Pi/3 + D_{np}$.
3. *Availability scaling (A4).* ATPases are Michaelis-Menten in ATP, $v = V_{max}a/(a + K)$. Normalizing to the reference ATP gives $v(a) = v(a_0)\,m(a,K)/m(a_0,K)$. Applying this to all of $D_{set}$ gives
$$
D = D_{set}\frac{m(a,K_{aD})}{m(a_0,K_{aD})}
$$
   This is the printed form.
4. *Consistency of Steps 1 and 3 with the Na$^+$ ledger.* $\Pi$ already contains $m(a,K_a)$ (T1.19). After Step 3 the ATP charged for pumping is $(\Pi/3)\,m(a,K_{aD})/m(a_0,K_{aD})$, while the Na$^+$ ledger (T1.18) still removes $\Pi$. The number of Na$^+$ extruded per ATP charged is
$$
\frac{\Pi}{(\Pi/3)\,m(a,K_{aD})/m(a_0,K_{aD})} = 3\,\frac{m(a_0,K_{aD})}{m(a,K_{aD})}
$$
   This equals 3 only at $a = a_0$. For example, at $a = 1.0$ mM, $m(1.0, 0.5) = 0.667$ and $m(2.5, 0.5) = 0.833$, so the ratio is $3/0.8 = 3.75$ Na$^+$ per ATP. Above $a_0$ it falls below 3. The non-pump terms likewise carry two availability factors, $m(a)$ and $m(a,K_{aD})/m(a_0,K_{aD})$.
5. *Corrected form (Reconstructed).* Keep the stoichiometric pump term unscaled, as A.2 did ($-\tfrac13\Pi_i$ with no extra factor), and give the non-pump terms one availability factor:
$$
D = \frac{\Pi}{3} + \frac{m(a,K_{aD})}{m(a_0,K_{aD})}\left[P_0 + \beta\sum_j W_{ij} + \kappa\sum_j\left\lvert\frac{dW_{ij}}{dt}\right\rvert + \kappa_c\sum_j\left(\frac{dc_{ij}}{dt}\right)_+\right]
$$
   The ratio of Step 4 is then exactly 3 at every ATP level. Demand still vanishes as $a \to 0$, because $\Pi \propto m(a,K_a)$. The unspecified inner $m(a)$ is replaced by the normalized factor that A.6 introduced.

**Result.** The printed form follows from A1-A4, but A4 as implemented double-counts the ATP dependence of the pump. That breaks the 3 Na$^+$ : 1 ATP coupling between T1.18/T1.19 and the ATP ledger everywhere except $a = a_0$ (Step 4). The corrected form is Step 5. Further points:

- (i) *$D_{set}$ is demand at $a = a_0$, not "at full ATP".* $m(a,K_{aD})/m(a_0,K_{aD})$ exceeds 1 for $a > a_0$, approaching $(a_0 + K_{aD})/a_0 = 1.2$.
- (ii) *The constant in the inner $m(a)$ is never stated.*
- (iii) *$\beta$ must be the same constant* as the weight cost in the headroom constructions (T6.6, T6.15). There $\beta\sum W$ is compared with a capacity $C_{max,Q}$, so the units must match (mM/s).
- (iv) *Explicit formula last stated in A.6.* A.7 prints only $D = D_{set}m(a,K_{aD})/m(a_0,K_{aD})$ and uses $D_{set}$ in Eq. 18 without defining it.

**Checks.**

- *Dimensions.* $\Pi/3$ is mM/s if $\Pi$ is in mM Na$^+$/s. A.6 calls $n$ "normalised", while A.8 gives $n_c \approx 4$ mM, so the unit of $\Pi$ follows whichever convention is used for $n$. The other terms are in mM/s by the units in the table.
- *Sign.* Every term is non-negative, because $\lvert dW/dt\rvert \ge 0$ and $(dc/dt)_+ \ge 0$. So $D \ge 0$.
- *Limit $a \to 0$.* $D \to 0$ in both the printed and the corrected form. This keeps $a \ge 0$ (T3.2 Checks), and it is the A.6 change C6 that let glycogen extend aglycaemic survival.
- *Rest.* $D(a_0) = D_{set}(a_0) \equiv D_0$. This is the $D_0$ that normalizes the glycolytic feedforward in T3.7.
- *Headroom.* T6.5 sums these $D_k$ over a supply territory, so the Step 4 inconsistency propagates to $h_Q$.

**Lineage.**

- **Model A** (Model_A_Changelog_Audit_and_Fixes.md, power demand): $p_i = P_0(d_i) + \alpha(d_i,\ell_i)r_i + \alpha_{syn}\sum_j W_{ij}x_{ij}r_j + \beta\sum_j W_{ij} + \kappa\sum_j\lvert dW_{ij}/dt\rvert$, with explicit spike and synaptic costs, gated by $h(e_i)$.
- **A.2** (Model A.2 Repaired Specification and Validation.docx): spike and synaptic costs move into the Na$^+$ ledger and are paid as $-\tfrac13\Pi_i$, with no extra availability factor. The remaining costs carry $m(e_i)$, and the capture cost $\kappa_c\sum\dot c^+$ is added.
- **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eq. 9): as A.2.
- **A.6** (Eq. 24): the A.2 terms are collected into $D_{set}$ ("the A.2 consumption terms are kept intact inside $D_{set}$") and multiplied by $m(a,K_{aD})/m(a_0,K_{aD})$ (change C6). This step introduces the double count.
- **A.7** (annex Eq. 24): $D$ relation only.
- **A.8, A.10 and Aleph 1:** $D_i$ only.

**Derivation status.** Phenomenological closure. The pump stoichiometry (Step 1) is exact. The cost terms and the availability scaling are modelling choices, motivated by A.2's requirement that every energy drain stop when ATP is exhausted, and in A.6 by aglycaemic survival data (Wender 2000). As printed, the form is inconsistent with the Na$^+$ ledger except at $a = a_0$.

---

## T3.4: Exact carbon mass balance (inherited: Aleph Sec. 3 "First Law" statement / A.8 Tier 3)

**Equation as stated** (Model_Aleph_1_only equations.docx and Model_Aleph_1_Comprehensive_Scientific_Report.docx, Sec. 3 bullet "First Law of Thermodynamics"; identical in A.8 PDF Sec. 2.3, the A.8 docx, A.10 Tier 3 and A.6 P5):

$$
\frac{d}{dt}\left[G + \Gamma + \frac{L + p}{2}\right] = J_G - \frac{J_L}{2} - \frac{v_{ox}}{2}
$$

**Symbols and units.** As in T3.1. The bracket is total carbon in glucose equivalents (mM glucose). 6-carbon pools have weight 1 and 3-carbon pools weight 1/2.

**Physical starting point.** Conservation of carbon atoms (conservation of mass for each element), applied to the T3.1 balances. Assumptions:

- A1. The T3.1 balances and their stoichiometry hold.
- A2. CO$_2$ is not a tracked pool, so the 3 carbons per unit of $v_{ox}$ leave the ledger.
- A3. No other carbon pools exist in the model: no glutamate, glutamine, TCA intermediates, amino acids or ketone bodies.

**Derivation.**

1. *Carbon content.* Glucose and a glucosyl unit have 6 C; lactate and pyruvate have 3 C. Total carbon (mM C) is $C_{tot} = 6G + 6\Gamma + 3L + 3p$.
2. *Glucose equivalents.* Divide by 6: $Q \equiv C_{tot}/6 = G + \Gamma + \tfrac12(L + p)$.
3. *Differentiate.* The derivative is linear:
$$
\frac{dQ}{dt} = \frac{dG}{dt} + \frac{d\Gamma}{dt} + \frac12\frac{dL}{dt} + \frac12\frac{dp}{dt}
$$
4. *Substitute T3.1.*
$$
\frac{dQ}{dt} = (J_G - v_{gn} - v_{ga} - v_{syn}) + (v_{syn} - v_{gly}) + \frac12\left[2v_{ga} + 2v_{gly} + v_{ex} - J_L\right] + \frac12\left[2v_{gn} - v_{ox} - v_{ex}\right]
$$
5. *Expand the halves.*
$$
\frac{dQ}{dt} = J_G - v_{gn} - v_{ga} - v_{syn} + v_{syn} - v_{gly} + v_{ga} + v_{gly} + \tfrac12 v_{ex} - \tfrac12 J_L + v_{gn} - \tfrac12 v_{ox} - \tfrac12 v_{ex}
$$
6. *Collect coefficients flux by flux.*
    - $v_{gn}$: $-1 + 1 = 0$;
    - $v_{ga}$: $-1 + 1 = 0$;
    - $v_{syn}$: $-1 + 1 = 0$;
    - $v_{gly}$: $-1 + 1 = 0$;
    - $v_{ex}$: $+\tfrac12 - \tfrac12 = 0$;
    - $J_G$: $+1$; $J_L$: $-\tfrac12$; $v_{ox}$: $-\tfrac12$.
7. *Result.*
$$
\frac{d}{dt}\left[G + \Gamma + \frac{L + p}{2}\right] = J_G - \frac{J_L}{2} - \frac{v_{ox}}{2}
$$
   Steps 3-7 are what the Lean theorems `carbon_mass_balance_closure` (Model_A8_FormalVerification.lean) and `carbon_mass_balance` (Model_A8_All_Equations.lean and the patched file) prove, by unfolding the four rate definitions and closing with `ring`.

**Result.** This is an exact algebraic identity of the T3.1 stoichiometry, and it matches the printed form. Several points need flagging:

- (i) *It is carbon (mass) conservation, not the First Law of Thermodynamics*, to which Aleph Sec. 3 attributes it. Energy (ATP, heat) and O$_2$ do not appear.
- (ii) *The identity holds for any rate laws and any values of the O$_2$ coefficient and of $Y_{ox}$.* It therefore validates neither. A stronger exact ledger that does test the O$_2$ coefficient follows from T3.1 Step 11, though no source states it:
$$
\frac{d}{dt}\left[6G + 6\Gamma + 3(L + p) - c_O\,o\right] = 6J_G - 3J_L - J_O
$$
   (constant $c_O$; this holds exactly only under the redox convention T3.1 A3).
- (iii) *The A.6 "O$_2$ ledger" $c_O\,do/dt = J_O - 3v_{ox}$ is just the O$_2$ row of T3.1*, not an independent identity.
- (iv) *The "numerical residual $1.4\times10^{-4}$"* (A.6 P5; the A.8 docx says "< 1.4e-4") measures integration and quadrature error. Analytically the residual is zero.
- (v) *Interpretation of the sink.* $v_{ox}/2$ glucose equivalents per unit time leave as $3v_{ox}$ CO$_2$ ($= 6 \times v_{ox}/2$ carbons).

**Checks.**

- *Dimensions.* Both sides are mM glucose equivalents per s.
- *Carbon atoms.* Multiplying by 6 gives $\frac{d}{dt}(6G + 6\Gamma + 3L + 3p) = 6J_G - 3J_L - 3v_{ox}$: glucose brings 6 C, and each lactate washed out or 3-carbon unit oxidized removes 3 C.
- *Rest steady state (implied).* With all pools steady, $J_{G0} = J_{L0}/2 + v_{ox,0}/2$, that is $0.30 = 0.035 + 0.265$ µmol/g/min (T3.1 Checks). The lactate share $J_{L0}/(2J_{G0}) = 11.7\%$ equals $1 - \mathrm{OGI}/6$.
- *Total ischaemia.* With $J_O = 0$ and no glucose entry, $dQ/dt = -J_L/2 - v_{ox}/2 \le 0$ while $L > L_b$. Carbon can only fall. As printed, however, $J_G$ does not vanish at $f = 0$ (T3.5 Result (iii)).
- *Aglycaemia ($G_b = 0$).* $J_G = -T_G[1+\gamma_G(f-1)]\,m(G,K_T) < 0$, so glucose leaks back to blood, and $Q$ falls faster than oxidation alone would make it.

**Lineage.**

- **A.6** (P5): stated, with a numerical check.
- **A.7:** Validation 5 states it in words (model A.7 maths.docx), and Model A.7 Upgrade Doc (gemini).docx says the ledgers "balance perfectly".
- **A.8:** the PDF Sec. 2.3 inline and the docx "Conserved Metabolic Ledger Closure", plus the three Lean theorems.
- **A.10:** Tier 3 inline.
- **Aleph 1:** Sec. 3, under "First Law of Thermodynamics", in both Aleph files.

**Derivation status.** Exact. It is an algebraic identity of the T3.1 stoichiometry, independent of the rate laws.

---

## T3.5: GLUT1 glucose transport with flow-dependent capillary recruitment (inherited: A.8 PDF Eq. (9))

**Equation as stated** (Model_A8_Scientific_Report.pdf, Eq. (9); identical to A.6 Eq. 16 and A.7 annex Eq. 16):

$$
J_G = T_G\left[1 + \gamma_G(f - 1)\right]\left[\frac{G_b}{G_b + K_T} - \frac{G}{G + K_T}\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $J_G$ | net blood → tissue glucose flux per tissue volume | mM/s |
| $T_G$ | maximal net transport at rest flow, "from rest state" in A.6 | mM/s (implied 0.98 µmol/g/min, see Checks) |
| $\gamma_G$ | flow-recruitment coefficient, 0.5 ("assumed" in A.6) | dimensionless |
| $f$ | normalized flow $F/F_0$ (T2.15) | dimensionless |
| $G_b$ | blood (plasma) glucose, 5 mM | mM |
| $K_T$ | transporter dissociation constant, 5 mM | mM |
| $G$ | tissue glucose | mM |

**Physical starting point.** Facilitated diffusion by a mobile (alternating-access) carrier: the classical four-state "simple carrier" of membrane transport (Lieb & Stein; reviewed for GLUT1 by Carruthers 1990). The blood-brain barrier is two such membranes in series (luminal and abluminal endothelial membranes). The recruitment factor is a phenomenological linearization. Assumptions:

- A1. Four carrier states: empty and outward-facing ($E_o$), empty and inward-facing ($E_i$), loaded and outward-facing ($ES_o$), loaded and inward-facing ($ES_i$).
- A2. Binding and unbinding on each face are at rapid equilibrium, with the same dissociation constant $K_T$ on both faces.
- A3. Reorientation is first order and symmetric: rate constant $k$ for loaded carriers and $g$ for empty carriers, the same in both directions.
- A4. Equal mobility: $k = g$.
- A5. The total carrier $N$ is conserved, and the carrier distribution is at steady state (it relaxes much faster than $G$ changes).
- A6. The luminal and abluminal membranes have the same $K_T$. Endothelial glucose is at quasi-steady state, and the endothelium does not metabolize glucose.
- A7. Plasma glucose along the capillary stays at $G_b$ (small single-pass extraction, no flow limitation).
- A8. The number of working transporters is proportional to the perfused capillary surface $S$, and $S$ depends smoothly on flow.

**Derivation.**

1. *Rapid equilibrium (A2).* $[ES_o] = [E_o]\,G_b/K_T$ and $[ES_i] = [E_i]\,G/K_T$.
2. *Fraction loaded on each face.* Let $T_o = [E_o] + [ES_o] = [E_o](1 + G_b/K_T)$. Then
$$
\frac{[ES_o]}{T_o} = \frac{G_b/K_T}{1 + G_b/K_T} = \frac{G_b}{G_b + K_T} \equiv m_o
$$
   Likewise $[ES_i]/T_i = G/(G + K_T) \equiv m_i$, with $T_i = [E_i] + [ES_i]$.
3. *Net inward flux.* The net flux is the net reorientation of loaded carriers:
$$
J = k\left([ES_o] - [ES_i]\right) = k\left(T_o m_o - T_i m_i\right)
$$
4. *Carrier steady state (A5).* At steady state the net movement of carriers from the outer to the inner face is zero:
$$
k\left([ES_o] - [ES_i]\right) + g\left([E_o] - [E_i]\right) = 0
$$
   Substitute $[ES_x] = T_x m_x$ and $[E_x] = T_x(1 - m_x)$:
$$
T_o\left[k m_o + g(1 - m_o)\right] = T_i\left[k m_i + g(1 - m_i)\right]
$$
   Write this as $T_o\alpha_o = T_i\alpha_i$, with $\alpha_x = g + (k - g)m_x$.
5. *Carrier distribution.* Using $T_o + T_i = N$:
$$
T_o = \frac{N\alpha_i}{\alpha_o + \alpha_i}, \qquad T_i = \frac{N\alpha_o}{\alpha_o + \alpha_i}
$$
6. *Insert into Step 3.*
$$
J = \frac{kN\left(\alpha_i m_o - \alpha_o m_i\right)}{\alpha_o + \alpha_i}
$$
   The numerator simplifies:
$$
\alpha_i m_o - \alpha_o m_i = g m_o + (k-g)m_i m_o - g m_i - (k-g)m_o m_i = g(m_o - m_i)
$$
   Hence, for the general symmetric-affinity carrier,
$$
J = \frac{kgN\,(m_o - m_i)}{2g + (k - g)(m_o + m_i)}
$$
7. *Equal mobility (A4).* Setting $g = k$ makes the denominator $2k$:
$$
J = \frac{kN}{2}\,(m_o - m_i)
$$
   Define $T \equiv kN/2$. This is the maximal net flux ($m_o \to 1$, $m_i \to 0$).
8. *Two membranes in series (A6).* Let $x = m(G_e, K_T)$ be the saturation at endothelial glucose $G_e$. Flux continuity gives $T_1(m(G_b) - x) = T_2(x - m(G))$, so
$$
x = \frac{T_1 m(G_b) + T_2 m(G)}{T_1 + T_2}, \qquad J = \frac{T_1T_2}{T_1 + T_2}\left[m(G_b, K_T) - m(G, K_T)\right]
$$
   The saturation-difference form survives exactly, because both membranes share $K_T$ and the intermediate unknown appears only through the same function $m$.
9. *Recruitment (A8).* $T \propto S(f)$. Expand to first order about rest: $S(f) = S(1) + S'(1)(f - 1) + O((f-1)^2)$. Dividing by $S(1)$:
$$
\frac{S(f)}{S(1)} \approx 1 + \gamma_G(f - 1), \qquad \gamma_G \equiv \frac{S'(1)}{S(1)}
$$
   So $\gamma_G$ is the elasticity of perfused surface with respect to flow at rest.
10. *Combine.* Write $T_G$ for the rest value of $T_1T_2/(T_1+T_2)$, with $m_o = m(G_b,K_T)$ and $m_i = m(G,K_T)$:
$$
J_G = T_G\left[1 + \gamma_G(f - 1)\right]\left[\frac{G_b}{G_b + K_T} - \frac{G}{G + K_T}\right]
$$
   This is the printed equation.
11. *Equivalent rational form.* Over a common denominator,
$$
\frac{G_b}{G_b + K_T} - \frac{G}{G + K_T} = \frac{K_T(G_b - G)}{(G_b + K_T)(G + K_T)}
$$
   For $G, G_b \ll K_T$ this gives $J_G \approx (T_G/K_T)(G_b - G)$: passive transport with permeability-surface product $T_G/K_T$.

**Result.** Under A1-A8 the derivation reproduces the printed equation exactly. Several points need flagging:

- (i) *A4 (equal mobility) is a strong simplification.* Red-cell GLUT1 shows asymmetry and trans-acceleration (Carruthers 1990). Without A4 the denominator of Step 6 depends on $m_o + m_i$.
- (ii) *$\gamma_G$ is a first-order phenomenological recruitment law.* A.6 "assumed" it at 0.5, then calibrated $\chi_g$ and $L_b$ with it held fixed. The factor is linear and unbounded as $f \to \infty$. A.10's "stabilized substrate delivery under extreme hyperperfusion" has no formula, so whatever cap A.10 intends is unspecified.
- (iii) *Zero-flow limit.* As $f \to 0$ the factor tends to $1 - \gamma_G = 0.5 > 0$, and $G_b$ stays fixed (A7). The printed law therefore keeps supplying glucose at half the rest capacity with no flow, which is unphysical for complete ischaemia. *Reconstructed fix:* replace $G_b$ by the capillary outflow concentration $G_c$, given by the capillary mass balance $F_0 f(G_b - G_c) = J_G$ ($F_0$ is the rest plasma flow per tissue volume, in s$^{-1}$, with no value in any source). This gives the implicit flux law
$$
J_G = T_G\left[1 + \gamma_G(f-1)\right]\left[m\!\left(G_b - \frac{J_G}{F_0 f}, K_T\right) - m(G, K_T)\right]
$$
   The right side decreases monotonically in $J_G$, so the solution is unique. It satisfies $J_G \le F_0 f G_b \to 0$ as $f \to 0$, and recovers the printed law when $J_G \ll F_0 f G_b$.
- (iv) *Conflict with T3.6.* T3.6's Buxton extraction assumes a flow-independent capillary surface, which is the opposite assumption (see T3.6 Result (iii)).
- (v) *Aleph Sec. 3 files $J_G$ under "Michaelis-Menten & Hill enzyme kinetics".* The saturations do have Michaelis-Menten form, but the law is carrier transport, not enzyme catalysis.

**Checks.**

- *Dimensions.* $T_G$ [mM/s] × dimensionless factors.
- *No active transport.* $J_G = 0$ exactly when $G = G_b$, and $J_G > 0$ when $G < G_b$.
- *Rest saturation (implied).* $m(5,5) - m(1.2,5) = 0.5 - 0.1935 = 0.3065$. That is 61% of the zero-tissue-glucose capacity 0.5, matching A.6's statement that BBB transport "sits at 61% of capacity at rest". With $J_{G0} = 0.30$ µmol/g/min, $T_G = 0.30/0.3065 = 0.98$ µmol/g/min.
- *Why recruitment was needed (implied).* Suppose CMRglc rises 50% at steady state ($J_G = 0.45$).
    - With $\gamma_G = 0$, transport requires $m(G) = 0.5 - 0.45/0.979 = 0.040$, so $G = 0.21$ mM, a fall of 82%. This matches A.6's "without it glucose fell 80%".
    - With $\gamma_G = 0.5$ and $f = 1.729$ (the CBF rise of +72.9% that A.6 calibrates on), $G = 0.97$ mM, a fall of 19%. A.6 reports -13% to -18%.
- *Aglycaemia ($G_b = 0$).* $J_G = -T_G[\ldots]\,m(G, K_T) < 0$: glucose is lost to blood.

**Lineage.**

- **A.2-A.5:** no glucose transport (lumped supply).
- **A.6** (Eq. 16): introduced. Change C5 says it was "forced by data": without recruitment, tissue glucose fell 80% on activation.
- **A.7** (annex Eq. 16): unchanged.
- **A.8** (PDF Eq. (9); docx: "$\gamma_G \approx 0.5$ represents flow-dependent recruitment of perfused capillary surface area"): unchanged.
- **A.10:** "stabilized substrate delivery under extreme hyperperfusion", with no formula. The fly branch $J_G = D_{trachea}\nabla^2 G$ is outside Aleph's mammalian scope.
- **Aleph 1:** Sec. 3 names Michaelis-Menten kinetics for GLUT1 $J_G$.

**Derivation status.** Derived under approximations. The saturation-difference form is exact for a symmetric simple carrier with equal mobility at rapid binding equilibrium, including two identical membranes in series (A1-A6). The recruitment factor is a phenomenological first-order linearization (A8), with an assumed coefficient. The law fails as $f \to 0$ unless the capillary concentration is made flow-limited (Result (iii)).

---

## T3.6: O$_2$ delivery with Buxton flow-dependent extraction (inherited: A.8 Tier 3)

**Equation as stated** (Model_A8_Scientific_Report.docx and Model_A8_model only.docx, Tier 3; identical to A.6 Eq. 17 and A.7 annex Eq. 17):

$$
J_O = J_{O0}\, f\,\frac{E(f)}{E_0}\cdot\frac{o_a - o}{o_a - o_0}, \qquad E(f) = 1 - (1 - E_0)^{1/f}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $J_O$ | O$_2$ delivered from blood to tissue per tissue volume | mM/s |
| $J_{O0}$ | rest delivery, "from rest state" ($= 3v_{ox,0}$, implied 1.59 µmol/g/min) | mM/s |
| $f$ | normalized flow (T2.15) | dimensionless |
| $E(f)$, $E_0$ | extraction fraction and its rest value (no value in any source) | dimensionless |
| $o_a$ | arterial O$_2$ (no value; the units must match $o$) | mM |
| $o$, $o_0$ | tissue O$_2$ and its rest value 0.035 mM | mM |

**Physical starting point.** Permeability-limited exchange along a capillary (Renkin 1959; Crone 1963), as used in the oxygen-limitation model of Buxton & Frank 1997, plus a tissue back-pressure term. Aleph Sec. 3 lists $E(f)$ under "Michaelis-Menten & Hill enzyme kinetics"; that classification is wrong, because $E(f)$ comes from capillary transport. Assumptions:

- A1. The capillary is a plug-flow tube of length $\ell$ with blood flow $F$ (per tissue volume). The O$_2$ profile along it is at steady state, because transit time is short compared with changes in $o$.
- A2. O$_2$ leaves the capillary at a rate per unit length proportional to the local difference between capillary O$_2$ $C(x)$ and tissue O$_2$ $o$. The proportionality constant is set by a permeability-surface product $PS$.
- A3. The O$_2$ that drives diffusion is proportional to the O$_2$ content carried by the blood. This linearizes haemoglobin binding.
- A4. Tissue $o$ is uniform along the capillary (well-mixed voxel).
- A5. $PS$ does not depend on flow: no capillary recruitment (Buxton & Frank).
- A6. Arterial inflow concentration $o_a$ is fixed.

**Derivation.**

1. *Steady convection-exchange (A1, A2).*
$$
F\frac{dC}{dx} = -\frac{PS}{\ell}\left(C - o\right), \qquad C(0) = o_a, \quad 0 \le x \le \ell
$$
2. *Solve.* Since $o$ is constant in $x$ (A4), let $y = C - o$. Then $F\,dy/dx = -(PS/\ell)\,y$, so
$$
y(x) = (o_a - o)\exp\left(-\frac{PS\,x}{F\ell}\right)
$$
3. *Outflow.* $C(\ell) = o + (o_a - o)e^{-PS/F}$.
4. *Delivery.* Delivery equals the convective loss:
$$
J_O = F\left[o_a - C(\ell)\right] = F(o_a - o)\left(1 - e^{-PS/F}\right)
$$
5. *Extraction.* Define $E \equiv 1 - e^{-PS/F}$, the fraction of the arterial-tissue gradient removed in one pass. At rest, $E_0 = 1 - e^{-PS/F_0}$, so $e^{-PS/F_0} = 1 - E_0$ and $PS/F_0 = -\ln(1 - E_0)$.
6. *Flow dependence (A5).* With $f = F/F_0$ and fixed $PS$:
$$
e^{-PS/F} = \exp\left(-\frac{PS}{F_0}\cdot\frac{1}{f}\right) = (1 - E_0)^{1/f}, \qquad E(f) = 1 - (1 - E_0)^{1/f}
$$
7. *Normalize to rest.* $J_{O0} = F_0(o_a - o_0)E_0$, so $F_0 = J_{O0}/[E_0(o_a - o_0)]$.
8. *Substitute into Step 4.* With $F = F_0 f$:
$$
J_O = F_0 f\,(o_a - o)\,E(f) = J_{O0}\,f\,\frac{E(f)}{E_0}\cdot\frac{o_a - o}{o_a - o_0}
$$
   This is the printed equation.

**Result.** Under A1-A6 the derivation reproduces the printed equation exactly. Several points need flagging:

- (i) *$E$ is the extraction of the arterial-tissue gradient.* It equals the classical oxygen extraction fraction only when $o \ll o_a$; Buxton & Frank took tissue O$_2$ ≈ 0. With $o > 0$, the fraction of arterial O$_2$ removed is $E(f)(1 - o/o_a)$.
- (ii) *A3 replaces the sigmoid haemoglobin dissociation curve by a line, and $o_a$ is ambiguous.* $o_a$ could be dissolved arterial O$_2$ (comparable with the free tissue $o$) or total O$_2$ content. Neither $o_a$ nor $E_0$ has a value in any source.
- (iii) *A5 contradicts the recruitment assumed for glucose in T3.5.* If the perfused surface grows with flow as $1 + \gamma(f-1)$, then $PS(f) = PS_0[1 + \gamma(f-1)]$ and Step 6 becomes (Reconstructed):
$$
e^{-PS(f)/F} = \exp\left(-\frac{PS_0}{F_0}\cdot\frac{1 + \gamma(f-1)}{f}\right) = (1 - E_0)^{[1 + \gamma(f-1)]/f}, \qquad E(f) = 1 - (1 - E_0)^{[1+\gamma(f-1)]/f}
$$
   With $\gamma = 0$ this reduces to the printed form. A consistent model should use one recruitment law (one $\gamma$) for glucose, lactate (T3.11) and O$_2$, or justify why they differ.

**Checks.**

- *Dimensions.* $J_{O0}$ [mM/s] × dimensionless factors.
- *Rest.* At $f = 1$ and $o = o_0$, $E = E_0$ and $J_O = J_{O0}$.
- *Low-flow limit.* As $f \to 0^+$, $(1 - E_0)^{1/f} \to 0$ (since $0 < 1 - E_0 < 1$), so $E \to 1$. Then $J_O \approx J_{O0}\,f\,(o_a - o)/[E_0(o_a - o_0)] \to 0$, linear in $f$: delivery is flow-limited.
- *High-flow limit.* As $f \to \infty$, $1 - e^{-x/f} \approx x/f$ with $x = -\ln(1-E_0)$, so $fE(f) \to -\ln(1 - E_0)$. Then
$$
J_O \to J_{O0}\,\frac{-\ln(1-E_0)}{E_0}\cdot\frac{o_a - o}{o_a - o_0}
$$
  This is a finite, diffusion-limited ceiling, and the prefactor exceeds 1. This saturation is why O$_2$ delivery rises less than flow, the positive-BOLD mechanism A.2 cites.
- *Monotonicity.* $E(f)$ decreases with $f$, while $fE(f)$ increases with $f$.
- *Back-pressure.* $J_O \to 0$ as $o \to o_a$. At steady state $c_O\,do/dt = 0$, so $J_O = 3v_{ox}$ (T3.1) and $J_{O0} = 3v_{ox,0}$.

**Lineage.**

- **A.2** (Model A.2 Repaired Specification and Validation.docx): domain supply $J_0\,f_QE(f_Q)/E_0\,(1 - e_Q)$ with $E(f) = 1 - (1 - E_0)^{1/f}$, motivated by positive BOLD.
- **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eqs. 11-12): same.
- **A.6** (Eq. 17): delivery to the O$_2$ pool with the back-pressure factor $(o_a - o)/(o_a - o_0)$.
- **A.7** (annex Eq. 17): unchanged; the reader extraction notes it is of Renkin-Crone type, though no source names it.
- **A.8** (docx): unchanged, described as "formalizing Buxton's oxygen extraction fraction".
- **Aleph 1:** Sec. 3 lists $E(f)$ under Michaelis-Menten/Hill kinetics.

**Derivation status.** Derived under approximations. The approximations are:

- plug-flow steady capillary profile (A1);
- linear wall exchange (A2);
- linear O$_2$ binding (A3);
- uniform tissue O$_2$ (A4);
- no recruitment (A5), which conflicts with T3.5.

---

## T3.7: Pump-coupled neuronal glycolysis with ADP feedback (inherited: A.8 Tier 3)

**Equation as stated** (Model_A8_Scientific_Report.docx and Model_A8_model only.docx, Tier 3; identical to A.6 Eq. 18 and A.7 annex Eq. 18):

$$
v_{gn} = V_{gn}\, m(G, K_G)\,\theta(a)\left[1 + \chi_g\left(\frac{D_{set}}{D_0} - 1\right)\right]_+, \qquad \theta(a) = \frac{a_{max} - a}{a_{max} - a + K_d}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{gn}$ | neuronal glycolytic flux, glucose → 2 pyruvate | mM glucose/s |
| $V_{gn}$ | maximal rate, "from rest state" (A.6) | mM/s |
| $K_G$ | effective glucose saturation constant, 0.5 mM | mM |
| $\theta(a)$ | ADP activation factor. The symbol clashes with the thresholds $\theta_i$ (T1.21); $\theta_{ADP}$ would be clearer | dimensionless |
| $a_{max}$ | total adenine nucleotide, so $a_{max} - a$ is ADP (no value in any source) | mM |
| $K_d$ | ADP half-activation constant (no value in any source) | mM |
| $\chi_g$ | demand feedforward gain, 1.49 (calibrated, A.6) | dimensionless |
| $D_{set}$, $D_0$ | demand at reference ATP (T3.3) and its rest value | mM/s |

**Physical starting point.** A phenomenological rate law with three multiplicative controls:

- substrate saturation (glucose uptake and hexokinase);
- activation of glycolysis by ADP (the phosphofructokinase and pyruvate kinase steps respond to the adenylate state);
- a feedforward from ATP demand. A.6's motivation: "the Na$^+$/K$^+$ pump draws preferentially on glycolytic ATP; this is the term that makes lactate rise during activation."

Assumptions:

- A1. One rate-limiting step, with Michaelis-Menten dependence on glucose and an effective constant $K_G$.
- A2. ADP acts as a Michaelis-Menten activator with constant $K_d$.
- A3. Adenine nucleotides are conserved and AMP is neglected: $[ADP] = a_{max} - a$.
- A4. The three controls act independently, so their factors multiply.
- A5. The feedforward is linear in the demand ratio near rest, and clipped at zero.

**Derivation.** These steps build the stated form; they are modelling choices, not consequences of a law.

1. *Glucose saturation (A1).* $V_{gn}\,m(G, K_G)$.
2. *ADP activation (A2).* $\theta = [ADP]/([ADP] + K_d)$.
3. *Adenine conservation (A3).* Substituting $[ADP] = a_{max} - a$ gives $\theta(a) = (a_{max} - a)/(a_{max} - a + K_d)$.
4. *Independence (A4).* For a rapid-equilibrium mechanism with independent binding sites, the fraction of active enzyme factors into one saturation per ligand (the same algebra as T3.10 Steps 1-3). This gives the product $m(G,K_G)\,\theta(a)\,\Phi$.
5. *Feedforward (A5).* Let $\Phi(x)$, with $x = D_{set}/D_0$, be any smooth demand response normalized so that $\Phi(1) = 1$. The first-order Taylor expansion about rest is $\Phi(x) \approx 1 + \Phi'(1)(x - 1)$. Set $\chi_g \equiv \Phi'(1)$ and take the positive part so that $v_{gn} \ge 0$:
$$
\Phi(x) = \left[1 + \chi_g(x - 1)\right]_+
$$
6. *Meaning of $\chi_g$.* At fixed $G$ and $a$, $\partial\ln v_{gn}/\partial\ln D_{set} = \chi_g$ at $D_{set} = D_0$. So $\chi_g = 1.49$ means a 1% rise in demand raises neuronal glycolysis by 1.49% through the feedforward alone.
7. *Calibration (A.6 Sec. 4b).* $\chi_g = 1.49$ was calibrated, with $\gamma_G = 0.5$ held fixed, so that the glucose increment on activation is twice the oxidative increment (Dienel, Rothman & Mangia 2025; "increment ratio 2:1"). $V_{gn}$ is fixed by the exact rest solution.

**Result.** Steps 1-5 give the printed form exactly. The form is a modelling choice motivated by data, not a derivation. Points to flag:

- (i) *$a_{max}$ and $K_d$ have no values in any source,* although they set the strength of the ADP feedback for both glycolysis and oxidation (T3.10 uses the same $\theta$).
- (ii) *Symbol clash.* $\theta(a)$ clashes with the thresholds $\theta_i$ and $\theta_0$ (T1.20, T1.21).
- (iii) *"Pump-coupled" is a misnomer.* $D_{set}$ contains every demand term (T3.3), not only the pump.
- (iv) *Shut-off.* The positive part sets $v_{gn} = 0$ when $D_{set}/D_0 < 1 - 1/\chi_g = 0.329$. $D_{set}$ falls when ATP falls ($\Pi \propto m(a,K_a)$, and the non-pump terms carry $m(a)$). In energy failure the feedforward therefore *lowers* glycolysis while $\theta(a)$ raises it. The two loops have opposite signs, and below 33% of rest demand neuronal glycolysis stops completely.
- (v) *Effective rather than enzymatic $K_G$.* $K_G = 0.5$ mM is well above the reported glucose $K_m$ of brain hexokinase (tens of µM). $m(G, K_G)$ is therefore an effective transport-plus-phosphorylation saturation.
- (vi) *Redox.* The NADH made by $v_{gn}$ is carried in $p$ (T3.1, A3). If $v_{gn}$ outruns $v_{ox}$, $p$ rises and $v_{ex}$ turns the excess into lactate. This is how the term produces the activation lactate rise.

**Checks.**

- *Dimensions.* $V_{gn}$ is in mM/s, and every factor is dimensionless.
- *Limits.*
    - $G \to 0$: $v_{gn} \to 0$.
    - $a \to a_{max}$ (no ADP): $\theta \to 0$ and $v_{gn} \to 0$.
    - $a \to 0$: $\theta \to a_{max}/(a_{max} + K_d)$, the maximum.
    - $D_{set} = D_0$: the feedforward factor is 1.
- *Steepness of the ADP feedback.* Differentiating $\ln\theta$ with respect to $\ln a$:
$$
\frac{\partial\ln\theta}{\partial\ln a} = -\frac{a}{a_{max} - a}\cdot\frac{K_d}{a_{max} - a + K_d}
$$
  The first factor is the ATP/ADP ratio, which is large when ADP is small. A small fractional fall in ATP then produces a large fractional rise in $\theta$. This high-gain feedback, not the CK buffer, is what can keep steady-state ATP nearly flat (T3.2 Checks).

**Lineage.**

- **A.2-A.5:** no glycolysis (lumped ATP).
- **A.6** (Eq. 18, change C5): introduced. It was "forced by data": without the feedforward, lactate *fell* by 4% on activation against a measured rise of 23-30%.
- **A.7** (annex Eq. 18): unchanged. Model A.7 Upgrade Doc (gemini).docx says A.7 "redox-couple[d] glycolysis and lactate dehydrogenase (LDH) activity directly within the neuronal cytosol", but no formula accompanies that claim, and the A.7 equation files keep the A.6 form.
- **A.8** (docx): unchanged; "$\chi_g \approx 1.49$ tightly couples neuronal glycolysis to sodium pump demand".
- **A.10 and Aleph 1:** no restatement.

**Derivation status.** Phenomenological closure. The functional form (Michaelis-Menten substrate saturation, Michaelis-Menten ADP activation with adenine conservation, and a linear demand feedforward) is a modelling choice. The evidence is A.6's activation data: lactate +23% (Mangia 2007), neuronal glycolysis rising independently of lactate import (Díaz-García 2017), and the 2:1 increment ratio (Dienel 2025). $a_{max}$ and $K_d$ are never given values.

---

## T3.8: Astrocytic glycolysis coupled to glutamate uptake (astrocyte-neuron lactate shuttle) (inherited: A.8 Tier 3)

**Equation as stated** (Model_A8_Scientific_Report.docx and Model_A8_model only.docx; identical to A.6 Eq. 19 and A.7 annex Eq. 19):

$$
v_{ga} = m(G, K_G)\left(V_{ga0} + \phi\, V_{glu}\, u\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{ga}$ | astrocytic glycolysis, glucose → 2 lactate | mM glucose/s |
| $V_{ga0}$ | activity-independent astrocytic glycolysis | mM/s |
| $V_{glu}$ | glucose-equivalent rate of glutamate uptake at rest | mM/s |
| $u$ | glutamate cycling relative to rest (A.6: $u = 1 + A$ at activity level $A$; A.8: "glutamate uptake") | dimensionless (rest 1) |
| $\phi$ | ANLS share in $[0,1]$, default 0.5 (A.6: "not identifiable from bulk data") | dimensionless |
| $K_G$ | glucose saturation constant, 0.5 mM (shared with T3.7) | mM |

**Physical starting point.** The astrocyte-neuron lactate shuttle stoichiometry of Pellerin & Magistretti (1994). Glutamate taken up by astrocytes is co-transported with Na$^+$ (EAAT stoichiometry: 3 Na$^+$ and 1 H$^+$ in, 1 K$^+$ out per glutamate; Zerangue & Kavanaugh 1996). The Na$^+$ is removed by the Na$^+$/K$^+$-ATPase, glutamate is amidated to glutamine, and the ATP for both comes from glycolysis to lactate. Assumptions:

- A1. Each glutamate taken up brings in 3 Na$^+$.
- A2. The astrocytic pump removes 3 Na$^+$ per ATP.
- A3. Glutamine synthetase uses 1 ATP per glutamate.
- A4. A fraction $\phi$ of this ATP comes from astrocytic glycolysis to lactate, which yields 2 ATP per glucose. The source of the remaining $1 - \phi$ is not modelled.
- A5. Basal astrocytic glycolysis $V_{ga0}$ does not depend on activity.
- A6. Glucose saturation is the same as for neurons ($K_G$).

**Derivation.**

1. *ATP per glutamate (A1-A3).* Pumping costs $3/3 = 1$ ATP, and glutamine synthesis costs 1 ATP, for a total of 2 ATP per glutamate.
2. *Glucose per glutamate (A4).* At 2 ATP per glucose, $2/2 = 1$ glucose per glutamate, releasing 2 lactate. This is the Pellerin-Magistretti 1:1 coupling.
3. *Rate.* Let the glutamate uptake rate be $J_{glu} = J_{glu,0}\,u$. Glucose demand for uptake is $1 \times J_{glu}$. Define $V_{glu} \equiv J_{glu,0}$ (in glucose units) to get $V_{glu}u$.
4. *ANLS share (A4).* Multiply by $\phi$: $\phi V_{glu}u$.
5. *Basal term (A5).* Add $V_{ga0}$.
6. *Substrate saturation (A6).* Multiply by $m(G, K_G)$:
$$
v_{ga} = m(G, K_G)\left(V_{ga0} + \phi V_{glu}u\right)
$$
   This is the printed form.

**Result.** Steps 1-6 give the printed form exactly. The 1:1 stoichiometry follows from the stated transporter and enzyme stoichiometries (A1-A3). The structure (additive basal term, a share $\phi$, and saturation on everything) is a modelling choice. Points to flag:

- (i) *$\phi$ is not a share in a conservation sense.* Nothing in the model supplies the $(1 - \phi)$ part of the astrocytic ATP need, because astrocytic oxidation is absent (T3.1, A4). Lowering $\phi$ therefore removes glucose consumption rather than moving it to another pathway. A true share would need an astrocytic oxidative flux that uses O$_2$.
- (ii) *Rest rate.* The rest astrocytic rate is $m(G_0,K_G)(V_{ga0} + \phi V_{glu})$. $V_{ga0}$ is only the activity-independent part.
- (iii) *$u$ is overloaded.* It is a dimensionless relative rate with no stated dynamics: an input set by activity. The same letter is the sleep gate $u(t)$ in T6.12, and the glycogenolysis term $c_K(u - 1)_+$ in T3.9 also reads it.
- (iv) *Unidentifiability (source finding).* A.6 reports that sweeping $\phi$ from 0 to 1 moves the activation lactate rise from +23% to +27% and the increment ratio from 1.97 to 2.13. The A.8 docx reports +21.5% to +26.2% and 1.95 to 2.14. Both shifts are within the spread between studies, so $\phi$ stays an open parameter at 0.5.
- (v) *The 1:1 coupling is itself debated.* The A.7 Upgrade Doc cites biosensor work in which neuronal glycolysis rises independently of astrocytic lactate. The model keeps both routes ($v_{gn}$ and $v_{ga}$).

**Checks.**

- *Dimensions.* $V_{ga0}$ and $V_{glu}$ are in mM/s, and $u$, $\phi$ and $m$ are dimensionless.
- *Limits.*
    - $\phi = 0$: $v_{ga} = m(G,K_G)V_{ga0}$, with no activity coupling.
    - $G \to 0$: $v_{ga} \to 0$.
    - At rest ($u = 1$): $v_{ga} = m(G_0, K_G)(V_{ga0} + \phi V_{glu})$.
- *Lactate output.* $2v_{ga}$ enters $L$ directly (T3.1). Neurons take it up when $v_{ex} < 0$, that is when $L/\rho > p$ (T3.11). This is the "shuttle".

**Lineage.**

- **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, caveat 6.2.2): the ANLS is not modelled.
- **A.6** (Eq. 19): introduced, with $\phi$ declared unidentifiable.
- **A.7** (annex Eq. 19): unchanged. Model A.7 Upgrade Doc (gemini).docx says the ANLS was "pruned" and replaced by direct neuronal redox coupling, which contradicts the annex.
- **A.8** (docx): unchanged; the $\phi$ sweep is repeated.
- **Aleph 1:** the lineage table says A.10.1 "couples astrocytic lactate shuttling directly to local pericyte dilation" (T3.14).

**Derivation status.** Phenomenological closure. The 1 glucose : 1 glutamate coefficient follows from the transporter and enzyme stoichiometry (Pellerin & Magistretti 1994). The additive structure, the share $\phi$ and the saturation factor are modelling choices. $\phi$ is not identifiable from bulk data, and the missing astrocytic oxidative branch makes it a scale factor rather than a share.

---

## T3.9: Glycogen synthesis and glycogenolysis fluxes (inherited: A.8 Tier 3 for $v_{syn}$; A.7 annex Eq. 21 for $v_{gly}$)

**Equation as stated** ($v_{syn}$: Model_A8_Scientific_Report.docx, identical to A.6 Eq. 20 and A.7 annex Eq. 20. $v_{gly}$: Model A.7 with all equations.docx, annex Eq. 21, identical to A.6 Eq. 21, the last explicit statement. A.8 gives $v_{gly}$ only in words: "accelerated by extracellular potassium, noradrenaline, and severe glucose scarcity ($G < G_h$)"):

$$
v_{syn} = V_{syn}\, m(G, K_{Gs})\left(1 - \frac{\Gamma}{\Gamma_{max}}\right)
$$

$$
v_{gly} = V_{gl}\, m(\Gamma, K_\Gamma)\left[1 + c_K(u - 1)_+ + c_{NE}\,NE + c_h\,\sigma\left(\frac{G_h - G}{s_h}\right) + c_{h2}\,\sigma\left(\frac{G_{h2} - G}{s_{h2}}\right)\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{syn}$, $v_{gly}$ | glycogen synthesis and breakdown | mM glucosyl/s |
| $V_{syn}$, $V_{gl}$ | rate scales, "from rest state" (A.6) | mM/s |
| $K_{Gs}$, $K_\Gamma$ | saturation constants for glucose (synthesis) and glycogen (breakdown); no values in any source | mM |
| $\Gamma_{max}$ | glycogen storage capacity; no value in any source | mM glucosyl |
| $c_K$ | activity (named K$^+$) activation gain; reads $u$ (T3.8) | dimensionless |
| $c_{NE}$, $NE$ | noradrenergic gain and NE level; $NE$ must be a real, non-negative, normalized level | dimensionless product |
| $c_h$, $c_{h2}$ | hypoglycaemic gains, 4 and 40 (assumed, A.6) | dimensionless |
| $G_h$, $G_{h2}$ | thresholds, 0.4 and 0.12 mM | mM |
| $s_h$, $s_{h2}$ | sigmoid widths; no values in any source | mM |

**Physical starting point.** Phenomenological enzyme-level rate laws:

- *Synthesis:* glucose → glucose-6-P → glucose-1-P → UDP-glucose → glycogen, through glycogen synthase.
- *Breakdown:* glycogen phosphorylase. Its activity is raised through phosphorylase kinase by cAMP/PKA (noradrenaline acting on β-adrenergic receptors) and by Ca$^{2+}$, and astrocytic glycogenolysis is also triggered by raised K$^+$. Glucose inhibits phosphorylase $a$ allosterically.

Assumptions:

- A1. Synthesis is Michaelis-Menten in glucose and limited by the free storage capacity $1 - \Gamma/\Gamma_{max}$.
- A2. Breakdown is Michaelis-Menten in its substrate $\Gamma$.
- A3. Activators act additively and independently on a basal rate: activity above rest, NE, and two hypoglycaemia switches (mild and severe).
- A4. The UTP and ATP costs of synthesis (one high-energy phosphate net per glucosyl cycled) are not charged, because astrocytic ATP is not tracked.

**Derivation.** These steps build the stated form; they are modelling choices.

1. *Synthesis (A1).* $V_{syn}\,m(G, K_{Gs})\,g(\Gamma)$, where $g$ is any decreasing capacity factor with $g(0) = 1$ and $g(\Gamma_{max}) = 0$. The simplest (linear) choice is $g = 1 - \Gamma/\Gamma_{max}$, which bounds $\Gamma \le \Gamma_{max}$.
2. *Breakdown basal rate (A2).* $V_{gl}\,m(\Gamma, K_\Gamma)$.
3. *Activation (A3).* Multiply by $1 + \sum_k c_k s_k$, with signals $s_k$:
    - $(u - 1)_+$, activity above rest;
    - $NE$;
    - $\sigma((G_h - G)/s_h)$, a smooth switch that turns on as $G$ falls below $G_h = 0.4$ mM;
    - $\sigma((G_{h2} - G)/s_{h2})$, a second, stronger switch below $G_{h2} = 0.12$ mM.

   This gives the printed $v_{gly}$.
4. *Reconstructed form of the A.7 prose.* Model A.7 Upgrade Doc (gemini).docx says that in A.7 glycogenolysis "is now governed strictly by standard mass-action kinetics and allosteric inhibition by glucose", replacing the "dual artificial sigmoids". It gives no formula. The standard reading is rapid-equilibrium competitive inhibition of phosphorylase by glucose (inhibition constant $K_{iG}$):
    - Binding: $E + \Gamma \rightleftharpoons E\Gamma$ ($K_\Gamma$) and $E + G \rightleftharpoons EG$ ($K_{iG}$).
    - Enzyme conservation: $E_{tot} = E\left(1 + \Gamma/K_\Gamma + G/K_{iG}\right)$.
    - Rate: $v = k_{cat}[E\Gamma] = k_{cat}E_{tot}(\Gamma/K_\Gamma)/(1 + \Gamma/K_\Gamma + G/K_{iG})$.

   Hence
$$
v_{gly} = V_{gl}\,\frac{\Gamma}{\Gamma + K_\Gamma\left(1 + G/K_{iG}\right)}\left[1 + c_K(u - 1)_+ + c_{NE}\,NE\right]
$$
   This makes mobilization rise smoothly as glucose falls, without thresholds. It removes six parameters ($c_h$, $c_{h2}$, $G_h$, $G_{h2}$, $s_h$, $s_{h2}$) and adds one ($K_{iG}$). The A.7 Upgrade Doc's change table gives the parameter saving only as an image, read as 4 by the extraction, so the exact A.7 form cannot be recovered.

**Result.** The printed forms follow from A1-A3 as modelling choices. Points to flag:

- (i) *The versions conflict.* A.6 and the A.7 annex print the sigmoid form. The A.7 Upgrade Doc says the sigmoids were replaced by competitive inhibition (Step 4 reconstructs that). A.8 gives words only. A.10 and Aleph say nothing.
- (ii) *The "K$^+$" term reads activity, not K$^+$.* $c_K$ multiplies $(u - 1)_+$, glutamate cycling, not extracellular K$^+$. If K$^+$ activation is meant, the natural argument is $(k_c - k_{rest})_+/k_{rest}$ from T2.13.
- (iii) *Which NE.* The LC oscillator of T2.2 gives a complex amplitude, but $v_{gly}$ needs a real, non-negative, normalized NE level. No source says which.
- (iv) *Missing values.* $\Gamma_{max}$, $K_{Gs}$, $K_\Gamma$, $s_h$ and $s_{h2}$ are never given.
- (v) *Energy cost not charged.* Synthesis costs one high-energy phosphate net per glucosyl cycled, and this is not charged anywhere (A4).

**Checks.**

- *Dimensions.* $V_{syn}$ and $V_{gl}$ are in mM/s. The activation bracket is dimensionless if $NE$ is normalized.
- *Bounds.* $v_{syn} = 0$ at $\Gamma = \Gamma_{max}$ and $v_{gly} = 0$ at $\Gamma = 0$, so $[0, \Gamma_{max}]$ is forward invariant (T3.1 Checks).
- *Severe aglycaemia.* For $G \ll G_{h2}$ with narrow switches, both sigmoids approach 1. The bracket is then at least $1 + 4 + 40 = 45$: breakdown runs at 45 times or more the basal rate.
- *Rest is not disturbed (implied constraints).* At $G_0 = 1.2$ mM the switches contribute $c_h\sigma(-0.8/s_h) + c_{h2}\sigma(-1.08/s_{h2})$.
    - Keeping the severe term below 0.04 needs $\sigma(-1.08/s_{h2}) < 10^{-3}$, which means $s_{h2} < 1.08/6.91 = 0.156$ mM.
    - Keeping the mild term below 0.04 needs $\sigma(-0.8/s_h) < 10^{-2}$, which means $s_h < 0.8/4.60 = 0.174$ mM.
- *Glycogen relaxation time (implied bound on $\Gamma_{max}$).* Linearize at rest with $G$ and the activators held fixed:
    - $\partial v_{syn}/\partial\Gamma = -V_{syn}m(G)/\Gamma_{max} = -v_{syn,0}/(\Gamma_{max} - \Gamma_0)$;
    - $\partial v_{gly}/\partial\Gamma = v_{gly,0}K_\Gamma/[\Gamma_0(\Gamma_0 + K_\Gamma)]$.

  Hence
$$
\frac{1}{\tau_\Gamma} = \frac{v_{syn,0}}{\Gamma_{max} - \Gamma_0} + \frac{v_{gly,0}K_\Gamma}{\Gamma_0(\Gamma_0 + K_\Gamma)}
$$
  A.6 gives $\tau_\Gamma = 12.5$ h, $v_{syn,0} = v_{gly,0} = 0.35$ mM/h and $\Gamma_0 = 7$ mM, so the bracket must equal $0.08/0.35 = 0.229$ mM$^{-1}$. The second term lies strictly between 0 and $1/\Gamma_0 = 0.143$ mM$^{-1}$, which forces
$$
11.4 \ \text{mM} < \Gamma_{max} < 18.7 \ \text{mM}
$$
  This holds if the 12.5 h mode is essentially the $\Gamma$ diagonal element, which the separation from the 5.5 min glucose mode supports.
- *Stoichiometry.* Each unit of $v_{gly}$ gives 2 lactate (T3.1).

**Lineage.**

- **A.6** (Eqs. 20-21, change C6): introduced. Graded glycogenolysis under severe glucose lack was forced by data. Without it, aglycaemic failure came at 4 min regardless of glycogen. With it, survival scales 1.47× against 1.44× observed (Wender 2000).
- **A.7:** annex Eqs. 20-21 are unchanged. Model A.7 Upgrade Doc (gemini).docx describes competitive mass-action inhibition instead, without a formula.
- **A.8** (docx): $v_{syn}$ is explicit and $v_{gly}$ is in words. Rat $\Gamma_0 = 7.0$ mM, $c_h = 4$, $c_{h2} = 40$, with 34 min aglycaemic survival.
- **A.10 and Aleph 1:** no formula. Aleph Table 3 gives species $\Gamma_0$ values, and the Aleph test list includes a rat glycogen resynthesis rate (0.12 mM/min benchmark).

**Derivation status.** Phenomenological closure. Both laws are modelling choices motivated by glycogen data: aglycaemic survival (Wender 2000), hypoglycaemic mobilization (Öz 2009) and turnover (Öz 2015). The source statements of $v_{gly}$ conflict, and several constants have no values.

---

## T3.10: Oxidative phosphorylation flux (inherited: A.8 Tier 3)

**Equation as stated** (Model_A8_Scientific_Report.docx and Model_A8_model only.docx; identical to A.6 Eq. 22 and A.7 annex Eq. 22):

$$
v_{ox} = V_{ox}\, m(p, K_p)\, m(o, K_o)\,\theta(a)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{ox}$ | oxidation of 3-carbon units from $p$ (uses 3 O$_2$, yields $Y_{ox}$ ATP) | mM/s |
| $V_{ox}$ | maximal rate, "from rest state" | mM/s |
| $K_p$ | pyruvate saturation constant, 50 µM | mM |
| $K_o$ | O$_2$ saturation constant, 3 µM | mM |
| $\theta(a)$ | ADP activation (T3.7) | dimensionless |

**Physical starting point.** The whole mitochondrial pathway is lumped into one step: pyruvate import and pyruvate dehydrogenase, the TCA cycle, the respiratory chain and ATP synthase. It has three controls: substrate supply, O$_2$ at cytochrome $c$ oxidase, and ADP (respiratory control: state 3, ADP-stimulated, versus state 4, ADP-limited; Chance & Williams 1955). Assumptions:

- A1. A single rate-limiting step proceeds at a rate proportional to the fraction of a lumped catalyst that has pyruvate, O$_2$ and ADP all bound.
- A2. Binding is at rapid equilibrium, and the sites are independent: no ligand changes another's dissociation constant.
- A3. $[ADP] = a_{max} - a$ (T3.7).
- A4. There is no proton-leak respiration, no product inhibition (by ATP or NADH), and no Ca$^{2+}$ activation of the dehydrogenases.

**Derivation.**

1. *Rapid-equilibrium random binding of two ligands, A (pyruvate) and B (O$_2$) (A2).* The catalyst states are $E$, $EA$, $EB$ and $EAB$, with
$$
[EA] = [E]\frac{A}{K_A}, \qquad [EB] = [E]\frac{B}{K_B}, \qquad [EAB] = [E]\frac{AB}{K_AK_B}
$$
   The last relation, with no interaction factor, is the independence assumption.
2. *Conservation.*
$$
E_{tot} = [E]\left(1 + \frac{A}{K_A} + \frac{B}{K_B} + \frac{AB}{K_AK_B}\right) = [E]\left(1 + \frac{A}{K_A}\right)\left(1 + \frac{B}{K_B}\right)
$$
3. *Rate (A1).*
$$
v = k_{cat}[EAB] = k_{cat}E_{tot}\,\frac{AB/(K_AK_B)}{(1 + A/K_A)(1 + B/K_B)} = V\,m(A, K_A)\,m(B, K_B)
$$
4. *Third independent ligand.* Adding ADP with constant $K_d$ multiplies the conservation sum by $(1 + [ADP]/K_d)$ and the rate by $[ADP]/K_d$, giving a third factor $m([ADP], K_d)$. By A3 this factor is $\theta(a)$.
5. *Assemble.*
$$
v_{ox} = V_{ox}\,m(p, K_p)\,m(o, K_o)\,\theta(a)
$$
   This is the printed form.

**Result.** The product form is exact for a single step with three independent rapid-equilibrium ligands (Steps 1-4). Treating a whole pathway that way is the modelling choice. Points to flag:

- (i) *No state-4 respiration.* By A4, $v_{ox} = 0$ when ADP = 0. Real mitochondria respire in state 4 at a leak-limited rate. This omission matters for any ROS coupling (T3.13).
- (ii) *Shared ADP feedback.* $\theta(a)$ uses the same $a_{max}$ and $K_d$ as glycolysis (T3.7), and neither has a value.
- (iii) *ROS claimed but absent.* A.9's "coupled oxidative phosphorylation to ROS" adds no term here (T3.13).

**Checks.**

- *Dimensions.* $V_{ox}$ is in mM/s, and the three factors are dimensionless.
- *Rest saturations (implied).* $m(o_0, K_o) = 0.035/0.038 = 0.92$ and $m(p_0, K_p) = 0.08/0.13 = 0.62$ (with $p_0 \approx 0.08$ mM, T3.1). Hence $V_{ox}\theta(a_0) = 0.53/(0.62 \times 0.92) \approx 0.94$ µmol/g/min.
- *O$_2$ sensitivity.* The elasticity is $\partial\ln v_{ox}/\partial\ln o = K_o/(o + K_o) = 0.079$ at rest, so oxidation is almost O$_2$-insensitive until $o$ approaches a few µM.
- *Limits.* $v_{ox} \to 0$ as $p \to 0$, as $o \to 0$ (anoxia) or as $a \to a_{max}$ (no ADP).
- *Ledgers.* Each unit uses 3 O$_2$ (T3.1) and makes $Y_{ox}$ ATP (T3.2).

**Lineage.**

- **A.6** (Eq. 22): introduced. $K_p$ and $K_o$ are labelled "standard kinetics".
- **A.7** (annex Eq. 22): unchanged.
- **A.8** (docx): unchanged; the docx states $Y_{ox} \approx 27.5$ next to it (see T3.2).
- **A.9:** "coupled oxidative phosphorylation to ROS" in the Aleph lineage table, with no formula.
- **A.10 and Aleph 1:** no restatement.

**Derivation status.** Phenomenological closure. The factorized Michaelis-Menten form is exact for one step with independent rapid-equilibrium binding of pyruvate, O$_2$ and ADP. Lumping the whole pathway into such a step, with no leak and no product inhibition, is a modelling choice.

---

## T3.11: LDH/MCT pyruvate-lactate exchange and lactate washout (inherited: A.7 annex Eq. 22 / A.6 Eq. 22; only named in A.8)

**Equation as stated** (Model A.7 with all equations.docx, annex Eq. 22; identical to A.6 Eq. 22. A.8 names $v_{ex}$ "LDH/MCT" and $J_L$ "washout" without formulas):

$$
v_{ex} = k_{ex}\left(p - \frac{L}{\rho}\right), \qquad J_L = k_{Lb}(L - L_b)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{ex}$ | net pyruvate → lactate conversion; negative means net lactate uptake into $p$ | mM/s |
| $k_{ex}$ | exchange rate constant, 1 s$^{-1}$ (assumed, A.6) | s$^{-1}$ |
| $\rho$ | equilibrium lactate/pyruvate ratio, 10 (A.6: "L/p ≈ 10"). Clashes with other uses of $\rho$ | dimensionless |
| $J_L$ | lactate washout to blood | mM/s |
| $k_{Lb}$ | washout rate constant (no value printed; implied 0.0137 s$^{-1}$, see Checks) | s$^{-1}$ |
| $L_b$ | blood lactate, 0.715 mM (calibrated in A.6 to the +26% lactate rise) | mM |

**Physical starting point.** Two processes in series move carbon between $p$ and $L$:

- lactate dehydrogenase, pyruvate + NADH + H$^+$ ⇌ lactate + NAD$^+$, treated by mass action at a clamped redox state;
- a monocarboxylate transporter (MCT), a proton-linked carrier treated like the symmetric carrier of T3.5.

The washout uses the same carrier model for endothelial MCT1. Assumptions:

- A1. Cytosolic NADH/NAD$^+$ and pH are clamped (redox-buffered) and enter as constants.
- A2. LDH follows mass action, or equivalently a reversible Michaelis-Menten (Haldane) law linearized near equilibrium.
- A3. Neuronal lactate $L_n$ is at quasi-steady state between LDH and the neuronal MCT. The MCT is linear (concentrations well below its $K_m$, or near equilibrium), and all concentrations refer to the same volume.
- A4. The endothelial MCT1 is a symmetric carrier, linearized about the operating point. $L_b$ is fixed, and there is no flow dependence.

**Derivation.**

1. *LDH mass action.*
$$
v_{LDH} = k_f[NADH][H^+]\,p - k_r[NAD^+]\,L_n
$$
2. *Factor (A1).*
$$
v_{LDH} = k_1\left(p - \frac{L_n}{\rho}\right), \qquad k_1 \equiv k_f[NADH][H^+], \qquad \rho \equiv \frac{k_f[NADH][H^+]}{k_r[NAD^+]} = K_{LDH}\frac{[NADH][H^+]}{[NAD^+]}
$$
   Here $K_{LDH} = k_f/k_r = [L][NAD^+]/([P][NADH][H^+])$ at equilibrium. So $\rho$ is the lactate/pyruvate ratio at LDH equilibrium for the clamped redox state. For a reversible Michaelis-Menten law, a first-order expansion in the displacement from equilibrium gives the same form, with an effective $k_1$.
3. *Neuronal MCT (A3).* $v_{MCT} = k_2(L_n - L)$. This is the linear limit of the symmetric-carrier law of T3.5 Step 11.
4. *Quasi-steady state.* $v_{LDH} = v_{MCT} = v_{ex}$. From Step 2, $L_n = \rho p - \rho v_{ex}/k_1$.
5. *Substitute into Step 3.*
$$
v_{ex} = k_2\left(\rho p - \frac{\rho v_{ex}}{k_1} - L\right)
$$
6. *Solve for $v_{ex}$.*
$$
v_{ex}\left(1 + \frac{\rho k_2}{k_1}\right) = k_2(\rho p - L) \quad\Rightarrow\quad v_{ex} = \frac{\rho k_1k_2}{k_1 + \rho k_2}\left(p - \frac{L}{\rho}\right)
$$
7. *Identify.* With
$$
k_{ex} = \frac{\rho k_1k_2}{k_1 + \rho k_2}
$$
   this is the printed form. If LDH is fast ($k_1 \to \infty$), $k_{ex} \to \rho k_2$ and transport limits the exchange. If transport is fast ($k_2 \to \infty$), $k_{ex} \to k_1$ and LDH limits it.
8. *Washout carrier (A4).* By T3.5 Steps 1-8 with constant $K_M$:
$$
J_L = T_L\left[m(L, K_M) - m(L_b, K_M)\right] = \frac{T_LK_M(L - L_b)}{(L + K_M)(L_b + K_M)}
$$
9. *Linearize.* Evaluate the denominator at an operating level $\bar L$ (with $L$ and $L_b$ close to $\bar L$, or both $\ll K_M$):
$$
J_L \approx k_{Lb}(L - L_b), \qquad k_{Lb} = \frac{T_LK_M}{(K_M + \bar L)^2}
$$
   The relative error is $(K_M + \bar L)^2/[(L + K_M)(L_b + K_M)] - 1$, which is small when $\lvert L - \bar L\rvert, \lvert L_b - \bar L\rvert \ll K_M$. The MCT1 $K_m$ for L-lactate is reported in the few-mM range (Halestrap & Price 1999), above the 0.7-1 mM concentrations here.

**Result.** Under A1-A4 the derivation reproduces both printed laws. $v_{ex}$ is exact for mass-action LDH in series with a linear transporter at clamped redox. $J_L$ is the linearization of a symmetric carrier. Points to flag:

- (i) *No recruitment in $J_L$.* $J_L$ lacks the factor $1 + \gamma_G(f - 1)$ given to glucose crossing the same capillary wall (T3.5). A consistent version (Reconstructed) is $J_L = k_{Lb}[1 + \gamma_G(f - 1)](L - L_b)$.
- (ii) *Proton coupling ignored.* MCTs co-transport H$^+$. Activity-driven pH changes are ignored (A1).
- (iii) *Values.* $k_{ex} = 1$ s$^{-1}$ is assumed, $L_b$ is calibrated, and $k_{Lb}$ is never printed.
- (iv) *Symbol clash.* $\rho$ is also used for densities and firing set points ($\rho_i$ in T1.21).
- (v) *These two fluxes plus $2(v_{ga} + v_{gly})$ make up the whole lactate shuttle.* Astrocytes add lactate to $L$, neurons take it up when $L > \rho p$, and blood removes the excess.

**Checks.**

- *Dimensions.* $k_{ex}$ and $k_{Lb}$ [s$^{-1}$] × mM.
- *Equilibrium.* $v_{ex} = 0$ exactly when $L = \rho p$, and $J_L = 0$ exactly when $L = L_b$.
- *Implied washout constant.* From the rest budget (T3.1 Checks), $J_{L0} = 0.07$ µmol/g/min and $L_0 - L_b = 0.8 - 0.715 = 0.085$ mM. So $k_{Lb} = 0.07/0.085 = 0.82$ min$^{-1}$ = 0.0137 s$^{-1}$.
- *Lactate time constant (implied, compared with A.6 P6).* Take the $(L, p)$ subsystem with $G$, $o$ and $a$ frozen. The Jacobian is
$$
\mathbf{J} = \begin{pmatrix} -\left(\dfrac{k_{ex}}{\rho} + k_{Lb}\right) & k_{ex} \\ \dfrac{k_{ex}}{\rho} & -\left(k_{ex} + \dfrac{\partial v_{ox}}{\partial p}\right) \end{pmatrix}, \qquad \frac{\partial v_{ox}}{\partial p} = \frac{v_{ox,0}K_p}{p_0(p_0 + K_p)}
$$
  With $v_{ox,0} = 0.53/60$ mM/s, $p_0 = 0.08$ mM and $K_p = 0.05$ mM, $\partial v_{ox}/\partial p = 0.0425$ s$^{-1}$.
    - Diagonal entries: $-0.1137$ and $-1.0425$ s$^{-1}$; off-diagonal entries: $1$ and $0.1$ s$^{-1}$.
    - Trace: $-1.156$ s$^{-1}$; determinant: $0.1137 \times 1.0425 - 0.1 = 0.0186$ s$^{-2}$.
    - Eigenvalues: $-0.0163$ and $-1.140$ s$^{-1}$.

  The slow mode has a time constant of 61 s, matching the 63 s lactate time constant reported in A.6 P6. This supports the implied $k_{Lb}$ and the unit conventions.

**Lineage.**

- **A.6** (Eq. 22): introduced. "Lactate and pyruvate exchange through LDH/MCT towards L/p = ρ."
- **A.7** (annex Eq. 22): unchanged; the last explicit statement.
- **A.8:** the docx flow diagram names "LDH/MCT $v_{ex}$" and "$J_L$ Washout" without formulas, and the A.8 extraction lists $J_L$ as undefined.
- **A.10 and Aleph 1:** the lactate shuttle is retained in words, and A.10.1 couples it to pericytes (T3.14).

**Derivation status.** Derived under approximations. The approximations are:

- clamped cytosolic redox and pH (A1);
- mass-action or near-equilibrium LDH (A2);
- quasi-steady neuronal lactate with a linear transporter (A3);
- a linearized symmetric endothelial carrier without flow dependence (A4).

---

## T3.12: Phosphocreatine / creatine pool dynamics for the CK buffer (claimed: Aleph Sec. 2 lineage table, "Creatine Kinase (PCr/Cr) buffer"; no PCr equation)

**Equation as stated.** NOT STATED IN ANY SOURCE.

PCr appears only in the following places:

- inside the CK term of the ATP balance (T3.2): A.8 PDF Eq. (12), the A.8 docx and A.10 Eq. 3.1;
- in the A.8 docx reaction "[PCr] + [ADP] + H$^+$ ⇌ [Cr] + [ATP]" and its flow diagram "[Neuronal ATP a_i] ⟷ (CK Equilibrium) ⟷ [Phosphocreatine PCr]";
- in the Lean definition `da_dt`, which takes `PCr`, `Cr` and `ADP` as free real arguments;
- in the Aleph lineage table;
- in the Aleph Sec. 9.1 invariant $K_{ischemia} = ([PCr]_0 + 2[ATP]_0 + 2\Gamma_0)/(\lambda_n n_{eq}F)$.

Model A.7 Upgrade Doc (gemini).docx says "a PCr equilibrium equation" was introduced, but no A.7 equation file contains one. The following are missing:

- a balance for $[PCr]$;
- creatine conservation;
- a closure for $[ADP]$;
- values for $k_{CK}$, $K_{eq}$, $[PCr]_0$ and total creatine.

What follows is a proposal, labelled Reconstructed throughout.

**Symbols and units (proposal).**

| Symbol | Meaning | Units |
|---|---|---|
| $[PCr]$ | phosphocreatine | mM |
| $C_{tot}$ | total creatine, $[PCr] + [Cr]$ | mM |
| $a_i$, $a_{max}$ | ATP and total adenine nucleotide, $[ADP] = a_{max} - a_i$ | mM |
| $k_{CK}$, $K_{eq}$ | as in T3.2 | mM$^{-1}$s$^{-1}$, dimensionless |
| $B(a)$ | effective buffering factor | dimensionless |

**Physical starting point (Reconstructed).** The stoichiometry of the CK reaction, conservation of the creatine and adenine moieties, and a timescale separation (rapid-equilibrium elimination of a fast reversible reaction, as in Tikhonov reduction). Assumptions:

- A1. Each CK turnover consumes 1 PCr and 1 ADP and produces 1 Cr and 1 ATP.
- A2. Total creatine $C_{tot} = [PCr] + [Cr]$ is constant over the time scales of interest (no synthesis or uptake).
- A3. $[ATP] + [ADP] = a_{max}$ (T3.2, A6).
- A4. For the reduction only: CK relaxes much faster than ATP production and demand change.

**Derivation (Reconstructed).**

1. *PCr balance (A1).* $\nu_{PCr} = -1$ per unit $v_{CK}$, so $d[PCr]/dt = -v_{CK}$.
2. *Close with A2 and A3.* Substitute $[Cr] = C_{tot} - [PCr]$, $[ADP] = a_{max} - a_i$ and $[ATP] = a_i$ into $v_{CK}$ (T3.2 Step 6):
$$
\frac{d[PCr]}{dt} = -k_{CK}\left([PCr]\,(a_{max} - a_i) - \frac{(C_{tot} - [PCr])\,a_i}{K_{eq}}\right)
$$
3. *High-energy phosphate.* Add Step 2 to T3.2. The CK terms cancel:
$$
\frac{d}{dt}\left(a_i + [PCr]\right) = 2v_{gn} + Y_{ox}v_{ox} - D_i
$$
4. *Rapid equilibrium (A4).* $v_{CK} \approx 0$, so $(C_{tot} - P)\,a = K_{eq}\,P\,(a_{max} - a)$, writing $P = [PCr]$ and $a = a_i$.
5. *Solve for $P$.* Collecting the $P$ terms, $P\left[K_{eq}(a_{max} - a) + a\right] = C_{tot}\,a$, so
$$
P_{eq}(a) = \frac{C_{tot}\,a}{K_{eq}(a_{max} - a) + a}
$$
   Equivalently, $[PCr]/[Cr] = ([ATP]/[ADP])/K_{eq}$.
6. *Differentiate the total.* With $H = a + P_{eq}(a)$, the chain rule gives $dH/dt = \left[1 + P_{eq}'(a)\right]da/dt$.
7. *Quotient rule.*
$$
P_{eq}'(a) = C_{tot}\,\frac{\left[K_{eq}(a_{max} - a) + a\right] - a\,(1 - K_{eq})}{\left[K_{eq}(a_{max} - a) + a\right]^2} = \frac{C_{tot}K_{eq}\,a_{max}}{\left[K_{eq}(a_{max} - a) + a\right]^2}
$$
8. *Reduced ATP equation.* Combine Steps 3, 6 and 7:
$$
\frac{da_i}{dt} = \frac{2v_{gn} + Y_{ox}v_{ox} - D_i}{B(a_i)}, \qquad B(a) = 1 + \frac{C_{tot}K_{eq}\,a_{max}}{\left[K_{eq}(a_{max} - a) + a\right]^2}
$$
9. *When the reduction is valid.* Consider the CK reaction alone, with $dP/dt = -v_{CK}$ and $da/dt = +v_{CK}$. The partial derivatives are
$$
\frac{\partial v_{CK}}{\partial P} = k_{CK}\left([ADP] + \frac{[ATP]}{K_{eq}}\right), \qquad \frac{\partial v_{CK}}{\partial a} = -k_{CK}\left([PCr] + \frac{[Cr]}{K_{eq}}\right)
$$
   The chain rule gives $dv_{CK}/dt = -\lambda_{CK}v_{CK}$, with
$$
\lambda_{CK} = k_{CK}\left([ADP] + \frac{[ATP]}{K_{eq}} + [PCr] + \frac{[Cr]}{K_{eq}}\right)
$$
   The reduction holds when $\lambda_{CK}$ is much larger than the relaxation rate of the buffered ATP balance (A.6 P6 gives 2.1 s for the unbuffered ATP mode).
10. *How strong the buffer can be.* Write $x = a_{max} - a$ (ADP). Then $B - 1 = C_{tot}a_{max}K_{eq}/(K_{eq}x + a)^2$, and
$$
\frac{\partial(B - 1)}{\partial K_{eq}} = C_{tot}a_{max}\,\frac{(K_{eq}x + a) - 2K_{eq}x}{(K_{eq}x + a)^3} = C_{tot}a_{max}\,\frac{a - K_{eq}x}{(K_{eq}x + a)^3}
$$
   This vanishes at $K_{eq} = a/x = [ATP]/[ADP]$, which by Step 5 is where $[PCr] = [Cr]$. Substituting:
$$
B_{max} - 1 = \frac{C_{tot}\,a_{max}}{4\,[ATP][ADP]}
$$
   Because free ADP is small, $B$ can be large.

**Result (proposal).** The closure is Step 2 plus creatine and adenine conservation. With it, the T3.2 system conserves high-energy phosphate exactly (Step 3). Under rapid equilibrium it reduces to the buffered ATP equation of Step 8. This form answers the question left open in T3.2:

- The buffer slows ATP transients by the factor $B(a)$.
- It does not move the steady state: $v_{CK} = 0$ there, so $2v_{gn} + Y_{ox}v_{ox} = D$ as before.
- The A.8 lineage-table change from -14.8% to -1.1% can therefore be a transient effect only. It would need $B(a_0) \approx 13.5$, which by Step 10 requires $C_{tot}a_{max}/(4a_0[ADP]_0) \ge 12.5$.
- No source gives the values needed to test this.

**Checks.**

- *Dimensions.* $k_{CK}$ [mM$^{-1}$s$^{-1}$] × mM$^2$ = mM/s. $B$ is dimensionless, since $C_{tot}K_{eq}a_{max}$/mM$^2$ has no units.
- *Conservation.* $d([PCr] + [Cr])/dt = 0$ by construction, and $d(a + [PCr])/dt$ contains no CK term.
- *Invariance of $[0, C_{tot}]$.* At $[PCr] = 0$, $d[PCr]/dt = k_{CK}C_{tot}a/K_{eq} \ge 0$. At $[PCr] = C_{tot}$, $d[PCr]/dt = -k_{CK}C_{tot}(a_{max} - a) \le 0$.
- *Limits of $B$.*
    - $C_{tot} \to 0$: $B \to 1$ (no buffer).
    - $K_{eq} \to 0$: $B - 1 = C_{tot}K_{eq}a_{max}/a^2 \to 0$.
    - $K_{eq} \to \infty$: $B - 1 \to C_{tot}a_{max}/(K_{eq}x^2) \to 0$.

  The buffer works best at intermediate $K_{eq}$ (Step 10).
- *Lean theorem.* `ck_equilibrium_preserves_atp_flux` is the special case $v_{CK} = 0$ of Step 4. It says nothing about $B$.

**Lineage.**

- **A.6:** the validation report says ATP falls 10-16% on activation, against flat $^{31}$P-MRS ATP, and lists "a phosphocreatine buffer (keeps ATP flat)" as the next addition.
- **A.7:** the Upgrade Doc (gemini) says it was added; the A.7 equations do not contain it.
- **A.8:** adds the CK term only, claiming ±1.2%.
- **A.10 and Aleph 1:** the same CK term, and the $K_{ischemia}$ invariant uses $[PCr]_0$.

**Derivation status.** Incomplete in source. No PCr, Cr or ADP dynamics, no creatine conservation and no parameter values appear anywhere. A reconstructed closure (Steps 1-2) and its rapid-equilibrium reduction (Steps 4-8) are supplied.

---

## T3.13: OXPHOS-ROS coupling (claimed: Aleph Sec. 2 lineage table, A.9 "coupled oxidative phosphorylation to ROS")

**Equation as stated.** NOT STATED IN ANY SOURCE.

The nearest material:

- *A.2* (Model A.2 Repaired Specification and Validation.docx) cites Sarnataro et al. 2025: fly sleep pressure traced to mitochondrial electron leak when ATP demand falls below supply. It proposes a readout $m(e)(1 - C/C_{max})$, "specified but not yet simulated".
- *Model A.7 Upgrade Doc (gemini).docx* says synaptic downscaling is "coupled to the local ATP/ADP ratio and the biophysical accumulation of reactive oxygen species (ROS) from mitochondrial electron leak". It gives no formula.
- *The Aleph lineage table* credits A.9 with "coupled oxidative phosphorylation to ROS".
- *The A.9 file* (Model_A9_changes from a8.docx) contains no ROS variable or equation, and neither do A.10 or the Aleph Sec. 5 equations.

No ROS variable, production law, scavenging law or feedback target is defined. What follows is a proposal, labelled Reconstructed throughout.

**Symbols and units (proposal).**

| Symbol | Meaning | Units |
|---|---|---|
| $R$ | ROS pool, counted as H$_2$O$_2$ equivalents | mM |
| $\epsilon_0$ | leak fraction during phosphorylating respiration (O$_2$ reduced by one electron per O$_2$ consumed) | dimensionless |
| $\epsilon_1$ | leak coefficient of a reduced chain when ADP is lacking | dimensionless |
| $k_R$ | first-order scavenging rate | s$^{-1}$ |

**Physical starting point (Reconstructed).** Mitochondrial superoxide comes from single-electron reduction of O$_2$, mainly at complexes I and III. Its rate rises steeply with the protonmotive force and with how reduced the electron carriers are (Korshunov, Skulachev & Starkov 1997; Murphy 2009). Both are high when substrate and O$_2$ are plentiful but ADP is scarce (state 4). Superoxide dismutase turns superoxide into H$_2$O$_2$, which peroxiredoxins, glutathione peroxidase and catalase remove. Assumptions:

- A1. During phosphorylating respiration, a constant fraction $\epsilon_0$ of the O$_2$ reduced by the chain ($3v_{ox}$, T3.1) is reduced by one electron only.
- A2. An extra leak, proportional to the oxidative capacity that is held back by lack of ADP, represents the reduced, high-potential state.
- A3. Dismutation is fast. The 1/2 stoichiometry (2 O$_2^{\bullet-}$ → 1 H$_2$O$_2$) is absorbed into $\epsilon_0$ and $\epsilon_1$.
- A4. Scavenging is Michaelis-Menten with a constant much larger than $R$, hence first order.

**Derivation (Reconstructed).**

1. *Phosphorylating leak (A1).* The O$_2$ flux through the chain is $3v_{ox}$, so the production term is $3\epsilon_0 v_{ox}$.
2. *ADP-limited capacity (A2).* The ADP-unlimited oxidative rate is $V_{ox}m(p,K_p)m(o,K_o)$. Using T3.10, the capacity held back by low ADP is
$$
V_{ox}m(p,K_p)m(o,K_o) - v_{ox} = V_{ox}m(p,K_p)m(o,K_o)\left[1 - \theta(a)\right]
$$
   The production term is $\epsilon_1 V_{ox}m(p,K_p)m(o,K_o)[1 - \theta(a)]$.
3. *Removal (A4).* $-k_RR$.
4. *Assemble (A3).*
$$
\frac{dR}{dt} = 3\epsilon_0\,v_{ox} + \epsilon_1\,V_{ox}\,m(p,K_p)\,m(o,K_o)\left[1 - \theta(a)\right] - k_R\,R
$$
5. *Steady state.* Substitute $v_{ox} = V_{ox}m(p)m(o)\theta$:
$$
R^* = \frac{V_{ox}m(p,K_p)m(o,K_o)}{k_R}\left[3\epsilon_0\,\theta(a) + \epsilon_1\left(1 - \theta(a)\right)\right]
$$
   So $\partial R^*/\partial\theta \propto 3\epsilon_0 - \epsilon_1$. ROS rises as ADP falls (supply exceeding demand, the Sarnataro condition) if and only if $\epsilon_1 > 3\epsilon_0$.
6. *O$_2$ ledger consistency.* The Step 2 term uses O$_2$ that is not in $3v_{ox}$. To keep T3.1 exact, the O$_2$ row would become $c_O\,do/dt = J_O - 3v_{ox} - \epsilon_1V_{ox}m(p,K_p)m(o,K_o)[1 - \theta(a)]$ (taking one O$_2$ per ROS unit before the A3 halving). Alternatively, this term can be neglected if $\epsilon_1$ is small. T3.10 omits proton-leak respiration in the same way.
7. *Feedback target (not fixed by any source).* Candidate targets:
    - the adenosine drive of the sleep gate (T6.12), e.g. adding $+\eta_RR$ to A.7 annex Eq. 36, $d[Ado]/dt = \eta\Pi_Q - \lambda_u[Ado] - v_{glymph}[Ado]$;
    - A.2's surplus readout $m(e)(1 - C/C_{max})$;
    - direct gating of synaptic downscaling, as the A.7 Upgrade Doc describes.

   Choosing among them needs data.

**Result (proposal).** Step 4 is a minimal ROS balance consistent with the existing Tier 3 variables. It adds three parameters ($\epsilon_0$, $\epsilon_1$, $k_R$) and no new inputs.

**Checks.**

- *Dimensions.* Every production term is (dimensionless) × mM/s, and $k_RR$ is in mM/s.
- *Limits.*
    - Anoxia ($o \to 0$): production → 0.
    - Saturating ADP ($\theta$ at its maximum, state 3): mainly the $\epsilon_0$ leak.
    - No ADP ($\theta \to 0$, state 4): only the $\epsilon_1$ leak, with $v_{ox} = 0$.
- *Positivity.* $R = 0$ gives $dR/dt \ge 0$.
- *No values.* No source supplies $\epsilon_0$, $\epsilon_1$ or $k_R$.

**Lineage.**

- **A.2:** electron-leak sleep pressure proposed as a readout.
- **A.7:** prose only (Upgrade Doc).
- **A.9:** credited by Aleph with the coupling, but the A.9 file contains no ROS equation.
- **A.10 and Aleph 1:** no equation.

**Derivation status.** Incomplete in source. There is no variable, no production law, no scavenging law and no feedback target. A reconstructed balance (Step 4) is supplied as a proposal.

---

## T3.14: Astrocytic lactate shuttle → local pericyte dilation coupling (claimed: Aleph Sec. 2 lineage table, A.10.1 "Tier 3 final fix")

**Equation as stated.** NOT STATED IN ANY SOURCE.

The Aleph lineage table says A.10.1 "preserves mass balance; couples astrocytic lactate shuttling directly to local pericyte dilation", but neither Aleph file writes the coupling. The nearest stated pieces:

- *Astrocytic lactate output:* $2(v_{ga} + v_{gly})$ (T3.1, T3.8, T3.9).
- *Lactate fluxes:* exchange $v_{ex}$ and washout $J_L$ (T3.11).
- *The pericyte/capillary state of T2.14* (A.6 Eqs. 13-14; A.8 Tier 2):
$$
\tau_\psi\frac{d\psi_c}{dt} = -\psi_c + q_c, \qquad r_e = r_0\left(1 + \beta_c\bar\psi_e\right)
$$
  Here A.6 defines $q_c$ as "local neural/glutamate activity", and A.8 calls it driven by "neuro-glial messengers".
- *The astrocytic term in the arteriole equation* (T2.9): $\beta_{astro}\mathcal{F}_{A2B}(Ado, cAMP)$, with $\mathcal{F}_{A2B}$ never defined. This acts on arterioles, not pericytes.
- *The A.7 audit* (A.7-research-report.md) proposed modelling the adenosine-A$_{2B}$-cAMP-lactate cascade in astrocytes (citing Theparambil et al.). It gave no formula.

What follows is a proposal, labelled Reconstructed throughout.

**Symbols and units (proposal).**

| Symbol | Meaning | Units |
|---|---|---|
| $q_c^{act}$ | the existing activity drive of T2.14 (zero at rest) | dimensionless (A.6: "relative") |
| $\ell_c$ | fractional lactate excess at node $c$, $(L_c - L_0)/L_0$ | dimensionless |
| $\beta_{LP}$ | maximal lactate contribution to the pericyte drive | dimensionless |
| $K_{LP}$, $n_L$ | half-activation and Hill coefficient | dimensionless |

**Physical starting point (Reconstructed).** First-order pericyte relaxation (T2.14) driven by a vasoactive messenger that rises with interstitial lactate. A candidate mechanism: lactate raises extracellular PGE$_2$ by reducing its uptake through the prostaglandin transporter (Gordon et al. 2008), and PGE$_2$ relaxes capillary pericytes through EP4 receptors (Hall et al. 2014; A.6 already uses Hall 2014 for $\beta_c$). Assumptions:

- A1. The messenger $M$ obeys $\tau_M\,dM/dt = -M + \kappa_M\,g(L)$ with $\tau_M \ll \tau_\psi$, so $M \approx \kappa_M\,g(L)$.
- A2. The pericyte response to $M$ saturates (receptor occupancy), giving a Hill function of the lactate excess.
- A3. The lactate term vanishes at rest, so that $r_e = r_0$ at rest is kept.
- A4. The lactate and activity drives add.

**Derivation (Reconstructed).**

1. *Start from T2.14.* $\tau_\psi\,d\psi_c/dt = -\psi_c + q_c$.
2. *Quasi-steady messenger (A1).* Setting $dM/dt \approx 0$ gives $M = \kappa_M\,g(L_c)$.
3. *Saturating response (A2, A3).* Use the fractional excess $\ell_c = (L_c - L_0)/L_0$ and a Hill law. The drive is
$$
\beta_{LP}\,H(\ell_c), \qquad H(\ell) = \frac{(\ell)_+^{n_L}}{K_{LP}^{n_L} + (\ell)_+^{n_L}}
$$
4. *Add to the activity drive (A4).*
$$
q_c = q_c^{act} + \beta_{LP}\,H(\ell_c)
$$
5. *Steady state.* $\psi_c^* = q_c$, so the lactate-driven part of the capillary dilation is $\Delta r_e/r_0 = \beta_c\beta_{LP}H(\bar\ell_e)$, where $\bar\ell_e$ is the edge average. It is bounded by $\beta_c\beta_{LP}$.
6. *Flux-based alternative.* "Lactate shuttling" can also be read as the production flux rather than the concentration:
$$
q_c = q_c^{act} + \beta_{LP}\,H\!\left(\frac{(v_{ga} + v_{gly})_c - (v_{ga} + v_{gly})_0}{(v_{ga} + v_{gly})_0}\right)
$$
   This is a feedforward from astrocytic glycolysis, whereas Step 4 is a feedback from the lactate state. The two differ during washout, when $L$ stays high after production stops.

**Result (proposal).** Step 4, or Step 6, is the smallest change that implements the Aleph claim inside existing variables. It adds three parameters ($\beta_{LP}$, $K_{LP}$, $n_L$).

**Checks.**

- *Dimensions.* $q_c$ and $\psi_c$ are dimensionless (A.6 "relative"), so $\beta_{LP}H$ is too.
- *Limits.* At rest ($L = L_0$), $H = 0$ and the A.8 behaviour is unchanged. When $L \gg L_0(1 + K_{LP})$, the contribution saturates at $\beta_{LP}$. When $L < L_0$, the positive part gives zero (no constriction from low lactate).
- *Loop sign (qualitative).* Dilation raises $f$ (T2.15), which raises both $J_O$ (T3.6) and $J_G$ (T3.5).
    - *O$_2$ path:* $o$ rises, $v_{ox}$ rises (weakly, elasticity 0.08, T3.10), $p$ falls, and lactate is drawn into $p$, so $L$ falls. This path is negative feedback.
    - *Glucose path:* $G$ rises, $v_{gn}$ and $v_{ga}$ rise, and $L$ rises. This path is positive feedback.

  The net loop gain depends on parameters, so its stability must be checked numerically.
- *Double counting.* A.8's $\beta_{astro}\mathcal{F}_{A2B}$ arteriole term (T2.9) may represent the same astrocytic signal at a different vessel level. A model that uses both should say whether they are distinct pathways.

**Lineage.**

- **A.6:** $q_c$ is local neural/glutamate activity; there is no lactate dependence.
- **A.7:** the audit (A.7-research-report.md) proposes an adenosine-A$_{2B}$-lactate cascade, with no formula.
- **A.8:** adds $\beta_{astro}\mathcal{F}_{A2B}$ to the arteriole equation, undefined. $q_c$ is "neuro-glial messengers".
- **A.10:** nothing.
- **A.10.1 (Aleph 1):** the lineage-table claim only.

**Derivation status.** Incomplete in source. No coupling term, variable or parameter is defined anywhere. A reconstructed pericyte drive (Step 4, or the flux variant in Step 6) is supplied as a proposal.
