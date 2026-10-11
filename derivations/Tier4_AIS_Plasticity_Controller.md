# Tier 4: Axon initial segment tri-variable leaky controller

## Overview

Tier 4 gives every neuron (or rate node) $i$ three slow structural states for its axon initial segment (AIS):

- the AIS length $L_i$;
- the distance $x_i$ from the soma to the AIS midpoint;
- the AIS Na$^+$-channel conductance density $g_{AIS,i}$.

These states are driven by a slow Ca$^{2+}$/activity proxy $\bar c_i$ (T4.1) through three leaky first-order controllers (T4.2-T4.4). The threshold law (T4.5) turns the states into a voltage-threshold shift $\theta_{AIS,i}$, which enters the firing-rate law (T1.20).

Aleph 1 prints no Tier 4 equation. Its lineage table names the "Tri-variable leaky AIS controller (L, x, gAIS)" in the A.8 column, and the A.10 column says the model "maintains unique homeostatic fixed points" (Model_Aleph_1_only equations.docx; Model_Aleph_1_Comprehensive_Scientific_Report.docx). The canonical forms below therefore come from:

- A.8: Eqs. (13)-(15) of Model_A8_Scientific_Report.pdf, which are the same as the Tier 4 block in Model_A8_model only.docx;
- A.10: Eq. 4.1 of Model_A10_Comprehensive_Scientific_Report.docx.

A.10's "Eq. 4.1" (the AIS law) is a different equation from Aleph 1's Eq. 4.1, which is the glucocorticoid integration rate $k_{stress}$ (T6.3).

**Couplings to other tiers.**

- **From Tier 1.** The fast proxy $c_i(t)$ has to be computed from the rate $r_i$ (T1.20) or from the somatic voltage $v_i$ (T1.1). No source says which (see T4.1).
- **To Tier 1.** $\theta_{AIS,i}$ is subtracted inside the rate law (T1.20), alongside:
  - the fast homeostatic threshold $\theta_i$ (T1.21);
  - adaptation $w_i$ (T1.8);
  - the baseline threshold $\theta_0$.
- **With T1.21.** The integral threshold homeostat and the AIS controllers correct the same rate error. Their joint equilibrium is unique only because the AIS controllers are leaky. This is derived in the closed-loop section at the end of this file.
- **From Tier 3 (indirectly).** If $c_i$ is normalized by the energy-scaled set point $\rho_i\chi(a_i/a_0)$ (Proposal P1 in T4.1), ATP enters Tier 4 through $\chi$.
- **From Tier 6.** A.10 makes the baseline length depend on developmental age $t_g$, which is the clock of the ontogenetic tensor (T6.17).

**Symbol clashes to carry through.**

| Symbol | Tier 4 meaning | Other meanings |
|---|---|---|
| $\tau_c$, $c$ | AIS proxy time constant and proxy | capture time constant and capture variable $c_{ij}$ (T6.8) |
| $x_i$ | AIS midpoint distance | presynaptic resource $x_{ij}$ (T1.9); compartment positions $x_{d,i}$, $x_{s,i}$ (T1.7); spatial position in T6.17 |
| $L_i$ | AIS length | lactate pool $L$ (T3.1) |
| $G_L$ | AIS length gain | leak conductance $g_L$ (Tier 1) |

The $L_i$ clash is concrete: the original Lean file (Model_A8_All_Equations.lean) declares `dL_dt` twice in the same namespace, once for lactate (line 196) and once for the AIS (line 244). The patched file renames them `dL_lactate_dt` and `dL_ais_dt`.

**Conventions.**

- Time is in hours, lengths in µm, voltages in mV.
- A positive $\theta_{AIS}$ means a higher threshold and a less excitable cell, because T1.20 subtracts it.
- "Homeostatic" means that a rise in $\bar c$ raises $\theta_{AIS}$, which is negative feedback.
- "Reconstructed" marks a derivation step that no source contains. Such steps are built from standard physics or biochemistry, and the reference is named.
- "Proposal" marks a form that no source states.
- "Computed here" marks a number obtained in this work by evaluating the source equations with source parameter values. These numbers are not source claims.

**Parameter values stated in the sources.**

| Parameter | Value | Source and status |
|---|---|---|
| $L_0$ | 22 µm | A.6 parameter table, from Jamann 2021 (L2/3) |
| $x_0$ | 25 µm | A.6 |
| $\tau_L$, $G_L$ | 5.7 h, 0.33 | A.6, calibrated on Evans 2015 |
| $\tau_x$, $G_x$ | 24 h, 6 µm | A.6, marked "assumed", nominal target Grubb 2010 (48 h, 17 µm) |
| $k_B$, $k_x$ | 5 mV | A.6, from Goethals & Brette 2020 |
| $\tau_c$ | about 1 h | A.8. A.6 and A.7 give no value |
| $g_0$, $\tau_g$, $G_g$, $k_g$ | not stated | not in any source (A.8 introduces the symbols only) |
| $c$ during 15 mM K$^+$ | 3 | A.6, stated as an assumption |
| $\bar c$ under chronic deprivation | 0.3 | A.8 inference section |
| $V_{th} - V_{rest}$ | 20 mV | A.6, used to turn threshold shifts into rheobase changes |

---

## T4.1: Slow Ca$^{2+}$/activity proxy driving the AIS controller (inherited: A.8 PDF Eq. (13))

**Equation as stated in the latest source.** The first relation of Model_A8_Scientific_Report.pdf Eq. (13). The same equation appears in Model_A8_model only.docx, in A.6 Eq. 25 and in A.7 annex Eq. 25:

$$
\tau_c\frac{d\bar c_i}{dt} = -\bar c_i + c_i(t)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\bar c_i$ | slow Ca$^{2+}$/depolarization proxy of neuron $i$. A.6 lists it as "relative (1 = normal)" | dimensionless |
| $c_i(t)$ | fast Ca$^{2+}$/depolarization drive. A.6 says only "$c = 1$ at normal activity"; no source defines it from model variables | dimensionless |
| $\tau_c$ | filter time constant, "$\tau_c \approx 1$ h" (A.8). The same symbol is used for the capture SDE (T6.8) | h |

**Physical starting point.** A.6 gives the mechanism in its "Why" note: the depolarization-induced AIS changes "act through L-type Ca$^{2+}$ and calcineurin, hence the shared Ca$^{2+}$ proxy". A.8 adds that $\bar c_i$ is "a slow integration proxy for intracellular calcium/depolarization, mediated biochemically by calcineurin and calmodulin kinase II ($\tau_c\approx1$ h)". Neither source derives the filter.

The reconstruction below (Steps 1-5) derives it as the linear, low-occupancy limit of Ca$^{2+}$-dependent enzyme activation. It uses standard mass-action kinetics, the same reasoning as a first-order Michaelis-Menten/Langmuir binding process. Assumptions:

- A1. The proxy is the activity $A$ of one well-mixed pool of a Ca$^{2+}$-activated signalling enzyme, such as calcineurin. The total amount is $A_T$.
- A2. Activation and deactivation follow mass action. Activation proceeds at rate $k_+ f(\mathrm{Ca}_i)$, where $f$ is an increasing function of cytosolic Ca$^{2+}$. Deactivation proceeds at rate $k_-$.
- A3. Low occupancy: $k_+ f \ll k_-$, so that $A \ll A_T$.
- A4. The fast drive is $f$ normalized by its value $f_{ref}$ at normal activity.

**Derivation.**

*Part A. Reconstruction of the filter (Reconstructed; standard mass-action kinetics).*

1. *Mass-action balance for the active enzyme (A1, A2).* Inactive enzyme $(A_T - A)$ is activated at rate $k_+ f$, and active enzyme is deactivated at rate $k_-$:
$$
\frac{dA}{dt} = k_+ f\,(A_T - A) - k_- A
$$

2. *Expand the product.* This is allowed by the distributive law:
$$
\frac{dA}{dt} = k_+ f A_T - (k_+ f + k_-)\,A
$$

3. *Apply low occupancy (A3).* With $k_+ f \ll k_-$, the coefficient $(k_+ f + k_-)$ equals $k_-$ to relative error $k_+ f/k_-$:
$$
\frac{dA}{dt} \approx k_+ f A_T - k_- A
$$

4. *Divide by $k_- > 0$.*
$$
\frac{1}{k_-}\frac{dA}{dt} = \frac{k_+ A_T}{k_-}\,f - A
$$

5. *Nondimensionalize (A4).* Define three things:
    - the reference activity $A_{ref} = (k_+ A_T/k_-)\,f_{ref}$, which is the steady state of Step 4 at normal activity;
    - the normalized variables $\bar c = A/A_{ref}$ and $c = f/f_{ref}$;
    - the time constant $\tau_c = 1/k_-$.

   Divide Step 4 by $A_{ref}$:
$$
\tau_c\frac{d\bar c}{dt} = \frac{k_+A_T f}{k_- A_{ref}} - \bar c = \frac{f}{f_{ref}} - \bar c = c - \bar c
$$
This is T4.1. The normalization "$c = 1$ at normal activity" is the choice $f = f_{ref}$ at normal activity.

*What A3 removes.* Without A3, Step 2 gives a relaxation rate $k_+ f + k_-$ that depends on activity. Strong activation would shorten the effective time constant. The steady state $A^*/A_T = k_+ f/(k_+ f + k_-)$ would also saturate. A constant $\tau_c$ and a linear steady state therefore hold only in the low-occupancy limit.

*Part B. Exact consequences of the linear filter (no further assumptions).*

6. *Integrating factor.* Divide T4.1 by $\tau_c$:
$$
\frac{d\bar c}{dt} + \frac{\bar c}{\tau_c} = \frac{c(t)}{\tau_c}
$$
Multiply by $e^{t/\tau_c}$. By the product rule the left side becomes an exact derivative:
$$
\frac{d}{dt}\left(\bar c\,e^{t/\tau_c}\right) = \frac{c(t)}{\tau_c}e^{t/\tau_c}
$$

7. *Integrate from 0 to $t$.* This uses the fundamental theorem of calculus. Then multiply by $e^{-t/\tau_c}$:
$$
\bar c(t) = \bar c(0)\,e^{-t/\tau_c} + \frac{1}{\tau_c}\int_0^t e^{-(t-s)/\tau_c}\,c(s)\,ds
$$

8. *Weighted-average form.* Write $\alpha(t) = 1 - e^{-t/\tau_c}$. The kernel then integrates to
$$
\frac{1}{\tau_c}\int_0^t e^{-(t-s)/\tau_c}ds = 1 - e^{-t/\tau_c} = \alpha(t)
$$
Step 7 can therefore be written as
$$
\bar c(t) = (1-\alpha)\,\bar c(0) + \alpha\,\langle c\rangle_t, \qquad \langle c\rangle_t = \frac{1}{\alpha\tau_c}\int_0^t e^{-(t-s)/\tau_c}c(s)\,ds
$$
Here $\langle c\rangle_t$ is a weighted mean of $c$ over $[0,t]$, because its weights are non-negative and integrate to 1. So $\bar c(t)$ is a convex combination of $\bar c(0)$ and a weighted mean of past drive.

9. *Step response.* Let $c$ jump from 1 to $c_1$ at $t = 0$, with $\bar c(0) = 1$. Step 7 gives
$$
\bar c(t) = c_1 + (1 - c_1)\,e^{-t/\tau_c}
$$

10. *Frequency response.* Substitute $c = \hat c\,e^{i\omega t}$ and look for $\bar c = \hat{\bar c}\,e^{i\omega t}$. T4.1 gives $(1 + i\omega\tau_c)\hat{\bar c} = \hat c$, so
$$
H_c(i\omega) = \frac{\hat{\bar c}}{\hat c} = \frac{1}{1 + i\omega\tau_c}, \qquad \left|H_c\right| = \frac{1}{\sqrt{1 + \omega^2\tau_c^2}}, \qquad \varphi = -\arctan(\omega\tau_c)
$$
The values below use $\tau_c = 1$ h (computed here):
    - The corner frequency is $1/(2\pi\tau_c) = 4.42\times10^{-5}$ Hz, a period of 6.28 h.
    - A 24 h rhythm ($\omega = 0.262$ h$^{-1}$) passes with gain 0.967 and a lag of $\arctan(0.262)/\omega = 0.98$ h.
    - A fluctuation with a 1 min period ($\omega\tau_c = 377$) is attenuated about 377-fold.

    Spikes, ripples and minute-scale bursts are averaged out, while circadian modulation of activity reaches the AIS almost unattenuated.

11. *Definition of $c_i(t)$ (Proposal; not in any source).* The proxy needs a closure in terms of model variables. Three candidates are consistent with the prose:
    - **P1:** $c_i = r_i/(\rho_i\chi(a_i/a_0))$, the rate relative to the energy-scaled set point of T1.21. This is the only one of the three that makes A.6 Property P8 ("At equilibrium $r_i = \rho_i\chi$, so $\bar c_i = 1$") exact. Under energy failure $\chi \to 0$, so P1 makes $c$ large unless $r$ falls at least as fast as $\chi$. Combined with the positivity limit of T4.2 ($\bar c < 1 + 1/G_L$), P1 would need a cap.
    - **P2:** $c_i = r_i/\rho_i$. Then the homeostat's equilibrium $r = \rho\chi$ gives $\bar c = \chi(a/a_0)$, which is not 1, so the AIS settles away from baseline whenever $\chi \ne 1$.
    - **P3:** an L-type Ca$^{2+}$ proxy in voltage, $c_i = m_L(v_i)/m_L(v_{ref})$, with $m_L$ a Boltzmann activation curve. This matches the experimental paradigm, in which 15 mM K$^+$ depolarizes the membrane, rather than a spike count. It does not vanish under depolarization block.

    The consequences of P1 and P3 for uniqueness are derived in the closed-loop section.

**Result.** Under A1-A4 the filter follows exactly as the linear, low-occupancy limit of Ca$^{2+}$-dependent enzyme activation (Steps 1-5), and it matches A.6-A.8. The source is incomplete in three ways:

- (i) **$c_i(t)$ is never defined** from model variables. Step 11 gives the options. P1 is the one that reproduces the uniqueness argument of A.6 and A.8.
- (ii) **$\tau_c$ is unstated in A.6 and A.7**, and A.8 gives only "$\approx 1$ h". The A.6 Evans calibration of $\tau_L$ and $G_L$ is not reproduced with $\tau_c = 1$ h; see Checks.
- (iii) **$\tau_c$ and $c$ clash** with the capture SDE (T6.8). Renaming the proxy's constant $\tau_{Ca}$ would remove the clash.

**Checks.**

- *Dimensions.* $[\tau_c][d\bar c/dt] = \mathrm{h}\cdot\mathrm{h}^{-1} = 1$, which matches $[\bar c] = [c] = 1$.
- *Limits.*
    - As $\tau_c \to 0$, $\bar c \to c(t)$ with no filtering.
    - As $\tau_c \to \infty$, $\bar c$ stays frozen at $\bar c(0)$.
    - For constant $c = c^*$, the unique steady state is $\bar c^* = c^*$; the DC gain $H_c(0)$ is 1.
- *Stability.* The homogeneous equation has eigenvalue $-1/\tau_c < 0$, so the filter is globally exponentially stable.
- *Bounds and positivity.* By Step 8, if $c(s) \in [c_{min}, c_{max}]$ for all $s$ and $\bar c(0)$ lies in the same interval, then $\bar c(t)$ stays in it. In particular $c \ge 0$ implies $\bar c \ge 0$. This fact is used in T4.3.
- *Evans 2015 calibration (computed here).* See the table below.

A.6 states three things about the Evans experiment: 15 mM K$^+$ for 3 h shortens dentate AIS from 19.6 to 14.8 µm; recovery begins by 6 h and is complete by 24 h; and the A.6 model gives "16.2 µm" at 6 h and "19.5 µm" at 24 h. The table integrates T4.1 and T4.2 with $L_0 = 19.6$ µm, $\tau_L = 5.7$ h, $G_L = 0.33$, and $c = 3$ for $0 \le t < 3$ h, $c = 1$ afterwards (forward Euler, step $10^{-4}$ h; the $\tau_c = 0$ row also matches the closed form in T4.2 Step 10):

| $\tau_c$ | $L(3\ \mathrm{h})$ | $L(6\ \mathrm{h})$ | $L(24\ \mathrm{h})$ |
|---|---|---|---|
| 0 | 14.31 µm | 16.47 µm | 19.47 µm |
| 0.5 h | 15.04 µm | 16.18 µm | 19.45 µm |
| 1.0 h | 15.79 µm | 15.94 µm | 19.44 µm |

A.6's reported 6 h value (16.2 µm) corresponds to $\tau_c \approx 0.5$ h. The observed 3 h value (14.8 µm) corresponds to $\tau_c \approx 0.3$-$0.4$ h. With A.8's $\tau_c = 1$ h, the same $\tau_L$ and $G_L$ give 15.8 µm at 3 h, which is about 79% of the observed 4.8 µm shortening. A.8 kept the A.6 constants but changed (or first stated) $\tau_c$, without recalibrating.

**Lineage.**

- **Model A, A.2, A.3, A.4 validation:** no AIS and no proxy. The A.5 specification (Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, caveat 3) says explicitly that it "omits ... structural plastic relocation of the axon initial segment".
- **A.6 Eq. 25:** introduces the proxy, with "c = 1 at normal activity" and no $\tau_c$ value.
- **A.7 annex Eq. 25** (Model A.7 with all equations.docx): unchanged.
- **A.8 Eq. (13)** (Model_A8_Scientific_Report.pdf; Model_A8_model only.docx): unchanged form; adds "$\tau_c \approx 1$ h" and the calcineurin/CaMKII interpretation. The proxy is not coded in any of the three A.8 Lean files. In the two All_Equations files $\bar c$ enters only as a free argument `c_bar`; Model_A8_FormalVerification.lean has no AIS content.
- **A.10 and Aleph 1:** the proxy is implicit in "tri-variable leaky AIS controller".

**Derivation status.** Phenomenological closure, and incomplete in source.

- A linear first-order filter is a modelling choice. The reconstruction (Steps 1-5) shows that it is the exact low-occupancy limit of mass-action activation of a Ca$^{2+}$-dependent enzyme. Saturation and an activity-dependent time constant are neglected.
- The fast drive $c_i(t)$ is undefined in every source (Proposals P1-P3).
- The value of $\tau_c$ is inconsistent between A.6 (calibration) and A.8.

---

## T4.2: AIS length leaky controller with developmental baseline (inherited: A.10 Eq. 4.1, first relation / A.8 PDF Eq. (13))

**Equation as stated in the latest source.** The first relation of A.10 Eq. 4.1 (Model_A10_Comprehensive_Scientific_Report.docx), written there as "τ_L · dLi/dt = -(Li - L0(tg)) - GL·L0·(c̄i - 1)":

$$
\tau_L\frac{dL_i}{dt} = -\left(L_i - L_0(t_g)\right) - G_L\, L_0\,(\bar c_i - 1)
$$

The A.8 form (Model_A8_Scientific_Report.pdf Eq. (13), second relation; Model_A8_model only.docx; A.6 and A.7 Eq. 26) has a constant baseline:

$$
\tau_L\frac{dL_i}{dt} = -(L_i - L_0) - G_L L_0 (\bar c_i - 1)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $L_i$ | AIS length of neuron $i$ | µm |
| $L_0$ | baseline (homeostatic) AIS length; 22 µm (A.6, from Jamann 2021, L2/3). The Evans calibration uses 19.6 µm (dentate) | µm |
| $L_0(t_g)$ | developmental baseline (A.10); no functional form is given anywhere | µm |
| $t_g$ | developmental (gestational) age. A.9 benchmarks it in gestational weeks (DHARANI, 14-24 GW). No source states its rate relative to model time $t$ | weeks |
| $\tau_L$ | length time constant, 5.7 h (A.6, calibrated) | h |
| $G_L$ | relative length gain, 0.33 (A.6, calibrated on Evans 2015) | dimensionless |
| $\bar c_i$ | slow proxy (T4.1) | dimensionless |

**Physical starting point.** Activity-dependent AIS length plasticity. A.6's "Why" note summarizes the evidence:

- sustained depolarization shortens the AIS within hours (Evans 2015, calcineurin-dependent);
- sensory deprivation lengthens it (Kuba 2010; Jamann 2021).

No source derives the controller. It is a modelling choice: a first-order relaxation toward an activity-dependent target. The steps below show that the printed form is the linear-response version of that choice. Assumptions:

- A1. AIS length relaxes with first-order kinetics toward a target length $L_{tgt}(\bar c)$ set by the slow proxy. A scaffold (ankyrin-G/βIV-spectrin) assembled and disassembled at a rate proportional to the distance from target would behave this way. This is a modelling choice.
- A2. $L_{tgt}$ is smooth and decreasing in $\bar c$, with $L_{tgt}(1) = L_0$.
- A3. Linear response: $L_{tgt}$ is replaced by its first-order Taylor polynomial about $\bar c = 1$.
- A4. Shortening and lengthening share one time constant $\tau_L$.
- A5. (A.10 only) The baseline depends on developmental age: $L_{tgt}(1) = L_0(t_g)$.

**Derivation.**

1. *Relaxation law (A1).*
$$
\tau_L\frac{dL}{dt} = -\left(L - L_{tgt}(\bar c)\right)
$$

2. *Taylor-expand the target about $\bar c = 1$ (A2: $L_{tgt}$ is smooth).*
$$
L_{tgt}(\bar c) = L_{tgt}(1) + L_{tgt}'(1)\,(\bar c - 1) + R_2, \qquad R_2 = O\left((\bar c - 1)^2\right)
$$

3. *Name the coefficients.* Use $L_{tgt}(1) = L_0$ (A2). Define the dimensionless relative gain
$$
G_L \equiv -\frac{L_{tgt}'(1)}{L_0}
$$
so that $L_{tgt}'(1) = -G_L L_0$. Because depolarization shortens the AIS, $L_{tgt}' < 0$ and $G_L > 0$.

4. *Drop $R_2$ (A3) and substitute into Step 1.*
$$
\tau_L\frac{dL}{dt} = -\left(L - L_0 + G_L L_0(\bar c - 1)\right) = -(L - L_0) - G_L L_0(\bar c - 1)
$$
This is the A.6-A.8 form, term for term. In control terms:
    - $-(L - L_0)$ is the leak;
    - $-G_L L_0(\bar c - 1)$ is proportional action on the error $e_c = \bar c - 1$.

    Taken together, the equation is a first-order lag on proportional control. Its transfer function is derived in Step 9.

5. *Developmental baseline (A5).* Repeat Steps 2-4 with $L_{tgt}(1) = L_0(t_g)$ and with the gain defined relative to the current baseline, $G_L \equiv -L_{tgt}'(1)/L_0(t_g)$:
$$
\tau_L\frac{dL}{dt} = -\left(L - L_0(t_g)\right) - G_L L_0(t_g)(\bar c - 1)
$$
The A.10 print has $L_0(t_g)$ in the relaxation term but a bare $L_0$ in the gain term. That matches Step 5 only if the bare $L_0$ is shorthand for $L_0(t_g)$; see Result.

6. *Equilibrium for constant $\bar c$.* Set $dL/dt = 0$ in Step 4:
$$
0 = -(L^* - L_0) - G_L L_0(\bar c - 1) \quad\Longrightarrow\quad L^* = L_0\left[1 - G_L(\bar c - 1)\right]
$$
For Step 5 the same algebra gives $L^* = L_0(t_g)[1 - G_L(\bar c - 1)]$, treating $t_g$ as frozen.

7. *Uniqueness.* The right side of Step 4 is affine in $L$ with slope $-1$. Dividing by $\tau_L$ gives slope $-1/\tau_L$, which is non-zero for any finite $\tau_L > 0$. An affine function with non-zero slope has exactly one root, so $L^*$ is unique. This is the content of the A.8 Lean theorem `ais_unique_fixed_point` at $\bar c = 1$, where $L^* = L_0$; see Checks for the hypothesis it needs.

8. *Error dynamics and stability.* Let $e = L - L^*$ with $\bar c$ constant. Subtract Step 6 from Step 4:
$$
\tau_L\frac{de}{dt} = -e \quad\Longrightarrow\quad e(t) = e(0)\,e^{-t/\tau_L}
$$
The equilibrium is globally exponentially stable, with eigenvalue $-1/\tau_L$.

9. *Solution for time-varying $\bar c$.* Use the integrating factor $e^{t/\tau_L}$, exactly as in T4.1 Steps 6-7:
$$
L(t) = L_0 + \left(L(0) - L_0\right)e^{-t/\tau_L} - \frac{G_L L_0}{\tau_L}\int_0^t e^{-(t-s)/\tau_L}\left(\bar c(s) - 1\right)ds
$$
In Laplace variables with zero initial deviation, $\delta L(s) = -G_L L_0\,\delta\bar c(s)/(1 + s\tau_L)$. Cascading with T4.1 ($\delta\bar c = \delta c/(1 + s\tau_c)$) gives
$$
\frac{\delta L}{\delta c} = \frac{-G_L L_0}{(1 + s\tau_L)(1 + s\tau_c)}
$$

10. *Closed forms used in the Evans check.*
    - (a) With $\tau_c \to 0$ and a step $c = c_1$ held over $0 \le t < t_1$, Step 9 with $\bar c - 1 = c_1 - 1$ gives
$$
L(t) = L_0 - G_L L_0(c_1 - 1)\left(1 - e^{-t/\tau_L}\right), \qquad 0 \le t \le t_1
$$
      After release ($c = 1$), Step 8 gives $L(t) = L_0 - (L_0 - L(t_1))\,e^{-(t - t_1)/\tau_L}$.

      With $L_0 = 19.6$ µm, $G_L = 0.33$, $c_1 = 3$, $t_1 = 3$ h and $\tau_L = 5.7$ h: $1 - e^{-3/5.7} = 0.4092$, so $L(3) = 19.6 - 12.936\times0.4092 = 14.31$ µm. Then $L(6) = 19.6 - 5.29\,e^{-3/5.7} = 16.47$ µm and $L(24) = 19.47$ µm. These match the first row of the T4.1 table.
    - (b) With $\tau_c > 0$ ($\tau_c \ne \tau_L$), the unit-step response of the cascade in Step 9 is
$$
1 - \frac{\tau_L e^{-t/\tau_L} - \tau_c e^{-t/\tau_c}}{\tau_L - \tau_c}
$$
      It is 0 with zero slope at $t = 0$ and tends to 1. For $\tau_c = 1$ h at $t = 3$ h it equals $1 - (5.7\times0.5908 - 0.0498)/4.7 = 0.294$. Then $L(3) = 19.6 - 12.936\times0.294 = 15.80$ µm, which matches the third row of the T4.1 table.

11. *Tracking a developmental baseline (Step 5, $\bar c = 1$).* Let $L_0(t_g(t))$ change slowly at rate $\dot L_0 = dL_0/dt$, taken constant over a few $\tau_L$. With $e = L - L_0$:
$$
\tau_L\frac{de}{dt} = \tau_L\frac{dL}{dt} - \tau_L\dot L_0 = -e - \tau_L\dot L_0
$$
The solution is
$$
e(t) = -\tau_L\dot L_0 + \left(e(0) + \tau_L\dot L_0\right)e^{-t/\tau_L}
$$
so $L$ lags its baseline by $\tau_L\dot L_0$. With $\tau_L = 5.7$ h $= 0.034$ week, an illustrative developmental growth of 1 µm per week gives a lag of 0.034 µm (computed here). The controller tracks any developmental baseline quasi-statically.

12. *Pure-integral comparison (open loop).* Remove the leak from Step 4:
$$
\tau_L\frac{dL}{dt} = -G_L L_0(\bar c - 1)
$$
    - If $\bar c \equiv 1$, then $dL/dt = 0$ for every $L$. Every length is an equilibrium (a continuum), and the linearization has eigenvalue 0, so the system is only marginally stable.
    - If $\bar c \equiv \bar c^* \ne 1$, there is no equilibrium, and $L(t) = L(0) - G_L L_0(\bar c^* - 1)\,t/\tau_L$ drifts linearly without bound.

    The leak removes both pathologies: Steps 6-8 give one equilibrium for every $\bar c$, and it is exponentially stable. The closed-loop version of this argument, with the threshold homeostat T1.21 acting on the same error, is derived in the closed-loop section. That is the "two integrators on one error" problem named by A.6 and A.8.

**Result.** Under A1-A4 the A.6-A.8 equation follows exactly (Step 4). The A.10 equation has three problems.

- **(i) Mixed baselines.** The relaxation term uses $L_0(t_g)$ and the gain term uses $L_0$. Two readings:
    - *R1:* the bare $L_0$ is shorthand for $L_0(t_g)$. The equation then is Step 5.
    - *R2:* $L_0$ is a fixed adult reference $L_{ref}$. The absolute gain $G_L L_{ref}$ then does not scale with the immature baseline. The relative gain becomes $G_L L_{ref}/L_0(t_g)$, which is larger in development, and the positivity bound below becomes $\bar c < 1 + L_0(t_g)/(G_L L_{ref})$.
- **(ii) Mixed references in the threshold.** A.10's threshold relation in the same Eq. 4.1 uses $\ln(L_i/L_0)$ with the bare $L_0$. The two readings then give:
    - *R1:* $\theta_{AIS} = 0$ at $\bar c = 1$ at every age. Developmental AIS growth would then have no effect on threshold, which contradicts the resistive-coupling theory (T4.5): there the threshold depends on absolute length.
    - *R2:* the homeostatic fixed point carries the developmental offset $\theta_{AIS}^* = -k_B\ln(L_0(t_g)/L_{ref}) \ne 0$. That is physically sensible, but it means the "$\theta_{AIS} = 0$ at the fixed point" property (Lean `theta_ais_zero_at_equilibrium`) holds only for adults.
- **(iii) Missing developmental forms.** No form is given for $L_0(t_g)$, for the clock $dt_g/dt$, or for developmental versions of $x_0$ and $g_0$.

**Proposal** (not in any source), consistent with T4.5 as a physical law:
$$
\tau_L\frac{dL_i}{dt} = -\left(L_i - L_0(t_g)\right) - G_L\,L_0(t_g)\,(\bar c_i - 1)
$$
The length term of T4.5 is then written as $-k_B\ln(L_i/L_{ref})$, where $L_{ref}$ is a fixed adult reference absorbed into $\theta_0$. The fast homeostat T1.21 absorbs the developmental offset, and the closed-loop equilibrium stays unique (closed-loop section).

**Positivity is not guaranteed** (all versions since A.7). At $L = 0$ the A.8 right side equals $L_0[1 - G_L(\bar c - 1)]$, which is negative whenever
$$
\bar c > 1 + \frac{1}{G_L} = 4.03 \quad (G_L = 0.33)
$$
Consequences and history:

- The target length $L^*$ is then negative, and the logarithm in T4.5 becomes undefined once $L$ reaches 0.
- A.6 projected $(L, x)$ onto $[L_{min}, L_{max}]\times[x_{min}, x_{max}]$, without stating the bounds. A.7 and A.8 dropped the projection.

The Evans drive ($c = 3$) lies inside the safe range, but its target $0.34\,L_0$ is already short. A proxy built from firing rate (P1, P2) can exceed 4 during seizures.

**Proposal** (not in any source): a log-coordinate controller. Write $\ell = \ln(L/L_0)$ and set
$$
\tau_L\frac{d\ell}{dt} = -\ell - G_L(\bar c - 1)
$$
Three properties:

- *Same linearization.* $d\ell/dt = (1/L)\,dL/dt$, so the proposal reads $\tau_L\,dL/dt = -L\ln(L/L_0) - G_L L(\bar c - 1)$. With $L = L_0(1 + \varepsilon)$, $L\ln(L/L_0) = L_0(\varepsilon + \varepsilon^2/2 + \ldots) = (L - L_0) + O(\varepsilon^2)$ and $G_L L(\bar c - 1) = G_L L_0(\bar c - 1) + O(\varepsilon\,(\bar c - 1))$. To first order this is the A.8 equation.
- *Positivity.* The equilibrium is $L^* = L_0e^{-G_L(\bar c - 1)} > 0$ for every $\bar c$.
- *Linear threshold.* $\theta_{AIS}$ from T4.5 becomes linear in the state ($-k_B\ell$).

**Checks.**

- *Dimensions.* Every term is µm: $\tau_L\,dL/dt$ is h·µm/h, $(L - L_0)$ is µm, and $G_L L_0(\bar c - 1)$ is (1)(µm)(1).
- *Limits.*
    - $G_L \to 0$: pure relaxation to $L_0$, with no activity dependence.
    - $\tau_L \to \infty$: $L$ frozen.
    - $\bar c = 1$: $L^* = L_0$, which is the Lean fixed point.
    - $\bar c = 0$ (silence): $L^* = (1 + G_L)L_0 = 29.3$ µm for $L_0 = 22$ µm.
- *Invariant interval.* Suppose $0 \le \bar c(t) \le \bar c_{max} < 1 + 1/G_L$ for all $t$. Then:
    - at $L = (1 + G_L)L_0$ the right side is $-G_L L_0\bar c \le 0$;
    - at $L = L_0[1 - G_L(\bar c_{max} - 1)] > 0$ the right side is $\ge 0$.

    So the interval $[L_0(1 - G_L(\bar c_{max} - 1)),\,(1 + G_L)L_0]$ is forward invariant, and $L$ stays positive.
- *A.8 deprivation claim (computed here).* A.8 states that chronic deprivation gives $\bar c \to 0.3$ and "AIS elongation (+19%)". Step 6 gives a steady state of $L^*/L_0 = 1 + 0.33\times0.7 = 1.231$, that is +23.1%. With $\tau_L = 5.7$ h, a deprivation lasting days is at steady state. The +19% therefore needs either $\bar c = 1 - 0.19/0.33 = 0.42$ or an unstated $G_L = 0.27$. The two A.8 numbers are mutually inconsistent at the stated $G_L$. The closed-loop section shows a further problem: under P1 a sustained $\bar c = 0.3$ cannot be a steady state at all while T1.21 is active.
- *Symmetric kinetics (A4).* A.6 reports a failure: its model reverses enriched-environment shortening "within 0.5 µm by 14 h", while Jamann 2021 sees reversal by 6 h. A single $\tau_L$ cannot fit both the Evans time course and the faster Jamann reversal. Separate time constants for $\bar c > 1$ and $\bar c < 1$ would be the minimal fix. This is a proposal.
- *Lean theorem `ais_unique_fixed_point`.* It proves only that at $\bar c = 1$ the zero set of $dL/dt$ is $\lbrace L_0\rbrace$ (likewise for $x$ and $g$). It does not cover:
    - $\bar c \ne 1$;
    - stability;
    - the coupled equilibrium with T1.21, which is what A.6 P8 is about.

    In Model_A8_All_Equations.lean the structure has no $\tau > 0$ hypotheses. Because Lean defines $1/0 = 0$, the hypothesis `dL_dt L 1 p = 0` holds for every $L$ when $\tau_L = 0$, so the theorem as stated is false in that case. The proof also discharges the "$1/\tau_L = 0$" case by citing $1/L_0 > 0$, from which `linarith` cannot derive the required contradiction. Model_A8_All_Equations_patched.lean adds `h_tauL_pos`, `h_taux_pos` and `h_taug_pos` and uses them, which fixes the logic. Neither file was compiled here.

**Lineage.**

- **A.6 Eq. 26** (Model A.6 four-caveat revision...docx): introduces the leaky length controller, with projection onto $[L_{min}, L_{max}]$. Calibrated $\tau_L = 5.7$ h, $G_L = 0.33$ on Evans 2015, with $c = 3$ assumed for 15 mM K$^+$. P8 records the final offset over 6 seeds: 1.79 µm (pure integral) versus 0.05 µm (leaky).
- **A.7 annex Eq. 26a** (Model A.7 with all equations.docx), model A.7 maths.docx, and Model A.7 More scientific Doc (gemini).docx (equation images): the same form, without the projection. Model A.7 Upgrade Doc (gemini).docx claims that A.7 replaced the AIS law with "exact one-dimensional cable theory", but no A.7 file contains such an equation.
- **A.8 Eq. (13)** (Model_A8_Scientific_Report.pdf; Model_A8_model only.docx): the same form, with prose on leakiness and the unique fixed point. Coded in Lean as `dL_dt` (original) and `dL_ais_dt` (patched).
- **A.9** (Model_A9_changes from a8.docx): no AIS change. It introduces the developmental clock $t_g$ through the ontogenetic tensor.
- **A.10 Eq. 4.1:** adds $L_0(t_g)$ in the relaxation term only.
- **Aleph 1:** lineage-table mention only.
- **Model_Aleph_Equation_Derivations_GPT.docx §6.1:** quotes the A.6/A.7 form and calls it a first-order relaxation.

**Derivation status.** Phenomenological closure. First-order relaxation toward an activity-dependent target is a modelling choice; given that choice, the printed form is its exact linear-response version (Steps 1-4, A1-A3). The motivation is calcineurin-dependent AIS shortening (Evans 2015) and deprivation-induced lengthening (Kuba 2010; Jamann 2021); $\tau_L$ and $G_L$ were calibrated on Evans 2015. The A.10 version mixes $L_0(t_g)$ and $L_0$ (consistent form derived in Step 5). Positivity is not guaranteed.

---

## T4.3: AIS position leaky controller (inherited: A.8 PDF Eq. (14), first relation)

**Equation as stated in the latest source.** The first relation of Model_A8_Scientific_Report.pdf Eq. (14). The same equation appears in Model_A8_model only.docx, in A.6 Eq. 26 (second relation) and in A.7 annex Eq. 26b. A.10 names the position $x_i$ but does not write its equation:

$$
\tau_x\frac{dx_i}{dt} = -(x_i - x_0) + G_x(\bar c_i - 1)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $x_i$ | distance from the soma to the AIS. A.6 lists it as the "AIS midpoint distance"; A.8 calls it the "midpoint position relative to soma" | µm |
| $x_0$ | baseline distance, 25 µm (A.6) | µm |
| $\tau_x$ | position time constant, 24 h (A.6, "assumed") | h |
| $G_x$ | position gain, 6 µm (A.6, "assumed"). It is an **absolute** gain with length units, unlike $G_L$ and $G_g$ | µm |
| $\bar c_i$ | slow proxy (T4.1) | dimensionless |

**Physical starting point.** Activity-dependent AIS relocation. A.6's note: sustained depolarization "moves it distally over days (Grubb & Burrone 2010)", through the same L-type Ca$^{2+}$/calcineurin pathway as the length change. No source derives the form. Assumptions:

- A1. First-order relaxation toward an activity-dependent target position $x_{tgt}(\bar c)$. This is a modelling choice.
- A2. $x_{tgt}$ is smooth and increasing in $\bar c$, with $x_{tgt}(1) = x_0$.
- A3. Linear response about $\bar c = 1$.
- A4. One time constant for distal and proximal moves.

**Derivation.**

1. *Relaxation law (A1).*
$$
\tau_x\frac{dx}{dt} = -\left(x - x_{tgt}(\bar c)\right)
$$

2. *Taylor-expand the target (A2).*
$$
x_{tgt}(\bar c) = x_0 + x_{tgt}'(1)(\bar c - 1) + O\left((\bar c - 1)^2\right)
$$

3. *Name the gain.* The source uses the absolute slope:
$$
G_x \equiv x_{tgt}'(1) > 0 \qquad (\text{µm per unit } \bar c)
$$
It is positive because depolarization moves the AIS distally.

4. *Drop the quadratic remainder (A3) and substitute.*
$$
\tau_x\frac{dx}{dt} = -\left(x - x_0 - G_x(\bar c - 1)\right) = -(x - x_0) + G_x(\bar c - 1)
$$
This is the printed form.

5. *Map onto the normalization used in T4.2 and T4.4.* Define the relative gain $\tilde G_x \equiv G_x/x_0$; with A.6's values, $\tilde G_x = 6/25 = 0.24$. Substituting $G_x = \tilde G_x x_0$:
$$
\tau_x\frac{dx}{dt} = -(x - x_0) + \tilde G_x\,x_0\,(\bar c - 1)
$$
This is the same structure as T4.2 with the gain sign reversed: depolarization shortens the AIS ($-G_L$) but moves it distally ($+\tilde G_x$). The two forms agree as long as $x_0$ is constant. They differ if $x_0$ is ever made developmental ($x_0(t_g)$, by analogy with T4.2): the printed absolute gain would not scale with the baseline, whereas the relative form would.

6. *Equilibrium, uniqueness, stability.* Set $dx/dt = 0$:
$$
x^* = x_0 + G_x(\bar c - 1)
$$
The root is unique because the right side is affine in $x$ with slope $-1/\tau_x \neq 0$. The error $e = x - x^*$ obeys $\tau_x\,de/dt = -e$, so the equilibrium is globally exponentially stable with eigenvalue $-1/\tau_x$. For time-varying $\bar c$ the solution follows from the integrating factor, as in T4.2 Step 9. The transfer function is $\delta x/\delta\bar c = G_x/(1 + s\tau_x)$.

7. *Positivity.* At $x = 0$ the right side is $x_0 + G_x(\bar c - 1) \ge x_0 - G_x$ whenever $\bar c \ge 0$. T4.1 Checks show that $\bar c \ge 0$ whenever $c \ge 0$. So if $G_x < x_0$ (6 < 25 µm), then $dx/dt > 0$ at $x = 0$ and $\lbrace x > 0\rbrace$ is forward invariant. The target satisfies $x^* \ge x_0 - G_x = 19$ µm. There is no upper bound if $\bar c$ is unbounded.

8. *Grubb & Burrone calibration (computed here).* A.6 gives the target as "Grubb 2010 (48 h, 17 µm)". A.6 does not say what drive to use for this calibration. Assume the Grubb depolarization gets the same $c = 3$ that A.6 assigns to 15 mM K$^+$. Step 6 together with the integrating-factor solution ($\tau_c \to 0$) then gives
$$
\Delta x(48\ \mathrm{h}) = G_x(c - 1)\left(1 - e^{-48/24}\right) = 6\times2\times0.8647 = 10.38\ \text{µm}
$$
With $\tau_c = 1$ h the value is 10.31 µm. Either way it is about 61% of 17 µm. Matching 17 µm in 48 h at $c = 3$ would need $G_x = 17/(2\times0.8647) = 9.8$ µm. Even at steady state the shift is only $G_x(c - 1) = 12$ µm. A.6's assumed $G_x$ is therefore not calibrated to the cited target. A.6's own validation table does not test the displacement; it tests only the threshold change for an imposed 17 µm shift.

9. *Feedback sign through T4.5.* By T4.5, $\partial\theta_{AIS}/\partial x = -k_x/x$, which is $-k_x/x_0$ at baseline. By Step 6, $\partial x^*/\partial\bar c = G_x$. The chain rule gives the static contribution of position to the threshold:
$$
\frac{\partial\theta_{AIS}^*}{\partial\bar c}\bigg|_x = -\frac{k_x}{x_0}G_x = -k_x\tilde G_x = -5\times0.24 = -1.2\ \text{mV per unit } \bar c
$$
The sign is negative. More activity moves the AIS distally, which lowers the voltage threshold and raises the rate. With $k_x > 0$, the sign that resistive-coupling theory gives (T4.5), the position loop is **anti-homeostatic** (positive feedback). In the closed-loop section, the position loop alone (with $\theta_i$ frozen and Proposal P1 for $c$) is shown to be unstable when $K k_x\tilde G_x > 1$, where $K$ is the fractional rate sensitivity per mV. In the full system it is held in check by the length loop ($+k_B G_L = +1.65$ mV) and by T1.21.

**Result.** Under A1-A3 the printed form follows exactly (Step 4), and it matches A.6-A.8. Three issues:

- **(i) Asymmetric normalization.** $G_x$ has units of µm while $G_L$ and $G_g$ are dimensionless. This is dimensionally consistent, and the relative form (Step 5) is equivalent with $\tilde G_x = 0.24$. Rewriting T4.3 with $\tilde G_x x_0$ would make the three controllers uniform and would make any future $x_0(t_g)$ scale correctly.
- **(ii) Wrong-sign loop.** Combined with the T4.5 sign, which follows the physics, the position controller works against homeostasis (Step 9). A.8 asserts the opposite in prose: "distal relocation ... acts through input resistance shifts to reduce excitability". No input-resistance variable exists in A.8. The fixes are discussed under T4.5. Either keep $k_x > 0$ and route Grubb's effect through input resistance (the synaptic gain $G_s$ of T1.1), or add the AIS Kv7 term that can reverse $k_{x,eff}$ (T4.5 Step 16).
- **(iii) Calibration.** With $c = 3$, $G_x = 6$ µm gives about 10 µm, not 17 µm, of displacement in 48 h (Step 8).

**Checks.**

- *Dimensions.* $\tau_x\,dx/dt$ is h·µm/h = µm; $(x - x_0)$ is µm; $G_x(\bar c - 1)$ is µm·1. All terms are consistent.
- *Limits.*
    - $G_x \to 0$: pure relaxation to $x_0$.
    - $\bar c = 1$: $x^* = x_0$, which is the Lean fixed point for $x$.
    - $\bar c = 0$: $x^* = 19$ µm.
    - $\bar c = 3$: $x^* = 37$ µm.
- *Lean.* `dx_dt` in both A.8 Lean files reproduces the equation, divided by $\tau_x$. `ais_unique_fixed_point` covers $x$ at $\bar c = 1$ only, with the same $\tau$-hypothesis flaw as for $L$ in the original file (see T4.2).
- *A.6 threshold test (reproduced).* For an imposed 17 µm distal shift at fixed length, T4.5 gives $-5\ln(42/25) = -2.59$ mV. A.6 reports "−2.6 mV (more excitable)" and marks it "fails on sign" against Grubb's +100 pA current-threshold rise.

**Lineage.**

- **A.6 Eq. 26** (second relation): introduced, with projection onto $[x_{min}, x_{max}]$. $\tau_x$ and $G_x$ are marked "assumed".
- **A.7 annex Eq. 26b** and model A.7 maths.docx: unchanged, without the projection.
- **A.8 Eq. (14)** (Model_A8_Scientific_Report.pdf; Model_A8_model only.docx): unchanged. Coded in Lean as `dx_dt`. The prose claim on the sign is not supported by the equations.
- **A.10:** "Adapts physical length (Li), position (xi), and channel density (gAIS,i)". The $x$ equation is not printed.
- **Aleph 1:** lineage table only.
- **GPT audit §6.1:** quotes the A.6/A.7 form.

**Derivation status.** Phenomenological closure. First-order relaxation of AIS position toward an activity-dependent target is a modelling choice; the printed form is its exact linear-response version. The motivation is distal relocation under chronic depolarization (Grubb & Burrone 2010). $\tau_x$ and $G_x$ are assumed values, not calibrated. Through T4.5 the loop has an anti-homeostatic sign.

---

## T4.4: AIS Na-channel density leaky controller (inherited: A.8 PDF Eq. (14), second relation)

**Equation as stated in the latest source.** The second relation of Model_A8_Scientific_Report.pdf Eq. (14). The same equation appears in Model_A8_model only.docx. A.10 names $g_{AIS,i}$ without writing its equation:

$$
\tau_g\frac{dg_{AIS,i}}{dt} = -(g_{AIS,i} - g_0) - G_g\, g_0\,(\bar c_i - 1)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $g_{AIS,i}$ | AIS Na$^+$-channel conductance density; A.8 calls it "sodium channel cluster conductance density". No source states units | conductance per area, e.g. S/m² (the unit Goethals & Brette 2020 use) |
| $g_0$ | baseline density; no value in any source | same as $g_{AIS}$ |
| $\tau_g$ | density time constant; no value in any source | h |
| $G_g$ | relative density gain; no value in any source | dimensionless |
| $\bar c_i$ | slow proxy (T4.1) | dimensionless |

**Physical starting point.** A.6 found that AIS geometry alone explains only about a fifth of the rheobase drop after whisker deprivation (Jamann 2021). It concluded that "most of the excitability change after deprivation or a shift comes from other properties that move with the AIS. These include Na$^+$ channel density, Kv7 clustering and input resistance". It recommended a third slow state $g_{AIS}$ with threshold term $-k\ln g$. A.8 added that state. No source derives its dynamics. Assumptions:

- A1. First-order relaxation toward an activity-dependent target density $g_{tgt}(\bar c)$. This is a modelling choice.
- A2. $g_{tgt}$ is smooth and decreasing in $\bar c$, with $g_{tgt}(1) = g_0$. Deprivation up-regulates channel density.
- A3. Linear response about $\bar c = 1$.
- A4. One time constant $\tau_g$.

**Derivation.**

1. *Relaxation law (A1).*
$$
\tau_g\frac{dg}{dt} = -\left(g - g_{tgt}(\bar c)\right)
$$

2. *Taylor expansion (A2).*
$$
g_{tgt}(\bar c) = g_0 + g_{tgt}'(1)(\bar c - 1) + O\left((\bar c - 1)^2\right)
$$

3. *Name the relative gain.*
$$
G_g \equiv -\frac{g_{tgt}'(1)}{g_0} > 0
$$

4. *Drop the remainder (A3) and substitute.*
$$
\tau_g\frac{dg}{dt} = -\left(g - g_0 + G_g g_0(\bar c - 1)\right) = -(g - g_0) - G_g g_0(\bar c - 1)
$$
This is the printed form. It has the same structure as T4.2.

5. *Equilibrium, uniqueness, stability.* Setting $dg/dt = 0$ gives
$$
g^* = g_0\left[1 - G_g(\bar c - 1)\right]
$$
The root is unique because the right side is affine in $g$ with slope $-1/\tau_g \ne 0$. The error $e = g - g^*$ obeys $\tau_g\,de/dt = -e$, so the equilibrium is globally exponentially stable. The transfer function is $\delta g/\delta\bar c = -G_g g_0/(1 + s\tau_g)$.

6. *Positivity.* As in T4.2, the right side at $g = 0$ is $g_0[1 - G_g(\bar c - 1)]$. This is negative when $\bar c > 1 + 1/G_g$, so $g > 0$ is not guaranteed. The log-coordinate form proposed in T4.2, $\tau_g\,d\ln(g/g_0)/dt = -\ln(g/g_0) - G_g(\bar c - 1)$, would remove the problem.

7. *Feedback sign through T4.5.* $\partial\theta_{AIS}/\partial g = -k_g/g_0$ at baseline, and $\partial g^*/\partial\bar c = -G_g g_0$. Hence
$$
\frac{\partial\theta_{AIS}^*}{\partial\bar c}\bigg|_g = +k_g G_g
$$
This is positive, so the density loop is homeostatic, like the length loop.

8. *What A.8's whisker-deprivation result requires (computed here).* A.8 reports the rheobase drop as −24.2% (target −20 to −33%) with $\bar c \to 0.3$ and AIS length +19%. A.6's conversion (T4.5 Step 15) with a 20 mV gap gives the required total shift: $\theta_{AIS} = -0.242\times20 = -4.84$ mV. The contributions:
    - Length term: $-5\ln(1.19) = -0.87$ mV.
    - Position term at the T4.3 steady state: $x^* = 25 + 6(0.3 - 1) = 20.8$ µm, so $-5\ln(20.8/25) = +0.92$ mV. A proximal move raises the threshold.
    - The density term must supply the rest: $-4.84 + 0.87 - 0.92 = -4.89$ mV.

    With $k_g = 5$ mV this needs $g^*/g_0 = e^{4.89/5} = 2.66$. By Step 5 that is a steady-state gain $G_g = (2.66 - 1)/0.7 = 2.37$. If the position term is ignored, the requirement drops to $g^*/g_0 = 2.21$ ($G_g = 1.73$). With the larger slope that Goethals & Brette 2020 found for $g$ in their biophysical simulations (8-9 mV; see T4.5), the requirement drops to $g^*/g_0 \approx 1.8$ (at 8.5 mV). No source gives $G_g$, $k_g$, $g_0$ or $\tau_g$, so the −24.2% cannot be reproduced from the published parameters. It needs Na$^+$ density to rise by roughly 1.8- to 2.7-fold.

**Result.** Under A1-A3 the printed form follows exactly (Step 4) and matches A.8. Three issues:

- **(i) Missing parameters.** None of $g_0$, $\tau_g$, $G_g$ or $k_g$, nor the units of $g_{AIS}$, is stated anywhere. A.8's validation figures depend on them.
- **(ii) Rheobase fixed, voltage threshold broken.** A.6's validation table summarizes Jamann 2021 as "−50 pA, about −20 to −33%; voltage threshold unchanged". The T4.4 + T4.5 mechanism reproduces the rheobase drop only by *lowering the voltage threshold* by about 4.8 mV (Step 8). That contradicts the unchanged voltage threshold. The A.8 "fix" matches one observable by breaking another. A.6's own diagnosis (input resistance, Kv7) points to a mechanism that changes rheobase at fixed voltage threshold; see T4.5 Step 15.
- **(iii) Positivity** is not guaranteed (Step 6).

**Checks.**

- *Dimensions.* Every term has the units of $g$ (conductance per area); $G_g$ is dimensionless.
- *Limits.* $\bar c = 1$ gives $g^* = g_0$, the Lean fixed point. $\bar c = 0$ gives $g^* = (1 + G_g)g_0$. $G_g \to 0$ gives pure relaxation.
- *Lean.* `dg_dt` (both files) reproduces the equation, divided by $\tau_g$. `ais_unique_fixed_point` covers $g$ at $\bar c = 1$. In the original file the proof of the $g$ case again cites `h_L0_pos`; this is the flaw described in T4.2.
- *Double counting.* T4.5 multiplies density by length through $\ln(g/g_0) + \ln(L/L_0)$, which is correct only if $g_{AIS}$ is a *density* (total conductance $= g\pi dL$). If $g_{AIS}$ were read as the total AIS conductance, the length effect would be counted twice. A.8's wording ("conductance density") supports the density reading.

**Lineage.**

- **A.6** (Section 8 and the recommendations list): proposes the state.
- **A.7:** none, despite A.6's recommendation.
- **A.8 Eq. (14)** (Model_A8_Scientific_Report.pdf; Model_A8_model only.docx; Model_A8_Scientific_Report.docx): introduced. The lineage table says it "resolves the Jamann whisker deprivation failure; rheobase drop increases from −4.5% to −24.2%". Coded in Lean as `dg_dt`.
- **A.9:** no change.
- **A.10:** named as a state of the "tri-variable" controller; the equation is not printed.
- **Aleph 1:** lineage table "Tri-variable leaky AIS controller (L, x, gAIS)".
- **GPT audit:** omits $g_{AIS}$ altogether.

**Derivation status.** Phenomenological closure, and incomplete in source. First-order relaxation of channel density toward an activity-dependent target is a modelling choice; the printed form is its exact linear-response version. The motivation is A.6's analysis of the Jamann 2021 deprivation data. No parameter value is given in any source. The result it was introduced to produce conflicts with the reported constancy of the voltage threshold.

---

## T4.5: AIS threshold law (inherited: A.10 Eq. 4.1, second relation / A.8 PDF Eq. (15))

**Equation as stated in the latest source.** Model_A8_Scientific_Report.pdf Eq. (15), the same in Model_A8_model only.docx. A.10 Eq. 4.1 repeats it as "θ_AIS,i = -kB·ln(Li/L0) - kx·ln(xi/x0) - kg·ln(gAIS/g0)":

$$
\theta_{AIS,i} = -k_B\ln\left(\frac{L_i}{L_0}\right) - k_x\ln\left(\frac{x_i}{x_0}\right) - k_g\ln\left(\frac{g_{AIS,i}}{g_0}\right)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\theta_{AIS,i}$ | shift of the somatic voltage threshold relative to the reference geometry. It is subtracted in T1.20 | mV |
| $k_B$, $k_x$ | length and position slopes, 5 mV each (A.6, from Goethals & Brette 2020) | mV |
| $k_g$ | density slope; no value in any source | mV |
| $L_i$, $x_i$, $g_{AIS,i}$ | AIS length, midpoint distance and Na$^+$ conductance density (T4.2-T4.4) | µm, µm, conductance/area |
| $L_0$, $x_0$, $g_0$ | reference geometry and density | as above |

The following symbols are used only in the derivation:

| Symbol | Meaning | Units |
|---|---|---|
| $V_s$, $V_a$ | somatic and AIS membrane potentials | mV |
| $V_{1/2}$, $k_a$ | half-activation voltage and Boltzmann slope factor of AIS Na$^+$ channels | mV |
| $E_{Na}$ | Na$^+$ reversal potential | mV |
| $R_a$, $r_a$ | soma-to-AIS axial resistance, and axial resistance per unit length $4R_i/(\pi d^2)$ | Ω, Ω/µm |
| $R_i$, $d$ | cytoplasmic resistivity and axon diameter | Ω·µm, µm |
| $G$ | total AIS Na$^+$ conductance, $g\,\pi d L$ | S |

**Physical starting point.** The resistive-coupling theory of spike initiation (Brette 2013, PLoS Comput Biol 9:e1003338; Goethals & Brette 2020, eLife 9:e53432). A.6 cites the second paper for the law and for $k = 5$ mV. The derivation below is Reconstructed from that theory; no Model A source contains it. Assumptions:

- A1. *Resistive coupling.* On the timescale of spike initiation, the soma and dendrites act as a large current sink, so $V_s$ is a fixed parameter. The thin proximal axon makes the soma-to-AIS axial resistance the dominant coupling. Goethals & Brette 2020 state both conditions: the proximal axon is thin compared with the somatodendritic compartment, and there are no strong subthreshold currents at the AIS.
- A2. *Quasi-static AIS at threshold.* AIS capacitance, leak and K$^+$ currents are neglected. Na$^+$ activation is instantaneous and inactivation is neglected.
- A3. *Boltzmann activation used in its subthreshold tail.* $m_\infty(V) = [1 + e^{(V_{1/2} - V)/k_a}]^{-1} \approx e^{(V - V_{1/2})/k_a}$ when $V_a$ is well below $V_{1/2}$.
- A4. *Constant driving force.* $E_{Na} - V_a \approx E_{Na} - V_{1/2} \equiv \Delta E$, because $\Delta E$ (tens of mV) $\gg k_a$ (a few mV).
- A5. *Point AIS at the midpoint.* The extended AIS is replaced by a point at its midpoint distance $x$ carrying the same total conductance $G = g\pi dL$. Goethals & Brette 2020 show that this changes the threshold only by a correction of at most about 0.9 mV for $k = 5$ mV. A.6 defines $x_i$ as the midpoint distance, which is what this assumption needs.
- A6. *Uniform cylindrical axon* with ohmic cytoplasm, so that $R_a = r_a x = 4R_i x/(\pi d^2)$.
- A7. *Only $L$, $x$ and $g$ change* with plasticity. $d$, $R_i$, $V_{1/2}$, $k_a$ and $E_{Na}$ stay fixed.

**Derivation.**

1. *Current balance at the AIS node (Kirchhoff's current law, A1, A2).* Na$^+$ current entering the AIS flows back to the soma through $R_a$:
$$
\frac{V_a - V_s}{R_a} = G\,m_\infty(V_a)\,(E_{Na} - V_a)
$$

2. *Solve for $V_s$.* Multiply by $R_a$ and rearrange:
$$
V_s = F(V_a) \equiv V_a - R_a G\,m_\infty(V_a)\,(E_{Na} - V_a)
$$

3. *Define the threshold as a fold.* Add back a small AIS capacitance $C_a$ to judge stability. Then
$$
C_a\frac{dV_a}{dt} = -\frac{V_a - V_s}{R_a} + Gm_\infty(E_{Na} - V_a) = -\frac{F(V_a) - V_s}{R_a}
$$
The derivative of the right side with respect to $V_a$ is $-F'(V_a)/R_a$, so a rest state with $F' > 0$ is stable and one with $F' < 0$ is unstable. As $V_s$ rises, the stable low-$V_a$ root and the unstable middle root merge where $F'(V_a) = 0$, at the local maximum of $F$. Beyond that point only the high (spiking) state remains. This saddle-node defines the somatic voltage threshold, as in Brette 2013:
$$
V_{th} = F(V_a^*), \qquad F'(V_a^*) = 0
$$

4. *Apply A3 and A4 to $F$.*
$$
F(V_a) = V_a - R_a G\,\Delta E\,e^{(V_a - V_{1/2})/k_a}
$$

5. *Differentiate.*
$$
F'(V_a) = 1 - \frac{R_a G\Delta E}{k_a}\,e^{(V_a - V_{1/2})/k_a}
$$

6. *Fold condition.* Set $F' = 0$:
$$
e^{(V_a^* - V_{1/2})/k_a} = \frac{k_a}{R_a G\Delta E}
$$

7. *Take logarithms* (both sides are positive):
$$
V_a^* = V_{1/2} - k_a\ln\left(\frac{R_aG\Delta E}{k_a}\right)
$$

8. *Confirm a maximum.*
$$
F''(V_a) = -\frac{R_aG\Delta E}{k_a^2}\,e^{(V_a - V_{1/2})/k_a} < 0
$$

9. *Evaluate $F$ at the fold.* Step 6 gives $R_aG\Delta E\,e^{(V_a^* - V_{1/2})/k_a} = k_a$. Substitute into Step 4:
$$
V_{th} = V_a^* - k_a = V_{1/2} - k_a - k_a\ln\left(\frac{R_aG\Delta E}{k_a}\right)
$$

10. *Domain of validity.* A3 requires $V_a^*$ to lie below $V_{1/2}$. By Step 7 this holds if and only if
$$
\frac{R_aG\Delta E}{k_a} > 1
$$
and the approximation is good when the ratio is $\gg 1$. As the AIS approaches the soma ($R_a \to 0$) or loses channels ($G \to 0$), the condition fails and the fold disappears. Goethals & Brette 2020, quoting Brette 2013, report that in the point model there is no threshold when the AIS is closer than about 2.25 µm (for their parameters).

11. *Insert the geometry (A5, A6).* Multiply $R_a = 4R_ix/(\pi d^2)$ by $G = g\pi dL$:
$$
R_aG = \frac{4R_i}{\pi d^2}x\cdot g\pi dL = \frac{4R_i}{d}\,x\,L\,g
$$

12. *Substitute into Step 9.*
$$
V_{th}(L, x, g) = V_{1/2} - k_a - k_a\ln\left(\frac{4R_i\Delta E}{d\,k_a}\,x\,L\,g\right)
$$

13. *Separate the factors relative to the reference.* Write $xLg = (x_0L_0g_0)\cdot(x/x_0)(L/L_0)(g/g_0)$. Every factor is positive, so the logarithm of the product is the sum of the logarithms:
$$
V_{th} = \underbrace{V_{1/2} - k_a - k_a\ln\left(\frac{4R_i\Delta E\,x_0L_0g_0}{d\,k_a}\right)}_{V_{th,0}} - k_a\ln\frac{L}{L_0} - k_a\ln\frac{x}{x_0} - k_a\ln\frac{g}{g_0}
$$
The constant $V_{th,0}$ contains everything A7 holds fixed.

14. *Map onto the rate law.* In T1.20 the effective threshold is $\theta_i + w_i + \theta_0 + \theta_{AIS,i}$. Identify $\theta_0$ with $V_{th,0}$ (in the voltage reference of $v_i$) and define $\theta_{AIS} \equiv V_{th}(L, x, g) - V_{th,0}$. Step 13 then gives
$$
\theta_{AIS} = -k_a\ln\left(\frac{L}{L_0}\right) - k_a\ln\left(\frac{x}{x_0}\right) - k_a\ln\left(\frac{g}{g_0}\right)
$$
This is the printed T4.5 with $k_B = k_x = k_g = k_a$.

15. *From voltage threshold to rheobase (the conversion A.6 uses).* For a passive soma with rest potential $V_{rest}$ and input resistance $R_{in}$, a current step $I$ gives the steady potential $V = V_{rest} + R_{in}I$. The cell fires once $V \ge V_{th}$, so
$$
I_{rh} = \frac{V_{th} - V_{rest}}{R_{in}}
$$
Take logarithms and differentiate:
$$
\frac{\delta I_{rh}}{I_{rh}} = \frac{\delta V_{th}}{V_{th} - V_{rest}} - \frac{\delta R_{in}}{R_{in}}
$$
At fixed $R_{in}$ the first term is exact, because $I_{rh}$ is linear in $V_{th}$. A.6 uses $V_{th} - V_{rest} = 20$ mV and $\delta R_{in} = 0$. The second term is what A.6 invokes for Grubb's experiment: with $R_{in}$ falling from 301 to 175 MΩ at a fixed 20 mV gap, $I_{rh}$ rises from 66.4 to 114.3 pA, that is by +47.8 pA (A.6: "+48 pA"; computed here). In the rate model, $R_{in}$ acts through the synaptic gain $G_s$ of T1.1, not through $\theta$.

16. *Extension: a non-Na$^+$ outward current at the AIS (Reconstructed).* Kv7 channels are an example. Add an outward current $I_{out}$ to Step 1:
$$
\frac{V_a - V_s}{R_a} = Gm_\infty(V_a)(E_{Na} - V_a) - I_{out} \quad\Longrightarrow\quad V_s = F(V_a) + R_aI_{out}
$$
If $I_{out}$ is approximately constant over the few mV around the fold, $F'$ is unchanged. The fold then sits at the same $V_a^*$, and
$$
V_{th} = V_{1/2} - k_a - k_a\ln\left(\frac{R_aG\Delta E}{k_a}\right) + r_a\,x\,I_{out}
$$
Differentiate with respect to $\ln x$ at fixed $L$ and $g$:
$$
\frac{\partial V_{th}}{\partial\ln x} = -k_a + r_a x I_{out}
$$
The effective position slope is therefore
$$
k_{x,eff} = k_a - r_a x_0 I_{out}
$$
It becomes negative, so that a distal move raises the threshold, when the ohmic drop of the AIS outward current across the soma-AIS resistance exceeds $k_a$. Goethals & Brette 2020 describe this reversal in words, following Lezmy et al. 2017: Kv7 channels "raise the somatic threshold by an amount proportional to AIS distance". If $I_{out}$ scales with AIS length (a constant Kv7 density), the length slope is reduced in the same way: $k_{B,eff} = k_a - r_a x_0 I_{out}$.

17. *Small-signal form (used in the closed-loop section).* With $\ln(1 + \varepsilon) = \varepsilon + O(\varepsilon^2)$:
$$
\theta_{AIS} \approx -k_B\frac{\delta L}{L_0} - k_x\frac{\delta x}{x_0} - k_g\frac{\delta g}{g_0}
$$

**Result.** Under A1-A7 the threshold law is derived (Steps 1-14). It has exactly the printed form with one common slope, $k_B = k_x = k_g = k_a$, where $k_a$ is the Boltzmann slope of AIS Na$^+$ activation. Model_Aleph_Equation_Derivations_GPT.docx §6.1 says the logarithmic law "is not uniquely implied by cable theory". That is true of cable theory in general, but the law *is* implied by its resistive-coupling limit. Further points:

- **(i) Independent slopes.** Three independent slopes are an empirical generalization of the theory. Goethals & Brette 2020 report theoretical $k = 5$ mV, while their biophysical simulations gave slopes of about 6-7 mV for $L$ and $x_{1/2}$ and 8-9 mV for $g$. A.6's $k_B = k_x = 5$ mV is the theoretical value. No source states $k_g$.
- **(ii) Sign of the position term.** With $k_x > 0$ the printed equation follows the physics: a distal shift lowers the *voltage* threshold. Goethals & Brette 2020: "A distal shift of the AIS normally produces a (modest) increase in excitability". A.6 computed this and recorded it as "fails on sign" against Grubb's current-threshold increase.

  A.8's prose says the opposite: "distal relocation ($x_i > x_0$) acts through input resistance shifts to reduce excitability". The equation contains no input resistance. A.8's validation figure "+82 pA" for the distal-shift current threshold therefore cannot be produced by Eqs. (13)-(15) as printed; some mechanism outside the printed equations must be involved. Two consistent repairs exist:
    - (a) keep $k_x = k_a > 0$ for the voltage threshold, and represent Grubb's excitability loss through $R_{in}$ (the $G_s$ of T1.1; Step 15);
    - (b) add the AIS outward-current term of Step 16, which makes $k_{x,eff}$ negative only when $r_ax_0I_{out} > k_a$.

  Simply setting $k_x < 0$ in T4.5 is not justified by the resistive-coupling theory. The sign also controls whether the position loop is homeostatic (T4.3 Step 9; closed-loop section).
- **(iii) Wrong observable for Jamann.** Goethals & Brette 2020 stress that AIS-specific excitability changes show up in the somatic *voltage* threshold, not in rheobase. A.8's use of $g_{AIS}$ to match a rheobase drop while the voltage threshold is reported unchanged therefore mixes observables (T4.4 Result (ii)).
- **(iv) A.10 reference.** A.10 pairs this relation with a length controller that relaxes to $L_0(t_g)$, but keeps $\ln(L_i/L_0)$ here (T4.2 Result (ii)). Under the resistive-coupling derivation the reference must be a fixed length ($L_{ref}$, absorbed into $\theta_0$). That makes a developmental threshold offset physical.

**Checks.**

- *Dimensions.* Each logarithm takes a ratio of like quantities, so each argument is dimensionless. $k_B$, $k_x$ and $k_g$ are in mV, so $\theta_{AIS}$ is in mV, consistent with $v_i$ in T1.20. In Step 9 the argument $R_aG\Delta E/k_a$ is Ω·S·mV/mV, which is dimensionless.
- *Equilibrium.* $\theta_{AIS}(L_0, x_0, g_0) = 0$ because $\ln 1 = 0$. This is the Lean theorem `theta_ais_zero_at_equilibrium`, which is correct as stated (it uses only $L_0$, $x_0$, $g_0 > 0$).
- *A.6 numbers reproduced (computed here; $k = 5$ mV, 20 mV gap):*

| Manipulation | $\theta_{AIS}$ | Rheobase change | A.6 / data |
|---|---|---|---|
| $L\times1.5$ | $-5\ln1.5 = -2.03$ mV | $-10.1\%$ | A.6 −10.1%; data −10.2 to −5.2% (Gulledge & Bravo 2016) |
| $L\times0.5$ | $-5\ln0.5 = +3.47$ mV | $+17.3\%$ | A.6 +17.3%; data +14.3 to +21.3% |
| $L\times1.7$ | $-2.65$ mV | | A.6 −2.7 mV; data −4 mV (Kuba 2010) |
| $L\times1.16$ to $1.21$ | $-0.74$ to $-0.95$ mV | $-3.7$ to $-4.8\%$ | A.6 "−4 to −5%"; A.8 "−4.5%" |
| $x$: 25 → 42 µm | $-5\ln(42/25) = -2.59$ mV | | A.6 −2.6 mV |

- *Asymmetry.* $\ln$ is concave, so halving $L$ (+3.47 mV) costs more than a 1.5-fold lengthening gains (−2.03 mV). A.6 notes this asymmetry, and the data share it.
- *Limits.*
    - $L$, $x$ or $g \to 0$ sends $\theta_{AIS} \to +\infty$. This lies outside the validity domain of Step 10, where the AIS no longer controls initiation, so the formula should be capped. This matters because T4.2 and T4.4 can drive $L$ or $g$ to 0.
    - Large $L$, $x$ or $g$ sends $\theta_{AIS} \to -\infty$ only logarithmically.
    - Setting $k_g = 0$ recovers the A.6/A.7 two-variable law.
- *Combined static gain through the controllers.* From T4.2 Step 6, T4.3 Step 9 and T4.4 Step 7, the chain rule at $\bar c = 1$ gives
$$
\frac{d\theta_{AIS}^*}{d\bar c} = k_BG_L - k_x\tilde G_x + k_gG_g = 1.65 - 1.20 + k_gG_g\ \text{mV}
$$
The length and density loops are homeostatic and the position loop is anti-homeostatic. The net is homeostatic for A.6's values.

**Lineage.**

- **A.6 Eq. 27:** $-k_B\ln(L/L_0) - k_x\ln(x/x_0)$, labelled "resistive coupling, Goethals & Brette 2020". Validation in A.6 Section 8.
- **A.7 annex Eq. 27** (Model A.7 with all equations.docx) and model A.7 maths.docx: unchanged. Model A.7 Upgrade Doc (gemini).docx claims that A.7 "replaces this with exact one-dimensional cable theory", but no A.7 file contains such an equation.
- **A.8 Eq. (15):** adds $-k_g\ln(g_{AIS}/g_0)$. Coded in Lean as `theta_AIS`, with theorem `theta_ais_zero_at_equilibrium`. The sign prose contradicts the equation.
- **A.10 Eq. 4.1** (second relation): unchanged.
- **Aleph 1:** lineage table only.
- **GPT audit §6.1:** two-variable form, labelled constitutive.

**Derivation status.** Derived under approximations: resistive coupling (A1), a quasi-static AIS with no inactivation, leak or K$^+$ current at threshold (A2), the exponential tail of Boltzmann activation (A3), a constant Na$^+$ driving force (A4), a point AIS at the midpoint (A5; correction at most about 0.9 mV), a uniform cylindrical axon (A6), and fixed channel properties (A7). The derivation forces $k_B = k_x = k_g = k_a$. Independent slopes, and any value of $k_g$, are empirical. The printed sign of the $x$ term is correct for the voltage threshold. A.8's prose and its +82 pA claim are not.

---

## Closed-loop analysis: the AIS controllers with the threshold homeostat (supports T4.2-T4.5)

Several sources make the central claim of Tier 4: that the leaky AIS controllers and the integral threshold homeostat (T1.21) have a unique joint equilibrium.

- A.6 Property P8;
- A.8 prose: "guarantees a mathematically unique homeostatic fixed point";
- Aleph 1 lineage table: "maintains unique homeostatic fixed points".

The Lean theorem covers only the AIS part of that claim at $\bar c = 1$. This section derives the full claim, the failure of the pure-integral variant, and the linear stability of the loop.

**Assumptions.**

- B1. The rate is $r = R(u)$ with $u = v - S$ and $S = \theta + w + \theta_0 + \theta_{AIS}(L, x, g)$ (T1.20 with its gates held fixed). $R$ is strictly increasing, with $\kappa \equiv R'(u^*) > 0$ at the operating point.
- B2. On the AIS timescale, $v$, $w$, $a$, $n$, $k_c$ and NE are held constant. They are either fast variables slaved to their quasi-steady values or external inputs.
- B3. The homeostat is $\tau_\theta\,d\theta/dt = r - \rho\chi$ (T1.21), with $\rho\chi$ constant under B2.
- B4. The proxy closure is P1 of T4.1, $c = r/(\rho\chi)$, unless stated otherwise.
- B5. The AIS dynamics are T4.1-T4.4 (leaky) or their pure-integral variants.

**Derivation.**

1. *Equilibrium with leaky controllers (P1).*
    - $d\theta/dt = 0$ gives $r^* = \rho\chi$.
    - T4.1 at steady state gives $\bar c^* = c^* = r^*/(\rho\chi) = 1$.
    - T4.2-T4.4 at $\bar c = 1$ give $L^* = L_0$, $x^* = x_0$, $g^* = g_0$. This is Lean `ais_unique_fixed_point`.
    - T4.5 then gives $\theta_{AIS}^* = 0$. This is Lean `theta_ais_zero_at_equilibrium`.

   The remaining condition is $R(v - \theta - w - \theta_0) = \rho\chi$. Because $R$ is strictly increasing, it has at most one solution, $u^* = R^{-1}(\rho\chi)$, which exists if $\rho\chi$ lies in the range of $R$. Hence
$$
\theta^* = v - w - \theta_0 - u^*
$$
is unique, and the whole equilibrium $(\theta^*, \bar c^*, L^*, x^*, g^*)$ is unique.

   *With a proxy that does not depend on the homeostat's target* (P3, or an imposed $c$): $\bar c^* = c^*$ is fixed by $v$. T4.2 Step 6, T4.3 Step 6 and T4.4 Step 5 give unique $L^*$, $x^*$ and $g^*$, T4.5 gives $\theta_{AIS}^*$, and $\theta^*$ is again unique. The equilibrium is still unique, but the AIS sits off its baseline.

2. *Pure-integral variant.* Remove the three leaks:
$$
\tau_L\dot L = -G_LL_0(\bar c - 1), \qquad \tau_x\dot x = G_x(\bar c - 1), \qquad \tau_g\dot g = -G_gg_0(\bar c - 1)
$$
   An equilibrium needs both $\bar c = 1$ and $r = \rho\chi$.
    - (a) *P1.* The two conditions coincide. The only constraint on $(\theta, L, x, g)$ is $u^* = v - w - \theta_0 - \theta - \theta_{AIS}(L, x, g)$, that is
$$
\theta - k_B\ln\frac{L}{L_0} - k_x\ln\frac{x}{x_0} - k_g\ln\frac{g}{g_0} = v - w - \theta_0 - u^* = \text{const}
$$
      This is a three-dimensional manifold of equilibria in $(\theta, L, x, g)$; it is two-dimensional in A.6, which has no $g$. The Jacobian has one zero eigenvalue for each direction along the manifold. The state at which the system stops depends on initial conditions and noise, which matches A.6's random 1.79 µm final offset. A.6 P8 writes this set as "$\theta + k_B\ln L$ fixed". With T4.5's sign it is $\theta - k_B\ln L$ (plus the $x$ and $g$ terms), so A.6 has a sign slip.
    - (b) *Mismatched set points.* Suppose $\bar c = 1$ corresponds to a rate $r_c \ne \rho\chi$, for example under P2, where $r_c = \rho$ and $\chi < 1$. Then the two equilibrium conditions are incompatible and **no equilibrium exists**. While the homeostat holds $r \approx \rho\chi$, $\bar c \to \chi$ and
$$
\frac{dL}{dt} = \frac{G_LL_0(1 - \chi)}{\tau_L} > 0
$$
      is constant, so $L$ grows linearly without bound while $\theta$ rises to compensate. This is integrator windup between two integrators fed by one error, which is the failure A.6 and A.8 describe. Only a projection bound (A.6) stops it.

3. *Consequence for transient versus permanent AIS changes.* Under P1, Step 1 shows that every steady state has $\bar c = 1$ and the AIS at baseline. A sustained change in drive is absorbed entirely by $\theta_i$; the AIS changes only while $\theta_i$ is catching up. A sustained $\bar c = 0.3$, as A.8 uses for congenital deprivation, can be a steady state only if one of the following holds:
    - T1.21 is absent;
    - T1.21 is saturated. A.8 dropped Model A's projection of $\theta$, so it cannot saturate;
    - T1.21 is much slower than the observation window;
    - $c$ is a Ca$^{2+}$/voltage proxy (P3) that deprivation lowers directly.

   No source says which. A.8's deprivation scenario therefore cannot be reproduced from the stated model.

4. *Linearization (P1).* Write $\lambda = \delta L/L_0$, $\xi = \delta x/x_0$, $\gamma = \delta g/g_0$ and $\delta S = \delta\theta + \delta\theta_{AIS}$. B1 gives $\delta r = -\kappa\,\delta S$. Then:
    - P1 gives $\delta c = \delta r/r^* = -K\,\delta S$, with $K \equiv \kappa/r^*$ in mV$^{-1}$, the fractional rate change per mV. Its value depends on the transfer function $\Phi$ of T1.20, which no source defines, so $K$ is scanned below rather than fixed.
    - T4.5 Step 17 gives $\delta\theta_{AIS} = -k_B\lambda - k_x\xi - k_g\gamma$.
    - B3 linearizes to $\tau_\theta\,d\delta\theta/dt = \delta r = -\kappa\,\delta S$. Dividing by $\kappa$ defines $T_\theta \equiv \tau_\theta/\kappa$, which is a time. With T1.21's units ($[\tau_\theta]$ = Hz·s/mV) and $[\kappa]$ = Hz/mV, $T_\theta$ is in s.

   The linear system is

   $$
   T_\theta\frac{d\delta\theta}{dt} = -\delta S, \qquad \tau_c\frac{d\delta\bar c}{dt} = -\delta\bar c - K\,\delta S
   $$

   $$
   \tau_L\frac{d\lambda}{dt} = -\lambda - G_L\,\delta\bar c, \qquad \tau_x\frac{d\xi}{dt} = -\xi + \tilde G_x\,\delta\bar c, \qquad \tau_g\frac{d\gamma}{dt} = -\gamma - G_g\,\delta\bar c
   $$

5. *Characteristic equation.* Laplace-transform each line with zero initial data:
    - $\lambda = -G_L\delta\bar c/(1 + s\tau_L)$, $\xi = \tilde G_x\delta\bar c/(1 + s\tau_x)$, $\gamma = -G_g\delta\bar c/(1 + s\tau_g)$;
    - hence $\delta\theta_{AIS} = H(s)\,\delta\bar c$, with
$$
H(s) = \frac{k_BG_L}{1 + s\tau_L} - \frac{k_x\tilde G_x}{1 + s\tau_x} + \frac{k_gG_g}{1 + s\tau_g}
$$
    - $\delta\bar c = -K\,\delta S/(1 + s\tau_c)$ and $\delta\theta = -\delta S/(sT_\theta)$.

   Substitute $\delta\theta = -\delta S/(sT_\theta)$ and $\delta\theta_{AIS} = H\,\delta\bar c = -KH\,\delta S/(1 + s\tau_c)$ into the definition $\delta S = \delta\theta + \delta\theta_{AIS}$:
$$
\delta S = -\frac{\delta S}{sT_\theta} - \frac{K\,H(s)}{1 + s\tau_c}\,\delta S
$$
   Move every term to the left side and factor out $\delta S$:
$$
\delta S\left[1 + \frac{1}{sT_\theta} + \frac{K\,H(s)}{1 + s\tau_c}\right] = 0
$$
   Non-trivial modes therefore satisfy
$$
1 + \frac{1}{sT_\theta} + \frac{K\,H(s)}{1 + s\tau_c} = 0
$$
   The DC value $H(0) = k_BG_L - k_x\tilde G_x + k_gG_g$ is the static gain of T4.5 Checks.

6. *AIS loop alone ($\theta$ frozen, $T_\theta \to \infty$).*
    - (a) *Length only.* Multiply by $(1 + s\tau_c)(1 + s\tau_L)$ and set $\gamma_L = Kk_BG_L > 0$:
$$
\tau_c\tau_L s^2 + (\tau_c + \tau_L)s + (1 + \gamma_L) = 0
$$
      All coefficients are positive, so both roots lie in the left half-plane for every $K \ge 0$ (Routh-Hurwitz for a quadratic).
    - (b) *Position only.* Set $\gamma_x = Kk_x\tilde G_x$:
$$
\tau_c\tau_x s^2 + (\tau_c + \tau_x)s + (1 - \gamma_x) = 0
$$
      The roots are stable if and only if $\gamma_x < 1$. For $\gamma_x > 1$ their product $(1 - \gamma_x)/(\tau_c\tau_x)$ is negative, so one root is real and positive. With A.6's values, $\gamma_x = 1.2K$, so the isolated position loop is unstable for $K > 0.83$ mV$^{-1}$ (computed here and confirmed numerically). This is the anti-homeostatic sign of T4.3 Step 9.
    - (c) *Length and position together.* Multiply by $(1 + s\tau_c)(1 + s\tau_L)(1 + s\tau_x)$:
$$
(1 + s\tau_c)(1 + s\tau_L)(1 + s\tau_x) + \gamma_L(1 + s\tau_x) - \gamma_x(1 + s\tau_L) = 0
$$
      Expanded, this is $a_3s^3 + a_2s^2 + a_1s + a_0 = 0$ with
$$
a_3 = \tau_c\tau_L\tau_x, \quad a_2 = \tau_c\tau_L + \tau_c\tau_x + \tau_L\tau_x, \quad a_1 = \tau_c + \tau_L + \tau_x + \gamma_L\tau_x - \gamma_x\tau_L, \quad a_0 = 1 + \gamma_L - \gamma_x
$$
      Routh-Hurwitz for a cubic requires all $a_k > 0$ and $a_2a_1 > a_3a_0$. Suppose $\tau_x \ge \tau_L$ and $k_BG_L \ge k_x\tilde G_x$, so that $\gamma_L \ge \gamma_x$. Then:
        - $a_0 \ge 1 > 0$.
        - $a_1 > 0$, because $\gamma_L\tau_x \ge \gamma_x\tau_x \ge \gamma_x\tau_L$.
        - The cross condition holds. First, $a_2(\tau_c + \tau_L + \tau_x) > \tau_L\tau_x\cdot\tau_c = a_3$. Second, $a_2 \ge \tau_c\tau_x$ and $\gamma_L\tau_x - \gamma_x\tau_L \ge \tau_L(\gamma_L - \gamma_x)$, so $a_2(\gamma_L\tau_x - \gamma_x\tau_L) \ge a_3(\gamma_L - \gamma_x)$. Adding the two inequalities gives $a_2a_1 > a_3(1 + \gamma_L - \gamma_x) = a_3a_0$.

      So under these two conditions the AIS loop is stable for every $K \ge 0$ and every $\tau_c > 0$. A.6's values satisfy both (24 h ≥ 5.7 h; 1.65 ≥ 1.20 mV). With $\tau_c = 1$ h the coefficients are $a_3 = 136.8$, $a_2 = 166.5$, $a_1 = 30.7 + 32.76K$, $a_0 = 1 + 0.45K$, and $a_2a_1 - a_3a_0 = 4974.8 + 5393.0K > 0$ (computed here).

7. *With the homeostat (finite $T_\theta$): a Nyquist sufficient condition.* The open-loop function is $\mathcal{L}(s) = 1/(sT_\theta) + KH(s)/(1 + s\tau_c)$.
    - Its poles are $s = 0$ (simple) and $-1/\tau_c$, $-1/\tau_L$, $-1/\tau_x$, $-1/\tau_g$. None lies in the open right half-plane.
    - Indent the Nyquist contour to the right around $s = 0$. On the small indentation $1/(sT_\theta)$ dominates and maps to a large arc in the right half-plane, which cannot encircle $-1$.
    - On the rest of the imaginary axis, $\mathrm{Re}[1/(i\omega T_\theta)] = 0$, so $\mathrm{Re}\,\mathcal{L}(i\omega) = \mathrm{Re}[KH(i\omega)/(1 + i\omega\tau_c)]$.

   If this real part exceeds $-1$ for all $\omega > 0$, the plot never meets the real axis at or left of $-1$, and its winding number about $-1$ is zero. With no open-loop right-half-plane poles, the closed loop is then stable **for every $T_\theta > 0$**:
$$
K\cdot\min_{\omega > 0}\mathrm{Re}\left[\frac{H(i\omega)}{1 + i\omega\tau_c}\right] > -1
$$
   For A.6's $L$ and $x$ loops with $\tau_c = 1$ h, the minimum is $-0.095$ mV, at $\omega \approx 0.86$ h$^{-1}$ (computed here). The condition then holds for $K < 10.5$ mV$^{-1}$. On the imaginary axis the length-plus-position $H$ alone satisfies $\mathrm{Re}\,H(i\omega) \ge (k_BG_L - k_x\tilde G_x)/(1 + \omega^2\tau_x^2) \ge 0$ when $\tau_L \le \tau_x$, because $1/(1 + \omega^2\tau_L^2) \ge 1/(1 + \omega^2\tau_x^2)$. The small negative minimum comes from the phase lag of the $\tau_c$ filter.

8. *Numerical confirmation (computed here).* Eigenvalues of the 5×5 system of Step 4 were computed with the $g$ loop switched off and A.6's values ($\tau_c = 1$ h, $\tau_L = 5.7$ h, $G_L = 0.33$, $\tau_x = 24$ h, $\tilde G_x = 0.24$, $k_B = k_x = 5$ mV). Over $K \in [10^{-3}, 10]$ mV$^{-1}$ and $T_\theta \in [10^{-3}, 10^3]$ h (60×60 log grid), every eigenvalue has a negative real part. The largest real part is $-1.8\times10^{-4}$ h$^{-1}$, at the slowest homeostat. The $g$ loop adds a homeostatic term to $H$, but its effect on the bound cannot be evaluated because $\tau_g$, $G_g$ and $k_g$ are unstated.

**Conclusions.**

- **Uniqueness.** The leak is what makes the joint equilibrium with T1.21 unique (Step 1). Without it there is a continuum of equilibria (P1) or none at all (mismatched set points), as A.6 and A.8 state (Step 2).
- **What Lean proves.** The Lean theorems prove the AIS half of Step 1 only, not the $\theta$ half, and nothing about stability.
- **Stability.** With A.6's parameters the coupled linear loop is stable over a wide range of rate sensitivities and homeostat speeds (Steps 6-8). The position controller is destabilizing on its own, and it is held in check only by the length loop and the homeostat.
- **AIS changes are transient under P1.** With an integral homeostat and the P1 proxy, AIS changes are transient (Step 3). Persistent structural changes need a proxy that the homeostat does not null.

---

## Summary of Tier 4 status

| Key | Equation | Status | Main issues found |
|---|---|---|---|
| T4.1 | Slow Ca$^{2+}$ proxy | Phenomenological closure; incomplete in source | $c_i(t)$ never defined (P1 $r/(\rho\chi)$ is needed for A.6 P8); constant $\tau_c$ only in the low-occupancy limit; $\tau_c \approx 1$ h (A.8) contradicts A.6's Evans calibration, which needs about 0.3-0.5 h; $\tau_c$ and $c$ clash with T6.8 |
| T4.2 | AIS length controller | Phenomenological closure | A.10 mixes $L_0(t_g)$ (relaxation) with $L_0$ (gain, threshold); no form for $L_0(t_g)$ or $dt_g/dt$; positivity lost for $\bar c > 1 + 1/G_L \approx 4.03$ (projection dropped after A.6); A.8 "+19%" at $\bar c = 0.3$ contradicts the steady state +23.1%; symmetric kinetics too slow for reversal (A.6); original Lean proof flawed (no $\tau > 0$; duplicate `dL_dt`) |
| T4.3 | AIS position controller | Phenomenological closure | absolute gain $G_x$ in µm ($\tilde G_x = 0.24$); with T4.5's sign the loop is anti-homeostatic (unstable alone if $Kk_x\tilde G_x > 1$); $G_x = 6$ µm gives about 10 µm, not 17 µm, in 48 h at $c = 3$; equation not printed in A.10 |
| T4.4 | AIS Na$^+$ density controller | Phenomenological closure; incomplete in source | $g_0$, $\tau_g$, $G_g$, $k_g$ and units never given; A.8's −24.2% needs $g^*/g_0 \approx 1.8$-$2.7$; the fix lowers the voltage threshold by about 4.8 mV although Jamann (per A.6) reports it unchanged; positivity not guaranteed |
| T4.5 | AIS threshold law | Derived under approximations | resistive-coupling theory gives the printed form with $k_B = k_x = k_g = k_a$; separate slopes empirical (Goethals & Brette 2020 simulations: 6-7 mV geometric, 8-9 mV for $g$); printed $x$ sign correct for the voltage threshold, but A.8 prose and its +82 pA claim contradict it; A.10 log reference $L_0$ conflicts with $L_0(t_g)$; logarithm unbounded outside validity ($R_aG\Delta E/k_a > 1$); A.6 P8 sign slip ($\theta - k_B\ln L$, not $+$) |
