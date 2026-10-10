# Tier 6: Plasticity, epigenetics and decay

## Overview

Tier 6 holds the slowest state variables of Aleph 1 (Model A.10.1). They run on timescales from minutes (synaptic tags) through days (sleep cycles, TrkB-driven set-point remodelling) to years (epigenetic silencing, AQP4 degradation, development). Aleph 1 prints three Tier 6 equations: Eq. 5.10 (HDAC operator, T6.1), Eq. 5.11 (hydraulic floor, T6.2) and Eq. 4.1 (glucocorticoid stress rate, T6.3). Its Sec. 3 states the Kramers forgetting law (T6.10). Its lineage table declares the rest active: headroom, condensate capture SDE, circadian pruning tensor, ontogenetic tensor, AQP4 degradation, TrkB-BDNF synaptogenesis and the hydraulic floor (`Model_Aleph_1_only equations.docx`; `Model_Aleph_1_Comprehensive_Scientific_Report.docx`). Each inherited equation is taken from the most recent source that writes it out, as listed in `00_Equation_Inventory.md`.

The tier has five functional blocks:

| Block | Keys | What it does |
|---|---|---|
| Energy-limited learning | T6.4 weight rule, T6.5 headroom, T6.6 supply gate and eviction, T6.7 tag and persistence | three-factor plasticity whose summed weight cost cannot exceed a territory's budget |
| Consolidation and forgetting | T6.8 capture SDE, T6.9 energy gate, T6.10 Kramers power law | tagged synapses are captured into a bistable condensate; noise-driven escape gives power-law forgetting |
| Sleep | T6.11 sleep downscaling, T6.12 Ado/NE gate, T6.13 circadian switch, T6.14 adenosine, T6.15 REM jump, T6.16 glymphatic velocity | wake accumulation, gated relaxation in NREM, projected REM jump, adenosine clearance |
| Development and pathology | T6.17 ontogenetic tensor, T6.18 angiogenesis, T6.19 AQP4 polarity, T6.2 hydraulic floor | growth of wiring and vessels; loss of AQP4 polarity and of trans-endfoot water conductivity |
| Neurotrophic and epigenetic | T6.3 GR stress rate, T6.1 HDAC operator, T6.20 TrkB, T6.21 set point | stress silences BDNF; serotonin drives TrkB; TrkB raises the synaptic set point |

**Couplings to other tiers.**

- **From Tier 1.** Firing rates $r_i$ (T1.20) enter the eligibilities $f^\pm_{ij}$ (T6.4, T6.7). No source defines these functions; Model A writes $f^\pm(r_i, r_j)$. The synaptic serotonin $[5\text{-}HT]_{syn}$ is the $[M]_{syn}$ of the transporter ledger (T1.5) and drives T6.20.
- **To Tier 1.** The weights $W_{ij}$ (T6.4) enter the somatic drive (T1.1) and the Na$^+$ load (T1.18).
- **From Tier 2.** Noradrenaline enters the sleep gate (T6.12) and the glymphatic velocity (T6.16). The Tier 2 file proposes $[NE](t) = \overline{NE} + a_{NE}\,\mathrm{Re}\,NE_{LC}(t)$ (T2.2). The oscillation amplitude $\mathcal{A}_{NE}$ can be tied to the Stuart-Landau radius $\rho^\ast = \sqrt{\lambda_{eff}}$; no source states this link. A.9 and A.10 describe perivascular transport with $J_v$ and $Pe$ (T2.16, T2.17), and no source says whether $v_{glymph}$ (T6.16) is retired.
- **To Tier 2.** $L_p$ (T6.2) sets the trans-endfoot part of the perivascular resistance. The Tier 2 file proposes $R_{PVS}^{tot} = R_{PVS} + 1/(L_pS_{ef})$ (T2.16, Step 9). New vessel edges (T6.18) change the graph of T2.1.
- **From and to Tier 3.** ATP $a_i$ enters the capture gate $\pi$ (T6.9), the acetylation term of T6.1 and the TrkB drive (T6.20). The territory demand $D_k$ (T3.3) defines the A.8 headroom (T6.5). In return, the weight-maintenance cost $\beta\sum W$ and the plasticity costs $\kappa\sum\lvert\dot W\rvert$ and $\kappa_c\sum\dot c^+$ are charged to the ATP ledger (T3.3). The pump flux $\Pi$ (T1.19) produces adenosine (T6.14). Node oxygen $o_c$ (T3.1) drives angiogenesis (T6.18).
- **To Tier 4.** Developmental age $t_g$, the clock of T6.17, sets the AIS baseline $L_0(t_g)$ in T4.2.
- **From Tier 5.** $[Ca^{2+}]_e$ (T5.3) is the printed driver of AQP4 degradation (T6.19).
- **Inside Tier 6.** There are three chains:
  - T6.3 → T6.1 → T6.20 → T6.21 → T6.11;
  - T6.13 → T6.11 and T6.21;
  - T6.19 → T6.2 and T6.16 → T6.14 → T6.12 → T6.11.

**Symbol clashes to carry through.**

| Symbol | Tier 6 meaning | Other meaning |
|---|---|---|
| $\tau_w$ | weight time constant (T6.4) | adaptation time constant (T1.8) |
| $\tau_c$, $c$ | capture time constant and variable (T6.8) | AIS Ca$^{2+}$ proxy (T4.1) |
| $\beta_c$ | capture self-recruitment gain (T6.8) | capillary dilation gain (T2.14) |
| $\beta$ | energy cost per unit weight (T6.5, T6.6, T6.15) | used in many gains elsewhere |
| $\psi$ | salience gate (T6.4, T6.6) | pericyte state (T2.14) |
| $\Pi_Q$ | total potentiation drive of territory $Q$ (T6.6) | pump flux summed over $Q$ (T6.14, A.5 Eq. 23) |
| $\pi$, $\pi_R$ | capture energy gate (T6.9); REM pruning strength (T6.15) | |
| $\lambda$ | polarity decay constant (T6.2) | $\lambda_Q$ projection (T6.15), $\lambda_u$ uptake (T6.14), $\lambda_{eff}$ (T2.2) |
| $\sigma$ | logistic function $1/(1+e^{-x})$ | $\sigma_c$ capture noise amplitude (T6.8) |
| $\rho$ | cell density (T6.17) | set-point rate $\rho_i$ (T1.21), LC radius $\rho$ (T2.2) |
| $\eta$ | developmental noise (T6.17); adenosine yield (T6.14) | $\eta_R$ REM rate (T6.15) |
| $P$ | persistence $P_{ij}$ (T6.7); retention $P(t)$ (T6.10) | AQP4 polarity $P_{AQP4}$ (T6.19) |
| $k$ | A.3 sleep rate (= $k_{down}$) | A.3 also uses $k$ for synapses per neuron |

**Conventions.**

- "Reconstructed" marks a derivation step that no source contains. Each is built from a named standard result.
- "Proposal" marks a form that no source states.
- "Computed here" marks a number obtained in this work by evaluating the source equations with values stated in the sources, or with illustrative values that are labelled as such. It is not a source claim.
- The logistic function is $\sigma(x) = 1/(1+e^{-x})$. Note that $1/(1+e^{x}) = 1 - \sigma(x)$.
- Time units follow the sources: hours for sleep (A.3), days for epigenetics (Aleph Table 3). The plasticity equations are written in units of $\tau_w$ or $\tau_c$.

**Parameter values stated in the sources.**

| Quantity | Value | Source |
|---|---|---|
| $k_{stress}$ (d$^{-1}$) | fly 0, zebrafish 0.020, mouse 0.080, rat 0.060, macaque 0.010, human 0.003, pigeon 0.015 | Aleph Table 3 |
| $K_{d,GR}$; $n_H$ | 2.4 nM (human), 4.8 nM (rodent), "measured in vitro"; $n_H\approx1.8$ | Aleph Sec. 4.1 (no citation given) |
| basal $P_{AQP4}$ | fly 0, zebrafish 0.45, mouse 0.86, rat 0.88, macaque 0.92, human 0.94, pigeon 0.72 | Aleph Table 3 |
| zebrafish wake gain $g_w$ | 1.65 synapses/h | A.3 (Suppermpool et al. 2024 data) |
| zebrafish sleep rate $k$ | 0.069 h$^{-1}$ (fit) | A.3 |
| SWS factor $\delta$ | 0.20 | A.2 (de Vivo 2017 fit) |
| REM pruning band | $1 + \pi_R w_p/(4s_w) = 1.94$ "at the default values" | A.2 |
| adenosine clearance time constant | 0.56 h (fit; "too fast") | A.4 validation report |
| forgetting exponents | 0.499 and 0.250 simulated (predicted 0.5, 0.25); $P\propto t^{-0.35}$ | A.3; A.8 PDF |
| zolpidem | $\mathcal{A}_{NE}$ down 78%, glymphatic exchange down 47% | A.8 report |
| pre-dawn barrier | $\Delta U_{eff}$ up 45% in the last 2 h before dawn | A.8 report, Inference 4 |
| Aleph test #57 | mouse $P_{AQP4}$: 0.86 → 0.41 (model 0.44) | Aleph validation table |
| Aleph tests #25, #66 | striatal spine deficit −44.0%; A.10 −18.5% (failed); A.10.1 −42.8% | Aleph validation table |

---

## T6.1: Epigenetic HDAC chromatin condensation operator and BDNF silencing (Aleph Eq. 5.10)

**Equation as stated in Aleph 1.** Eq. 5.10 of `Model_Aleph_1_only equations.docx`, identical in `Model_Aleph_1_Comprehensive_Scientific_Report.docx`:

$$
\tau_{epig}\frac{dH_{HDAC}}{dt} = k_{stress}\,F_{chronic\_stress} - k_{acetyl}\,a_i\,H_{HDAC}, \qquad k_{BDNF,eff} = \frac{k_{BDNF}}{1 + \exp\left(\gamma_{silence}(H_{HDAC} - \theta_{epig})\right)}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $H_{HDAC}$ | HDAC2/5 chromatin-condensation index at BDNF promoters. Never defined in the source; taken here as a normalized, non-negative index | dimensionless (proposal) |
| $\tau_{epig}$ | "time constant". Must be dimensionless for the equation to be consistent with Table 3 (Step 4) | see Step 4 |
| $k_{stress}$ | stress integration rate, from Eq. 4.1 (T6.3) | d$^{-1}$ (Aleph Table 3) |
| $F_{chronic\_stress}$ | chronic-stress forcing. Never defined; taken here as an exposure index in $[0,1]$ | dimensionless (proposal) |
| $k_{acetyl}$ | acetylation (decondensation) rate per unit ATP | d$^{-1}$ mM$^{-1}$ (implied) |
| $a_i$ | neuronal ATP (T3.2) | mM |
| $k_{BDNF}$ | maximal BDNF/TrkB coupling of T6.20 (fully open chromatin) | units of T6.20 |
| $k_{BDNF,eff}$ | effective coupling after silencing | same as $k_{BDNF}$ |
| $\gamma_{silence}$ | logistic slope | 1/[H] |
| $\theta_{epig}$ | half-silencing index | [H] |

**Physical starting point.** Chronic stress and glucocorticoids recruit class I/IIa histone deacetylases (HDAC2, HDAC5) to neurotrophin promoters. Deacetylation condenses chromatin and lowers BDNF transcription; HDAC5 and chronic social defeat are the classic example (Tsankova et al. 2006). Histone acetyltransferases (HATs) reverse this. Their substrate, nuclear acetyl-CoA, is made by ATP-citrate lyase (ACLY), which consumes one ATP per acetyl-CoA (Wellen et al. 2009). This is the only biochemical route by which ATP can enter a decondensation rate. The source gives no derivation; GPT §7.4 calls the form "a driven, first-order state equation" with "a logistic repression function". Assumptions:

- A1. One well-mixed index $H$ describes the condensed fraction of the relevant promoter sites.
- A2. Condensation is driven by stress at a rate that does not depend on $H$. This is the low-occupancy limit: few sites are condensed.
- A3. Decondensation is first order in $H$. Its rate is proportional to the acetyl-CoA supply, and that supply is proportional to ATP in the unsaturated (first-order) limit of ACLY kinetics.
- A4. Each promoter is in fast equilibrium between an open state O and a condensed state C. The free-energy difference between them is linear in $H$.
- A5. BDNF/TrkB coupling is proportional to the open fraction, because transcription comes only from open promoters and the downstream steps are quasi-steady.

**Derivation.**

*Part A. The state equation (Reconstructed: low-occupancy mass action).*

1. *Site balance.* Let $x\in[0,1]$ be the condensed fraction of $N_T$ sites. Condensation acts on open sites at rate $k_+(t)$; decondensation acts on condensed sites at rate $k_-(t)$:
$$
\frac{dx}{dt} = k_+(t)\,(1 - x) - k_-(t)\,x
$$

2. *Low occupancy (A2).* For $x\ll1$, $k_+(1-x) = k_+ - k_+x \approx k_+$, with relative error $x$:
$$
\frac{dx}{dt} \approx k_+(t) - k_-(t)\,x
$$

3. *ATP dependence of decondensation (A3).* With the other substrates saturating, ACLY runs at $v = V_{ACLY}\,a/(K_{ATP} + a)$. For $a\ll K_{ATP}$ this is $v \approx (V_{ACLY}/K_{ATP})\,a$. HAT activity scales with this acetyl-CoA flux, so $k_- = \tilde k_{acetyl}\,a$. The sources give no $K_{ATP}$. Whether millimolar ATP is in the linear regime is therefore not established, and the linear factor $a_i$ remains a modelling choice.

4. *Map to the printed form.* Set $H \equiv x$, $k_+ = k_{stress}F/\tau_{epig}$ and $\tilde k_{acetyl} = k_{acetyl}/\tau_{epig}$, then multiply Step 2 by $\tau_{epig}$. The result is the printed first relation. This step fixes the units:
    - Every term of $\tau_{epig}\,dH/dt = k_{stress}F - \dots$ must carry the units of $\tau_{epig}[H]/\mathrm{time}$.
    - Table 3 gives $k_{stress}$ in d$^{-1}$, and Eq. 4.1 makes $k_{stress} = k_{transloc}\times$(occupancy), also a rate.
    - With $H$ and $F$ dimensionless, $[k_{stress}F] = \mathrm{d}^{-1}$, so $[\tau_{epig}] = 1$.
    
    So $\tau_{epig}$ cannot be a time constant. It is a dimensionless factor, and it is redundant with the two rates. The consistent form is
$$
\frac{dH}{dt} = k_{stress}F - k_{acetyl}\,a_i\,H
$$
   with $k_{acetyl}$ in d$^{-1}$ mM$^{-1}$. The alternative is to keep $\tau_{epig}$ as a time and make $k_{stress}F$ dimensionless, which contradicts Table 3 and Eq. 4.1.

*Part B. Exact solution of the state equation (no further assumptions).*

5. *Standard form.* Divide the printed relation by $\tau_{epig}$:
$$
\frac{dH}{dt} + \lambda_H(t)\,H = \frac{k_{stress}F(t)}{\tau_{epig}}, \qquad \lambda_H(t) = \frac{k_{acetyl}\,a_i(t)}{\tau_{epig}}
$$

6. *Integrating factor.* Let $\Lambda(t,s) = \int_s^t\lambda_H(u)\,du$. By the product rule, $\frac{d}{dt}\left[H e^{\Lambda(t,0)}\right] = \left(\dot H + \lambda_H H\right)e^{\Lambda(t,0)}$. Integrate from 0 to $t$ and multiply by $e^{-\Lambda(t,0)}$:
$$
H(t) = H(0)\,e^{-\Lambda(t,0)} + \int_0^t\frac{k_{stress}F(s)}{\tau_{epig}}\,e^{-\Lambda(t,s)}\,ds
$$

7. *Constant inputs.* With $a_i$ and $F$ constant, $\Lambda(t,s) = \lambda_H(t-s)$ and the integral is elementary:
$$
H(t) = H^\ast + \left(H(0) - H^\ast\right)e^{-\lambda_H t}, \qquad H^\ast = \frac{k_{stress}F}{k_{acetyl}\,a_i}, \qquad \lambda_H^{-1} = \frac{\tau_{epig}}{k_{acetyl}\,a_i}
$$

8. *Onset latency.* Start from $H(0)=0$ and solve $H(t_\theta) = \theta_{epig}$ in Step 7. Then $1 - e^{-\lambda_Ht_\theta} = \theta_{epig}/H^\ast$, so
$$
t_\theta = -\frac{1}{\lambda_H}\ln\left(1 - \frac{\theta_{epig}}{H^\ast}\right)
$$
   This requires $H^\ast > \theta_{epig}$. For $H^\ast\gg\theta_{epig}$, expand $\ln(1-z)\approx -z$: $t_\theta \approx \theta_{epig}/(\lambda_H H^\ast) = \tau_{epig}\theta_{epig}/(k_{stress}F)$. In the strong-drive regime, the species rate $k_{stress}$ of Table 3 therefore sets the onset latency directly, which differs 27-fold between mouse (0.080 d$^{-1}$) and human (0.003 d$^{-1}$).

9. *Recovery.* Remove stress at $t_{off}$ ($F=0$). Step 7 with $H^\ast=0$ gives $H(t) = H(t_{off})e^{-\lambda_H(t - t_{off})}$. $H$ falls back below threshold after $t_{rec} = \lambda_H^{-1}\ln\left(H(t_{off})/\theta_{epig}\right)$. Recovery time does not depend on $k_{stress}$ at all. "Multi-year" persistence therefore needs $\lambda_H^{-1}$ of order years, a value no source gives.

*Part C. Logistic repression (Reconstructed: two-state Boltzmann occupancy).*

10. *Two-state occupancy (A4).* Let the open and condensed states have free energies $G_O$ and $G_C$. The Boltzmann probability of the open state is
$$
p_O = \frac{e^{-G_O/k_BT}}{e^{-G_O/k_BT} + e^{-G_C/k_BT}} = \frac{1}{1 + e^{-(G_C - G_O)/k_BT}}
$$
   The second form follows from dividing numerator and denominator by $e^{-G_O/k_BT}$.

11. *Linear free-energy dependence.* Write $G_C - G_O = \Delta g_0 - g_1H$ with $g_1>0$, so condensation becomes more favourable as $H$ rises. Substitute into Step 10:
$$
p_O = \frac{1}{1 + \exp\left(\frac{g_1H - \Delta g_0}{k_BT}\right)} = \frac{1}{1 + \exp\left(\gamma_{silence}(H - \theta_{epig})\right)}, \qquad \gamma_{silence} = \frac{g_1}{k_BT}, \qquad \theta_{epig} = \frac{\Delta g_0}{g_1}
$$

12. *Coupling (A5).* $k_{BDNF,eff} = k_{BDNF}\,p_O$. This is the printed second relation.

13. *Steady-state composition.* Insert $H^\ast$ from Step 7:
$$
k_{BDNF,eff}^\ast = \frac{k_{BDNF}}{1 + \exp\left(\gamma_{silence}\left(\frac{k_{stress}F}{k_{acetyl}a_i} - \theta_{epig}\right)\right)}
$$
   Its sensitivity to ATP follows from $\ln k^\ast_{BDNF,eff} = \ln k_{BDNF} - \ln\left(1 + e^{\gamma(H^\ast-\theta)}\right)$ and $dH^\ast/d\ln a_i = -H^\ast$:
$$
\frac{d\ln k_{BDNF,eff}^\ast}{d\ln a_i} = \gamma_{silence}H^\ast\,(1 - p_O) > 0
$$
   Energy failure therefore deepens silencing. This is a Tier 3 → Tier 6 coupling the sources do not mention.

**Result.** Under A1-A5 both relations follow: the first as low-occupancy mass action (Steps 1-4), the second as two-state Boltzmann occupancy (Steps 10-12). They do not match Aleph 1 exactly:

- (i) **Units.** $\tau_{epig}$ must be dimensionless, given $k_{stress}$ in d$^{-1}$ (Step 4). The consistent form is $dH/dt = k_{stress}F - k_{acetyl}a_iH$.
- (ii) **$H$ and $F$ are undefined.** If $H$ is meant as a bounded fraction, the low-occupancy step has to be undone. The bounded form is then $\tau\,dH/dt = k_{stress}F(1-H) - k_{acetyl}a_iH$ (from Step 1). Its steady state $H^\ast = k_{stress}F/(k_{stress}F + k_{acetyl}a_i)$ lies in $[0,1)$.
- (iii) **Link to T6.20 is not stated.** It is implied: Invariant 7 ($\Xi_{BDNF}$, Aleph Sec. 9.1) writes $k_{BDNF}/(1+\exp(\gamma_{silence}(H_{HDAC}-\theta)))$ in the TrkB numerator. $k_{BDNF,eff}$ therefore replaces $k_{BDNF}$ in T6.20.
- (iv) **Normalization of $k_{BDNF}$.** $k_{BDNF}$ is the fully open maximum. At $H=0$ the coupling is $k_{BDNF}/(1+e^{-\gamma_{silence}\theta_{epig}})$, not $k_{BDNF}$.
- (v) **Stress is counted twice.** If $[CORT]_{free}$ in Eq. 4.1 carries the stress signal, $F$ can only be a duty cycle (the fraction of time under stress). Otherwise stress enters twice.
- (vi) **No hysteresis.** The state equation is linear and the repression is monotone. Taken alone, Eq. 5.10 has one globally attracting equilibrium for constant inputs, and no hysteresis (see T6.21, Step 9).

**Checks.**

- *Dimensions.* As printed, $[\tau_{epig}][H]/\mathrm{d}$ on the left against d$^{-1}$ on the right. This is consistent only if $\tau_{epig}$ is dimensionless (Step 4). $\gamma_{silence}(H-\theta_{epig})$ is dimensionless.
- *Positivity.* At $H=0$, $dH/dt = k_{stress}F/\tau_{epig}\ge0$, so $H\ge0$ is forward invariant.
- *Limits.*
    - $F=0$: $H\to0$ with rate $\lambda_H$.
    - $a_i\to0$ (energy failure): removal stops and $H$ grows linearly without bound, $H = H(0) + k_{stress}Ft/\tau_{epig}$. Silencing becomes irreversible.
    - $\gamma_{silence}\to0$: $k_{BDNF,eff}\to k_{BDNF}/2$ for every $H$.
    - $\gamma_{silence}\to\infty$: a hard switch at $\theta_{epig}$.
- *Stability.* The linearization has the single eigenvalue $-\lambda_H<0$.
- *Data.* Tests #25 and #66 cannot be reproduced: no source gives $\tau_{epig}$, $k_{acetyl}$, $\gamma_{silence}$, $\theta_{epig}$ or $F$.

**Lineage.**

- New in Aleph 1 (A.10.1). The lineage table describes it as the "Epigenetic HDAC2/5 chromatin condensation operator (dH_HDAC/dt) for multi-year chronic depressive modeling". There is no precursor in A.1-A.10.
- It was added after the A.10 failure of validation test #25 (striatal spine deficit −18.5% against −44.0% observed, "Missing Epigenetic HDAC"). With it, test #66 gives −42.8% (`Model_Aleph_1_Comprehensive_Scientific_Report.docx`, validation table).
- The GPT audit (`Model_Aleph_Equation_Derivations_GPT.docx`, §7.4) asks for a defined unit of $H$ and calls the logistic phenomenological.

**Derivation status.** Phenomenological closure. Both relations can be reconstructed from mass action and two-state thermodynamics (Steps 1-12), but three choices are modelling choices: what $H$ and $F$ represent, the linear ATP dependence, and the linear free-energy dependence on $H$. As printed, the equation is also incomplete in source: the units of $H$, $F$ and $\tau_{epig}$ are undefined and $\tau_{epig}$ is dimensionally redundant, and the substitution into T6.20 is not stated. The evidence offered is the single validation pair #25/#66.

---

## T6.2: Regularized non-singular hydraulic floor for AQP4-dependent conductivity (Aleph Eq. 5.11)

**Equation as stated in Aleph 1.** Eq. 5.11, identical to A.10 Eq. 6.3:

$$
L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp\left(\lambda\,(P_{AQP4}(t) - 1)\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $L_p$ | trans-astrocytic (endfoot) hydraulic conductivity | m Pa$^{-1}$ s$^{-1}$ |
| $L_{p,0}$ | conductivity at full polarity | m Pa$^{-1}$ s$^{-1}$ |
| $L_{p,min}$ | floor (AQP4-independent conductivity) | m Pa$^{-1}$ s$^{-1}$ |
| $\lambda$ | polarity sensitivity ("decay constant") | dimensionless |
| $P_{AQP4}$ | AQP4 polarity index (T6.19) | dimensionless, nominally $[0,1]$ |

**Physical starting point.** Water crosses the astrocytic endfoot sheath by two parallel routes. One goes through AQP4 channels concentrated at the perivascular membrane; the other is AQP4-independent (lipid bilayer, inter-endfoot gaps). Volume flux obeys the hydraulic (Starling) law $J_w = L_pS\,\Delta p$, ignoring osmotic terms. Conductances of parallel routes add, as for parallel resistors (Kirchhoff). Assumptions:

- A1. $L_p = L_{indep} + L_{AQP4}(P)$, with parallel routes.
- A2. At full polarity, $L_p(1) = L_{p,0}$.
- A3. $L_{AQP4}(P) = L_{AQP4}(1)\,e^{\lambda(P-1)}$. This is a constitutive choice (A.9), with constant relative sensitivity $d\ln L_{AQP4}/dP = \lambda$.

**Derivation.**

1. *Parallel routes (A1).* $L_p(P) = L_{indep} + L_{AQP4}(P)$.
2. *Normalization (A2).* At $P=1$, $L_{p,0} = L_{indep} + L_{AQP4}(1)$, so $L_{AQP4}(1) = L_{p,0} - L_{indep}$.
3. *Name the floor.* Set $L_{indep}\equiv L_{p,min}$. Then $L_{AQP4}(1) = L_{p,0} - L_{p,min}$.
4. *Constitutive map (A3).* Substitute $L_{AQP4}(P) = (L_{p,0} - L_{p,min})e^{\lambda(P-1)}$ into Step 1. This gives the printed form.
5. *Where the exponential comes from.* A3 is equivalent to $dL_{AQP4}/dP = \lambda L_{AQP4}$: each unit loss of polarity removes the same fraction of the AQP4 conductance. Channel counting gives something different. If $P$ is the fraction of AQP4 at the endfoot and the channels act in parallel, then $L_{AQP4} = (L_{p,0}-L_{p,min})P$, which is linear. The exponential is a stronger (convex) dependence than channel counting, and it is a modelling choice.
6. *Bounds (exact).* For $\lambda>0$ the map $P\mapsto e^{\lambda(P-1)}$ is increasing. On $P\in[0,1]$ it takes values in $[e^{-\lambda}, 1]$. Multiply by $L_{p,0}-L_{p,min}>0$ and add $L_{p,min}$:
$$
L_{p,min} + (L_{p,0} - L_{p,min})e^{-\lambda} \le L_p \le L_{p,0}
$$
7. *Monotonicity.* $dL_p/dP = \lambda(L_{p,0} - L_{p,min})e^{\lambda(P-1)} > 0$.
8. *Floor for any $P$.* For every real $P$, $e^{\lambda(P-1)}>0$, so $L_p > L_{p,min}$. This matters because T6.19 as printed lets $P_{AQP4}$ fall below 0 (T6.19, Step 3).
9. *Link to the perivascular resistance (Proposal; missing in source).* The A.9 text says lower $L_p$ "drastically increases $R_{PVS}$" but gives no relation. The Tier 2 file (T2.16, Step 9) proposes a series combination with endfoot area $S_{ef}$:
$$
R_{PVS}^{tot} = R_{PVS} + \frac{1}{L_pS_{ef}} \le R_{PVS} + \frac{1}{L_{p,min}S_{ef}}
$$
   The inequality follows from Step 8.
10. *Why the floor was needed.* Without the floor (A.9), $1/L_p = e^{\lambda(1-P)}/L_{p,0}$:
    - On $P\in[0,1]$ this is bounded by $e^{\lambda}/L_{p,0}$. The A.9 form is already non-singular there, but its stiffness ratio $\max L_p/\min L_p = e^{\lambda}$ is large for large $\lambda$.
    - If $P\to-\infty$, $1/L_p\to\infty$ exponentially.
    
    The "$R_{PVS}\to\infty$" singularity cited by A.10 ("solver stiffness singularities ($R_{PVS}\to\infty$)") therefore needs one of two things. Either $P_{AQP4}$ goes far below 0, which the printed T6.19 allows: its steady state $1 - k_{toxic}\mathcal H\mathcal F_{inflam}/k_{recover}$ is unbounded below as the inflammatory drive grows (T6.19, Step 3). Or $\lambda$ is very large. With the floor, the stiffness ratio is at most $L_{p,0}/L_{p,min}$ whatever $P$ does.

**Result.** The printed form follows exactly from A1-A3, and it matches A.10 Eq. 6.3. The bounds (Step 6), monotonicity (Step 7) and positivity for any $P$ (Step 8) are exact. Missing from the source:

- the $L_p\to R_{PVS}$ relation (supplied in Step 9 as a proposal);
- the requirement $\lambda>0$, $L_{p,0}>L_{p,min}\ge0$ (also noted in GPT §7.3).

The floor treats a symptom whose cause is the non-invariance of $[0,1]$ in T6.19. Invariant 3 ($\Lambda_{glymph}$) uses $L_{p,0}$, not $L_p(P_{AQP4})$, so it ignores both the polarity and the floor.

**Checks.**

- *Dimensions.* Both terms are in units of $L_p$; $\lambda(P-1)$ is dimensionless if $\lambda$ is.
- *Limits.*
    - $L_{p,min}\to0$ recovers A.9.
    - $\lambda\to0$ gives $L_p\equiv L_{p,0}$, with no AQP4 dependence.
    - $P=1$ gives $L_{p,0}$.
    - $P=0$ gives $L_{p,min} + (L_{p,0}-L_{p,min})e^{-\lambda}$.
- *Species.* At the basal polarities of Table 3, the AQP4 part is reduced by $e^{-\lambda(1-P)}$: by $e^{-0.06\lambda}$ in human and $e^{-0.55\lambda}$ in zebrafish. Under test #57 (mouse, 0.86 → 0.41) it drops by a further $e^{-0.45\lambda}$. Neither $\lambda$ nor $L_{p,min}$ is given in any source.

**Lineage.**

- A.9 (`Model_A9_changes from a8.docx`, equation image): $L_p = L_{p,0}e^{\lambda(P_{AQP4}-1)}$, no floor.
- A.10 Eq. 6.3 (`Model_A10_Comprehensive_Scientific_Report.docx`) adds $L_{p,min}$ "to prevent solver stiffness singularities ($R_{PVS}\to\infty$) in 3xTg-AD".
- Aleph Eq. 5.11 is identical; the lineage table records "regularized hydraulic floor ($L_p\ge L_{p,min}$)".

**Derivation status.** Phenomenological closure. The exponential map from polarity to conductivity is constitutive, and channel counting would give a linear map (Step 5). The parallel-route split (Steps 1-4) and all the bounds (Steps 6-8) are exact.

---

## T6.3: Glucocorticoid-receptor stress integration rate (Aleph Eq. 4.1)

**Equation as stated in Aleph 1.** Eq. 4.1, Sec. 4.1 "First-Principles Epigenetic Stress Derivation":

$$
k_{stress} = k_{transloc}\cdot\left[\frac{([CORT]_{free})^{n_H}}{(K_{d,GR})^{n_H} + ([CORT]_{free})^{n_H}}\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $k_{stress}$ | stress integration rate (enters T6.1) | d$^{-1}$ (Table 3) |
| $k_{transloc}$ | nuclear import rate constant of liganded GR | d$^{-1}$ |
| $[CORT]_{free}$ | free glucocorticoid (cortisol in primates, corticosterone in rodents) | nM |
| $K_{d,GR}$ | GR dissociation constant: 2.4 nM human, 4.8 nM rodent (source, "measured independently in vitro", no citation) | nM |
| $n_H$ | Hill coefficient, $\approx1.8$, "of receptor homodimerization" (source) | dimensionless |

**Physical starting point.** Ligand binding to a receptor in quasi-equilibrium (mass action), followed by first-order nuclear import of the liganded receptor. Cooperativity is represented by the Hill equation (Hill 1910), the limit of fully concerted binding; a non-integer $n_H$ is an empirical interpolation (Weiss 1997). Assumptions:

- A1. Binding is fast compared with import, so occupancy is at equilibrium.
- A2. Binding is described by a Hill function.
- A3. Import is first order in liganded cytoplasmic receptor, with rate constant $k_{transloc}$.
- A4. The cytoplasmic pool is not depleted: import is slow compared with export and recycling.
- A5. $k_{stress}$ is identified with the import rate per cytoplasmic receptor.

**Derivation.**

*Part A. Hill occupancy (A1, A2).*

1. *Concerted binding.* $R + nL \rightleftharpoons RL_n$ with overall dissociation constant $K^n$. Mass action gives $[RL_n] = [R][L]^n/K^n$.
2. *Fraction bound.* Divide by $[R]_{tot} = [R] + [RL_n]$, then divide numerator and denominator by $[R]$:
$$
\theta = \frac{[L]^n/K^n}{1 + [L]^n/K^n} = \frac{[L]^n}{K^n + [L]^n}
$$
   With $[L] = [CORT]_{free}$, $K = K_{d,GR}$ and $n = n_H$ this is the bracket of Eq. 4.1.
3. *Non-integer $n_H$.* For two coupled sites (a dimer), $1\le n_H\le2$. $n_H = 1.8$ means strong but incomplete cooperativity. The Hill form is exact only for $n_H = 1$ (one site) or for complete concertedness, so for $n_H=1.8$ it is an approximation.

*Part B. Explicit monomer-dimer model and comparison with the Hill form (Reconstructed; computed here).*

4. *Model.* Each GR monomer binds one steroid independently: $\theta_1 = L/(L+K_d)$. Liganded monomers dimerize, $2\,RL\rightleftharpoons(RL)_2$, with dissociation constant $K_{dim}$. Let $M$ be all monomers. Mass action and conservation of receptor $R_T$ give
$$
D = \frac{(\theta_1M)^2}{K_{dim}}, \qquad R_T = M + 2D
$$
5. *Solve for $M$.* Write $m = M/R_T$, $q = R_T/K_{dim}$ and $\alpha = 2q\theta_1^2$. Dividing the conservation law by $R_T$ gives $m + \alpha m^2 = 1$. The root in $[0,1]$ is
$$
m = \frac{-1 + \sqrt{1+4\alpha}}{2\alpha} = \frac{2}{1 + \sqrt{1+4\alpha}}
$$
   The second form comes from multiplying numerator and denominator by $1 + \sqrt{1+4\alpha}$.
6. *Dimer fraction.* With $s = \sqrt{1+4\alpha}$,
$$
f_D = \frac{2D}{R_T} = 1 - m = \frac{s - 1}{s+1} = \frac{4\alpha}{(1+s)^2}
$$
   The last form uses $s - 1 = 4\alpha/(s+1)$.
7. *Low-dose limit.* For $\alpha\ll1$, $s\approx1$ and $f_D\approx\alpha = 2q\theta_1^2\approx2q(L/K_d)^2$. The log-log slope is 2: dimerization of independently liganded monomers produces cooperativity only at low occupancy.
8. *Effective Hill coefficient at half-maximum (computed here).* Normalize $f_D$ by its value at saturation and evaluate $d\ln[g/(1-g)]/d\ln L$ at $g = 1/2$:

| $q = R_T/K_{dim}$ | $f_{D,max}$ | EC$_{50}/K_d$ | Hill slope at EC$_{50}$ |
|---|---|---|---|
| 0.01 | 0.019 | 2.34 | 1.18 |
| 0.1 | 0.146 | 1.87 | 1.20 |
| 1 | 0.500 | 0.89 | 1.27 |
| 10 | 0.800 | 0.31 | 1.31 |
| 100 | 0.932 | 0.10 | 1.33 |

   The slope over the mid-range is 1.2-1.3 for any dimerization strength. An apparent $n_H\approx1.8$ at half-occupancy would need ligand binding itself to be cooperative (a dimer with higher affinity than the monomer), not just dimerization after binding. The source's attribution of $n_H$ to "homodimerization" is therefore not supported by the minimal dimerization mechanism.

*Part C. From occupancy to a rate (A3-A5).*

9. *Import flux.* The liganded cytoplasmic receptor is $\theta\,GR_c$. With first-order import (A3), $J_{imp} = k_{transloc}\,\theta\,GR_c$.
10. *Per-receptor rate (A5).* $J_{imp}/GR_c = k_{transloc}\theta \equiv k_{stress}$. This is Eq. 4.1.
11. *With export (relaxing A4).* $dGR_n/dt = k_{transloc}\theta\,(GR_T - GR_n) - k_{exp}GR_n$. Its steady state is
$$
\frac{GR_n^\ast}{GR_T} = \frac{k_{stress}}{k_{stress} + k_{exp}}
$$
   It approaches $k_{stress}/k_{exp}$, linear in $k_{stress}$, only when $k_{stress}\ll k_{exp}$. So T6.1's forcing, which is linear in $k_{stress}$, also needs this condition. It does not follow from Eq. 4.1 alone.

**Result.** Eq. 4.1 follows from A1-A5 together with the Hill approximation. The "first-principles" label in the source overstates it:

- The Hill coefficient is empirical (Step 3).
- The stated dimerization mechanism gives 1.2-1.3 at mid-range, not 1.8 (Step 8).
- Identifying $k_{stress}$ with an import rate is a modelling choice (A5).

Table 3 cannot be checked against Eq. 4.1, because no source gives $[CORT]_{free}$ or $k_{transloc}$ for any species. A consistency calculation (computed here) assumes a common $k_{transloc}$ and the low-occupancy limit, where $\theta\approx(C/K_d)^{n_H}$. The Table 3 ratios would then need these free-glucocorticoid ratios:

- mouse/human: $2\times(0.080/0.003)^{1/1.8} = 12.4$;
- rat/human: 10.6;
- macaque/human: $(0.010/0.003)^{1/1.8} = 1.95$.

The factor 2 is the $K_d$ ratio 4.8/2.4.

Read literally as nuclear import, which in cell studies proceeds within minutes to an hour after steroid exposure (general knowledge, not from the sources), $k_{transloc}$ is many orders of magnitude larger than Table 3's $10^{-3}$-$10^{-1}$ d$^{-1}$. The occupancies would then be tiny. Equivalently, $k_{stress}$ is an effective integration rate, not an import rate.

**Checks.**

- *Dimensions.* The bracket is dimensionless, so $[k_{stress}] = [k_{transloc}]$ = time$^{-1}$, which agrees with Table 3.
- *Limits.*
    - $C\to0$: $k_{stress}\to0$, so no stress means no HDAC drive.
    - $C = K_{d,GR}$: $k_{stress} = k_{transloc}/2$.
    - $C\to\infty$: $k_{stress}\to k_{transloc}$.
    - $n_H = 1$: hyperbolic binding.
- *Monotonicity.* $dk_{stress}/dC = k_{transloc}\,n_H\,C^{n_H-1}K^{n_H}/(K^{n_H}+C^{n_H})^2>0$.
- *Fly.* Table 3 gives $k_{stress}=0$ for the fly. This is consistent with no GR pathway, $k_{transloc}=0$.

**Lineage.**

- New in Aleph Sec. 4.1 of both Aleph files. It replaces "an empirical fitting rate".
- No precursor in A.1-A.10.
- The GPT audit (§7.5) calls it "a phenomenological cooperative-binding approximation".

**Derivation status.** Derived under approximations:

- quasi-equilibrium binding;
- the Hill form with an empirical, non-integer $n_H$;
- import-limited kinetics without depletion;
- identification of $k_{stress}$ with the per-receptor import rate.

The species values in Table 3 are not reproducible from the equation (inputs missing).

---

## T6.4: Three-factor synaptic weight dynamics with headroom gate and eviction (inherited: A.8 PDF Eq. (17); Aleph: synaptic headroom)

**Equation as stated in the latest source.** Eq. (17) of `Model_A8_Scientific_Report.pdf`, identical in `Model_A8_model only.docx`, A.6 Eq. 32 and A.7 annex Eq. 32:

$$
\tau_w\frac{dW_{ij}}{dt} = (1 - b_m)\left[(s_Q + \psi(1 - s_Q))\,DA^+ f^+_{ij}(w_{max} - W_{ij}) - (1 + DA^-)\,f^-_{ij}W_{ij} - E_{ij}\right] - \gamma(1 - P_{ij})W_{ij}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $W_{ij}$ | weight of synapse $j\to i$, in $[0, w_{max}]$ | dimensionless |
| $\tau_w$ | plasticity time constant (clashes with adaptation, T1.8) | time |
| $b_m$ | "activity-dependent learning brake" (A.8). Never defined in any version; taken in $[0,1]$ | dimensionless |
| $DA^+$, $DA^-$ | positive and negative parts of the dopamine prediction error, both $\ge0$ | dimensionless |
| $f^+_{ij}$, $f^-_{ij}$ | potentiation and depression eligibilities, $\ge0$. Never defined; Model A writes $f^\pm(r_i, r_j)$ | dimensionless |
| $s_Q$ | headroom supply gate of territory $Q$ (T6.6) | dimensionless, $[0,1]$ |
| $\psi$ | salience gate (clashes with the pericyte state, T2.14) | dimensionless, $[0,1]$ |
| $w_{max}$ | soft ceiling | as $W$ |
| $E_{ij}$ | eviction (T6.6) | as $W$ |
| $\gamma$ | decay rate of unprotected weight, in units of $1/\tau_w$ | dimensionless |
| $P_{ij}$ | persistence, $\max(\Omega_{ij}, c_{ij})$ (T6.7) | dimensionless, $[0,1]$ |

**Physical starting point.** The rule combines five ingredients:

- a three-factor learning rule, in which Hebbian eligibility is gated by a neuromodulator (Izhikevich 2007; Frémaux & Gerstner 2016);
- soft bounds, where potentiation scales with the remaining room and depression with the weight (van Rossum, Bi & Turrigiano 2000);
- an energetic gate on potentiation (A.2);
- matched eviction of the least-protected synapses (A.2);
- decay of synapses that are neither tagged nor captured, as in synaptic tagging and capture (Frey & Morris 1997).

None of the sources derives the rule; it is assembled. Assumptions:

- A1. $f^\pm_{ij}\ge0$ and $DA^\pm\ge0$.
- A2. Soft bounds: potentiation $\propto(w_{max}-W)$, depression $\propto W$.
- A3. Depression runs at a baseline rate and is enhanced by negative prediction error, giving the factor $(1+DA^-)$.
- A4. Potentiation is multiplied by $g_Q = s_Q + \psi(1-s_Q)$.
- A5. The brake $b_m\in[0,1]$ is the same for all synapses of a territory $Q$; it is written $b_Q$ below. This is needed for exact cancellation (Step 15).
- A6. $E_{ij}\ge0$ and $E_{ij}\propto W_{ij}$ (T6.6).
- A7. Decay acts outside the brake, because decay is not learning.

**Derivation.**

*Part A. Assembling the rule.*

1. *Three-factor core.* A modulator multiplies each eligibility: $\tau_w\dot W = M_+e^+ - M_-e^-$.
2. *Soft bounds (A2).* $e^+ = f^+_{ij}(w_{max}-W_{ij})$ and $e^- = f^-_{ij}W_{ij}$.
3. *Modulators (A3).* $M_+ = DA^+$ and $M_- = 1 + DA^-$.
4. *Energy gate with salience bypass (A4).* Multiply the potentiation term by
$$
g_Q = s_Q + \psi(1-s_Q) = 1 - (1-\psi)(1-s_Q)
$$
   The second form is obtained by expanding. Since $\psi\in[0,1]$, $g_Q\in[s_Q, 1]$: of the potentiation blocked by $s_Q$, a fraction $\psi$ passes anyway.
5. *Eviction (A6).* Subtract $E_{ij}$. T6.6 constructs it so that its sum over $Q$ equals the bypassed potentiation.
6. *Brake and decay (A7).* Put $(1-b_m)$ in front of the learning bracket and add $-\gamma(1-P_{ij})W_{ij}$ outside it. This is the printed equation.

*Part B. Invariance of the box $[0, w_{max}]$.*

7. *Lower face.* At $W_{ij}=0$, $E_{ij}=0$ because $\omega_{ij}\propto W_{ij}$ (T6.6), provided $\sum_Q\omega>0$. Then
$$
\tau_w\dot W_{ij} = (1-b_m)\,g_Q\,DA^+f^+_{ij}w_{max}\ge0
$$
8. *Upper face.* At $W_{ij}=w_{max}$ the potentiation term vanishes:
$$
\tau_w\dot W_{ij} = -(1-b_m)\left[(1+DA^-)f^-_{ij}w_{max} + E_{ij}\right] - \gamma(1-P_{ij})w_{max}\le0
$$
   So no trajectory crosses either face. For each coordinate this is a scalar comparison argument, with the other coordinates treated as bounded inputs. $[0,w_{max}]$ is forward invariant for each weight.

*Part C. Domain sum and the exact barrier (printed placement, $E_{ij}$ inside the brake).*

9. *Domain quantities.*
$$
\pi_{ij} = DA^+f^+_{ij}(w_{max}-W_{ij}), \quad \Pi_Q = \sum_{ij\in Q}\pi_{ij}, \quad D^-_Q = \sum_{ij\in Q}(1+DA^-)f^-_{ij}W_{ij}, \quad D^\gamma_Q = \sum_{ij\in Q}\gamma(1-P_{ij})W_{ij}
$$
   Write $D_Q = D^-_Q + D^\gamma_Q$, the "total depression plus decay" of A.2.
10. *Sum the rule over $Q$.* Use A5 ($b_m = b_Q$) and $\sum_QE_{ij} = \psi(1-s_Q)\Pi_Q$ (T6.6, Step 6):
$$
\tau_w\sum_{ij\in Q}\dot W_{ij} = (1-b_Q)\left[(s_Q + \psi(1-s_Q))\Pi_Q - D^-_Q - \psi(1-s_Q)\Pi_Q\right] - D^\gamma_Q = (1-b_Q)\left(s_Q\Pi_Q - D^-_Q\right) - D^\gamma_Q
$$
   The bypass and the eviction cancel exactly.
11. *Insert the gate inequality.* By its definition in T6.6, $s_Q\Pi_Q\le D_Q + \gamma_h\tau_wh_Q/\beta$. Multiply by $(1-b_Q)\ge0$ and subtract $(1-b_Q)D^-_Q + D^\gamma_Q$:
$$
\tau_w\sum_{ij\in Q}\dot W_{ij}\le(1-b_Q)\left(D^\gamma_Q + \frac{\gamma_h\tau_wh_Q}{\beta}\right) - D^\gamma_Q = (1-b_Q)\frac{\gamma_h\tau_wh_Q}{\beta} - b_QD^\gamma_Q
$$
12. *Headroom rate.* For the weight-based headroom $h_Q = C_{max,Q} - \beta\sum_QW$ with constant $C_{max,Q}$ (A.2/A.5; T6.5), $\dot h_Q = -\beta\sum_Q\dot W$. Multiply Step 11 by $-\beta/\tau_w$:
$$
\dot h_Q\ge-(1-b_Q)\gamma_hh_Q + \frac{\beta b_Q}{\tau_w}D^\gamma_Q\ge-(1-b_Q)\gamma_hh_Q
$$
   The last step drops a non-negative term. No sign of $h_Q$ is assumed.
13. *Gronwall.* Let $g(t) = (1-b_Q(t))\gamma_h\in[0,\gamma_h]$ and $G(t) = \int_0^tg$. By the product rule, $\frac{d}{dt}\left[h_Qe^{G}\right] = (\dot h_Q + gh_Q)e^{G}\ge0$. Integrating gives
$$
h_Q(t)\ge h_Q(0)\,e^{-G(t)}\ge h_Q(0)\,e^{-\gamma_ht}
$$
   So $h_Q(0)\ge0$ implies $h_Q(t)\ge0$ for all $t$. This is A.2 Property 3 ($h_Q(t)\ge h_Q(0)e^{-\gamma_ht}$), extended to a time-varying brake.

*Part D. Where the eviction sits, and a non-uniform brake.*

14. *A.5 placement (eviction outside the brake).* Repeat Step 10 with $-E_{ij}$ outside $(1-b_m)$:
$$
\tau_w\sum_Q\dot W = (1-b_Q)\left(s_Q\Pi_Q - D^-_Q\right) - D^\gamma_Q - b_Q\,\psi(1-s_Q)\Pi_Q
$$
   The extra term $-b_Q\psi(1-s_Q)\Pi_Q\le0$ means eviction removes more than the bypass added. The barrier still holds, but with a net loss, so cancellation is not exact. This is the A.4 validation finding ("cancellation is exact only if $\Pi_Q$ is defined with $(1-b_m)$"). With the eviction outside, exact cancellation needs $\Pi^b_Q = \sum(1-b_m)\pi_{ij}$ in both $s_Q$ and $E_{ij}$.
15. *Non-uniform brake (dropping A5).* With $b_{ij}$ varying inside $Q$ and the printed placement, the eviction sum is $\sum(1-b_{ij})E_{ij} = \psi(1-s_Q)\Pi_Q\sum(1-b_{ij})\omega_{ij}/\sum\omega$. The bypass is $\psi(1-s_Q)\sum(1-b_{ij})\pi_{ij}$. They cancel only if the $\omega$-weighted and the $\pi$-weighted means of $(1-b_{ij})$ are equal. If eviction falls on braked synapses while potentiation happens at unbraked ones, eviction under-compensates and the barrier can fail. A5, or the A.5 placement with $\Pi^b_Q$, is therefore required.
16. *A.8 headroom.* A.8 defines $h_Q$ in demand units (T6.5). Then Step 12 picks up the term $\dot C_{max,Q}(t)$, and the barrier is no longer guaranteed (T6.5, Steps 5-7).

*Part E. Fixed point without gating.*

17. *Constant inputs, $s_Q=1$, $E_{ij}=0$.* Write $A = DA^+f^+_{ij}$, $B = (1+DA^-)f^-_{ij}$ and $\Gamma = \gamma(1-P_{ij})$. Set the right side to zero:
$$
(1-b_m)\left[A(w_{max}-W) - BW\right] - \Gamma W = 0 \;\Rightarrow\; W^\ast = \frac{(1-b_m)A\,w_{max}}{(1-b_m)(A+B) + \Gamma}\in[0, w_{max})
$$
   The relaxation rate is $\left[(1-b_m)(A+B)+\Gamma\right]/\tau_w$.

**Result.** The printed equation is a phenomenological construction (Steps 1-6), and it matches A.6-A.8. Two properties are exact: the box $[0, w_{max}]$ is invariant (Steps 7-8), and the energy barrier holds (Steps 9-13). The barrier needs four conditions:

- the A.2/A.5 weight-based $h_Q$ with a constant cap;
- the same brake for all synapses of $Q$;
- $\sum_Q\omega>0$;
- $s_Q$ and $E_{ij}$ as in T6.6.

Under the A.5 placement the barrier holds with over-eviction (Step 14). Under A.8's demand-based $h_Q$ it is not guaranteed (Step 16). $b_m$ and $f^\pm_{ij}$ have never been defined in any version.

**Checks.**

- *Dimensions.* With $W$ dimensionless, every bracketed term is dimensionless, so $f^\pm$ and $E$ are dimensionless and $\gamma$ is a rate in units of $1/\tau_w$.
- *Limits.*
    - $s_Q = 1$: $g_Q = 1$ and $E = 0$, the plain three-factor rule.
    - $\psi = 0$: a pure gate, with no bypass and no eviction.
    - $\psi = 1$: full potentiation, exactly offset in the domain sum by eviction. This reallocates weight from unprotected to newly potentiated synapses. It is the mechanism behind A.2's 30-memory test: 30 of 30 memories learned with eviction against 17 of 30 without.
    - $DA^+=0$: depression and decay only.
    - $P_{ij}=1$: no decay.
    - $b_m = 1$: decay only.
- *Positivity.* Covered by Steps 7-8.

**Lineage.**

- **Model A** (`Model_A_Biological_Neuroenergetics_Specification.pdf`, Eq. 6; `Model_A_Changelog_Audit_and_Fixes.md`, T13′): gate $DA^+s_Qf^+$, eviction $-E_{ij}$ outside the brake, decay $-\gamma(1-\Omega_{ij})W_{ij}$.
- **A.2** (`Model A.2 Repaired Specification and Validation.docx`): matched gate $s_Q+\psi(1-s_Q)$, eviction written out explicitly outside the brake, $P_{ij} = \max(\Omega_{ij}, c_{ij})$, barrier proof (Property 3).
- **A.5 Eq. 17** (`Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf`): $E_{ij}$ outside.
- **A.4 validation report** (`Model A.5  validation against experimental data.docx`): "move $E_{ij}$ inside the bracket".
- **A.6 Eq. 32**: inside ("eviction now inside the (1 − b_m) bracket"). A.7 annex Eq. 32 and A.8 PDF Eq. (17) keep this.
- **Aleph lineage table:** "synaptic headroom", inherited.

**Derivation status.** Phenomenological closure. The functional form is a modelling choice, motivated by three-factor learning, soft bounds and tagging and capture. The evidence is A.2's eviction test and the de Vivo downscaling fit (A.2). Two properties are exact consequences of the construction: invariance of $[0,w_{max}]$, and the barrier $h_Q(t)\ge h_Q(0)e^{-\gamma_ht}$ under the conditions in Result.

---

## T6.5: Vascular metabolic headroom of a supply territory (inherited: A.8 Tier 6; Aleph: synaptic headroom)

**Equation as stated in the latest source.** A.8 (`Model_A8_model only.docx`, Tier 6; `Model_A8_Scientific_Report.docx`):

$$
h_Q = D_{cap} - \sum_{k\in Q} D_k \ge 0
$$

A.8 adds, in words only: "If total energy demand approaches vascular supply capacity ($h_Q\to0$), learning gain $s_Q\to0$, preventing metabolic overshoot."

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $h_Q$ | headroom (spare capacity) of territory $Q$ | mM s$^{-1}$ (ATP rate, as $D_k$ in T3.3) |
| $Q$ | the synapses (A.6: "the set of synapses drawing on one capillary node") or neurons $k$ of one supply territory | set |
| $D_{cap}$ | vascular supply capacity of the territory. Never defined | mM s$^{-1}$ |
| $D_k$ | ATP demand of member $k$ (T3.3) | mM s$^{-1}$ |
| $C_{max,Q}$, $\beta$ | A.2/A.5 weight-cost cap and cost per unit weight | mM s$^{-1}$; mM s$^{-1}$ per unit $W$ |

**Physical starting point.** Steady-state energy balance of a supply territory (first law): ATP production cannot exceed what the delivered O$_2$ and glucose can sustain. A demand that exceeds this capacity can be met only transiently, from the PCr and glycogen buffers. Assumptions:

- A1. $D_{cap}$ is the maximal sustainable ATP production of the territory at maximal delivery (Proposal: Tier 2 flow and Tier 3 extraction fix it).
- A2. $D_k$ is the T3.3 demand. The corrected form of T3.3, Step 5 is used, with availability factor $\tilde m_k = m(a_k,K_{aD})/m(a_0,K_{aD})$.
- A3. Near rest, $\tilde m_k\approx1$.

**Derivation.**

1. *Definition.* $h_Q$ is a definition. Its non-negativity is the steady-state feasibility condition $\sum_kD_k\le D_{cap}$, so "$\ge0$" is a constraint, not an identity.
2. *Insert T3.3 (A2).*
$$
\sum_{k\in Q}D_k = \sum_{k\in Q}\left\lbrace\frac{\Pi_k}{3} + \tilde m_k\left[P_0 + \beta\sum_lW_{kl} + \kappa\sum_l\left\lvert\dot W_{kl}\right\rvert + \kappa_c\sum_l(\dot c_{kl})_+\right]\right\rbrace
$$
3. *Separate the weight term.* Collect everything except $\beta\tilde m_kW_{kl}$ into
$$
D_Q^{oth}(t) = \sum_{k\in Q}\left\lbrace\frac{\Pi_k}{3} + \tilde m_k\left[P_0 + \kappa\sum_l\left\lvert\dot W_{kl}\right\rvert + \kappa_c\sum_l(\dot c_{kl})_+\right]\right\rbrace
$$
   Then $\sum_kD_k = \beta\sum_{kl}\tilde m_kW_{kl} + D_Q^{oth}(t)$.
4. *Reconcile the two definitions (A3).* With $\tilde m_k = 1$:
$$
h_Q^{A.8} = \left[D_{cap} - D_Q^{oth}(t)\right] - \beta\sum_{kl\in Q}W_{kl} \equiv C_{max,Q}(t) - \beta\sum_{kl\in Q}W_{kl}
$$
   This is the A.2/A.5 weight-cost headroom with a time-varying cap $C_{max,Q}(t) = D_{cap} - D_Q^{oth}(t)$. $\beta$ means the same in both: ATP rate per unit weight, the maintenance cost of T3.3. Units are consistent if $C_{max,Q}$ is in mM s$^{-1}$.
5. *Rate of change.* $\dot h_Q = \dot C_{max,Q} - \beta\sum_Q\dot W$.
6. *Insert the gated weight dynamics.* T6.4 Step 11 depends only on $s_Q$ being computed from the current $h_Q$, so it still holds: $-\beta\sum_Q\dot W\ge-(1-b_Q)\gamma_hh_Q$. Hence $\dot h_Q\ge\dot C_{max,Q} - g(t)h_Q$, with $g = (1-b_Q)\gamma_h$. With the integrating factor of T6.4 Step 13,
$$
h_Q(t)\ge h_Q(0)\,e^{-G(t)} + \int_0^te^{-(G(t)-G(s))}\,\dot C_{max,Q}(s)\,ds
$$
7. *Consequence.* If non-weight demand rises, the cap falls ($\dot C_{max,Q}<0$). A firing surge does this by raising $\Pi_k$. The integral is then negative and $h_Q$ can cross zero. The gate cannot stop this. Even with $s_Q = 0$, weights fall only at the rate $D_Q/\tau_w$ set by depression and decay. Under A.8's definition, $h_Q\ge0$ is therefore not an invariant of Tier 6. It holds only if $\dot C_{max,Q}\ge0$, or if Tier 3 limits demand (falling $\tilde m_k$, the K$_{ATP}$ brake of T1.1). A second complication: through $\kappa\sum\lvert\dot W\rvert$, $D^{oth}_Q$ depends on $\dot W$ itself.
8. *Repair (Proposal).* Two consistent options:
    - (a) Keep the A.2/A.5 weight budget with a constant cap $C_{max,Q}$, and treat demand-based spare capacity as a separate Tier 3 diagnostic. T6.4-T6.6 and T6.15 then hold exactly.
    - (b) Feed the cap's rate into the gate. Take $b_Q=0$ for clarity. The barrier condition $\dot h_Q\ge-\gamma_hh_Q$ is $\beta\sum_Q\dot W\le\gamma_hh_Q + \dot C_{max,Q}$. With T6.4 Step 10 this becomes $s_Q\Pi_Q\le D_Q + \tau_w(\gamma_hh_Q + \dot C_{max,Q})/\beta$, so
$$
s_Q = \min\left\lbrace1, \max\left\lbrace0, \frac{D_Q + \tau_w(\gamma_hh_Q + \dot C_{max,Q})/\beta}{\Pi_Q}\right\rbrace\right\rbrace
$$
   This is feasible only while $D_Q + \tau_w(\gamma_hh_Q + \dot C_{max,Q})/\beta\ge0$. Beyond that, Tier 3 must absorb the deficit.
9. *The verbal claim "$h_Q\to0\Rightarrow s_Q\to0$".* With T6.6, at $h_Q=0$, $s_Q = \min\lbrace1, D_Q/\Pi_Q\rbrace$. This vanishes only if $D_Q = 0$. What holds is $s_Q\Pi_Q\le D_Q$: at zero headroom, potentiation is allowed exactly up to the capacity freed by concurrent depression and decay, so the net domain weight change is $\le0$.

**Result.** The equation is a definition, and as a definition it is exact. Under A2-A3, A.8's demand-based headroom equals the A.2/A.5 weight-cost headroom with a time-varying cap (Step 4). The constraint "$\ge0$" is enforced by the gates (T6.6, T6.15) only when the cap is constant (Steps 6-7). A.8's verbal statement that $s_Q\to0$ is inaccurate (Step 9). $D_{cap}$ is never defined.

**Checks.**

- *Dimensions.* $[h_Q] = [D_k]$ = mM s$^{-1}$. $h_Q/\beta$ is in weight units, as used in T6.6 and T6.15.
- *Rest.* At rest $h_Q(\text{rest}) = D_{cap} - \sum_kD_k(a_0)$ must be positive for learning to be possible at all.
- *Limits.* $\beta\to0$ (weights cost nothing): $h_Q$ no longer depends on $W$ and the gate is inactive.

**Lineage.**

- **Model A** (`Model_A_Biological_Neuroenergetics_Specification.pdf`): $h_{C,Q} = C_{max,Q} - \beta\sum_{kl\in Q}W_{kl}$, with $\beta$ the "maintenance cost per weight".
- **A.2; A.5 Eq. 18:** same weight-cost form.
- **A.6 Eq. 35:** uses $h_Q$ without restating it.
- **A.8** (`Model_A8_model only.docx`, `Model_A8_Scientific_Report.docx`, PDF Tier 6): redefines it as $D_{cap} - \sum D_k\ge0$, in demand units.
- **Aleph lineage table:** "synaptic headroom", inherited from A.8.

**Derivation status.** Exact as a definition. The invariance claim is incomplete in source. Under the A.8 definition, $h_Q\ge0$ does not follow from T6.6 or T6.15 (Step 7). A consistent repair is supplied (Step 8).

---

## T6.6: Headroom supply gate and salience-weighted eviction allocation (inherited: A.5 Eqs. 18-19; used without formula from A.6 on)

**Equation as stated in the latest source.** `Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf` (the A.5 specification), Eqs. 18-19. This is the last explicit statement; A.6 refers to "$s_Q$, $E_{ij}$ as in A.4 Eqs. 15-16":

$$
s_Q = \min\left\lbrace 1, \frac{D_Q + \gamma_h\tau_w h_Q/\beta}{\Pi_Q}\right\rbrace, \qquad h_Q = C_{max,Q} - \beta\sum_{kl\in Q}W_{kl}
$$

$$
E_{ij} = \psi(1 - s_Q)\,\Pi_Q\left[\frac{\omega_{ij}}{\sum_{kl\in Q}\omega_{kl}}\right], \qquad \omega_{ij} = (1 - P_{ij})\,W_{ij}\exp(-f^+_{ij}/f_0)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Pi_Q$ | total potentiation drive of $Q$, $\sum DA^+f^+(w_{max}-W)$ (T6.4, Step 9). Clashes with the pump flux | as $W$ |
| $D_Q$ | total depression plus decay of $Q$, $D^-_Q + D^\gamma_Q$ (T6.4, Step 9) | as $W$ |
| $\gamma_h$ | barrier rate | time$^{-1}$ |
| $\beta$ | cost per unit weight | [h]/[W] |
| $C_{max,Q}$ | weight-cost cap | as $h_Q$ |
| $\omega_{ij}$ | eviction weight | as $W$ |
| $f_0$ | recency scale | as $f^+$ |

**Physical starting point.** A barrier (forward-invariance) condition on the headroom, $\dot h_Q\ge-\gamma_hh_Q$. This is a linear control-barrier-function condition (Ames et al. 2017): it keeps $h_Q\ge0$ by Gronwall. Blocked potentiation that is let through by salience is paid for by proportional allocation of eviction. Assumptions:

- A1. Territories partition the synapses.
- A2. The brake is uniform on $Q$ (T6.4, A5).
- A3. $h_Q$ is the weight-based headroom with constant $C_{max,Q}$.
- A4. $\Pi_Q>0$; when $\Pi_Q = 0$, set $s_Q = 1$, which is the limit of the formula.
- A5. $\sum_Q\omega>0$.

**Derivation.**

1. *Target.* The barrier condition is $\dot h_Q\ge-\gamma_hh_Q$. With $\dot h_Q = -\beta\sum_Q\dot W$, this is $\beta\sum_Q\dot W\le\gamma_hh_Q$, or
$$
\tau_w\sum_Q\dot W\le\frac{\gamma_h\tau_wh_Q}{\beta}
$$
2. *Domain sum for a general gate.* Provided the eviction satisfies $\sum_QE = \psi(1-s_Q)\Pi_Q$ (Step 6), T6.4 Step 10 gives $\tau_w\sum_Q\dot W = (1-b_Q)(s_Q\Pi_Q - D^-_Q) - D^\gamma_Q$.
3. *Sufficient condition.* T6.4 Step 11 shows that $s_Q\Pi_Q\le D_Q + \gamma_h\tau_wh_Q/\beta$ implies Step 1, for any $b_Q\in[0,1]$.
4. *Largest admissible gate.* Divide by $\Pi_Q>0$ (A4). The admissible gates are $s_Q\le(D_Q + \gamma_h\tau_wh_Q/\beta)/\Pi_Q$. The largest one that is also $\le1$ is
$$
s_Q = \min\left\lbrace1, \frac{D_Q + \gamma_h\tau_wh_Q/\beta}{\Pi_Q}\right\rbrace
$$
   This is the printed gate. The numerator is $\ge0$ whenever $h_Q\ge0$, so $s_Q\in[0,1]$.
5. *Equivalent Lipschitz forms.* Write $N_Q = D_Q + \gamma_h\tau_wh_Q/\beta$. For $\Pi_Q>0$, $\Pi_Q\min\lbrace1, N_Q/\Pi_Q\rbrace = \min\lbrace\Pi_Q, N_Q\rbrace$, so
$$
s_Q\Pi_Q = \min\lbrace\Pi_Q, N_Q\rbrace, \qquad (1-s_Q)\Pi_Q = \Pi_Q - \min\lbrace\Pi_Q,N_Q\rbrace = (\Pi_Q - N_Q)_+
$$
6. *Eviction allocation.* The bypassed potentiation is $\psi(1-s_Q)\Pi_Q$. Distribute it in proportion to the weights $\omega_{ij}$:
$$
E_{ij} = \psi(1-s_Q)\Pi_Q\frac{\omega_{ij}}{\sum_Q\omega} = \psi(\Pi_Q - N_Q)_+\frac{\omega_{ij}}{\sum_Q\omega}
$$
   Summing over $Q$, the normalized weights add to 1, so $\sum_QE_{ij} = \psi(1-s_Q)\Pi_Q$, which is the condition used in Step 2.
7. *Choice of $\omega_{ij}$.* Each factor has a role:
    - $(1-P_{ij})$ spares tagged or captured synapses;
    - $W_{ij}$ makes eviction proportional to size, so $E_{ij}\to0$ as $W_{ij}\to0$ (box invariance, T6.4 Step 7) and strong unprotected synapses pay most;
    - $e^{-f^+_{ij}/f_0}$ spares recently eligible synapses.
8. *Regularity.* By Step 5, $s_Q\Pi_Q$ and $(1-s_Q)\Pi_Q$ are Lipschitz functions of the state, because min and positive part are Lipschitz. The per-synapse potentiation $s_Q\pi_{ij} = \pi_{ij}\min\lbrace1, N_Q/\Pi_Q\rbrace$ is continuous for $\Pi_Q>0$. As $\Pi_Q\to0$ it tends to 0, because $0\le\pi_{ij}\le\Pi_Q$. The eviction is Lipschitz wherever $\sum_Q\omega$ is bounded away from 0. The vector field is therefore continuous everywhere, and locally Lipschitz except on the degenerate set $\Pi_Q = N_Q = 0$ and where $\sum_Q\omega\to0$. Classical solutions exist and are unique away from that set. The minimum produces a kink, not a jump, so the Filippov treatment that A.2 says is "still needed" is not required.
9. *Boundary $W_{ij}=0$.* $E_{ij}/W_{ij} = \psi(\Pi_Q - N_Q)_+(1-P_{ij})e^{-f^+_{ij}/f_0}/\sum_Q\omega<\infty$ under A5. So $\dot W_{ij}\ge-KW_{ij}$ near 0, and $W_{ij}$ stays non-negative.
10. *Failure of A5.* If every synapse of $Q$ is fully protected ($P=1$) or empty, then $\sum_Q\omega = 0$. Eviction cannot be allocated and the bypassed potentiation goes uncompensated, so the barrier fails. Model A avoided this with the regularized weights $(1-\Omega+\varepsilon)W$. Proposal: either $\omega_{ij} = (1-P_{ij}+\varepsilon)W_{ij}e^{-f^+_{ij}/f_0}$, or set $\psi = 0$ whenever $\sum_Q\omega = 0$.

**Result.** The gate and the eviction follow exactly from the barrier requirement (Steps 1-6), and they match A.5 Eqs. 18-19. The construction needs A1-A5: a uniform brake, the weight-based $h_Q$, $\Pi_Q>0$ and $\sum_Q\omega>0$. Aleph inherits A.8's demand-based $h_Q$ (T6.5), which does not match the weight-based $h_Q$ printed here. The formula has not been restated since A.5.

**Checks.**

- *Dimensions.* $[N_Q] = [D_Q] + [\gamma_h\tau_w][h_Q]/[\beta] = [W]$, so $s_Q$ is dimensionless. $[E_{ij}] = [\Pi_Q] = [W]$.
- *Range.* $s_Q\in[0,1]$ for $h_Q\ge0$.
- *Limits.*
    - $h_Q\to\infty$: $s_Q = 1$, no gating.
    - $\Pi_Q\to0$: $s_Q = 1$.
    - $\psi = 0$: $E_{ij} = 0$.
    - $h_Q = 0$: $s_Q = \min\lbrace1, D_Q/\Pi_Q\rbrace$, which is not zero (T6.5, Step 9).
- *Conservation.* $\sum_QE_{ij} = \psi(1-s_Q)\Pi_Q$ exactly.
- *Numbers in the source.* A.2 reports headroom "positive throughout" and learning of 30 of 30 memories with eviction against 17 of 30 without. A.6 P3 checks the REM extension (T6.15).

**Lineage.**

- **Model A** (`Model_A_Biological_Neuroenergetics_Specification.pdf`, Eqs. 7-8): $s_Q = \min\lbrace1,(\Delta_Q + \tau_w\gamma_hh_{C,Q}/\beta)/(\bar\Pi_Q+\varepsilon)\rbrace$, with $\Delta_Q$ undefined. Eviction $E_{ij} = U_Q(1-\Omega_{ij}+\varepsilon)W_{ij}/\sum(1-\Omega+\varepsilon)W$. The Model A changelog (`Model_A_Changelog_Audit_and_Fixes.md`) writes the budget as $(1-s_Q)\Pi_Q$, which gives a "net loss $(2s-1)\Pi_Q$" (A.5 change log).
- **A.2:** $D_Q$ and $\Pi_Q$ defined; gate $s+\psi(1-s)$ matched by eviction $\psi(1-s)\Pi$; the barrier proved.
- **A.5 Eqs. 18-19:** the printed forms.
- **A.6-A.8:** refer to the forms without restating them. A.8 states only "$h_Q\to0$, $s_Q\to0$".

**Derivation status.** Exact as a barrier construction, given A1-A5. The functional choice of $\omega_{ij}$ is phenomenological. Not restated after A.5, and inconsistent with the A.8 headroom inherited by Aleph.

---

## T6.7: Synaptic tag dynamics and persistence variable (inherited: A.7 annex Eq. 34; A.8 Tier 6 for $P_{ij}$)

**Equation as stated in the latest source.** A.7 annex Eq. 34 (`Model A.7 with all equations.docx`), the last explicit $\Omega$ dynamics. $P_{ij}$ is as in A.8:

$$
\tau_\Omega\frac{d\Omega_{ij}}{dt} = \kappa_\Omega\,DA^+ f^+_{ij}(1 - \Omega_{ij}) - \Omega_{ij}, \qquad P_{ij} = \max(\Omega_{ij}, c_{ij})
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Omega_{ij}$ | synaptic tag (fraction of tagged slots) | dimensionless, $[0,1]$ |
| $\tau_\Omega$ | tag lifetime | time |
| $\kappa_\Omega$ | tagging gain | dimensionless |
| $c_{ij}$ | capture variable (T6.8) | dimensionless, $[0,1]$ |
| $P_{ij}$ | persistence | dimensionless, $[0,1]$ |

**Physical starting point.** Synaptic tagging and capture (Frey & Morris 1997; Redondo & Morris 2011): activity paired with a neuromodulatory signal sets a transient, local tag. The tag decays over hours unless plasticity-related products are captured. It is modelled here as a two-state (untagged and tagged) population with mass-action kinetics. Assumptions:

- A1. Setting acts on untagged slots at rate $k_{set} = \kappa_\Omega DA^+f^+_{ij}/\tau_\Omega$.
- A2. Tags decay first order at rate $1/\tau_\Omega$.
- A3. Persistence is the stronger of the two protections.

**Derivation.**

1. *Two-state balance.* $\dot\Omega = k_{set}(1-\Omega) - k_{dec}\Omega$.
2. *Insert A1-A2 and multiply by $\tau_\Omega$.* This gives the printed equation.
3. *Constant drive.* Let $u = \kappa_\Omega DA^+f^+_{ij}$. Then $\tau_\Omega\dot\Omega = u - (1+u)\Omega$. This is linear, with solution
$$
\Omega(t) = \Omega^\ast + (\Omega(0)-\Omega^\ast)\,e^{-(1+u)t/\tau_\Omega}, \qquad \Omega^\ast = \frac{u}{1+u}
$$
   Strong drive shortens the effective time constant to $\tau_\Omega/(1+u)$. After the drive stops ($u = 0$), $\Omega = \Omega(t_0)e^{-(t-t_0)/\tau_\Omega}$.
4. *Invariance of $[0,1]$ (exact).* At $\Omega = 0$, $\tau_\Omega\dot\Omega = u\ge0$. At $\Omega = 1$, $\tau_\Omega\dot\Omega = -1<0$. The scalar comparison principle (Nagumo's condition in one dimension) then makes $[0,1]$ forward invariant for any non-negative, measurable drive $u(t)$. This is A.2 Property 1 ("Ω and c have logistic form").
5. *Persistence (A3).* $P_{ij} = \max(\Omega_{ij}, c_{ij})\in[0,1]$ when both arguments are. The max is Lipschitz with constant 1, since $\lvert\max(a,b) - \max(a',b')\rvert\le\max(\lvert a-a'\rvert,\lvert b-b'\rvert)$, and it is not differentiable on $\Omega = c$. A smooth alternative (Proposal) treats the two protections as independent: $P = 1-(1-\Omega)(1-c)$. It satisfies $\max(\Omega,c)\le P\le\min(1,\Omega+c)$.

**Result.** The printed form follows exactly from A1-A3, and it matches A.2, A.5 Eq. 20, A.6 Eq. 34 and A.7 Eq. 34. Invariance of $[0,1]$ is exact (Step 4). $f^+_{ij}$ remains undefined.

**Checks.**

- *Dimensions.* $\kappa_\Omega DA^+f^+$ is dimensionless.
- *Limits.*
    - $u\to\infty$: $\Omega\to1$.
    - $u = 0$: exponential decay with lifetime $\tau_\Omega$.
    - $c = 0$: $P = \Omega$, the A.1 case $P\equiv\Omega$.
- *Fixed point.* $\Omega^\ast = u/(1+u)$, with eigenvalue $-(1+u)/\tau_\Omega$.

**Lineage.**

- **Model A** (`Model_A_Biological_Neuroenergetics_Specification.pdf`, Eq. 10; `Model_A_Changelog_Audit_and_Fixes.md`): the tag is the fastest variable of a Benna-Fusi cascade, $\Omega = u^1$, with no upper bound.
- **A.2:** "bounded fast tag" with the printed form; $P_{ij} = \max(\Omega_{ij}, c_{ij})$.
- **A.5 Eqs. 20, 22; A.6 Eq. 34; A.7 annex Eq. 34:** unchanged.
- **A.8:** only $P_{ij} = \max(\Omega_{ij}, c_{ij})$ ("persistence variable protecting tagged or captured synapses from decay $\gamma$").

**Derivation status.** Phenomenological closure. It is a two-state mass-action model of the tag, motivated by synaptic tagging and capture. Invariance of $[0,1]$ is exact. The choice $P = \max(\Omega, c)$ is a modelling choice.

---

## T6.8: Energy-gated bistable condensate capture SDE (inherited: A.8 PDF Eq. (18); Aleph: condensate capture SDE on [0, 1])

**Equation as stated in the latest source.** Eq. (18) of `Model_A8_Scientific_Report.pdf`, identical in `Model_A8_model only.docx` and A.6 Eq. 33:

$$
\tau_c\, dc_{ij} = \left[\Omega_{ij}\,\pi(a_i)(1 - c_{ij}) + \beta_c\frac{c_{ij}^2(1 - c_{ij})}{K_c^2 + c_{ij}^2} - \gamma_c\, c_{ij}\right]dt + \sigma_c\, c_{ij}(1 - c_{ij})\, dB_{ij}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $c_{ij}$ | capture (condensate) variable | dimensionless, $[0,1]$ |
| $\tau_c$ | capture time constant (clashes with the AIS proxy, T4.1) | time |
| $\Omega_{ij}$ | tag (T6.7) | dimensionless, $[0,1]$ |
| $\pi(a_i)$ | energy gate (T6.9) | dimensionless, $[0,1]$ |
| $\beta_c$ | cooperative self-recruitment gain, in units of $1/\tau_c$ (clashes with the capillary gain, T2.14) | dimensionless |
| $K_c$ | Hill constant of self-recruitment | dimensionless |
| $\gamma_c$ | dissolution rate, in units of $1/\tau_c$ | dimensionless |
| $\sigma_c$ | noise amplitude. $\tau_c\,dc$ has units of time and $dB$ of time$^{1/2}$ | time$^{1/2}$ |
| $B_{ij}$ | standard Brownian motions, assumed independent across synapses | time$^{1/2}$ |

The drift in square brackets is written $b(c,t)$ below.

**Physical starting point.** Postsynaptic scaffold proteins can phase-separate into condensates (Zeng et al. 2016), and A.3 cites biomolecular condensates as the basis of a self-sustaining capture state. Capture of plasticity-related products needs a tag (synaptic tagging and capture) and local energy (A.2). The SDE is a mean-field balance with noise. Assumptions:

- A1. $c$ is the fraction of capture-competent sites in the condensed phase; $1-c$ is the dilute fraction.
- A2. Tag- and energy-driven recruitment acts on the dilute fraction at rate $\Omega\pi$.
- A3. Condensed material recruits more cooperatively: the rate per dilute site is $\beta_cc^2/(K_c^2+c^2)$ (Hill-2).
- A4. Dissolution is first order, at rate $\gamma_c$.
- A5. The noise is multiplicative with amplitude $\sigma_cc(1-c)$, read in the Itô sense unless stated.
- A6. $\Omega(t)$ and $\pi(t)$ are measurable with values in $[0,1]$ (T6.7, T6.9).

**Derivation.**

*Part A. Drift and noise.*

1. *Mass balance (A1-A4).* The flux into the condensed phase is $\left[\Omega\pi + \beta_cc^2/(K_c^2+c^2)\right](1-c)$. The flux out is $\gamma_cc$. Hence
$$
\tau_c\frac{dc}{dt} = \Omega\pi(1-c) + \beta_c\frac{c^2(1-c)}{K_c^2+c^2} - \gamma_cc = b(c,t)
$$
   This is the printed drift. The $(1-c)$ on the cooperative term is what A.6 added; Steps 7 and 9 show why it is needed.
2. *Why $c(1-c)$ and not $\sqrt{c(1-c)}$ (A5).* Fluctuations from resampling a finite pool of sites (Wright-Fisher type) would have amplitude $\propto\sqrt{c(1-c)}$. Near $c=0$ that SDE behaves like a Feller (CIR) diffusion, $dc\approx(\Omega\pi/\tau_c)dt + (\sigma/\tau_c)\sqrt c\,dB$. Its boundary $c=0$ is unattainable only when the scaled Feller condition $2\Omega\pi\tau_c\ge\sigma^2$ holds, and it is reached whenever $\Omega\pi=0$. The printed amplitude vanishes linearly at both ends, which makes both boundaries unattainable for all parameter values (Steps 11-15). So the choice is made for invariance, as the A.4 validation report proposed. It is not derived from molecular counting.

*Part B. Bistability of the deterministic drift ($\sigma_c = 0$).*

3. *Factor the drift with no tag ($\Omega\pi = 0$).* Put both terms over $K_c^2+c^2$:
$$
b(c) = \frac{c\,q(c)}{K_c^2+c^2}, \qquad q(c) = \beta_cc(1-c) - \gamma_c(K_c^2+c^2) = -(\beta_c+\gamma_c)c^2 + \beta_cc - \gamma_cK_c^2
$$
4. *Interior fixed points.* Solve $q = 0$ with the quadratic formula:
$$
c_\pm = \frac{\beta_c\pm\sqrt{\beta_c^2 - 4\gamma_cK_c^2(\beta_c+\gamma_c)}}{2(\beta_c+\gamma_c)}
$$
   The roots are real and distinct iff $\beta_c^2>4\gamma_cK_c^2(\beta_c+\gamma_c)$. With $r = \beta_c/\gamma_c$ this reads $r^2 - 4K_c^2r - 4K_c^2>0$, that is
$$
\frac{\beta_c}{\gamma_c}>2K_c^2 + 2K_c\sqrt{K_c^2+1}
$$
5. *Location.* By Vieta, $c_+c_- = \gamma_cK_c^2/(\beta_c+\gamma_c)>0$ and $c_++c_- = \beta_c/(\beta_c+\gamma_c)<1$. Both roots are therefore positive, and both are below 1.
6. *Stability.* $q<0$ outside $[c_-, c_+]$ and $q>0$ inside it, and $b$ has the sign of $q$ for $c>0$. Also $b'(0) = -\gamma_c<0$, because the Hill term is $O(c^2)$. So $c=0$ is stable (forgotten), $c_-$ is the unstable threshold, and $c_+$ is stable (captured). For example (illustrative values, not from the sources; computed here), $K_c = 0.5$ and $\beta_c = 3\gamma_c$ give a threshold ratio of 1.618 and fixed points $0$, $0.0955$, $0.6545$.
7. *The pre-A.6 form leaves the interval.* Without $(1-c)$ on the Hill term (A.3, A.5 Eq. 21), $b_{old}(1) = \beta_c/(1+K_c^2) - \gamma_c$. This is positive iff $\beta_c>\gamma_c(1+K_c^2)$, which reproduces the A.4 validation finding that "c exceeds 1 whenever $\beta_c>\gamma_c(1+K_c^2)$". Its interior fixed points solve $\gamma_cc^2 - \beta_cc + \gamma_cK_c^2 = 0$, so it is bistable iff $\beta_c>2\gamma_cK_c$, and its upper root can exceed 1.
8. *Tag and energy switch the state.* Write $s = \Omega\pi>0$ and multiply $b$ by $K_c^2+c^2$:
$$
N(c) = -(s+\beta_c+\gamma_c)c^3 + (s+\beta_c)c^2 - K_c^2(s+\gamma_c)c + sK_c^2
$$
   $N(0) = sK_c^2>0$ and $N(1) = -\gamma_c(1+K_c^2)<0$, so the number of fixed points in $(0,1)$ is odd: one or three. As $s$ rises, the low stable state and $c_-$ merge in a saddle-node (where $N = N' = 0$) and vanish. Only the captured state is left. In the illustration of Step 6 this happens at $s\approx0.023\gamma_c$ (computed here). When the tag decays and $s\to0$, $c$ stays near $c_+$. This is tagging and capture as a hysteresis loop in $s$: a transient (tag × energy) signal is converted into a persistent state.

*Part C. Forward invariance of $[0,1]$ (exact).*

9. *Itô form.* Divide by $\tau_c$: $dc = f\,dt + g\,dB$ with $f = b/\tau_c$ and $g = (\sigma_c/\tau_c)c(1-c)$.
10. *Boundary values.* $f(0,t) = \Omega\pi/\tau_c\ge0$, $f(1,t) = -\gamma_c/\tau_c<0$ and $g(0) = g(1) = 0$. These are the Lean lemmas `capture_drift_nonnegative_at_zero`, `capture_drift_negative_at_one`, `capture_diffusion_vanishes_at_zero` and `capture_diffusion_vanishes_at_one` (`Model_A8_FormalVerification.lean`). The drift at $c=0$ is not zero when $\Omega\pi>0$. The statements that "both drift and diffusion vanish" at $c=0$ and $c=1$ are therefore wrong: they appear in A.6's "Why", the A.7 annex, the A.8 prose and the docstring of Lean Theorem 3. The Lean lemmas themselves are correct. Boundary signs plus vanishing diffusion do not by themselves prove invariance for an SDE (compare Step 2), so a proof follows.
11. *Logit transform.* For $c\in(0,1)$ set $y = \ln\left(c/(1-c)\right)$. Then $y' = 1/(c(1-c))$ and $y'' = (2c-1)/(c^2(1-c)^2)$.
12. *Itô's lemma.* $dy = \left(fy' + \tfrac12g^2y''\right)dt + gy'\,dB$. The diffusion becomes $gy' = \sigma_c/\tau_c$, a constant. The drift is
$$
\mu(y,t) = \frac{1}{\tau_c}\left[\frac{\Omega\pi}{c} + \frac{\beta_cc}{K_c^2+c^2} - \frac{\gamma_c}{1-c}\right] + \frac{\sigma_c^2}{2\tau_c^2}(2c-1), \qquad c = \frac{1}{1+e^{-y}}
$$
   The bracket uses $b/(c(1-c)) = \Omega\pi/c + \beta_cc/(K_c^2+c^2) - \gamma_c/(1-c)$.
13. *One-sided bounds.* Since $K_c^2+c^2\ge2K_cc$, $\beta_cc/(K_c^2+c^2)\le\beta_c/(2K_c)$. Use $\Omega\pi\le1$.
    - For $y\ge0$ ($c\ge1/2$): $\Omega\pi/c\le2$, $-\gamma_c/(1-c)\le0$ and $2c-1\le1$. So $\mu\le M_+ = \left[2 + \beta_c/(2K_c)\right]/\tau_c + \sigma_c^2/(2\tau_c^2)$.
    - For $y\le0$ ($c\le1/2$): the first two terms are $\ge0$, $-\gamma_c/(1-c)\ge-2\gamma_c$ and $2c-1\ge-1$. So $\mu\ge-M_- = -2\gamma_c/\tau_c - \sigma_c^2/(2\tau_c^2)$.
14. *Non-explosion (Khasminskii's test).* Take $V = 1+y^2$, so $\mathcal LV = 2y\mu + \sigma_c^2/\tau_c^2$. By Step 13, $2y\mu\le2\lvert y\rvert M$ with $M = \max(M_+, M_-)$. Using $2\lvert y\rvert\le1+y^2$, $\mathcal LV\le(M + \sigma_c^2/\tau_c^2)V$. The drift is locally Lipschitz in $y$ and the noise is additive, so $y$ cannot reach $\pm\infty$ in finite time (Khasminskii's non-explosion theorem). Hence $c(t)\in(0,1)$ for all $t$, almost surely, whenever $c(0)\in(0,1)$.
15. *Starts on the boundary.* The SDE in $c$ has locally Lipschitz coefficients, so pathwise uniqueness holds.
    - From $c(0)=0$ with $\Omega\pi\equiv0$, the unique solution is $c\equiv0$.
    - From $c(0)=0$ with $\Omega\pi>0$, the positive drift moves $c$ into $(0,1)$.
    - From $c(0)=1$, the drift is negative and $c$ moves into $(0,1)$.
    
    So $[0,1]$ is forward invariant. A.6 P2 reports the matching numerical check: 0 of 20,000 paths leave, against 98% under A.5's additive noise.
16. *Stratonovich reading.* The equivalent Itô drift gains $\tfrac12gg' = (\sigma_c^2/(2\tau_c^2))c(1-c)(1-2c)$, which vanishes at both ends. In logit coordinates the Stratonovich equation is $dy = \left[b/(\tau_cc(1-c))\right]dt + (\sigma_c/\tau_c)\circ dB$, and Steps 13-14 apply unchanged. Invariance therefore holds in both readings. The stationary density and the escape rates differ between them (T6.10). This is GPT §7.1's caveat.

*Part D. Long-time behaviour for constant $\Omega\pi$ (exact).*

17. *Stationary density.* The zero-flux solution of the Fokker-Planck equation is $p_s(c)\propto g^{-2}\exp\left(\int2f/g^2\,dc\right)$.
    - With $\Omega\pi = 0$, near $c=0$: $f\approx-\gamma_cc/\tau_c$ and $g^2 = \sigma_c^2c^2/\tau_c^2$, so $2f/g^2\approx-2\gamma_c\tau_c/(\sigma_c^2c)$. Integrating gives $p_s\propto c^{-2-2\gamma_c\tau_c/\sigma_c^2}$, which is not integrable at 0. There is no stationary density: probability drains towards $c=0$, and every captured synapse is eventually lost. This is the basis of T6.10.
    - With $\Omega\pi>0$: $2f/g^2\approx2\Omega\pi\tau_c/(\sigma_c^2c^2)$ near 0 gives $p_s\propto c^{-2}e^{-2\Omega\pi\tau_c/(\sigma_c^2c)}$. Near 1, $2f/g^2\approx-2\gamma_c\tau_c/(\sigma_c^2(1-c)^2)$ gives $e^{-2\gamma_c\tau_c/(\sigma_c^2(1-c))}$. Both ends are integrable, so a stationary density exists iff $\Omega\pi>0$.

**Result.** The printed SDE is a phenomenological mean-field balance (Step 1) with multiplicative noise chosen for invariance (Step 2), and it matches A.6-A.8. Three results are exact:

- Forward invariance of $[0,1]$ under Itô or Stratonovich (Steps 9-16).
- The bistability condition $\beta_c/\gamma_c>2K_c^2 + 2K_c\sqrt{K_c^2+1}$ (Steps 3-6).
- The tag-driven saddle-node switch (Step 8).

The prose claim that the drift vanishes at $c=0$ is wrong; it equals $\Omega\pi\ge0$. $\sigma_c$ has units of time$^{1/2}$ because the equation is written for $\tau_c\,dc$.

**Checks.**

- *Dimensions.* $[\tau_c\,dc]$ is a time, $[b\,dt]$ is a time, and $[\sigma_c\,dB]$ is time$^{1/2}\cdot$time$^{1/2}$, also a time.
- *Limits.*
    - $\sigma_c\to0$: the ODE of Step 1.
    - $\beta_c = 0$: monostable, $c^\ast = \Omega\pi/(\Omega\pi+\gamma_c)$.
    - $\Omega\pi = \beta_c = 0$: $c = c_0e^{-\gamma_ct/\tau_c}$.
- *Fixed points.* See Steps 4-8.
- *Data.* A.2's starvation and spacing results (capture 0.82 fed, 0.15 starved) come from the deterministic A.2 form. They have not been recomputed for the SDE.

**Lineage.**

- **A.2** (`Model A.2 Repaired Specification and Validation.docx`): deterministic $\tau_c\dot c = \Omega\pi(e_Q)(1-c) - \gamma_{c,ij}c$, with lifetimes $1/\gamma_c$ varying across synapses.
- **A.3** (`Model A.3 Species-Resolved ... .docx`): adds the bistable $\beta_cc^2/(K_c^2+c^2)$ and additive noise $\sqrt{2D}\xi$.
- **A.5 Eq. 21:** the same as A.3.
- **A.4 validation report:** 6% of paths leave $[0,1]$ at $D = 0.002$ and 98% at $D = 0.01$; $c>1$ if $\beta_c>\gamma_c(1+K_c^2)$. Proposes $c^2(1-c)$ and $\sigma c(1-c)dW$.
- **A.6 Eq. 33:** the repaired form.
- **A.7 annex Eq. 33:** writes $dc/dt$ together with $dB$, a notational slip.
- **A.8 PDF Eq. (18):** the printed form. The Lean drift and diffusion definitions are in `Model_A8_All_Equations*.lean`, and the boundary lemmas in `Model_A8_FormalVerification.lean`.
- **Aleph lineage table:** "Condensate capture SDE on [0, 1]".

**Derivation status.** Phenomenological closure for the drift and the noise model. Boundary invariance is exact (Steps 9-16). The bistability and switching conditions are exact for the stated drift.

---

## T6.9: Capture energy gate (inherited: A.5 Eq. 22; $\pi(a_i)$ used without a form from A.6 on)

**Equation as stated in the latest source.** A.5 Eq. 22 (`Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf`), first given in A.2:

$$
\pi(e) = \frac{e^4}{e^4 + e_\pi^4}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $e$ | normalized energy. In A.2-A.5 this is the lumped domain energy $e_Q$; from A.6 on, $\pi(a)$ or $\pi(a_i)$ is written with ATP in mM | dimensionless (proposal: $e = a_i/a_0$) |
| $e_\pi$ | half-activation energy | as $e$ |

**Physical starting point.** Capture of plasticity products needs local ATP. A.2 ties capture to "local mitochondrial metabolism" in the starvation and spacing effects, and A.3 cites synapse-driven local ATP synthesis. A steep, cooperative dependence is represented by a Hill function (Hill 1910), as for $\chi(e)$ in T1.21. Assumptions:

- A1. Concerted dependence on four energy-dependent steps or sites. This is a modelling choice.
- A2. The argument is normalized by the resting ATP $a_0$, as for $\chi(a_i/a_0)$ in A.6 Eq. 31.

**Derivation.**

1. *Hill form.* T6.3 Steps 1-2 with $n=4$, ligand $e$ and constant $e_\pi$ give $\pi = e^4/(e^4+e_\pi^4)$.
2. *Normalization (A2).* Substitute $e = a_i/a_0$, so that $\pi(a_i) = a_i^4/(a_i^4 + (e_\pi a_0)^4)$. A threshold in mM is then $e_\pi a_0$. Without A2, writing $\pi(a)$ with $a$ in mM silently changes the units of $e_\pi$.
3. *Log-sensitivity.* $\ln\pi = 4\ln e - \ln(e^4+e_\pi^4)$, so
$$
\frac{d\ln\pi}{d\ln e} = 4 - \frac{4e^4}{e^4+e_\pi^4} = 4(1-\pi)
$$
4. *Switch width.* Solve $\pi = p$: $e = e_\pi\left(p/(1-p)\right)^{1/4}$. For $p = 0.1$ this is $0.577e_\pi$; for $p = 0.9$ it is $1.732e_\pi$. The gate goes from 10% to 90% over a threefold range of energy.
5. *Starvation contrast.* A.2 holds the domain reserve at 0.85 (fed) and 0.25 (starved). Those values give
$$
\frac{\pi(0.85)}{\pi(0.25)} = \left(\frac{0.85}{0.25}\right)^4\frac{0.25^4 + e_\pi^4}{0.85^4 + e_\pi^4}
$$
   This ratio rises from 1 (for $e_\pi\ll0.25$) to $3.4^4 = 133.6$ (for $e_\pi\gg0.85$). No source gives $e_\pi$, so A.2's capture values (0.82 against 0.15) cannot be reproduced here.

**Result.** The gate follows from A1-A2 as a Hill function and matches A.2 and A.5. It has not been restated since A.5. A.6-A.8 write $\pi(a)$ or $\pi(a_i)$ without saying whether the argument is normalized (Step 2). The gating variable also moved from the domain energy $e_Q$ (A.2-A.5) to the neuron's ATP $a_i$ (A.6 on) without comment.

**Checks.**

- *Range.* $\pi\in[0,1)$, $\pi(e_\pi) = 1/2$, and $\pi$ is increasing.
- *Limits.*
    - $e\to0$: $\pi\approx(e/e_\pi)^4$.
    - $e\to\infty$: $\pi\to1$.
    - As the exponent goes to infinity, the gate becomes a step at $e_\pi$.

**Lineage.**

- **A.2:** introduced, gating capture by domain energy $e_Q$.
- **A.5 Eq. 22:** the last explicit statement.
- **A.6 Eq. 33, A.7 annex Eq. 33, A.8 PDF Eq. (18):** written as $\pi(a)$ or $\pi(a_i)$, with no form given.

**Derivation status.** Phenomenological closure: a Hill-4 switch chosen to make capture energy-dependent. It has not been restated after A.5, and the normalization has been unstated since A.6.

---

## T6.10: Kramers-escape power-law forgetting (inherited: Aleph Sec. 3.1; A.8 Tier 6)

**Equation as stated in Aleph 1** (and in the latest source, A.8, for the full form). Aleph Sec. 3 ("Kramers Escape Theory: Derives power-law forgetting curves $P(t)\propto t^{-\sigma_c^2/\mu}$") and A.8 Tier 6:

$$
P(t) \propto t^{-\sigma_c^2/\mu} \quad (\text{Aleph}), \qquad P(t) \simeq \Gamma\left(1 + \frac{\sigma_c^2}{\mu}\right)\left(\frac{t}{\tau_0}\right)^{-\sigma_c^2/\mu}, \quad p(\Delta U) \propto \exp(-\Delta U/\mu) \quad (\text{A.8})
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $P(t)$ | fraction of captured synapses still captured at time $t$ | dimensionless |
| $\sigma_c$ | capture noise amplitude (T6.8) | time$^{1/2}$ |
| $\Delta U$, $\mu$ | barrier height and mean barrier height | drift-potential units (see Step 9) |
| $\tau_0$ | attempt time (Kramers prefactor) | time |
| $D$ | noise intensity, used by A.3 and A.7 ($\sqrt{2D}\xi$) | barrier units |
| $\Gamma$, $\gamma(\cdot,\cdot)$ | gamma and lower incomplete gamma functions | |

**Physical starting point.** Three ingredients:

- Kramers escape from a metastable well in the weak-noise limit (Kramers 1940; Hänggi, Talkner & Borkovec 1990), applied to the captured state of T6.8.
- Each synapse's escape is a Poisson event.
- An average over synapses whose barriers differ. This is the trap model of Bouchaud (1992), as the A.4 validation report notes.

Assumptions:

- A1. After the tag has decayed, $\Omega\pi = 0$. Then T6.8 is bistable, with captured well $c_+$ and saddle $c_s = c_-$ (T6.8, Steps 3-6).
- A2. Weak noise: barrier ≫ noise intensity.
- A3. Barriers are exponentially distributed across synapses, $p(\Delta U) = \mu^{-1}e^{-\Delta U/\mu}$ for $\Delta U\ge0$. This is assumed, not derived (Part D).
- A4. The prefactor $\tau_0$ is the same for all synapses.

**Derivation.**

*Part A. Kramers rate for the multiplicative-noise SDE of T6.8 (Reconstructed; standard mean-first-passage-time asymptotics).*

1. *Rescale time.* Set $s = t/\tau_c$. Brownian scaling gives $B_t = \sqrt{\tau_c}\,W_s$, with $W$ a standard Brownian motion. Divide T6.8 by $\tau_c$ and substitute $dt = \tau_c\,ds$ and $dB_t = \sqrt{\tau_c}\,dW_s$:
$$
dc = b(c)\,ds + \frac{\sigma_c}{\sqrt{\tau_c}}\,h(c)\,dW_s = b(c)\,ds + \sqrt{2\varepsilon}\,h(c)\,dW_s, \qquad h = c(1-c), \quad \varepsilon = \frac{\sigma_c^2}{2\tau_c}
$$
2. *Diffusion coefficient and quasi-potential.* $D(c) = \varepsilon h(c)^2$. Define
$$
\Phi(c) = -\int_{c_+}^{c}\frac{b(c')}{h(c')^2}\,dc'
$$
   $\Phi' = -b/h^2$. Since $b<0$ on $(0,c_s)$, $b>0$ on $(c_s,c_+)$ and $b<0$ on $(c_+,1)$, $\Phi$ has a local maximum at $c_s$ and a local minimum at $c_+$.
3. *Mean first-passage time.* $T(x)$ is the mean time to reach a point $x_a<c_s$ starting from $x$, with the natural boundary at 1 acting as a reflecting boundary. It solves the backward equation $bT' + DT'' = -1$ with $T(x_a)=0$ and $T'(1)=0$. Let $\psi(x) = \exp\left(-\int^xb/D\right)$. Then
$$
\left(\frac{T'}{\psi}\right)' = \frac{DT''+bT'}{D\psi} = -\frac{1}{D\psi}
$$
   Integrate from $x$ to 1, using $T'(1)=0$, and then from $x_a$ to $c_+$:
$$
T(c_+) = \int_{x_a}^{c_+}\psi(y)\int_y^1\frac{dz}{D(z)\psi(z)}\,dy
$$
4. *Insert $D = \varepsilon h^2$.* $\int b/D = -\Phi/\varepsilon$, so $\psi = e^{\Phi/\varepsilon}$ and $1/(D\psi) = e^{-\Phi/\varepsilon}/(\varepsilon h^2)$.
5. *Laplace's method ($\varepsilon\to0$).* The outer integrand peaks at the maximum of $\Phi$, which is $c_s$. For $y$ near $c_s$, the inner integrand peaks at the minimum of $\Phi$, which is $c_+$. Expanding each to second order:
$$
\int\psi\,dy\approx e^{\Phi(c_s)/\varepsilon}\sqrt{\frac{2\pi\varepsilon}{\lvert\Phi''(c_s)\rvert}}, \qquad \int\frac{dz}{D\psi}\approx\frac{e^{-\Phi(c_+)/\varepsilon}}{\varepsilon h(c_+)^2}\sqrt{\frac{2\pi\varepsilon}{\Phi''(c_+)}}
$$
6. *Multiply.*
$$
T\approx\frac{2\pi}{h(c_+)^2\sqrt{\Phi''(c_+)\lvert\Phi''(c_s)\rvert}}\exp\left(\frac{\Delta\Phi}{\varepsilon}\right), \qquad \Delta\Phi = \Phi(c_s) - \Phi(c_+) = \int_{c_s}^{c_+}\frac{b(c)}{h(c)^2}\,dc>0
$$
7. *Curvatures.* $\Phi'' = -b'/h^2 + 2bh'/h^3$. At a fixed point $b=0$, so $\Phi''(c_+) = \lvert b'(c_+)\rvert/h(c_+)^2$ and $\lvert\Phi''(c_s)\rvert = b'(c_s)/h(c_s)^2$.
8. *Rate in physical time.* $k = 1/(\tau_cT)$:
$$
k = \frac{1}{\tau_0}\exp\left(-\frac{\Delta\Phi}{\varepsilon}\right), \qquad \tau_0 = \frac{2\pi\tau_c\,h(c_s)}{h(c_+)\sqrt{\lvert b'(c_+)\rvert\,b'(c_s)}}
$$
   For additive noise ($h\equiv1$) this reduces to the textbook Kramers formula $k = \sqrt{U''(c_+)\lvert U''(c_s)\rvert}\,e^{-\Delta U/D}/(2\pi)$, with $U = -\int b$. That is A.3's $\tau = \tau_0e^{\Delta U/D}$.
9. *Barrier in the printed variables.*
$$
\frac{\Delta\Phi}{\varepsilon} = \frac{2\tau_c}{\sigma_c^2}\int_{c_s}^{c_+}\frac{b(c)}{c^2(1-c)^2}\,dc
$$
   If $h$ changes little over the barrier, $h\approx\bar h$, then $\Delta\Phi\approx\Delta U/\bar h^2$ with $\Delta U = \int_{c_s}^{c_+}b\,dc$. The exponent becomes $\Delta U/D_{eff}$, with effective noise intensity $D_{eff} = \sigma_c^2\bar h^2/(2\tau_c)$. This is "$\sigma_c^2c^2(1-c)^2/2$" evaluated in the barrier region.
10. *Illustration (computed here; illustrative parameters $K_c = 0.5$, $\beta_c = 3$, $\gamma_c = 1$, not from the sources).*
    - $c_s = 0.0955$ and $c_+ = 0.6545$.
    - $\Delta U = 0.105$ and $\Delta\Phi = 2.29$. The local estimate $\Delta U/h(c_+)^2$ gives 2.05, 11% low.
    - $\tau_0 = 1.80\,\tau_c$.
    
    $h$ changes 2.6-fold across the barrier (0.086 at $c_s$, 0.226 at $c_+$), so the exact $\Delta\Phi$ should be used.

*Part B. One synapse.*

11. *Poisson escape.* In the Kramers regime escape is memoryless, so the survival of a synapse with barrier $\Delta U$ is $S(t\mid\Delta U) = e^{-kt}$.

*Part C. Average over barriers (exact integral).*

12. *Average (A3, A4).* Write $D$ for the noise intensity that divides the barrier: $\varepsilon$ if $\Delta U$ is read as $\Delta\Phi$, or $D_{eff}$ in the local approximation. Then
$$
P(t) = \int_0^\infty\frac{1}{\mu}e^{-\Delta U/\mu}\exp\left(-\frac{t}{\tau_0}e^{-\Delta U/D}\right)d\Delta U
$$
13. *Change of variable.* Let $T = t/\tau_0$ and $y = Te^{-\Delta U/D}$. Then $\Delta U = D\ln(T/y)$ and $d\Delta U = -D\,dy/y$, and $\Delta U: 0\to\infty$ maps to $y: T\to0$. Also $e^{-\Delta U/\mu} = (y/T)^{D/\mu}$.
14. *Evaluate.* Write $\alpha = D/\mu$:
$$
P(t) = \frac1\mu\int_0^T\left(\frac yT\right)^{\alpha}e^{-y}\frac{D\,dy}{y} = \alpha\,T^{-\alpha}\int_0^Ty^{\alpha-1}e^{-y}dy = \alpha\,T^{-\alpha}\,\gamma(\alpha, T)
$$
15. *Limits.*
    - $T\gg1$: $\gamma(\alpha,T) = \Gamma(\alpha) - \Gamma(\alpha,T)$, with $\Gamma(\alpha,T)\sim T^{\alpha-1}e^{-T}$, and $\alpha\Gamma(\alpha) = \Gamma(1+\alpha)$. So
$$
P(t)\simeq\Gamma(1+\alpha)\left(\frac{t}{\tau_0}\right)^{-\alpha}
$$
   with an exponentially small correction. This is the A.8 form.
    - $T\ll1$: $\gamma(\alpha,T)\approx T^\alpha/\alpha$, so $P\to1$.
16. *Numerical check (computed here).* Quadrature of Step 12 agrees with Step 14 to 10 significant digits. The asymptote of Step 15 is accurate to $4\times10^{-6}$ (relative) at $T = 10$ for $\alpha = 0.35$ (0.398061 against 0.398063), and the two coincide at $T = 100$.
17. *Identify the exponent.* $\alpha = D/\mu$. In T6.8's variables,
$$
\alpha = \frac{\varepsilon}{\mu_\Phi} = \frac{\sigma_c^2}{2\tau_c\,\mu_\Phi}\approx\frac{\sigma_c^2\bar h^2}{2\tau_c\,\mu_U}
$$
   Here $\mu_\Phi$ and $\mu_U$ are the means of $\Delta\Phi$ and $\Delta U$. Aleph's exponent $\sigma_c^2/\mu$ agrees only if $\mu$ is defined as $2\tau_c\mu_\Phi$. In terms of the drift-potential barrier it omits the factor $\bar h^2/(2\tau_c)$, which is 0.026 for the illustration with $\tau_c = 1$. The A.8 PDF's $P\propto t^{-0.35}$ corresponds to $\alpha = 0.35$.

*Part D. The exponential barrier distribution is an assumption.*

18. *Barrier near the fold.* Near the saddle-node of T6.8, expand the drift as $b\approx\epsilon_pA - B(c-c^\ast)^2$, where $\epsilon_p$ is the relative distance of $\beta_c$ from its critical value. The fixed points are $c^\ast\pm r$ with $r = \sqrt{\epsilon_pA/B}$. Then
$$
\Delta U = \int_{-r}^{r}\left(\epsilon_pA - Bx^2\right)dx = 2\epsilon_pAr - \frac23Br^3 = \frac43\frac{(\epsilon_pA)^{3/2}}{B^{1/2}}\propto\epsilon_p^{3/2}
$$
   Numerically (computed here, $K_c = 0.5$, $\gamma_c = 1$), the log-log slope of $\Delta U$ against $\epsilon_p$ is 1.4997. This agrees with A.4's "$(\beta-\beta_c)^{1.51}$" and A.6 P11.
19. *Consequence.* Suppose $\beta_c$ varies across synapses with a density that is smooth and non-zero at the critical value. Then $p(\Delta U) = p_\epsilon(\epsilon_p)\,d\epsilon_p/d\Delta U\propto\Delta U^{-1/3}$ near 0, which is not exponential. The exponential tail of A3 has to be assumed (Bouchaud's trap model). T6.8 does not produce it.

**Result.** The averaging integral and its asymptote are exact (Steps 12-16), and they reproduce A.3 and A.8. The escape rate is the weak-noise Kramers asymptote, which for T6.8's multiplicative noise must use the quasi-potential $\Delta\Phi$ (Steps 1-9). Two corrections and one caveat:

- **Exponent.** Aleph's exponent $\sigma_c^2/\mu$ follows a convention that does not match T6.8. The exponent derived from T6.8 is $\sigma_c^2/(2\tau_c\mu_\Phi)$ (Step 17). The power law itself is unaffected, because $\mu$ is a free parameter.
- **Barrier distribution.** It is assumed (Steps 18-19). A power law does not follow from an arbitrary double-well SDE, as GPT §7.1 notes.
- **Retention.** Aleph's "$\propto$" drops the factor $\Gamma(1+\alpha)\tau_0^{\alpha}$.

**Checks.**

- *Dimensions.* $\Delta U/\mu$ and $D/\mu$ are dimensionless. $\varepsilon = \sigma_c^2/(2\tau_c)$ is dimensionless, as $\Delta\Phi$ is.
- *Limits.*
    - $\mu\to\infty$ (deep barriers): $\alpha\to0$, so no forgetting.
    - $\mu\to0$: $\alpha\to\infty$, so forgetting is immediate.
    - $t\ll\tau_0$: $P\to1$.
- *Source numbers.* A.3 simulated 400,000 synapses and fitted 0.499 and 0.250 against predicted 0.5 and 0.25. The Γ-function form agrees with the quadrature (Step 16).

**Lineage.**

- **A.2:** lifetimes with density $\propto\gamma^{a-1}$ give $t^{-a}$ "by construction" (slope −0.52).
- **A.3:** Kramers escape with exponentially distributed barriers, exponent $D/\mu$, additive noise.
- **A.4 validation report, Theorem 5:** "algebra correct", but T6.8's predecessor "does not yield exponential barriers"; cite Bouchaud 1992.
- **A.6 P11:** the barrier distribution is stated as an assumption.
- **A.7:** $P\simeq\Gamma(1+D/\mu)(t/\tau_0)^{-D/\mu}$.
- **A.8:** $D\to\sigma_c^2$; the PDF quotes $t^{-0.35}$.
- **Aleph Sec. 3:** $t^{-\sigma_c^2/\mu}$.

**Derivation status.** Derived under approximations:

- the weak-noise (Kramers) limit;
- Poisson escape;
- the tag gone ($\Omega\pi = 0$);
- a common $\tau_0$;
- an exponential barrier distribution, which is assumed and not produced by T6.8.

The averaging integral is exact.

---

## T6.11: Wake accumulation and circadian-gated sleep downscaling of synapse number (inherited: A.8 PDF Eq. (19); Aleph: pre-dawn circadian sleep pruning)

**Equation as stated in the latest source.** Eq. (19) of `Model_A8_Scientific_Report.pdf`, identical in `Model_A8_model only.docx`:

$$
\text{Wake: } \frac{dS_i}{dt} = g_w\,\mathcal{C}(t)\,(1 + \alpha A_r)
$$

$$
\text{Sleep: } S_i(t) = S_{set} + \left(S_i(t_0) - S_{set}\right)\exp\left(-k_{down}\int_{t_0}^{t}\Theta_{circ}(t')\,u(t')\,dt'\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $S_i$ | synapse number (or synaptic level) of neuron $i$ | synapses |
| $g_w$ | wake gain; zebrafish 1.65 synapses/h (A.3) | synapses h$^{-1}$ |
| $\mathcal C(t)$ | circadian wake factor, which goes to 0 in constant light (A.8, zebrafish) | dimensionless |
| $\alpha$, $A_r$ | arousal gain and arousal. $A_r$ is never defined | $\alpha A_r$ dimensionless |
| $S_{set}$ | set point. Constant up to A.8; dynamic in A.10 (T6.21) | synapses |
| $k_{down}$ | downscaling rate; zebrafish fit 0.069 h$^{-1}$ (A.3) | h$^{-1}$ |
| $\Theta_{circ}$ | circadian switch (T6.13) | dimensionless |
| $u$ | Ado/NE sleep gate (T6.12) | dimensionless |
| $t_0$ | start of the sleep bout | h |

**Physical starting point.** The synaptic homeostasis hypothesis: net potentiation during wake, renormalization during sleep (Tononi & Cirelli 2014). The two-process view of sleep regulation (Borbély 1982): homeostatic pressure, here adenosine and noradrenaline through $u$, gated by a circadian process $\Theta_{circ}$. Calibration and test data are single-neuron synapse counts in larval zebrafish (Suppermpool et al. 2024, cited in A.3-A.8). Assumptions:

- A1. In wake, synapses are added at a rate that does not depend on $S$.
- A2. In sleep, $S$ relaxes towards $S_{set}$ at first order with gated rate $\kappa(t) = k_{down}\Theta_{circ}(t)u(t)\ge0$.
- A3. $S_{set}$ is constant during a bout. This is relaxed in Step 9.
- A4. For calibration only: at the start of the day, $S = S_{set}$.

**Derivation.**

1. *Wake (A1).* Integrate from wake onset $t_w$:
$$
S_i(t) = S_i(t_w) + g_w\int_{t_w}^{t}\mathcal C(t')\left(1 + \alpha A_r(t')\right)dt'
$$
2. *Sleep ODE (A2).* A.3 and A.5 Eq. 24 write the gated relaxation as an ODE, and A.8 inserts $\Theta_{circ}$. A.8 prints only its solution. The ODE is
$$
\frac{dS_i}{dt} = -k_{down}\,\Theta_{circ}(t)\,u(t)\,\left(S_i - S_{set}\right)
$$
3. *Deviation variable (A3).* Let $x = S_i - S_{set}$. Since $S_{set}$ is constant, $\dot x = \dot S_i = -\kappa(t)x$.
4. *Integrating factor.* Let $K(t) = \int_{t_0}^t\kappa(t')dt'$. Then $\frac{d}{dt}\left(xe^{K}\right) = (\dot x + \kappa x)e^{K} = 0$, so $x(t)e^{K(t)} = x(t_0)$ and
$$
S_i(t) = S_{set} + \left(S_i(t_0) - S_{set}\right)e^{-K(t)}
$$
   This is the printed sleep relation. It is exact for any integrable $\kappa\ge0$.
5. *Properties.* $e^{-K}\in(0,1]$. The deviation keeps its sign and never grows, so $S$ never overshoots $S_{set}$. The map $S(t_0)\mapsto S(t)$ is affine with slope $e^{-K}$, hence non-expansive. This is what the A.4 validation report means when it says the exact flow "gives Theorem 6".
6. *Zebrafish calibration (A.3, with $u = 1$ and no $\Theta$, A4).* The day excess is $E = g_w\times13\ \mathrm h = 21.45$ synapses. Over $\Delta t$ the loss is $L = E(1 - e^{-k\Delta t})$. Solve for $k$:
$$
k = -\frac{1}{\Delta t}\ln\left(1 - \frac{L}{E}\right) = -\frac{1}{5\ \mathrm h}\ln\left(1 - \frac{6.28}{21.45}\right) = 0.0693\ \mathrm h^{-1}
$$
   This agrees with A.3's 0.069 h$^{-1}$.
7. *Deprivation prediction.* After 4 h of deprivation that adds 13.0 synapses, the loss over 6 h of recovery sleep is $(21.45 + 13.0)(1 - e^{-6k}) = 11.72$ (computed here). A.3 gives 11.7; the observed value is 11.9.
8. *The failure that motivates $\Theta_{circ}$.* Use the same law for the second half of a normal night (6 h). The remaining excess is $21.45 - 6.28 = 15.17$, and the further loss is $15.17(1 - e^{-6k}) = 5.16$ (computed here). A.3 gives "5.2"; the observed value is +0.8. To stop the loss, $\int\Theta_{circ}u\,dt$ has to be close to 0 from about ZT18. That is 6 h before lights-on, not the 2 h quoted by A.8 (see T6.13).
9. *Dynamic set point (A.10, T6.21; relaxing A3).* With $S_{set}(t)$, the ODE is $\dot S = -\kappa(S - S_{set}(t))$. Variation of constants, with $K(t,s) = \int_s^t\kappa$, gives
$$
S_i(t) = S_i(t_0)e^{-K(t,t_0)} + \int_{t_0}^t\kappa(s)S_{set}(s)e^{-K(t,s)}ds
$$
   Since $\partial_se^{-K(t,s)} = \kappa(s)e^{-K(t,s)}$, integration by parts turns the integral into $S_{set}(t) - S_{set}(t_0)e^{-K(t,t_0)} - \int_{t_0}^t\dot S_{set}(s)e^{-K(t,s)}ds$. Therefore
$$
S_i(t) - S_{set}(t) = \left(S_i(t_0) - S_{set}(t_0)\right)e^{-K(t,t_0)} - \int_{t_0}^t\dot S_{set}(s)\,e^{-K(t,s)}\,ds
$$
   The printed closed form is exact only if $\dot S_{set} = 0$ during the bout. Its error is at most $\int_{t_0}^t\lvert\dot S_{set}\rvert ds$.
10. *Missing link to the weights (Proposal).* A.6 replaced the SWS weight map $W\leftarrow(1-\delta(1-P))W$ by this flow, "so there is one sleep operator". But $S_i$ counts synapses, while T6.4 evolves weights, and no source maps one to the other. Two consistent choices:
    - $S_i = \sum_j\mathbf 1\lbrace W_{ij}>w_{th}\rbrace$, with the flow realized by removing the weakest unprotected synapses;
    - the A.4 validation proposal: apply the flow to each weight, $W(T) = S_{set} + (W - S_{set})e^{-k\int u}$, with $S_{set}$ read as a weight target.
    
    The SWS map spared tagged synapses through $(1-P)$. The S-flow has no $P$-dependence, so that protection is lost unless it is re-introduced.
11. *Wake factor.* In constant light $\mathcal C\to0$ (A.8, zebrafish branch). The A.4 validation report gives deprived fish 2.9 synapses/h against 1.65 by day. If $\mathcal C$ is the same at night as by day, this needs $1+\alpha A_r = 2.9/1.65 = 1.76$ (computed here, under that assumption).

**Result.** For the stated ODE (Step 2) the closed form is exact (Steps 3-4), and it matches A.6-A.8. The A.3 calibration and prediction are reproduced (Steps 6-8). The model itself is phenomenological. Three things are missing from the sources:

- the closed form ignores the dynamic $S_{set}$ of A.10; the general form is Step 9;
- there is no rule linking $S_i$ to $W_{ij}$;
- $A_r$ is undefined.

The A.7 Upgrade document says the product gate was replaced by an "ATP/ADP & ROS leak" gate, but gives no formula. A.8 restores the Ado/NE gate, and Aleph inherits A.8.

**Checks.**

- *Dimensions.* $[k_{down}\int\Theta u\,dt] = \mathrm h^{-1}\cdot\mathrm h$, dimensionless. $[g_w\mathcal C(1+\alpha A_r)]$ = synapses h$^{-1}$.
- *Limits.*
    - $u = 0$ or $\Theta_{circ} = 0$: $S$ frozen.
    - $k_{down}\to\infty$ with $\Theta u>0$: instantaneous reset to $S_{set}$.
    - $\mathcal C = 0$: no wake gain.
- *Fixed point.* $S_{set}$ during sleep. There is no fixed point during wake: $S$ grows linearly and nothing saturates it.

**Lineage.**

- **Model A and A.2:** SWS map $W\leftarrow(1-\delta(1-P))W$ applied once per cycle ($\delta\approx0.18$-0.20).
- **A.3:** continuous gate $dS/dt = -k\,u(\mathrm{Ado},\mathrm{NE})(S - S_{set})$; zebrafish fit and prediction.
- **A.5 Eq. 24:** the same.
- **A.4 validation report:** exact flow over a bout; $g_w = g_0\mathcal C(t)(1+\text{arousal})$.
- **A.6 Eq. 37:** the unified operator.
- **A.7 annex Eq. 37:** the same. The Upgrade document claims an ATP/ADP-ROS gate.
- **A.8 PDF Eq. (19):** adds $\Theta_{circ}$.
- **A.10 Eq. 6.2:** makes $S_{set}$ dynamic.
- **Aleph lineage table:** "pre-dawn circadian sleep pruning".

**Derivation status.** Exact as the closed form of the stated gated relaxation (Steps 2-4, and Step 9 for a dynamic set point). The model itself is a phenomenological closure.

---

## T6.12: Adenosine/noradrenaline product sleep gate (inherited: A.8 Tier 6, unnumbered)

**Equation as stated in the latest source.** A.8 (`Model_A8_model only.docx`, `Model_A8_Scientific_Report.docx`), unnumbered, printed with Eq. (20):

$$
u(t) = \sigma\left(\frac{[Ado] - \theta_A}{s_A}\right)\left[1 - \sigma\left(\frac{NE - \theta_N}{s_N}\right)\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $u$ | sleep downscaling gate | dimensionless, $(0,1)$ |
| $\sigma$ | logistic $1/(1+e^{-x})$ | |
| $[Ado]$, $\theta_A$, $s_A$ | interstitial adenosine (T6.14), threshold, width | concentration (A.6: "relative") |
| $NE$, $\theta_N$, $s_N$ | noradrenaline level, threshold, width. Its link to $NE_{LC}$ (T2.2) is not stated | concentration |

**Physical starting point.** Adenosine acting on A1 receptors builds sleep pressure (Porkka-Heiskanen et al. 1997). Locus coeruleus noradrenaline opposes sleep-dependent synapse loss. Suppermpool et al. (2024), as summarized in A.3 and the A.4 validation report, found that loss needs high adenosine and low noradrenaline: in daytime fish, only 2-chloroadenosine with clonidine produced loss. Assumptions:

- A1. Each factor is the probability of a binary permissive condition: adenosine signalling on, and noradrenergic suppression off.
- A2. The two conditions are independent.
- A3. Each probability is a smooth switch in the concentration.

**Derivation.**

1. *Mass-action occupancy.* One-site binding gives $\theta = A/(A+K)$. Divide numerator and denominator by $A$ and write $K/A = e^{-(\ln A - \ln K)}$:
$$
\theta = \frac{1}{1 + e^{-(\ln A - \ln K)}} = \sigma(\ln A - \ln K)
$$
   Mass action is therefore a logistic in the logarithm of the concentration, with unit slope. With Hill coefficient $n$, it is $\sigma(n(\ln A - \ln K))$.
2. *Match the printed (linear-concentration) logistic.* At the half point $A = \theta_A = K$:
    - the Hill form has slope $d\sigma(n\ln(A/K))/dA = n/(4K)$;
    - the printed form has slope $1/(4s_A)$.
    
    Equal slopes require $s_A = K/n$. The printed form is the linear-concentration approximation of a Hill switch with $n = \theta_A/s_A$.
3. *Difference at low concentration.* At $A = 0$ the printed factor is $\sigma(-\theta_A/s_A) = \sigma(-n)$: 0.269 for $n = 1$ and 0.018 for $n = 4$. Mass action gives 0. The printed gate leaves a floor unless $\theta_A\gg s_A$.
4. *Noradrenergic factor.* The probability that NE does not suppress is $1 - \sigma((NE - \theta_N)/s_N) = \sigma(-(NE-\theta_N)/s_N)$, by the same logic and the identity $1-\sigma(x) = \sigma(-x)$.
5. *Product (A2).* The joint probability of two independent permissive conditions is the product of their probabilities. This is the printed $u$.
6. *Properties.*
    - $0<u<1$.
    - $\partial u/\partial[Ado]>0$ and $\partial u/\partial NE<0$.
    - $u\le\min$ of the two factors.
    - $u\to1$ only when $[Ado]\gg\theta_A$ and $NE\ll\theta_N$.
7. *Link to the LC oscillator (Proposal).* $\mathrm{Re}\,NE_{LC}$ (T2.2) has zero mean over the limit cycle, so it cannot be $NE$ by itself. With the Tier 2 proposal $[NE](t) = \overline{NE} + a_{NE}\mathrm{Re}\,NE_{LC}(t)$, the consistent choice is $NE = \overline{NE}$, the cycle average. Using the instantaneous value would make $u$ oscillate at 0.01-0.05 Hz. T6.16 already uses $\overline{NE}$ for its gate.

**Result.** The gate is a phenomenological product of independent switches (Steps 4-5). Each switch approximates a Hill occupancy, with $s_A = \theta_A/n$, but has a non-zero floor (Steps 1-3). It matches A.5 Eq. 25 and A.6-A.8. What it lacks:

- the identity of $NE$ (Proposal, Step 7);
- units for $[Ado]$ ("relative" in A.6).

The A.7 claim of an ATP/ADP-ROS replacement conflicts with A.8, and A.8 is what Aleph inherits.

**Checks.**

- *Dimensions.* Both arguments are dimensionless if each width has its variable's units.
- *Limits.*
    - $s_A, s_N\to0$: $u$ becomes the indicator of $\lbrace[Ado]>\theta_A,\ NE<\theta_N\rbrace$.
    - $NE\to\infty$: $u\to0$, as with clonidine removed and LC active.
- *Evidence (A.4 validation report).* Fitted to nine group means with four parameters, the product gate scores $\chi^2 = 4.6$ and AIC 12.6, against 22.8 for A.3's ungated law. It is the only variant that gives loss in exactly one daytime group, 2-chloroadenosine with clonidine (fit −0.43/h, observed −0.82 ± 0.57/h). Its held-out errors are larger (1.45 SE), and it needs an adenosine clearance of 0.56 h, which is too fast.

**Lineage.**

- **A.3:** verbal ("a gate that needs high adenosine and low noradrenaline").
- **A.5 Eq. 25:** the printed product.
- **A.4 validation report:** model comparison.
- **A.6 Eq. 37; A.7 annex Eq. 37:** unchanged. The A.7 Upgrade document claims a thermodynamic gate with no formula.
- **A.8:** the printed form.
- **Lean:** `sigmoidal_gate` (`Model_A8_All_Equations*.lean`) is the generic logistic; it is used only in `v_glymph`.

**Derivation status.** Phenomenological closure. It is motivated by receptor occupancy and by the drug-combination data. The evidence is the A.4 group-level fit.

---

## T6.13: Pre-dawn circadian pruning tensor (inherited: A.8 PDF Eq. (20))

**Equation as stated in the latest source.** Eq. (20) of `Model_A8_Scientific_Report.pdf`:

$$
\Theta_{circ}(t) = \frac{1}{1 + \exp\left(\frac{t - t_{dawn}}{\tau_{circ}}\right)}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Theta_{circ}$ | circadian permissive factor for pruning. Called a "tensor" but scalar in every source | dimensionless |
| $t_{dawn}$ | subjective dawn | h |
| $\tau_{circ}$ | transition width | h |

**Physical starting point.** A clock-driven override that stops sleep-dependent synapse loss before dawn. The A.7 Upgrade document calls for "a systemic, clock-driven neuromodulatory tensor potentially tied to orexin or hypocretin pathways". The zebrafish data motivate it: loss stops in the second half of the night (T6.11, Step 8). Assumption A1: the permissive state is a two-state switch whose free-energy difference is linear in clock time. The logistic form follows from that; the rest is a modelling choice.

**Derivation.**

1. *Identity.* With $x = (t - t_{dawn})/\tau_{circ}$,
$$
\Theta_{circ} = \frac{1}{1+e^{x}} = 1 - \frac{1}{1+e^{-x}} = 1 - \sigma(x)
$$
2. *Two-state reading (A1; Reconstructed as in T6.1, Steps 10-11).* Take a permissive state P and an arrested state R with $G_R - G_P = -g\,(t - t_{dawn})$. The Boltzmann probability of P is $1/(1 + e^{g(t-t_{dawn})/k_BT})$. This is the printed form with $\tau_{circ} = k_BT/g$.
3. *Shape.* $\Theta(t_{dawn}) = 1/2$ and $d\Theta/dt = -\Theta(1-\Theta)/\tau_{circ}$. $\Theta = 0.9$ at $x = -\ln9$ and $0.1$ at $x = +\ln9$, so the 10-90% transition takes $2\tau_{circ}\ln9 = 4.39\,\tau_{circ}$.
4. *Not periodic.* As printed, $\Theta\to0$ for all $t\gg t_{dawn}$. After the first dawn, sleep downscaling (T6.11) would be switched off for good. The function must act on circadian phase. Proposal: with period $T = 24$ h, define the phase relative to dawn, $\vartheta(t) = \left((t - t_{dawn} + T/2)\bmod T\right) - T/2\in[-T/2, T/2)$, and set
$$
\Theta_{circ}(t) = \frac{1}{1 + \exp\left(\vartheta(t)/\tau_{circ}\right)}
$$
   This form jumps at $\vartheta = \pm T/2$, 12 h from dawn. For a diurnal animal that falls in the wake period, where $u\approx0$, so the jump has no effect there. A smooth alternative is a product of two logistics that opens at sleep onset and closes before dawn.
5. *The "final 2 hours" claim.* A.8 says the tensor "arrests synaptic pruning during the final 2 hours of the sleep cycle". With $t_{dawn}$ equal to clock dawn, $\Theta(t_{dawn} - 2\,\mathrm h) = \sigma(2\,\mathrm h/\tau_{circ})>1/2$. Pruning is still mostly on, and the arrest happens only after dawn. To have $\Theta\le0.1$ from dawn minus 2 h onwards, the centre $t_c$ of the switch must satisfy $t_c\le t_{dawn} - 2\,\mathrm h - \tau_{circ}\ln9$. The parameter "$t_{dawn}$" must therefore be read as the time of arrest, not dawn. The zebrafish data (T6.11, Step 8) put it near ZT18, 6 h before lights-on.
6. *Consistency with the barrier inference.* A.8 Inference 4 writes $\Delta U_{eff}(t) = \Delta U_0\left[1 + \zeta_{circ}\,\sigma(x)\right]$. By Step 1, $\sigma(x) = 1-\Theta_{circ}$, so $\Delta U_{eff} = \Delta U_0[1 + \zeta_{circ}(1-\Theta_{circ})]$: the barrier rises as $\Theta$ falls. This agrees with $\Theta$ as a permissive factor. Before $t_{dawn}$, $1-\Theta\le1/2$, so A.8's "+45% in the final 2 hours before dawn" needs $\zeta_{circ}\ge0.9$ (computed here). Escape is then suppressed by the factor $e^{-0.45\Delta U_0/\sigma_c^2}$, in A.8's convention.
7. *Sign conflict with A.10.* A.10 Eq. 6.2 (T6.21) gates set-point pruning by $1-\Theta_{circ}$. That makes it active when A.8 says pruning is arrested. Either this is a sign inversion, or it describes a different (daytime) pruning of the set point. No source says which.

**Result.** The logistic follows from A1 (Step 2), and its properties are exact (Step 3). The sources leave three things out:

- **Periodicity.** The printed $\Theta$ is not periodic, so it works only for a single night (Step 4; Proposal supplied).
- **Meaning of $t_{dawn}$.** For the A.8 claim to hold, $t_{dawn}$ must be the arrest time, not dawn (Step 5).
- **Zebrafish branch.** Its 14:10 photoperiod form is described but never written.

**Checks.**

- *Dimensions.* $(t-t_{dawn})/\tau_{circ}$ is dimensionless.
- *Limits.*
    - $\tau_{circ}\to0$: a step, $\Theta = \mathbf 1\lbrace t<t_{dawn}\rbrace$.
    - $\tau_{circ}\to\infty$: $\Theta\equiv1/2$.
- *Range.* $\Theta\in(0,1)$.

**Lineage.**

- **A.7 Upgrade document:** a clock-driven override listed as an A.8 need.
- **A.8 PDF Eq. (20)** (`Model_A8_Scientific_Report.pdf`; `.docx`; `Model_A8_model only.docx`): the printed form. A.8 says it resolves "the per-organism slope discrepancy" (r = 0.58).
- **A.8 Inference 4:** the $\Delta U_{eff}$ barrier.
- **A.10 Eq. 6.2:** uses $1-\Theta_{circ}$.
- **Aleph lineage table:** "pre-dawn circadian sleep pruning tensor $\Theta_{circ}(t)$".

**Derivation status.** Phenomenological closure, also incomplete in source: not periodic, $t_{dawn}$ ambiguous, photoperiod branch unwritten, and the gating sign inconsistent with A.10.

---

## T6.14: Interstitial adenosine (sleep pressure) dynamics (inherited: A.7 annex Eq. 36 / A.6 Eq. 36)

**Equation as stated in the latest source.** A.7 annex Eq. 36 (`Model A.7 with all equations.docx`), identical to A.6 Eq. 36. A.5 Eq. 23 writes $[Ado]_Q$, $\eta_{ATP}$ and $\lambda_{uptake}$:

$$
\frac{d[Ado]}{dt} = \eta\,\Pi_Q - \lambda_u[Ado] - v_{glymph}[Ado]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[Ado]$ | interstitial adenosine of territory $Q$ | concentration (A.6: "relative") |
| $\eta$ | adenosine yield per unit pump flux ("per pump turnover") | concentration per unit $\Pi$ |
| $\Pi_Q$ | Na$^+$/K$^+$ pump flux summed over $Q$, $\sum_{i\in Q}\Pi_i$ (T1.19). This clashes with the potentiation drive $\Pi_Q$ of T6.6 | Na$^+$ units s$^{-1}$ |
| $\lambda_u$ | uptake and metabolism rate constant | s$^{-1}$ |
| $v_{glymph}$ | glymphatic velocity (T6.16). Here it is used as a rate | printed: velocity; required: s$^{-1}$ |

**Physical starting point.** A mass balance for adenosine in a well-mixed interstitial compartment. Extracellular adenosine comes from hydrolysis of released ATP, ADP and AMP by ectonucleotidases, and from equilibrative efflux. It is removed by equilibrative uptake followed by adenosine kinase or deaminase, and by convective washout. Assumptions:

- A1. Fixed, well-mixed interstitial volume $V_Q$.
- A2. Production is proportional to the ATP turnover of the pumps, $\Pi_Q/3$ (3 Na$^+$ per ATP).
- A3. Uptake is Michaelis-Menten, linearized for $[Ado]\ll K_m$.
- A4. Washout is by a volume flow $Q_v$ of adenosine-free fluid that leaves at the compartment concentration.
- A5. Diffusive exchange with neighbouring territories is neglected.

**Derivation.**

1. *Mass balance (A1, A4, A5).* With $A = [Ado]$,
$$
V_Q\frac{dA}{dt} = J_{prod} - J_{upt} - Q_vA
$$
2. *Production (A2).* $J_{prod} = Y\Pi_Q/3$, where $Y$ is adenosine per ATP hydrolysed.
3. *Uptake (A3).* $J_{upt} = V_{max}A/(K_m + A)\approx(V_{max}/K_m)A$ for $A\ll K_m$.
4. *Divide by $V_Q$.*
$$
\frac{dA}{dt} = \frac{Y}{3V_Q}\Pi_Q - \frac{V_{max}}{K_mV_Q}A - \frac{Q_v}{V_Q}A
$$
   Name the coefficients: $\eta = Y/(3V_Q)$, $\lambda_u = V_{max}/(K_mV_Q)$, and washout rate $k_g = Q_v/V_Q$. This is the printed form with $v_{glymph}\to k_g$.
5. *Units of the washout term.* Write the volume flow as velocity times cross-section, $Q_v = vS_\perp$. Then $k_g = v/\ell_Q$ with $\ell_Q = V_Q/S_\perp$. The printed $v_{glymph}[Ado]$ has units of velocity times concentration, not concentration per time. The consistent term is $(v_{glymph}/\ell_Q)[Ado]$. The A.4 validation report and the Tier 2 file (T2.13, Step 6) flag the same problem. With the A.9/A.10 perivascular flux, $k_g = \bar J_v/V_Q$ (T2.16).
6. *Exact solution.* With constant coefficients, $A^\ast = \eta\Pi_Q/(\lambda_u + k_g)$ and $\tau_A = 1/(\lambda_u + k_g)$, and
$$
A(t) = A^\ast + (A(0) - A^\ast)e^{-t/\tau_A}
$$
   With time-varying coefficients, the integrating factor $e^{\int(\lambda_u + k_g)}$ gives $A(t) = A(0)e^{-\int_0^t(\lambda_u+k_g)} + \int_0^t\eta\Pi_Q(s)e^{-\int_s^t(\lambda_u+k_g)}ds$.
7. *Wake and sleep.* $\Pi_Q$ is larger in wake, so $A^\ast$ is higher. In NREM sleep the pump flux falls and $k_g$ rises (T6.16), so $A$ decays with $\tau_A$. The A.4 validation report fitted $\tau_A = 0.56$ h of sleep and noted that rodent microdialysis shows decline over hours. Forcing $\ge2$ h kept the group fit ($\chi^2$ 4.95) but worsened held-out prediction.

**Result.** The printed form follows from A1-A5 (Steps 1-4), except for one units error: $v_{glymph}$ is a velocity used as a rate constant. The corrected washout term is $(v_{glymph}/\ell_Q)[Ado]$, or $(\bar J_v/V_Q)[Ado]$ with A.9/A.10 transport (Step 5). $\Pi_Q$ here is the pump flux, not T6.6's potentiation drive. No yields or volumes are given. The equation has not been restated since A.7, although A.8 uses $[Ado]$ in $u$.

**Checks.**

- *Positivity.* At $A = 0$, $dA/dt = \eta\Pi_Q\ge0$.
- *Dimensions.* $[\eta\Pi_Q] = [\lambda_uA]$ = concentration/time. As printed, $v_{glymph}A$ fails.
- *Limits.*
    - $k_g\to0$: uptake-only clearance.
    - $\Pi_Q\to0$: exponential decay.
    - Steady state: $A^\ast$.
- *Mechanism.* The A.4 validation report calls glymphatic washout of adenosine "contested": Miao et al. 2024 report lower clearance in sleep, against Hauglund et al. 2025. Enzymatic clearance predicts the same plateau.

**Lineage.**

- **A.5 Eq. 23:** introduced, with $\eta_{ATP}$ and $\lambda_{uptake}$.
- **A.4 validation report:** a reduced form (build-up in wake, clearance in sleep); clearance 0.56 h fitted.
- **A.6 Eq. 36; A.7 annex Eq. 36:** the printed form; the A.7 annex is the last explicit statement.
- **A.8:** uses $[Ado]$ in $u$ (T6.12) without dynamics.

**Derivation status.** Phenomenological closure: a mass balance with linear kinetics. It is also incomplete in source, because of the velocity-as-rate units error, the $\Pi_Q$ symbol clash, and no restatement after A.7.

---

## T6.15: REM weight jump with headroom projection (inherited: A.8 Tier 6)

**Equation as stated in the latest source.** A.8 (`Model_A8_model only.docx`, `Model_A8_Scientific_Report.docx`), identical to A.6 Eq. 35 and the A.7 annex:

$$
\Delta W = \lambda_Q\,\eta_R\,P\,(w_{max} - W) - \pi_R\,(1 - P)\,\sigma\left(\frac{w_p - W}{s_w}\right)W, \qquad \lambda_Q = \min\left\lbrace 1, \frac{h_Q/\beta + \sum \mathrm{dec}}{\sum \mathrm{inc}}\right\rbrace
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Delta W$ | REM jump of one weight | as $W$ |
| $\eta_R$ | REM strengthening fraction | dimensionless |
| $P$ | persistence (T6.7) | dimensionless |
| $\pi_R$ | pruning strength (clashes with $\pi$, T6.9) | dimensionless |
| $w_p$, $s_w$ | pruning threshold and width | as $W$ |
| $\lambda_Q$ | headroom projection scalar | dimensionless, $[0,1]$ |
| $\sum\mathrm{inc}$, $\sum\mathrm{dec}$ | sums over $Q$ of the strengthening and pruning increments | as $W$ |
| $h_Q$, $\beta$ | headroom and cost per unit weight (T6.5) | $h_Q/\beta$ in weight units |

**Physical starting point.** REM sleep strengthens tagged synapses and prunes weak untagged ones (A.2). The strengthening is projected so that the jump cannot breach the headroom barrier. This is the discrete-time version of T6.6's construction. Assumptions:

- A1. The increments are $\mathrm{inc}_{ij} = \eta_RP_{ij}(w_{max}-W_{ij})\ge0$ and $\mathrm{dec}_{ij} = \pi_R(1-P_{ij})\sigma((w_p-W_{ij})/s_w)W_{ij}\ge0$.
- A2. Only the strengthening is scaled.
- A3. Headroom is weight-based, $h_Q = C_{max,Q} - \beta\sum W$.

**Derivation.**

*Part A. The projection (exact).*

1. *Jump.* $\Delta W_{ij} = \lambda_Q\,\mathrm{inc}_{ij} - \mathrm{dec}_{ij}$.
2. *Post-jump headroom (A3).* $h_Q' = C_{max,Q} - \beta\sum(W + \Delta W) = h_Q - \beta\left(\lambda_Q\sum\mathrm{inc} - \sum\mathrm{dec}\right)$.
3. *Barrier.* $h_Q'\ge0$ if and only if $\lambda_Q\sum\mathrm{inc}\le h_Q/\beta + \sum\mathrm{dec}$.
4. *Largest admissible scalar.* For $\sum\mathrm{inc}>0$, the largest $\lambda_Q\in[0,1]$ satisfying Step 3 is
$$
\lambda_Q = \min\left\lbrace1, \frac{h_Q/\beta + \sum\mathrm{dec}}{\sum\mathrm{inc}}\right\rbrace
$$
   This is the printed form. $\lambda_Q\ge0$ because $h_Q\ge0$ and $\sum\mathrm{dec}\ge0$. If $\sum\mathrm{inc} = 0$, $\lambda_Q$ has no effect and can be set to 1.
5. *When the projection binds.* If $\lambda_Q<1$, substitute Step 4 into Step 2:
$$
h_Q' = h_Q - \beta\left(\frac{h_Q}{\beta} + \sum\mathrm{dec} - \sum\mathrm{dec}\right) = 0
$$
   The headroom lands exactly on zero. This reproduces A.6 P3 ("h: 0.0028 → 0.000"). Without the projection, the A.4 validation report has it going from 0.0028 to −0.011.

*Part B. The weight box.*

6. *Upper bound.* $W' = W + \lambda_Q\eta_RP(w_{max} - W) - \mathrm{dec}\le W + (w_{max} - W) = w_{max}$ when $\lambda_Q\eta_RP\le1$, which holds if $\eta_R\le1$.
7. *Lower bound.* $W'\ge W - \pi_R(1-P)\sigma(\cdot)W\ge(1-\pi_R)W\ge0$ when $\pi_R\le1$.

*Part C. Lipschitz constant of the map, with $\lambda_Q$ and $P$ held fixed.*

8. *Strengthening.* $W\mapsto W + \lambda_Q\eta_RP(w_{max}-W)$ has slope $1 - \lambda_Q\eta_RP\in[1-\eta_R, 1]$. It is non-expansive.
9. *Pruning term.* Let $\phi(W) = W\sigma(x)$ with $x = (w_p - W)/s_w$. By the chain rule, $d\sigma/dW = -\sigma(1-\sigma)/s_w$, so
$$
\phi'(W) = \sigma(x) - \frac{W}{s_w}\sigma(x)(1-\sigma(x))
$$
10. *Slope of the pruning map.* $M(W) = W - \pi_R(1-P)\phi(W)$ has $M' = 1 - \pi_R(1-P)\phi'$. It is expansive where $\phi'<0$. Write $a = w_p/s_w$, so that $W/s_w = a - x$:
$$
-\phi' = \sigma(1-\sigma)(a - x) - \sigma
$$
11. *Bound.*
    - For $x\ge0$: $-\phi'\le\sigma(1-\sigma)a\le a/4$, since $\sigma(1-\sigma)\le1/4$.
    - For $x<0$: $-\phi' = \sigma(1-\sigma)a + \sigma\left[(1-\sigma)\lvert x\rvert - 1\right]\le a/4 + m_0$, where $m_0 = \sup_{v>0}\sigma(-v)\left[(1-\sigma(-v))v - 1\right] = 0.0998$ (computed here, at $v\approx2.40$).
    
    Hence
$$
\mathrm{Lip}(M)\le1 + \pi_R(1-P)\left(\frac{w_p}{4s_w} + 0.0998\right)
$$
12. *A.2's bound.* A.2's $1 + \pi_Rw_p/(4s_w)$ drops $m_0$. The exact supremum of $-\phi'$ (computed numerically here) is below $a/4$ if and only if $a\ge0.626$:
    - $a = 0.25$: 0.120 against $a/4 = 0.0625$;
    - $a = 1$: 0.199 against 0.25;
    - $a = 3.76$: 0.669 against 0.94.
    
    At A.2's defaults ($\pi_Rw_p/(4s_w) = 0.94$, so $a\ge3.76$ because $\pi_R\le1$), A.2's bound is valid and conservative. With $\pi_R = 1$ the true constant is 1.67, against A.2's 1.94.
13. *Dependence of $\lambda_Q$ on $W$.* $\lambda_Q$ depends on $W$ through $h_Q$, $\sum\mathrm{inc}$ and $\sum\mathrm{dec}$. It is Lipschitz where $\sum\mathrm{inc}$ is bounded away from zero, because it is the minimum of Lipschitz functions. The full map's constant gains terms from $\partial\lambda_Q/\partial W$, which no source bounds.

**Result.** $\lambda_Q$ is exactly the largest scalar in $[0,1]$ that keeps the post-jump headroom non-negative (Steps 1-4), and it lands $h_Q$ on 0 when it binds (Step 5). The printed form matches. A.2's contraction bound holds for $w_p/s_w\ge0.626$, which covers the A.2 defaults. A universal bound is given in Step 11. Two caveats:

- A.8 defines $h_Q$ in demand units (T6.5), so a jump also changes the plasticity cost $\kappa\lvert\Delta W\rvert$. That cost is impulsive for a jump and is not accounted for. Step 2 is exact only under A3.
- The map itself is phenomenological.

**Checks.**

- *Dimensions.* $h_Q/\beta$ and the sums are in weight units, so $\lambda_Q$ is dimensionless.
- *Limits.*
    - $h_Q\to\infty$: $\lambda_Q = 1$.
    - $h_Q = 0$ and $\sum\mathrm{dec} = 0$: $\lambda_Q = 0$, no strengthening.
    - $P = 1$: pure strengthening.
    - $P = 0$: pure pruning.

**Lineage.**

- **Model A:** REM map $W\leftarrow W + \eta_R\Omega(w_{max} - W)$.
- **A.2:** adds pruning; proves the Lipschitz bound (Property 4).
- **A.4 validation report:** the REM jump breaks Theorem 3; proposes scaling by $\min(1, h/(\beta\sum\Delta W^+))$.
- **A.6 Eq. 35:** the printed projection, with the decrements credited. P3 verifies it.
- **A.7 annex Eq. 35; A.8:** unchanged.

**Derivation status.** Exact as a projection construction, under weight-based headroom. The REM map itself is a phenomenological closure.

---

## T6.16: Glymphatic peristalsis velocity driven by infraslow NE oscillations (inherited: A.8 Tier 6; Aleph: glymphatic peristalsis)

**Equation as stated in the latest source.** A.8 (`Model_A8_model only.docx`, `Model_A8_Scientific_Report.docx`), identical to A.6 Eq. 38 and A.7 annex Eq. 38:

$$
v_{glymph} = v_0 + v_1\cdot\mathbf{1}_{NREM}\cdot\left(\frac{AQP4}{AQP4_0}\right)\cdot\frac{\mathcal{A}_{NE}}{\mathcal{A}_{NE} + K_{NE}}\cdot\left[1 - \sigma\left(\frac{\overline{NE} - \theta_g}{s_g}\right)\right]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $v_{glymph}$ | glymphatic (perivascular) velocity | µm s$^{-1}$ |
| $v_0$, $v_1$ | baseline velocity and NREM increment | µm s$^{-1}$ |
| $\mathbf 1_{NREM}$ | NREM indicator | 0 or 1 |
| $AQP4/AQP4_0$ | relative AQP4 polarity | dimensionless |
| $\mathcal A_{NE}$, $K_{NE}$ | amplitude of 0.01-0.05 Hz NE oscillations (Hauglund et al. 2025) and half-saturation | NE units |
| $\overline{NE}$, $\theta_g$, $s_g$ | mean NE, gate threshold, width | NE units |

**Physical starting point.** Infraslow LC noradrenaline oscillations in NREM sleep drive arterial vasomotion, which pumps cerebrospinal fluid along perivascular spaces (Hauglund et al. 2025). Low mean NE in sleep enlarges the interstitial space (Xie et al. 2013). AQP4 at endfeet supports exchange (Iliff et al. 2012). Assumptions:

- A1. There is a baseline velocity $v_0$ in every state.
- A2. The NREM increment is a product of independent factors in $[0,1]$.
- A3. The increment is linear in relative AQP4.
- A4. It saturates in oscillation amplitude (a Michaelis-Menten form).
- A5. Low mean NE is permissive.

**Derivation.**

1. *Assemble (A1-A5).* $v = v_0 + v_1\prod_kF_k$, with $F_1 = \mathbf 1_{NREM}$, $F_2 = AQP4/AQP4_0$, $F_3 = \mathcal A/(\mathcal A + K_{NE})$ and $F_4 = 1 - \sigma((\overline{NE}-\theta_g)/s_g)$. This is the printed form.
2. *Range.* If $AQP4\le AQP4_0$, every factor is in $[0,1]$ and $v\in[v_0, v_0 + v_1]$.
3. *Zolpidem limit.* As $\mathcal A_{NE}\to0$, $F_3\to0$ and $v\to v_0$. This is what the Lean theorem `zolpidem_pulsatility_loss_collapses_glymphatic` proves (`Model_A8_All_Equations*.lean`). The flow returns to baseline; it does not stop, despite the theorem's name.
4. *A.8's −47% (computed here).* Assume $v_0$ is small compared with the increment and that $F_4$ is unchanged. A 78% fall in $\mathcal A$ then scales the increment by $0.22(x+1)/(0.22x + 1)$, with $x = \mathcal A/K_{NE}$ before the drug. Set this equal to $0.53$ (a 47% fall):
$$
0.22x + 0.22 = 0.1166x + 0.53 \;\Rightarrow\; x = \frac{0.31}{0.1034} = 3.0
$$
   The two A.8 numbers are therefore consistent with $\mathcal A_{NE}\approx3K_{NE}$ before the drug.
5. *Unification with Tiers 2 and 6 (Proposal).*
    - $\mathcal A_{NE} = a_{NE}\rho^\ast = a_{NE}\sqrt{\lambda_{eff}}$ (T2.2). Then zolpidem lowers $\lambda_{eff}$ and $\mathcal A$ goes to 0 continuously at the Hopf point.
    - $AQP4/AQP4_0 = P_{AQP4}/P_{AQP4,basal}$ (T6.19).
    
    Here the polarity enters linearly, whereas T6.2 maps polarity to $L_p$ exponentially. These are two different maps for the same physics.
6. *Pumping physics, a caution.* Classical long-wavelength peristaltic pumping gives a time-mean flow proportional to the square of the amplitude ratio for small amplitudes (Shapiro, Jaffrin & Weinberg 1969). The Michaelis-Menten factor is linear at small $\mathcal A$. T2.16 uses a rectified $\lvert\dot r\rvert$, which is also linear. The sources do not settle the small-amplitude exponent.
7. *Units.* $v_{glymph}$ is a velocity. In T6.14 and T2.13 it is used as a rate, which needs division by a length (T6.14, Step 5).

**Result.** The velocity law is a phenomenological product of gates (Step 1), and it matches A.6-A.8. The Lean theorem is correct but its name is misleading (Step 3). The A.8 zolpidem numbers imply $\mathcal A_{NE}\approx3K_{NE}$ (Step 4). The links to $\rho^\ast$ (T2.2) and $P_{AQP4}$ (T6.19) are not stated in any source. A.9 and A.10 recast glymphatic advection as $J_v$ and $Pe$ (T2.16, T2.17), and no source says whether $v_{glymph}$ is retired.

**Checks.**

- *Dimensions.* Every factor is dimensionless, so $[v] = [v_0] = [v_1]$.
- *Limits.*
    - Wake: $v = v_0$.
    - $AQP4\to0$: $v = v_0$.
    - $\overline{NE}\gg\theta_g$: $v\to v_0$.
    - $\mathcal A\gg K_{NE}$: saturation.
- *Sign of the zolpidem effect.* A.5 Eq. 14 had no $\mathcal A$ factor and gated on instantaneous NE. Zolpidem lowers mean NE, so it predicted a +71% rise. With $\mathcal A$, A.6 gives −47%, in the observed direction.

**Lineage.**

- **A.5 Eq. 14:** $v_{wake} + v_{sleep}\mathbf 1_{SWS}(AQP4/AQP4_0)[1-\sigma(([NE]-\theta_{NE})/s_N)]$.
- **A.6 Eq. 38:** adds $\mathcal A_{NE}$ ("switchable; contested pathway").
- **A.7 annex Eq. 38:** unchanged.
- **A.8:** unchanged. Lean `v_glymph` and the zolpidem theorem.
- **A.9/A.10:** $J_v$ and $Pe$.
- **Aleph lineage table:** "glymphatic peristalsis" (A.10 column: "coupled autonomic brainstem limit cycle to perivascular flux $J_v(t)$").

**Derivation status.** Phenomenological closure. It is possibly superseded by $J_v$/$Pe$ (T2.16, T2.17), and the source does not say.

---

## T6.17: Ontogenetic scaling tensor for structural connectivity (inherited: A.9; Aleph Sec. 2 lineage table, $dW_{ij}/dt_g$)

**Equation as stated in the latest source.** `Model_A9_changes from a8.docx`, Sec. 1, equation image, re-read for the inventory:

$$
\frac{dW_{ij}}{dt_g} = \mathcal{M}_{ij}(t_g)\cdot\nabla\rho(x_i, t_g) + \eta(t_g)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $W_{ij}$ | structural connectivity. It replaces A.8's fixed matrix; its relation to the plastic weight of T6.4 is not stated | as $W$ |
| $t_g$ | gestational or developmental age (DHARANI atlas, 14-24 gestational weeks) | weeks |
| $\mathcal M_{ij}(t_g)$ | "axon-guidance chemotactic gradient tensor". Its dimensions are never stated; here it is a 3-vector per pair (Step 3) | $[W]\,\mathrm m^4\,\mathrm{cells}^{-1}\,[t_g]^{-1}$ |
| $\rho(x_i, t_g)$ | cytoarchitectural cell density at position $x_i$ ($\rho$ is reused elsewhere) | cells m$^{-3}$ |
| $\eta(t_g)$ | developmental noise; additive or multiplicative not stated | $[W]\,[t_g]^{-1}$ |

**Physical starting point.** Growth cones climb gradients of guidance cues (chemotaxis). The standard continuum description is a drift proportional to the gradient (Keller & Segel 1971). The source gives no derivation, only a motivation: A.8's static $N$ and $W_{ij}$ "crashed when exposed to gestational fetal data". The GPT audit (§7.2) asks for the tensor dimensions, the mapping from density to connections, the noise type and non-negativity. Assumptions (all Proposals):

- A1. The guidance cue is secreted by cells and is short-range and quasi-steady, so its concentration is $c_g = k_g\rho$.
- A2. Growth cones move with chemotactic velocity $\mathbf v = \chi\nabla c_g$.
- A3. The connection $j\to i$ grows in proportion to the component of $i$'s guided growth that points towards $j$, with gain $\alpha_{ij}\ge0$ and unit vector $\hat{\mathbf e}_{ij} = (x_j - x_i)/\lvert x_j - x_i\rvert$.
- A4. The noise is Itô white noise, $\eta\,dt_g = \sigma_W(t_g)\,dB_{ij}$.

**Derivation.** All steps below are Reconstructed; the source contains none.

1. *Cue gradient (A1).* $\nabla c_g = k_g\nabla\rho$.
2. *Chemotactic velocity (A2).* $\mathbf v(x) = \chi k_g\nabla\rho(x)$.
3. *Projection onto the pair (A3).* $dW_{ij}/dt_g = \alpha_{ij}\hat{\mathbf e}_{ij}\cdot\mathbf v(x_i) = \alpha_{ij}\chi k_g\,\hat{\mathbf e}_{ij}\cdot\nabla\rho(x_i)$. Define
$$
\mathcal M_{ij}(t_g) = \alpha_{ij}(t_g)\,\chi\,k_g\,\hat{\mathbf e}_{ij}
$$
   Then the deterministic part is $\mathcal M_{ij}\cdot\nabla\rho(x_i,t_g)$, which is the printed form. The "tensor" is an $N\times N\times3$ array: one 3-vector per pair. The contraction is the Euclidean dot product over the spatial index.
4. *Units.* $\nabla\rho$ has units of cells m$^{-4}$. For $\mathcal M\cdot\nabla\rho$ to have units $[W]/[t_g]$, $\mathcal M$ needs the units in the table.
5. *Noise (A4).* $dW_{ij} = \mathcal M_{ij}\cdot\nabla\rho\,dt_g + \sigma_W\,dB_{ij}$. Integrating gives mean $W_{ij}(t_{g0}) + \int\mathcal M_{ij}\cdot\nabla\rho\,ds$ and variance $\int\sigma_W^2ds$.
6. *Non-negativity fails.* Additive noise gives a Gaussian increment, so $P(W_{ij}<0)>0$ for any $W_{ij}$ close to 0. Proposals: a reflected SDE at $W = 0$ (Skorokhod reflection), or a projection $W\leftarrow\max(W,0)$. Multiplicative noise $\sigma_W\sqrt W\,dB$ does not help on its own, because the drift can be negative: Feller's condition then fails and 0 is reached.
7. *No saturation.* The right side does not depend on $W_{ij}$. Under a persistent gradient, $W_{ij}$ grows without bound and connectivity never settles. A growth limit such as $(w_{max} - W_{ij})$, or competition for target space, is needed (Proposal).

**Result.** The printed form follows from a chemotactic drift projected onto each pair (Steps 1-3; Reconstructed). It is then a definition of $\mathcal M_{ij}$, not a consequence of developmental biology. The source leaves out:

- the dimensions of $\mathcal M$ (supplied in Steps 3-4);
- the type of noise (Step 5);
- non-negativity (Step 6);
- saturation (Step 7);
- how cell-density data become connection probabilities;
- the relation of this structural $W_{ij}$ to the plastic $W_{ij}$ of T6.4.

**Checks.**

- *Dimensions.* Step 4.
- *Limits.*
    - $\nabla\rho = 0$ (uniform density): pure diffusion of $W$.
    - $\sigma_W = 0$: deterministic growth.
    - Growth is positive when the density rises towards $j$ ($\hat{\mathbf e}_{ij}\cdot\nabla\rho>0$).

**Lineage.**

- **Model A and A.3:** species vector $\Theta_s$, static per species.
- **A.8:** static $N$ and $W_{ij}$.
- **A.9:** this equation, evaluated against the DHARANI fetal atlas.
- **Aleph lineage table, A.9 column:** "Ontogenetic Scaling Tensor ($dW_{ij}/dt_g$)".
- **A.10:** couples $t_g$ to the AIS baseline $L_0(t_g)$ (T4.2).
- **GPT audit, §7.2:** text only.

**Derivation status.** Phenomenological closure, and incomplete in source. The tensor dimensions, contraction, noise model and bounds are unstated; the reconstruction above supplies them as proposals.

---

## T6.18: Hypoxia-driven angiogenesis (inherited: A.9, ontogenetic scaling)

**Equation as stated in the latest source.** `Model_A9_changes from a8.docx`, Sec. 1, equation image:

$$
\frac{d\mathcal{E}}{dt_g} = \kappa_{angio}\sum_c\left(1 - \frac{o_c}{o_{target}}\right)_+
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\mathcal E$ | number of vascular edges in the T2.1 graph | count |
| $\kappa_{angio}$ | sprouting rate per node at full hypoxia | $[t_g]^{-1}$ |
| $o_c$ | O$_2$ at node $c$ (T3.1) | mM |
| $o_{target}$ | target O$_2$ | mM |
| $(\cdot)_+$ | positive part | |

**Physical starting point.** Hypoxia stabilizes HIF-1α, which induces VEGF; VEGF drives endothelial sprouting (Shweiki et al. 1992). The source says only "driven by localized hypoxic demand". Assumptions (Reconstructed):

- A1. The VEGF signal at node $c$ is proportional to the relative O$_2$ deficit below target, and zero above it. This is the first-order expansion of a decreasing response about $o_{target}$, rectified.
- A2. Sprouts arise at node $c$ as an inhomogeneous Poisson process whose intensity is proportional to the VEGF signal: $\lambda_c(t) = \kappa_{angio}(1 - o_c/o_{target})_+$.
- A3. $\mathcal E$ is the expected edge count.

**Derivation.**

1. *Intensity (A1, A2).* $\lambda_c = \kappa_{angio}(1 - o_c/o_{target})_+\ge0$.
2. *Counting processes.* Let $N_c(t)$ count the sprouts from node $c$. For a counting process with intensity $\lambda_c$, the difference $N_c(t) - \int_0^t\lambda_c\,ds$ is a martingale. Taking expectations, $\mathbb E[N_c(t)] = \mathbb E\int_0^t\lambda_c\,ds$.
3. *Total edges.* $\mathcal E(t) = \mathcal E(0) + \sum_cN_c(t)$. Differentiate the expectation:
$$
\frac{d\,\mathbb E[\mathcal E]}{dt_g} = \sum_c\mathbb E[\lambda_c] = \kappa_{angio}\sum_c\mathbb E\left[\left(1 - \frac{o_c}{o_{target}}\right)_+\right]
$$
   With deterministic $o_c$ (A3) this is the printed form.
4. *Self-limitation.* New edges raise flow (T2.1, T2.15) and delivery (T3.6), so $o_c$ rises towards $o_{target}$ and $\lambda_c\to0$. Growth stops on the set $\lbrace o_c\ge o_{target}\ \forall c\rbrace$.
5. *Attachment rule (Proposal; missing in source).* Connect each new sprout from hypoxic node $c$ to the nearest perfused node within a maximum length $\ell_{max}$, with initial radius $r_{min}$ and conductance from T2.7. Then rebuild the Laplacian of T2.1.

**Result.** The printed form is the mean of a hypoxia-driven Poisson sprouting process (Steps 1-3), under the stated linear-response assumption. Missing from the source:

- the attachment rule (Step 5);
- vessel regression: with no loss term, $\mathcal E$ can only grow, although developmental vascular networks also prune.

The equation is not restated in A.10 or in Aleph.

**Checks.**

- *Dimensions.* $[\kappa_{angio}]$ = per unit $t_g$ per node; the bracket is dimensionless; $\mathcal E$ is a count.
- *Limits.*
    - $o_c\ge o_{target}$ everywhere: no growth.
    - $o_c = 0$: maximal rate $\kappa_{angio}$ per node.
- *Monotonicity.* $d\mathcal E/dt_g\ge0$.

**Lineage.** New in A.9 (equation image re-read for the inventory). It is not restated in A.10 or Aleph. Aleph names only the ontogenetic tensor.

**Derivation status.** Phenomenological closure. It is a linear-response Poisson sprouting model, and the attachment and regression rules are missing.

---

## T6.19: AQP4 polarity degradation (pathological degradation tensor) (inherited: A.9; Aleph Sec. 2 lineage table, $P_{AQP4}\to0$)

**Equation as stated in the latest source.** `Model_A9_changes from a8.docx`, Sec. 4, equation image:

$$
\tau_{path}\frac{dP_{AQP4}}{dt} = -k_{toxic}\cdot\mathcal{H}\left([Ca^{2+}]_e - Ca_{thresh}\right)\cdot\mathcal{F}_{inflam} + k_{recover}\left(1 - P_{AQP4}\right), \qquad P_{AQP4} \in [0,1]
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $P_{AQP4}$ | AQP4 polarity index. Basal values (Table 3): human 0.94, macaque 0.92, rat 0.88, mouse 0.86, pigeon 0.72, zebrafish 0.45, fly 0 (absent) | dimensionless |
| $\tau_{path}$ | time constant | time |
| $k_{toxic}$, $k_{recover}$ | loss and recovery coefficients (dimensionless, because $\tau_{path}$ carries the time) | dimensionless |
| $\mathcal H$ | Heaviside step | |
| $[Ca^{2+}]_e$, $Ca_{thresh}$ | extracellular Ca$^{2+}$ (T5.3) and threshold | mM |
| $\mathcal F_{inflam}$ | neuroinflammation level | dimensionless |

**Physical starting point.** In neuroinflammation and protein-aggregate disease, AQP4 redistributes away from the perivascular endfoot. A.9 describes the index as "a leaky integrator driven by toxic solute accumulation (e.g. $C_{tau}$) and neuroinflammation". Assumptions as printed:

- A1. The loss rate does not depend on $P$ (zeroth order).
- A2. Recovery is first order towards full polarity.
- A3. The drive is $D(t) = \mathcal H(\cdot)\,\mathcal F_{inflam}$.

**Derivation.**

1. *Standard form.* Divide by $\tau_{path}$: $\dot P = \left[-k_{toxic}D + k_{recover}(1-P)\right]/\tau_{path}$.
2. *Constant drive.* The equation is linear in $P$. Its steady state and solution are
$$
P^\ast = 1 - \frac{k_{toxic}}{k_{recover}}D, \qquad P(t) = P^\ast + \left(P(0) - P^\ast\right)e^{-k_{recover}t/\tau_{path}}
$$
3. *Invariance test.*
    - At $P=1$: $\dot P = -k_{toxic}D/\tau_{path}\le0$, so the upper face holds.
    - At $P=0$: $\dot P = (k_{recover} - k_{toxic}D)/\tau_{path}$, which is negative when $k_{toxic}D>k_{recover}$. Then $P$ leaves $[0,1]$ and settles at $P^\ast<0$.
    
    $P^\ast$ is unbounded below as $\mathcal F_{inflam}$ grows. The printed "$P_{AQP4}\in[0,1]$" is a constraint with no mechanism behind it, and it is the root cause of the stiffness that T6.2's floor was added to cure.
4. *Repaired form (Proposal).* Make the loss first order in the polarized fraction, since only polarized AQP4 can be lost:
$$
\tau_{path}\frac{dP_{AQP4}}{dt} = -k_{toxic}D\,P_{AQP4} + k_{recover}\left(1 - P_{AQP4}\right)
$$
   At $P=0$, $\dot P = k_{recover}/\tau_{path}>0$; at $P=1$, $\dot P = -k_{toxic}D/\tau_{path}\le0$. So $[0,1]$ is invariant. The steady state $P^\ast = k_{recover}/(k_{recover} + k_{toxic}D)$ lies in $(0,1]$, and the relaxation rate is $(k_{recover} + k_{toxic}D)/\tau_{path}$.
5. *Smooth step.* The Heaviside makes the right side discontinuous at threshold, so Filippov solutions would be needed. A smooth replacement is $\mathcal H_\epsilon(z) = \sigma(z/\epsilon)$ (Proposal).
6. *The driver.* The A.9 text names toxic solutes ($C_{tau}$), but the equation uses $[Ca^{2+}]_e$. In T5.3, $[Ca^{2+}]_e$ only falls below its rest value of 1.2 mM. As printed, $\mathcal H([Ca^{2+}]_e - Ca_{thresh})$ therefore has only two possibilities:
    - $Ca_{thresh}<1.2$ mM: it is 1 at rest, and the toxic drive is on in health;
    - $Ca_{thresh}\ge1.2$ mM: it is never 1.
    
    In neither case does it track pathology. Consistent repairs: $\mathcal H(C_{tau} - C_{thresh})$, as the text says, or a depletion trigger $\mathcal H(Ca_{thresh} - [Ca^{2+}]_e)$, active during seizures or spreading depolarization.
7. *Basal values.* With no drive, both forms give $P^\ast = 1$. The basal values below 1 in Table 3 therefore need a tonic drive $D_b$. Computed here:

| Species | basal $P$ | printed: $k_{toxic}D_b/k_{recover} = 1-P$ | repaired: $k_{toxic}D_b/k_{recover} = 1/P - 1$ |
|---|---|---|---|
| human | 0.94 | 0.06 | 0.064 |
| macaque | 0.92 | 0.08 | 0.087 |
| rat | 0.88 | 0.12 | 0.136 |
| mouse | 0.86 | 0.14 | 0.163 |
| pigeon | 0.72 | 0.28 | 0.389 |
| zebrafish | 0.45 | 0.55 | 1.22 |

   The fly's 0 means absent AQP4, not an equilibrium: under the repaired form it would need infinite drive. The fly branch should drop the equation (A.8 model; Aleph Table 2).
8. *Test #57 (mouse 3xTg-AD, 0.86 → 0.41).* The printed form needs a $0.59/0.14 = 4.2$-fold rise in drive. The repaired form needs $1.439/0.163 = 8.8$-fold (computed here).

**Result.** The printed equation is a phenomenological leaky integrator (Steps 1-2). The source falls short in three places:

- **Invariance.** $[0,1]$ is not invariant (Step 3). Making the loss first order in $P$ fixes this (Step 4).
- **Driver.** The Ca$^{2+}$ driver contradicts the text and cannot encode pathology given T5.3 (Step 6).
- **Basal values.** Basal $P<1$ needs a tonic drive that the source does not mention (Step 7).

The "apoptotic eviction protocol" that A.9 introduces alongside it has no equation.

**Checks.**

- *Dimensions.* Each term on the right is dimensionless when $\tau_{path}$ carries time.
- *Limits.*
    - $D = 0$: $P\to1$ with rate $k_{recover}/\tau_{path}$.
    - $k_{recover} = 0$: $P$ falls linearly (printed) or exponentially (repaired).
- *Data.* Aleph test #57: model 0.44 against observed 0.41.

**Lineage.**

- **A.5 Eq. 14:** a static factor $AQP4/AQP4_0$ in $v_{glymph}$.
- **A.9** (`Model_A9_changes from a8.docx`, equation image re-read for the inventory): this dynamics.
- **Aleph lineage table:** "AQP4 Polarity Degradation ($P_{AQP4}\to0$)" in the A.9 column. The basal values are in Table 3.

**Derivation status.** Phenomenological closure, and incomplete in source: invariance, the driver and basal calibration are all missing. A repaired, invariant form is supplied as a proposal.

---

## T6.20: TrkB neurotrophic phosphorylation (inherited: A.10 Eq. 6.1; Aleph: delayed TrkB-BDNF synaptogenesis)

**Equation as stated in the latest source.** A.10 Eq. 6.1 (`Model_A10_Comprehensive_Scientific_Report.docx`):

$$
\tau_{TrkB}\frac{d[TrkB^*]}{dt} = -[TrkB^*] + k_{BDNF}\left([5\text{-}HT]_{syn} - 5HT_{basal}\right)_+\cdot a_i
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[TrkB^*]$ | phosphorylated (active) TrkB | concentration or fraction |
| $\tau_{TrkB}$ | deactivation time constant | time |
| $k_{BDNF}$ | coupling. It is silenced to $k_{BDNF,eff}$ by T6.1 (implied) | $[TrkB^*]$ nM$^{-1}$ mM$^{-1}$ |
| $[5\text{-}HT]_{syn}$ | synaptic serotonin, the $[M]_{syn}$ of T1.5 | nM |
| $5HT_{basal}$ | baseline serotonin | nM |
| $a_i$ | ATP | mM |

**Physical starting point.** Sustained serotonergic signalling raises BDNF expression and release through 5-HT receptor, cAMP and CREB pathways. BDNF binds TrkB, which autophosphorylates; this is a receptor tyrosine kinase reaction that consumes ATP. Phosphatases reverse it. Antidepressant action through TrkB is reviewed by Castrén and colleagues, and Casarotto et al. (2021) report direct antidepressant binding to TrkB. Assumptions:

- A1. TrkB phosphorylation follows mass action in BDNF ($B$).
- A2. Low occupancy: $[TrkB^*]\ll T_{tot}$.
- A3. $B$ is quasi-steady and threshold-linear in the serotonergic excess. This is a modelling choice.
- A4. The kinase rate is linear in ATP (the unsaturated limit).
- A5. Dephosphorylation is first order, with rate $k_{dp}$.

**Derivation.**

1. *Mass action (A1, A4, A5).*
$$
\frac{dT^\ast}{dt} = k_pB\,a\,(T_{tot} - T^\ast) - k_{dp}T^\ast
$$
2. *Low occupancy (A2).* $T_{tot} - T^\ast\approx T_{tot}$.
3. *BDNF drive (A3).* $B = b_1(S - S_b)_+$, with $S = [5\text{-}HT]_{syn}$ and $S_b = 5HT_{basal}$.
4. *Divide by $k_{dp}$.*
$$
\frac{1}{k_{dp}}\frac{dT^\ast}{dt} = \frac{k_pb_1T_{tot}}{k_{dp}}(S - S_b)_+a - T^\ast
$$
   With $\tau_{TrkB} = 1/k_{dp}$ and $k_{BDNF} = k_pb_1T_{tot}/k_{dp}$, this is the printed form.
5. *ATP factor.* Protein kinases generally have a Michaelis constant for ATP well below millimolar cellular ATP. A4's linear factor therefore overstates the ATP sensitivity at rest; it applies only under severe ATP depletion. A saturating factor $a/(a+K_{ATP})$ would be consistent with kinase kinetics. No source gives $K_{ATP}$.
6. *Linear-filter solution.* Write $X(t) = (S(t) - S_b)_+$:
$$
T^\ast(t) = T^\ast(0)e^{-t/\tau_{TrkB}} + \frac{1}{\tau_{TrkB}}\int_0^te^{-(t-s)/\tau_{TrkB}}\,k_{BDNF}X(s)a(s)\,ds
$$
7. *Step response.* For a constant drive switched on at $t = 0$ from $T^\ast(0) = 0$: $T^\ast = T^\ast_\infty\left(1 - e^{-t/\tau_{TrkB}}\right)$ with $T^\ast_\infty = k_{BDNF}Xa$. Half of the rise takes $\tau_{TrkB}\ln2$.
8. *Delay of the cascade.* A first-order filter has transfer function $H(s) = 1/(1+\tau s)$, and its mean delay is $-H'(0)/H(0) = \tau$. For cascaded filters the transfer functions multiply, so $-\frac{d}{ds}\ln\prod_k(1+\tau_ks)^{-1}\big\rvert_{s=0} = \sum_k\tau_k$: mean delays add. T6.20 followed by T6.21 lags by $\tau_{TrkB}$ plus the set-point time constant. These lags are smooth. They do not produce the threshold-like 14-21 day SSRI latency, which A.10 attributes to a saddle-node on the 5-HT1A autoreceptor slow manifold (out of scope here).
9. *Epigenetic silencing (T6.1).* Invariant 7 ($\Xi_{BDNF}$, Aleph Sec. 9.1) puts $k_{BDNF}/(1+\exp(\gamma_{silence}(H_{HDAC}-\theta)))$ in the TrkB numerator. The consistent form is therefore
$$
\tau_{TrkB}\frac{d[TrkB^*]}{dt} = -[TrkB^*] + k_{BDNF,eff}(H_{HDAC})\left([5\text{-}HT]_{syn} - 5HT_{basal}\right)_+a_i
$$
   This substitution is stated here explicitly; no source states it.
10. *Baseline.* At $[5\text{-}HT]_{syn} = 5HT_{basal}$ the drive is zero and $T^\ast\to0$. Through T6.21 the set point then decays to zero at baseline serotonin (T6.21, Step 6). Proposal: either add a constitutive term $T_0$, or read $5HT_{basal}$ as a level below the normal operating point.

**Result.** The printed form follows from A1-A5 (Steps 1-4; Reconstructed), and it matches A.10 Eq. 6.1. It is phenomenological in its serotonin-to-BDNF link (A3) and in its linear ATP factor (Step 5). Three gaps: the silencing substitution is implied but unstated (Step 9); there is no TrkB activity at baseline (Step 10); and "delayed" refers only to a first-order lag (Step 8).

**Checks.**

- *Dimensions.* $[k_{BDNF}] = [T^\ast]/(\mathrm{nM}\cdot\mathrm{mM})$.
- *Positivity.* The drive is $\ge0$, so $T^\ast\ge0$ is invariant.
- *Limits.*
    - $\tau_{TrkB}\to0$: $T^\ast = k_{BDNF}Xa$ instantaneously.
    - $a_i\to0$: no activation.
    - $X = 0$: decay with time constant $\tau_{TrkB}$.

**Lineage.**

- **A.10 Eq. 6.1** (`Model_A10_Comprehensive_Scientific_Report.docx`): new.
- **A.10 Sec. 4:** builds the SSRI slow-fast system on Eqs. 1.7, 6.1 and 6.2.
- **Aleph lineage table:** "delayed TrkB-BDNF synaptogenesis" (A.10 column). Aleph Eq. 5.10 defines $k_{BDNF,eff}$; Invariant 7 combines them.

**Derivation status.** Phenomenological closure. The mass-action skeleton is standard (Steps 1-4). The serotonin-to-BDNF link, the ATP factor and the baseline behaviour are modelling choices.

---

## T6.21: Structural synaptic set-point remodeling (inherited: A.10 Eq. 6.2)

**Equation as stated in the latest source.** A.10 Eq. 6.2 (`Model_A10_Comprehensive_Scientific_Report.docx`):

$$
\frac{dS_{set}}{dt} = \kappa_{BDNF}[TrkB^*] - \gamma_{prune}\left(1 - \Theta_{circ}(t)\right)S_{set}
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $S_{set}$ | synaptic set point (the relaxation target in T6.11) | synapses |
| $\kappa_{BDNF}$ | synaptogenic gain | synapses $[TrkB^*]^{-1}$ time$^{-1}$ |
| $[TrkB^*]$ | active TrkB (T6.20) | as T6.20 |
| $\gamma_{prune}$ | pruning rate | time$^{-1}$ |
| $\Theta_{circ}$ | circadian switch (T6.13) | dimensionless |

**Physical starting point.** A production-loss balance for structural synapses: synaptogenesis driven by TrkB signalling, and first-order elimination. A.10 says the SSRI-induced serotonin surge "drives TrkB phosphorylation and structural spine addition ($dS_{set}/dt>0$)". Assumptions:

- A1. The production rate is linear in $[TrkB^*]$.
- A2. Pruning is first order in $S_{set}$.
- A3. Pruning is gated by $1-\Theta_{circ}$, as printed.

**Derivation.**

1. *Balance (A1-A3).* Production minus loss gives the printed equation.
2. *Integrating factor.* Let $g(t) = \gamma_{prune}(1-\Theta_{circ}(t))$ and $G(t) = \int_0^tg$. Then
$$
S_{set}(t) = S_{set}(0)e^{-G(t)} + \int_0^t\kappa_{BDNF}T^\ast(s)\,e^{-(G(t)-G(s))}\,ds
$$
3. *Frozen-coefficient steady state.* $S^\ast = \kappa_{BDNF}T^\ast/(\gamma_{prune}(1-\Theta_{circ}))$. This diverges where $\Theta_{circ}\to1$, so the instantaneous value is not meaningful. Use the cycle average.
4. *Averaging.* Take $\Theta_{circ}$ periodic with period $T = 24$ h (the periodic form of T6.13, Step 4), and suppose $\gamma_{prune}T\ll1$ with $T^\ast$ slowly varying. First-order averaging (error $O(\gamma_{prune}T)$) gives
$$
\frac{d\bar S}{dt} = \kappa_{BDNF}\langle T^\ast\rangle - \gamma_{prune}\langle1-\Theta_{circ}\rangle\bar S, \qquad \bar S^\ast = \frac{\kappa_{BDNF}\langle T^\ast\rangle}{\gamma_{prune}\langle1-\Theta_{circ}\rangle}
$$
5. *Exact periodic orbit (constant $T^\ast$).* From Step 2 over one period, $S((n+1)T) = S(nT)e^{-G(T)} + \kappa_{BDNF}T^\ast I$, with $I = \int_0^Te^{-(G(T)-G(s))}ds$. The fixed point of this map is
$$
S_p = \frac{\kappa_{BDNF}T^\ast I}{1 - e^{-G(T)}}
$$
   Its multiplier is $e^{-G(T)}<1$, so it is globally attracting. For small $G(T) = \gamma_{prune}\langle1-\Theta\rangle T$, $I\approx T$ and $1 - e^{-G(T)}\approx G(T)$, which recovers Step 4.
6. *Collapse at baseline.* At basal serotonin $T^\ast\to0$ (T6.20, Step 10), and $S_{set}\to0$ at the rate $\gamma_{prune}\langle1-\Theta\rangle$. A healthy, stationary set point needs TrkB activity at baseline. Proposal: relax towards a baseline, $\dot S_{set} = \kappa_{BDNF}T^\ast - \gamma_{prune}(1-\Theta_{circ})(S_{set} - S_{set,0})$. This gives $\bar S^\ast = S_{set,0} + \kappa_{BDNF}\langle T^\ast\rangle/(\gamma_{prune}\langle1-\Theta\rangle)$.
7. *Circadian sign.* A.8 uses $\Theta_{circ}$ as the permissive factor for sleep pruning (T6.11, T6.13). A.10 uses $1-\Theta_{circ}$, so set-point pruning is active when A.8's pruning is arrested (T6.13, Step 7). With A.10's sign, the set point is pruned by day while $S_i$ is pruned by night. No source says whether this is intended.
8. *Invariant 7.* Combine Step 4 with T6.20 (Step 9) at unit serotonergic excess, $\langle1-\Theta\rangle\to1$, and constant $H$ and $a_i$:
$$
\frac{\bar S^\ast}{S_{set,0}} = \frac{\kappa_{BDNF}k_{BDNF}a_i}{\gamma_{prune}\left(1 + \exp(\gamma_{silence}(H_{HDAC}-\theta))\right)S_{set,0}} = \Xi_{BDNF}
$$
   $\Xi_{BDNF}$ is therefore the steady set point per unit serotonergic excess, relative to baseline. As printed it lacks the factor $([5\text{-}HT]_{syn} - 5HT_{basal})_+$ (nM), so it is not dimensionless. It also omits $\langle1-\Theta_{circ}\rangle$.
9. *No hysteresis in the cascade.* For constant inputs (and frozen $\Theta$), three equations form a feed-forward chain $H\to k_{BDNF,eff}\to T^\ast\to S_{set}$:
    - T6.1 is linear in $H$, with decay rate $\lambda_H>0$ and an input that does not depend on downstream states;
    - T6.20 is linear in $T^\ast$, with rate $1/\tau_{TrkB}$ and an input that depends only on $H$;
    - T6.21 is linear in $S_{set}$, with rate $g>0$ and an input that depends only on $T^\ast$.
    
    The Jacobian is lower triangular, with diagonal $(-\lambda_H, -1/\tau_{TrkB}, -g)$, all negative. By induction down the chain, each variable converges to a unique limit. There is one globally attracting equilibrium (or periodic orbit, by Step 5) and no bistability. The claim of a "low-spine attractor" that requires agents "to overcome the epigenetic hysteresis barrier" (Aleph Sec. 9.1, Invariant 7) does not follow from Eqs. 5.10, 6.1 and 6.2. They predict slow recovery, governed by the slow decay $\lambda_H$ of T6.1 (T6.1, Step 9), not hysteresis. Hysteresis would need feedback, for example from $S_{set}$ to stress or from $H$ to its own production. GPT §9.7 reaches the same conclusion.
10. *Test #66 as a constraint (computed here).* With serotonergic drive, ATP and $\Theta$ unchanged, Step 4 and T6.1 give a deficit $1 - \bar S^\ast_{dep}/\bar S^\ast_{ctrl} = 1 - p_O(H_{dep})/p_O(H_{ctrl})$. The reported −42.8% needs $p_O(H_{dep})/p_O(H_{ctrl}) = 0.572$. No source gives the $H$ values.

**Result.** The printed equation is a phenomenological production-loss balance, and the solution, the averaging and the periodic orbit are exact (Steps 2-5). It matches A.10 Eq. 6.2. The problems are:

- (i) the set point collapses at baseline serotonin (Step 6; repair proposed);
- (ii) its circadian sign is opposite to A.8's sleep-pruning gate (Step 7);
- (iii) Invariant 7 is this steady state with a missing dimensional factor (Step 8);
- (iv) the T6.1-T6.20-T6.21 cascade cannot produce the hysteresis Aleph attributes to it (Step 9).

**Checks.**

- *Dimensions.* $[\kappa_{BDNF}T^\ast]$ = synapses/time = $[\gamma_{prune}S_{set}]$.
- *Positivity.* At $S_{set}=0$, $\dot S_{set} = \kappa_{BDNF}T^\ast\ge0$.
- *Limits.*
    - $\Theta_{circ}\equiv1$: no pruning, so $S_{set}$ grows linearly.
    - $T^\ast = 0$: exponential decay.
- *Stability.* The periodic orbit has Floquet multiplier $e^{-G(T)}<1$.

**Lineage.**

- **A.3-A.8:** $S_{set}$ constant (A.3 continuous gate; A.8 Eq. (19)).
- **A.10 Eq. 6.2:** this dynamics.
- **Aleph:** "synaptic set-point remodeling" inherited; Invariant 7 builds on it.

**Derivation status.** Phenomenological closure. The solution properties are exact. The baseline collapse and the circadian sign are unresolved in the source.

---

## Summary of Tier 6 status

| Key | Equation | Status | Main issues found |
|---|---|---|---|
| T6.1 | HDAC operator and BDNF silencing (Eq. 5.10) | Phenomenological closure (incomplete in source) | $\tau_{epig}$ must be dimensionless given Table 3 units; $H$ and $F$ undefined; link to T6.20 implied (Invariant 7) but not stated; stress counted twice via $[CORT]$ and $F$; linear and monotone, so no hysteresis; onset set by $k_{stress}$, recovery by $k_{acetyl}a_i/\tau_{epig}$ |
| T6.2 | Hydraulic floor (Eq. 5.11) | Phenomenological closure (bounds exact) | exponential map is constitutive (channel counting gives a linear map); $L_p\to R_{PVS}$ relation missing (series form proposed); floor treats the non-invariance of T6.19; $\lambda$ reused |
| T6.3 | GR stress rate (Eq. 4.1) | Derived under approximations | Hill $n_H$ empirical; minimal dimerization model gives 1.2-1.3 at half-max, not 1.8; $k_{stress}$ as import rate is an identification; Table 3 not reproducible (needs $[CORT]$, $k_{transloc}$) |
| T6.4 | Three-factor weight rule | Phenomenological closure (barrier exact) | box $[0,w_{max}]$ invariant; barrier exact for a uniform brake and weight-based $h_Q$; A.5 placement over-evicts; non-uniform brake can break the barrier; $b_m$, $f^\pm$ never defined |
| T6.5 | Headroom | Exact (definition); invariance incomplete in source | A.8 demand-based $h_Q$ = weight-based with time-varying cap; $h_Q\ge0$ not guaranteed when non-weight demand rises; "$s_Q\to0$ as $h_Q\to0$" false; $D_{cap}$ undefined |
| T6.6 | Supply gate and eviction | Exact (barrier construction) | largest admissible gate; Lipschitz forms $\min\lbrace\Pi,N\rbrace$ and $(\Pi-N)_+$ make Filippov unnecessary; needs $\sum\omega>0$; not restated after A.5; mismatched with A.8 $h_Q$ |
| T6.7 | Tag and persistence | Phenomenological closure | $[0,1]$ invariant; $P=\max(\Omega,c)$ is non-smooth (smooth OR form proposed) |
| T6.8 | Capture SDE | Phenomenological closure (invariance exact) | drift at $c=0$ is $\Omega\pi\ge0$, not 0 (prose error; Lean lemmas right); invariance proved by logit transform plus Khasminskii; bistability iff $\beta_c/\gamma_c>2K_c^2+2K_c\sqrt{K_c^2+1}$; noise form chosen for invariance |
| T6.9 | Capture energy gate | Phenomenological closure | Hill-4; normalization of $a_i$ unstated since A.6; gating variable moved from $e_Q$ to $a_i$ |
| T6.10 | Kramers power-law forgetting | Derived under approximations | averaging integral exact; multiplicative-noise Kramers needs quasi-potential $\Delta\Phi$; exponent is $\sigma_c^2/(2\tau_c\mu_\Phi)$, not $\sigma_c^2/\mu$; exponential barrier distribution assumed (fold gives $\Delta U\propto\epsilon^{3/2}$) |
| T6.11 | Wake and sleep downscaling | Exact (closed form); model phenomenological | zebrafish fit reproduced (0.0693/h; 11.72; 5.16); dynamic $S_{set}$ needs variation of constants; no $S_i\leftrightarrow W_{ij}$ link; $A_r$ undefined; A.7 ROS gate vs A.8 Ado/NE gate |
| T6.12 | Ado/NE product gate | Phenomenological closure | linear-concentration logistic approximates a Hill switch ($s_A=\theta_A/n$) with a floor; $NE$ should be $\overline{NE}$ |
| T6.13 | Circadian switch | Phenomenological closure (incomplete in source) | not periodic (single-night only); "$t_{dawn}$" must be the arrest time for the "final 2 h" claim; +45% needs $\zeta\ge0.9$; sign conflict with A.10 |
| T6.14 | Adenosine balance | Phenomenological closure (incomplete in source) | $v_{glymph}$ is a velocity used as a rate (needs $/\ell_Q$ or $\bar J_v/V_Q$); $\Pi_Q$ clash (pump flux); not restated after A.7 |
| T6.15 | REM jump and projection | Exact (projection); map phenomenological | $\lambda_Q$ is the largest feasible scalar and lands $h_Q$ on 0; A.2 Lipschitz bound valid only for $w_p/s_w\ge0.626$ (universal bound given); demand-based $h_Q$ caveat |
| T6.16 | Glymphatic velocity | Phenomenological closure | Lean proves $v=v_0$ (baseline), not cessation; A.8 −47% implies $\mathcal A_{NE}\approx3K_{NE}$; links to $\rho^\ast$ and $P_{AQP4}$ unstated; possibly superseded by $J_v$/$Pe$ |
| T6.17 | Ontogenetic tensor | Phenomenological closure; incomplete in source | tensor dimensions, contraction, noise, non-negativity and saturation unstated (supplied as proposals) |
| T6.18 | Angiogenesis | Phenomenological closure | mean of a Poisson sprouting process; attachment rule and vessel regression missing |
| T6.19 | AQP4 polarity | Phenomenological closure; incomplete in source | $[0,1]$ not invariant (repair: loss $\propto P$); Ca$^{2+}_e$ driver cannot encode pathology given T5.3; basal $P<1$ needs tonic drive |
| T6.20 | TrkB phosphorylation | Phenomenological closure | silencing substitution $k_{BDNF}\to k_{BDNF,eff}$ implied only; zero activity at baseline; linear ATP factor; "delay" is a first-order lag |
| T6.21 | Set-point remodeling | Phenomenological closure | collapses to 0 at baseline serotonin; $1-\Theta$ sign conflicts with A.8; Invariant 7 = averaged steady state (missing a dimensional factor); cascade has no hysteresis |
