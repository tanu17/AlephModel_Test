# Tier 1: Membrane electrophysiology and pharmacodynamics

## Overview

Tier 1 is the neuron layer of Aleph 1 (Model A.10.1). It turns synaptic input, pharmacological input and metabolic state into a firing rate $r_i$ for every neuron or node $i$. It also keeps the intracellular Na$^+$ account that sets the energy cost of that activity. Aleph 1 prints five Tier 1 operators (Eqs. 5.1-5.5). The other entries in this file are closures of Eq. 5.1 and the inherited components that the Aleph lineage table says are still active: the Black-Leff operational model, the Gq-PLC-IP3-Ca$^{2+}$ cascade, receptor internalization, the dendritic potential, the sodium debt ledger and the firing-rate transfer function.

How the entries fit together:

- **Soma and dendrite.** The somatic potential (T1.1) is closed by the K_ATP conductance (T1.6), the adaptation variable (T1.8), the presynaptic resource (T1.9) and the axial/ephaptic current (T1.7). The dendrite (T1.10) receives the same axial current with the opposite sign. It carries the dCaAP generator (T1.11, with the floating threshold T1.17), the dopamine-gated HCN shunt (T1.12), and the pharmacologically resolved synaptic currents: NMDA with Woodhull block (T1.2) and GABA_A with allosteric modulation (T1.3).
- **Receptor signalling.** The Black-Leff operational model (T1.13) feeds receptor internalization (T1.14) and Gq-driven IP3 production (T1.15). IP3 drives cytosolic Ca$^{2+}$ (T1.16) and lowers the dCaAP threshold (T1.17).
- **Rate and energy.** The rate law (T1.20) reads the somatic potential, the fast homeostatic threshold (T1.21), adaptation (T1.8), the AIS shift $\theta_{AIS,i}$ (T4.5), extracellular K$^+$ $k_c$ (T2.13) and the Na$^+$ load (T1.18). The Na$^+$ load is cleared by the pump (T1.19).
- **Other operators.** Cx36 gap junctions (T1.4) couple PV interneurons; where the gap current enters (Tier 5 PV cells or the rate layer) is not stated. The transporter ledger (T1.5) sets extracellular monoamine levels, which feed dopamine (T1.12) and noradrenergic gain (T1.20).

Couplings to other tiers:

- **From Tier 3:** ATP $a_i$ enters $g_K$ (T1.6), the pump (T1.19) and the energy-scaled set point (T1.21).
- **To Tier 3:** pump flux $\Pi_i$ sets ATP demand $\Pi/3$ (T3.3).
- **To Tier 2:** firing rates drive the neurovascular source of the Kirchhoff balance (T2.1) and the K$^+$ load (T2.13).
- **To Tier 4:** activity drives the slow Ca$^{2+}$ proxy (T4.1).
- **From Tier 4:** the AIS shift returns through T1.20.
- **To and from Tier 5:** Tier 5 spiking events load the same Na$^+$ ledger (T5.5).
- **From Tier 6:** Tier 6 supplies the weights $W_{ij}$ (T6.4).

Conventions in this file:

- Membrane ionic currents are positive outward, so they appear with a minus sign in a current-balance equation. Synaptic, injected and axial currents are written as inward (depolarizing) sources.
- "Normalized form" means an equation divided by a reference (leak) conductance, so that every term carries voltage units.
- Source files are cited by name. "Reconstructed" marks a derivation step that no source contains; such steps are built from standard physics or chemistry, and the standard reference is named.

---

## T1.1: Somatic membrane potential with K_ATP metabolic brake (Aleph Eq. 5.1)

**Equation as stated in Aleph 1** (Model_Aleph_1_only equations.docx and Model_Aleph_1_Comprehensive_Scientific_Report.docx, Eq. 5.1; identical to A.10 Eq. 1.1 and A.8 PDF Eq. (1)):

$$
\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap}\, w_i\,(v_i - E_K) + G_s\,\zeta\,(1 - \nu_{ACh}) \sum_j \left[ s_j W_{ij} x_{ij} r_j(t - \tau_{ij}) \right] + G_s (1 + \nu_{ACh})\, I_i(t) + I_{ax,i}
$$

**Symbols and units.** Aleph 1 defines none of these symbols. The meanings below come from the A.8 sources (Model_A8_model only.docx; Model_A8_Scientific_Report.pdf). The units are those the normalized form requires (derived in Steps 9-11).

| Symbol | Meaning | Units (normalized form) |
|---|---|---|
| $v_i$ | somatic membrane potential of neuron or node $i$ | mV |
| $\tau_v$ | membrane time constant $C_s/g_L$ | ms |
| $v_{rest}$ | leak reversal, called "resting potential" (about -70 mV, A.8) | mV |
| $g_K(a_i)$ | K_ATP conductance relative to leak (T1.6) | dimensionless |
| $a_i$ | intracellular ATP | mM |
| $E_K$ | K$^+$ reversal (-85 mV, A.8) | mV |
| $g_{adap}$, $w_i$ | adaptation conductance scale and adaptation variable (T1.8); the product $g_{adap}w_i$ is relative to leak | product dimensionless |
| $G_s$ | baseline synaptic gain; A.8 calls it a "conductance" | mV s (charge per spike divided by $g_L$; see Step 10) |
| $\zeta$ | global synaptic scaling | dimensionless |
| $\nu_{ACh}$ | cholinergic tone, in $[0,1]$ | dimensionless |
| $s_j$ | Dale sign, $\pm 1$ | dimensionless |
| $W_{ij}$ | synaptic weight (T6.4) | dimensionless |
| $x_{ij}$ | releasable resource fraction (T1.9), in $[0,1]$ | dimensionless |
| $r_j$ | presynaptic rate (T1.20) | Hz |
| $\tau_{ij}$ | axonal delay | ms |
| $I_i(t)$ | feedforward input; its type is never stated | must be Hz for the printed $G_s$ to apply (Step 10) |
| $I_{ax,i}$ | axial plus ephaptic current divided by $g_L$ (T1.7) | mV |

**Physical starting point.** Charge conservation (Kirchhoff's current law) on the membrane capacitor of a single somatic compartment, as in Hodgkin-Huxley-type compartment models. Assumptions:

- A1. The soma is one isopotential compartment with constant capacitance $C_s$.
- A2. Leak, K_ATP and adaptation currents are Ohmic (linear in $V$), with reversals $v_{rest}$, $E_K$, $E_K$.
- A3. The adaptation conductance is proportional to a slow gating variable $w_i$ (T1.8).
- A4. Synaptic input is current-based and rate-coded. Each presynaptic spike injects a fixed charge with sign $s_j$. The driving-force dependence is frozen at an operating voltage, and spike trains are replaced by their rates.
- A5. Cholinergic tone scales recurrent input by $(1-\nu_{ACh})$ and feedforward input by $(1+\nu_{ACh})$. This is a phenomenological gain rule.
- A6. The axial current to the dendrite follows the two-compartment cable model (T1.7).
- A7. Every term is divided by the somatic leak conductance $g_L$.

**Derivation.**

1. *Charge balance.* The capacitive current equals the net current entering the compartment (A1). Ionic membrane currents are positive outward, and synaptic and axial currents are counted as inward sources:
$$
C_s \frac{dV_i}{dt} = -I_L - I_{KATP} - I_{adap} + I_{rec} + I_{ff} + I_{ax}^{phys}
$$

2. *Leak (A2).* Ohm's law with reversal $v_{rest}$:
$$
I_L = g_L\,(V_i - v_{rest})
$$

3. *K_ATP current (A2).* The physical conductance $G_{KATP}(a_i)$ is written as $g_L\,g_K(a_i)$, where $g_K$ is the dimensionless relative conductance of T1.6:
$$
I_{KATP} = g_L\,g_K(a_i)\,(V_i - E_K)
$$

4. *Adaptation current (A2, A3).* The slow K$^+$ conductance is linear in the gate, $G_{adap} = g_L\, g_{adap}\, w_i$, and shares the K$^+$ reversal:
$$
I_{adap} = g_L\, g_{adap}\, w_i\,(V_i - E_K)
$$

5. *Recurrent synaptic current as a spike-train sum (A4).* A spike of neuron $j$ at time $t^j_k$ reaches $i$ after delay $\tau_{ij}$ and delivers charge $Q_{ij} = s_j\,q_0\,\zeta\,W_{ij}\,x_{ij}$, spread over a normalized kernel $\kappa$ (with $\int_0^\infty \kappa(s)\,ds = 1$):
$$
I_{rec}(t) = \sum_j Q_{ij} \sum_k \kappa(t - t^j_k - \tau_{ij})
$$

6. *Rate (mean-field) replacement (A4).* Take the expectation over spike trains with instantaneous rate $r_j$. Campbell's theorem gives $\mathbb{E}\left[\sum_k \kappa(t - t_k - \tau)\right] = \int_0^\infty \kappa(s)\, r_j(t - \tau - s)\, ds$. If $r_j$ changes slowly compared with the kernel width, this integral equals $r_j(t-\tau_{ij})$, because $\int\kappa = 1$. Hence
$$
I_{rec}(t) = q_0\,\zeta \sum_j s_j W_{ij} x_{ij}\, r_j(t - \tau_{ij})
$$
This step also treats $x_{ij}$ as uncorrelated with the spike arrival. For Poisson trains this holds exactly (see T1.9).

7. *Why the current-based form is an approximation (A4).* A conductance-based synapse carries $g_{syn,ij}(t)\,(E_{syn,j} - V_i)$. Write $V_i = \bar V + (V_i - \bar V)$:
$$
g_{syn,ij}(t)\,(E_{syn,j} - V_i) = g_{syn,ij}(t)\,(E_{syn,j} - \bar V) - g_{syn,ij}(t)\,(V_i - \bar V)
$$
The first term is a current with fixed sign $s_j = \mathrm{sgn}(E_{syn,j} - \bar V)$, which is Dale's law at the operating point. Its magnitude is absorbed into $q_0 W_{ij}$. The second term is a shunt, and Eq. 5.1 drops it. This matters most for GABA_A synapses, whose reversal lies close to rest.

8. *Cholinergic gains and feedforward input (A5).* Multiply the recurrent current by $(1-\nu_{ACh})$. Write the feedforward current as $q_0'(1+\nu_{ACh})I_i(t)$. The rule follows the Hasselmo account of acetylcholine, which suppresses intracortical recurrent transmission and favours afferent input (e.g. Hasselmo 2006). Of the sources, A.8 gives this motivation only in words, and A.2 only implicitly. This step is a modelling choice, not a derivation.

9. *Axial current (A6).* From T1.7, $I_{ax}^{phys} = G_{ax}\left[(v_{d,i} - V_i) + (V_e(x_{d,i}) - V_e(x_{s,i}))\right]$.

10. *Insert Steps 2-9 into Step 1, then divide by $g_L$ (A7).* Define $\tau_v = C_s/g_L$:
$$
\tau_v \frac{dV_i}{dt} = -(V_i - v_{rest}) - g_K(a_i)(V_i - E_K) - g_{adap} w_i (V_i - E_K) + \frac{q_0}{g_L}\,\zeta(1-\nu_{ACh})\sum_j s_j W_{ij}x_{ij}r_j(t-\tau_{ij}) + \frac{q_0'}{g_L}(1+\nu_{ACh})I_i(t) + \frac{I_{ax}^{phys}}{g_L}
$$

11. *Identify the Aleph coefficients.* The term-by-term mapping is:
    - $G_s \equiv q_0/g_L$. Charge divided by conductance has units V s, so $G_s$ is an integrated PSP area per spike (mV s), not a conductance.
    - The printed equation uses the same $G_s$ on the feedforward term. That requires $q_0' = q_0$, so $I_i$ must be a rate-like quantity in Hz. If $I_i$ is a current, its gain must be $1/g_L$, not $G_s$.
    - $I_{ax,i} \equiv I_{ax}^{phys}/g_L$, so the $g_{ax}$ inside $I_{ax,i}$ is $G_{ax}/g_L$ (dimensionless).
    - Renaming $V_i \to v_i$ gives Aleph Eq. 5.1 term for term.

**Result.** Charge conservation under assumptions A1-A7 reproduces the printed equation exactly. Three points need flagging:

- (i) It is a normalized equation, but no source says so. A.8 calls $G_s$ a conductance, which Step 11 shows is wrong.
- (ii) $I_i(t)$ is undefined and can share the gain $G_s$ only if it is a rate.
- (iii) Synapses are current-based (Step 7), while the K$^+$ terms are conductance-based. The model therefore has metabolic shunting but no synaptic shunting.

A fully consistent version in physical units is:

$$
C_s\frac{dV_i}{dt} = -g_L(V_i - v_{rest}) - G_{KATP}(a_i)(V_i-E_K) - G_{adap}w_i(V_i-E_K) + q_0\zeta(1-\nu_{ACh})\sum_j s_jW_{ij}x_{ij}r_j(t-\tau_{ij}) + (1+\nu_{ACh})I^{ff}_i(t) + G_{ax}\left[(v_{d,i}-V_i) + \Delta V_{e,i}\right]
$$

Here $\Delta V_{e,i} = V_e(x_{d,i}) - V_e(x_{s,i})$ and $I^{ff}_i$ is a current. Dividing by $g_L$ recovers Eq. 5.1.

**Checks.**

- *Dimensions.* With $v$ in mV, every right-hand term is in mV:
    - $g_K$ and $g_{adap}w$ are dimensionless and multiply mV.
    - $G_s$ [mV s] times $r$ [1/s] gives mV.
    - $I_{ax,i}$ is in mV.
    - The left side is $\tau_v$ [ms] times $dv/dt$ [mV/ms], which is mV.
- *Fixed point with frozen inputs.* The equation is linear in $v_i$:
$$
\tau_v\frac{dv_i}{dt} = -(1 + g_K + g_{adap}w_i + g_{ax})\,v_i + \left[v_{rest} + (g_K + g_{adap}w_i)E_K + D_i + g_{ax}(v_{d,i} + \Delta V_{e,i})\right]
$$
  Here $D_i$ is the summed synaptic and feedforward drive. The fixed point and effective time constant are
$$
v_i^* = \frac{v_{rest} + (g_K + g_{adap}w_i)E_K + D_i + g_{ax}(v_{d,i}+\Delta V_{e,i})}{1 + g_K + g_{adap}w_i + g_{ax}}, \qquad \tau_{eff} = \frac{\tau_v}{1 + g_K + g_{adap}w_i + g_{ax}}
$$
- *Metabolic brake limit.* Set $D_i = 0$, $w_i = 0$, $g_{ax} = 0$ and let $a_i \to 0$, so $g_K \to \bar g_K$ (T1.6). Then $v^* \to (v_{rest} + \bar g_K E_K)/(1 + \bar g_K)$. This lies strictly between $E_K$ and $v_{rest}$ and reaches $E_K = -85$ mV only as $\bar g_K \to \infty$. The A.8 statement that the brake "hyperpolarizes toward $E_K$" is correct in direction, but the brake does not reach $E_K$. The synaptic gain $\partial v^*/\partial D_i = 1/(1+g_K+\ldots)$ falls at the same time. This is the "hyperpolarizes and shunts" property claimed in A.2.
- *Uniform field.* If $V_e(x_{d,i}) = V_e(x_{s,i})$, the ephaptic part of $I_{ax,i}$ vanishes. This is the Lean theorem `ephaptic_coupling_cancels_in_uniform_field` (Model_A8_All_Equations.lean and the patched file). The proof is the one-line identity $V_e - V_e = 0$.
- *Cholinergic limits.* At $\nu_{ACh} = 0$ both gains are 1. At $\nu_{ACh} = 1$ recurrent input is removed and feedforward input is doubled.
- *Meaning of $v_{rest}$.* At normal ATP $g_K(a_0) > 0$, so the true resting potential is $(v_{rest} + g_K(a_0)E_K)/(1+g_K(a_0))$, slightly below $v_{rest}$. The symbol $v_{rest}$ is really the leak reversal.
- *Delays.* The terms $r_j(t-\tau_{ij})$ make the system a delay differential equation. Its state space is the history segment $C([-\tau_{max},0])$, as A.6 notes.

**Lineage.**

- **Model A** (Model_A_Changelog_Audit_and_Fixes.md; Model_A_Biological_Neuroenergetics_Specification.pdf): $\tau_v\dot v_i = -(v_i - v_{rest}) + \zeta(1-\nu ACh)\sum_j s_jW_{ij}x_{ij}r_j - c_a a_Q + (1+\nu ACh)I_i$. K_ATP acts only as a threshold shift $\Delta\theta(e_i)$ in the rate law.
- **A.2** (Model A.2 Repaired Specification and Validation.docx): K_ATP becomes a conductance $-g_K(e_i)(v_i - E_K)$, with gain $G$; the leak is written $-v_i$.
- **A.5** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eq. 1): adds delays $\tau_{ij}$, a point ephaptic term $-g_{eph}(v_i - V_e(x_i))$ and an axial term $g_{axial}(v_{d,i} - v_i)$. The A.4 validation report (Model A.5 validation against experimental data.docx) showed that the point-cell field term has no physical effect.
- **A.6** (Model A.6 four-caveat revision ... (claude).docx, Eq. 1): moves the field into the axial-gradient term; $g_K$ reads the produced ATP $a_i$.
- **A.7** (Model A.7 with all equations.docx, annex Eq. 1; model A.7 maths.docx): unchanged.
- **A.8** (Model_A8_Scientific_Report.pdf Eqs. (1)-(2); Model_A8_model only.docx; Lean `dv_s_dt`): adds $-g_{adap}w_i(v_i - E_K)$ and names the axial term $I_{ax,i}$.
- **A.10 and Aleph:** A.10 Eq. 1.1 and Aleph Eq. 5.1 are identical to A.8.

**Derivation status.** Derived under approximations. KCL is exact. The approximations are:

- a single isopotential compartment;
- Ohmic leak, K_ATP and adaptation currents;
- current-based, rate-coded synapses (frozen driving force, mean-field rates);
- phenomenological cholinergic gains;
- an undeclared normalization by $g_L$.

$I_i(t)$ is undefined in every source.

---

## T1.2: Woodhull voltage-dependent NMDA open-channel block (Aleph Eq. 5.2)

**Equation as stated in Aleph 1** (Eq. 5.2, "Woodhull Open-Channel Trap Law"; identical to A.10 Eq. 1.3):

$$
I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}\,(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}\exp(-\alpha_{Mg}\, v) + \frac{[B]}{K_B}\exp\left(-\frac{z\,\delta_B F v}{R\,T_b}\right)\right]^{-1}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $I_{NMDA}$ | NMDA current, positive outward (because of the factor $v - E_{rev}$) | current, or mV in normalized form |
| $\bar g_{NMDA}$ | maximal NMDA conductance | conductance |
| $v$ | dendritic membrane potential, $\phi_{in} - \phi_{out}$ | mV |
| $E_{rev}$ | NMDA reversal (not stated; near 0 mV in standard physiology) | mV |
| $[Mg^{2+}]_e$ | extracellular Mg$^{2+}$ | mM |
| $\delta_{Mg}$ | Mg$^{2+}$ dissociation constant at 0 mV. It is written like an electrical depth but acts as a concentration | mM |
| $\alpha_{Mg}$ | Mg$^{2+}$ voltage sensitivity | 1/mV |
| $[B]$ | open-channel blocker concentration (A.10 lists ketamine, memantine, MK-801) | concentration |
| $K_B$ | blocker dissociation constant at $v = 0$ | concentration |
| $z$ | blocker valence (+1 in A.10) | dimensionless |
| $\delta_B$ | fractional electrical depth of the binding site, measured from outside (0.65 in A.10) | dimensionless |
| $F$, $R$, $T_b$ | Faraday constant, gas constant, body temperature | C/mol, J/(mol K), K |

**Physical starting point.** Woodhull (1973) open-channel block. A charged blocker enters an open pore from the extracellular side and binds at a site that sits a fraction $\delta$ of the way through the transmembrane field. Binding is at equilibrium, and Boltzmann statistics give its voltage dependence. Aleph Sec. 3.1 names the basis $\Delta G(v) = \Delta G_0 + z\delta_B F v$ (Model_Aleph_1_Comprehensive_Scientific_Report.docx). Assumptions:

- A1. The field across the pore is linear, so the electrical potential at the site is $\phi_{out} + \delta(\phi_{in} - \phi_{out}) = \phi_{out} + \delta v$.
- A2. Blocker binding and unbinding are fast compared with changes in $v$ and with channel gating, so occupancy is at equilibrium.
- A3. The blocker reaches and leaves the site only from the outside. Permeation ("punch-through") to the cytoplasm is neglected.
- A4. Mg$^{2+}$ and the drug compete for the same pore. A channel holds at most one blocker, so the bound states are mutually exclusive.
- A5. An unblocked open channel conducts Ohmically, $\bar g(v - E_{rev})$.
- A6. For Mg$^{2+}$, the empirical Jahr-Stevens form is used in place of explicit electrical parameters.

**Derivation.**

1. *Electrochemical potential of the free blocker outside.* $\mu_{out} = \mu^\circ_{free} + RT_b\ln([B]/c^\circ) + zF\phi_{out}$.

2. *Electrochemical potential of the bound blocker (A1).* $\mu_{site} = \mu^\circ_{bound} + zF(\phi_{out} + \delta_B v)$.

3. *Free energy of binding, as a function of voltage.* Subtract the electrical parts, using $\Delta G_0 = \mu^\circ_{bound} - \mu^\circ_{free}$:
$$
\Delta G(v) = \Delta G_0 + z\,\delta_B F v
$$
This is the expression Aleph Sec. 3.1 quotes. For a cation ($z > 0$) at negative $v$, the electrical term is negative, so hyperpolarization favours binding.

4. *Mass action at equilibrium (A2).* For the open state $O$ and the blocked state $OB$, $[OB]/([O][B]) = (1/c^\circ)\exp(-\Delta G(v)/RT_b)$. The dissociation constant is therefore
$$
K_D(v) = \frac{[O][B]}{[OB]} = c^\circ e^{\Delta G_0/RT_b}\,e^{z\delta_B F v/RT_b} \equiv K_B\, e^{z\delta_B F v/RT_b}
$$
Here $K_B = c^\circ e^{\Delta G_0/RT_b}$ is the dissociation constant at 0 mV.

5. *Kinetic cross-check, Reconstructed after Woodhull 1973.* Write the association rate as $k_{on}(v) = k_{on}(0)\,e^{-z\delta_1 F v/RT_b}$ and the dissociation rate as $k_{off}(v) = k_{off}(0)\,e^{+z\delta_2 F v/RT_b}$. Here $\delta_1 + \delta_2 = \delta_B$ locate the outer barrier and the site. Their ratio is
$$
\frac{k_{off}(v)}{k_{on}(v)} = \frac{k_{off}(0)}{k_{on}(0)}\,e^{z(\delta_1+\delta_2)Fv/RT_b} = K_B\,e^{z\delta_B Fv/RT_b}
$$
This matches Step 4. The equilibrium constant depends only on the depth of the site, not on where the barrier sits.

6. *Unblocked fraction with one blocker.* With $[O] + [OB]$ conserved,
$$
f_u = \frac{[O]}{[O]+[OB]} = \frac{1}{1 + [B]/K_D(v)} = \frac{1}{1 + \dfrac{[B]}{K_B}\exp\left(-\dfrac{z\delta_B F v}{RT_b}\right)}
$$

7. *Second, mutually exclusive blocker (A4).* With states $O$, $OMg$ and $OB$, the binding polynomial is $1 + [Mg]/K_{Mg}(v) + [B]/K_D(v)$. The unblocked fraction is its reciprocal:
$$
f_u = \left[1 + \frac{[Mg^{2+}]_e}{K_{Mg}(v)} + \frac{[B]}{K_D(v)}\right]^{-1}
$$

8. *Mg$^{2+}$ term (A6).* Take $1/K_{Mg}(v) = \delta_{Mg}^{-1}\exp(-\alpha_{Mg}v)$, with $\delta_{Mg}$ a concentration. This is the Jahr-Stevens (1990) form, whose standard fitted values are 3.57 mM and 0.062 per mV. In Woodhull terms, $\alpha_{Mg} = 2\delta'_{Mg}F/(RT)$ for the divalent ion, where $\delta'_{Mg}$ is the Mg$^{2+}$ site depth.

9. *Current (A5).* $I_{NMDA} = \bar g_{NMDA}\,f_u\,(v - E_{rev})$. Substituting Step 7 with Step 8 gives the printed Eq. 5.2.

**Result.** The drug term follows exactly from Woodhull's equilibrium model under A1-A3. The additive Mg$^{2+}$ term follows from A4 with the empirical A6. Eq. 5.2 matches the derivation, but six points need flagging:

- (i) **Not a trapping law.** The name "trap law" is wrong for what is printed. The equation is an equilibrium availability factor. Trapping block, in which the blocker stays bound when the channel closes, needs open, closed, blocked-open and blocked-closed states with their own kinetics. Eq. 5.2 does not track channel state or history.
- (ii) **$\delta_{Mg}$ is a concentration.** It is not a fractional depth like $\delta_B$, and the shared letter invites confusion.
- (iii) **Temperature dependence.** The Mg$^{2+}$ exponent carries no explicit temperature dependence. The drug exponent does, through $T_b$. A Woodhull-consistent Mg term would use $2\delta'_{Mg}F/(RT_b)$.
- (iv) **No glutamate gating.** $\bar g_{NMDA}$ carries no transmitter dependence, so as printed the NMDA conductance is open whenever the dendrite exists. A usable form is $g_{NMDA}(t) = \bar g_{NMDA}\,s_{NMDA}(t)$, with $s_{NMDA}$ driven by presynaptic release. This is a proposal; no source gives it.
- (v) **Sign convention.** $I_{NMDA}$ as printed is positive outward. T1.10 adds it with a plus sign as an inward source, so the sign is inconsistent there (see T1.10).
- (vi) **Permeation neglected.** A3 removes relief of block at strong hyperpolarization. With permeation, the effective dissociation constant becomes $(k_{off} + k_{perm})/k_{on}$ (Woodhull 1973), and block is no longer monotone in $v$.

**Checks.**

- *Dimensions.* The following are all dimensionless: $[Mg]/\delta_{Mg}$, $[B]/K_B$, $\alpha_{Mg}v$, and $z\delta_BFv/(RT_b)$ (because $F/(RT_b)$ has units 1/V). So the bracket is dimensionless and $I_{NMDA}$ has the units of $\bar g\,v$. At $T_b = 310.15$ K, $RT_b/F = 26.7$ mV.
- *Limiting cases.*
    - $[B] \to 0$ gives the Mg-only Jahr-Stevens block.
    - $[Mg] \to 0$ and $[B] \to 0$ give the Ohmic current $\bar g(v - E_{rev})$.
    - $v \to +\infty$ makes both exponentials vanish, so the block is relieved.
    - $v \to -\infty$ gives complete block, $I \to 0$; without A3 there would be partial relief.
- *Monotonicity.* For $z > 0$, $\partial f_u/\partial v > 0$, so depolarization relieves block.
- *Algebra of A.10 Insight 2 (the invariant itself is out of scope).* In the strong-block limit $f_u \approx (K_B/[B])\,e^{z\delta_BFv/RT_b}$. For two cells at $v_{Pyr} = -68$ mV and $v_{PV} = -52$ mV:
$$
\frac{f_u(v_{Pyr})}{f_u(v_{PV})} = \exp\left[\frac{z\delta_BF(v_{Pyr} - v_{PV})}{RT_b}\right] = e^{-0.39} \approx 0.68
$$
  The depolarized PV cell is therefore *less* blocked per open channel. A.10 writes this ratio as $\exp[z\delta_BF(v_{PV}-v_{Pyr})/RT_b] = 1.48$, which is the reciprocal. Its "4.74-fold" figure multiplies the voltage factor in the wrong direction. The GPT audit (Model_Aleph_Equation_Derivations_GPT.docx) also notes that the ratio neglects the "1+" term.

**Lineage.**

- **Before A.10:** no NMDA block term. A.8 has none. A.10 states that its Eq. 1.3 fixes an earlier A.9 error (Model_A10_Comprehensive_Scientific_Report.docx, validation table).
- **A.10 Eq. 1.3:** introduces the form.
- **Aleph:** Eq. 5.2 is identical, and Aleph Sec. 3.1 adds the free-energy basis.
- **GPT audit (Sec. 3.2):** gives the Boltzmann sketch and the same caveats on trapping, sign convention and additivity.

**Derivation status.** Derived under approximations. The drug term is exact for equilibrium two-state block in a linear field (A1-A3). The approximations are:

- equilibrium rather than trapping kinetics;
- no permeation;
- mutually exclusive Mg$^{2+}$ and drug sites;
- an empirical Mg$^{2+}$ term;
- no glutamate gating in $\bar g_{NMDA}$.

---

## T1.3: Vectorized Hall-Ehlert GABA_A allosteric ternary-complex law (Aleph Eq. 5.3)

**Equation as stated in Aleph 1** (Eq. 5.3, both Aleph files; the ellipsis is printed in the sources themselves):

$$
\left(\frac{E}{E_{max}}\right)_{GABA} = \sum_s f_s(x)\cdot\left[\frac{[A]/K_{A,s} + \alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})}{1 + [A]/K_{A,s} + [B]/K_{B,s} + \alpha_s([A]/K_{A,s})([B]/K_{B,s}) + \tau_s\cdot(\ldots)}\right]
$$

The complete scalar form is A.10 Eq. 1.4 (Model_A10_Comprehensive_Scientific_Report.docx):

$$
\frac{E}{E_{max}} = \frac{[A]/K_A + \alpha\beta([A]/K_A)([B]/K_B)}{1 + [A]/K_A + [B]/K_B + \alpha([A]/K_A)([B]/K_B) + \tau_{eff}\left([A]/K_A + \alpha\beta([A]/K_A)([B]/K_B)\right)}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $s$ | GABA_A subunit class (the lineage table says "β2/β3 allosteric assembly") | index |
| $f_s(x)$ | weight of class $s$. Its argument $x$ is never defined | dimensionless |
| $[A]$ | orthosteric agonist (endogenous GABA) | concentration |
| $[B]$ | allosteric modulator | concentration |
| $K_{A,s}$, $K_{B,s}$ | dissociation constants of $A$ and $B$ for class $s$ | concentration |
| $\alpha_s$ | binding cooperativity | dimensionless |
| $\beta_s$ | efficacy cooperativity. Undefined in Aleph; A.10 calls β "operational activation efficacy cooperativity" | dimensionless |
| $\tau_s$ | operational efficacy ($\tau_{eff}$ in A.10) | dimensionless |
| $(\ldots)$ | literal ellipsis in both Aleph files | none |

Abbreviate $a = [A]/K_A$ and $b = [B]/K_B$ (class index dropped).

**Physical starting point.** The allosteric ternary complex model (Ehlert 1988), extended to function by an efficacy cooperativity (Hall 2000) and an operational transducer (Black & Leff 1983). Aleph Sec. 3 says this law follows from "the thermodynamic cycles of a two-state receptor". Assumptions:

- A1. The receptor has four binding states, $R$, $AR$, $BR$ and $ABR$. They are in rapid equilibrium, and neither ligand is depleted.
- A2. Detailed balance holds around the thermodynamic cycle $R \to AR \to ABR \to BR \to R$.
- A3. $BR$ has no intrinsic efficacy (no allosteric agonism). $AR$ has efficacy 1, and $ABR$ has efficacy $\beta$ relative to $AR$.
- A4. Efficacy-weighted occupancy is converted to response by a hyperbolic transducer with operational efficacy $\tau$.
- A5. Subunit classes respond independently, and their responses add with fixed weights.

**Derivation.**

1. *Equilibria of the cycle (A1).* The four dissociation constants are
$$
K_A = \frac{[A][R]}{[AR]},\qquad K_B = \frac{[B][R]}{[BR]},\qquad \frac{K_B}{\alpha} = \frac{[B][AR]}{[ABR]},\qquad K'_A = \frac{[A][BR]}{[ABR]}
$$

2. *Close the cycle (A2).* Compute $[ABR]$ along both paths. Via $AR$:
$$
[ABR] = \frac{\alpha[B][AR]}{K_B} = \frac{\alpha[A][B][R]}{K_AK_B}
$$
Via $BR$:
$$
[ABR] = \frac{[A][BR]}{K'_A} = \frac{[A][B][R]}{K_BK'_A}
$$
Equating the two gives $K'_A = K_A/\alpha$. The same $\alpha$ therefore scales both the affinity of $A$ in the presence of $B$ and the affinity of $B$ in the presence of $A$.

3. *Statistical weights.* Divide each state by $[R]$. This gives $R:1$, $AR:a$, $BR:b$ and $ABR:\alpha ab$. The total receptor is
$$
R_T = [R]\,(1 + a + b + \alpha ab)
$$

4. *Efficacy-weighted occupancy (A3).*
$$
\rho = \frac{1\cdot[AR] + \beta\cdot[ABR]}{R_T} = \frac{a + \alpha\beta ab}{1 + a + b + \alpha ab} \equiv \frac{N}{D}
$$
This is exactly the printed numerator over the first four denominator terms.

5. *Operational transducer (A4; Black & Leff 1983, as in T1.13).* $E/E_m = \tau\rho/(1+\tau\rho)$. Substituting $\rho = N/D$:
$$
\frac{E}{E_m} = \frac{\tau N/D}{1 + \tau N/D} = \frac{\tau N}{D + \tau N} = \frac{\tau(a + \alpha\beta ab)}{1 + a + b + \alpha ab + \tau(a + \alpha\beta ab)}
$$
This is the standard operational model of allosterism (Leach et al. 2007) with no allosteric agonism.

6. *Identify the ellipsis.* The denominator in Step 5 has the term $\tau(a + \alpha\beta ab)$. A.10 Eq. 1.4 writes the same denominator term. Hence
$$
(\ldots) = \frac{[A]}{K_{A,s}} + \alpha_s\beta_s\frac{[A]}{K_{A,s}}\frac{[B]}{K_{B,s}}
$$

7. *Compare numerators.* Step 5 has $\tau N$ in the numerator. A.10 and Aleph have $N$:
$$
\left(\frac{E}{E_{max}}\right)_{A.10} = \frac{N}{D + \tau N} = \frac{1}{\tau}\left(\frac{E}{E_m}\right)_{Step\ 5}
$$
So the printed law is the operational model divided by $\tau$.

8. *Vectorize (A5).* Let class $s$ have maximal conductance $\bar g_s$. The total normalized response is $\sum_s \bar g_s (E/E_m)_s / \sum_s \bar g_s$. Defining $f_s = \bar g_s/\sum_{s'}\bar g_{s'}$, with $f_s \ge 0$ and $\sum_s f_s = 1$, gives the $\sum_s f_s(\cdot)_s$ structure of Eq. 5.3.

**Result.** The corrected and complete form is derived as:

$$
\left(\frac{E}{E_{max}}\right)_{GABA} = \sum_s f_s\,\frac{\tau_s\left(\dfrac{[A]}{K_{A,s}} + \alpha_s\beta_s\dfrac{[A]}{K_{A,s}}\dfrac{[B]}{K_{B,s}}\right)}{1 + \dfrac{[A]}{K_{A,s}} + \dfrac{[B]}{K_{B,s}} + \alpha_s\dfrac{[A]}{K_{A,s}}\dfrac{[B]}{K_{B,s}} + \tau_s\left(\dfrac{[A]}{K_{A,s}} + \alpha_s\beta_s\dfrac{[A]}{K_{A,s}}\dfrac{[B]}{K_{B,s}}\right)},\qquad \sum_s f_s = 1
$$

It differs from Aleph 1 as follows:

- (i) **Ellipsis.** Aleph's $\tau_s\cdot(\ldots)$ is a truncation in the source. Step 6 supplies it from A.10.
- (ii) **Missing $\tau_s$ in the numerator.** A.10 and Aleph omit the $\tau_s$ in the numerator. As printed, the maximal response at saturating agonist and $b = 0$ is $1/(1+\tau)$, which *decreases* as efficacy rises. In the derived form it is $\tau/(1+\tau)$.
- (iii) **Undefined symbols.** $\beta_s$, $f_s(x)$ and $x$ are undefined.
- (iv) **Coupling never written.** The link from this fraction to the GABA_A current in T1.10 is never written. A natural proposal is $I_{GABA} = -\bar g_{GABA}\,(E/E_{max})_{GABA}\,(v_{d,i} - E_{GABA})$.
- (v) **Choice of model.** GABA_A is an ion channel. A transducer ratio $\tau$ is a GPCR concept, so using it here is a modelling choice. An MWC-type gating model (Hall 2000, two-state) would be the mechanistic alternative.

**Checks.**

- *Dimensions.* $a$, $b$, $\alpha$, $\beta$, $\tau$ and $f_s$ are all dimensionless, so the response is dimensionless.
- *$[A] \to 0$.* $N \propto a \to 0$, so the response is 0 in both forms. This is the A.10 statement that a pure positive allosteric modulator cannot gate the channel on its own.
- *$[B] \to 0$.* The derived form gives $\tau a/(1 + (1+\tau)a) = \tau[A]/(K_A + (1+\tau)[A])$. This is exactly the Black-Leff law T1.13, which is an independent consistency check. The printed form gives $[A]/(K_A + (1+\tau)[A])$, which differs from T1.13 by the factor $\tau$.
- *$[B] \to \infty$.* Divide numerator and denominator by $b$ and let $b \to \infty$. The printed form gives $\beta a/(1/\alpha + a + \tau\beta a)$. This reproduces A.10 Insight 1, Proof Step 1. The derived form gives $\tau\beta a/(1/\alpha + a + \tau\beta a)$. Both vanish as $a \to 0$.
- *Bounds.* The efficacy-weighted occupancy satisfies $\rho = (a + \alpha\beta ab)/(1 + a + b + \alpha ab) < \max(1,\beta)$, because each active state carries efficacy 1 or $\beta$ and the inactive states $R$ and $BR$ carry none. Since $\tau\rho/(1+\tau\rho)$ increases in $\rho$, with $f_s \ge 0$, $\sum f_s = 1$ and all parameters positive the derived response lies in $[0, \max_s \tau_s\beta^+_s/(1+\tau_s\beta^+_s))$ with $\beta^+_s = \max(1,\beta_s)$. This is inside $[0,1)$. For a modulator with $\beta_s \le 1$ the ceiling is $\tau_s/(1+\tau_s)$; a positive efficacy modulator ($\beta_s > 1$) can raise it, as the $[B]\to\infty$ limit above shows.

**Lineage.**

- **A.9:** introduced the Black-Leff model for GPCRs only (T1.13).
- **A.10 Eq. 1.4:** gives the complete scalar law with $\tau_{eff}$ in the denominator only, together with the $[B]\to\infty$ and $[A]\to 0$ limits (Insight 1).
- **Aleph Eq. 5.3:** vectorizes over subunit classes and truncates the $\tau_s$ term (both Aleph files).
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 3.3 sketches the binding polynomial and flags the undefined $\tau_s\cdot(\ldots)$.

**Derivation status.** Incomplete in source.

- *Missing:* the term after $\tau_s$, the definitions of $\beta_s$, $f_s$ and $x$, and the coupling to $I_{GABA}$.
- *Supplied here:* the full state-sum derivation; the identification of the ellipsis from A.10; a corrected numerator consistent with the operational model and with T1.13; and a proposed coupling.
- *Status by part:* given A1-A5, the binding part is exact. The transducer is a phenomenological (operational) closure.

---

## T1.4: Connexin-36 gap-junction current between PV interneurons (Aleph Eq. 5.4)

**Equation as stated in Aleph 1** (Eq. 5.4; the lineage-table short form is $I_{gap} = -g_{gap}L_{gap}v_{PV}$):

$$
I_{gap,k} = \sum_{j \in \mathrm{PV\ neighbors}} g_{gap}\,(v_{PV,j} - v_{PV,k}) = -g_{gap}\left[L_{gap}\, v_{PV}\right]_k
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $I_{gap,k}$ | gap-junction current into PV cell $k$ (positive inward) | current (or mV if normalized by $g_L$) |
| $g_{gap}$ | conductance of one junction (uniform) | conductance (relative to $g_L$ in normalized form) |
| $v_{PV}$ | vector of PV membrane potentials | mV |
| $A$ | symmetric 0/1 adjacency matrix of the Cx36 network | dimensionless |
| $D$ | degree matrix, $D_{kk} = d_k = \sum_j A_{kj}$ | dimensionless |
| $L_{gap}$ | graph Laplacian $D - A$ | dimensionless |

**Physical starting point.** Ohm's law for each junction (Kirchhoff), summed over the electrical-synapse graph. Assumptions:

- A1. Each Cx36 junction is a linear, non-rectifying conductance $g_{gap}$ between the two cell interiors.
- A2. Each cell is isopotential at the junction site, so dendritic filtering is ignored.
- A3. The network is undirected: $A_{kj} = A_{jk}$.

**Derivation.**

1. *One junction (A1).* The current from $j$ into $k$ is $g_{gap}(v_j - v_k)$.

2. *Sum over neighbours.* Use $A_{kj}$ to select neighbours:
$$
I_{gap,k} = g_{gap}\sum_j A_{kj}(v_j - v_k)
$$

3. *Split the sum.* Use $\sum_j A_{kj} = d_k$:
$$
I_{gap,k} = g_{gap}\left(\sum_j A_{kj}v_j - d_kv_k\right) = g_{gap}\left[(Av)_k - (Dv)_k\right]
$$

4. *Factor.*
$$
I_{gap,k} = -g_{gap}\left[(D - A)v\right]_k = -g_{gap}\left[L_{gap}v_{PV}\right]_k
$$

5. *Heterogeneous junctions.* Replace $g_{gap}A_{kj}$ by a symmetric conductance matrix $G_{kj}$. Define $D^G_{kk} = \sum_j G_{kj}$. Steps 2-4 repeat unchanged:
$$
I_{gap} = -(D^G - G)\,v = -L^G v
$$

**Result.** Aleph Eq. 5.4 is an exact identity under A1-A3. The source omits two things:

- (i) Where $I_{gap}$ enters is not stated. Neither the Tier 5 PV membrane nor any rate equation includes it.
- (ii) If it enters a normalized membrane equation such as T1.1, $g_{gap}$ must be expressed relative to that cell's leak conductance.

**Checks.**

- *Dimensions.* Conductance times voltage gives current. $L_{gap}$ is dimensionless.
- *Charge conservation.* $\mathbf{1}^TI_{gap} = -g_{gap}\mathbf{1}^TL_{gap}v$. Since $L_{gap}$ is symmetric and $L_{gap}\mathbf{1} = D\mathbf{1} - A\mathbf{1} = d - d = 0$, we have $\mathbf{1}^TL_{gap} = (L_{gap}\mathbf{1})^T = 0$. Hence $\sum_k I_{gap,k} = 0$: junctions move charge between cells but create none.
- *Positive semidefiniteness.* Expand the quadratic form:
$$
v^TL_{gap}v = \sum_k d_kv_k^2 - \sum_{k,j}A_{kj}v_kv_j
$$
  By symmetry, $\sum_k d_kv_k^2 = \sum_{k,j}A_{kj}v_k^2 = \tfrac12\sum_{k,j}A_{kj}(v_k^2 + v_j^2)$. Substituting,
$$
v^TL_{gap}v = \tfrac12\sum_{k,j}A_{kj}(v_k - v_j)^2 \ge 0
$$
  Equality holds only if $v$ is constant on each connected component. The zero eigenvalue has eigenvector $\mathbf{1}$, and its multiplicity equals the number of components. The second-smallest eigenvalue $\lambda_2$ (algebraic connectivity) is the quantity used by the Aleph invariant $\Sigma_{sync}$, which is out of scope here.
- *Pure coupling dissipates differences.* If $C\,dv/dt = I_{gap}$ alone, then
$$
\frac{d}{dt}\left(\tfrac12 C\,v^Tv\right) = -g_{gap}v^TL_{gap}v \le 0
$$
  Voltages relax to the component mean, while the mean itself is conserved (by charge conservation). With intrinsic dynamics, delays and inhibition, synchrony is *not* guaranteed. The GPT audit makes the same point.
- *Limit.* $g_{gap} \to 0$ gives $I_{gap} = 0$.

**Lineage.**

- **A.5:** the change log mentions $g_{gap}$ only in words (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf).
- **A.10.1 / Aleph:** the operator is new in A.10.1 (Aleph Eq. 5.4 and lineage table). Its motivation is the failed broadband-gamma test #4 on ds005917, recorded as fixed in test #65 (Model_Aleph_1_Comprehensive_Scientific_Report.docx).
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 3.4 gives the same identity.

**Derivation status.** Exact, given Ohmic, non-rectifying junctions between isopotential cells on an undirected graph.

---

## T1.5: Competitive monoamine transporter reuptake ledger (SERT/DAT/NET) (Aleph Eq. 5.5)

**Equation as stated in Aleph 1** (Eq. 5.5; identical to A.10 Eq. 1.7):

$$
\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}\,[M]_{syn}}{K_{m,T}\left(1 + [Inhibitor]/K_i\right) + [M]_{syn}} - k_{clear}[M]_{syn}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[M]_{syn}$ | extracellular monoamine (5-HT, DA or NE) | concentration (e.g. nM) |
| $R_{release}(r_{presyn})$ | firing-dependent release rate; its form is never given | concentration/time |
| $V_{max,T}$ | maximal transporter uptake rate per unit extracellular volume | concentration/time |
| $K_{m,T}$ | transporter Michaelis constant | concentration |
| $[Inhibitor]$ | free competitive inhibitor | concentration |
| $K_i$ | inhibitor dissociation constant | concentration |
| $k_{clear}$ | residual first-order clearance (diffusion out of the volume, enzymatic breakdown) | 1/time |

**Physical starting point.** Conservation of transmitter amount in a well-mixed extracellular volume, plus Michaelis-Menten kinetics with Briggs-Haldane quasi-steady state and a competitive inhibitor. Assumptions:

- A1. The extracellular volume $V_e$ is fixed and well mixed. $[M]_{syn}$ is a volume average.
- A2. Transporter states relax fast compared with $[M]_{syn}$ (quasi-steady state).
- A3. The translocation step $TM \to T + M_{in}$ is irreversible; transporter reversal is neglected.
- A4. The inhibitor binds only the free transporter, reversibly. Its free concentration is not depleted.
- A5. Transporter-bound transmitter is a small fraction of the total ($T_{tot} \ll K_m + [M]$), so buffering by transporters is neglected.
- A6. All other losses are first order.

**Derivation.**

1. *Amount balance (A1).* $\dfrac{d(V_e[M])}{dt} = J_{rel} - J_{T} - J_{other}$, with fluxes in mol/time.

2. *Divide by constant $V_e$.* Define $R_{release} = J_{rel}/V_e$, $v_T = J_T/V_e$ and $k_{clear}[M] = J_{other}/V_e$ (A6):
$$
\frac{d[M]}{dt} = R_{release} - v_T - k_{clear}[M]
$$

3. *Transporter scheme.* $T + M \rightleftharpoons TM \to T + M_{in}$, with rate constants $k_1$, $k_{-1}$ and $k_2$, and $T + I \rightleftharpoons TI$ with constant $K_i$.

4. *Quasi-steady state of $TM$ (A2, A3).* Setting $d[TM]/dt = k_1[T][M] - (k_{-1}+k_2)[TM] = 0$ gives
$$
[T][M] = K_m[TM],\qquad K_m = \frac{k_{-1}+k_2}{k_1}
$$

5. *Inhibitor equilibrium (A4).* $[TI] = [T][I]/K_i$.

6. *Transporter conservation.* Use $T_{tot} = [T] + [TM] + [TI]$ and substitute $[T] = K_m[TM]/[M]$:
$$
T_{tot} = \frac{K_m[TM]}{[M]}\left(1 + \frac{[I]}{K_i}\right) + [TM]
$$

7. *Solve for $[TM]$.*
$$
[TM] = \frac{T_{tot}[M]}{K_m(1+[I]/K_i) + [M]}
$$

8. *Uptake rate.* $v_T = k_2[TM]$, so with $V_{max,T} = k_2T_{tot}$ (per unit volume)
$$
v_T = \frac{V_{max,T}[M]}{K_{m,T}(1+[I]/K_i) + [M]}
$$

9. *Substitute into Step 2.* This gives Eq. 5.5.

**Result.** Eq. 5.5 follows exactly from A1-A6 and matches Aleph 1. Two gaps remain:

- (i) **Release term.** $R_{release}(r_{presyn})$ is never specified. A form consistent with T1.9 would be $R_{release} = \nu_{rel}\sum_{j\in presyn}x_j r_j$, with $\nu_{rel}$ the concentration released per spike. This is a proposal only.
- (ii) **Volume.** The sources do not say whether $[M]_{syn}$ is a synaptic-cleft concentration or a voxel average. This changes the meaning of $V_{max,T}$ and $k_{clear}$.

Transporters are Na$^+$/Cl$^-$-coupled, alternating-access carriers rather than enzymes. The Michaelis-Menten form is their QSSA reduction when inward translocation is effectively irreversible (A3).

**Checks.**

- *Dimensions.* $R_{release}$, $V_{max}\cdot$(dimensionless saturation) and $k_{clear}[M]$ are all concentration/time. $[I]/K_i$ is dimensionless.
- *Steady state is unique.* Let $f(M) = R - V_{max}M/(K_{app}+M) - k_{clear}M$, with $K_{app} = K_m(1+[I]/K_i)$. Then $f(0) = R > 0$, and $f'(M) = -V_{max}K_{app}/(K_{app}+M)^2 - k_{clear} < 0$, so $f$ is strictly decreasing. Also $f \to -\infty$ when $k_{clear} > 0$. So there is exactly one positive steady state.
    - If $k_{clear} = 0$, a steady state exists only if $R < V_{max}$, and it is $M^* = RK_{app}/(V_{max} - R)$.
- *Low-concentration limit.* For $M \ll K_{app}$, $M^* \approx R/(V_{max}/K_{app} + k_{clear})$. When transporters dominate clearance, a competitive inhibitor raises $M^*$ by the factor $1 + [I]/K_i$.
- *Limits.* $[I] \to 0$ gives plain Michaelis-Menten uptake. $[I] \to \infty$ removes transporter uptake, leaving first-order clearance.
- *Positivity.* At $M = 0$, $dM/dt = R \ge 0$, so $[M]$ stays non-negative.

**Lineage.**

- **A.10 Eq. 1.7:** new ("Reuptake Corrected" in the A.10 validation table).
- **Aleph Eq. 5.5:** identical. Aleph Sec. 3 lists it under "Michaelis-Menten & Hill Enzyme Kinetics".
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 3.5 gives the same mass-balance plus competitive-MM sketch.

**Derivation status.** Derived under approximations: well-mixed volume, QSSA, irreversible translocation, competitive and non-depleting inhibitor, negligible transporter buffering, first-order residual clearance. $R_{release}$ is unspecified in every source.

---

## T1.6: K_ATP conductance law, closure of Eq. 5.1 (inherited: A.8 Tier 1 inline; symbol $g_K(a_i)$ in Aleph Eq. 5.1)

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf, Sec. 2.1 inline; Model_A8_model only.docx):

$$
g_K(a) = \frac{\bar g_K}{1 + (a/K_A)^{n_K}}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $g_K(a)$ | K_ATP conductance; dimensionless (relative to leak) when used in normalized Eq. 5.1 | dimensionless |
| $\bar g_K$ | maximal K_ATP conductance, relative to leak | dimensionless |
| $a$ | intracellular ATP | mM |
| $K_A$ | ATP level of half-inhibition. The same symbol is the Black-Leff $K_A$ in T1.13, which is a clash | mM |
| $n_K$ | Hill exponent | dimensionless |

**Physical starting point.** Ligand-gated inhibition of the K_ATP channel (Kir6.2 pore with SUR subunits), where ATP binding closes the channel. No source derives the form. The sources say only that the channel "opens as ATP falls" and hyperpolarizes toward $E_K$ (A.2; A.8). Assumptions:

- A1. The channel is open only when no inhibitory ATP is bound.
- A2. ATP binding is all-or-none (fully concerted) at $n_K$ sites.
- A3. MgADP activation, PIP2 and the sulfonylurea-receptor subunit are ignored, so $a$ is the only regulator.
- A4. The conductance is maximal conductance times open probability.

**Derivation.** This is a reconstruction of the standard interpretation of a Hill inhibition law. The Hill form itself is the modelling choice.

1. *States under A2.* With concerted binding, only two states have appreciable weight: unbound (weight 1) and fully bound with $n_K$ ATP. The fully bound weight is $(a/K_A)^{n_K}$, where $K_A^{n_K}$ is the overall dissociation constant of the $n_K$-ligand complex.

2. *Open probability (A1).* Divide the open-state weight by the sum of weights:
$$
P_o = \frac{1}{1 + (a/K_A)^{n_K}}
$$

3. *Conductance (A4).* Multiply by the maximal conductance:
$$
g_K = \bar g_K\,P_o = \frac{\bar g_K}{1 + (a/K_A)^{n_K}}
$$

4. *When A2 fails.* If binding is not fully concerted (independent or partly cooperative sites), the exact $P_o$ is a ratio of polynomials in $a$. The Hill form is then an empirical fit, and $n_K$ is an apparent cooperativity, not a site count.

**Result.** The A.8 form follows from A1-A4. A2 is an idealization, so in practice the law is a phenomenological Hill closure. As noted under T1.1, in normalized Eq. 5.1 $\bar g_K$ must be read relative to the leak conductance. Physiologically the channel is regulated by the ATP/ADP ratio; the model uses ATP alone (A3).

**Checks.**

- *Dimensions.* $(a/K_A)$ is dimensionless, so $g_K$ has the units of $\bar g_K$.
- *Limits.*
    - $a \to 0$: $g_K \to \bar g_K$, the full brake.
    - $a = K_A$: $g_K = \bar g_K/2$.
    - $a \gg K_A$: $g_K \approx \bar g_K(K_A/a)^{n_K} \to 0$, the brake is off.
- *Monotonicity.*
$$
\frac{dg_K}{da} = -\bar g_K\,\frac{n_K\,a^{n_K-1}/K_A^{n_K}}{\left[1 + (a/K_A)^{n_K}\right]^2} < 0 \quad (a > 0)
$$
  Falling ATP therefore always opens the channel.
- *Effect on Eq. 5.1.* As $a \to 0$, the fixed point approaches $(v_{rest} + \bar g_KE_K)/(1+\bar g_K)$ and the effective time constant shortens by $1+\bar g_K$ (see the T1.1 checks).

**Lineage.**

- **Model A:** the brake is a threshold shift $\Delta\theta(e_i)$ in the rate law (Model_A_Biological_Neuroenergetics_Specification.pdf Eq. (2); Model_A_Changelog_Audit_and_Fixes.md).
- **A.2:** $g_K(e) = \bar g_K/(1 + (e/K_A)^n)$ on lumped energy $e$. A.2's Morris screen found $K_A$ barely moves ischaemic ATP and is not identifiable from rates and ATP alone.
- **A.5 Eq. 2 and A.6 Eq. 1:** the same law. A.6 makes the argument the produced ATP $a$.
- **A.7 and A.8:** inline in A.7 and in A.8 (PDF Sec. 2.1; docx).
- **Lean:** the A.8 Lean files treat $g_K$ as a free real input to `dv_s_dt`.
- **A.10 and Aleph:** keep only the symbol $g_K(a_i)$.

**Derivation status.** Phenomenological closure (Hill inhibition). The motivation is ATP-inhibited K_ATP channels that open under energy depletion. It is exact only under the idealization of fully concerted binding. No source gives fitted values or evidence for $n_K$.

---

## T1.7: Axial plus ephaptic soma-dendrite current, closure of Eq. 5.1 (inherited: A.8 PDF Eq. (2); symbol $I_{ax,i}$ in Aleph Eq. 5.1)

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Eq. (2); also inside the A.8 docx Eq. 1):

$$
I_{ax,i} = g_{ax}\left[(v_{d,i} - v_i) + \left(V_e(x_{d,i}) - V_e(x_{s,i})\right)\right]
$$

The dendritic equation (T1.10) receives $-I_{ax,i}$.

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $g_{ax}$ | soma-dendrite axial conductance. Relative to the somatic leak in Eq. 5.1; a physical conductance in T1.10 | dimensionless or conductance |
| $v_i$, $v_{d,i}$ | somatic and dendritic transmembrane potentials | mV |
| $V_e(x)$ | extracellular potential at position $x$ | mV |
| $x_{s,i}$, $x_{d,i}$ | somatic and dendritic positions | m |
| $\phi_s$, $\phi_d$ | intracellular potentials (used in the derivation) | mV |

**Physical starting point.** The two-compartment cable model: Ohm's law along the intracellular core resistance between soma and dendrite, with transmembrane potential defined as intracellular minus extracellular potential. Assumptions:

- A1. Each compartment is isopotential inside.
- A2. The extracellular potential is imposed: the neuron does not change $V_e$ (no ephaptic feedback). It is quasi-static over membrane time scales.
- A3. The core resistance between compartments is Ohmic, with conductance $g_{ax}$.

**Derivation.**

1. *Ohm's law on the core (A3).* The current flowing from the dendrite to the soma inside the cell is driven by the difference of *intracellular* potentials:
$$
I_{ax} = g_{ax}(\phi_d - \phi_s)
$$

2. *Definition of transmembrane potential.* $v = \phi - V_e$ in each compartment, so $\phi_s = v_i + V_e(x_{s,i})$ and $\phi_d = v_{d,i} + V_e(x_{d,i})$.

3. *Substitute.*
$$
I_{ax} = g_{ax}\left[v_{d,i} + V_e(x_{d,i}) - v_i - V_e(x_{s,i})\right] = g_{ax}\left[(v_{d,i} - v_i) + (V_e(x_{d,i}) - V_e(x_{s,i}))\right]
$$
This is the A.8 form exactly.

4. *Current conservation along the core.* The same current leaves the dendrite, so the dendritic balance carries $-I_{ax}$.

5. *Normalization.* In Eq. 5.1 every term is divided by the somatic leak $g_{L,s}$, so the $g_{ax}$ there is $G_{ax}/g_{L,s}$. In T1.10, which is not normalized, it must be the physical $G_{ax}$. The sources use one symbol for both.

**Steady polarization by a uniform field.** This reconstructs A.6 property P10.

- 6. Let the field component along the soma-to-dendrite axis be $E$. Then $V_e(x) = V_0 - Ex$, and with $\ell = x_{d,i} - x_{s,i}$:
$$
\Delta V_e = V_e(x_{d,i}) - V_e(x_{s,i}) = -E\ell
$$
- 7. Measure $v_s$ and $v_d$ from rest. Give each compartment a passive membrane conductance, $g_s$ and $g_d$. Define $u = (v_d - v_s) + \Delta V_e$, so the axial current is $g_{ax}u$. The steady state of both balances is:
$$
0 = -g_sv_s + g_{ax}u, \qquad 0 = -g_dv_d - g_{ax}u
$$
- 8. Solve for each compartment:
$$
v_s = \frac{g_{ax}}{g_s}u, \qquad v_d = -\frac{g_{ax}}{g_d}u
$$
- 9. Substitute into the definition of $u$:
$$
u = -\frac{g_{ax}}{g_d}u - \frac{g_{ax}}{g_s}u + \Delta V_e \quad\Rightarrow\quad u = \frac{\Delta V_e}{1 + g_{ax}/g_d + g_{ax}/g_s}
$$
- 10. Insert $\Delta V_e = -E\ell$:
$$
v_s = -\frac{(g_{ax}/g_s)\,E\ell}{1 + g_{ax}/g_d + g_{ax}/g_s}, \qquad v_d = +\frac{(g_{ax}/g_d)\,E\ell}{1 + g_{ax}/g_d + g_{ax}/g_s}
$$
  The soma formula is exactly A.6 P10.

**Result.** The printed form is exact under A1-A3, and the A.6 P10 polarization formula is reproduced. Two corrections:

- (i) A.6 gives the strong-coupling limit as "$\to E\ell\cdot g_d/(g_s+g_d)$". As $g_{ax} \to \infty$ the correct limit is $v_s \to -E\ell\,g_d/(g_s+g_d)$ and $v_d \to +E\ell\,g_s/(g_s+g_d)$. A.6 dropped the sign.
- (ii) $g_{ax}$ must be normalized differently in Eq. 5.1 and in T1.10 (Step 5).

**Checks.**

- *Dimensions.* $(v_d - v)$ and $\Delta V_e$ are both voltages, so $I_{ax}$ has the units of $g_{ax}\times$voltage.
- *Uniform potential.* If $V_e(x_{d,i}) = V_e(x_{s,i})$, the field term is zero. This is the Lean theorem `ephaptic_coupling_cancels_in_uniform_field`; equivalently $E\ell = 0$ in Step 10. A point cell therefore cannot sense a uniform potential, which is the A.4/A.5 defect that A.6 repaired.
- *Opposite polarization.* From Step 8, $v_d/v_s = -g_s/g_d < 0$, so soma and dendrite polarize in opposite directions.
    - A.6 quotes soma 0.118 and dendrite 0.176 mV per V/m. That ratio gives $g_s/g_d = 0.176/0.118 = 1.49$.
    - From Step 8, $v_s - v_d = \kappa\,\Delta V_e/(1+\kappa)$ with $\kappa = g_{ax}/g_s + g_{ax}/g_d$. So $\lvert v_s\rvert + \lvert v_d\rvert = E\ell\,\kappa/(1+\kappa) < E\ell$.
    - The quoted total of 0.294 mV per V/m therefore requires $\ell > 0.294$ mm. This is a consistency condition on the unstated soma-dendrite separation.
- *Sign physics.* If $V_e$ is higher at the dendrite ($\Delta V_e > 0$), current enters the cell at the dendrite and leaves at the soma. The soma depolarizes ($v_s > 0$ in Step 8) and the dendrite hyperpolarizes, matching the classical result Bikson et al. 2004 report.
- *Charge conservation.* The soma gains $+I_{ax}$ and the dendrite loses $-I_{ax}$, so the net is zero.

**Lineage.**

- **A.5 Eq. 1:** separate terms $-g_{eph}(v_i - V_e(x_i))$ and $g_{axial}(v_{d,i} - v_i)$. The A.4 validation report and A.6 change C15 show the point-cell term is unphysical.
- **A.6 Eqs. 1-2:** axial-gradient form, with property P10 and Bikson 2004 calibration.
- **A.7 Eqs. 1-2:** unchanged. model A.7 maths.docx states "a uniform field gives zero".
- **A.8:** PDF Eq. (2) names the term $I_{ax,i}$; the Lean files prove the uniform-field cancellation.
- **A.10 and Aleph:** use $I_{ax,i}$ without restating it.

**Derivation status.** Exact within the two-compartment model with an imposed, quasi-static extracellular potential.

---

## T1.8: Spike-frequency adaptation variable (inherited: A.8 Tier 1 inline; symbol $w_i$ in Aleph Eq. 5.1)

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Sec. 2.1; Model_A8_model only.docx):

$$
\tau_w \frac{dw_i}{dt} = -w_i + m_w r_i
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $w_i$ | adaptation variable. A.6 lists it in "rate units"; it enters Eq. 5.1 as a conductance factor and T1.20 as a subtractive threshold | see Result |
| $\tau_w$ | adaptation time constant. The same symbol is the weight time constant in T6.4, which is a clash | s |
| $m_w$ | adaptation gain | units of $w$ per Hz |
| $r_i$ | firing rate | Hz |

**Physical starting point.** A slow K$^+$ conductance gated by Ca$^{2+}$ or Na$^+$ that builds up with each spike. A.8 names "slow calcium-activated or sodium-activated potassium channels". No source gives a derivation. Assumptions:

- A1. The adaptation gate $w$ relaxes with first-order kinetics and a single time constant $\tau_w$. The intermediate ion concentration is collapsed into the gate.
- A2. Each spike increments $w$ by a fixed amount $\Delta w$, and the increment is linear (no saturation).
- A3. Spikes form a point process with intensity $r_i(t)$.

**Derivation.** Reconstructed: the standard shot-noise average of a spike-incremented linear variable.

1. *Spike-driven kinetics (A1, A2).*
$$
\frac{dw}{dt} = -\frac{w}{\tau_w} + \Delta w\sum_k\delta(t - t_k)
$$

2. *Expectation over spike trains (A3).* The equation is linear in $w$, so the expectation passes through it. Using $\mathbb{E}\left[\sum_k\delta(t - t_k)\right] = r_i(t)$:
$$
\frac{d\langle w\rangle}{dt} = -\frac{\langle w\rangle}{\tau_w} + \Delta w\,r_i(t)
$$

3. *Multiply by $\tau_w$ and define $m_w = \tau_w\Delta w$.* Writing $w$ for $\langle w\rangle$:
$$
\tau_w\frac{dw_i}{dt} = -w_i + m_w r_i
$$

**Result.** The A.8 form is the exact mean of a linear, spike-incremented first-order gate. Using a single linear gate is the modelling choice. Two issues need flagging:

- (i) **Double counting and unit mismatch.** $w_i$ is used twice: as a conductance factor $g_{adap}w_i(v_i - E_K)$ in Eq. 5.1, and as a subtractive threshold $-w_i$ inside $\Phi$ in T1.20.
    - In Eq. 5.1, $g_{adap}w_i$ must be dimensionless, so $g_{adap}$ has units 1/[w].
    - In T1.20, $w_i$ must be in mV.
    - Both are consistent only with a hidden conversion factor, and the two uses count adaptation twice.
    - A consistent model keeps one of the two. The conductance form is the mechanistic one.
- (ii) **No upper bound.** A gate fraction should be bounded, but the linear form lets $w_i$ grow without limit as $r_i$ grows. A saturating alternative is $\tau_w\dot w = -w + m_wr(1 - w)$. That is a proposal, not in any source.

**Checks.**

- *Dimensions.* $[\tau_w\,dw/dt] = [w]$ and $[m_wr] = [w]$, which requires $[m_w] = [w]\cdot$s.
- *Steady state.* $w^* = m_w r$, with relaxation time $\tau_w$.
- *Gain reduction (with T1.20).* Consider the subtractive use and linearize $r = \Phi(g(v - w - \ldots))$ at steady state, with $\Phi' = d\Phi/d(\text{arg})$. Then $dr = \Phi'g(dv - m_w\,dr)$, which gives
$$
\frac{dr}{dv} = \frac{g\Phi'}{1 + g\Phi'm_w}
$$
  Adaptation thus divides the slope of the f-I curve, the expected effect of spike-frequency adaptation.
- *Positivity.* If $w(0) \ge 0$ and $r \ge 0$, then $w(t) \ge 0$, because at $w = 0$ the derivative is $m_wr/\tau_w \ge 0$.

**Lineage.**

- **A.2:** $\tau_{ad}\dot a_i = -a_i + m\,r_i$ (Model A.2 Repaired Specification and Validation.docx). Adaptation is called $a_i$, and $m$ clashes with the Michaelis-Menten $m(\cdot)$.
- **Model A:** the same equation appears in its precursor lineage (Model_A_Biological_Neuroenergetics_Specification.pdf).
- **A.5 Eq. 6 to A.7 Eq. 7:** A.5 Eq. 6 has the same form; A.6 Eq. 7 renames the variable $w_i$; A.7 Eq. 7 is unchanged.
- **A.8:** inline. The A.8 equations introduce the conductance use in Eq. 5.1.
- **A.10 and Aleph:** symbol only.

**Derivation status.** Phenomenological closure. Choosing one linear first-order gate is a modelling choice. Given that choice, the rate drive $m_wr$ follows exactly by averaging (Reconstructed). Its dual use in Eq. 5.1 and T1.20 is inconsistent.

---

## T1.9: Presynaptic resource (Tsodyks-Markram) dynamics for $x_{ij}$ (inherited: A.5 Eq. 16; symbol $x_{ij}$ in Aleph Eq. 5.1)

**Equation as stated in the latest explicit source** (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, Eq. 16; also A.2):

$$
\frac{dx_{ij}}{dt} = \frac{1 - x_{ij}}{\tau_{rec}} - U\,x_{ij}\,r_j
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $x_{ij}$ | readily releasable resource fraction of synapse $j\to i$ | dimensionless, in $[0,1]$ |
| $\tau_{rec}$ | recovery time constant | s |
| $U$ | fraction of the available resource released per spike | dimensionless |
| $r_j$ | presynaptic rate | Hz |

**Physical starting point.** The Tsodyks-Markram model of short-term depression: each presynaptic spike uses a fixed fraction $U$ of the available resource, which recovers to 1 with first-order kinetics. A.8 cites the model by name for $x_{ij}$. Assumptions:

- A1. Depression only: $U$ is constant, with no facilitation variable.
- A2. Recovery is first order with time constant $\tau_{rec}$.
- A3. Presynaptic spikes form a Poisson process with intensity $r_j(t)$.
- A4. The model works with the mean resource $\langle x\rangle$, as the rate model requires.

**Derivation.**

1. *Between spikes (A2).*
$$
\frac{dx}{dt} = \frac{1 - x}{\tau_{rec}}
$$

2. *At a spike (A1).* $x(t_k^+) = x(t_k^-) - Ux(t_k^-)$.

3. *Combine Steps 1-2 as a spike-train equation.*
$$
\frac{dx}{dt} = \frac{1 - x}{\tau_{rec}} - U\,x(t^-)\sum_k\delta(t - t_k)
$$

4. *Expectation (A3).* $x(t^-)$ depends only on spikes before $t$. For a Poisson process, whether a spike occurs at $t$ is independent of the past. Hence
$$
\mathbb{E}\left[x(t^-)\sum_k\delta(t - t_k)\right] = \langle x\rangle\,r_j(t)
$$
For a Poisson process this step is exact, not an approximation.

5. *Mean equation (A4).*
$$
\frac{d\langle x\rangle}{dt} = \frac{1 - \langle x\rangle}{\tau_{rec}} - U\langle x\rangle r_j
$$
This is the printed form, with $x_{ij} \equiv \langle x\rangle$.

**Result.** The source form follows exactly for the mean resource under Poisson input with constant $U$. It is approximate for regular spike trains. For a regular train with period $T$, iterating Steps 1-2 gives the pre-spike steady state
$$
x_- = \frac{1 - e^{-T/\tau_{rec}}}{1 - (1-U)e^{-T/\tau_{rec}}}
$$
instead of the mean-field value. Using $\langle x\rangle$ inside the products $W_{ij}x_{ij}r_j$ of Eq. 5.1 also ignores the correlation between $x$ and the spike train in the transmitted current. With identical $U$ and $\tau_{rec}$ at all synapses, $x_{ij}$ depends on $j$ only.

**Checks.**

- *Dimensions.* $(1-x)/\tau_{rec}$ and $Uxr$ both have units 1/s.
- *Invariance of $[0,1]$.* At $x = 0$, $dx/dt = 1/\tau_{rec} > 0$. At $x = 1$, $dx/dt = -Ur_j \le 0$. So the interval is forward-invariant.
- *Steady state.* $(1 - x^*)/\tau_{rec} = Ux^*r$ gives
$$
x^* = \frac{1}{1 + U\tau_{rec}r}
$$
- *Transmitted rate.* $x^*r = r/(1 + U\tau_{rec}r) \to 1/(U\tau_{rec})$ as $r \to \infty$. This is depression-limited saturation.
- *Limits.* $r \to 0$ gives $x \to 1$. $U \to 0$ gives no depression.

**Lineage.**

- **Model A / v7.3:** vesicle resource.
- **A.2 and A.5:** A.2 restores it as $\dot x_{ij} = (1-x_{ij})/\tau_{rec} - Ux_{ij}r_j$ (Model A.2 Repaired Specification and Validation.docx). A.5 Eq. 16 is the last explicit statement.
- **A.6 to A.10 and Aleph:** use $x_{ij}$ without restating it. A.8 calls it "Tsodyks-Markram short-term depression". The A.8 inferences quote NsMJ vesicle depletion of $x$ from 0.8 to 0.15.

**Derivation status.** Derived under approximations: mean-field resource over Poisson spike trains, depression without facilitation, and the mean $\langle x\rangle$ used in place of the random resource. The dynamics have not been restated in any source since A.5.

---

## T1.10: Active dendritic membrane potential (inherited: A.10 Eq. 1.2; A.8 PDF Eq. (3))

**Equation as stated in the latest source** (Model_A10_Comprehensive_Scientific_Report.docx, Eq. 1.2):

$$
C_d \frac{dv_{d,i}}{dt} = -g_{leak}(v_{d,i} - E_L) + \bar A_{Ca}\,\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i} - E_{HCN}) + I_{AMPA} + I_{NMDA} + I_{GABA} - I_{ax,i}
$$

The A.8 form (Model_A8_Scientific_Report.pdf Eq. (3)) has $\sum_{j\in apical}W_{ij}x_{ij}r_j(t-\tau_{ij})$ where A.10 has $I_{AMPA} + I_{NMDA} + I_{GABA}$.

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $C_d$ | dendritic capacitance | capacitance |
| $v_{d,i}$ | dendritic membrane potential | mV |
| $g_{leak}$, $E_L$ | dendritic leak conductance and reversal | conductance, mV |
| $\bar A_{Ca}$ | dCaAP amplitude. Aleph Table 3 gives it in mV: human 38, macaque 18, rat 6.5, mouse 4.5; fly, zebrafish and pigeon 0 | mV as printed; a current is required (see Result) |
| $\Delta(u)$ | dCaAP activation (T1.11) | dimensionless |
| $u_{d,i}$ | integrated apical drive; how it is computed is never stated | mV (same units as $u_{th}$) |
| $g_{HCN}(DA)$, $E_{HCN}$ | dopamine-gated HCN conductance (T1.12) and its reversal | conductance, mV |
| $I_{AMPA}$ | AMPA current; never defined | current |
| $I_{NMDA}$ | NMDA current from Eq. 5.2 (T1.2) | current |
| $I_{GABA}$ | GABA_A current; presumably scaled by Eq. 5.3 (T1.3), but not stated | current |
| $I_{ax,i}$ | axial plus ephaptic current (T1.7) | current |

**Physical starting point.** KCL on the apical dendritic compartment, as in T1.1. Assumptions:

- A1. The apical dendrite is one isopotential compartment with capacitance $C_d$.
- A2. Leak and HCN currents are Ohmic.
- A3. The dCaAP is an imposed current source with amplitude $\bar A_{Ca}$ and a shape set by $\Delta(u_{d,i})$. It is not a voltage-gated Ca$^{2+}$ conductance.
- A4. Synaptic currents are resolved by receptor type. NMDA carries Woodhull block (T1.2); GABA_A carries allosteric modulation (T1.3).
- A5. The axial current is the mirror of the somatic one (T1.7).

**Derivation.**

1. *Charge balance (A1).* Leak and HCN are outward-positive membrane currents. Generator, synaptic and axial terms are written as inward sources:
$$
C_d\frac{dv_{d,i}}{dt} = -I_{leak} - I_{HCN} + I_{dCaAP} + I_{syn} - I_{ax,i}
$$

2. *Leak (A2).* $I_{leak} = g_{leak}(v_{d,i} - E_L)$.

3. *HCN (A2).* $I_{HCN} = g_{HCN}(DA)(v_{d,i} - E_{HCN})$, with $g_{HCN}$ from T1.12. HCN channels carry mixed Na$^+$/K$^+$ current, so $E_{HCN}$ lies between $E_K$ and $E_{Na}$.

4. *dCaAP generator (A3).* $I_{dCaAP} = \bar A_{Ca}\Delta(u_{d,i})$, which is zero below threshold (T1.11).

5. *Synaptic currents (A4).* Each inward synaptic current has the form $g_X(t)\,B_X(v)\,(E_X - v_{d,i})$, where $B_X$ is a block factor ($B_X = 1$ except for NMDA):
$$
I_{syn} = g_{AMPA}(t)(E_{AMPA} - v_{d,i}) + \bar g_{NMDA}s(t)f_u(v_{d,i})(E_{rev} - v_{d,i}) + g_{GABA}(t)(E_{GABA} - v_{d,i})
$$

6. *Axial (A5).* The dendrite loses the current the soma gains, $-I_{ax,i}$, with $I_{ax,i} = G_{ax}[(v_{d,i} - v_i) + \Delta V_{e,i}]$ in physical units.

7. *Assemble.* Steps 2-6 give the printed structure term by term.

**Result.** The structure matches A.10 Eq. 1.2, but the derivation exposes five defects:

- (i) **Units of $\bar A_{Ca}$.** $\bar A_{Ca}$ is tabulated in mV, yet the equation adds it to currents. One fix is to replace $\bar A_{Ca}\Delta$ by $g_{leak}\bar A_{Ca}\Delta$. Then, dividing by $g_{leak}$ with $\tau_d = C_d/g_{leak}$:
$$
\tau_d\frac{dv_{d,i}}{dt} = -(v_{d,i} - E_L) + \bar A_{Ca}\Delta(u_{d,i}) - \frac{g_{HCN}(DA)}{g_{leak}}(v_{d,i} - E_{HCN}) + \frac{I_{syn}}{g_{leak}} - \frac{I_{ax,i}}{g_{leak}}
$$
  In this form $\bar A_{Ca}$ (mV) is the steady depolarization the dCaAP adds at threshold.
- (ii) **NMDA sign.** Eq. 5.2 defines $I_{NMDA} = \bar g\,f_u\,(v - E_{rev})$, which is positive *outward*. Adding it with a plus sign in Step 1 means NMDA activation hyperpolarizes the dendrite whenever $v < E_{rev}$. The consistent term is $-I_{NMDA}^{(Eq.\,5.2)} = \bar g\,f_u\,(E_{rev} - v)$.
- (iii) **Undefined synaptic terms.** $I_{AMPA}$ is never defined. $I_{GABA}$ is never linked to Eq. 5.3. Neither current has transmitter gating. Proposed closures (not in any source), with $u_{d,i}$ and the synaptic conductances driven by the A.8 apical sum:
    - $g_{AMPA}(t) = \bar g_{AMPA}\sum_{j\in apical}W_{ij}x_{ij}r_j(t-\tau_{ij})$, where $\bar g_{AMPA}$ is a conductance-time area per spike (conductance times s), so that $g_{AMPA}$ is a conductance;
    - $g_{GABA}(t) = \bar g_{GABA}\,(E/E_{max})_{GABA}$ from T1.3;
    - $u_{d,i} = G_d\sum_{j\in apical}W_{ij}x_{ij}r_j(t-\tau_{ij})$, which is the A.8 docx description "integrated synaptic drive arriving at the apical tuft". The gain $G_d$ (mV s, the dendritic analogue of $G_s$ in T1.1) is needed so that $u_{d,i}$ is in mV, like $u_{th}$; the bare sum is in Hz.
- (iv) **Lost terms.** In replacing the A.8 apical sum, A.10 dropped the delays $\tau_{ij}$ and the weights $W_{ij}$ from the dendrite.
- (v) **Axial normalization.** $I_{ax,i}$ is normalized in Eq. 5.1 but physical here (see T1.7).

**Checks.**

- *Dimensions.* $C_d\,dv/dt$ is a current. So are the leak, HCN, synaptic and axial terms. $\bar A_{Ca}\Delta$ is a voltage as tabulated; this is the mismatch in (i).
- *Below dCaAP threshold.* If $u < u_{th}$, then $\Delta = 0$ and the generator drops out. This is the Lean theorem `dCaAP_zero_below_threshold` (Model_A8_All_Equations.lean, patched file), proved by `if_pos` and `ring`.
- *Fixed point with frozen inputs.* Write $I^{in}_{syn}$ for the voltage-independent part of the synaptic sources. Treating $f_u$ as frozen as well, the right-hand side is linear in $v_d$, with total conductance $g_{tot} = g_{leak} + g_{HCN} + G_{ax} + \sum_X g_X$:
$$
v_d^* = \frac{g_{leak}E_L + g_{HCN}E_{HCN} + \bar A_{Ca}\Delta + I^{in}_{syn} + G_{ax}(v_s - \Delta V_e)}{g_{tot}}
$$
  The gain for a synaptic current is $1/g_{tot}$. This shunting by $g_{HCN}$ is used in T1.12.
- *Charge conservation with the soma.* The soma gains $+I_{ax}$ and the dendrite loses $-I_{ax}$.

**Lineage.**

- **A.5 Eq. 3:** $I_{dCaAP}(v_{d,i})$ undefined, plus an apical sum and axial term (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf).
- **A.6 Eq. 2:** explicit $\Delta(u)$, the apical sum $\sum_{j\in apical}W_{ij}x_{ij}r_j(t-\tau_{ij})$, and the axial-gradient field term.
- **A.7 Eq. 2:** the same; short forms in Section 1 drop terms.
- **A.8:** PDF Eq. (3) and docx; Lean `dv_d_dt` with a free `I_apical`.
- **A.10 Eq. 1.2:** replaces the apical sum with $I_{AMPA} + I_{NMDA} + I_{GABA}$.
- **Aleph:** lists the "dendritic potential" as inherited and gives $\bar A_{Ca}$ by species (Table 3).

**Derivation status.** Derived under approximations, and incomplete in source.

- *Approximations:* a single compartment, Ohmic leak and HCN, and a dCaAP modelled as a current source.
- *Missing:* $I_{AMPA}$, the coupling of $I_{GABA}$ to Eq. 5.3, the construction of $u_{d,i}$, and transmitter gating.
- *Defects in what is printed:* a unit mismatch for $\bar A_{Ca}$ and a sign inconsistency with Eq. 5.2.

---

## T1.11: Dendritic Ca$^{2+}$ action potential (dCaAP) activation function (inherited: A.8 PDF Eq. (4))

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Eq. (4); Model_A8_model only.docx):

$$
\Delta(u) = \mathcal{H}(u - u_{th})\cdot\exp\left(-\frac{u - u_{th}}{w_{Ca}}\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\mathcal{H}$ | Heaviside step. The Lean convention sets the value at $u = u_{th}$ to 1 | dimensionless |
| $u$ | apical drive | mV |
| $u_{th}$ | dCaAP threshold; dynamic from A.9 on (T1.17) | mV |
| $w_{Ca}$ | decay width (human 12 mV, A.8 docx) | mV |

**Physical starting point.** An empirical description of the dendritic Ca$^{2+}$ action potential that Gidon et al. (2020) found in human layer 2/3 pyramidal neurons. Its amplitude is largest for inputs just above threshold and falls for stronger inputs. No first-principles derivation exists, and none is attempted here. The form is a modelling choice. Assumptions:

- A1. Zero response below threshold.
- A2. Maximal response at threshold.
- A3. Monotone exponential decline above threshold, with width $w_{Ca}$.

**Derivation.** None; this is a phenomenological closure. What follows *demonstrates* the property the form was chosen for, which is the XOR computation claimed in A.6 and A.8.

1. *Basic values.* For $u < u_{th}$, $\Delta(u) = 0$. At threshold, $\Delta(u_{th}) = e^0 = 1$. For $u > u_{th}$:
$$
\frac{d\Delta}{du} = -\frac{1}{w_{Ca}}\exp\left(-\frac{u - u_{th}}{w_{Ca}}\right) < 0
$$

2. *XOR setting.* Take two inputs with drives $u_1, u_2 \ge 0$ that add, a baseline drive of 0 with $u_{th} > 0$, and a readout that fires when $\bar A_{Ca}\Delta(u) > \theta_{out}$. Define $c = \theta_{out}/\bar A_{Ca} \in (0,1)$.

3. *Truth table.*
    - $(0,0)$: $u = 0 < u_{th}$, so $\Delta = 0$ and there is no output.
    - $(1,0)$ or $(0,1)$: $u = u_k$. Output occurs iff $u_k \ge u_{th}$ and $\exp(-(u_k - u_{th})/w_{Ca}) > c$, that is, iff $u_{th} \le u_k < u_{th} + w_{Ca}\ln(1/c)$.
    - $(1,1)$: $u = u_1 + u_2 \ge u_{th}$ whenever either input fires alone. There is then no output iff $u_1 + u_2 \ge u_{th} + w_{Ca}\ln(1/c)$.

4. *Example.* With $u_1 = u_2 = u_{th}$:
    - one input gives $\Delta = 1 > c$, so the readout fires;
    - both inputs give $\Delta = \exp(-u_{th}/w_{Ca})$, so the readout is silent iff $u_{th} \ge w_{Ca}\ln(1/c)$.
    
    Under that condition the cell computes XOR.

5. *A monotone activation cannot give XOR.* Suppose $\Delta$ is non-decreasing. Then $u_1 + u_2 \ge u_1$ implies $\Delta(u_1 + u_2) \ge \Delta(u_1)$. So $(1,1)$ fires whenever $(1,0)$ fires, and the best achievable is OR. This is the A.6 justification ("a monotone activation gives OR, not XOR").

**Result.** The A.8 form is a phenomenological closure. It has the properties claimed, and Steps 3-5 give the exact conditions for XOR. It is discontinuous at $u_{th}$, a jump from 0 to 1. This is harmless for a rate model, but it makes the vector field of T1.10 non-smooth. A smooth surrogate would be $\sigma((u - u_{th})/s)\exp(-(u-u_{th})_+/w_{Ca})$; that is a proposal only.

**Checks.**

- *Dimensions.* $(u - u_{th})/w_{Ca}$ is dimensionless, so $\Delta$ is dimensionless.
- *Bounds.* $0 \le \Delta \le 1$.
- *Limits.* $u \to \infty$ gives $\Delta \to 0$. $w_{Ca} \to \infty$ gives a pure step, which is monotone and computes OR only.
- *Lean.* `dCaAP_activation` uses `if u < u_th then 0 else exp(...)`, the same function with $\mathcal{H}(0) = 1$. The theorem `dCaAP_zero_below_threshold` checks A1.

**Lineage.**

- **A.5:** $I_{dCaAP}$ undefined.
- **A.6 Eq. 2:** introduces $\Delta(u)$; change C17 reads "largest at threshold, damped above".
- **A.7 Eq. 2:** unchanged.
- **A.8:** PDF Eq. (4) and docx, with human $\bar A_{Ca} = 38$ mV and $w_{Ca} = 12$ mV; Lean piecewise definition.
- **A.9:** makes $u_{th}$ dynamic (T1.17).
- **A.10 and Aleph:** use $\Delta(u_{d,i})$ in the dendrite.

**Derivation status.** Phenomenological closure. The motivation and evidence are the Gidon et al. 2020 amplitude-versus-input data for human L2/3 dCaAPs, and the need for a non-monotone activation to compute XOR (Step 5).

---

## T1.12: D1 dopamine inverted-U pair: HCN shunt and non-preferred-input suppression (inherited: A.8 Tier 1 inline; $g_{HCN}(DA)$ in A.10 Eq. 1.2)

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Sec. 2.1; Model_A8_model only.docx; A.6 Eqs. 3-4):

$$
g_{HCN}(DA) = \frac{\bar g_{HCN}\,DA^3}{K_D^3 + DA^3}, \qquad s_{np}(DA) = 1 - \frac{\sigma_1\,DA^2}{K_1^2 + DA^2}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $DA$ | dopamine level | concentration (or relative) |
| $\bar g_{HCN}$ | maximal HCN conductance | conductance |
| $K_D$, $K_1$ | half-activation levels | units of $DA$ |
| $\sigma_1$ | maximal suppression; $\sigma_1 \le 1$ is needed for $s_{np} \ge 0$ | dimensionless |
| $s_{np}$ | gain on non-preferred inputs; the term it multiplies is never written | dimensionless |

**Physical starting point.** The mechanism the sources cite is Arnsten 2011: D1 receptor, then Gs, then adenylyl cyclase, then cAMP, which binds the HCN cyclic-nucleotide-binding domain and opens HCN channels. A second D1 action suppresses non-preferred inputs. Both forms are Hill functions chosen by the authors. No source derives them. Assumptions:

- A1. HCN opening is a Hill-3 function of dopamine. This lumps D1 occupancy, cAMP production and cAMP binding.
- A2. Suppression is a Hill-2 function of dopamine, with maximum $\sigma_1$.
- A3. For the inverted-U demonstration: preferred and non-preferred inputs are currents of equal size $I$ entering the dendrite (T1.10). The non-preferred input is scaled by $s_{np}$, and both are shunted by $g_{HCN}$.

**Derivation.** The two Hill laws are modelling choices (A1-A2). What can be derived is the inverted-U the sources claim (Reconstructed from T1.10).

1. *Gain of an input current.* From the T1.10 fixed point, a current $I$ changes $v_d$ by $I/g_{tot}$. Take $g_{tot} = g_0 + g_{HCN}(DA)$, where $g_0$ collects the dopamine-independent conductances.

2. *Selectivity signal (A3).* Preferred minus non-preferred response:
$$
P(DA) = \frac{I}{g_0 + g_{HCN}(DA)} - \frac{s_{np}(DA)\,I}{g_0 + g_{HCN}(DA)} = I\,\frac{1 - s_{np}(DA)}{g_0 + g_{HCN}(DA)}
$$

3. *Insert A2.*
$$
P(DA) = I\,\frac{\sigma_1DA^2/(K_1^2 + DA^2)}{g_0 + \bar g_{HCN}DA^3/(K_D^3 + DA^3)}
$$
The numerator is the rising limb (suppression of distractors). The reciprocal of the denominator is the falling limb (global shunt).

4. *End points.* $P(0) = 0$ and $P(\infty) = I\sigma_1/(g_0 + \bar g_{HCN})$.

5. *Value at $DA = K_D$.* Here $g_{HCN} = \bar g_{HCN}/2$ and the suppression is $\sigma_1/(1 + (K_1/K_D)^2)$. Write $\rho = \bar g_{HCN}/g_0$. Then
$$
\frac{P(K_D)}{P(\infty)} = \frac{1}{1 + (K_1/K_D)^2}\cdot\frac{1 + \rho}{1 + \rho/2}
$$

6. *Condition for an interior maximum.* $P(K_D) > P(\infty)$ iff $1 + (K_1/K_D)^2 < (1+\rho)/(1+\rho/2)$, that is,
$$
\left(\frac{K_1}{K_D}\right)^2 < \frac{\rho}{2 + \rho}
$$
$P$ is continuous, with $P(0) = 0 < P(K_D)$ and $P(K_D) > P(\infty)$. So $P$ has an interior maximum that exceeds both ends. That is an inverted U.

**Result.**

- **The Hill laws.** These match the sources. They are phenomenological.
- **The inverted U.** It follows from the product of the two limbs whenever suppression saturates at lower dopamine than the shunt, in the sense of Step 6. It does *not* return to zero at high dopamine: the floor is $I\sigma_1/(g_0 + \bar g_{HCN})$. A strict U would need $\bar g_{HCN} \to \infty$ or a third mechanism.
- **Gaps in the sources:**
    - The term that $s_{np}$ multiplies is never written in any equation.
    - The Aleph lineage table says A.9 replaced the "fixed gain scalars (G_s, g_HCN)" with Black-Leff, but no Black-Leff form for D1 to HCN is ever written.
- **Proposal (not in any source).** A form consistent with T1.13 would chain the D1 operational response $\phi_{D1} = \tau_{D1}DA/(K_{D1} + (1+\tau_{D1})DA)$ into a cAMP-to-HCN Hill law: $g_{HCN} = \bar g_{HCN}\phi_{D1}^3/(K_c^3 + \phi_{D1}^3)$.

**Checks.**

- *Dimensions.* $DA/K_D$ and $DA/K_1$ are dimensionless, so $g_{HCN}$ has units of conductance and $s_{np}$ is dimensionless.
- *Ranges.* $g_{HCN} \in [0, \bar g_{HCN})$. $s_{np} \in (1-\sigma_1, 1]$.
- *Limits.* $DA = 0$ gives no shunt and no suppression. $DA \to \infty$ gives the full shunt $\bar g_{HCN}$ and $s_{np} \to 1 - \sigma_1$.
- *Monotonicity.* $g_{HCN}$ rises with $DA$, and $s_{np}$ falls with $DA$.

**Lineage.**

- **A.4:** monotone DA gain (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf change log).
- **A.5 Eq. 4:** Hill-3 HCN law.
- **A.6 Eqs. 3-4:** add $s_{np}$ and the inverted-U justification ("low DA leaves non-preferred inputs unsuppressed, and high DA shunts everything"). A.6 Section 1 reports a figure check.
- **A.7 Eqs. 3-4:** unchanged.
- **A.8:** inline, citing Arnsten 2011.
- **A.10 and Aleph:** A.10 Eq. 1.2 keeps $g_{HCN}(DA)$. The Aleph lineage table claims a Black-Leff replacement that is not written.

**Derivation status.** Phenomenological closure. The motivation is the D1 to cAMP to HCN pathway (Arnsten 2011) and the working-memory inverted U. The evidence offered is qualitative (A.6 figure). The inverted U is derived here, with an explicit condition, from the two closures plus the T1.10 shunt.

---

## T1.13: Black-Leff operational model of GPCR agonism, with $K_A$ from binding free energy (inherited: A.9; Aleph Sec. 2 lineage table)

**Equation as stated in the latest source** (Model_A9_changes from a8.docx; equation images checked):

$$
\frac{E}{E_{max}} = \frac{\tau[L]}{K_A + (\tau + 1)[L]}, \qquad K_A = e^{-\Delta G/RT}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $E/E_{max}$ | response as a fraction of the system maximum $E_m$ | dimensionless |
| $[L]$ | ligand concentration | concentration |
| $K_A$ | equilibrium dissociation constant | concentration |
| $\tau$ | transducer ratio (efficacy), $R_0/K_E$ | dimensionless |
| $R_0$, $K_E$ | receptor density; occupied-receptor level giving half-maximal response | density |
| $\Delta G$ | binding free energy; the sign convention is not stated | J/mol |
| $R$, $T$ | gas constant, temperature | J/(mol K), K |

**Physical starting point.** The Black and Leff (1983) operational model: equilibrium receptor occupancy followed by a hyperbolic occupancy-to-response transducer. The second relation is standard-state thermodynamics. Assumptions:

- A1. Ligand binding is at equilibrium, and the ligand is not depleted.
- A2. Response is a rectangular-hyperbolic function of occupied receptors: $E = E_m[AR]/(K_E + [AR])$.
- A3. There is one binding site and no constitutive activity. The transducer slope is 1.

**Derivation.**

1. *Occupancy (A1).* With $K_A = [L][R]/[AR]$ and $R_0 = [R] + [AR]$:
$$
[AR] = \frac{R_0[L]}{K_A + [L]}
$$

2. *Transducer (A2).*
$$
\frac{E}{E_m} = \frac{[AR]}{K_E + [AR]}
$$

3. *Substitute Step 1 into Step 2.*
$$
\frac{E}{E_m} = \frac{R_0[L]/(K_A + [L])}{K_E + R_0[L]/(K_A + [L])}
$$

4. *Multiply numerator and denominator by $(K_A + [L])/K_E$, and define $\tau = R_0/K_E$.*
$$
\frac{E}{E_m} = \frac{\tau[L]}{K_A + [L] + \tau[L]} = \frac{\tau[L]}{K_A + (\tau + 1)[L]}
$$
This is the A.9 form.

5. *Standard-state thermodynamics for $K_A$.* For dissociation $AR \rightleftharpoons A + R$, the dimensionless equilibrium constant is $K_A/c^\circ = \exp(-\Delta G^\circ_{diss}/RT)$, with $c^\circ$ = 1 M. Hence
$$
K_A = c^\circ\exp\left(-\frac{\Delta G^\circ_{diss}}{RT}\right) = c^\circ\exp\left(+\frac{\Delta G^\circ_{bind}}{RT}\right)
$$
using $\Delta G^\circ_{bind} = -\Delta G^\circ_{diss}$.

**Result.**

- **The operational law.** It is exactly A.9's form under A1-A3.
- **The $K_A$ relation.** It matches only if (i) $K_A$ is expressed in units of $c^\circ$ (A.9 omits $c^\circ$, so its $K_A$ is dimensionless), and (ii) $\Delta G$ is the *dissociation* free energy, which is positive for a stable complex.
    - If $\Delta G$ is the binding (association) free energy, which is negative for favourable binding, then $e^{-\Delta G/RT}$ is the association constant $1/K_A$.
    - Used as a dissociation constant, it would make tighter binding look weaker.
- **Corrected form.** $K_A = c^\circ e^{\Delta G^\circ_{bind}/RT}$.
- **Gaps in the sources.** No source gives values of $\tau$ or $K_A$ for any ligand.

**Checks.**

- *Dimensions.* $\tau$ is dimensionless, and $[L]$ and $K_A$ are concentrations, so $E/E_{max}$ is dimensionless.
- *Maximum.* As $[L] \to \infty$, $E/E_m \to \tau/(1+\tau) < 1$. Full agonists have $\tau \gg 1$.
- *Potency.* Half of the maximum is reached where $\tau[L]/(K_A + (1+\tau)[L]) = \tau/(2(1+\tau))$, which gives
$$
EC_{50} = \frac{K_A}{1 + \tau}
$$
  So $EC_{50} < K_A$: receptor reserve.
- *Limits.* $\tau \to 0$ gives a response of 0 (antagonist). $\tau \to \infty$ gives $E/E_m \to [L]/(K_A/\tau + [L])$, a full response at low occupancy.
- *Consistency.* T1.3, corrected and with $[B] = 0$, reduces to this law. T1.14 and T1.15 use it with pathway-specific $\tau_{arr}$ and $\tau_{Gq}$.

**Lineage.**

- **A.8:** fixed gains ($G_s$, $g_{HCN}$).
- **A.9:** introduced both relations, citing a 2019 Frontiers in Pharmacology receptor-model paper (its ref. 5).
- **A.10:** embeds the form with $\tau_{arr}$ and $\tau_{Gq}$ (Eqs. 1.5-1.6).
- **Aleph:** the lineage table repeats $E/E_{max} = \tau[L]/(K_A + (\tau+1)[L])$.
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 8.1 describes the occupancy-response origin.

**Derivation status.** Exact under the assumptions of the operational model (A1-A3). The $K_A$ relation is incomplete as printed: the reference concentration is missing and the sign convention for $\Delta G$ is unstated. The corrected form is derived in Step 5.

---

## T1.14: Receptor internalization and tachyphylaxis, beta-arrestin-2 biased (inherited: A.10 Eq. 1.5)

**Equation as stated in the latest source** (Model_A10_Comprehensive_Scientific_Report.docx, Eq. 1.5):

$$
\frac{d[R_{surf}]}{dt} = -k_{endo}\left[\frac{\tau_{arr}[L]}{K_A + (\tau_{arr} + 1)[L]}\right][R_{surf}] + k_{recycle}\left(R_{total} - [R_{surf}]\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[R_{surf}]$ | surface receptor density | density (e.g. receptors per µm², or nM) |
| $R_{total}$ | total receptor pool (surface plus internal), conserved | same as $[R_{surf}]$ |
| $k_{endo}$ | maximal endocytosis rate constant | 1/time |
| $k_{recycle}$ | recycling rate constant | 1/time |
| $\tau_{arr}$ | beta-arrestin-2 transducer efficacy | dimensionless |
| $[L]$, $K_A$ | ligand concentration and dissociation constant, as in T1.13 | concentration |
| $\phi_{arr}$ | the bracket: arrestin-pathway operational fraction | dimensionless |

**Physical starting point.** A two-pool trafficking model (surface and internal) with mass-action fluxes. The internalization flux is gated by the arrestin-pathway operational response (T1.13). Aleph Sec. 3 names "clathrin-coated pit assembly kinetics" but gives no formula. Assumptions:

- A1. Receptors are conserved between two pools: $R_{surf} + R_{int} = R_{total}$. Synthesis and degradation are neglected.
- A2. The internalization flux is $k_{endo}\,\phi_{arr}\,R_{surf}$. The fraction of surface receptors engaged by arrestin equals the Black-Leff fraction with efficacy $\tau_{arr}$.
- A3. Recycling is first order in the internal pool, $k_{recycle}R_{int}$.
- A4. Ligand binding equilibrates fast compared with trafficking, so $\phi_{arr}$ is quasi-static.

**Derivation.**

1. *Surface pool balance (A2, A3).*
$$
\frac{dR_{surf}}{dt} = -k_{endo}\,\phi_{arr}\,R_{surf} + k_{recycle}R_{int}
$$

2. *Eliminate $R_{int}$ by conservation (A1).* $R_{int} = R_{total} - R_{surf}$, so
$$
\frac{dR_{surf}}{dt} = -k_{endo}\,\phi_{arr}\,R_{surf} + k_{recycle}(R_{total} - R_{surf})
$$

3. *Insert $\phi_{arr}$ from T1.13 (A2, A4).* $\phi_{arr} = \tau_{arr}[L]/(K_A + (\tau_{arr}+1)[L])$. This gives A.10 Eq. 1.5.

4. *Solve for constant $[L]$.* Collect terms:
$$
\frac{dR_{surf}}{dt} = -\lambda R_{surf} + k_{recycle}R_{total}, \qquad \lambda = k_{endo}\phi_{arr} + k_{recycle}
$$
This linear ODE has the solution
$$
R_{surf}(t) = R^* + (R_{surf}(0) - R^*)e^{-\lambda t}, \qquad R^* = \frac{k_{recycle}R_{total}}{k_{recycle} + k_{endo}\phi_{arr}}
$$

5. *Recovery after washout.* With $\phi_{arr} = 0$ and initial value $R_{min}$:
$$
R_{surf}(t) = R_{total}\left[1 - (1 - R_{min}/R_{total})e^{-k_{recycle}t}\right]
$$

**Result.** A.10 Eq. 1.5 follows exactly from the two-pool balance under A1-A4. The gating law (A2) is the modelling choice. Three points need flagging:

- (i) **No stretched exponential.** A.10 Insight 4 states a stretched-exponential recovery, $R_{total}[1 - (1 - R_{min}/R_{total})\exp(-(t/\tau_{recycle})^{\alpha})]$ with $\alpha = 0.62$, and calls it derived from Eq. 1.5. Eq. 1.5 gives Step 5, which is the $\alpha = 1$ member, with $\tau_{recycle} = 1/k_{recycle}$. A stretched exponential needs a distribution of recycling rates, $\int p(k)e^{-kt}dk$, or anomalous transport. Eq. 1.5 contains neither.
- (ii) **No residency-time mechanism.** The equilibrium Black-Leff fraction depends on $K_A = k_{off}/k_{on}$ only. The ligand residency time $1/k_{off}$ that Insight 4 invokes does not appear, so Eq. 1.5 cannot represent a residency-time threshold.
- (iii) **Fixed efficacy.** In the operational model $\tau = R_0/K_E$ is proportional to receptor density. Internalization should therefore scale $\tau_{arr}$, and $\tau_{Gq}$ in T1.15, by $R_{surf}/R_{total}$. Eq. 1.5 holds $\tau$ fixed.

**Checks.**

- *Dimensions.* $k_{endo}\phi R_{surf}$ and $k_{recycle}(R_{total} - R_{surf})$ both have units of density per time.
- *Invariance of $[0, R_{total}]$.* At $R_{surf} = 0$ the derivative is $k_{recycle}R_{total} > 0$. At $R_{surf} = R_{total}$ it is $-k_{endo}\phi R_{total} \le 0$.
- *Limits.* $[L] = 0$ gives $R^* = R_{total}$. $[L] \to \infty$ gives $\phi \to \tau_{arr}/(1+\tau_{arr})$ and maximal internalization. $\tau_{arr} \to 0$ (an unbiased ligand) gives no internalization.
- *Conservation.* $R_{int} = R_{total} - R_{surf}$ is built in.

**Lineage.**

- **Before A.10:** nothing.
- **A.10 Eq. 1.5:** introduces the equation, with Insight 4 as an asserted stretched-exponential consequence.
- **Aleph:** names "receptor internalization/tachyphylaxis" and clathrin-coated-pit kinetics (Sec. 3.4) without a formula.
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 10.4 notes that fractal or power-law scaling needs an explicit distributional assumption.

**Derivation status.** Phenomenological closure. The two-pool mass balance is exact (A1, A3). The arrestin-gated internalization rate (A2) is a modelling choice. The stretched-exponential claim does not follow from the equation.

---

## T1.15: Gq-biased PLC to IP3 second-messenger generation (inherited: A.10 Eq. 1.6; A.9 cascade)

**Equation as stated in the latest source** (Model_A10_Comprehensive_Scientific_Report.docx, Eq. 1.6):

$$
\frac{d[IP_3]_i}{dt} = k_{PLC}\left[\frac{\tau_{Gq}[L]}{K_A + (\tau_{Gq} + 1)[L]}\right][R_{surf}] - \gamma_{IP3}[IP_3]_i
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[IP_3]_i$ | intracellular IP3 | concentration (µM) |
| $k_{PLC}$ | PLC production constant per active surface receptor | concentration/(time · receptor density) |
| $\tau_{Gq}$ | Gq transducer efficacy | dimensionless |
| $[R_{surf}]$ | surface receptor density (T1.14) | density |
| $\gamma_{IP3}$ | IP3 degradation rate | 1/time |
| $\phi_{Gq}$ | the bracket: Gq operational fraction | dimensionless |

**Physical starting point.** IP3 mass balance. Production is PLC-beta hydrolysis of PIP2, proportional to the number of active Gq-coupled receptors. Removal is by IP3 3-kinase and 5-phosphatase. Assumptions:

- A1. The cytosol is well mixed.
- A2. The PIP2 substrate is in excess, so it is not depleted.
- A3. PLC activity is proportional to the number of active Gq-coupled surface receptors, $\phi_{Gq}R_{surf}$.
- A4. Degradation is first order (both enzymes below saturation).

**Derivation.**

1. *Mass balance (A1).*
$$
\frac{d[IP_3]}{dt} = J_{PLC} - J_{deg}
$$

2. *Production (A2, A3).* $J_{PLC} = k_{PLC}\,\phi_{Gq}\,R_{surf}$, with $\phi_{Gq}$ from T1.13 using efficacy $\tau_{Gq}$.

3. *Degradation (A4).* A Michaelis-Menten removal $V_d[IP_3]/(K_d + [IP_3])$ becomes $\gamma_{IP3}[IP_3]$ with $\gamma_{IP3} = V_d/K_d$ when $[IP_3] \ll K_d$.

4. *Combine.* Steps 1-3 give A.10 Eq. 1.6.

**Result.** The equation matches A.10 under A1-A4. Two points need flagging:

- (i) **Units of $k_{PLC}$.** A.9 wrote $d[IP_3]/dt = k_{PLC}(E/E_{max}) - \gamma_{IP3}[IP_3]$, where $k_{PLC}$ has units of concentration/time. A.10 multiplies by $[R_{surf}]$, which changes the units of $k_{PLC}$ to concentration/(time · density). The two versions' $k_{PLC}$ values are not interchangeable.
- (ii) **Double counting.** In the operational model, $\tau_{Gq}$ already scales with receptor density. Multiplying by $R_{surf}$ as well counts density twice unless $\tau_{Gq}$ is read as a per-receptor efficacy. The sources do not say which.

**Checks.**

- *Dimensions.* $k_{PLC}\phi R_{surf}$ and $\gamma[IP_3]$ both have units of concentration/time.
- *Steady state for constant inputs.*
$$
[IP_3]^* = \frac{k_{PLC}\phi_{Gq}R_{surf}}{\gamma_{IP3}}
$$
- *Combined with T1.14 under sustained ligand.*
$$
[IP_3]^* = \frac{k_{PLC}\phi_{Gq}}{\gamma_{IP3}}\cdot\frac{k_{recycle}R_{total}}{k_{recycle} + k_{endo}\phi_{arr}}
$$
  The Gq signal is attenuated by arrestin-biased internalization. This is the tachyphylaxis mechanism, and a bias toward $\tau_{arr}$ strengthens it.
- *Bound used in T1.17.* Since $\phi_{Gq} \le \tau_{Gq}/(1+\tau_{Gq})$ and $R_{surf} \le R_{total}$:
$$
[IP_3](t) \le \max\left([IP_3](0),\ \frac{k_{PLC}\tau_{Gq}R_{total}}{(1+\tau_{Gq})\gamma_{IP3}}\right)
$$
- *Positivity.* At $[IP_3] = 0$ the derivative is at least 0.

**Lineage.**

- **A.9:** $d[IP_3]_i/dt = k_{PLC}(E/E_{max}) - \gamma_{IP3}[IP_3]_i$ (Model_A9_changes from a8.docx; equation image checked).
- **A.10 Eq. 1.6:** uses the Gq-biased Black-Leff fraction times surface receptors.
- **Aleph:** the lineage table names the "Gq-PLC-IP3-Ca2+ cascade" without a formula.
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 8.2 says the A.9 algebra was not legible to its author. The A.9 equation images are in fact legible and match the form above.

**Derivation status.** Phenomenological closure. The mass balance is exact; the production law (A3) and the first-order degradation (A4) are modelling choices.

---

## T1.16: Intracellular Ca$^{2+}$ with IP3-receptor ER release (inherited: A.9 Gq-PLC-IP3-Ca$^{2+}$ cascade)

**Equation as stated in the latest source** (Model_A9_changes from a8.docx; equation image checked):

$$
\frac{d[Ca^{2+}]_i}{dt} = -\gamma_{Ca}\left([Ca^{2+}]_i - Ca_{rest}\right) + I_{VGCC}(v_d) + k_{IP3}\,[m(IP_3)]^3\,h^3\left([Ca^{2+}]_{ER} - [Ca^{2+}]_i\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[Ca^{2+}]_i$ | free cytosolic Ca$^{2+}$ | µM |
| $\gamma_{Ca}$ | lumped clearance rate | 1/s |
| $Ca_{rest}$ | resting Ca$^{2+}$ | µM |
| $I_{VGCC}(v_d)$ | voltage-gated Ca$^{2+}$ entry at dendritic potential $v_d$. As printed it is a "current", but it must be a flux | must be µM/s |
| $k_{IP3}$ | maximal IP3R flux rate constant | 1/s |
| $m(IP_3)$ | IP3 activation gate; not defined | dimensionless |
| $h$ | inactivation gate; not defined, no dynamics | dimensionless |
| $[Ca^{2+}]_{ER}$ | ER Ca$^{2+}$; no balance equation | µM |

**Physical starting point.** Cytosolic Ca$^{2+}$ mass balance, with fluxes across the plasma membrane and the ER membrane. The IP3R channel open probability follows the De Young-Keizer (1992) model in its Li-Rinzel (1994) reduction. A.9 gives only one sentence. The gating model and the ER balance below are supplied by this derivation, not by any source. Assumptions:

- A1. The cytosol (volume $V_{cyt}$) and the ER (volume $V_{ER}$) are each well mixed.
- A2. Plasma-membrane extrusion, SERCA uptake and leaks are linearized about rest.
- A3. VGCC influx is the Ca$^{2+}$ current converted to a molar flux.
- A4. IP3R flux equals open probability times a passive permeability times the ER-to-cytosol gradient.
- A5. The IP3R has three identical, independent subunits. A subunit conducts only when IP3 is bound, the activating Ca$^{2+}$ site is bound, and the inhibitory Ca$^{2+}$ site is free. IP3 and activating-Ca$^{2+}$ binding are fast; inhibition is slow (gate $h$).
- A6. Fast Ca$^{2+}$ buffering is neglected. Otherwise every flux is multiplied by a buffer factor.

**Derivation.**

1. *Cytosolic balance (A1).*
$$
\frac{d[Ca]_i}{dt} = J_{VGCC} + J_{IP3R} - J_{clear}
$$

2. *Clearance (A2).* Let $J_{clear}([Ca]) = J_{pump}([Ca]) - J_{leak}$, with $J_{clear}(Ca_{rest}) = 0$ by the definition of rest. A first-order Taylor expansion gives
$$
J_{clear} \approx \gamma_{Ca}([Ca]_i - Ca_{rest}), \qquad \gamma_{Ca} = \left.\frac{dJ_{clear}}{d[Ca]}\right\rvert_{Ca_{rest}}
$$

3. *VGCC flux (A3).* $Ca^{2+}$ has valence 2, and an inward current is negative in the outward-positive convention:
$$
J_{VGCC} = -\frac{I_{Ca}(v_d)}{2F\,V_{cyt}}
$$
The printed $I_{VGCC}(v_d)$ must therefore mean this converted and sign-flipped flux.

4. *IP3R flux (A4).*
$$
J_{IP3R} = k_{IP3}\,P_o\,([Ca]_{ER} - [Ca]_i)
$$

5. *Open probability (A5).* Each subunit is open with probability $m_\infty n_\infty h$, where
$$
m_\infty = \frac{[IP_3]}{[IP_3] + d_1},\qquad n_\infty = \frac{[Ca]_i}{[Ca]_i + d_5}
$$
and $h$ is the fraction of subunits whose inhibitory site is free. With three independent subunits:
$$
P_o = m_\infty^3\,n_\infty^3\,h^3
$$

6. *Inactivation gate (A5; Li-Rinzel 1994).*
$$
\frac{dh}{dt} = \frac{h_\infty - h}{\tau_h},\qquad h_\infty = \frac{Q_2}{Q_2 + [Ca]_i},\qquad \tau_h = \frac{1}{a_2(Q_2 + [Ca]_i)},\qquad Q_2 = d_2\frac{[IP_3] + d_1}{[IP_3] + d_3}
$$
Here $d_1$, $d_2$, $d_3$, $d_5$ and $a_2$ are the De Young-Keizer/Li-Rinzel constants. No values are given in any Aleph source.

7. *Compare with A.9.* Steps 1-5 reproduce A.9's structure if $m(IP_3)^3$ is read as $(m_\infty n_\infty)^3$. As printed, A.9 has no Ca$^{2+}$-activation factor $n_\infty$, so Ca$^{2+}$-induced Ca$^{2+}$ release is missing, and $h$ has no dynamics.

8. *ER balance and conservation (A1).* Split the net clearance as $J_{clear} = J_{PM} + J_{SERCA} - J_{ER,leak}$, where $J_{PM}$ is the net plasma-membrane extrusion (pumps minus plasma-membrane leak), $J_{SERCA}$ is SERCA uptake into the ER and $J_{ER,leak}$ is passive leak out of the ER. All fluxes are in cytosolic concentration per time. The ER then obeys
$$
\frac{d[Ca]_{ER}}{dt} = \frac{V_{cyt}}{V_{ER}}\left(J_{SERCA} - J_{IP3R} - J_{ER,leak}\right)
$$
Multiply the cytosolic and ER equations by their volumes and add. ER exchange cancels:
$$
\frac{d}{dt}\left(V_{cyt}[Ca]_i + V_{ER}[Ca]_{ER}\right) = V_{cyt}\left(J_{VGCC} - J_{PM}\right)
$$
Total cell Ca$^{2+}$ therefore changes only through plasma-membrane fluxes. A.9's equation cannot satisfy this without an ER equation, so it implicitly treats the ER as an infinite store at fixed $[Ca]_{ER}$.

**Result.** The A.9 equation is incomplete. The completed system, supplied here and not in the source, is:

$$
\frac{d[Ca]_i}{dt} = -\gamma_{Ca}([Ca]_i - Ca_{rest}) - \frac{I_{Ca}(v_d)}{2FV_{cyt}} + k_{IP3}\,m_\infty^3n_\infty^3h^3([Ca]_{ER} - [Ca]_i)
$$

$$
\frac{dh}{dt} = \frac{h_\infty([Ca]_i, [IP_3]) - h}{\tau_h([Ca]_i, [IP_3])}
$$

$$
\frac{d[Ca]_{ER}}{dt} = \frac{V_{cyt}}{V_{ER}}\left(J_{SERCA} - k_{IP3}\,m_\infty^3n_\infty^3h^3([Ca]_{ER} - [Ca]_i) - J_{ER,leak}\right)
$$

In the first line the linearized clearance $\gamma_{Ca}([Ca]_i - Ca_{rest})$ stands for $J_{PM} + J_{SERCA} - J_{ER,leak}$ (Step 2). Exact conservation (Step 8) holds only if the same $J_{SERCA}$ and $J_{ER,leak}$ appear in both equations, so a simulation should write the cytosolic clearance out in that split form rather than as a single lumped rate.

As far as the Tier 1 sources show, $[Ca^{2+}]_i$ feeds nothing downstream. T1.17 uses IP3, not Ca$^{2+}$.

**Checks.**

- *Dimensions.* $\gamma_{Ca}\times$ concentration, $I/(2FV)$ [A/(C/mol · L) = mol/(L s)] and $k_{IP3}\times$ concentration are all concentration/time.
- *Rest.* With $I_{Ca} = 0$ and $P_o = 0$, $[Ca]_i \to Ca_{rest}$ exponentially at rate $\gamma_{Ca}$.
- *Gradient direction.* $J_{IP3R} > 0$ iff $[Ca]_{ER} > [Ca]_i$, so release always runs down the gradient.
- *Limits.* $[IP_3] \to 0$ gives $m_\infty \to 0$ and no release. High $[Ca]_i$ gives $h_\infty \to 0$, so release terminates. This is the bell-shaped Ca$^{2+}$ dependence of the IP3R.
- *Conservation.* Shown in Step 8 for the completed system.

**Lineage.**

- **A.9:** new (Model_A9_changes from a8.docx, equation image checked). The A.9 text says the ER release is "tracked by the newly introduced intracellular calcium state variable".
- **A.10 and Aleph:** not restated; Aleph names the cascade only.
- **GPT audit:** Model_Aleph_Equation_Derivations_GPT.docx Sec. 8.2 asks for ER exchange and Ca$^{2+}$ conservation checks.

**Derivation status.** Incomplete in source.

- *Missing:* definitions of $m$ and $h$, dynamics for $h$, the Ca$^{2+}$-activation factor, an ER balance, the current-to-flux conversion for $I_{VGCC}$, and any downstream use of $[Ca]_i$.
- *Supplied, labelled as not in source:* Li-Rinzel gating, the ER equation and the conservation law.
- *Status of the printed part:* the clearance term is a linearization (derived under approximations).

---

## T1.17: Floating dendritic (dCaAP) threshold (inherited: A.9)

**Equation as stated in the latest source** (Model_A9_changes from a8.docx; equation image checked):

$$
u_{th}(t) = u_{th,0} - \alpha_{Gq}\log\left(1 + [IP_3]_i\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $u_{th}$ | dCaAP threshold used in T1.11 | mV |
| $u_{th,0}$ | baseline threshold | mV |
| $\alpha_{Gq}$ | coupling coefficient | mV |
| $[IP_3]_i$ | intracellular IP3 (T1.15). It must be dimensionless inside the logarithm, so it is implicitly normalized | as printed, concentration |

**Physical starting point.** None is stated. The A.9 text says "this dynamic calcium pool dictates the dendritic action potential threshold", but the equation uses $[IP_3]_i$, not Ca$^{2+}$. The form is a modelling choice: a threshold lowered by second messengers, with logarithmic saturation. Assumptions:

- A1. Threshold lowering increases monotonically with second-messenger level.
- A2. Lowering is linear for small signals and sublinear (logarithmic) for large ones.
- A3. $[IP_3]_i$ inside the logarithm means $[IP_3]_i/K_{IP3}$ for some reference concentration $K_{IP3}$. The source omits it.

**Derivation.** None; phenomenological. The following properties follow from the form.

1. *Small signal.* For $[IP_3] \ll K_{IP3}$, the expansion $\log(1 + y) = y - y^2/2 + \ldots$ gives
$$
u_{th} \approx u_{th,0} - \alpha_{Gq}[IP_3]/K_{IP3}
$$

2. *Sensitivity.*
$$
\frac{du_{th}}{d[IP_3]} = -\frac{\alpha_{Gq}}{K_{IP3} + [IP_3]}
$$
This is negative and decreasing in magnitude: a Weber-Fechner-like saturation.

3. *Lower bound.* Use the T1.15 bound $[IP_3] \le IP_{max} = k_{PLC}\tau_{Gq}R_{total}/((1+\tau_{Gq})\gamma_{IP3})$ (for $[IP_3](0) \le IP_{max}$). Since $u_{th}$ is decreasing in $[IP_3]$:
$$
u_{th} \ge u_{th,0} - \alpha_{Gq}\log\left(1 + IP_{max}/K_{IP3}\right)
$$
The threshold is bounded below only through the bound on IP3. The logarithm itself is unbounded.

**Result.** As printed the form is phenomenological, with three problems:

- (i) The argument of the logarithm is not dimensionless. The corrected form is $u_{th} = u_{th,0} - \alpha_{Gq}\ln(1 + [IP_3]_i/K_{IP3})$, and the base of the logarithm should be stated.
- (ii) The text names Ca$^{2+}$ but the equation uses IP3. If the prose is right, the Ca-driven version would be $u_{th} = u_{th,0} - \alpha_{Ca}\ln(1 + ([Ca]_i - Ca_{rest})_+/K_{Ca})$. That is a proposal, and it would give T1.16 a downstream role.
- (iii) Nothing prevents $u_{th}$ from falling below the baseline drive. If $u_{th} \le 0$, the dCaAP fires with zero input. A floor $u_{th} \ge u_{min}$, or a saturating form $u_{th,0} - \Delta u_{max}[IP_3]/(K + [IP_3])$, would prevent this. Both are proposals.

**Checks.**

- *Dimensions.* With normalization, $\alpha_{Gq}$ and $u$ are in mV.
- *Limits.* $[IP_3] = 0$ gives $u_{th} = u_{th,0}$. $\alpha_{Gq} = 0$ recovers the A.8 fixed threshold.
- *Effect on T1.11.* A lower $u_{th}$ widens the window $u_{th} \le u < u_{th} + w_{Ca}\ln(1/c)$ in which a single input fires. It also makes the XOR condition $u_1 + u_2 \ge u_{th} + w_{Ca}\ln(1/c)$ easier to satisfy, so Gq signalling changes the logic the dendrite computes.

**Lineage.**

- **A.9:** new (Model_A9_changes from a8.docx), citing work on intracellular calcium stores and synapse-specific plasticity (its ref. 9).
- **A.10 and Aleph:** not restated. Aleph lists the dendritic potential as inherited.

**Derivation status.** Phenomenological closure. The motivation is that second-messenger signalling makes dendritic spikes easier to trigger, giving a "floating threshold" for plasticity (A.9). No quantitative evidence is given. In the source, the driver (IP3 versus Ca$^{2+}$) and the normalization are unresolved.

---

## T1.18: Intracellular sodium debt ledger with driving-force saturation (inherited: A.8 PDF Eq. (5))

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Eq. (5); Model_A8_model only.docx):

$$
\frac{dn_i}{dt} = \left[\nu_{spk} r_i + \nu_{syn} G_s \sum_j W_{ij} x_{ij} r_j + \lambda_n + \frac{I_{ChR2,Na}}{F\cdot Vol_i}\right]\left(1 - \frac{n_i}{n_{eq}}\right) - \Pi_i
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $n_i$ | intracellular Na$^+$ load. A.8 gives mM; A.6 calls it "normalised" | mM |
| $\nu_{spk}$ | Na$^+$ entry per spike, as a concentration increment | mM |
| $\nu_{syn}$ | AMPA Na$^+$ entry per unit synaptic drive. The drive $G_s\sum Wxr$ is in mV (T1.1) | mM/(mV s) |
| $\lambda_n$ | resting Na$^+$ leak, $> 0$ | mM/s |
| $I_{ChR2,Na}$ | Na$^+$ component of the optogenetic photocurrent, counted as a positive inward magnitude | A |
| $F$, $Vol_i$ | Faraday constant; intracellular volume | C/mol; L |
| $n_{eq}$ | "electrochemical equilibrium" load (about 12 mM) | mM |
| $\Pi_i$ | pump extrusion of Na$^+$ (T1.19) | mM/s |

**Physical starting point.** Amount balance of intracellular Na$^+$ (Model_Aleph_Equation_Derivations_GPT.docx Sec. 5.3), with passive influx described by the Goldman-Hodgkin-Katz (GHK) flux equation. Assumptions:

- A1. The intracellular volume is constant and well mixed.
- A2. Each spike moves at least the charge needed to charge the membrane capacitance from rest to peak, and that charge is carried by Na$^+$.
- A3. A fixed fraction of synaptic (AMPA) charge is carried by Na$^+$, proportional to the rate-coded synaptic drive.
- A4. Each passive pathway (spike, synaptic, leak, ChR2) is a GHK flux evaluated at one common effective voltage $\bar V$. This makes the influx linear in $n$ with a common zero at $n_{eq}$.
- A5. Pump extrusion $\Pi_i$ is active and does not depend on the passive driving force. It is given by T1.19, in Na$^+$ units.
- A6. Extracellular Na$^+$ is constant.

**Derivation.**

1. *Amount balance (A1).* With $N_i = Vol_i\,n_i$ moles of Na$^+$, $dN_i/dt = J_{in} - J_{pump}$. Divide by constant $Vol_i$:
$$
\frac{dn_i}{dt} = \frac{J_{in}}{Vol_i} - \Pi_i
$$

2. *Spike term (A2).* One spike needs charge $Q = C_m(V_{peak} - V_{rest})$, where $C_m$ is the total membrane capacitance. That is $Q/F$ moles of Na$^+$, so
$$
\Delta n_{spk} = \frac{C_m(V_{peak} - V_{rest})}{F\,Vol_i}
$$
At rate $r_i$ the flux is $\nu_{spk}r_i$ with $\nu_{spk} = \Delta n_{spk}$. This is the A.8 Inference formula (Model_A8_Scientific_Report.docx). Real entry exceeds this capacitive minimum by an overlap factor of at least 1, because Na$^+$ and K$^+$ currents overlap during the spike (Attwell & Laughlin 2001; Alle et al. 2009).

3. *Synaptic term (A3).* With $f_{Na}$ the Na$^+$ fraction of synaptic charge and $q_0$ the charge per unit drive, the flux is $\nu_{syn}G_s\sum_jW_{ij}x_{ij}r_j$, where $\nu_{syn} = f_{Na}q_0/(F\,Vol_i\,G_s\cdot\text{(drive units)})$. It is written with $G_s$ so that it uses the drive of T1.1.

4. *Leak and optogenetic terms.* The leak $\lambda_n$ is a constant. The ChR2 term converts current to molar flux per volume: $I_{ChR2,Na}/(F\,Vol_i)$, for a monovalent ion ($z_{Na} = 1$, written explicitly in A.5).

5. *GHK flux for one pathway (A4, A6).* The GHK current, outward positive, is
$$
I = P\frac{z^2F^2V}{RT}\cdot\frac{c_i - c_oe^{-zFV/RT}}{1 - e^{-zFV/RT}}
$$
The inward molar flux is $J = -I/(zF)$. With $z = 1$ and $\upsilon = FV/RT$:
$$
J_{in} = P\frac{\upsilon}{1 - e^{-\upsilon}}\left(c_oe^{-\upsilon} - c_i\right)
$$
The prefactor $\upsilon/(1 - e^{-\upsilon})$ is positive for every $\upsilon$, and it tends to 1 as $\upsilon \to 0$.

6. *Factor out the equilibrium concentration.* Define $n_{eq}(V) = c_oe^{-FV/RT}$, the internal concentration at which $E_{Na} = V$:
$$
J_{in} = \underbrace{P\frac{\upsilon}{1-e^{-\upsilon}}\,n_{eq}}_{J_0}\left(1 - \frac{c_i}{n_{eq}}\right)
$$
At fixed $V$ this is *exactly* linear in $c_i$ and vanishes at $c_i = n_{eq}$. If $n_i$ is a load above a baseline $n_0$ (so $c_i = n_0 + n_i$), the same algebra gives $(1 - n_i/(n_{eq} - n_0))$.

7. *All pathways (A4).* Each pathway has the form $J_{0,p}(1 - n/n_{eq,p})$. A common factor requires a common $n_{eq}$, that is, a common effective voltage $\bar V$. Identify $J_{0,p}/Vol_i$ with the bracketed terms of Steps 2-4.

8. *Assemble (A5).* Steps 1-7 give the A.8 equation.

**Result.** The A.8 ledger follows from Na$^+$ amount balance. The driving-force factor $(1 - n/n_{eq})$ is *exact* for a GHK flux at fixed voltage (Steps 5-6). A.8 calls it a "thermodynamic driving-force saturation factor"; this derivation shows its precise meaning. The approximation is to use one $n_{eq}$ for all pathways.

$n_{eq} = 12$ mM implies $\bar V = (RT/F)\ln([Na]_o/12\text{ mM})$. For a textbook extracellular Na$^+$ of about 145 mM, that is about +67 mV, near the spike peak rather than rest. This is consistent with spike-dominated influx, but not with the resting leak or with synaptic entry near rest, whose $n_{eq}$ would be far higher.

Pump coupling: $\Pi_i$ is in Na$^+$ units, and ATP use is $\Pi_i/3$ (T3.3).

**Checks.**

- *Dimensions.* Every bracketed term is in mM/s, the factor is dimensionless, and $\Pi$ is in mM/s.
    - $\nu_{spk}r$: mM times 1/s.
    - $\nu_{syn}\times$ mV: gives mM/s.
    - $\lambda_n$: mM/s.
    - $I/(F\,Vol)$: A/(C/mol · L) = mol/(L s).
- *Forward invariance of $[0, n_{eq}]$ (Nagumo).* Let $f(n) = J(1 - n/n_{eq}) - \Pi(a, n)$, where the bracket $J \ge \lambda_n > 0$ needs $\nu_{spk}, \nu_{syn}G_s \ge 0$, a non-negative drive and $I_{ChR2,Na} \ge 0$.
    - At $n = n_{eq}$: $f = -\Pi(a, n_{eq}) \le 0$ for $a \ge 0$.
    - At $n = 0$: $\Pi(a, 0) = 0$ because $m(0, K_n) = 0$ (T1.19), so $f = J \ge \lambda_n > 0$.
    - For a scalar ODE with locally Lipschitz $f$, these boundary signs make $[0, n_{eq}]$ forward-invariant (Nagumo's theorem).
    - Delayed rates do not change the argument, because the boundary signs hold for every history (A.6).
- *Lean.* `sodium_ledger_upper_invariant` and `sodium_boundary_invariant` prove the upper boundary sign. `sodium_ledger_lower_invariant` proves the lower one, but it uses `positivity` on $\nu_{syn}G_s\cdot$drive while the parameter structure has no sign hypotheses on $\nu_{syn}$ or $G_s$ (Model_A8_FormalVerification.lean). That step needs added hypotheses $\nu_{syn} \ge 0$ and $G_s \ge 0$.
- *Unique steady state for frozen inputs.* On $(0, n_{eq})$ the influx $J(1 - n/n_{eq})$ decreases strictly from $J$ to 0. The pump $\Pi_{max}m(a)\,n/(n + K_n)$ increases strictly from 0 (for $a > 0$). Their difference changes sign exactly once, so there is a unique $n^* \in (0, n_{eq})$.
- *Zero ATP.* At $a = 0$, $\Pi = 0$ and $n \to n_{eq}$ from below. This matches A.6 P1 (maximum 11.45 below 12 after 600 s of zero supply).
- *Interaction with T1.20.* Firing fails near $n_c = 4$ mM, which lies inside $[0, n_{eq}]$. At $n = n_{eq}$ the rate gate is $1/(1 + 3^6) = 1/730$.

**Lineage.**

- **Model A:** no Na$^+$ state; $P_{ATP} \approx \Delta G_{ATP}/(3q_e)\lvert I_{Na}\rvert$ (Model_A_Changelog_Audit_and_Fixes.md).
- **A.2:** introduces $\dot n = \nu_{spk}r + \nu_{syn}G\sum Wxr + \lambda_n - \Pi$.
- **A.3:** adds optogenetic loading.
- **A.5 Eq. 7:** writes the ChR2 term as $I_{ChR2}/(z_{Na}F\,Vol_i)$.
- **A.4 validation:** finds $n$ unbounded at zero ATP.
- **A.6 Eq. 5 (change C10):** adds $(1 - n_i/n_{eq})$. The A.8 lineage box credits A.7, which conflicts with A.6's own change table.
- **A.7 Eq. 5 and A.8 Eq. (5):** unchanged; Lean `dn_dt` in all three Lean files.
- **Aleph:** "sodium debt ledger" inherited.

**Derivation status.** Derived under approximations:

- one well-mixed compartment;
- capacitive minimum charge per spike;
- a lumped Na$^+$ fraction of synaptic charge;
- GHK flux at one common effective voltage for all pathways (exact for each pathway separately at its own voltage);
- active pump extrusion independent of driving force.

---

## T1.19: Na$^+$/K$^+$-ATPase pump rate, dual Michaelis-Menten (inherited: A.8 PDF Eq. (6))

**Equation as stated in the latest source** (Model_A8_Scientific_Report.pdf Eq. (6); Model_A8_model only.docx):

$$
\Pi_i = \Pi_{max}\, m(a_i, K_a)\, m(n_i, K_n), \qquad m(z, K) = \frac{z}{z + K}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Pi_i$ | Na$^+$ extrusion rate | mM/s (Na$^+$) |
| $\Pi_{max}$ | maximal extrusion rate | mM/s |
| $a_i$, $K_a$ | ATP and its half-saturation constant (about 0.15 mM, A.8) | mM |
| $n_i$, $K_n$ | Na$^+$ load and its half-saturation constant (about 10 mM, A.8) | mM |

Stoichiometry: 1 ATP : 3 Na$^+$ out : 2 K$^+$ in.

**Physical starting point.** Rapid-equilibrium kinetics of a two-substrate enzyme (Michaelis-Menten generalized to random-order binding). A.8 gives only "dual Michaelis-Menten kinetics". Assumptions:

- A1. ATP and Na$^+$ bind at independent sites, in random order, in rapid equilibrium, with no interaction between sites.
- A2. Na$^+$ binding is represented by one effective site with constant $K_n$.
- A3. Only the fully loaded complex turns over, with rate constant $k_{cat}$.
- A4. Extracellular K$^+$, ADP/P$_i$ product inhibition and membrane voltage are neglected.

**Derivation.**

1. *States and weights (A1, A2).* The four states E, E·ATP, E·Na and E·ATP·Na have weights $1$, $a/K_a$, $n/K_n$ and $(a/K_a)(n/K_n)$. The last weight is a plain product because the sites do not interact.

2. *Turnover (A3).*
$$
v = k_{cat}E_T\,\frac{(a/K_a)(n/K_n)}{1 + a/K_a + n/K_n + (a/K_a)(n/K_n)}
$$

3. *Factor the denominator.*
$$
1 + \frac{a}{K_a} + \frac{n}{K_n} + \frac{a}{K_a}\frac{n}{K_n} = \left(1 + \frac{a}{K_a}\right)\left(1 + \frac{n}{K_n}\right)
$$

4. *Simplify.*
$$
v = k_{cat}E_T\,\frac{a/K_a}{1 + a/K_a}\cdot\frac{n/K_n}{1 + n/K_n} = k_{cat}E_T\,\frac{a}{a + K_a}\cdot\frac{n}{n + K_n}
$$

5. *Convert to Na$^+$ units.* Each cycle exports 3 Na$^+$, so $\Pi_{max} = 3k_{cat}E_T$ (per unit volume). This gives the A.8 form.

**Result.** The product of two Michaelis-Menten factors is exact for independent rapid-equilibrium binding (A1-A3), and it matches A.8. The real pump binds three intracellular Na$^+$ ions cooperatively. Replacing $m(n, K_n)$ by $n^{h}/(n^{h} + K_n^{h})$ with $h > 1$ would be more faithful, but that is a proposal; no source gives a Hill coefficient. A4 also removes any feedback from extracellular K$^+$ $k_c$ (T2.13) onto the pump.

**Checks.**

- *Dimensions.* $m(\cdot)$ is dimensionless, so $\Pi$ has the units of $\Pi_{max}$.
- *Positivity and bounds.* For $a, n \ge 0$, $0 \le \Pi < \Pi_{max}$. Positivity is used in the T1.18 invariance proof; the Lean `pump_rate` lemmas prove non-negativity.
- *Monotonicity.*
$$
\frac{\partial\Pi}{\partial a} = \Pi_{max}\,\frac{K_a}{(a+K_a)^2}\,m(n) \ge 0, \qquad \frac{\partial\Pi}{\partial n} = \Pi_{max}\,m(a)\,\frac{K_n}{(n+K_n)^2} \ge 0
$$
  Strict monotonicity in $n$ gives the unique Na$^+$ steady state in T1.18.
- *Limits.* $a \to 0$ or $n \to 0$ gives $\Pi \to 0$. $a, n \gg K$ gives $\Pi \to \Pi_{max}$.
- *Energy coupling.* ATP consumption is $\Pi/3$ (T3.3), consistent with Step 5.
- *Temperature.* The A.8 pigeon branch uses $\Pi_{max}(T_b) = \Pi_{max,0}Q_{10}^{(T_b - 37)/10}$, which is multiplicative and leaves the form unchanged.

**Lineage.**

- **A.2:** $\Pi = \Pi_{max}m(e)m(n)$ on lumped energy.
- **A.5 Eq. 8:** unchanged.
- **A.6 Eq. 6:** adds "3 Na$^+$ per ATP".
- **A.7 Eq. 6:** unchanged.
- **A.8:** PDF Eq. (6) and docx, with $K_a \approx 0.15$ mM and $K_n \approx 10$ mM; Lean `pump_rate`/`pump`.
- **Aleph:** inherited within the sodium ledger.

**Derivation status.** Derived under approximations: independent rapid-equilibrium sites, one effective Na$^+$ site (no cooperativity), and no dependence on extracellular K$^+$, products or voltage.

---

## T1.20: Firing-rate transfer function with Na-gradient failure gate (inherited: A.8 Tier 1)

**Equation as stated in the latest source** (Model_A8_model only.docx; A.6 Eq. 7):

$$
r_i = \left[1 + \left(\frac{n_i}{n_c}\right)^6\right]^{-1} h_K(k_c)\cdot\Phi\left(g(NE)\left(v_i - \theta_i - w_i - \theta_0 - \theta_{AIS,i}\right)\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $r_i$ | firing rate | Hz |
| $n_c$ | critical Na$^+$ load (about 4 mM). The same symbol is the node activity in T2.1, which is a clash | mM |
| $h_K(k_c)$ | extracellular-K$^+$ factor; its form is never given | dimensionless |
| $k_c$ | extracellular K$^+$ at the capillary node (T2.13) | mM |
| $\Phi$ | sigmoid transfer function; its form is never given. It must carry Hz if $r$ is in Hz | Hz |
| $g(NE)$ | noradrenergic gain; its form is never given | 1/mV |
| $\theta_i$ | fast homeostatic threshold (T1.21) | mV |
| $w_i$ | adaptation (T1.8); must be in mV here | mV |
| $\theta_0$ | baseline threshold | mV |
| $\theta_{AIS,i}$ | AIS shift (T4.5) | mV |

**Physical starting point.** None in the sources. The rate law is a constitutive closure. A.8 interprets it as follows: above $n_c$ the cell enters depolarization block from loss of the Na$^+$ reversal gradient; $h_K$ captures K$^+$ effects; $\Phi$ is a sigmoid whose slope is set by noradrenergic arousal. Assumptions:

- A1. The population rate is a sigmoidal function of the somatic potential minus an effective threshold. A Wilson-Cowan-type population with distributed thresholds gives this form, where the sigmoid is the threshold distribution function.
- A2. Thresholds add: homeostatic, adaptive, baseline and structural shifts are subtracted from $v_i$.
- A3. Noradrenaline multiplies the slope (gain modulation; Servan-Schreiber et al. 1990).
- A4. Failure from Na$^+$ loading and the K$^+$ effect act multiplicatively.
- A5. The rate follows $v_i$ instantaneously (no rate dynamics).

**Derivation.** None for the overall form. It is a phenomenological closure, and no derivation is invented here. Two exact properties of the Na$^+$ gate can be shown.

1. *Logistic form of the gate.* Write $(n/n_c)^6 = \exp(6\ln(n/n_c))$. Then
$$
\left[1 + (n/n_c)^6\right]^{-1} = \frac{1}{1 + \exp(6\ln(n/n_c))}
$$

2. *Rewrite in terms of the Na$^+$ reversal (if $n$ is the internal concentration).* With $E_{Na}(n) = (RT/F)\ln([Na]_o/n)$:
$$
\ln(n/n_c) = -\frac{F}{RT}\left(E_{Na}(n) - E_{Na}(n_c)\right)
$$

3. *Substitute Step 2 into Step 1.*
$$
\left[1 + (n/n_c)^6\right]^{-1} = \frac{1}{1 + \exp\left(-\dfrac{E_{Na}(n) - E_{Na}(n_c)}{RT/(6F)}\right)}
$$
This is a logistic function of the Na$^+$ reversal potential with slope $RT/(6F) \approx 4.5$ mV at 37 °C. The Hill exponent 6 therefore sets how sharply firing fails as $E_{Na}$ collapses. As the exponent goes to infinity the gate becomes the step $\mathcal{H}(n_c - n)$.

4. *Gate values.* The gate is $1/2$ at $n = n_c$, with slope $-6/(4n_c) = -1.5/n_c$ there. At $n_{eq} = 12$ mM it is $1/(1 + 729) = 1/730$.

**Result.** This is a phenomenological closure, and it matches A.8. Steps 1-3 support the A.8 interpretation, with one caveat. The $E_{Na}$ identity requires $n$ to be the total intracellular concentration. A critical value of 4 mM lies below typical resting intracellular Na$^+$, so $n$ must be an *excess* load (A.6 calls it "normalised"). In that case Step 2 holds only approximately.

**Incompleteness.** None of $h_K$, $\Phi$ or $g(NE)$ is defined, and the direction of the K$^+$ effect is inconsistent between sources:

- Model A (Model_A_Biological_Neuroenergetics_Specification.pdf) says $h_K$ is a smooth *non-increasing* gate that shuts spiking as $k$ approaches $k_{ceil} \approx 12$ mM.
- A.8 says it represents *hyperexcitability* under K$^+$ accumulation.
- A form consistent with Model A would be $h_K(k) = [1 + \exp((k - k_{ceil})/s_k)]^{-1}$. That is a proposal.

The dual use of $w_i$ (see T1.8) means adaptation is counted both here and as a conductance in Eq. 5.1, with incompatible units.

**Checks.**

- *Dimensions.* The argument of $\Phi$ is $g(NE)$ [1/mV] times mV, which is dimensionless. $r$ has the units of $\Phi$ (Hz), and the gates are dimensionless.
- *Bounds.* $0 \le r_i \le \Phi_{max}h_K$, and $r_i \to 0$ as $n_i$ becomes large.
- *Sensitivity to thresholds.* $\partial r/\partial\theta_i = -[\text{gate}]\,h_K\,g\,\Phi' \le 0$. This sign is what makes T1.21 a negative-feedback controller.
- *Limits.* $n_i \ll n_c$ gives a gate of 1. With $g(NE) \to 0$ the rate becomes flat at $\Phi(0)$, independent of $v$.

**Lineage.**

- **Model A:** $r = h_K(k_Q)\phi_\tau(g_\tau(NE)(v - \theta - a - \Delta\theta(e)))$ (Model_A_Changelog_Audit_and_Fixes.md; Model A spec Eq. (2)).
- **A.2:** adds $[1 + (n/n_c)^6]^{-1}$ and drops $\Delta\theta(e)$, which is replaced by the K_ATP conductance.
- **A.5 Eq. 5:** unchanged.
- **A.6 Eq. 7:** adds $\theta_{AIS}$.
- **A.7 Eq. 7 and A.8:** unchanged.
- **Aleph:** "firing-rate transfer" inherited.

**Derivation status.** Phenomenological closure, and incomplete in source because $h_K$, $\Phi$ and $g(NE)$ are undefined. The motivation is sigmoidal population f-I curves, NE gain modulation, and failure through depolarization block as the Na$^+$ gradient collapses. The Hill-6 gate is shown exactly equivalent to a logistic in $E_{Na}$ (Steps 1-3). The exponent 6 itself has no stated evidence.

---

## T1.21: Energy-aware fast homeostatic threshold (inherited: A.8 Tier 1 inline; $\chi$ form from A.7 annex Eq. 31)

**Equation as stated in the latest source** (Model_A8_model only.docx for the controller; A.6/A.7 Eq. 31 for $\chi$):

$$
\tau_\theta \frac{d\theta_i}{dt} = r_i - \rho_i\,\chi(a_i/a_0), \qquad \chi(e) = \frac{e^4}{e^4 + e_h^4}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\theta_i$ | homeostatic threshold | mV |
| $\tau_\theta$ | controller constant. With $\theta$ in mV and $r$ in Hz it has units 1/mV, not time (see Checks) | 1/mV |
| $\rho_i$ | target-rate parameter; A.6 gives $\ln\rho_i \sim N(\mu_\rho, \sigma_\rho^2)$ | Hz |
| $\chi(e)$ | energy scaling of the set point | dimensionless |
| $a_0$ | reference ATP | mM |
| $e_h$ | half-point of $\chi$ in normalized ATP | dimensionless |

**Physical starting point.** Integral control of firing rate (intrinsic homeostatic plasticity), with a set point that falls when energy falls. No source derives the form. A.2 motivates it: "set point falls with ATP so a supply cut lowers the target" and the controller does not fight the K_ATP brake. Assumptions:

- A1. The threshold integrates the rate error.
- A2. The target is $\rho_i\chi(a_i/a_0)$, with Hill-4 energy scaling. This is a modelling choice.
- A3. The threshold moves slowly compared with $v_i$ and $r_i$.

**Derivation.** The controller form is a modelling choice and is not derived. Its consequences can be.

1. *Steady state.* $d\theta_i/dt = 0$ gives
$$
r_i^* = \rho_i\,\chi(a_i^*/a_0)
$$
This is A.2 Property 5. The equilibrium rate follows the energy state.

2. *Local stability with other states frozen.* By T1.20, $\partial r/\partial\theta = -\kappa$ with $\kappa = [\text{gate}]\,h_K\,g\,\Phi' \ge 0$. Linearizing about $\theta^*$:
$$
\tau_\theta\frac{d\delta\theta}{dt} = -\kappa\,\delta\theta
$$
The fixed point is exponentially stable when $\kappa > 0$, with time constant $\tau_\theta/\kappa$.

3. *Loss of authority (windup).* If the gate or $h_K$ is 0 (Na$^+$ failure or K$^+$ shutdown), then $\kappa = 0$ and $r = 0 < \rho\chi$. The derivative is then $d\theta/dt = -\rho\chi/\tau_\theta < 0$, so $\theta$ falls without bound. Model A projected $\theta$ onto $[\theta_{min}, \theta_{max}]$; A.8 dropped the projection.

4. *Interaction with the AIS controllers.* The threshold enters $r$ only through $S = \theta_i + w_i + \theta_0 + \theta_{AIS,i}$. Following A.6 P8, assume the AIS proxy satisfies $\bar c_i = 1$ exactly when $r_i = r_i^*$.
    - *Pure-integral AIS controller:* $dL/dt = F_L(\bar c)$ with $F_L(1) = 0$. At equilibrium only $r(S) = r^*$ is imposed. That fixes $S$ but not how $S$ splits between $\theta_i$ and $\theta_{AIS}(L)$. Every pair $(\theta_i, L)$ with $\theta_i + \theta_{AIS}(L)$ fixed is an equilibrium: a continuum. With the T4.5 law $\theta_{AIS} = -k_B\ln(L/L_0) - \ldots$, the conserved combination is $\theta_i - k_B\ln L$. A.6 P8 writes "$\theta + k_B\ln L$ fixed", which is a sign slip (see T4.5).
    - *Leaky AIS controller:* $\tau_L\,dL/dt = -(L - L_0) + F_L(\bar c)$, and likewise for $x$ and $g_{AIS}$ (T4.2-T4.4). At $\bar c = 1$ this forces $L = L_0$, $x = x_0$ and $g = g_0$, so $\theta_{AIS} = 0$ by T4.5. Then $r(\theta) = r^*$ has a unique solution for $\theta$ when $\kappa > 0$ ($r$ strictly decreasing in $\theta$). The equilibrium is unique, as A.6 P8 states and the A.8 Lean AIS fixed-point theorems record.

**Result.** The form matches A.8 (controller) and A.6/A.7 Eq. 31 (the $\chi$ law). The A.8 inline statement omits the explicit $\chi$ formula. Two corrections:

- (i) $\chi(1) = 1/(1 + e_h^4)$, so at normal ATP the target is $\rho_i/(1 + e_h^4)$, not $\rho_i$. $\rho_i$ is the set point only if $e_h \ll 1$.
- (ii) The units of $\tau_\theta$ (see Checks).

**Checks.**

- *Dimensions.* $[\tau_\theta]\cdot$mV/s $= $ Hz requires $[\tau_\theta] = $ 1/mV. A dimensionally clean form is $T_\theta\,d\theta/dt = V_\theta(r - \rho\chi)/\rho_{ref}$, with $T_\theta$ a time and $V_\theta$ a voltage scale.
- *Energy limits.* $a \to 0$ gives $\chi \to 0$, so the target goes to 0. The controller then *raises* $\theta$ when $r > 0$, which reinforces the K_ATP brake instead of opposing it. $a \gg e_ha_0$ gives $\chi \to 1$. A.2 reports that with a fixed set point the ischaemia test drove ATP to 0.04 and Na$^+$ to 4.5, past collapse. With $\chi$ the rate fell from 3.6 to 1.6 Hz with ATP at 0.27 (Model A.2 Repaired Specification and Validation.docx, Property 5).
- *Monotonicity of $\chi$.*
$$
\chi'(e) = \frac{4e^3e_h^4}{(e^4 + e_h^4)^2} > 0
$$

**Lineage.**

- **Model A:** $\tau_\theta\dot\theta = r - \rho_\tau$, projected onto bounds (Model_A_Changelog_Audit_and_Fixes.md).
- **A.2:** energy-aware $\chi(e)$.
- **A.5 Eq. 15:** unchanged.
- **A.6 Eq. 31:** adds $\ln\rho_i \sim N(\mu_\rho, \sigma_\rho^2)$.
- **A.7 annex Eq. 31:** last statement of the $\chi$ form.
- **A.8:** inline without $\chi$.
- **Aleph:** not named separately; it feeds T1.20.

**Derivation status.** Phenomenological closure. The motivation is homeostatic intrinsic plasticity with an energy-scaled set point, so that the controller and the K_ATP brake agree. The evidence is the A.2 ischaemia comparison and the A.6 P8 uniqueness check. Steady state, stability, windup and the uniqueness condition are derived here.

---

## Summary of Tier 1 status

| Key | Equation | Status | Main issues found |
|---|---|---|---|
| T1.1 | Somatic potential (Eq. 5.1) | Derived under approximations | normalization by $g_L$ undeclared; $G_s$ is mV s, not a conductance; $I_i$ undefined and must be a rate to share $G_s$; current-based synapses beside conductance-based K$^+$ terms |
| T1.2 | Woodhull NMDA block (Eq. 5.2) | Derived under approximations | equilibrium block, not trapping; $\delta_{Mg}$ is a concentration; no glutamate gating; outward-positive sign conflicts with T1.10; A.10 Insight 2 ratio inverted |
| T1.3 | GABA_A allosteric law (Eq. 5.3) | Incomplete in source | ellipsis (supplied from A.10); $\tau_s$ missing in the numerator (maximum $1/(1+\tau)$ instead of $\tau/(1+\tau)$; fails to reduce to T1.13); $\beta_s$, $f_s(x)$, $x$ undefined; no link to $I_{GABA}$ |
| T1.4 | Cx36 Laplacian (Eq. 5.4) | Exact | point of entry into any membrane equation not stated; normalization of $g_{gap}$ |
| T1.5 | Transporter ledger (Eq. 5.5) | Derived under approximations | $R_{release}$ unspecified; cleft versus voxel concentration unstated |
| T1.6 | K_ATP law | Phenomenological closure | $K_A$ symbol clash; ATP-only regulation |
| T1.7 | Axial/ephaptic current | Exact | one $g_{ax}$ symbol for normalized and physical equations; sign dropped in the A.6 strong-coupling limit |
| T1.8 | Adaptation | Phenomenological closure | $w_i$ used as both conductance factor and threshold (double counting, units) |
| T1.9 | Tsodyks-Markram resource | Derived under approximations | not restated since A.5; mean-field (exact only for Poisson input) |
| T1.10 | Dendritic potential | Derived under approximations; incomplete | $\bar A_{Ca}$ in mV added to currents; NMDA sign; $I_{AMPA}$, $u_{d,i}$, GABA coupling undefined; delays and weights dropped in A.10 |
| T1.11 | dCaAP activation | Phenomenological closure | discontinuous at threshold; XOR conditions derived |
| T1.12 | D1 inverted-U pair | Phenomenological closure | $s_{np}$ multiplies no written term; inverted U has a non-zero floor; claimed Black-Leff replacement never written |
| T1.13 | Black-Leff and $K_A(\Delta G)$ | Exact (operational model); $K_A$ relation incomplete | missing $c^\circ$; $\Delta G$ sign convention |
| T1.14 | Receptor internalization | Phenomenological closure | gives a pure exponential, not the claimed stretched exponential; no residency-time dependence; $\tau_{arr}$ should scale with $R_{surf}$ |
| T1.15 | Gq-PLC-IP3 | Phenomenological closure | units of $k_{PLC}$ changed from A.9; possible double counting of receptor density |
| T1.16 | Ca$^{2+}$ with IP3R release | Incomplete in source | $m$, $h$ undefined; no $h$ dynamics; no Ca activation; no ER balance or Ca conservation; current-to-flux factor missing; no downstream use |
| T1.17 | Floating dCaAP threshold | Phenomenological closure | IP3 not normalized; text says Ca, equation uses IP3; no floor |
| T1.18 | Na$^+$ ledger | Derived under approximations | factor exact for GHK at fixed voltage; one $n_{eq}$ for all pathways (implies about +67 mV); Lean lower-bound proof lacks sign hypotheses |
| T1.19 | Na$^+$/K$^+$ pump | Derived under approximations | non-cooperative Na$^+$ binding; no extracellular K$^+$ dependence |
| T1.20 | Rate transfer function | Phenomenological closure; incomplete | $h_K$, $\Phi$, $g(NE)$ undefined; $h_K$ direction contradictory between Model A and A.8; $n$ must be an excess load |
| T1.21 | Homeostatic threshold | Phenomenological closure | $\tau_\theta$ has units 1/mV; $\chi(1) \neq 1$; integrator windup when gates close; uniqueness needs leaky AIS controllers |
