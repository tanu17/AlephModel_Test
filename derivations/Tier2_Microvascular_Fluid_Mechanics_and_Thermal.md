# Tier 2: Microvascular fluid mechanics and thermal operators

This file rebuilds, step by step, the derivations of the 17 Tier 2 equations of Aleph 1 (Model A.10.1). The equations are listed in `00_Equation_Inventory.md` under keys T2.1 to T2.17. Aleph 1 prints six of them: Eqs. 5.6, 5.7, 5.8 (two relations), 5.9 and 4.2, which are T2.1 to T2.6 here. The other eleven are inherited from A.6 to A.10 and are restated from the most recent source that writes them out. The original derivations were lost. Each derivation below is one of three kinds:

- a standard derivation from a named physical law;
- a derivation labelled **Reconstructed**, where no source has one and the steps are built here from standard physics with the reference named;
- for a form that is a modelling choice rather than a consequence of a law, the label "phenomenological closure", with its motivation, instead of an invented derivation.

## Role of the tier and its couplings

Tier 2 converts neural activity into vessel radii, radii into a network blood flow, and that flow into the normalized delivery signal that Tier 3 uses. It also carries two newer operators. One is photothermal: laser light heats tissue, and the heat dilates vessels. The other is pathological: stalled capillaries switch off edges of the flow network. A further branch couples the locus coeruleus (LC) to vessel-wall motion and through that to perivascular (glymphatic) transport.

| Branch | Chain inside Tier 2 | Inputs from other tiers | Outputs to other tiers |
|---|---|---|---|
| Hydraulic network | T2.7 edge conductance, then T2.1 node pressures and edge flows, then T2.15 normalized node flow; T2.8 wall shear from edge flows | radii from the control branch | $f_c$ to T3.5 (GLUT1 transport $J_G$) and T3.6 (O₂ delivery $J_O$) |
| Neurovascular radius control | T2.13 extracellular K⁺, then T2.12 Kir2.1 source, then T2.11 conducted hyperpolarization, then T2.9 arteriole radius; T2.14 pericyte state and capillary radius | firing rates $\bar r$ (T1.20) into T2.13; $I_{NsMJ}$ (Tier 1, form never given); adenosine (T6.14) into $\mathcal F_{A2B}$; lactate drive into $q_c$ (claimed, T3.14) | $k_c$ to $h_K$ in T1.20 |
| LC vasomotion | T2.2 Stuart–Landau LC oscillator, then T2.10 NE-driven radius oscillation | $g_{GABA}$ and $g_{\alpha2}$ from receptor laws (T1.3 Hall–Ehlert, T1.13 Black–Leff) | $\mathrm{Re}(NE_{LC})$ to the NE gates of T6.12 and T6.16 |
| Perivascular transport | T2.10 wall motion, then T2.16 perivascular flux $J_v$, then T2.17 Péclet number | $L_p$ (T6.2), AQP4 polarity (T6.19) | $J_v$ and $Pe$ to Tier 6 glymphatic clearance (T6.16; washout terms of T6.14 and T2.13) |
| Photothermal | T2.6 optical absorption $Q$, then T2.3 Pennes temperature, then T2.4 thermal dilation | laser power and wavelength (experimental input) | radius increment to T2.7; invariant $\Theta_{optothermal}$ |
| Capillary stall | T2.8 wall shear, ICAM-1 and radius, then T2.5 stall probability and conductance switch, then T2.1 | $[ICAM\text{-}1]_e$ (inflammation input) | invariant $\Pi_{stall}$ |

**Conventions used in this file.**

- SI units are used unless a source value is quoted. Sources almost never state units. A unit marked "implied" is inferred here.
- A.6 works with relative pressures ($P_a=1$) and with conductances whose Poiseuille prefactor $\pi/(8\eta)$ has been absorbed. The mapping between that normalized form and the SI form is shown explicitly in T2.1 (Step 17) and T2.7 (Step 9).
- Symbol clashes are carried over from the inventory and flagged where they bite:
  - $n_c$ is the node neural activity in T2.1 and the critical Na⁺ level in T1.20;
  - $\tau_v$ is the vascular time constant in T2.10 and the membrane time constant in T1.1;
  - $\beta_c$ is the capillary dilation gain in T2.14 and the capture gain in T6.8;
  - $k_{th}$ is the K⁺ threshold in T2.12 and the thermal conductivity in T2.3;
  - $\Phi$ is the photon fluence rate in T2.6, the conducted hyperpolarization in T2.11 and the rate sigmoid in T1.20;
  - $\psi$ is the pericyte state here and the salience variable in T6.4.
- To avoid one more clash with the hydraulic conductivity $L_p$ (T6.2), the Pennes perfusion length is written $\ell_{perf}$.

**Radius composition (not stated in any source; proposal).** Four equations change a vessel radius:

- T2.9 and T2.10 for arterioles;
- T2.14 for capillaries;
- T2.4 for the thermal increment;
- T2.5, which switches a conductance off.

No source says how these combine into the $r_e$ that enters $G_e$. This file uses the minimal consistent rule below. It is a proposal, and it is discussed further in T2.4.

$$
G_e(t) = S_e(t)\,\frac{\pi\,\left[r_e^{dyn}(t) + \Delta r_{e,thermal}(t)\right]^4}{8\,\eta_{blood}\,\ell_e},\qquad r_e^{dyn}=\begin{cases} r_e \text{ from T2.10} & \text{arteriolar edges}\\ r_e \text{ from T2.14} & \text{capillary edges}\end{cases}
$$

## Summary of derivation status

| Key | Equation | Status | Main issue found |
|---|---|---|---|
| T2.1 | Kirchhoff node balance (Eq. 5.6) | Derived under approximations | the neural source $k'n_c/V_{cortex}$ lacks flow units and breaks global volume balance |
| T2.2 | Stuart–Landau LC oscillator (Eq. 5.7) | Derived under approximations | the cubic coefficient is normalized only if time or amplitude is rescaled; zero nonlinear frequency shift is assumed; no map from amplitude to NE concentration; α2 and GABA inhibition enter identically |
| T2.3 | Pennes bioheat (Eq. 5.8a) | Derived under approximations | basis of $\omega_b$ (mass or volume) not stated; metabolic heat and boundary conditions omitted |
| T2.4 | Thermal dilation (Eq. 5.8b) | Phenomenological closure | absolute and relative forms disagree between the Aleph table and Eq. 5.8; reference temperature; no saturation |
| T2.5 | Stall probability (Eq. 5.9) | Phenomenological closure | no intercept; $\tau_w=0$ in a stalled edge makes a stall permanent; no temporal dynamics |
| T2.6 | Optical heat $Q=\mu_a\Phi$ (Eq. 4.2) | Derived under approximations | $\Phi$ must be a fluence *rate*; the diffusion equation is not printed; the diffusion approximation fails near the source |
| T2.7 | Hagen–Poiseuille conductance | Exact | for blood in capillaries it holds only through an apparent viscosity $\eta(r)$ |
| T2.8 | Wall shear stress | Exact | prefer the rheology-free form $r\Delta p/(2\ell)$ |
| T2.9 | Dual-pathway arteriole dilation | Phenomenological closure; incomplete in source (inputs) | $I_{NsMJ}$ and $\mathcal F_{A2B}$ never specified; Lean omits $1/A_K$ |
| T2.10 | NE vasomotion | Incomplete in source | literal ellipsis; positivity needs $\kappa_{NE}\rho^*<1$ |
| T2.11 | Kir2.1 conducted kernel | Phenomenological closure | upstream/downstream asymmetry imposed; least-cost path is an approximation on a mesh |
| T2.12 | Kir2.1 K⁺ source | Phenomenological closure | $s_{off}$ never given; symbol clash $k_{th}$ |
| T2.13 | Extracellular K⁺ | Phenomenological closure | $v_{glymph}$ enters as a dimensionless rate; not restated after A.5 |
| T2.14 | Pericyte state and capillary radius | Phenomenological closure; reflected OU process incomplete in source | the reflected OU process is never written (supplied here) |
| T2.15 | Normalized node flow | Exact | half-sum formula undercounts at boundary nodes |
| T2.16 | Perivascular flux | Incomplete in source | printed form is not a flow (units) and grows without bound in time |
| T2.17 | Péclet number | Exact | $v$ and $L$ unspecified; $Pe$ alone does not establish net clearance |

## T2.1: 3D Kirchhoff microvascular node balance with linear neurovascular source (Aleph Eq. 5.6)

**Equation as stated in Aleph 1** (`Model_Aleph_1_only equations.docx`, Eq. 5.6; identical in `Model_Aleph_1_Comprehensive_Scientific_Report.docx` and in A.8 PDF Eq. (7)):

$$
\sum_{e \ni c} G_e\,(p_c - p_{c'}) = c_a\, r_a^4\,(P_a - p_c)\,\mathbf{1}_{c\in Art} - G_v\, p_c\,\mathbf{1}_{c\in Ven} + \frac{k'\, n_c}{V_{cortex}}
$$

Aleph Sec. 3.2 also states the interior form $\sum_{e\ni c} G_e(p_c - p_{c'}) = 0$.

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $c$, $c'$ | graph node; $c'$ is the other endpoint of edge $e$ | - |
| $e\ni c$ | the edges incident on node $c$ | - |
| $G_e$ | hydraulic conductance of edge $e$ (T2.7) | m³ s⁻¹ Pa⁻¹ |
| $p_c$ | nodal blood pressure, gauge (venous reservoir = 0) | Pa (A.6: relative, $P_a=1$) |
| $P_a$ | pressure of the arterial feeding reservoir | Pa |
| $c_a$ | inlet constant; $c_a r_a^4$ is the inlet conductance | m⁻¹ Pa⁻¹ s⁻¹ (derived in Step 6) |
| $r_a$ | radius of the feeding arteriole (T2.9) | m |
| $G_v$ | venous drainage conductance | m³ s⁻¹ Pa⁻¹ |
| $\mathbf{1}_{c\in Art}$, $\mathbf{1}_{c\in Ven}$ | indicators of arteriole-root and venule nodes | dimensionless |
| $n_c$ | local neural activity at node $c$ (same symbol as the critical Na⁺ level in T1.20) | not stated (a rate, s⁻¹, or dimensionless) |
| $k'$ | linear neurovascular coupling coefficient | not stated; must be m⁶ s⁻¹ per unit of $n_c$ (Step 14) |
| $V_{cortex}$ | cortical tissue volume | m³ |

**Physical starting point.** The starting point is conservation of mass for an incompressible fluid on a network, which is Kirchhoff's current law applied to volume flow. The constitutive law is Hagen–Poiseuille for each edge (T2.7). The boundary is closed with lumped conductances to pressure reservoirs. Assumptions:

- A1. Blood is incompressible, with constant density $\rho_b$, so mass conservation is volume conservation.
- A2. The flow solution is quasi-steady: nodes store no volume on the time scale of the solution. Vessel compliance $dV/dt$ is neglected relative to throughflow. Radii may change in time, but the pressures are recomputed instantaneously for each set of radii.
- A3. Each patent edge obeys a linear flow law $q_e = G_e\,\Delta p_e$ with $G_e>0$ (T2.7).
- A4. Each arteriole-root node is joined to a reservoir at $P_a$ by one upstream arteriolar segment of Poiseuille conductance $\pi r_a^4/(8\eta\ell_a)$.
- A5. Each venule node drains through $G_v$ to a venous reservoir held at gauge pressure 0.
- A6. A node may receive an external volume source $s_c$ (m³ s⁻¹). Aleph sets $s_c = k'n_c/V_{cortex}$.
- A7. The patent graph is connected, or each of its connected components contains at least one boundary (arteriole-root or venule) node. Arteriole-root and venule nodes are disjoint sets.

**Derivation**

**Step 1 (edge flow).** For edge $e$ joining $c$ and $c'$, the flow leaving $c$ along $e$ is, by A3 and T2.7,

$$
q_{e,c\to c'} = G_e\,(p_c - p_{c'}).
$$

It is antisymmetric: $q_{e,c'\to c} = -q_{e,c\to c'}$.

**Step 2 (mass balance on a control volume around node $c$).** The rate of change of mass equals the mass inflow minus the mass outflow. Let $Q^{in}_c$ and $Q^{out}_c$ be volume flows to and from external reservoirs. A1 lets every mass flux be written as $\rho_b$ times a volume flux:

$$
\frac{dm_c}{dt} = \rho_b\left(Q^{in}_c - Q^{out}_c + s_c - \sum_{e\ni c} q_{e,c\to c'}\right).
$$

**Step 3 (quasi-steady node).** By A2, $dm_c/dt = 0$. Divide by $\rho_b>0$:

$$
\sum_{e\ni c} q_{e,c\to c'} = Q^{in}_c - Q^{out}_c + s_c.
$$

**Step 4 (insert the edge law).** Substitute Step 1 into Step 3:

$$
\sum_{e\ni c} G_e\,(p_c - p_{c'}) = Q^{in}_c - Q^{out}_c + s_c.
$$

**Step 5 (interior nodes).** An interior node has no reservoir link and no source, so $Q^{in}_c = Q^{out}_c = s_c = 0$:

$$
\sum_{e\ni c} G_e\,(p_c - p_{c'}) = 0.
$$

This is the interior form in Aleph Sec. 3.2.

**Step 6 (arterial inlet).** By A4, a root node is the downstream end of a Poiseuille segment that starts at the reservoir. Applying Step 1 to that segment:

$$
Q^{in}_c = \frac{\pi r_a^4}{8\eta\ell_a}\,(P_a - p_c) \equiv c_a\, r_a^4\,(P_a - p_c),\qquad c_a \equiv \frac{\pi}{8\eta\ell_a}.
$$

So $c_a$ has units Pa⁻¹ s⁻¹ m⁻¹ and absorbs the viscosity and the length of the inlet segment. It is a constant only if $\eta$ and $\ell_a$ are constant.

**Step 7 (venous outlet).** By A5, the outflow through $G_v$ to a reservoir at 0 is

$$
Q^{out}_c = G_v\,(p_c - 0) = G_v\,p_c.
$$

**Step 8 (combine with indicators).** Indicators apply Step 6 only at root nodes and Step 7 only at venule nodes. Adding the source of A6:

$$
\sum_{e\ni c} G_e\,(p_c-p_{c'}) = c_a r_a^4\,(P_a-p_c)\,\mathbf{1}_{c\in Art} - G_v\, p_c\, \mathbf{1}_{c\in Ven} + s_c.
$$

With $s_c = k'n_c/V_{cortex}$ this is Aleph Eq. 5.6.

**Step 9 (matrix form).** Number the $N$ nodes. Define the weighted adjacency matrix: $A_{cc'} = G_e$ if edge $e$ joins $c$ and $c'$, and 0 otherwise. Define the degree matrix $D = \mathrm{diag}\left(\sum_{c'} A_{cc'}\right)$ and the graph Laplacian $L = D - A$. Then $(L\mathbf p)_c = \sum_{c'} A_{cc'}(p_c - p_{c'})$, which is the left side of Step 8. Moving the $p_c$-dependent boundary terms to the left gives

$$
(L + B)\,\mathbf p = \mathbf u,\qquad B = \mathrm{diag}(b_c),\quad b_c = c_a r_a^4\,\mathbf 1_{c\in Art} + G_v\,\mathbf 1_{c\in Ven},\quad u_c = c_a r_a^4 P_a\,\mathbf 1_{c\in Art} + s_c .
$$

**Step 10 (quadratic form).** For any $\mathbf x\in\mathbb R^N$, expand the Laplacian:

$$
\mathbf x^{T} L\,\mathbf x = \sum_{c} x_c \sum_{c'} A_{cc'}(x_c - x_{c'}) = \sum_{c,c'} A_{cc'}\, x_c\,(x_c - x_{c'}).
$$

Rename the dummy indices $c\leftrightarrow c'$ and use the symmetry $A_{cc'}=A_{c'c}$:

$$
\mathbf x^{T} L\,\mathbf x = \sum_{c,c'} A_{cc'}\, x_{c'}\,(x_{c'} - x_{c}).
$$

Add the two expressions and divide by 2:

$$
\mathbf x^{T} L\,\mathbf x = \frac12\sum_{c,c'} A_{cc'}\,(x_c - x_{c'})^2 = \sum_{e=(c,c')} G_e\,(x_c - x_{c'})^2 .
$$

The last equality holds because each edge appears twice in the ordered double sum. Adding the diagonal boundary matrix:

$$
\mathbf x^{T}(L+B)\,\mathbf x = \sum_{e} G_e\,(x_c - x_{c'})^2 + \sum_c b_c\, x_c^2 \;\ge\; 0 .
$$

$L+B$ is symmetric because $A$ and $B$ are.

**Step 11 (positive definiteness and uniqueness).** Suppose $\mathbf x^T(L+B)\mathbf x = 0$. Every term in Step 10 is non-negative: $G_e>0$ by A3 (this is the Lean theorem `poiseuille_conductance_strictly_positive`), and $b_c\ge 0$. So every term vanishes. Hence $x_c = x_{c'}$ across every edge. By connectivity (A7), $\mathbf x$ is constant, $x_c = \kappa$, on each component. Then $\sum_c b_c\kappa^2 = 0$ with at least one $b_c>0$ in that component, so $\kappa = 0$. Therefore $\mathbf x = 0$, and $L+B$ is symmetric positive definite (SPD). An SPD matrix is non-singular, so the pressures

$$
\mathbf p = (L+B)^{-1}\mathbf u
$$

exist and are unique. This is the proof that the Lean header in `Model_A8_FormalVerification.lean` announces but never implements.

**Step 12 (discrete maximum principle, $s_c\equiv 0$).** Claim: $0\le p_c\le P_a$. Let $c^\ast$ be a node of maximal pressure and suppose $p_{c^\ast} > P_a$. Every neighbour has $p_{c'}\le p_{c^\ast}$, so the left side of Step 8 is $\ge 0$. There are three cases.

- If $c^\ast$ is a root node, the right side is $c_a r_a^4(P_a - p_{c^\ast}) < 0$, a contradiction.
- If $c^\ast$ is a venule node, the right side is $-G_v p_{c^\ast} < 0$, a contradiction.
- If $c^\ast$ is interior, the right side is 0. A sum of non-negative terms is then 0 only if every neighbour has pressure $p_{c^\ast}$. Repeating along a path (A7) reaches a boundary node with the same maximal pressure, which gives one of the two contradictions above.

So $p_c\le P_a$. The same argument applied to a node of minimal pressure gives $p_c\ge 0$.

**Step 13 (global volume balance).** Sum Step 8 over all nodes. Edge $e$ contributes $G_e(p_c-p_{c'})$ at $c$ and $G_e(p_{c'}-p_c)$ at $c'$, so all edge terms cancel:

$$
0 = \sum_{c\in Art} c_a r_a^4\,(P_a - p_c) - \sum_{c\in Ven} G_v\, p_c + \sum_c s_c .
$$

That is, $Q^{out}_{total} = Q^{in}_{total} + \sum_c s_c$.

- Without the source, venous outflow equals arterial inflow. A.6's check "inflow - outflow 1.8×10⁻¹⁵" verifies exactly this.
- With the source, venous outflow exceeds arterial inflow by $(k'/V_{cortex})\sum_c n_c$. The source creates blood volume inside the tissue. Blood cannot be created there: activity can raise flow only by changing conductances (radii) or the inlet pressure.

**Step 14 (units of the source).** The left side has units $[G_e][p] = \mathrm{m^3\,s^{-1}\,Pa^{-1}}\times\mathrm{Pa} = \mathrm{m^3\,s^{-1}}$. A homogeneous equation therefore needs

$$
\left[\frac{k' n_c}{V_{cortex}}\right] = \mathrm{m^3\,s^{-1}}\;\Longrightarrow\; [k'] = \frac{\mathrm{m^6\,s^{-1}}}{[n_c]} .
$$

If $n_c$ is a rate in s⁻¹, $k'$ must have units m⁶. No source says so.

The A.7 audit (`A.7-research-report.md`) argues that $A$ is dimensionless, $k$ is in s⁻¹, and "$kA/V_{cortex}$ has correct units of flow". Direct check:

$$
\left[\frac{kA}{V_{cortex}}\right] = \frac{\mathrm{s^{-1}}\cdot 1}{\mathrm{m^3}} = \mathrm{m^{-3}\,s^{-1}} \neq \mathrm{m^3\,s^{-1}} .
$$

The inserted $1/V_{cortex}$ turns the term into a rate per unit volume. So the "dimensional fix" does not give flow units, and A.8's claim of "dimensionally homogeneous linear volumetric coupling" is not supported.

**Step 15 (a dimensionally consistent reading; Reconstructed).** Suppose $F = k'n$ is a volume flow (m³ s⁻¹) for the whole cortex. Then $k'n/V_{cortex}$ is a perfusion (s⁻¹). A perfusion becomes a nodal flow when multiplied by the tissue volume $V_c$ served by node $c$:

$$
s_c = V_c\,\frac{k' n_c}{V_{cortex}},\qquad [k' n_c] = \mathrm{m^3\,s^{-1}} .
$$

This repairs the units, but it does not repair the conservation defect of Step 13.

**Step 16 (a physically consistent alternative: activity acts through conductance; Reconstructed).** Let activity change the radii, $r_e = r_{e0}(1+\delta_e)$, with $\delta_e$ small and linear in activity (T2.9, T2.14). By T2.7, $G_e = G_{e0}(1+\delta_e)^4$. The binomial expansion to first order gives

$$
G_e = G_{e0}\,(1 + 4\delta_e) + O(\delta_e^2).
$$

Write $L+B = M_0 + \delta M$, where $\delta M$ is linear in the $\delta$'s, and $\mathbf p = \mathbf p_0 + \delta\mathbf p$, $\mathbf u = \mathbf u_0 + \delta\mathbf u$. The inlet term gives $\delta u_c = 4c_a r_{a0}^4\delta_a P_a\mathbf 1_{c\in Art}$. Substitute into $(M_0+\delta M)(\mathbf p_0 + \delta\mathbf p) = \mathbf u_0 + \delta\mathbf u$ and subtract the zeroth-order equation $M_0\mathbf p_0 = \mathbf u_0$:

$$
M_0\,\delta\mathbf p = \delta\mathbf u - \delta M\,\mathbf p_0 + O(\delta^2).
$$

$M_0$ is SPD (Step 11), so $\delta\mathbf p = M_0^{-1}(\delta\mathbf u - \delta M\,\mathbf p_0)$ is linear in $\delta$. The edge-flow change is

$$
\delta q_e = \delta G_e\,(p_{c,0}-p_{c',0}) + G_{e0}\,(\delta p_c - \delta p_{c'}),
$$

which is also linear in $\delta$, and so linear in activity. The "linear NVC" law $F = k'n$ therefore emerges with $k' = \partial F/\partial n$, an effective network sensitivity. No volume is injected, and the global balance of Step 13 holds with $s_c = 0$.

**Step 17 (normalized form, the A.6 convention).** Choose a pressure scale $P_a$ and a conductance scale $G_{ref}$. Define

$$
\pi_c = \frac{p_c}{P_a},\quad g_e = \frac{G_e}{G_{ref}},\quad g_a = \frac{c_a r_a^4}{G_{ref}},\quad g_v = \frac{G_v}{G_{ref}},\quad \sigma_c = \frac{s_c}{G_{ref}P_a}.
$$

Divide Step 8 by $G_{ref}P_a$:

$$
\sum_{e\ni c} g_e\,(\pi_c - \pi_{c'}) = g_a\,(1-\pi_c)\,\mathbf 1_{c\in Art} - g_v\,\pi_c\,\mathbf 1_{c\in Ven} + \sigma_c .
$$

A.6's $G_e = r_e^4/\ell_e$ is $g_e$ with the Poiseuille prefactor $\pi/(8\eta)$ absorbed into $G_{ref}$. This is valid only if $\eta$ is constant (see T2.7).

**Result.** Step 8 with $s_c = 0$ follows from A1–A5 and matches Aleph Eq. 5.6 term by term except for the neural source. The source $k'n_c/V_{cortex}$ as printed has two defects:

- **Units.** It is a flow only if $k'$ carries units m⁶ s⁻¹ per unit of $n_c$, which no source states. The A.7 audit's dimensional argument for it is wrong (Step 14).
- **Conservation.** It makes venous outflow exceed arterial inflow (Step 13).

Corrected form (Step 16):

$$
\sum_{e \ni c} G_e(t)\,(p_c - p_{c'}) = c_a\, r_a(t)^4\,(P_a - p_c)\,\mathbf{1}_{c\in Art} - G_v\, p_c\,\mathbf{1}_{c\in Ven},\qquad G_e(t) = \frac{\pi\, r_e(t)^4}{8\,\eta_{blood}\,\ell_e},
$$

with activity entering through $r_e(t)$ and $r_a(t)$. If an explicit source is kept for calibration, it must be $s_c = V_c\,k'n_c/V_{cortex}$ with $[k'n_c]$ = m³ s⁻¹ (Step 15). It must also be documented that it makes venous outflow exceed arterial inflow.

**Checks**

- *Dimensions.* $G_e(p_c-p_{c'})$: m³ s⁻¹. $c_a r_a^4(P_a-p_c)$: (m⁻¹ Pa⁻¹ s⁻¹)(m⁴)(Pa) = m³ s⁻¹. $G_vp_c$: m³ s⁻¹. $k'n_c/V_{cortex}$: m³ s⁻¹ only under Step 14; with the A.7 audit's units it is m⁻³ s⁻¹ (fails).
- *Series-conductance limit.* Take two nodes: node 1 a root, node 2 a venule, joined by one edge of conductance $G$. Let $Q = G(p_1-p_2)$.
  - The node-1 balance gives $Q = c_a r_a^4(P_a-p_1)$, so $P_a - p_1 = Q/(c_a r_a^4)$.
  - The edge gives $p_1 - p_2 = Q/G$.
  - The node-2 balance $G(p_2-p_1) = -G_vp_2$ gives $p_2 = Q/G_v$.
  - Adding the three relations: $P_a = Q\left(1/(c_a r_a^4) + 1/G + 1/G_v\right)$, so

  $$
  Q = \frac{P_a}{1/(c_a r_a^4) + 1/G + 1/G_v}.
  $$

  Series resistances add, and arterial inflow equals venous outflow, as Step 13 requires.
- *Dirichlet limits.* As $G_v\to\infty$, venule nodes are clamped to $p_c = 0$. As $c_a r_a^4\to\infty$, root nodes are clamped to $p_c = P_a$.
- *Bounds and uniqueness.* Steps 11 and 12 give $0\le p_c\le P_a$ and a unique solution.
- *Interaction with stalls (T2.5).* Setting $S_e=0$ removes edges. If a subgraph loses every path to a boundary node, A7 fails. $L+B$ is then singular on that component: its pressures are undetermined and its flows are zero. Such components must be deleted, or regularized, before solving.

**Lineage**

- Model A, A.2 and A.5 (`Model A.2 Repaired Specification and Validation.docx`; `Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf`, which specifies A.5): discrete supply domains with a flow ODE and no network.
- A.6 Eq. 9 (`Model A.6 four-caveat revision, verified equations and experimental validation (claude).docx`): 2D capillary graph. The equation is Step 8 without the source, with $G_e = r_e^4/\ell_e$. Property P4 states SPD uniqueness, interior divergence 1.2×10⁻¹⁴ and inflow - outflow 1.8×10⁻¹⁵.
- A.7 Eq. 9 (`Model A.7 with all equations.docx`, `model A.7 maths.docx`): 3D graph. It is printed without the indicator functions, so as printed it applies the inlet and outlet terms at every node; this is a transcription defect. Neurovascular coupling was quadratic, $F = kn^2$.
- `A.7-research-report.md` proposes $F = k'n$ and "$Q = Ak/V_{cortex}$".
- A.8 PDF Eq. (7) and `Model_A8_model only.docx`: the present form, with SPD uniqueness asserted. `Model_A8_FormalVerification.lean` announces the SPD theorem but does not implement it.
- A.10 (`Model_A10_Comprehensive_Scientific_Report.docx`): prose only.
- Aleph Eq. 5.6: identical to A.8.
- `Model_Aleph_Equation_Derivations_GPT.docx` §4.1 flags the units of the source and of $c_a$.

**Derivation status.** Derived under approximations. The approximations are A1 (incompressible blood), A2 (quasi-steady, no compliance), A3 (Poiseuille edges) and A4–A5 (lumped reservoirs). The neural source term is a phenomenological addition: its units are unresolved and it is not conservative. A dimensionally consistent version and a conductance-mediated replacement are derived in Steps 15 and 16.

---

## T2.2: Stuart–Landau locus coeruleus noradrenergic limit cycle (Aleph Eq. 5.7)

**Equation as stated in Aleph 1** (`Model_Aleph_1_only equations.docx`, Eq. 5.7; identical to A.10 Eq. 2.1):

$$
\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\,\omega_{LC})\,NE_{LC} - \lvert NE_{LC}\rvert^2\, NE_{LC} - g_{GABA}\, NE_{LC} - g_{\alpha 2}\, NE_{LC}
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $NE_{LC}$ | complex amplitude of the LC noradrenergic oscillation; $\mathrm{Re}(NE_{LC})$ drives vasomotion (T2.10) | $\mathrm{s^{-1/2}}$ if $t$ is in seconds; dimensionless if time is rescaled (Step 7) |
| $\lambda_{LC}$ | linear growth rate (distance from the Hopf point) | s⁻¹ |
| $\omega_{LC}$ | angular frequency, $2\pi f$ with $f$ in the 0.01–0.1 Hz band (0.032 Hz NREM peak) | rad s⁻¹ |
| $g_{GABA}$ | GABAergic inhibition of the LC (from $[L_{GABA}]$ via T1.3/T1.13) | s⁻¹ (implied) |
| $g_{\alpha2}$ | α2-autoreceptor inhibition (from $[L_{\alpha2}]$ via T1.13) | s⁻¹ (implied) |

**Physical starting point.** The LC network is treated as a smooth dynamical system $d\mathbf x/dt = \mathbf F(\mathbf x;\mu)$, for example firing rate, released NE and autoreceptor occupancy, close to a Hopf bifurcation of its resting state. The Stuart–Landau equation is the Hopf normal form; standard references are Guckenheimer & Holmes 1983 and Kuznetsov, *Elements of Applied Bifurcation Theory*. Assumptions:

- A1. Near a critical value $\mu_c$, the rest state $\mathbf x^\ast(\mu)$ has one complex pair of eigenvalues $\sigma(\mu)\pm i\omega(\mu)$ with $\sigma(\mu_c)=0$, $\omega(\mu_c)=\omega_0>0$ and $d\sigma/d\mu\ne 0$ (transversality). All other eigenvalues have negative real part.
- A2. The bifurcation is supercritical: the first Lyapunov coefficient is negative.
- A3. Terms beyond cubic order are neglected, so $\lvert NE_{LC}\rvert$ is small.
- A4. The amplitude-dependent frequency shift is zero. In the general form $-(1+ib)\lvert z\rvert^2 z$, Aleph sets $b=0$.
- A5. GABAergic and α2 inhibition shift only the bifurcation parameter. They change slowly relative to the oscillation, and their effect on $\omega$ is neglected.
- A6. The real part of the amplitude is an (unstated) affine readout of the NE fluctuation.

**Derivation**

**Step 1 (linearization).** Let $J(\mu) = D_{\mathbf x}\mathbf F(\mathbf x^\ast(\mu);\mu)$. By A1, $J$ has eigenvector $\mathbf q$ with $J(\mu_c)\mathbf q = i\omega_0\mathbf q$, and adjoint vector $\mathbf p$ with $\mathbf p^{H}\mathbf q = 1$.

**Step 2 (centre-manifold reduction).** By the centre-manifold theorem, all solutions near $(\mathbf x^\ast,\mu_c)$ are attracted to a two-dimensional invariant manifold tangent to $\mathrm{span}(\mathbf q,\bar{\mathbf q})$. Write $\mathbf x - \mathbf x^\ast = z\mathbf q + \bar z\bar{\mathbf q} + O(\lvert z\rvert^2)$ and project the dynamics with $\mathbf p^{H}$:

$$
\frac{dz}{dt} = \lambda(\mu)\,z + \sum_{2\le j+k\le 3}\frac{g_{jk}}{j!\,k!}\,z^j\bar z^{k} + O(\lvert z\rvert^4),\qquad \lambda(\mu) = \sigma(\mu) + i\,\omega(\mu).
$$

**Step 3 (near-identity change of variable).** To remove a term $a\,z^j\bar z^k$, set $z = w + h\,w^j\bar w^k$. Differentiate, using $dw/dt = \lambda w + O(\lvert w\rvert^2)$ and $d\bar w/dt = \bar\lambda\bar w + O(\lvert w\rvert^2)$ at leading order:

$$
\frac{dz}{dt} = \frac{dw}{dt} + h\left(j\,w^{j-1}\bar w^{k}\,\lambda w + k\,w^{j}\bar w^{k-1}\,\bar\lambda\bar w\right) + \ldots = \frac{dw}{dt} + h\,(j\lambda + k\bar\lambda)\,w^j\bar w^k + \ldots
$$

The right side of the $z$ equation, in terms of $w$, is

$$
\lambda z + a z^j\bar z^k = \lambda w + \lambda h\,w^j\bar w^k + a\,w^j\bar w^k + \ldots
$$

Equate the two expressions and solve for $dw/dt$:

$$
\frac{dw}{dt} = \lambda w + \left[a - h\,(j\lambda + k\bar\lambda - \lambda)\right] w^j\bar w^k + \ldots
$$

The term is removed by choosing $h = a/(j\lambda + k\bar\lambda - \lambda)$, which is possible only if the denominator is non-zero. At $\mu_c$, $\lambda = i\omega_0$ and $\bar\lambda = -i\omega_0$, so the denominator is $(j-k-1)\,i\omega_0$. A term can therefore be removed if and only if $j - k \ne 1$.

**Step 4 (resonant terms).** At quadratic order the pairs $(j,k) = (2,0), (1,1), (0,2)$ give $j-k = 2, 0, -2$. None equals 1, so all quadratic terms are removed. At cubic order $(3,0), (1,2), (0,3)$ are removed, and $(2,1)$, the term $\lvert w\rvert^2w$, is resonant and stays. This gives the Hopf normal form:

$$
\frac{dw}{dt} = \lambda(\mu)\,w + c_1\,\lvert w\rvert^2 w + O(\lvert w\rvert^5).
$$

**Step 5 (supercritical and shear-free).** By A2, $\mathrm{Re}\,c_1 < 0$. Write $c_1 = -c_r(1+ib)$ with $c_r>0$. A4 sets $b=0$:

$$
\frac{dw}{dt} = \lambda(\mu)\,w - c_r\,\lvert w\rvert^2 w .
$$

**Step 6 (unit cubic coefficient).** Define $Z = \sqrt{c_r}\,w$. Then $\lvert Z\rvert^2 Z = c_r^{3/2}\lvert w\rvert^2 w$, and

$$
\frac{dZ}{dt} = \sqrt{c_r}\,\frac{dw}{dt} = \lambda Z - c_r^{3/2}\,\lvert w\rvert^2 w = \lambda Z - \lvert Z\rvert^2 Z .
$$

**Step 7 (units of the normalized amplitude).** In Step 5, $[c_r] = \mathrm{s^{-1}}[w]^{-2}$, so $[Z]^2 = [c_r][w]^2 = \mathrm{s^{-1}}$. With time in seconds, $Z$ has units $\mathrm{s^{-1/2}}$. Alternatively, introduce a reference time $t_0$, set $\tilde t = t/t_0$ and $\tilde Z = \sqrt{t_0}\,Z$. Then $d\tilde Z/d\tilde t = (\lambda t_0)\tilde Z - \lvert\tilde Z\rvert^2\tilde Z$ with every quantity dimensionless. The printed equation is therefore consistent only in one of these two rescaled senses. Neither is stated.

**Step 8 (inhibition shifts the bifurcation parameter).** By A5, write $\mu = \mu_0 - \kappa_G E_{GABA} - \kappa_\alpha E_{\alpha2}$, where $E$ are the receptor-occupancy effects (T1.3, T1.13). Linearize the real part about $\mu_c$, $\sigma(\mu)\approx\sigma_\mu(\mu-\mu_c)$ with $\sigma_\mu = d\sigma/d\mu\vert_{\mu_c}>0$ by convention:

$$
\sigma = \sigma_\mu(\mu_0-\mu_c) - \sigma_\mu\kappa_G E_{GABA} - \sigma_\mu\kappa_\alpha E_{\alpha2} \equiv \lambda_{LC} - g_{GABA} - g_{\alpha2},
$$

with $\lambda_{LC} = \sigma_\mu(\mu_0-\mu_c)$, $g_{GABA} = \sigma_\mu\kappa_G E_{GABA}$ and $g_{\alpha2} = \sigma_\mu\kappa_\alpha E_{\alpha2}$. Keep $\omega(\mu)\approx\omega(\mu_c)\equiv\omega_{LC}$ (A5).

**Step 9 (assemble).** Substitute Step 8 into Step 6 and name $Z\equiv NE_{LC}$:

$$
\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\omega_{LC})\,NE_{LC} - \lvert NE_{LC}\rvert^2 NE_{LC} - g_{GABA}\,NE_{LC} - g_{\alpha2}\,NE_{LC} .
$$

This is Aleph Eq. 5.7. Define $\lambda_{eff} = \lambda_{LC} - g_{GABA} - g_{\alpha2}$.

**Step 10 (polar form).** Write $NE_{LC} = \rho e^{i\phi}$ with $\rho\ge 0$. Then $dNE_{LC}/dt = (\dot\rho + i\rho\dot\phi)e^{i\phi}$, and the right side is $(\lambda_{eff} + i\omega_{LC})\rho e^{i\phi} - \rho^3 e^{i\phi}$. Divide by $e^{i\phi}\ne 0$:

$$
\dot\rho + i\rho\dot\phi = \lambda_{eff}\,\rho - \rho^3 + i\,\omega_{LC}\,\rho .
$$

Equate the real and imaginary parts:

$$
\dot\rho = \lambda_{eff}\,\rho - \rho^3,\qquad \dot\phi = \omega_{LC}.
$$

**Step 11 (fixed points of the amplitude).** Set $\dot\rho = \rho(\lambda_{eff} - \rho^2) = 0$. The roots are $\rho = 0$ and, if $\lambda_{eff}>0$, $\rho^\ast = \sqrt{\lambda_{eff}}$. Let $f(\rho) = \lambda_{eff}\rho - \rho^3$, so $f'(\rho) = \lambda_{eff} - 3\rho^2$.

- At $\rho = 0$: $f'(0) = \lambda_{eff}$. The origin is stable if $\lambda_{eff}<0$ and unstable if $\lambda_{eff}>0$.
- At $\rho^\ast$: $f'(\rho^\ast) = \lambda_{eff} - 3\lambda_{eff} = -2\lambda_{eff} < 0$, so it is stable.

The attracting limit cycle is

$$
NE_{LC}(t) = \sqrt{\lambda_{eff}}\;e^{i(\omega_{LC}t + \phi_0)},\qquad \mathrm{Re}\,NE_{LC}(t) = \sqrt{\lambda_{eff}}\cos(\omega_{LC}t + \phi_0).
$$

**Step 12 (exact amplitude transient).** Substitute $u = \rho^{-2}$, so $\dot u = -2\rho^{-3}\dot\rho = -2\rho^{-3}(\lambda_{eff}\rho - \rho^3) = -2\lambda_{eff}u + 2$. This is linear in $u$, with solution

$$
u(t) = \frac{1}{\lambda_{eff}} + \left(u_0 - \frac{1}{\lambda_{eff}}\right)e^{-2\lambda_{eff}t},\qquad \rho(t) = \left[\frac{1}{\lambda_{eff}} + \left(\rho_0^{-2} - \frac{1}{\lambda_{eff}}\right)e^{-2\lambda_{eff}t}\right]^{-1/2}.
$$

The amplitude relaxes to the cycle with time constant $1/(2\lambda_{eff})$. At $\lambda_{eff} = 0$ the equation is $\dot u = 2$, so $\rho(t) = (\rho_0^{-2} + 2t)^{-1/2}\sim(2t)^{-1/2}$: critical slowing down.

**Step 13 (pharmacological reading).** A GABA_A positive allosteric modulator such as zolpidem raises $g_{GABA}$. When $g_{GABA} + g_{\alpha2} > \lambda_{LC}$, $\lambda_{eff}<0$ and the oscillation collapses to the focus $\rho = 0$. This is the "glymphatic–sedation paradox" mechanism named in Aleph Sec. 3. Because the bifurcation is supercritical, the collapse is continuous, $\rho^\ast = \sqrt{\lambda_{eff}}\to 0$, with no hysteresis. The model therefore predicts a dose–amplitude law $\rho^\ast(\text{dose}) = \sqrt{\lambda_{LC} - g_{GABA}(\text{dose}) - g_{\alpha2}}$.

**Result.** Aleph Eq. 5.7 is the supercritical Hopf normal form after amplitude normalization (Step 6), zero shear (A4) and linear inhibitory shifts of the growth rate (Step 8). It matches the printed form exactly under these assumptions. Points the source leaves open:

1. The unit cubic coefficient requires $NE_{LC}$ in $\mathrm{s^{-1/2}}$ or a rescaled time (Step 7).
2. The general normal form has $-(1+ib)\lvert z\rvert^2z$; $b=0$ is an assumption.
3. Mapping to a concentration. No map from the complex amplitude to an NE concentration is given. A consistent proposal is $[NE](t) = \overline{NE} + a_{NE}\,\mathrm{Re}\,NE_{LC}(t)$, which requires $a_{NE}\rho^\ast\le\overline{NE}$ for non-negative concentration.
4. Inhibition. GABA and α2 inhibition enter identically. In the model, dexmedetomidine (an α2 agonist) also lowers $\lambda_{eff}$ and would collapse the oscillation at a high enough dose. The reported "preserved" infraslow oscillation under dexmedetomidine (A.9; Aleph test #44) is consistent only if $g_{\alpha2}(\text{dex}) < \lambda_{LC} - g_{GABA}$ at the doses used. The equation's structure does not by itself distinguish the two drugs.

**Checks**

- *Dimensions.* $\lambda_{LC}$, $g_{GABA}$, $g_{\alpha2}$ and $\omega_{LC}$ are in s⁻¹, so $\lambda NE$ has units s⁻¹[NE]. The cubic term has units $[NE]^3$, which equals s⁻¹[NE] only if $[NE]^2$ = s⁻¹ (Step 7).
- *Frequency.* $\omega_{LC} = 2\pi f$. The NREM peak $f = 0.032$ Hz gives $\omega_{LC} = 2\pi\times 0.032 = 0.201$ rad s⁻¹ (period 31.25 s). The band 0.01–0.1 Hz corresponds to 0.0628–0.628 rad s⁻¹. Entering $\omega_{LC} = 0.032$ directly would give a 0.0051 Hz oscillation.
- *Limits.* With $g_{GABA} = g_{\alpha2} = 0$, the free LC has amplitude $\sqrt{\lambda_{LC}}$. As $\lambda_{eff}\to 0^+$, the amplitude goes to 0 and the relaxation time $1/(2\lambda_{eff})$ diverges. For $\lambda_{eff}<0$, the decay is $\rho\propto e^{\lambda_{eff}t}$.
- *Phase.* $\dot\phi = \omega_{LC}$ does not depend on inhibition (A5), so the spectral peak is the same under every drug. This is consistent with the matched 0.032–0.035 Hz peaks, but it holds by construction rather than as a derived result.

**Lineage**

- A.8 has a Boolean or heuristic sleep gate and no LC oscillator.
- A.9 (`Model_A9_changes from a8.docx`, equation image) writes $dNE_{LC}/dt = f_{oscillator}(NE_{LC}) - g_{GABA}([L_{GABA}])NE_{LC} - g_{\alpha2}([L_{\alpha2}])NE_{LC}$. It names Stuart–Landau but does not write it out, and says zolpidem "induced a Hopf bifurcation".
- A.10 Eq. 2.1 (`Model_A10_Comprehensive_Scientific_Report.docx`) gives the explicit normal form.
- Aleph Eq. 5.7 is identical. Aleph Sec. 3 lists "Stuart–Landau limit-cycle normal form" and "supercritical Hopf bifurcation".
- `Model_Aleph_Equation_Derivations_GPT.docx` §4.2 sketches the centre-manifold argument and notes that $NE_{LC}$ must be complex.

**Derivation status.** Derived under approximations: (i) proximity to a supercritical Hopf point; (ii) cubic truncation; (iii) zero nonlinear frequency shift; (iv) inhibition linear in the bifurcation parameter and quasi-static; (v) amplitude normalization. That the LC sits near a Hopf point is itself a modelling hypothesis. It is motivated by the infraslow NE oscillations cited in the sources (Hauglund et al. 2025).

---

## T2.3: Pennes bioheat equation with optical source (Aleph Eq. 5.8, first relation)

**Equation as stated in Aleph 1** (`Model_Aleph_1_only equations.docx`, Eq. 5.8; the same form is listed in Aleph Sec. 3.2):

$$
\rho\, C_p\,\frac{\partial T}{\partial t} = k_{th}\,\nabla^2 T - \omega_b\, C_b\,(T - T_b) + Q_{laser}(x,\lambda)
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $T(x,t)$ | tissue temperature | K |
| $\rho$ | tissue density | kg m⁻³ |
| $C_p$ | tissue specific heat | J kg⁻¹ K⁻¹ |
| $k_{th}$ | tissue thermal conductivity (clashes with the K⁺ threshold $k_{th}$ of T2.12) | W m⁻¹ K⁻¹ |
| $\omega_b$ | blood perfusion; basis not stated | kg m⁻³ s⁻¹ if it includes blood density (mass basis); s⁻¹ if volumetric |
| $C_b$ | blood specific heat | J kg⁻¹ K⁻¹ |
| $T_b$ | arterial (body) temperature. Aleph Table 3 gives 37.0 (human), 36.9 (mouse), 37.7 (rat), 38.0 (macaque), 41.2 (pigeon), 28.5 (zebrafish) and 25.0 °C (fly) | K |
| $Q_{laser}$ | absorbed optical power density; the same quantity as $Q$ of T2.6 (implied) | W m⁻³ |
| $\lambda$ | optical wavelength | m |

**Physical starting point.** The first law of thermodynamics for a stationary continuum, Fourier's law of conduction, and the Pennes (1948) perfusion model. Assumptions:

- A1. Tissue is a stationary, incompressible continuum. $\rho$, $C_p$ and $k_{th}$ are locally constant and isotropic, and $c_p\approx c_v$.
- A2. Conduction obeys Fourier's law, $\mathbf q = -k_{th}\nabla T$.
- A3. Pennes assumption. Blood reaches the exchange (capillary) level at arterial temperature $T_b$, equilibrates completely with local tissue, and leaves at local tissue temperature $T$. Perfusion acts as a non-directional, distributed exchange. Directional convection and countercurrent exchange in larger vessels are neglected.
- A4. The volumetric heat sources are optical absorption $Q_{laser}$ and metabolic heat $q_m$. Aleph omits $q_m$; it is kept here and then discussed.
- A5. Temperature rises are small, so the properties and the perfusion do not depend on $T$. This excludes the feedback through T2.4, which is discussed under Checks.

**Derivation**

**Step 1 (energy balance on a fixed control volume $V$).** The internal energy is $E = \int_V\rho C_pT\,dV$. Its rate of change equals the conductive inflow through $\partial V$ plus the volumetric sources:

$$
\frac{d}{dt}\int_V \rho C_p T\,dV = -\oint_{\partial V}\mathbf q\cdot\mathbf n\,dA + \int_V\left(q_{perf} + q_m + Q_{laser}\right)dV .
$$

**Step 2 (divergence theorem).** Write the surface integral as a volume integral, $\oint_{\partial V}\mathbf q\cdot\mathbf n\,dA = \int_V\nabla\cdot\mathbf q\,dV$. Since $V$ is fixed and $\rho C_p$ is constant (A1), the time derivative moves inside the integral:

$$
\int_V\left(\rho C_p\frac{\partial T}{\partial t} + \nabla\cdot\mathbf q - q_{perf} - q_m - Q_{laser}\right)dV = 0 .
$$

**Step 3 (localization).** The volume $V$ is arbitrary and the integrand is continuous, so the integrand vanishes pointwise:

$$
\rho C_p\frac{\partial T}{\partial t} = -\nabla\cdot\mathbf q + q_{perf} + q_m + Q_{laser}.
$$

**Step 4 (Fourier's law).** Insert A2. With constant $k_{th}$, $-\nabla\cdot(-k_{th}\nabla T) = k_{th}\nabla^2T$:

$$
\rho C_p\frac{\partial T}{\partial t} = k_{th}\nabla^2T + q_{perf} + q_m + Q_{laser}.
$$

**Step 5 (Pennes perfusion term).** Let $w_b$ be the volumetric perfusion: the volume of blood per unit tissue volume per unit time, in s⁻¹. The blood mass flow per unit tissue volume is $\rho_bw_b$. By A3, blood carries enthalpy in at $T_b$ and out at $T$. The net heat delivered to tissue per unit volume is

$$
q_{perf} = \rho_b w_b C_b\,T_b - \rho_b w_b C_b\,T = -\rho_b w_b C_b\,(T - T_b).
$$

**Step 6 (map to the Aleph coefficient).** The Aleph form follows with

$$
\omega_b \equiv \rho_b\,w_b \quad[\mathrm{kg\,m^{-3}\,s^{-1}}],\qquad q_{perf} = -\omega_b C_b\,(T-T_b).
$$

If $\omega_b$ is meant as the volumetric perfusion $w_b$ (s⁻¹), as the word "rate" suggests, the printed term lacks the blood density $\rho_b$, about 10³ kg m⁻³. In SI units the sink is then too small by about three orders of magnitude.

**Step 7 (assemble).**

$$
\rho C_p\frac{\partial T}{\partial t} = k_{th}\nabla^2T - \omega_b C_b\,(T-T_b) + q_m + Q_{laser}.
$$

With $q_m = 0$ this is Aleph Eq. 5.8.

**Step 8 (what omitting $q_m$ means).** Without a laser, a steady and spatially uniform state has $\partial_tT = 0$ and $\nabla^2T = 0$, so $0 = -\omega_bC_b(T_0 - T_b) + q_m$, which gives

$$
T_0 = T_b + \frac{q_m}{\omega_b C_b}.
$$

Dropping $q_m$ is therefore equivalent to taking the resting tissue temperature $T_0$ equal to $T_b$. If $q_m$ is restored, the reference temperature in T2.4 must be $T_0$, not $T_b$. Otherwise $\max(0,T-T_b)>0$ at rest and produces a standing thermal dilation.

**Step 9 (equation for the temperature rise).** Define $\theta = T - T_0$. Subtract the steady baseline relation of Step 8 from Step 7:

$$
\rho C_p\frac{\partial\theta}{\partial t} = k_{th}\nabla^2\theta - \omega_bC_b\,\theta + Q_{laser}.
$$

Divide by $\rho C_p$ and define the thermal diffusivity $\alpha_{th} = k_{th}/(\rho C_p)$, the perfusion rate constant $\beta_{perf} = \omega_bC_b/(\rho C_p)$ (s⁻¹) and the perfusion length $\ell_{perf} = \sqrt{k_{th}/(\omega_bC_b)}$:

$$
\frac{\partial\theta}{\partial t} = \alpha_{th}\nabla^2\theta - \beta_{perf}\,\theta + \frac{Q_{laser}}{\rho C_p}.
$$

**Step 10 (transient Green's function).** Substitute $\theta = e^{-\beta_{perf}t}\varphi$. Then $\partial_t\theta = e^{-\beta_{perf}t}(\partial_t\varphi - \beta_{perf}\varphi)$, and the perfusion term cancels:

$$
\frac{\partial\varphi}{\partial t} = \alpha_{th}\nabla^2\varphi + e^{\beta_{perf}t}\frac{Q_{laser}}{\rho C_p}.
$$

This is the heat equation. Its free-space kernel is $(4\pi\alpha_{th}t)^{-3/2}e^{-\lvert x\rvert^2/(4\alpha_{th}t)}$. Undoing the substitution, the response to an instantaneous unit energy release at the origin is

$$
\theta_\delta(x,t) = \frac{1}{\rho C_p}\,\frac{1}{(4\pi\alpha_{th}t)^{3/2}}\,\exp\!\left(-\frac{\lvert x\rvert^2}{4\alpha_{th}t}\right)e^{-\beta_{perf}t}.
$$

**Step 11 (steady point-source Green's function).** In steady state, $k_{th}\nabla^2G - \omega_bC_bG = -\delta(x)$. For $r = \lvert x\rvert > 0$ in spherical symmetry:

$$
\frac{1}{r^2}\frac{d}{dr}\left(r^2\frac{dG}{dr}\right) - \frac{G}{\ell_{perf}^2} = 0 .
$$

Set $G = U/r$. Then $\frac{1}{r^2}\frac{d}{dr}(r^2G') = U''/r$, so $U'' - U/\ell_{perf}^2 = 0$, and the solution that decays is $U = A_Ge^{-r/\ell_{perf}}$. Fix $A_G$ by requiring a unit outward heat flow through a vanishing sphere:

$$
-k_{th}\,4\pi r^2\frac{dG}{dr} = 4\pi k_{th}A_G\left(1 + \frac{r}{\ell_{perf}}\right)e^{-r/\ell_{perf}} \xrightarrow{\;r\to0\;} 4\pi k_{th}A_G = 1 .
$$

Hence

$$
G(r) = \frac{e^{-r/\ell_{perf}}}{4\pi k_{th}\,r},\qquad \theta(x) = \int G(\lvert x - x'\rvert)\,Q_{laser}(x')\,dx' .
$$

**Step 12 (one-dimensional exponential source, linking to T2.6).** Take a wide beam whose absorbed power decays with depth, $Q_{laser} = Q_0e^{-\mu z}$ for $z>0$, with $\mu = \mu_{eff}$ of T2.6. The steady problem is $k_{th}\theta'' - \omega_bC_b\theta = -Q_0e^{-\mu z}$.

- Particular solution. Try $\theta_p = A_1e^{-\mu z}$: $k_{th}\mu^2A_1 - \omega_bC_bA_1 = -Q_0$, so $A_1 = Q_0/[\omega_bC_b(1-\mu^2\ell_{perf}^2)]$.
- Homogeneous solution. The solution that decays is $A_2e^{-z/\ell_{perf}}$.
- Boundary condition. Take an adiabatic surface, $\theta'(0) = 0$: $-\mu A_1 - A_2/\ell_{perf} = 0$, so $A_2 = -\mu\ell_{perf}A_1$.

Therefore

$$
\theta(z) = \frac{Q_0}{\omega_bC_b\,(1-\mu^2\ell_{perf}^2)}\left(e^{-\mu z} - \mu\ell_{perf}\,e^{-z/\ell_{perf}}\right),\qquad \theta(0) = \frac{Q_0}{\omega_bC_b\,(1+\mu\ell_{perf})}.
$$

The surface value follows from $(1-\mu\ell_{perf})/(1-\mu^2\ell_{perf}^2) = 1/(1+\mu\ell_{perf})$. It stays finite at $\mu\ell_{perf} = 1$.

**Result.** Aleph Eq. 5.8 (first relation) follows exactly from Steps 1–7 under A1–A5, with $q_m = 0$ and $\omega_b$ read as a mass perfusion $\rho_bw_b$. It matches the printed form under that reading. Points the source leaves open:

1. Basis of $\omega_b$. If $\omega_b$ is volumetric, the corrected sink is $-\rho_bw_bC_b(T-T_b)$.
2. Metabolic heat. $q_m$ is omitted. The equivalent consistent statement is to use the resting temperature $T_0$ as the reference (Step 8).
3. Boundary conditions. None are given. A cranial-window surface needs a Robin condition $-k_{th}\partial_nT = h(T - T_{amb})$, and deep tissue needs $T\to T_0$.
4. Perfusion. $\omega_b$ is a constant, although Tier 2 computes the local flow. A consistent closure (proposal) is $\omega_{b,c} = \rho_b\,F_c/V_c$ with $F_c$ from T2.15.

**Checks**

- *Dimensions.* $\rho C_p\partial_tT$: (kg m⁻³)(J kg⁻¹ K⁻¹)(K s⁻¹) = W m⁻³. $k_{th}\nabla^2T$: (W m⁻¹ K⁻¹)(K m⁻²) = W m⁻³. $\omega_bC_b(T-T_b)$: (kg m⁻³ s⁻¹)(J kg⁻¹ K⁻¹)(K) = W m⁻³ on a mass basis; with $\omega_b$ in s⁻¹ it is J kg⁻¹ s⁻¹, which fails. $Q_{laser}$: W m⁻³.
- *Uniform source.* $\int G\,dV = \int_0^\infty 4\pi r^2\frac{e^{-r/\ell_{perf}}}{4\pi k_{th}r}dr = \frac{\ell_{perf}^2}{k_{th}} = \frac{1}{\omega_bC_b}$. A uniform $Q_0$ therefore gives $\theta = Q_0/(\omega_bC_b)$, the local balance of production and perfusion loss. The 1D solution of Step 12 has the same limit as $\mu\to 0$.
- *No perfusion.* As $\omega_b\to 0$, $\ell_{perf}\to\infty$ and $G\to 1/(4\pi k_{th}r)$, the pure-conduction kernel.
- *Strong perfusion.* As $\ell_{perf}\to 0$, Step 12 gives $\theta\to Q_0e^{-\mu z}/(\omega_bC_b)$, the local balance.
- *Link to the invariant $\Theta_{optothermal}$ (Aleph Sec. 9.1).* Its denominator $\omega_bC_b + k_{th}/r_{beam}^2$ has units W m⁻³ K⁻¹. It is the steady loss coefficient of the operator $k_{th}\nabla^2 - \omega_bC_b$ with $\nabla^2\sim -1/r_{beam}^2$, correct up to an O(1) geometric factor. Its numerator $\mu_aP_{laser}\delta_{pulse}$ is in W m⁻³ only if $P_{laser}$ is an irradiance and $\delta_{pulse}$ is a dimensionless duty cycle. If $\delta_{pulse}$ is a duration, the ratio has units of time.
- *Feedback ignored.* T2.4 dilates vessels, which raises perfusion, which raises $\omega_b$. This negative feedback lowers $\theta$. It is not represented because $\omega_b$ is constant.

**Lineage**

- The equation is new in Aleph (A.10.1 final fix). Test #52 failed under A.10 ("Missing Photothermal Term"); test #68 under A.10.1 is marked fixed (`Model_Aleph_1_Comprehensive_Scientific_Report.docx`).
- No earlier version has a thermal equation.
- `Model_Aleph_Equation_Derivations_GPT.docx` §4.3 gives the first-law, Fourier and Pennes sketch and flags the units of $\omega_b$.

**Derivation status.** Derived under approximations: the Pennes perfusion model (A3), constant properties (A1, A5) and no directional convection. The energy balance itself is exact.

---

## T2.4: Thermal (photothermal) vessel dilation (Aleph Eq. 5.8, second relation)

**Equation as stated in Aleph 1** (Eq. 5.8):

$$
\Delta r_{e,thermal} = r_{e0}\,\kappa_T\,\max(0,\, T - T_b)
$$

The Aleph lineage table (Sec. 2) prints $\Delta r_{thermal} = \kappa_T\cdot(T-T_b)_+$, without $r_{e0}$.

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $\Delta r_{e,thermal}$ | radius increment of edge $e$ | m |
| $r_{e0}$ | baseline radius of edge $e$ | m |
| $\kappa_T$ | thermal dilation coefficient (fractional dilation per kelvin); value not given | K⁻¹ (Eq. 5.8); m K⁻¹ in the lineage-table form |
| $T$ | local tissue temperature (T2.3) | K |
| $T_b$ | reference (body or arterial) temperature | K |

**Physical starting point.** There is no conservation law behind this relation. It is a constitutive (linear-response) law for vascular tone as a function of temperature. Assumptions:

- A1. At fixed other inputs, the radius is a smooth function of temperature, $r_e = r_{e0}\,R(T)$, with $R(T_{ref}) = 1$.
- A2. Only warming above the reference produces dilation. Below it the thermal effect is set to zero, which is a modelling choice.
- A3. The temperature rise is small enough for a first-order expansion.

**Derivation (linear-response closure; not a consequence of Pennes)**

**Step 1 (Taylor expansion).** Expand $R$ about $T_{ref}$ (A1, A3):

$$
R(T) = 1 + R'(T_{ref})\,(T - T_{ref}) + O\!\left((T-T_{ref})^2\right).
$$

**Step 2 (define the coefficient).**

$$
\kappa_T \equiv R'(T_{ref}) = \frac{1}{r_{e0}}\frac{\partial r_e}{\partial T}\bigg\rvert_{T_{ref}}\qquad [\mathrm{K^{-1}}].
$$

**Step 3 (increment).** Subtract the baseline and keep first order:

$$
\Delta r_e = r_e - r_{e0} = r_{e0}\,\kappa_T\,(T - T_{ref}).
$$

**Step 4 (rectify).** By A2, replace $(T-T_{ref})$ by $\max(0, T-T_{ref})$:

$$
\Delta r_{e,thermal} = r_{e0}\,\kappa_T\,\max(0,\,T - T_{ref}).
$$

With $T_{ref} = T_b$ this is Aleph Eq. 5.8.

**Step 5 (absolute versus relative form).** The lineage-table form $\kappa_T^{abs}(T-T_b)_+$ equals Step 4 only if $\kappa_T^{abs} = r_{e0}\kappa_T$. A single $\kappa_T^{abs}$ would then give the same absolute dilation to a 2 µm capillary and a 16.5 µm human arteriole. The relative form of Eq. 5.8 is the one consistent with a fractional vascular response, and it is used here. The lineage table should be corrected to include $r_{e0}$.

**Step 6 (effect on conductance).** With $r_e = r_{e0}(1 + \kappa_T\theta_+)$ and $\theta_+ = \max(0, T - T_{ref})$, T2.7 gives

$$
\frac{G_e}{G_{e0}} = (1+\kappa_T\theta_+)^4 = 1 + 4\kappa_T\theta_+ + 6\kappa_T^2\theta_+^2 + \ldots
$$

So to first order, the fractional conductance change is four times the fractional radius change.

**Step 7 (how $\Delta r$ enters the radius; proposal).** Eq. 5.8 is algebraic and instantaneous, and no source says how it combines with the dynamic radii of T2.9, T2.10 and T2.14. Two consistent choices are possible:

- Additive and instantaneous: $r_e = r_e^{dyn} + \Delta r_{e,thermal}$. This is the rule in the overview.
- Dynamic: add $\kappa_T\theta_+$ inside the target bracket of T2.9 or T2.10, so that the thermal dilation develops with the same smooth-muscle time constant:

$$
\tau_a\frac{dr_a}{dt} = r_{a0}\left[1 + \ldots + \kappa_T\,\max(0,T - T_{ref})\right] - r_a .
$$

The dynamic form is preferred, because vessels cannot dilate instantaneously.

**Result.** The form is a first-order, rectified linear-response closure. It matches Eq. 5.8 with $T_{ref} = T_b$. Corrections:

1. The Aleph lineage table omits $r_{e0}$ (Step 5).
2. If metabolic heat is kept in T2.3, use $T_{ref} = T_0$, the resting tissue temperature (T2.3 Step 8).
3. The law has no saturation and no delay. A bounded version (proposal) is $\Delta r = r_{e0}\Delta_{max}\tanh(\kappa_T\theta_+/\Delta_{max})$.

**Checks**

- *Dimensions.* $\kappa_T\theta_+$ is dimensionless, so $\Delta r$ has the units of $r_{e0}$.
- *Limits.* $T\le T_{ref}$ gives $\Delta r = 0$. The response is continuous at $T = T_{ref}$, with a kink in the derivative.
- *Calibration target.* Aleph test #68 reports a "+1.10%" photothermal dilation, which implies $\kappa_T\theta_+\approx 0.011$ under the laser protocol. With $\kappa_T$ and $\theta$ both unreported, this cannot be checked further.
- *Species reference.* For ectotherms (zebrafish 28.5 °C, fly 25.0 °C, Aleph Table 3), $T_b$ is ambient temperature, so the reference is environmental.

**Lineage.** New in Aleph Eq. 5.8 (`Model_Aleph_1_only equations.docx`, `Model_Aleph_1_Comprehensive_Scientific_Report.docx`). The lineage-table version lacks $r_{e0}$. `Model_Aleph_Equation_Derivations_GPT.docx` §4.3 calls it a separate phenomenological relation that is not derived from Pennes.

**Derivation status.** Phenomenological closure. It is a linear-response, rectified constitutive choice. It is motivated by the photothermal vasodilation artefact in opto-fMRI (tests #52 and #68). The only evidence offered is the single fitted dilation of +1.10%.

---

## T2.5: Discrete stochastic capillary stall probability and conductance switch (Aleph Eq. 5.9)

**Equation as stated in Aleph 1** (Eq. 5.9):

$$
P(stall_e) = \left[1 + \exp\left(-\left(\beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}\left(\frac{r_{crit}}{r_e}\right)^2 - \beta_{shear}\frac{\tau_{w,e}}{\tau_{crit}}\right)\right)\right]^{-1}, \qquad G_e = S_e\cdot G_{Poiseuille}
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $P(stall_e)$ | probability that edge $e$ is stalled | dimensionless |
| $[ICAM\text{-}1]_e$ | endothelial adhesion-molecule level on edge $e$ | concentration or relative level (not stated) |
| $\beta_{adh}$ | adhesion coefficient | inverse of the units of $[ICAM\text{-}1]$ |
| $r_{crit}$ | critical radius (of the order of a leukocyte radius) | m |
| $r_e$ | lumen radius | m |
| $\beta_{geom}$, $\beta_{shear}$ | geometric and shear coefficients | dimensionless |
| $\tau_{w,e}$ | wall shear stress (T2.8) | Pa |
| $\tau_{crit}$ | critical (dislodging) shear stress | Pa |
| $S_e$ | patency switch: 1 patent, 0 stalled (never defined in the source) | dimensionless |
| $G_{Poiseuille}$ | conductance from T2.7 | m³ s⁻¹ Pa⁻¹ |

**Physical starting point.** Two readings are possible. (A) Statistical: a logistic link for a Bernoulli outcome with a linear predictor. (B) Kinetic (Reconstructed): a two-state Markov chain for each edge, flowing ⇄ stalled, with Bell-type (Bell 1978) adhesive-bond kinetics. Assumptions for (B):

- B1. Each edge is in one of two states. Stalls form at rate $k_+$ and are dislodged at rate $k_-$.
- B2. Dislodgement is the force-assisted rupture of an adhesive cluster. Following Bell, $k_- = k_0\exp[-(N_b\varepsilon_b - F x_\beta)/E_{noise}]$, where $N_b$ is the number of bonds, $\varepsilon_b$ the energy per bond, $F$ the applied force, $x_\beta$ the bond reactive length and $E_{noise}$ an effective noise energy. At molecular scale $E_{noise} = k_BT$; for a whole cell it is a fitted scale.
- B3. In the linear range, the bond number is proportional to ligand density: $N_b = a_b[ICAM\text{-}1]$.
- B4. The force is the shear load on the exposed cell area: $F = A_{exp}\tau_w$.
- B5. The formation rate rises with confinement as $\ln k_+ = \ln k_{+,0} + \beta_{geom}(r_{crit}/r_e)^2$. The square is the occlusion area ratio $\pi r_{crit}^2/\pi r_e^2$. Its linear entry into $\ln k_+$ is a modelling choice.

**Derivation**

**Step 1 (option A: logistic link).** For a Bernoulli outcome $Y_e\in\lbrace 0,1\rbrace$ (1 = stalled), the logistic model sets the log-odds (written $\mathcal{L}$ here, to avoid a clash with the viscosity $\eta$) equal to a linear predictor $\mathcal{L}_e$:

$$
\ln\frac{P}{1-P} = \mathcal{L}_e .
$$

**Step 2 (invert the log-odds).** Exponentiate: $P/(1-P) = e^{\mathcal{L}_e}$. Then $P = e^{\mathcal{L}_e}(1-P)$, so $P(1 + e^{\mathcal{L}_e}) = e^{\mathcal{L}_e}$, and

$$
P = \frac{e^{\mathcal{L}_e}}{1+e^{\mathcal{L}_e}} = \frac{1}{1+e^{-\mathcal{L}_e}} .
$$

With $\mathcal{L}_e = \beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}(r_{crit}/r_e)^2 - \beta_{shear}\tau_{w,e}/\tau_{crit}$, this is the printed law.

**Step 3 (option B: master equation).** Under B1, the probability $P$ of being stalled obeys

$$
\frac{dP}{dt} = k_+(1-P) - k_-P .
$$

**Step 4 (stationary probability).** Set $dP/dt = 0$: $k_+ = (k_+ + k_-)P$, so

$$
P^\ast = \frac{k_+}{k_+ + k_-} = \frac{1}{1 + k_-/k_+} = \frac{1}{1 + e^{-\mathcal{L}}},\qquad \mathcal{L} \equiv \ln\frac{k_+}{k_-} .
$$

The logistic form is exactly the stationary occupancy of a two-state chain whose log rate ratio is $\mathcal{L}$.

**Step 5 (log of the dislodgement rate).** Take the logarithm of B2 and insert B3 and B4:

$$
\ln k_- = \ln k_0 - \frac{a_b\varepsilon_b}{E_{noise}}[ICAM\text{-}1] + \frac{A_{exp}x_\beta}{E_{noise}}\,\tau_w .
$$

**Step 6 (log rate ratio).** Subtract Step 5 from B5:

$$
\mathcal{L} = \ln\frac{k_{+,0}}{k_0} + \frac{a_b\varepsilon_b}{E_{noise}}[ICAM\text{-}1] + \beta_{geom}\left(\frac{r_{crit}}{r_e}\right)^2 - \frac{A_{exp}x_\beta\tau_{crit}}{E_{noise}}\,\frac{\tau_w}{\tau_{crit}} .
$$

**Step 7 (identify the coefficients).**

$$
\beta_0 = \ln\frac{k_{+,0}}{k_0},\qquad \beta_{adh} = \frac{a_b\varepsilon_b}{E_{noise}},\qquad \beta_{shear} = \frac{A_{exp}x_\beta\tau_{crit}}{E_{noise}} .
$$

The printed law is recovered if and only if $\beta_0 = 0$. The units are: $\beta_{adh}$ in 1/[ICAM-1]; $\beta_{shear}$ dimensionless (force × length / energy).

**Step 8 (conductance switch).** The state is a Bernoulli variable, $S_e\sim\mathrm{Bernoulli}(1-P_e)$, which is 1 when patent. The conductance is $G_e = S_eG_{Poiseuille}$. Its mean is

$$
\mathbb E[G_e] = (1-P_e)\,G_{Poiseuille}.
$$

Network flows are nonlinear functions of the conductances (T2.1), so $\mathbb E[q_e]\ne q_e(\mathbb E[G])$. Flows must be computed from sampled $S_e$, not from mean conductances.

**Step 9 (dynamic version; Reconstructed).** Step 3 also fixes the correlation time of the switch. The chain relaxes at rate $k_+ + k_-$, so a stall persists on average for $1/k_-$. Sampling $S_e$ independently at every time step, which is all the stationary law of Eq. 5.9 allows, would make stalls flicker with no persistence. A consistent update is: in a step $\Delta t$, a patent edge stalls with probability $1 - e^{-k_+\Delta t}$ and a stalled edge reopens with probability $1 - e^{-k_-\Delta t}$, with $k_+/k_- = e^{\mathcal{L}}$ and $k_+ + k_- = 1/\tau_{stall}$. The correlation time $\tau_{stall}$ is a new parameter that no source gives.

**Step 10 (self-consistency of $\tau_w$ in a stalled edge).** If $\tau_{w,e}$ is computed from the edge's own flow with T2.8, $\tau_w = 4\eta Q_e/(\pi r_e^3)$, then a stalled edge has $G_e = 0$, so $Q_e = 0$ and $\tau_{w,e} = 0$. The predictor then takes its maximum and $P(stall)$ rises: a stall becomes self-sustaining and nearly absorbing. The repair uses the rheology-free form of T2.8 with the current pressure drop:

$$
\tau_{w,e} = \frac{r_e\,\lvert p_c - p_{c'}\rvert}{2\ell_e} = \frac{\pi r_e^2\lvert p_c - p_{c'}\rvert}{2\pi r_e\ell_e}.
$$

This is the pressure force on a plug spread over the lateral contact area, which is exactly the load that dislodges a stalled cell. It is non-zero in a stalled edge, and it rises when the edge stalls, because the pressure drop across it increases.

**Result.** The printed law is the stationary occupancy of a two-state switch with a log rate ratio linear in adhesion, confinement and shear (Steps 3–7). Equivalently, it is a logistic regression (Steps 1–2). It matches Eq. 5.9 only with a zero intercept. Corrected form:

$$
P(stall_e) = \left[1 + \exp\left(-\left(\beta_0 + \beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}\left(\frac{r_{crit}}{r_e}\right)^2 - \beta_{shear}\frac{r_e\lvert p_c - p_{c'}\rvert}{2\ell_e\,\tau_{crit}}\right)\right)\right]^{-1},
$$

with $S_e$ evolving as the two-state chain of Step 9 and $G_e = S_eG_{Poiseuille}$. Without $\beta_0$, an edge with no adhesion, a wide lumen and no shear has $P = 1/2$. Physically it should have $P\approx 0$, which requires $\beta_0\ll 0$.

**Checks**

- *Range.* $P\in(0,1)$ for any finite predictor.
- *Monotonicity.* With $P' = P(1-P)$:
  - $\partial P/\partial[ICAM\text{-}1] = \beta_{adh}P(1-P) > 0$;
  - $\partial P/\partial r_e = -2\beta_{geom}r_{crit}^2r_e^{-3}P(1-P) < 0$;
  - $\partial P/\partial\tau_w = -(\beta_{shear}/\tau_{crit})P(1-P) < 0$.

  The signs agree with the physical expectation: adhesion promotes stalls, while a wider lumen and stronger shear oppose them.
- *Limits.* $[ICAM\text{-}1]\to 0$, $r_e\gg r_{crit}$ and $\tau_w\gg\tau_{crit}$ give $P\to 0$. $r_e\to 0$ gives $P\to 1$.
- *Dimensions.* The argument of the exponential must be dimensionless, so $\beta_{adh}$ carries 1/[ICAM-1], or $[ICAM\text{-}1]$ must be normalized.
- *Percolation invariant.* For independent edges, $\mathbb E[\Pi_{stall}] = \sum_e\ell_eP_e/\sum_e\ell_e$. But $P_e$ depends on $\tau_w$, which depends on network flows that redistribute after each stall. Stalls are therefore correlated, and the threshold $p_c^\ast\approx 0.075$ claimed in Aleph Sec. 9.1 cannot be derived from Eq. 5.9 alone. It also depends on graph topology. Aleph test #69 reports a 6.5% stall fraction, below that threshold.
- *Graph connectivity.* Stalls can disconnect subgraphs. See T2.1, Checks.

**Lineage.** New in Aleph Eq. 5.9 (A.10.1 final fix for the failed 12-month stall test #58; #69 marked fixed). `Model_Aleph_Equation_Derivations_GPT.docx` §4.5 calls it a statistical choice and notes the units and the unspecified reopening and correlation.

**Derivation status.** Phenomenological closure. The logistic link and the linear predictor are modelling choices. The kinetic reading (Steps 3–7) shows what physical assumptions would make each coefficient meaningful, but the confinement term and the noise scale remain choices. The evidence is a single fitted stall fraction (test #69).

---

## T2.6: Optical heat deposition from radiative transport and Beer–Lambert absorption (Aleph Eq. 4.2)

**Equation as stated in Aleph 1** (`Model_Aleph_1_only equations.docx`, Sec. 4.2, Eq. 4.2):

$$
Q(x,\lambda) = \mu_a(\lambda)\cdot\Phi(x), \qquad \mu_a(\lambda) = \ln(10)\cdot\left[[HbO_2]\,\varepsilon_{HbO_2}(\lambda) + [HbR]\,\varepsilon_{HbR}(\lambda)\right] + \mu_{a,water}(\lambda) + \mu_{a,lipid}(\lambda)
$$

The text adds that "photon fluence $\Phi(x)$ is solved via the diffusion approximation of radiative transport with reduced scattering coefficient $\mu_s'(\lambda)$". It gives $\varepsilon_{HbO_2}(473\ \mathrm{nm}) = 3.2\times10^4$ cm⁻¹/(mol/L).

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $Q$ | absorbed optical power density; equal to $Q_{laser}$ in T2.3 (implied) | W m⁻³ |
| $\mu_a$ | absorption coefficient (natural-log base) | m⁻¹ |
| $\Phi$ | fluence **rate**, the radiance integrated over $4\pi$ (the source says "fluence"; symbol clash with T2.11) | W m⁻² |
| $[HbO_2]$, $[HbR]$ | tissue-averaged molar concentrations of oxy- and deoxyhaemoglobin | mol L⁻¹ |
| $\varepsilon_{HbO_2}$, $\varepsilon_{HbR}$ | molar decadic extinction coefficients | L mol⁻¹ cm⁻¹ |
| $\mu_{a,water}$, $\mu_{a,lipid}$ | background absorption (natural base) | m⁻¹ |
| $\mu_s'$ | reduced scattering coefficient $\mu_s(1-g)$. Aleph Table 3 at 473 nm: fly 0.2, zebrafish 0.4, mouse 1.2, rat 1.5, pigeon 1.8, macaque 2.5, human 2.9 mm⁻¹ | m⁻¹ |
| $g$ | scattering anisotropy (mean cosine) | dimensionless |
| $L(x,\hat s)$ | radiance | W m⁻² sr⁻¹ |
| $D$ | optical diffusion coefficient | m |

**Physical starting point.** The radiative transfer equation (RTE), the Beer–Lambert law and the P1 (diffusion) approximation of the RTE. Standard references are Ishimaru, *Wave Propagation and Scattering in Random Media*, and Welch & van Gemert, *Optical-Thermal Response of Laser-Irradiated Tissue*. Assumptions:

- A1. Light transport is described by the RTE: incoherent, with no polarization or interference effects.
- A2. All absorbed optical energy is converted locally to heat. There is no fluorescence re-emission, no photochemical storage, and the heat yield is 1.
- A3. Absorbers act independently and are homogeneously mixed at the scale of a mean free path (Beer–Lambert additivity).
- A4. For the fluence equation, scattering dominates ($\mu_s'\gg\mu_a$), the radiance is nearly isotropic, and the field point is several transport mean free paths from sources and boundaries.
- A5. Steady state applies: the photon transit time is negligible relative to every thermal time.

**Derivation**

**Step 1 (radiative transfer equation).** In a medium with absorption $\mu_a$, scattering $\mu_s$ and phase function $p(\hat s\cdot\hat s')$ normalized to $\int_{4\pi}p\,d\Omega' = 1$:

$$
\frac{1}{c}\frac{\partial L}{\partial t} + \hat s\cdot\nabla L = -(\mu_a+\mu_s)\,L + \mu_s\int_{4\pi}p(\hat s\cdot\hat s')\,L(x,\hat s')\,d\Omega' + S(x,\hat s).
$$

**Step 2 (define the moments).** The fluence rate is $\Phi = \int_{4\pi}L\,d\Omega$, the net flux is $\mathbf J = \int_{4\pi}L\,\hat s\,d\Omega$, and the isotropic source is $S_0 = \int_{4\pi}S\,d\Omega$.

**Step 3 (integrate the RTE over all directions).** Integrate Step 1 over $\hat s$:

- $\int\hat s\cdot\nabla L\,d\Omega = \nabla\cdot\mathbf J$;
- $\int\mu_s\int p\,L'\,d\Omega'd\Omega = \mu_s\int L'\left(\int p\,d\Omega\right)d\Omega' = \mu_s\Phi$, by the normalization of $p$.

The scattering gain cancels the scattering loss $-\mu_s\Phi$:

$$
\frac{1}{c}\frac{\partial\Phi}{\partial t} + \nabla\cdot\mathbf J = -\mu_a\Phi + S_0 .
$$

**Step 4 (absorbed power).** Rearrange: $S_0 - \nabla\cdot\mathbf J - c^{-1}\partial_t\Phi = \mu_a\Phi$. The left side is the radiant power per unit volume that is injected or flows in and is not stored in the light field. It is lost from the radiation field only by absorption. By A2 it all becomes heat:

$$
Q = \mu_a\,\Phi .
$$

This is the first relation of Eq. 4.2. It requires $\Phi$ to be a fluence **rate** (W m⁻²), so that $Q$ is in W m⁻³. If $\Phi$ is a photon fluence rate (photons m⁻² s⁻¹), then $Q = h\nu\,\mu_a\Phi$. If it is a time-integrated fluence (J m⁻²), $\mu_a\Phi$ is an absorbed energy density (J m⁻³), not a power.

**Step 5 (Beer–Lambert for one absorber).** Along a ray in a non-scattering solution, the decadic law is $I = I_0\,10^{-\varepsilon c\ell}$, with absorbance $A = \varepsilon c\ell$. Use $10^{y} = e^{y\ln 10}$:

$$
I = I_0\exp(-\ln(10)\,\varepsilon c\,\ell)\quad\Longrightarrow\quad \mu_a = \ln(10)\,\varepsilon\,c ,
$$

since the natural attenuation law is $dI/d\ell = -\mu_aI$.

**Step 6 (additivity).** By A3, absorption events by different species are independent, so their rates per unit path add. The ray then obeys $dI/d\ell = -\sum_j\mu_{a,j}I$:

$$
\mu_a = \ln(10)\left([HbO_2]\varepsilon_{HbO_2} + [HbR]\varepsilon_{HbR}\right) + \mu_{a,water} + \mu_{a,lipid}.
$$

This is the second relation of Eq. 4.2. The water and lipid terms must already be natural-base coefficients. If they are taken from decadic tables, they also need the factor $\ln 10$.

**Step 7 (P1 expansion of the radiance).** By A4, keep the first two spherical harmonics:

$$
L(x,\hat s) \approx \frac{\Phi(x)}{4\pi} + \frac{3}{4\pi}\,\mathbf J(x)\cdot\hat s .
$$

Consistency check, using $\int\hat s_i\,d\Omega = 0$ and $\int\hat s_i\hat s_j\,d\Omega = \frac{4\pi}{3}\delta_{ij}$: $\int L\,d\Omega = \Phi$ and $\int L\,\hat s\,d\Omega = \frac{3}{4\pi}\cdot\frac{4\pi}{3}\mathbf J = \mathbf J$.

**Step 8 (first moment of the RTE).** Multiply Step 1 by $\hat s$ and integrate.

- With P1 and $\int\hat s_i\hat s_j\hat s_k\,d\Omega = 0$: $\int\hat s\,(\hat s\cdot\nabla L)\,d\Omega = \nabla\cdot\int\hat s\hat s\,L\,d\Omega = \nabla\left(\Phi/3\right)$.
- The anisotropy is defined by $\int\hat s\,p(\hat s\cdot\hat s')\,d\Omega = g\,\hat s'$, so the scattering-gain term gives $\mu_s g\mathbf J$.

Hence

$$
\frac{1}{c}\frac{\partial\mathbf J}{\partial t} + \frac{1}{3}\nabla\Phi = -(\mu_a + \mu_s)\mathbf J + \mu_s g\,\mathbf J + \mathbf S_1 = -(\mu_a + \mu_s')\,\mathbf J + \mathbf S_1 ,
$$

with $\mu_s' = \mu_s(1-g)$ and $\mathbf S_1 = \int S\,\hat s\,d\Omega$.

**Step 9 (Fick's law for light).** Drop $c^{-1}\partial_t\mathbf J$ (A5) and the anisotropic source $\mathbf S_1$ (A4, far from sources):

$$
\mathbf J = -D\,\nabla\Phi,\qquad D = \frac{1}{3(\mu_a + \mu_s')} .
$$

**Step 10 (diffusion equation).** Insert Step 9 into the steady form of Step 3:

$$
-\nabla\cdot(D\nabla\Phi) + \mu_a\Phi = S_0 .
$$

For homogeneous $D$, divide by $D$:

$$
\nabla^2\Phi - \mu_{eff}^2\,\Phi = -\frac{S_0}{D},\qquad \mu_{eff} = \sqrt{\frac{\mu_a}{D}} = \sqrt{3\mu_a(\mu_a+\mu_s')} .
$$

This is the equation that Aleph says is "solved" but never prints.

**Step 11 (point source).** Approximate the fibre as an isotropic point source of power $P_0$, $S_0 = P_0\,\delta(x)$. By the same steps as T2.3 Step 11, with $k_{th}\to D$ and $\ell_{perf}\to 1/\mu_{eff}$:

$$
\Phi(r) = \frac{P_0\,e^{-\mu_{eff}r}}{4\pi D\,r},\qquad Q(r) = \mu_a\frac{P_0\,e^{-\mu_{eff}r}}{4\pi D\,r} .
$$

For a collimated beam on a surface, the standard device is an isotropic source one transport mean free path, $1/(\mu_a+\mu_s')$, below the surface, plus an image source for the boundary.

**Result.** $Q = \mu_a\Phi$ is exact, given the RTE and complete local thermalization (A2). The expression for $\mu_a$ is exact Beer–Lambert additivity for independent, homogeneously mixed absorbers. Both match Eq. 4.2. The source leaves three things incomplete:

1. $\Phi$ must be a fluence rate, and the source's word "fluence" is wrong for a power density.
2. $\Phi$ depends on $\lambda$ through $\mu_a$ and $\mu_s'$, so it should be written $\Phi(x,\lambda)$.
3. The fluence equation is not printed. It is supplied here (Step 10) under the diffusion approximation.

**Checks**

- *Units of $\mu_a$.* $\varepsilon c$: (L mol⁻¹ cm⁻¹)(mol L⁻¹) = cm⁻¹. Example: $\ln(10)\times3.2\times10^4 = 7.37\times10^4$ cm⁻¹ M⁻¹, which is 7.37 mm⁻¹ per mM of tissue-averaged HbO₂. The haemoglobin concentration must be on the same basis as $\varepsilon$, either per heme or per tetramer, which differ by a factor of 4, and must be tissue-averaged: blood volume fraction times blood concentration.
- *Units of $Q$.* (m⁻¹)(W m⁻²) = W m⁻³.
- *Energy conservation for the point source.*

  $$
  \int Q\,dV = \frac{\mu_aP_0}{4\pi D}\int_0^\infty4\pi r^2\frac{e^{-\mu_{eff}r}}{r}dr = \frac{\mu_aP_0}{D\,\mu_{eff}^2} = P_0 ,
  $$

  using $\mu_{eff}^2 = \mu_a/D$. All injected power is absorbed, as it must be in an infinite medium.
- *Validity of the diffusion approximation.*
  - It needs $\mu_a\ll\mu_s'$. With $\mu_a\approx\ln(10)\varepsilon_{HbO_2}[HbO_2]$, the mouse value $\mu_s' = 1.2$ mm⁻¹ requires $[HbO_2]_{tissue}\ll 1.2/7.37 = 0.16$ mM.
  - It needs distances greater than a few transport mean free paths: $1/\mu_s' = 0.83$ mm in mouse, which is comparable to the thickness of mouse cortex. For the fly, $1/\mu_s' = 5$ mm, larger than the whole head. The diffusion approximation therefore fails near the fibre tip and over much of the small-animal geometry, where Monte Carlo or full RTE solutions are needed.
- *Beer–Lambert caveat.* Blood is packaged in vessels, not homogeneously mixed. This "vessel packaging" lowers the effective $\mu_a$ relative to the homogeneous formula at strongly absorbed (blue) wavelengths, so A3 is an approximation.

**Lineage**

- The A.7 audit (`A.7-research-report.md`) proposed a Beer–Lambert activated volume, $V_{act}(z) = V_0e^{-\mu_az}e^{-\mu_s'z}$. It multiplies two exponentials, which is not the diffusion result $e^{-\mu_{eff}z}$.
- Aleph Sec. 4.2 (`Model_Aleph_1_only equations.docx`, `Model_Aleph_1_Comprehensive_Scientific_Report.docx`) introduces $Q$ as a derived quantity that replaces an arbitrary laser scalar.
- `Model_Aleph_Equation_Derivations_GPT.docx` §4.4 notes the fluence-rate requirement and the limits of the diffusion approximation.

**Derivation status.** Derived under approximations. $Q = \mu_a\Phi$ is exact given full thermalization. $\mu_a$ follows from Beer–Lambert additivity (homogeneous mixing). $\Phi$ requires the diffusion (P1) approximation, which the source names but does not write; it is supplied here.

---

## T2.7: Hagen–Poiseuille edge conductance (inherited: Aleph Sec. 3.2 / A.8 Tier 2)

**Equation as stated in the latest source** (Aleph Sec. 3.2, "Navier–Stokes Lubrication Approximation", `Model_Aleph_1_only equations.docx`; A.8 writes $\eta_{blood}(r_e)$):

$$
G_e = \frac{\pi\, r_e^4}{8\,\eta_{blood}\,\ell_e}
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $G_e$ | hydraulic conductance of edge $e$, $Q_e = G_e\Delta p_e$ | m³ s⁻¹ Pa⁻¹ |
| $r_e$ | lumen radius | m |
| $\ell_e$ | segment length (A.6: median 45 µm) | m |
| $\eta_{blood}$ | blood viscosity; apparent viscosity $\eta_{blood}(r_e)$ in A.8 (Fåhræus–Lindqvist) | Pa s |
| $u(r)$ | axial velocity profile | m s⁻¹ |
| $\Delta p$ | pressure drop over the segment, $p(0)-p(\ell)$ | Pa |

**Physical starting point.** The incompressible Navier–Stokes equations for steady flow in a straight, rigid, circular tube (Hagen 1839; Poiseuille 1840). Assumptions:

- A1. The fluid is Newtonian and incompressible, with viscosity $\eta$.
- A2. The flow is steady, laminar, axisymmetric and fully developed: $\mathbf u = u(r)\,\hat z$, with no entrance effects.
- A3. The wall is rigid and straight, and the no-slip condition $u(R) = 0$ holds.
- A4. The velocity is finite on the axis.
- A5. For a slowly varying radius $r(z)$, the lubrication approximation applies: $\lvert dr/dz\rvert\ll 1$ and the reduced Reynolds number $Re\,(R/\ell)\ll 1$.

**Derivation**

**Step 1 (Navier–Stokes).**

$$
\rho_b\left(\frac{\partial\mathbf u}{\partial t} + \mathbf u\cdot\nabla\mathbf u\right) = -\nabla p + \eta\nabla^2\mathbf u,\qquad \nabla\cdot\mathbf u = 0 .
$$

**Step 2 (simplify with A2).** Steady flow gives $\partial_t\mathbf u = 0$. For $\mathbf u = u(r)\hat z$, $\mathbf u\cdot\nabla\mathbf u = u\,\partial_zu\,\hat z = 0$, because $u$ does not depend on $z$. Continuity, $\partial_zu = 0$, is satisfied. The radial component gives $\partial p/\partial r = 0$, so $p = p(z)$. The axial component is

$$
0 = -\frac{dp}{dz} + \eta\,\frac{1}{r}\frac{d}{dr}\left(r\frac{du}{dr}\right).
$$

**Step 3 (separate the variables).** The first term depends only on $z$ and the second only on $r$, so both are equal to the same constant. With $\Delta p = p(0)-p(\ell)$, that constant is $dp/dz = -\Delta p/\ell$:

$$
\frac{1}{r}\frac{d}{dr}\left(r\frac{du}{dr}\right) = -\frac{\Delta p}{\eta\,\ell}.
$$

**Step 4 (first integration).** Multiply by $r$ and integrate:

$$
r\frac{du}{dr} = -\frac{\Delta p}{2\eta\ell}r^2 + C_1 \quad\Longrightarrow\quad \frac{du}{dr} = -\frac{\Delta p}{2\eta\ell}r + \frac{C_1}{r}.
$$

A4 forces $C_1 = 0$.

**Step 5 (second integration and no-slip).** Integrate: $u = -\frac{\Delta p}{4\eta\ell}r^2 + C_2$. The condition $u(R) = 0$ gives $C_2 = \frac{\Delta p\,R^2}{4\eta\ell}$:

$$
u(r) = \frac{\Delta p}{4\eta\ell}\left(R^2 - r^2\right).
$$

**Step 6 (volume flow).** Integrate over the cross-section:

$$
Q = \int_0^R 2\pi r\,u(r)\,dr = \frac{2\pi\Delta p}{4\eta\ell}\int_0^R\left(R^2r - r^3\right)dr = \frac{\pi\Delta p}{2\eta\ell}\left(\frac{R^4}{2} - \frac{R^4}{4}\right) = \frac{\pi R^4}{8\eta\ell}\,\Delta p .
$$

**Step 7 (conductance).** By definition, $G = Q/\Delta p$. With $R = r_e$ and $\ell = \ell_e$:

$$
G_e = \frac{\pi r_e^4}{8\,\eta\,\ell_e}.
$$

**Step 8 (lubrication extension, A5).** If $r$ varies slowly along $z$, each slice obeys Step 6 locally: $Q = -\frac{\pi r(z)^4}{8\eta}\frac{dp}{dz}$. $Q$ is the same in every slice (continuity), so integrating $dp/dz$ from 0 to $\ell$ gives

$$
\Delta p = Q\int_0^\ell\frac{8\eta}{\pi r(z)^4}dz \quad\Longrightarrow\quad G = \left[\int_0^\ell\frac{8\eta\,dz}{\pi r(z)^4}\right]^{-1}.
$$

The resistances of the slices add in series. This is the sense in which Aleph calls the law a "lubrication approximation".

**Step 9 (map to the A.6/A.7 form).** A.6 and A.7 write $G_e = r_e^4/\ell_e$. With constant $\eta$, this is $G_e/G_{ref}$ for $G_{ref} = \pi/(8\eta)$ times a unit of length cubed, as in T2.1 Step 17. If $\eta$ depends on $r_e$, the prefactor is not constant and can no longer be absorbed.

**Step 10 (blood as an effective fluid).** Blood is a suspension of deformable red cells, so A1 fails in microvessels. The practice since Fåhræus & Lindqvist (1931) is to define an apparent viscosity by requiring Step 7 to hold:

$$
\eta_{app}(r_e, H_D) \equiv \frac{\pi r_e^4\,\Delta p}{8\,\ell_e\,Q}.
$$

With this definition $G_e = \pi r_e^4/(8\eta_{app}\ell_e)$ holds identically. The physics moves into the empirical function $\eta_{app}$ of radius and discharge haematocrit $H_D$ (Pries, Neuhaus & Gaehtgens 1992; in vivo, Pries et al. 1994). Two facts keep $Q\propto\Delta p$ approximately valid even in capillaries, where red cells pass in single file and the profile is not parabolic: Stokes flow is linear in the forcing, and the cell distribution is fixed at given haematocrit.

**Result.** For a Newtonian fluid in a rigid tube, $G_e = \pi r_e^4/(8\eta\ell_e)$ is exact. It matches Aleph Sec. 3.2 and A.8. For blood, it holds through the apparent viscosity $\eta_{blood}(r_e)$, which the sources name but never specify (Step 10). A.6 and A.7's $r_e^4/\ell_e$ is the same law with constant $\eta$ absorbed (Step 9).

**Checks**

- *Dimensions.* $\pi r^4/(8\eta\ell)$: m⁴/(Pa s · m) = m³ s⁻¹ Pa⁻¹.
- *Profile.* $u_{max} = u(0) = \Delta pR^2/(4\eta\ell)$, and the mean velocity is $\bar u = Q/(\pi R^2) = \Delta pR^2/(8\eta\ell) = u_{max}/2$.
- *Sensitivity.* $dG/G = 4\,dr/r$. A 7% capillary dilation (T2.14) raises the conductance by $1.07^4 - 1 = 31\%$.
- *Positivity.* For $r_e,\ell_e,\eta>0$, $G_e>0$. This is the Lean theorem `poiseuille_conductance_strictly_positive` in `Model_A8_All_Equations.lean` and `Model_A8_All_Equations_patched.lean`.
- *Validity.*
  - Microvascular Reynolds numbers are far below 1, so A2 holds.
  - The Womersley number $R\sqrt{\omega\rho_b/\eta}$ is far below 1 for micrometre radii at infraslow and cardiac frequencies, so the flow is quasi-steady under vasomotion.
  - The weakest assumption is A3: vessels are compliant and their radii are the controlled variables. Within T2.1 A2 this is treated quasi-statically.

**Lineage**

- A.6 Eq. 8 (`Model A.6 four-caveat revision...docx`) and A.7 Eq. 8 (`Model A.7 with all equations.docx`, `model A.7 maths.docx`): $G_e = r_e^4/\ell_e$.
- A.8 (`Model_A8_model only.docx`, A.8 PDF): $G_e(t) = \pi r_e(t)^4/(8\eta_{blood}(r_e)\ell_e)$. The Lean files define `poiseuille_conductance` and prove positivity.
- Aleph Sec. 3.2 (both Aleph files): the same law, attributed to the "Navier–Stokes lubrication approximation". Aleph Eq. 5.9 multiplies it by $S_e$.
- `Model_Aleph_Equation_Derivations_GPT.docx` §8.4 states the assumptions.

**Derivation status.** Exact for steady laminar Newtonian flow in a rigid circular tube (A1–A4). Applied to blood in capillaries, it is an approximation carried by the apparent viscosity $\eta_{blood}(r_e)$.

---

## T2.8: Poiseuille wall shear stress (inherited: Aleph Sec. 3.2, used in Eq. 5.9)

**Equation as stated in the latest source** (Aleph Sec. 3.2, "Poiseuille Wall Shear Stress Law"):

$$
\tau_w = \frac{4\,\eta\, Q}{\pi\, r_e^3}
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $\tau_w$ | wall shear stress | Pa |
| $\eta$ | viscosity | Pa s |
| $Q$ | volume flow in the edge | m³ s⁻¹ |
| $r_e$ | lumen radius | m |
| $\Delta p$, $\ell$ | pressure drop and length of the segment | Pa, m |

**Physical starting point.** Newton's law of viscosity at the wall, applied to the Poiseuille profile of T2.7, and checked against a force balance on the fluid core. The assumptions are those of T2.7 (A1–A4).

**Derivation**

**Step 1 (Newtonian wall stress).** $\tau_w = \eta\left\lvert\frac{du}{dr}\right\rvert_{r=R}$.

**Step 2 (velocity gradient).** Differentiate the profile of T2.7 Step 5:

$$
\frac{du}{dr} = -\frac{\Delta p}{2\eta\ell}\,r\quad\Longrightarrow\quad\left\lvert\frac{du}{dr}\right\rvert_{R} = \frac{\Delta p\,R}{2\eta\ell}.
$$

**Step 3 (stress in terms of the pressure drop).** Combine Steps 1 and 2:

$$
\tau_w = \eta\,\frac{\Delta p\,R}{2\eta\ell} = \frac{R\,\Delta p}{2\ell}.
$$

**Step 4 (force-balance check).** For the fluid cylinder of radius $R$ and length $\ell$, the net pressure force $\pi R^2\Delta p$ balances the wall friction $2\pi R\ell\,\tau_w$. So $\tau_w = R\Delta p/(2\ell)$, as in Step 3. This step uses no constitutive law: the result holds for any fluid in fully developed flow, including blood.

**Step 5 (eliminate $\Delta p$).** From T2.7 Step 6, $\Delta p = 8\eta\ell Q/(\pi R^4)$. Substitute into Step 3:

$$
\tau_w = \frac{R}{2\ell}\cdot\frac{8\eta\ell Q}{\pi R^4} = \frac{4\eta Q}{\pi R^3}.
$$

With $R = r_e$, this is the Aleph form.

**Result.** $\tau_w = 4\eta Q/(\pi r_e^3)$ is exact for Poiseuille flow and matches Aleph Sec. 3.2. For blood, the rheology-free form $\tau_w = r_e\Delta p/(2\ell_e)$ (Step 4) is preferable. The flow form with the apparent viscosity of T2.7 Step 10 gives the same number only if the same $\eta_{app}$ is used in both $G_e$ and $\tau_w$. The pressure form also stays defined in a stalled edge, where $Q = 0$ (see T2.5 Step 10).

**Checks**

- *Dimensions.* $\eta Q/r^3$: (Pa s)(m³ s⁻¹)/m³ = Pa. Likewise $R\Delta p/\ell$: m·Pa/m = Pa.
- *Mean-velocity form.* $Q = \pi R^2\bar u$ gives $\tau_w = 4\eta\bar u/R = 8\eta\bar u/d$, the textbook form.
- *Scaling.* At fixed $Q$, $\tau_w\propto r^{-3}$, so constriction raises the shear. At fixed $\Delta p/\ell$, $\tau_w\propto r$.

**Lineage.** New in Aleph Sec. 3.2 (both Aleph files). It feeds $\tau_{w,e}$ of Eq. 5.9 (T2.5). No earlier model uses wall shear. `Model_Aleph_Equation_Derivations_GPT.docx` §8.4 states the assumptions.

**Derivation status.** Exact (given Poiseuille flow, T2.7 A1–A4). The force-balance form is exact for any fully developed flow.

---

## T2.9: Dual-pathway arteriole dilation (NsMJ + Kir2.1 + astrocytic A2B + capillary signal) (inherited: A.8 PDF Eq. (8))

**Equation as stated in the latest source** (A.8 PDF Eq. (8); `Model_A8_model only.docx`):

$$
\tau_a\frac{dr_a}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\frac{I_{NsMJ}(t)}{I_0} + \beta_a\frac{\Phi_{root}(a)}{A_K} + \beta_{astro}\,\mathcal{F}_{A2B}(Ado, cAMP) + \beta_d\sum_c \omega_{ac}\psi_c\right] - r_a
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $r_a$ | radius of arteriole $a$ ($a$ is an arteriole index here, not ATP) | m |
| $r_{a0}$ | baseline radius. Aleph Table 3: zebrafish 1.8, pigeon 4.2, mouse 4.8, rat 6.0, macaque 11.2, human 16.5 µm | m |
| $\tau_a$ | relaxation time constant (2 s, A.6) | s |
| $I_{NsMJ}$, $I_0$ | neuron-to-smooth-muscle junction current and its normalization (form never given) | A (ratio dimensionless) |
| $\Phi_{root}(a)$ | conducted Kir2.1 hyperpolarization at the root of arteriole $a$ (T2.11) | mV |
| $A_K$ | Kir2.1 source gain (T2.12), used as a normalization | mV (implied; Checks) |
| $\mathcal F_{A2B}$ | astrocytic adenosine–A2B–cAMP signal (form never given) | dimensionless (implied) |
| $\omega_{ac}$ | weight of capillary node $c$ for arteriole $a$, $\propto e^{-\lvert x_a-x_c\rvert/\ell_d}$ with $\sum_c\omega_{ac} = 1$ and $\ell_d = 100$ µm (A.6) | dimensionless |
| $\psi_c$ | capillary or pericyte vasoactive state (T2.14) | dimensionless |
| $\beta_{NsMJ}$, $\beta_a$, $\beta_{astro}$, $\beta_d$ | pathway gains (A.6: $\beta_a = 2.74$, $\beta_d = 2.94$) | dimensionless |

**Physical starting point.** There is no first-principles law behind the bracket; it is a linear superposition of normalized dilator signals. The relaxation structure can be reconstructed from the wall mechanics of a thin-walled vessel: Laplace's law for hoop stress, plus a Kelvin–Voigt viscoelastic wall with an active smooth-muscle tension, linearized about rest. This is a standard vascular-mechanics construction (see Fung, *Biomechanics: Circulation*). Assumptions:

- A1. The wall is thin ($h\ll r$), with constant thickness $h$ and unstressed radius $r_u$.
- A2. The transmural pressure $P_{tm}$ is constant. This neglects the myogenic and pressure feedback from T2.1.
- A3. The wall is linear Kelvin–Voigt in hoop strain, with elastic modulus $E_w$ and wall viscosity $\eta_w$.
- A4. The active smooth-muscle tension $\sigma_{act}$ depends on normalized signals $x_j$ (zero at rest). Small signals allow linearization, and the pathways act additively and independently.
- A5. All pathways share one mechanical time constant; any pathway-specific kinetics belongs to the input signals themselves.

**Derivation (Reconstructed)**

**Step 1 (Laplace's law).** The hoop stress in a thin cylindrical wall is

$$
\sigma_\theta = \frac{P_{tm}\,r}{h}.
$$

**Step 2 (wall constitutive law).** With hoop strain $\varepsilon = (r-r_u)/r_u$ (A3, A4):

$$
\sigma_{wall} = E_w\frac{r-r_u}{r_u} + \frac{\eta_w}{r_u}\frac{dr}{dt} + \sigma_{act}(x).
$$

**Step 3 (mechanical equilibrium).** Inertia is negligible at the microscale, so $\sigma_\theta = \sigma_{wall}$:

$$
\frac{P_{tm}\,r}{h} = E_w\frac{r-r_u}{r_u} + \frac{\eta_w}{r_u}\frac{dr}{dt} + \sigma_{act}.
$$

**Step 4 (solve for $dr/dt$ and collect the terms in $r$).**

$$
\frac{\eta_w}{r_u}\frac{dr}{dt} = -\left(\frac{E_w}{r_u} - \frac{P_{tm}}{h}\right)r + E_w - \sigma_{act}.
$$

**Step 5 (define the stiffness and the time constant).** Let $k_w = E_w/r_u - P_{tm}/h$. Stability requires $k_w>0$: the wall must be stiffer than the distending effect of pressure, otherwise the vessel would distend without bound (Laplace instability). Divide by $k_w$:

$$
\tau_a\frac{dr}{dt} = r_{eq}(\sigma_{act}) - r,\qquad \tau_a = \frac{\eta_w}{r_u\,k_w},\quad r_{eq} = \frac{E_w - \sigma_{act}}{k_w}.
$$

**Step 6 (linearize the active tension).** By A4, dilator pathways reduce tone:

$$
\sigma_{act} = \sigma_0 - \sum_j a_j\,x_j .
$$

**Step 7 (target radius).** Substitute Step 6 into $r_{eq}$:

$$
r_{eq} = \frac{E_w - \sigma_0}{k_w} + \sum_j\frac{a_j}{k_w}x_j \equiv r_{a0} + \sum_j\frac{a_j}{k_w}x_j .
$$

**Step 8 (factor out the baseline).** Define $\beta_j = a_j/(k_w r_{a0})$:

$$
r_{eq} = r_{a0}\left[1 + \sum_j\beta_jx_j\right].
$$

**Step 9 (identify the pathways).** Take $x_1 = I_{NsMJ}/I_0$, $x_2 = \Phi_{root}(a)/A_K$, $x_3 = \mathcal F_{A2B}$ and $x_4 = \sum_c\omega_{ac}\psi_c$. Insert Step 8 into Step 5:

$$
\tau_a\frac{dr_a}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\frac{I_{NsMJ}}{I_0} + \beta_a\frac{\Phi_{root}(a)}{A_K} + \beta_{astro}\mathcal F_{A2B} + \beta_d\sum_c\omega_{ac}\psi_c\right] - r_a .
$$

This is A.8 Eq. (8).

**Step 10 (basal equilibrium and stability).** With all $x_j = 0$, the right side vanishes at $r_a = r_{a0}$. This is the Lean theorem `arteriolar_basal_equilibrium`. Write $\dot r_a = f(r_a)$. Then $\partial f/\partial r_a = -1/\tau_a<0$, so the equilibrium is globally stable for constant inputs.

**Step 11 (response to constant inputs).** For constant $x_j$, the solution is

$$
r_a(t) = r^\ast + (r_a(0) - r^\ast)\,e^{-t/\tau_a},\qquad r^\ast = r_{a0}\left[1 + \sum_j\beta_jx_j\right].
$$

The fractional steady dilation is $\sum_j\beta_jx_j$. A Kir2.1 knockout removes the $j=2$ term. A.6 calibrates $\beta_d$ so that 51% of the response remains after the knockout.

**Step 12 (frequency response).** For $x_j\propto e^{i\omega t}$, $r_a - r^\ast\propto H(i\omega)$ with $H(i\omega) = 1/(1+i\omega\tau_a)$ and $\lvert H\rvert = (1+\omega^2\tau_a^2)^{-1/2}$.

**Result.** The equation is a first-order relaxation toward a target radius that is linear in normalized dilator signals. It can be reconstructed from Laplace's law and a linear viscoelastic wall (Steps 1–9), and it matches A.8 Eq. (8) exactly under A1–A5. The reconstruction makes three assumptions explicit, none of which the source states:

1. The transmural pressure is constant, so the myogenic (Bayliss) feedback through $p_c$ of T2.1 is absent.
2. The signals add independently.
3. A single $\tau_a$ serves the "fast" NsMJ and "slow" A2B pathways.

The equation cannot be evaluated as stated, because two inputs are never specified. Proposals, clearly not in any source:

$$
\tau_N\frac{dI_{NsMJ}}{dt} = -I_{NsMJ} + g_N\sum_{i\in pre(a)}r_i(t - d_N),\qquad \mathcal F_{A2B} = \frac{[Ado]^{n}}{K_{A2B}^{n} + [Ado]^{n}}\ \text{filtered as}\ \tau_{cAMP}\frac{d\mathcal F}{dt} = -\mathcal F + \frac{[Ado]^{n}}{K_{A2B}^{n} + [Ado]^{n}}.
$$

**Checks**

- *Dimensions.* Each term in the bracket must be dimensionless:
  - $I_{NsMJ}/I_0$ is dimensionless.
  - $\Phi_{root}/A_K$ is dimensionless only if $A_K$ is in mV. That is consistent with T2.12, where $s_c = A_K[\ldots]$ feeds $\Phi$ (mV) in T2.11.
  - $\mathcal F_{A2B}$ and $\psi_c$ are dimensionless by assumption.
  - Both sides then have units of length.
- *Latency.* A first-order filter responds from $t = 0^+$; the 10% rise time is $\tau_a\ln(10/9) = 0.105\,\tau_a$, or 0.21 s for $\tau_a = 2$ s. The "<150 ms latency" of the NsMJ pathway is therefore a property of $I_{NsMJ}(t)$, not of this equation.
- *Positivity.* With non-negative dilator inputs the target is at least $r_{a0}>0$, so $r_a$ stays positive.
- *Lean.* `dr_a_dt` in `Model_A8_All_Equations.lean` writes `beta_a * Phi_root` without dividing by `A_K` (declared but unused). The basal-equilibrium theorem is unaffected, but the coded equation differs from A.8 Eq. (8) by the factor $1/A_K$ (1/255 with the A.6 value $A_K = 255$).
- *Notation drift.* $\tau_a$ (A.6–A.8) becomes $\tau_v$ in A.9 and A.10 (T2.10), which clashes with the membrane $\tau_v$ of T1.1.

**Lineage**

- A.2 (`Model A.2 Repaired Specification and Validation.docx`) and A.5 Eq. 10 (`Model_A4_..._gemini.pdf`): a normalized-flow ODE, $\tau_f\dot f_Q = -(f_Q-1) + \kappa_N(u_Q/\bar u_Q - 1) + \kappa_K(k_Q-k_{rest})$. This is already a first-order relaxation with additive drives.
- A.6 Eq. 15: $\tau_a\dot r_a = r_{a0}[1 + \beta_a\Phi_{root}/A_K + \beta_d\sum_c\omega_{ac}\psi_c] - r_a$, with $\beta_a = 2.74$ (33% arteriole dilation, Longden) and $\beta_d = 2.94$ (51% remaining after Kir2.1 knockout).
- A.7 Eq. 15 (`Model A.7 with all equations.docx`): unchanged.
- A.8 Eq. (8) adds the NsMJ and A2B pathways (Zhang 2024, Theparambil 2024, as cited in A.8). The Lean `dr_a_dt` drops $1/A_K$.
- A.10 Eq. 2.2 merges the bracket, printed with "…", into the NE vasomotion equation (T2.10).
- The Aleph lineage table reads "dual fast NsMJ + slow Kir2.1 dilation".

**Derivation status.** Phenomenological closure. The relaxation structure is reconstructed here from Laplace's law and a Kelvin–Voigt wall, but the additive linear bracket is a modelling choice calibrated on Longden 2017 and Hall 2014 (as cited in A.6). It is also incomplete in source: $I_{NsMJ}$ and $\mathcal F_{A2B}$ are never specified, and the forms above are proposals.

---

## T2.10: Noradrenergic vasomotion coupling of vessel radius to the LC oscillator (inherited: A.10 Eq. 2.2)

**Equation as stated in the latest source** (A.10 Eq. 2.2, `Model_A10_Comprehensive_Scientific_Report.docx`; the ellipsis is literal):

$$
\tau_v\frac{dr_e}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\left(\frac{I_{NsMJ}}{I_0}\right) + \ldots\right] - r_e - \kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_e
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $r_e$ | vessel radius (A.10 uses $r_e$ with the arteriolar baseline $r_{a0}$) | m |
| $\tau_v$ | vascular time constant (the same role as $\tau_a$ of T2.9; clashes with the membrane $\tau_v$) | s |
| $\kappa_{NE}$ | noradrenergic constriction gain | 1/[$NE_{LC}$] |
| $\mathrm{Re}(NE_{LC})$ | real part of the LC amplitude (T2.2) | [$NE_{LC}$] |
| "…" | literal ellipsis; the remaining dilator terms of T2.9 | - |

**Physical starting point.** The wall mechanics of T2.9 (Laplace's law plus a Kelvin–Voigt wall) with an α1-adrenergic contribution to active tension, forced by the LC limit cycle of T2.2. Assumptions:

- A1. All assumptions of T2.9.
- A2. NE raises active tension, linearly in the NE signal for small signals.
- A3. The NE signal is $\mathrm{Re}(NE_{LC})$, an oscillation about zero mean on the limit cycle. It represents the deviation of NE from its mean.
- A4. The "…" stands for the remaining terms of the T2.9 bracket. This reconstruction is not stated in any source.

**Derivation**

**Step 1 (reconstruct the full equation; Reconstructed).** Replace the ellipsis by the T2.9 bracket, with $r_a\to r_e$ and $\tau_a\to\tau_v$ (A4). Write $x_j$ for the normalized dilator signals of T2.9 Step 9:

$$
\tau_v\frac{dr_e}{dt} = r_{a0}\left[1 + \beta_{NsMJ}\frac{I_{NsMJ}}{I_0} + \beta_a\frac{\Phi_{root}}{A_K} + \beta_{astro}\mathcal F_{A2B} + \beta_d\sum_c\omega_{ac}\psi_c\right] - r_e - \kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_e .
$$

**Step 2 (additive form from wall mechanics).** Add the NE tension to T2.9 Step 6: $\sigma_{act} = \sigma_0 - \sum_ja_jx_j + a_{NE}\,\mathrm{Re}(NE_{LC})$. Repeating T2.9 Steps 7–8:

$$
r_{eq} = r_{a0}\left[1 + \sum_j\beta_jx_j - \kappa'\,\mathrm{Re}(NE_{LC})\right],\qquad \kappa' = \frac{a_{NE}}{k_wr_{a0}} .
$$

The constriction therefore enters the target additively, as $-\kappa' r_{a0}\mathrm{Re}(NE_{LC})$.

**Step 3 (compare with the printed multiplicative form).** Write $r_e = r_{a0} + \delta r$, where $\delta r$ is of the order of the signals. Then

$$
-\kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_e = -\kappa_{NE}\,\mathrm{Re}(NE_{LC})\,r_{a0} - \kappa_{NE}\,\mathrm{Re}(NE_{LC})\,\delta r .
$$

The second term is of second order. The printed form therefore agrees with Step 2 to first order, with $\kappa_{NE} = \kappa'$. The multiplicative form is a modelling choice that adds two things:

- the effective relaxation rate becomes $(1+\kappa_{NE}\mathrm{Re}\,NE_{LC})/\tau_v$;
- for constant NE, the equilibrium is $r^\ast = r_{target}/(1+\kappa_{NE}NE)$.

**Step 4 (positivity condition).** Write the printed equation as $\tau_v\dot r_e = r_{target} - (1+\kappa_{NE}\mathrm{Re}\,NE_{LC})\,r_e$. If $1+\kappa_{NE}\mathrm{Re}\,NE_{LC}>0$ at all times, then $\dot r_e>0$ whenever $r_e\to 0^+$ with $r_{target}>0$, so $r_e$ stays positive and bounded. On the limit cycle, $\min\mathrm{Re}\,NE_{LC} = -\rho^\ast$, so the condition is

$$
\kappa_{NE}\,\rho^\ast = \kappa_{NE}\sqrt{\lambda_{LC} - g_{GABA} - g_{\alpha2}} < 1 .
$$

If it is violated, the effective decay rate turns negative over part of each cycle.

**Step 5 (linear response to the limit cycle).** Hold the dilator inputs constant, so $r_{target} = R_0$. On the cycle, $\mathrm{Re}\,NE_{LC} = \rho^\ast\cos\omega t$ (T2.2 Step 11, $\omega = \omega_{LC}$). Write $r_e = R_0 + \delta r$ and keep first order in $\kappa_{NE}\rho^\ast$:

$$
\tau_v\frac{d\,\delta r}{dt} = -\delta r - \kappa_{NE}\rho^\ast R_0\cos\omega t .
$$

**Step 6 (periodic solution).** Try $\delta r = \mathrm{Re}(A e^{i\omega t})$ with forcing $-\kappa_{NE}\rho^\ast R_0\,\mathrm{Re}(e^{i\omega t})$. Then $i\omega\tau_vA = -A - \kappa_{NE}\rho^\ast R_0$, so

$$
A = -\frac{\kappa_{NE}\rho^\ast R_0}{1 + i\omega\tau_v},\qquad \lvert A\rvert = \frac{\kappa_{NE}\,\rho^\ast\,R_0}{\sqrt{1+(\omega_{LC}\tau_v)^2}},\qquad \arg A = \pi - \arctan(\omega_{LC}\tau_v).
$$

Peak constriction lags peak NE by $\arctan(\omega_{LC}\tau_v)/\omega_{LC}$.

**Step 7 (second-order mean shift).** Average the exact equation over one period, writing $\langle\cdot\rangle$ for the period mean. In steady oscillation $\langle\dot r_e\rangle = 0$, so $0 = R_0 - \langle r_e\rangle - \kappa_{NE}\rho^\ast\langle\cos\omega t\,\delta r\rangle$. With $\langle\cos\omega t\,\mathrm{Re}(Ae^{i\omega t})\rangle = \frac12\mathrm{Re}A$ and $\mathrm{Re}A = -\kappa_{NE}\rho^\ast R_0/(1+\omega^2\tau_v^2)$:

$$
\langle r_e\rangle - R_0 = \frac{(\kappa_{NE}\rho^\ast)^2R_0}{2\left(1+(\omega_{LC}\tau_v)^2\right)} > 0 .
$$

The multiplicative coupling rectifies: oscillating NE produces a small net mean dilation at second order.

**Result.** With the ellipsis replaced by the T2.9 bracket (Step 1, a reconstruction), the equation is the T2.9 relaxation plus an α1-adrenergic constriction. To first order it equals the additive tension model derived from wall mechanics (Steps 2–3). The source is incomplete in three ways:

1. The literal ellipsis.
2. The baseline. $r_{a0}$ is used for a generic edge radius $r_e$; for capillary edges the baseline should be $r_0$ of T2.14, so the equation applies only to arteriolar edges.
3. The mapping of $NE_{LC}$ to a concentration (T2.2).

Derived consequences:

- the positivity condition $\kappa_{NE}\rho^\ast<1$;
- the vasomotion amplitude $\lvert A\rvert/R_0 = \kappa_{NE}\sqrt{\lambda_{eff}}/\sqrt{1+(\omega_{LC}\tau_v)^2}$.

The amplitude vanishes continuously as $\lambda_{eff}\to 0^+$, which is the model's account of zolpidem-induced loss of vasomotion.

**Checks**

- *Dimensions.* $\kappa_{NE}\mathrm{Re}(NE_{LC})$ is dimensionless, so every term has units of length.
- *Numbers from source values.* Take $\tau_v = \tau_a = 2$ s (A.6; identifying the two is an assumption) and $\omega_{LC} = 0.201$ rad s⁻¹ (T2.2 Checks). Then:
  - $\omega_{LC}\tau_v = 0.402$;
  - $\sqrt{1+0.402^2} = 1.078$, so the oscillation passes with 93% of its quasi-static amplitude;
  - the phase lag is $\arctan(0.402) = 21.9°$, which is 1.9 s.
- *Limits.* $\kappa_{NE}\to 0$ recovers T2.9. $\omega_{LC}\tau_v\gg 1$ low-pass filters the vasomotion away. $\lambda_{eff}\le 0$ gives $\rho^\ast = 0$ and no vasomotion.
- *Link to the invariant $\Phi_{peristalsis}$ (Aleph Sec. 9.1).* The wall-velocity amplitude from Step 6 is $\omega\lvert A\rvert = (\kappa_{NE}\rho^\ast R_0/\tau_v)\cdot\omega\tau_v/\sqrt{1+(\omega\tau_v)^2}$. That has the structure $\omega\tau/\sqrt{1+(\cdot)^2}$ seen in the invariant, but the invariant replaces $\omega\tau$ inside the square root by $\kappa_{stiff}C_{amyloid}$, which this derivation does not produce. The invariant's units are checked in T2.16.

**Lineage**

- A.9 (`Model_A9_changes from a8.docx`, equation image): $\tau_v\,dr_e/dt = \cdots - \kappa_{NE}NE_{LC}(t)\,r_e$, with a literal "⋯". Motivated by Hauglund 2025 (as cited).
- A.10 Eq. 2.2: adds $\mathrm{Re}(\cdot)$ and the NsMJ term; the rest is elided as "…".
- The Aleph lineage table (both Aleph files) reads "noradrenergic vasomotion ($-\kappa_{NE}\cdot r_e$)".
- No version writes the full equation.

**Derivation status.** Incomplete in source (literal ellipsis). The full form in Step 1 is a reconstruction. The NE term is a phenomenological closure that agrees to first order with a wall-mechanics derivation. The response amplitude and the positivity condition are derived here.

---

## T2.11: Kir2.1 retrograde conducted hyperpolarization (Green's-function kernel with bifurcation cost) (inherited: A.8 Tier 2, Pathway 2a)

**Equation as stated in the latest source** (`Model_A8_model only.docx`, Pathway 2a; identical to A.6 Eq. 12 and A.7 Eq. 12):

$$
\Phi_m(t) = \Phi_{max}\tanh\left(\sum_n e^{-C_{nm}}\,\frac{s_n(t - d_{nm}/v_c)}{\Phi_{max}}\right), \qquad C_{nm} = \frac{\ell_e}{\lambda_c}\ (\mathrm{upstream}), \quad C_{nm} = \frac{\ell_e}{\lambda_c} + \ln b\ (\mathrm{lateral\ or\ downstream})
$$

$C_{nm}$ is the least path cost from $n$ to $m$, summed step by step.

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $\Phi_m$ | conducted endothelial hyperpolarization at node $m$ (clashes with the fluence $\Phi$ of T2.6) | mV |
| $\Phi_{max}$ | saturation level (60 mV, A.6) | mV |
| $s_n$ | K⁺-driven source at node $n$ (T2.12) | mV |
| $C_{nm}$ | least path cost from $n$ to $m$ | dimensionless |
| $d_{nm}$ | path distance from $n$ to $m$ | m |
| $v_c$ | conduction speed (2 mm s⁻¹, Longden 2017 as cited) | m s⁻¹ |
| $\lambda_c$ | length constant (2 mm, A.6) | m |
| $\ell_e$ | length of one step (segment) | m |
| $b$ | branching factor (2, A.6) | dimensionless |

**Physical starting point.** Linear cable theory for the endothelial syncytium (Hodgkin & Rushton 1946; Rall), current conservation at junctions (Kirchhoff), and regenerative front propagation in a bistable cable (Nagumo-type; see Keener & Sneyd, *Mathematical Physiology*). Assumptions:

- A1. Between junctions, each segment is a uniform passive cable with length constant $\lambda_c$.
- A2. At a junction, current divides among the outgoing branches in proportion to their input conductances.
- A3. Kir2.1 regeneration is represented only by a constant arrival speed $v_c$.
- A4. Sources superpose linearly before saturation.
- A5. The response is dominated by the cheapest path.
- A6. Saturation at $\Phi_{max}$ is represented by tanh.

**Derivation (Reconstructed; components only)**

**Step 1 (cable equation).** For a membrane-potential deviation $V(x,t)$ with membrane time constant $\tau_m$ and a normalized source $J$:

$$
\tau_m\frac{\partial V}{\partial t} = \lambda_c^2\frac{\partial^2V}{\partial x^2} - V + J(x,t).
$$

**Step 2 (steady, source-free segment).** Set $\partial_tV = 0$ and $J = 0$: $\lambda_c^2V'' = V$, so $V = c_1e^{-x/\lambda_c} + c_2e^{x/\lambda_c}$. Write the segment $[0,\ell]$ in the form $V(x) = A\cosh\frac{\ell-x}{\lambda_c} + B\sinh\frac{\ell-x}{\lambda_c}$. Let $r_{ax}$ be the axial resistance per unit length, $G_\infty = 1/(r_{ax}\lambda_c)$ the input conductance of a semi-infinite cable, and $G_L$ the load at $x = \ell$. The load condition $I(\ell) = G_LV(\ell)$, with $I = -r_{ax}^{-1}V'$, gives $B = (G_L/G_\infty)A$. Therefore

$$
\frac{V(\ell)}{V(0)} = \frac{1}{\cosh(\ell/\lambda_c) + (G_L/G_\infty)\sinh(\ell/\lambda_c)} .
$$

**Step 3 (matched load gives the exponential).** For $G_L = G_\infty$, the denominator is $\cosh+\sinh = e^{\ell/\lambda_c}$:

$$
\frac{V(\ell_e)}{V(0)} = e^{-\ell_e/\lambda_c},\qquad \text{cost } c_e = -\ln\frac{V(\ell_e)}{V(0)} = \frac{\ell_e}{\lambda_c}.
$$

The per-step cost $\ell_e/\lambda_c$ is exact when each segment sees its characteristic conductance, and approximate otherwise.

**Step 4 (path product).** Transmissions multiply along a path, so costs add: $\prod_k e^{-c_k} = e^{-\sum_kc_k}$. For a path made only of segments, $\sum_k\ell_k/\lambda_c = d_{nm}/\lambda_c$.

**Step 5 (junction: current division).** At a node, incoming current $I_{in}$ leaves through branches $k$ with input conductances $G_k$, and all branches share the node voltage $V_n$. Current conservation gives $I_{in} = \sum_kG_kV_n$, so $V_n = I_{in}/\sum_kG_k$ and

$$
I_k = G_kV_n = I_{in}\frac{G_k}{\sum_jG_j}.
$$

**Step 6 (downstream or lateral cost).** At a bifurcation into $b$ equal daughters, each receives the fraction $1/b$, so the cost is $-\ln(1/b) = \ln b$. This is the source's term.

**Step 7 (upstream cost is not zero in a passive tree).** A signal climbing from a daughter divides between the parent (conductance $G_p$) and $b-1$ siblings ($G_s$ each). The fraction entering the parent is $G_p/(G_p + (b-1)G_s)$, so

$$
c_{up} = \ln\left(1 + (b-1)\frac{G_s}{G_p}\right).
$$

This vanishes only if $G_p\gg(b-1)G_s$. Suppose $G\propto r^{m}$, where $m = 3/2$ for a solid core conductor, since $G_\infty = \pi r^{3/2}\sqrt{2/(R_iR_m)}$. Suppose also Murray's law for $b=2$, $r_s = 2^{-1/3}r_p$. Then $c_{up} = \ln(1 + 2^{-m/3})$:

- $m = 0$ gives 0.693;
- $m = 1$ gives 0.584;
- $m = 3/2$ gives 0.535.

Passive geometry therefore never makes the upstream step free. The source's "upstream cost $\ell_e/\lambda_c$ only" is an imposed asymmetry. It was introduced in A.6 because an isotropic kernel "dilated every arteriole in the 1.5 mm slab".

**Step 8 (arrival delay).** Kir2.1 regeneration turns the endothelium into an excitable or bistable cable that supports a front of constant speed $v_c$. The arrival time over path length $d_{nm}$ is $d_{nm}/v_c$, so source $n$ contributes $s_n(t - d_{nm}/v_c)$ at node $m$. A purely passive cable has no fixed delay (its response spreads diffusively), and a purely regenerative front does not attenuate. The kernel combines a front's delay with a passive cable's attenuation. It is a reduced description fitted to two measured numbers, $v_c$ and $\lambda_c$.

**Step 9 (least-cost path).** For a linear network, the response at $m$ to a source at $n$ is a sum over all paths of the products of their transmissions. Keeping only the largest term gives $e^{-C_{nm}}$ with $C_{nm} = \min_{paths}\sum_kc_k$. This is exact on a tree, where the simple path is unique (within the current-division approximation). On a mesh with loops it is a lower bound when all transmissions are positive.

**Step 10 (superposition).** Sum over sources (A4):

$$
u_m(t) = \sum_n e^{-C_{nm}}\,s_n\!\left(t - \frac{d_{nm}}{v_c}\right).
$$

**Step 11 (saturation).** Set $\Phi_m = \Phi_{max}\tanh(u_m/\Phi_{max})$ (A6). From the expansion $\tanh y = y - y^3/3 + O(y^5)$:

$$
\Phi_m = u_m - \frac{u_m^3}{3\Phi_{max}^2} + \ldots\quad(\lvert u_m\rvert\ll\Phi_{max}),\qquad \lvert\Phi_m\rvert<\Phi_{max}\ \text{always}.
$$

Small signals superpose linearly, and the hyperpolarization never exceeds $\Phi_{max}$. Physically, $\Phi_{max}$ should not exceed the distance from the resting potential to $E_K$.

**Result.** The kernel combines several pieces:

- exact passive-cable attenuation per segment (Step 3, for matched loads);
- an approximate current-division junction cost $\ln b$ (Steps 5–6);
- an imposed upstream/downstream asymmetry (Step 7);
- a regenerative-front delay (Step 8);
- a dominant-path approximation (Step 9);
- linear superposition (Step 10);
- tanh saturation (Step 11).

It matches the A.6/A.8 form. The parts that cannot be derived are the asymmetry, the combination of delay with attenuation, and the tanh.

**Checks**

- *Dimensions.* $C_{nm}$ is dimensionless, $s_n$ and $\Phi$ are in mV, and $d/v_c$ is in s.
- *Single source on an upstream path (illustrative inversion of the A.6 calibration).* With $d = 500$ µm and $\lambda_c = 2$ mm, $e^{-C} = e^{-0.25} = 0.779$. Requiring $\Phi = 23$ mV with $\Phi_{max} = 60$ mV gives $s = 60\,\mathrm{artanh}(23/60)/0.779 = 60\times0.404/0.779 = 31.1$ mV. The delay is $0.5/2 = 0.25$ s. This assumes a single active node; A.6 may have calibrated with several. With the A.6 gain $A_K = 255$ (T2.12), $s = 31.1$ mV corresponds to $B(k_c) - B(k_{rest}) = 31.1/255 \approx 0.12$, a node on the rising flank of the band-pass rather than on its plateau. A node on the plateau ($s_c\approx A_K$) would give $60\tanh(0.779\times255/60)\approx 60$ mV at 500 µm, so the 23 mV calibration point cannot correspond to full Kir2.1 activation of a single node.
- *Limits.* As $\lambda_c\to\infty$ and $b\to 1$ every node sees every source (no attenuation, the isotropic failure of A.6). As $v_c\to\infty$ the response is instantaneous.
- *Passive-cable failure (A.6 development log).* A passive cable with $\lambda = 1$ mm on the mesh gave 0.03 mV at the arteriole. That is why the measured regenerative parameters replace an explicit cable solution.

**Lineage**

- A.6 Eq. 12 (`Model A.6 four-caveat revision...docx`) introduces the kernel as the "solution of a regenerative endothelial cable reduced to its measured properties", with $\ln b$ as "current division at branch points". The development log records the passive-cable and isotropic-kernel failures.
- A.7 Eq. 12 (`Model A.7 with all equations.docx`): unchanged.
- A.8 (`Model_A8_model only.docx`; A.8 PDF names an "asymmetric Green's kernel (ln b)"): unchanged.
- A.10 and Aleph: the Kir2.1 pathway is inherited by name, with no formula.

**Derivation status.** Phenomenological closure. Per-segment attenuation and the junction cost are motivated by linear cable theory (exact for matched loads and equal-branch current division). The upstream/downstream asymmetry, the delayed and attenuated hybrid kernel, the least-cost path rule on a mesh, and the tanh saturation are modelling choices calibrated on Longden 2017 (as cited).

---

## T2.12: Kir2.1 extracellular-K⁺ source term (inherited: A.7 annex Eq. 11 / A.6 Eq. 11)

**Equation as stated in the latest source** (A.7 Eq. 11, `Model A.7 with all equations.docx`; A.6 writes the second product as "(same at $k_{rest}$)"):

$$
s_c = A_K\left[\sigma\left(\frac{k_c - k_{th}}{s_k}\right)\sigma\left(\frac{k_{off} - k_c}{s_{off}}\right) - \sigma\left(\frac{k_{rest} - k_{th}}{s_k}\right)\sigma\left(\frac{k_{off} - k_{rest}}{s_{off}}\right)\right]
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $s_c$ | Kir2.1 source at capillary node $c$ (input to T2.11) | mV |
| $A_K$ | effective source gain (255, A.6, calibrated to 23 mV at 500 µm) | mV (implied by T2.11) |
| $k_c$ | extracellular K⁺ at node $c$ (T2.13) | mM |
| $k_{th}$, $s_k$ | activation threshold and width (6.8 and 0.5 mM; clashes with the thermal $k_{th}$ of T2.3) | mM |
| $k_{off}$, $s_{off}$ | offset concentration and width (20 mM; $s_{off}$ not given in any source) | mM |
| $k_{rest}$ | resting extracellular K⁺ (value not restated) | mM |
| $\sigma(y)$ | logistic function, $1/(1+e^{-y})$ | dimensionless |

**Physical starting point.** The Kir2.1 inward-rectifier conductance rises with extracellular K⁺; classically $g_{Kir}\propto\sqrt{[K^+]_o}$ (Hagiwara & Takahashi 1974). The K⁺ reversal potential follows the Nernst equation. Together these explain why modest K⁺ elevation hyperpolarizes endothelium and smooth muscle while large elevation depolarizes it. The logistic band-pass is a phenomenological fit to that behaviour (Longden 2017 thresholds, as cited). Assumptions:

- A1. The cell has two conductance groups: Kir ($g_K(k)$, reversal $E_K(k)$) and the rest ($g_0$, reversal $E_0$), at steady state.
- A2. Nernst: $E_K = (RT/F)\ln(k/k_i)$, with constant intracellular K⁺ $k_i$.
- A3. The source is referenced to rest.

**Derivation (Reconstructed motivation, then properties)**

**Step 1 (steady potential with two conductances).** Zero net current, $g_K(V - E_K) + g_0(V - E_0) = 0$, gives

$$
V_{ss}(k) = \frac{g_K(k)\,E_K(k) + g_0E_0}{g_K(k) + g_0}.
$$

**Step 2 (hyperpolarization relative to the Kir-free potential).** Subtract $V_{ss}$ from $E_0$:

$$
H(k) = E_0 - V_{ss}(k) = \frac{g_K(k)}{g_K(k)+g_0}\,\bigl(E_0 - E_K(k)\bigr).
$$

**Step 3 (band-pass structure).** $H$ is the product of two factors:

- $w(k) = g_K/(g_K+g_0)$, which rises with $k$ because $g_K$ grows with $k$ and lies in $[0,1)$;
- $E_0 - E_K(k)$, which by A2 falls linearly in $\ln k$ and crosses zero at $k^\ast = k_i\exp(FE_0/RT)$.

So $H$ rises, peaks, and changes sign at $k^\ast$: the hyperpolarization disappears when $E_K$ reaches $E_0$. This gives a physical meaning to $k_{off}$: the concentration at which the Nernst potential reaches the non-Kir resting potential.

**Step 4 (logistic surrogate).** Replace $w(k)$ by the steep sigmoid $\sigma((k-k_{th})/s_k)$, which represents the regenerative, threshold-like Kir2.1 activation. Replace $(E_0 - E_K(k))$, normalized, by $\sigma((k_{off}-k)/s_{off})$. Define

$$
B(k) = \sigma\!\left(\frac{k - k_{th}}{s_k}\right)\sigma\!\left(\frac{k_{off} - k}{s_{off}}\right).
$$

The surrogate never turns negative, whereas $H(k)$ does above $k^\ast$.

**Step 5 (reference to rest).** By A3, $s_c = A_K[B(k_c) - B(k_{rest})]$, which is the source equation. At rest,

$$
s_c(k_{rest}) = A_K\,[B(k_{rest}) - B(k_{rest})] = 0 .
$$

**Step 6 (limits).** Use $\sigma(y)\to 1$ as $y\to+\infty$ and $\sigma(y)\to 0$ as $y\to-\infty$.

- As $k_c\to\infty$, the second factor goes to 0, so $B\to 0$ and $s_c\to -A_KB(k_{rest})$.
- For $k_c\ll k_{th}$, the first factor is exponentially small, of order $e^{-(k_{th}-k_c)/s_k}$, giving the same limit up to that small term.

For $k_{rest}\ll k_{th}$ and $k_{rest}\ll k_{off}$, $B(k_{rest})\approx\sigma((k_{rest}-k_{th})/s_k)\approx e^{-(k_{th}-k_{rest})/s_k}$, which is very small. The source is therefore close to zero outside the band.

**Step 7 (plateau).** If the band is wide, $k_{off} - k_{th}\gg s_k, s_{off}$, then $B\approx 1$ for $k_{th} + \text{few }s_k < k < k_{off} - \text{few }s_{off}$, and $s_c\approx A_K$.

**Result.** The double-sigmoid band-pass is a phenomenological surrogate for the physical steady state $H(k) = w(k)(E_0-E_K(k))$ (Steps 1–3). The rest subtraction makes baseline sources vanish exactly (Step 5). It matches the A.6/A.7 form. Departures from the physics:

1. The surrogate cannot become depolarizing above $k_{off}$. A.6 itself records a failed high-K⁺ test ("48% dilation, transient… needs K⁺-dependent inactivation").
2. $s_{off}$ is never given.
3. $A_K = 255$ mV is a fitted gain that exceeds $\Phi_{max} = 60$ mV, so a single node on the plateau saturates the tanh of T2.11.

**Checks**

- *Dimensions.* All arguments are (mM)/(mM), dimensionless. $s_c$ has the units of $A_K$, which must be mV for T2.11 and T2.9.
- *Monotonicity.* $\partial B/\partial k = B\left[\frac{1-\sigma_1}{s_k} - \frac{1-\sigma_2}{s_{off}}\right]$, with $\sigma_1$ and $\sigma_2$ the two factors. It is positive at low $k$ and negative at high $k$, with one interior maximum when the band is wide.
- *Why the reference to rest matters (A.6 development log).* Without the subtraction, 823 nodes each contributed 0.015 mV and summed to about 7 mV of standing hyperpolarization. Step 5 removes this exactly.
- *Dose–response (A.6).* 0.9, 4.9, 15, 23 and 33% dilation at 5, 6, 7, 8 and 10 mM. The rise between 6 and 8 mM reflects $k_{th} = 6.8$ mM and $s_k = 0.5$ mM.

**Lineage**

- A.6 Eq. 11 (`Model A.6 four-caveat revision...docx`) introduces the source, referenced to rest after the standing-offset failure.
- A.7 Eq. 11 (`Model A.7 with all equations.docx`) is the last explicit statement.
- A.8 refers to a "K⁺-driven" source $s_n$ without a formula. A.10 and Aleph name the Kir2.1 pathway only.

**Derivation status.** Phenomenological closure. The band-pass shape is motivated by Kir conductance and Nernst physics (Steps 1–3); the logistic form and its parameters are fitted (Longden 2017, as cited). It has not been restated since A.7.

---

## T2.13: Extracellular K⁺ with glial clearance and glymphatic washout (supports $h_K$ and $s_c$) (inherited: A.5 Eq. 13)

**Equation as stated in the latest source** (A.5 Eq. 13, `Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf`):

$$
\tau_K\frac{dk_Q}{dt} = -m(e_Q)\,(k_Q - k_{rest}) + \gamma_K\,\bar r_Q - v_{glymph}(t)\,(k_Q - k_{CSF})
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $k_Q$ | extracellular K⁺ in supply domain $Q$ (capillary node $k_c$ from A.6 on) | mM |
| $\tau_K$ | time constant | s |
| $m(e_Q)$ | energy-dependent clearance factor, $m(x) = x/(x+K)$ (A.2) | dimensionless |
| $e_Q$ | domain energy (ATP) level | relative |
| $k_{rest}$ | resting K⁺ | mM |
| $\gamma_K$ | K⁺ release per unit mean firing rate | mM s |
| $\bar r_Q$ | mean firing rate in $Q$ | s⁻¹ |
| $v_{glymph}$ | glymphatic term; a velocity in T6.16 but dimensionless here (Step 6) | see Step 6 |
| $k_{CSF}$ | CSF K⁺ concentration | mM |

**Physical starting point.** A mass balance of K⁺ in the extracellular space (ECS) of a well-mixed control volume, with release proportional to firing, energy-dependent active uptake (Na⁺/K⁺-ATPase, astrocytic α2 isoform, per A.2), and convective exchange with CSF. Assumptions:

- A1. The domain (or node voxel) is well mixed. It has tissue volume $V$ and ECS volume fraction $\alpha$, both constant. Diffusion between domains is neglected.
- A2. Release is $N\nu_K\bar r$, where $N$ is the number of neurons and $\nu_K$ the net moles of K⁺ released per spike before re-uptake.
- A3. Net uptake above the resting balance is linear in $(k - k_{rest})$, with rate constant $\kappa_u$, and is scaled by the Michaelis–Menten energy factor $m(e)$, because pumping consumes ATP.
- A4. Convective exchange with CSF at volume flow $Q_{gl}$ through the domain.

**Derivation (Reconstructed)**

**Step 1 (mass balance).** The amount of K⁺ in the ECS is $\alpha Vk$:

$$
\alpha V\frac{dk}{dt} = N\nu_K\bar r - \alpha V\kappa_u\,m(e)\,(k - k_{rest}) - Q_{gl}\,(k - k_{CSF}).
$$

**Step 2 (divide by $\alpha V\kappa_u$).**

$$
\frac{1}{\kappa_u}\frac{dk}{dt} = \frac{N\nu_K}{\alpha V\kappa_u}\bar r - m(e)\,(k - k_{rest}) - \frac{Q_{gl}}{\alpha V\kappa_u}\,(k - k_{CSF}).
$$

**Step 3 (name the groups).** Define

$$
\tau_K = \frac{1}{\kappa_u},\qquad \gamma_K = \frac{N\nu_K\tau_K}{\alpha V},\qquad \tilde v_{gl} = \frac{Q_{gl}\,\tau_K}{\alpha V}.
$$

Then

$$
\tau_K\frac{dk}{dt} = -m(e)\,(k - k_{rest}) + \gamma_K\bar r - \tilde v_{gl}\,(k - k_{CSF}),
$$

which is the A.5 form with $v_{glymph}\equiv\tilde v_{gl}$.

**Step 4 (link to a velocity).** If the glymphatic flow is a superficial velocity $v$ through a domain of cross-section $A$ and length $L_Q$, then $Q_{gl} = vA$ and $V = AL_Q$. So

$$
\tilde v_{gl} = \frac{v\,\tau_K}{\alpha\,L_Q} .
$$

**Step 5 (fixed point and relaxation).** For constant $e$, $\bar r$ and $\tilde v_{gl}$, set $dk/dt = 0$:

$$
k^\ast = \frac{m(e)\,k_{rest} + \gamma_K\bar r + \tilde v_{gl}\,k_{CSF}}{m(e) + \tilde v_{gl}},\qquad \tau_{relax} = \frac{\tau_K}{m(e) + \tilde v_{gl}} .
$$

**Step 6 (units).** Every term must have the units of $\tau_K\,dk/dt$, which is mM. So $m(e)$ must be dimensionless, which it is, and $v_{glymph}$ must also be dimensionless. It is the group $v\tau_K/(\alpha L_Q)$, not a velocity. Elsewhere (T6.16, T6.14) $v_{glymph}$ is a velocity, so the same symbol has inconsistent units. The A.4 validation report (`Model A.5  validation against experimental data.docx`) flags the same point.

**Result.** The equation follows from a well-mixed ECS K⁺ balance under A1–A4. It matches A.5 Eq. 13, provided $v_{glymph}$ is read as the dimensionless group $v\tau_K/(\alpha L_Q)$ (Step 4). Corrected form, re-indexed to the capillary nodes used from A.6 on (Reconstructed):

$$
\tau_K\frac{dk_c}{dt} = -m(e_c)\,(k_c - k_{rest}) + \gamma_K\,\bar r_c - \frac{v_{glymph}\,\tau_K}{\alpha L_c}\,(k_c - k_{CSF}) + \tau_KD_K^{eff}\sum_{c'\sim c}\frac{k_{c'} - k_c}{\Delta x_{cc'}^2}.
$$

The last term is the inter-node diffusion that Aleph Invariant 9 ($c_{ictal}$, which uses $D_K$ and $\tau_K$) presupposes but no source writes. Note also that $k_{rest}$ is the fixed point only for $\bar r = 0$. With a resting firing rate $\bar r_0$, the resting K⁺ is $k_{rest} + \gamma_K\bar r_0/m(e)$, so either $\bar r$ must be read as the excess over baseline or $k_{rest}$ must be re-defined.

**Checks**

- *Dimensions (Step 6).* $m(e)(k - k_{rest})$ is in mM. $\gamma_K\bar r$ is (mM s)(s⁻¹) = mM. $\tilde v_{gl}(k - k_{CSF})$ is in mM only if $\tilde v_{gl}$ is dimensionless.
- *Energy failure.* As $e\to 0$, $m\to 0$; with $\tilde v_{gl} = 0$, $\tau_K\dot k = \gamma_K\bar r>0$ and K⁺ rises without bound. The bound comes only from the firing gate $h_K(k_c)$ in T1.20 silencing activity, which is the model's route to spreading-depolarization-like failure.
- *Washout limit.* As $\tilde v_{gl}\to\infty$, $k^\ast\to k_{CSF}$.
- *Rest.* With $\bar r = 0$ and $\tilde v_{gl} = 0$, $k^\ast = k_{rest}$.

**Lineage**

- A.2 (`Model A.2 Repaired Specification and Validation.docx`): $\tau_K\dot k_Q = -m(e_Q)(k_Q - k_{rest}) + \gamma_K\bar r_Q$, with clearance justified by the energy cost of the astrocytic α2 pump.
- A.5 Eq. 13 adds glymphatic washout; this is the last explicit statement.
- The A.4 validation report flags the units of $v_{glymph}$.
- A.6–A.8 use $k_c$ at capillary nodes, in $h_K(k_c)$ (T1.20) and in $s_c$ (T2.12), but never restate its dynamics.
- Aleph Invariant 9 uses $D_K$, $\tau_K$ and $h_K(k_c)$, which implies a reaction–diffusion K⁺ equation that is never written.

**Derivation status.** Phenomenological closure. The balance structure is standard. Linear uptake gated by $m(e)$ and the release law are modelling choices. The equation has not been restated since A.5 (domain-based); the node re-indexing and the diffusion term are reconstructions.

---

## T2.14: Pericyte/capillary relaxation state and capillary radius (inherited: A.8 Tier 2 inline)

**Equation as stated in the latest source** (`Model_A8_model only.docx`, inline; A.6 Eqs. 13–14):

$$
\tau_\psi\frac{d\psi_c}{dt} = -\psi_c + q_c, \qquad r_e = r_0\left(1 + \beta_c\,\bar\psi_e\right)
$$

A.8 adds that "mechanical compliance is stabilized via a reflected Ornstein–Uhlenbeck process ensuring radii remain within biological boundaries ($r_e\in[r_{min},r_{max}]$)". The A.8 PDF calls it a "damped reflected Ornstein–Uhlenbeck process". No formula is given.

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $\psi_c$ | capillary or pericyte relaxation state at node $c$ (clashes with salience $\psi$ in T6.4) | dimensionless |
| $q_c$ | neuro-glial messenger drive (A.6: local neural or glutamate activity; Aleph claims lactate, T3.14) | dimensionless |
| $\tau_\psi$ | time constant (1.2 s, A.6) | s |
| $r_0$ | capillary baseline radius (rat 2.2 µm) | m |
| $\beta_c$ | dilation gain (0.07, Hall 2014 as cited; clashes with the capture gain $\beta_c$ in T6.8) | dimensionless |
| $\bar\psi_e$ | average of $\psi$ over segment $e$ (averaging rule not stated) | dimensionless |
| $r_{min}$, $r_{max}$ | radius bounds | m |

**Physical starting point.** A first-order (single-pole) low-pass filter of a vasoactive messenger, a linear radius response (the linearized wall mechanics of T2.9 Steps 1–8 with pericyte tone in place of smooth-muscle tone), and, for the compliance noise, a reflected Ornstein–Uhlenbeck (OU) diffusion (Skorokhod reflection). Assumptions:

- A1. Messenger production and removal are first-order, with one time constant $\tau_\psi$.
- A2. Radius responds linearly and instantaneously to $\psi$ (no wall lag on the capillary scale).
- A3. The segment value is the mean of the two endpoint nodes: $\bar\psi_e = (\psi_c + \psi_{c'})/2$, a proposal.
- A4. Radius fluctuations are mean-reverting Gaussian noise about the deterministic target, reflected at $r_{min}$ and $r_{max}$.

**Derivation**

**Step 1 (first-order kinetics).** Let the messenger be produced at a rate proportional to the drive, $k_pq_c$, and removed at rate $k_r\psi_c$: $d\psi_c/dt = k_pq_c - k_r\psi_c$. Scale $\psi$ so that $k_p = k_r$ and set $\tau_\psi = 1/k_r$:

$$
\tau_\psi\frac{d\psi_c}{dt} = -\psi_c + q_c .
$$

**Step 2 (general solution).** Divide by $\tau_\psi$ and multiply by the integrating factor $e^{t/\tau_\psi}$, which gives $\frac{d}{dt}\left(\psi_ce^{t/\tau_\psi}\right) = \frac{q_c}{\tau_\psi}e^{t/\tau_\psi}$. Integrate from 0 to $t$:

$$
\psi_c(t) = \psi_c(0)\,e^{-t/\tau_\psi} + \frac{1}{\tau_\psi}\int_0^te^{-(t-s)/\tau_\psi}\,q_c(s)\,ds .
$$

For a step drive $q_c = q_0$: $\psi_c(t) = q_0(1 - e^{-t/\tau_\psi}) + \psi_c(0)e^{-t/\tau_\psi}$. The transfer function is $1/(1+i\omega\tau_\psi)$.

**Step 3 (radius law).** Linearize the target radius in $\psi$ (A2), as in T2.9 Steps 6–8:

$$
r_e = r_0\left(1 + \beta_c\,\bar\psi_e\right),\qquad \beta_c = \frac{1}{r_0}\frac{\partial r_e}{\partial\bar\psi_e}.
$$

With A3, $\bar\psi_e = (\psi_c+\psi_{c'})/2$.

**Step 4 (conductance consequence).** By T2.7, $G_e/G_{e0} = (1 + \beta_c\bar\psi_e)^4$. At $\bar\psi_e = 1$, $1.07^4 = 1.311$: a 31% rise in segment conductance for a 7% dilation.

**Step 5 (reflected OU process; supplied, not in any source).** Let $r^\ast(t) = r_0(1+\beta_c\bar\psi_e(t))$ be the deterministic target from Step 3. Write

$$
dr_e = \theta_r\,(r^\ast - r_e)\,dt + \sigma_r\,dW_t + dL_t - dU_t ,
$$

where $W_t$ is a standard Wiener process. $L_t$ and $U_t$ are the minimal non-decreasing processes that increase only when $r_e = r_{min}$ and $r_e = r_{max}$ respectively (Skorokhod reflection). They keep $r_e\in[r_{min},r_{max}]$ for all $t$.

**Step 6 (Fokker–Planck equation).** For constant $r^\ast$, the density $p(r,t)$ obeys

$$
\frac{\partial p}{\partial t} = -\frac{\partial}{\partial r}\left[\theta_r(r^\ast - r)\,p\right] + \frac{\sigma_r^2}{2}\frac{\partial^2p}{\partial r^2},
$$

with zero-flux (reflecting) conditions $\theta_r(r^\ast-r)p - \frac{\sigma_r^2}{2}\partial_rp = 0$ at $r_{min}$ and $r_{max}$.

**Step 7 (stationary density).** In steady state the flux is constant, and it is zero because it vanishes at the boundaries. So $\theta_r(r^\ast - r)p = \frac{\sigma_r^2}{2}p'$, which gives $p'/p = (2\theta_r/\sigma_r^2)(r^\ast - r)$. Integrate:

$$
p_\infty(r) = \frac{1}{Z}\exp\!\left(-\frac{\theta_r(r - r^\ast)^2}{\sigma_r^2}\right),\quad r\in[r_{min},r_{max}],\qquad Z = \int_{r_{min}}^{r_{max}}\exp\!\left(-\frac{\theta_r(r - r^\ast)^2}{\sigma_r^2}\right)dr .
$$

This is a Gaussian of variance $\sigma_r^2/(2\theta_r)$, truncated to the bounds.

**Step 8 (the "damped OU with vessel inertia" of A.8; proposal).** A second-order Langevin form $m_w\ddot r + \gamma_w\dot r + k_w(r - r^\ast) = \sigma\xi(t)$ reduces in the overdamped limit $m_w\to 0$ to Step 5, with $\theta_r = k_w/\gamma_w$ and $\sigma_r = \sigma/\gamma_w$. This connects the A.8 wording to the OU form.

**Result.** The ψ equation is a first-order low-pass filter (exact as stated, given A1). The radius law is a linear-response closure. Both match A.6 and A.8. The reflected OU process that A.7 and A.8 name is never written; it is supplied in Steps 5–7. The deterministic radius of Step 3 is then the mean target $r^\ast$ of the OU process, which reconciles the two statements in A.8 (an algebraic $r_e$ and a stochastic $r_e$).

**Checks**

- *Dimensions.* $\psi$ and $q$ are dimensionless, $\tau_\psi$ is in s, and $\beta_c\bar\psi$ is dimensionless, so $r_e$ has the units of $r_0$. For the OU process, $\theta_r$ is in s⁻¹ and $\sigma_r$ in $\mathrm{m\,s^{-1/2}}$.
- *Limits.* For $q_c = 0$, $\psi_c\to 0$ and $r_e\to r_0$. As $\sigma_r\to 0$ the OU process collapses to $r_e\to r^\ast$. As $r_{min}\to-\infty$ and $r_{max}\to\infty$ it becomes the untruncated OU process.
- *Calibration.* $\beta_c = 0.07$ reproduces Hall 2014's 6.7% capillary dilation for $\bar\psi\approx 1$ (A.6). A.8 reports that capillary dilation contributes only 4.2% of the total flow increase, despite the 31% local conductance rise of Step 4. This is consistent with a network in which arteriolar resistance dominates (Hill 2015, as cited in A.8). It is a network result (T2.1 Step 16), not a local one.

**Lineage**

- A.6 Eqs. 13–14 (`Model A.6 four-caveat revision...docx`): introduced, with $\tau_\psi = 1.2$ s, $\beta_c = 0.07$ and $q_c$ = local neural or glutamate activity.
- A.7 Eqs. 13–14 (`Model A.7 with all equations.docx`, `model A.7 maths.docx`, `Model A.7 More scientific Doc (gemini).docx`): unchanged; "reflected Ornstein–Uhlenbeck" is named.
- A.8 (`Model_A8_model only.docx`, A.8 PDF): inline; "damped reflected OU with mechanical vessel inertia" is named; the 4.2% open-failure note is added.
- Aleph (A.10.1) claims a direct astrocytic-lactate → pericyte coupling (T3.14), which would redefine $q_c$, but gives no formula.

**Derivation status.** Phenomenological closure. The low-pass filter and the linear radius law are modelling choices calibrated on Hall 2014 (as cited). The reflected OU process is incomplete in source; the form supplied in Steps 5–8 is a standard construction labelled as a proposal.

---

## T2.15: Normalized node flow (input to GLUT1 and O₂ delivery) (inherited: A.6/A.7 Eq. 10)

**Equation as stated in the latest source** (A.7 Eq. 10, `Model A.7 with all equations.docx`; A.6 Eq. 10; A.8 writes only $f = F/F_0$):

$$
f_c = \frac{F_c}{F_{c,0}}, \qquad F_c = \frac{1}{2}\sum_{e\ni c}\lvert q_e\rvert
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $f_c$ | normalized flow at node $c$ (input to T3.5 and T3.6) | dimensionless |
| $F_c$ | throughflow of node $c$ | m³ s⁻¹ |
| $F_{c,0}$ | resting throughflow (same network, resting radii) | m³ s⁻¹ |
| $q_e$ | flow in edge $e$ from T2.1, $q_e = G_e(p_c - p_{c'})$ | m³ s⁻¹ |
| $Q^{bd}_c$ | flow exchanged with a reservoir or source at a boundary node | m³ s⁻¹ |

**Physical starting point.** The node balance of T2.1, with throughflow defined as the volume per unit time that passes through a node. This is an identity, not a model.

Assumptions:

- A1. The flows satisfy T2.1 Step 8.
- A2. The throughflow is the total inflow, which equals the total outflow.

**Derivation**

**Step 1 (split the incident edges).** For node $c$, let $\mathcal O_c$ be the incident edges with $q_{e,c\to c'}>0$ (outflow) and $\mathcal I_c$ those with $q_{e,c\to c'}<0$ (inflow). Define

$$
\mathrm{Out}_c = \sum_{e\in\mathcal O_c}q_{e,c\to c'},\qquad \mathrm{In}_c = \sum_{e\in\mathcal I_c}\lvert q_{e,c\to c'}\rvert .
$$

**Step 2 (sum of absolute values).** Every incident edge falls in exactly one of the two sets, or carries zero flow:

$$
\sum_{e\ni c}\lvert q_e\rvert = \mathrm{Out}_c + \mathrm{In}_c .
$$

**Step 3 (interior conservation).** At an interior node, T2.1 Step 5 gives $\sum_{e\ni c}q_{e,c\to c'} = \mathrm{Out}_c - \mathrm{In}_c = 0$, so $\mathrm{Out}_c = \mathrm{In}_c$.

**Step 4 (half-sum identity).** Substitute Step 3 into Step 2:

$$
\frac12\sum_{e\ni c}\lvert q_e\rvert = \frac12(\mathrm{Out}_c + \mathrm{In}_c) = \mathrm{Out}_c = \mathrm{In}_c = F_c .
$$

At interior nodes, the source formula is exactly the throughflow.

**Step 5 (boundary nodes).** At a root node with inflow $Q^{bd}_c = c_ar_a^4(P_a - p_c)>0$ and no source, T2.1 Step 8 gives $\mathrm{Out}_c - \mathrm{In}_c = Q^{bd}_c$. The true throughflow is the total inflow, $F_c = \mathrm{In}_c + Q^{bd}_c = \mathrm{Out}_c$. The source formula gives instead

$$
\frac12\sum_{e\ni c}\lvert q_e\rvert = \frac12\left(\mathrm{Out}_c + \mathrm{Out}_c - Q^{bd}_c\right) = F_c - \frac12Q^{bd}_c .
$$

So it underestimates the throughflow by half the boundary flow. The same holds at venule nodes, with the outflow $G_vp_c$ in place of $Q^{bd}_c$.

**Step 6 (general form).** Count every exchange of the node: edges, reservoir links and sources. Total inflow equals total outflow, so the sum of the absolute values of all exchanges is twice the throughflow:

$$
F_c = \frac12\left[\sum_{e\ni c}\lvert q_e\rvert + c_ar_a^4\lvert P_a - p_c\rvert\,\mathbf 1_{c\in Art} + G_v\lvert p_c\rvert\,\mathbf 1_{c\in Ven} + \lvert s_c\rvert\right].
$$

At interior nodes this reduces to the source formula.

**Result.** At interior nodes, $F_c = \frac12\sum\lvert q_e\rvert$ is an exact consequence of T2.1, and $f_c$ is its ratio to rest. At boundary nodes the source formula undercounts by half the boundary flow; the corrected general form is Step 6. Two further points need care: $F_{c,0} = 0$ (a stagnant or stalled node at rest) makes $f_c$ undefined, and a guard such as $f_c = 1$ when $F_{c,0} = 0$ must be stated.

**Checks**

- *Dimensions.* $F_c$ is in m³ s⁻¹ and $f_c$ is dimensionless; $f_c = 1$ at rest by construction.
- *Chain example (T2.1 Checks).* In the two-node chain, the root node has edge flow $Q$ and boundary inflow $Q$. The half-sum formula gives $Q/2$, while the true throughflow is $Q$. Step 6 gives $\frac12(Q + Q) = Q$.
- *Downstream use.* In T3.5, $J_G = T_G[1+\gamma_G(f-1)]\ldots$, and in T3.6, $E(f) = 1-(1-E_0)^{1/f}$ needs $f>0$. A node whose resting flow is positive but whose current flow is zero (a stalled neighbourhood, T2.5) gives $f = 0$ and $E(0^+) = 1$, which is the correct limit of full extraction.

**Lineage**

- A.6 Eq. 10 (`Model A.6 four-caveat revision...docx`): introduced.
- A.7 Eq. 10 (`Model A.7 with all equations.docx`; `Model A.7 More scientific Doc (gemini).docx` gives only $f_c = F_c/F_{c,0}$): unchanged.
- A.8 (A.8 PDF; `Model_A8_Scientific_Report.docx`): only $f = F/F_0$, inside the Buxton extraction.
- Aleph: inherited implicitly through T3.5 and T3.6.

**Derivation status.** Exact (definition plus the Kirchhoff identity of Step 4). The formula as printed is exact only at interior nodes; the boundary-node correction is derived in Step 6.

---

## T2.16: Perivascular (glymphatic) flux driven by vessel-wall motion (inherited: A.10 Eq. 2.3, from A.9)

**Equation as stated in the latest source** (A.10 Eq. 2.3, `Model_A10_Comprehensive_Scientific_Report.docx`; identical in A.9):

$$
J_v(t) = \frac{1}{R_{PVS}}\int\left\lvert\frac{\partial r_e(t)}{\partial t}\right\rvert dt
$$

A.9 says that "fluid velocity $v$ is derived from the perivascular flow rate $J_v$", but gives no conversion.

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $J_v$ | perivascular flow rate | m³ s⁻¹ (required for a flow) |
| $R_{PVS}$ | hydraulic resistance of the perivascular space (PVS) | Pa s m⁻³ |
| $r_e$ | vessel (inner PVS wall) radius (T2.10) | m |
| $r_o$ | outer PVS radius (glia limitans), assumed fixed | m |
| $\ell$ | length of the vessel segment | m |
| $\varepsilon$ | rectification fraction (net forward fraction of displaced flow) | dimensionless |
| $L_p$ | trans-astrocytic hydraulic conductivity (T6.2) | m Pa⁻¹ s⁻¹ |
| $S_{ef}$ | endfoot sheath area | m² |

**Physical starting point.** The kinematics of incompressible fluid displaced by a moving wall (volume conservation), Stokes flow in an annulus for the PVS resistance, and peristaltic-pumping theory, in which net transport needs a rectifying asymmetry (Shapiro, Jaffrin & Weinberg 1969). The printed form has no derivation in any source. Assumptions:

- A1. The PVS is an annulus between the moving vessel wall at $r_e(t)$ and a fixed outer wall at $r_o$, filled with incompressible fluid.
- A2. Within one segment the wall motion is uniform along $\ell$, with long-wavelength motion only.
- A3. Net (time-averaged) flow arises only from a rectifying asymmetry, represented by a fraction $\varepsilon\in[0,1]$. With constant linear resistances and reversible wall motion, the net flow is zero (Step 4).
- A4. The flow in the PVS is Stokes (Poiseuille-like) flow.

**Derivation**

**Step 1 (units of the printed form).** $\int\lvert\partial_tr_e\rvert dt$ is a length (m): the total variation of the radius. Dividing by $R_{PVS}$ (Pa s m⁻³) gives

$$
\left[\frac{1}{R_{PVS}}\int\lvert\dot r_e\rvert dt\right] = \frac{\mathrm m}{\mathrm{Pa\,s\,m^{-3}}} = \mathrm{m^4\,Pa^{-1}\,s^{-1}} \neq \mathrm{m^3\,s^{-1}} .
$$

The printed $J_v$ is not a flow. Moreover, an indefinite integral of $\lvert\dot r_e\rvert$ grows without bound under sustained oscillation, so $J_v(t)$ could not reach a stationary value.

**Step 2 (volume displaced by the wall).** By A1, the PVS volume of the segment is $V_{pvs} = \pi(r_o^2 - r_e^2)\ell$. Differentiate in time ($r_o$ and $\ell$ are fixed):

$$
\frac{dV_{pvs}}{dt} = -2\pi r_e\ell\,\frac{dr_e}{dt}.
$$

Incompressibility requires the net flow out through the segment ends to equal $-dV_{pvs}/dt$. The magnitude of the displaced flow is therefore

$$
Q_{disp}(t) = 2\pi r_e\ell\,\lvert\dot r_e\rvert .
$$

**Step 3 (split between the two ends).** Let the segment connect to an upstream reservoir through resistance $R_u$ and to a downstream one through $R_d$, both at the same pressure. A displaced flow $Q$ leaving the segment splits in inverse proportion to the resistances, $Q_d = Q\,R_u/(R_u+R_d)$ and $Q_u = Q\,R_d/(R_u+R_d)$. The net forward part is

$$
Q_d - Q_u = Q\,\frac{R_u - R_d}{R_u + R_d}.
$$

**Step 4 (no net flow without rectification).** If $R_u$ and $R_d$ are constant, the same split applies when the wall moves back and fluid is drawn in. The net forward flow is then $\frac{R_u-R_d}{R_u+R_d}\left(-\frac{dV_{pvs}}{dt}\right)$, and since $-dV_{pvs}/dt = 2\pi r_e\ell\,\dot r_e = \pi\ell\,\frac{d(r_e^2)}{dt}$, its average over a period is proportional to $\langle d(r_e^2)/dt\rangle$, which vanishes for periodic motion. Net transport therefore needs a time-dependent asymmetry: a travelling wave, valve-like endfoot gaps, or resistances that change with the wall position. That is the physics A3 summarizes in $\varepsilon$. In lubrication theory of peristalsis, the net flow of a travelling wave is of second order in the amplitude ratio (Shapiro et al. 1969). A rectified first-order law is therefore an upper-bound closure.

**Step 5 (rectified mean flow).** With A3, the period-averaged net flow over $T = 2\pi/\omega_{LC}$ is

$$
\bar J_v = \varepsilon\,\frac{1}{T}\int_{t-T}^{t}2\pi r_e\ell\,\lvert\dot r_e\rvert\,dt' .
$$

**Step 6 (sinusoidal wall motion).** With $r_e = \bar r + \lvert A\rvert\cos\omega t$ (T2.10 Step 6), $\lvert\dot r_e\rvert = \lvert A\rvert\omega\lvert\sin\omega t\rvert$, whose period mean is $\frac{2}{\pi}\lvert A\rvert\omega$. To first order in $\lvert A\rvert/\bar r$:

$$
\bar J_v = \varepsilon\,2\pi\bar r\ell\cdot\frac{2}{\pi}\lvert A\rvert\omega = 4\varepsilon\,\bar r\,\ell\,\omega\,\lvert A\rvert .
$$

Insert the vasomotion amplitude from T2.10, $\lvert A\rvert = \kappa_{NE}\rho^\ast r_{a0}/\sqrt{1+(\omega\tau_v)^2}$ with $\rho^\ast = \sqrt{\lambda_{eff}}$ (T2.2):

$$
\bar J_v = 4\varepsilon\,\bar r\,\ell\,\omega_{LC}\,\frac{\kappa_{NE}\sqrt{\lambda_{LC} - g_{GABA} - g_{\alpha2}}\;r_{a0}}{\sqrt{1+(\omega_{LC}\tau_v)^2}} .
$$

This chain (LC amplitude → wall velocity → displaced volume) is the one the A.9 and A.10 prose describes. It gives zero flux when the LC oscillation collapses (zolpidem, $\lambda_{eff}\le 0$).

**Step 7 (form that keeps $R_{PVS}$; proposal).** If the wall is regarded as a pressure source rather than a prescribed displacement, a wall impedance $Z_w$ (Pa s m⁻¹) converts wall velocity into pumping pressure, $\Delta p_w = Z_w\lvert\dot r_e\rvert$. Then

$$
\bar J_v = \varepsilon\,\frac{Z_w}{R_{PVS}}\,\frac{1}{T}\int_{t-T}^{t}\lvert\dot r_e\rvert\,dt'\qquad\left[\frac{\mathrm{Pa\,s\,m^{-1}}\cdot\mathrm{m\,s^{-1}}}{\mathrm{Pa\,s\,m^{-3}}} = \mathrm{m^3\,s^{-1}}\right].
$$

This is the minimal repair that keeps the printed structure $(1/R_{PVS})\int\lvert\dot r_e\rvert$: replace the indefinite integral by a period mean and add the missing factor $Z_w$.

**Step 8 (PVS resistance of an annulus).** Under A4, the axial velocity $u(\varrho)$ for $r_e<\varrho<r_o$ satisfies $\frac{1}{\varrho}(\varrho u')' = -\Delta p/(\eta\ell)\equiv -\mathcal G$.

- Integrate twice: $u = -\mathcal G\varrho^2/4 + A_1\ln\varrho + B_1$.
- No slip at both walls, $u(r_e) = u(r_o) = 0$. Subtracting the two conditions gives $A_1 = \mathcal G(r_o^2 - r_e^2)/(4\ln(r_o/r_e))$.
- Integrate $Q = \int_{r_e}^{r_o}2\pi\varrho u\,d\varrho$, using $\int\varrho\ln\varrho\,d\varrho = \frac{\varrho^2\ln\varrho}{2} - \frac{\varrho^2}{4}$ and $B_1 = \mathcal Gr_e^2/4 - A_1\ln r_e$, and collect terms:

$$
Q = \frac{\pi\,\Delta p}{8\eta\ell}\left[r_o^4 - r_e^4 - \frac{(r_o^2 - r_e^2)^2}{\ln(r_o/r_e)}\right]\quad\Longrightarrow\quad R_{PVS} = \frac{8\eta\ell}{\pi\left[r_o^4 - r_e^4 - (r_o^2-r_e^2)^2/\ln(r_o/r_e)\right]} .
$$

$R_{PVS}$ depends on $r_e(t)$, so wall motion modulates the resistance. That modulation is one physical source of the rectification in A3.

**Step 9 (link to $L_p$; proposal).** $L_p$ (T6.2) is a membrane (endfoot) conductivity for flow across the astrocytic sheath, not along the PVS. A resistance that "depends on $L_p$" is consistent only as a series combination of the axial PVS resistance and the trans-endfoot resistance:

$$
R_{PVS}^{tot} = R_{PVS} + \frac{1}{L_p\,S_{ef}} .
$$

With the T6.2 floor $L_p\ge L_{p,min}>0$, $R_{PVS}^{tot}\le R_{PVS} + 1/(L_{p,min}S_{ef})$ stays finite. This is the "hydraulic floor prevents $R_{PVS}\to\infty$" statement of A.10 and Aleph.

**Step 10 (velocity for the Péclet number).** The mean fluid velocity is the flow divided by the open cross-section:

$$
v = \frac{\bar J_v}{\pi(r_o^2 - \bar r^2)}\quad\text{(open annulus)},\qquad v = \frac{\bar J_v}{\phi_{pvs}\,\pi(r_o^2-\bar r^2)}\quad\text{(porous PVS of porosity }\phi_{pvs}\text{, interstitial velocity)}.
$$

**Result.** The printed equation is dimensionally inconsistent (m⁴ Pa⁻¹ s⁻¹, not m³ s⁻¹) and grows without bound in time, because it uses an indefinite integral (Step 1). It cannot be derived as written. Two dimensionally consistent repairs are derived:

- a kinematic displacement form, which needs no $R_{PVS}$:

$$
\bar J_v = \varepsilon\,\frac{1}{T}\int_{t-T}^{t}2\pi r_e\ell\,\lvert\partial_tr_e\rvert\,dt' ;
$$

- a pressure-source form that keeps the printed structure, $\bar J_v = \varepsilon(Z_w/R_{PVS})\langle\lvert\partial_tr_e\rvert\rangle_T$ (Step 7).

Also supplied: the annulus $R_{PVS}$ (Step 8), its series link to $L_p$ (Step 9) and the $J_v\to v$ conversion (Step 10). Physically, any net flow requires a rectifying asymmetry (Step 4); without one, reversible wall motion produces no net flux.

**Checks**

- *Dimensions.* Printed: m⁴ Pa⁻¹ s⁻¹ (fails). Step 5: m·m·m s⁻¹ = m³ s⁻¹. Step 7: m³ s⁻¹. Step 8: $R_{PVS}$ is (Pa s)(m)/(m⁴) = Pa s m⁻³.
- *Limits.* $\varepsilon = 0$ or $\dot r_e = 0$ gives $\bar J_v = 0$. LC collapse ($\lambda_{eff}\le 0$) gives $\bar J_v = 0$, the zolpidem prediction, in the observed direction (Hauglund 2025, as cited).
- *Annulus limits.*
  - As $r_e\to 0$, the bracket becomes $r_o^4$ (because $(r_o^2)^2/\ln(r_o/r_e)\to 0$), which recovers the Poiseuille tube $Q = \pi r_o^4\Delta p/(8\eta\ell)$.
  - As $r_o\to r_e$ (thin gap of width $w$, with $\ln(r_o/r_e)\approx w/r_e - w^2/(2r_e^2) + w^3/(3r_e^3)$), the bracket goes to $\frac{4}{3}r_e\,w^3$. This recovers the plane-slit law $Q = \frac{2\pi r_e\,w^3}{12\eta\ell}\Delta p$.
- *Invariant $\Phi_{peristalsis}$ (Aleph Sec. 9.1).* $r_{a0}^4/(8\eta R_{PVS}D)$ has units m⁴/[(Pa s)(Pa s m⁻³)(m² s⁻¹)] = m⁵ Pa⁻² s⁻¹. If $\kappa_{stiff}C_{amyloid}$ is dimensionless, the invariant is not dimensionless, so comparing it with 1.0 is not meaningful as printed.

**Lineage**

- A.5 to A.8: glymphatic flow is the phenomenological velocity $v_{glymph}$ (T6.16).
- A.9 (`Model_A9_changes from a8.docx`, equation image) introduces $J_v = (1/R_{PVS})\int\lvert\partial_tr_e\rvert dt$ and says that $v$ is derived from it, with no conversion.
- A.10 Eq. 2.3: identical, printed together with $Pe$.
- The Aleph lineage table: A.10 "coupled autonomic brainstem limit cycle to perivascular flux $J_v(t)$; added hydraulic bounds".
- No source derives the form. No source says whether $v_{glymph}$ is retired.

**Derivation status.** Incomplete in source. The printed form is dimensionally inconsistent, has no stationary value, and lacks the $J_v\to v$ and $R_{PVS}\leftrightarrow L_p$ links. The repaired forms (Steps 5–10) are Reconstructed from volume conservation and Stokes flow, and the rectification fraction $\varepsilon$ is a phenomenological closure.

---

## T2.17: Péclet number for perivascular advection versus diffusion (inherited: Aleph Sec. 3.2 / A.10 Eq. 2.3)

**Equation as stated in the latest source** (Aleph Sec. 3.2, "Péclet Advective-Diffusive Fluid Dynamics"; A.10 Eq. 2.3; A.9):

$$
Pe = \frac{v\,L}{D}
$$

**Symbols and units**

| Symbol | Meaning | Units |
|---|---|---|
| $Pe$ | Péclet number | dimensionless |
| $v$ | characteristic perivascular fluid speed (from $J_v$, T2.16 Step 10) | m s⁻¹ |
| $L$ | transport length (not specified in any source) | m |
| $D$ | solute diffusivity in the PVS or interstitium | m² s⁻¹ |
| $c$ | solute concentration | mol m⁻³ |

**Physical starting point.** Conservation of a passive solute transported by an incompressible flow, with Fickian diffusion: the advection–diffusion equation. Assumptions:

- A1. The solute is dilute and passive (it does not affect the flow), and is neither produced nor consumed in the region considered.
- A2. The flow is incompressible: $\nabla\cdot\mathbf v = 0$.
- A3. Fick's law holds, $\mathbf j_{diff} = -D\nabla c$, with constant $D$.
- A4. The flow field and the geometry have single characteristic scales $U$ and $L$.

**Derivation**

**Step 1 (conservation law).** The concentration changes by the divergence of the total (advective plus diffusive) flux:

$$
\frac{\partial c}{\partial t} + \nabla\cdot\left(c\,\mathbf v - D\nabla c\right) = 0 .
$$

**Step 2 (simplify with A2 and A3).** $\nabla\cdot(c\mathbf v) = \mathbf v\cdot\nabla c + c\,\nabla\cdot\mathbf v = \mathbf v\cdot\nabla c$, and $\nabla\cdot(D\nabla c) = D\nabla^2c$:

$$
\frac{\partial c}{\partial t} + \mathbf v\cdot\nabla c = D\nabla^2c .
$$

**Step 3 (scales).** Set $\mathbf x = L\tilde{\mathbf x}$, $\mathbf v = U\tilde{\mathbf v}$ and $t = (L^2/D)\tilde t$ (diffusive time scale). Then $\nabla = L^{-1}\tilde\nabla$ and $\partial_t = (D/L^2)\partial_{\tilde t}$.

**Step 4 (substitute).**

$$
\frac{D}{L^2}\frac{\partial c}{\partial\tilde t} + \frac{U}{L}\tilde{\mathbf v}\cdot\tilde\nabla c = \frac{D}{L^2}\tilde\nabla^2c .
$$

**Step 5 (multiply by $L^2/D$).**

$$
\frac{\partial c}{\partial\tilde t} + \frac{UL}{D}\,\tilde{\mathbf v}\cdot\tilde\nabla c = \tilde\nabla^2c,\qquad Pe\equiv\frac{UL}{D}.
$$

With $U = v$, this is the Aleph definition.

**Step 6 (time-scale form).** The diffusion time over $L$ is $t_{diff} = L^2/D$ and the advection time is $t_{adv} = L/v$. Their ratio is

$$
\frac{t_{diff}}{t_{adv}} = \frac{L^2/D}{L/v} = \frac{vL}{D} = Pe .
$$

$Pe>1$ means that advection carries solute across $L$ faster than diffusion does.

**Step 7 (advective scaling, equivalently).** With $t = (L/U)\tilde t$ instead, Step 5 becomes $\partial_{\tilde t}c + \tilde{\mathbf v}\cdot\tilde\nabla c = Pe^{-1}\tilde\nabla^2c$. Diffusion is then a small correction when $Pe\gg 1$.

**Result.** $Pe = vL/D$ is exact as a definition: it is the single dimensionless group of the advection–diffusion equation (Step 5). It matches Aleph Sec. 3.2. The source leaves three things open:

1. $L$ is unspecified (PVS segment length, inter-vessel distance or tissue depth), and $Pe$ scales linearly with it.
2. $v$ must be the period-averaged *net* velocity (T2.16 Steps 5 and 10), not the oscillatory peak velocity.
3. $Pe$ alone does not establish net clearance (Checks).

**Checks**

- *Dimensions.* (m s⁻¹)(m)/(m² s⁻¹) is dimensionless.
- *Reported values.* $Pe$ 0.42 (wake) → 2.85 (NREM) (Aleph test #54; A.10). With $L$ and $D$ unchanged, the ratio $2.85/0.42 = 6.79$ is the implied increase of the net perivascular speed from wake to NREM. Through T2.16 Step 6, $v\propto\varepsilon\,\omega_{LC}\,\kappa_{NE}\sqrt{\lambda_{eff}}/\sqrt{1+(\omega_{LC}\tau_v)^2}$, so this ratio constrains how $\lambda_{eff}$ (and $\varepsilon$) differ between the two states.
- *Oscillatory flow.* Zero-mean oscillatory flow gives no net advection, but it can enhance dispersion (Taylor 1953; Aris 1956). For steady Poiseuille flow in a tube of radius $a$, $D_{eff} = D\left(1 + Pe_a^2/48\right)$ with $Pe_a = \bar va/D$. A large oscillatory $Pe$ therefore signals enhanced mixing, not directional clearance.
- *Limits.* $Pe\to 0$ is pure diffusion. $Pe\to\infty$ is pure advection, with boundary layers of relative thickness $Pe^{-1/2}$ or $Pe^{-1/3}$ depending on the geometry.

**Lineage**

- A.9 (`Model_A9_changes from a8.docx`) introduces $Pe$ inline, replacing the Boolean clearance gate; $L$ and $D$ are not defined.
- A.10 Eq. 2.3 prints it with $J_v$.
- Aleph Sec. 3.2 (both Aleph files) gives it as the "Péclet advective-diffusive" law.
- `Model_Aleph_Equation_Derivations_GPT.docx` §8.3 gives the time-scale ratio.

**Derivation status.** Exact (definition, from nondimensionalizing the advection–diffusion equation). Its interpretation as a clearance measure needs the net velocity of T2.16 and a stated $L$.

---

## Cross-cutting issues for this tier

1. **The neural source in Kirchhoff (T2.1)** is the most consequential defect. It is not a flow dimensionally, and it injects blood volume. The derived alternative, in which activity acts through conductances (T2.1 Step 16), reproduces linear NVC without either problem.
2. **Radius bookkeeping.** T2.4, T2.5, T2.9, T2.10 and T2.14 all act on radii or conductances, and no source states how they compose. The overview gives a minimal rule.
3. **Units of $NE_{LC}$, $v_{glymph}$ and $J_v$.** The normalized LC amplitude (T2.2 Step 7), the dimensionless washout group in T2.13 and the perivascular flux of T2.16 each use one symbol with inconsistent units across versions.
4. **Shear in stalled edges (T2.5).** Using the flow-based $\tau_w$ makes stalls absorbing; the pressure-based $\tau_w = r\Delta p/(2\ell)$ of T2.8 removes this.
5. **Missing closures.** Six functions or processes are never specified: $I_{NsMJ}$, $\mathcal F_{A2B}$ (T2.9), the reflected OU process (T2.14), the diffusion equation for $\Phi$ (T2.6), the $J_v\to v$ conversion (T2.16) and the inter-node K⁺ diffusion (T2.13). The forms supplied here are labelled proposals or reconstructions.
6. **Lean coverage.** Only Poiseuille positivity and the basal arteriole equilibrium are proved in Lean, and the Lean `dr_a_dt` omits $1/A_K$. The Kirchhoff SPD theorem is announced but missing; T2.1 Steps 10–11 supply the proof.
