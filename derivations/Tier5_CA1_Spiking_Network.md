# Tier 5: CA1 conductance-based spiking layer, PV block and node eviction

## Overview

Tier 5 is the only part of Aleph 1 (Model A.10.1) that resolves single spikes. The rate equations of Tier 1 carry dynamics slower than about 5 ms. A.6 introduced Tier 5 because rate equations cannot hold 150-500 Hz structure. Its assumption A7 reads: "Rate equations carry dynamics slower than about 5 ms. A spiking layer carries sub-millisecond population timing (ripples, fast ripples), and both share the same Na$^+$ and ATP ledgers."

The layer is an embedded hippocampal CA1 network of $N_E = 400$ pyramidal cells and $N_I = 80$ parvalbumin (PV) basket cells (A.6 parameter table; Model_A8_Scientific_Report.pdf Sec. 2.5). It has four parts:

- a conductance-based leaky integrate-and-fire (LIF) membrane with a noise term (T5.1);
- exponential AMPA and GABA$_A$ conductances driven by delayed spike trains (T5.2);
- an extracellular Ca$^{2+}$ pool whose depletion is meant to cut fast-ripple bursts short (T5.3);
- the pathological lesion "PV cells in depolarization block" (T5.4), which no source ever writes as an equation.

The Tier 5 file also holds two rules that link spiking to the metabolic ledgers:

- the per-spike Na$^+$ load (T5.5);
- the apoptotic node-eviction rule $a_i < 0.05\,a_0$ (T5.6), which the Aleph lineage table files under "Tier 4 & 5".

**What Aleph 1 prints.** Nothing for this tier. Both Aleph files have a lineage-table row, "Tier 4 & 5: AIS & CA1 Spiking Networks", that names the following without formulas:

- in the A.8 column, "CA1 PV depolarization block with [Ca2+]e cutoff";
- in the A.9 column, "apoptotic node eviction protocol: excises degenerate nodes (a_i < 0.05 a0) without crash";
- in the A.10 column, "non-divergent seizure truncation";
- in the A.10.1 column, "Maintains apoptotic eviction; gap-junction coupling prevents uncoordinated interneuron desynchronization".

The sources are Model_Aleph_1_only equations.docx and Model_Aleph_1_Comprehensive_Scientific_Report.docx. A.10 (Model_A10_Comprehensive_Scientific_Report.docx) describes the tier in prose only. The canonical forms below therefore come from:

- the Tier 5 block of Model_A8_model only.docx and Model_A8_Scientific_Report.docx (membrane and synapses);
- Model_A8_Scientific_Report.pdf Eq. (16) (Ca$^{2+}$ depletion);
- A.6 Eqs. 28-30 and A.7 annex Eqs. 28-30 (the reset rule and the per-spike Na$^+$ event);
- the Aleph lineage table (the eviction criterion).

**Couplings to other tiers.**

- **To Tier 1 (Na$^+$ ledger).** Every spike adds Na$^+$ to the ledger T1.18 (T5.5). The pump T1.19 clears it. Spikes enter the ledger as events, whereas the rate layer enters it through $\nu_{spk}r_i$. T5.5 shows that the two are the same term averaged over spike trains.
- **From Tier 1 (gap junctions).** Aleph Eq. 5.4 (T1.4) couples PV interneurons through Cx36 junctions. No source says which membrane equation receives $I_{gap}$. The natural host is the PV membrane of T5.1, and the coupled form is derived there as a proposal.
- **From Tier 1 (Na$^+$-fatigue gate).** The rate layer's depolarization-block surrogate $[1+(n_i/n_c)^6]^{-1}$ (T1.20) is the only formula for block anywhere in the model. T5.4 examines whether it can serve the spiking layer.
- **To Tier 3 (ATP).** Na$^+$ loaded by spikes is pumped out at 3 Na$^+$ per ATP, so ATP demand rises by $\Pi/3$ (T3.3). The ATP balance (T3.2) supplies $a_i$ for the eviction rule (T5.6).
- **To Tier 6.** The A.9 AQP4 degradation tensor (T6.19) is gated by $\mathcal{H}([Ca^{2+}]_e - Ca_{thresh})$, so it reads the T5.3 pool. Eviction (T5.6) deletes weights $W_{ij}$ (T6.4) and changes the territory headroom $h_Q$ (T6.5).
- **Not coupled, although the prose implies a coupling.** A.8 says Ca$^{2+}$ depletion "attenuates presynaptic release probability". Neither the synapse law (T5.2) nor any other equation contains $[Ca^{2+}]_e$. The missing coupling is derived in T5.3 as a proposal. The spiking membrane (T5.1) also has no K_ATP term (T1.6). ATP therefore cannot act back on spiking cells except through eviction.

**Symbol clashes to carry through.**

| Symbol | Tier 5 meaning | Other meanings |
|---|---|---|
| $\tau_m$ | CA1 membrane time constant (A.6: $\tau_E = 15$ ms, $\tau_I = 5$ ms) | rate-layer membrane constant is $\tau_v$ (T1.1), itself clashing with the vascular $\tau_v$ |
| $\tau_{ref}$ | Ca$^{2+}$ refill constant in T5.3 (A.8) | the LIF refractory period, which A.6 names without a symbol. It is written $t_{ref}$ here to avoid the clash |
| $g_{i,k}$ | inhibitory conductance of cell $k$ ("i" = inhibitory) | $i$ is the rate-layer node index everywhere else |
| $W^E_{kj}$, $W^I_{km}$ | fixed spiking-layer weights (A.6: $w_{kj}$) | plastic rate-layer weights $W_{ij}$ (T6.4). No source links the two |
| $d$ | synaptic plus conduction delay (0.6 ms) | degree $d_k$ in the gap-junction Laplacian (T1.4) |
| "eviction" | removal of a whole node (T5.6) | synaptic eviction current $E_{ij}$ (T6.4, T6.6) |
| $\sigma_{ch}$ | membrane-noise amplitude | capture-noise amplitude $\sigma_c$ (T6.8) |
| $k$ | CA1 cell index | Kirchhoff index $c$ and K$^+$ concentration $k_c$ (Tier 2) |

**Conventions.**

- Voltages are in mV and times in ms, except that T5.6 uses s. Concentrations are in mM.
- Ionic membrane currents are positive outward, as in Tier 1, so they enter a current balance with a minus sign. Gap-junction and synaptic sources are written as inward currents.
- "Normalized form" means divided by the cell's leak conductance $g_L$, so that conductances are dimensionless and every term is in mV.
- "Reconstructed" marks a derivation step that no source contains. Such steps are built from standard physics and the reference is named.
- "Proposal" marks a form that no source states.
- "Computed here" marks a number obtained in this work from source values. "Illustrative" marks a scale estimate that uses standard textbook magnitudes (for example a specific membrane capacitance of 1 µF/cm$^2$). These are not model parameters and none is claimed as a source value.

**Parameter values stated in the sources.**

| Parameter | Value | Source and status |
|---|---|---|
| $N_E$, $N_I$ | 400, 80 | A.6 parameter table ("A" = assumed); Model_A8_Scientific_Report.pdf Sec. 2.5 |
| $\tau_E$, $\tau_I$ (membrane) | 15 ms, 5 ms | A.6, "A" |
| $\tau_{AMPA}$, $\tau_{GABA}$, $d$ | 1.0, 1.5, 0.6 ms | A.6, "A", "tuned once for a normal ripple near 150 Hz" |
| pathology: clusters, $p_{in}$, $w_{in}$, PV | 2 × 150 cells, 0.3, 0.15, "depolarisation block" | A.6, "A", from Bragin 2000 and Schlingloff 2025 as cited by A.6 |
| $\sigma_{ch}$ tested | 0, 1, 3, 6 mV | A.6 Sec. 9 (Validation 4) |
| $E_L$, $E_e$, $E_i$, $V_{th}$, $V_{reset}$, $t_{ref}$ | not stated | no source gives a value |
| $[Ca^{2+}]_{e,0}$ | 1.2 mM, falling to "< 0.6 mM" during bursts | A.8 docx (both files) |
| $\tau_{Ca}$, $\tau_{ref}$, $I_{Ca,burst}$ | not stated | the Lean structure requires only $\tau_{Ca} > 0$, $\tau_{ref} > 0$, $Ca_0 > 0$ |
| $\nu_{spk}$ | not stated | the A.8 Inference gives only its capacitive formula |
| $n_{eq}$, $n_c$ | 12 mM, 4 mM | A.6, A.8 (T1.18, T1.20) |
| $K_a$ (pump ATP constant) | 0.15 mM | A.8 (T1.19) |
| $a_0$ | 2.5 mM (rest neuronal ATP) | A.6 parameter table (T3.2) |
| eviction threshold | $0.05\,a_0$ | Aleph lineage table, A.9 column |

**Validation numbers reported by the sources** (used in the checks).

| Quantity | A.6 | A.7 (column of the A.8 scorecard) | A.8 | Target cited |
|---|---|---|---|---|
| ripple peak | 148 ± 5 Hz | 148 ± 5 Hz | 150 ± 4 Hz | 148 Hz median (A.6); 148 ± 8 Hz (A.8), both citing Stark 2014 |
| fast-ripple peak | 312 ± 3 Hz | 312 ± 3 Hz | 342 ± 18 Hz | 250-600 Hz (A.6); 310-450 Hz (A.8, citing Schlingloff 2025) |
| fast-ripple event length | about 90 ms ("seizure-like") | > 90 ms | 22.4 ms | 10-30 ms |
| cluster lag | 0.15-0.25 ms | 0.18 ms | 2.75 ms | 2.2-3.4 ms (Ibarz 2010) |
| spikes per pyramidal cell per event | 0.79 (ripple), 25 (fast ripple) | - | "$\Delta n_i \approx 25\,\nu_{spk}$" | - |

---

## T5.1: CA1 conductance-based leaky integrate-and-fire membrane with channel noise (inherited: A.8 Tier 5)

**Equation as stated in the latest source.** The equation appears in the Tier 5 block of Model_A8_model only.docx and Model_A8_Scientific_Report.docx. It is identical to A.6 Eq. 28 and A.7 annex Eq. 28. A.6 adds in words "spike at V_th, reset, refractory". The A.8 PDF names the network but does not print this equation.

$$
\tau_m\frac{dV_k}{dt} = -(V_k - E_L) - g_{e,k}(t)(V_k - E_e) - g_{i,k}(t)(V_k - E_i) + \sigma_{ch}\sqrt{2\tau_m}\,\xi_k(t)
$$

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $V_k$ | membrane potential of CA1 cell $k$, with $k = 1, \ldots, N_E + N_I$ | mV |
| $\tau_m$ | membrane time constant $C_m/g_L$. It depends on cell type: $\tau_E = 15$ ms for pyramidal cells and $\tau_I = 5$ ms for PV cells (A.6) | ms |
| $E_L$, $E_e$, $E_i$ | reversal potentials of leak, AMPA and GABA$_A$ currents. No source gives values | mV |
| $g_{e,k}$, $g_{i,k}$ | AMPA and GABA$_A$ conductances divided by the leak conductance. A.6 lists them as "relative" (T5.2) | dimensionless |
| $\sigma_{ch}$ | noise amplitude. A.6 tested 1, 3 and 6 mV of "membrane noise" | mV |
| $\xi_k(t)$ | Gaussian white noise with $\langle\xi_k\rangle = 0$ and $\langle\xi_k(t)\xi_l(t')\rangle = \delta_{kl}\,\delta(t-t')$ | ms$^{-1/2}$ |
| $V_{th}$, $V_{reset}$, $t_{ref}$ | threshold, reset potential, absolute refractory period. A.6 names them in words; no symbols or values are given | mV, mV, ms |

**Physical starting point.** Charge conservation (Kirchhoff's current law) on a single isopotential membrane compartment, with Ohmic conductances, as in the Hodgkin-Huxley (1952) formalism. Spike generation is replaced by a threshold-reset rule, which is the leaky integrate-and-fire reduction (Lapicque 1907; Stein 1965; Tuckwell 1988). The noise term is the fluctuation of a finite population of stochastically gating channels (Fox & Lu 1994; White, Rubinstein & Kay 2000), reduced to white noise by a diffusion approximation. Model_Aleph_Equation_Derivations_GPT.docx Sec. 6.2 names the same starting point, $C_m\,dV/dt = -\sum_j g_j(V - E_j) + I_{syn} + I_{ext}$, but gives no steps. Assumptions:

- A1. Each CA1 cell is one isopotential compartment with constant capacitance $C_m$.
- A2. The leak current is Ohmic with conductance $g_L$ and reversal $E_L$.
- A3. AMPA and GABA$_A$ currents are Ohmic with time-varying conductances $G_e(t)$, $G_i(t)$ and fixed reversals $E_e$, $E_i$. There is no NMDA current and no activity-dependent shift of $E_i$.
- A4. The voltage-gated Na$^+$ and K$^+$ currents that make the spike are not modelled. A spike is an event at $V_{th}$ followed by a reset and a refractory period. Subthreshold voltage-gated currents are neglected or lumped into the leak.
- A5. The noise comes from a pool of $N_{ch}$ independent two-state channels. The fluctuating current is evaluated at a fixed operating voltage $\bar V$, which makes it additive. Its correlation time $\tau_g$ is much shorter than $\tau_m$, which makes it white. It is Gaussian because $N_{ch}$ is large, and it is independent between cells.
- A6. Every term is divided by the leak conductance $g_L$ of the cell.

**Derivation.**

1. *Charge balance (A1).* The capacitive current equals minus the sum of outward ionic currents:
$$
C_m\frac{dV_k}{dt} = -I_L - I_e - I_i - I_{ch}
$$

2. *Ohm's law for each pathway (A2, A3).*
$$
I_L = g_L(V_k - E_L), \qquad I_e = G_{e,k}(t)(V_k - E_e), \qquad I_i = G_{i,k}(t)(V_k - E_i)
$$

3. *Statistics of the channel pool (A5).* Let the pool have $N_{ch}$ channels with unitary conductance $\gamma$, opening rate $\alpha$, closing rate $\beta$ and open probability $p = \alpha/(\alpha + \beta)$. The conductance is $G_{ch}(t) = \gamma N_{open}(t)$. Its mean $N_{ch}\gamma p$ is a constant Ohmic conductance and is absorbed into $g_L$ (A2). Its fluctuation $\delta G = G_{ch} - N_{ch}\gamma p$ has, for independent two-state Markov channels, the stationary autocovariance
$$
\langle\delta G(t)\,\delta G(t+s)\rangle = \sigma_G^2\,e^{-\lvert s\rvert/\tau_g}, \qquad \sigma_G^2 = N_{ch}\gamma^2p(1-p), \qquad \tau_g = \frac{1}{\alpha + \beta}
$$
The fluctuating current at the operating voltage (A5) is $I_{ch} = \delta G(t)(\bar V - E_{ch})$.

4. *White-noise limit (A5).* When $\tau_g \ll \tau_m$, the membrane integrates $\delta G$ over many correlation times. It then responds only to the integral of the autocovariance:
$$
\int_{-\infty}^{\infty}\sigma_G^2e^{-\lvert s\rvert/\tau_g}\,ds = 2\sigma_G^2\tau_g
$$
A delta-correlated process with the same integral is $\delta G(t) \approx \sigma_G\sqrt{2\tau_g}\,\xi(t)$. Its autocovariance is $2\sigma_G^2\tau_g\,\delta(t - t')$, whose integral is again $2\sigma_G^2\tau_g$. Because $\xi$ and $-\xi$ have the same law, the sign of $(\bar V - E_{ch})$ can be absorbed:
$$
-I_{ch} \approx \sigma_G\,\lvert\bar V - E_{ch}\rvert\sqrt{2\tau_g}\,\xi_k(t)
$$

5. *Substitute Steps 2 and 4 into Step 1.*
$$
C_m\frac{dV_k}{dt} = -g_L(V_k - E_L) - G_{e,k}(V_k - E_e) - G_{i,k}(V_k - E_i) + \sigma_G\lvert\bar V - E_{ch}\rvert\sqrt{2\tau_g}\,\xi_k(t)
$$

6. *Divide by $g_L$ (A6).* Define $\tau_m = C_m/g_L$, $g_{e,k} = G_{e,k}/g_L$ and $g_{i,k} = G_{i,k}/g_L$:
$$
\tau_m\frac{dV_k}{dt} = -(V_k - E_L) - g_{e,k}(V_k - E_e) - g_{i,k}(V_k - E_i) + \frac{\sigma_G}{g_L}\lvert\bar V - E_{ch}\rvert\sqrt{2\tau_g}\,\xi_k(t)
$$

7. *Identify $\sigma_{ch}$.* The printed noise term is $\sigma_{ch}\sqrt{2\tau_m}\,\xi_k$. Equating it with the last term of Step 6 gives
$$
\sigma_{ch} = \frac{\sigma_G}{g_L}\,\lvert\bar V - E_{ch}\rvert\,\sqrt{\frac{\tau_g}{\tau_m}}
$$
With this identification Step 6 is T5.1 term for term.

   How the amplitude scales with channel number: let the noisy pool carry a fraction $\phi$ of the leak conductance, $N_{ch}\gamma p = \phi g_L$. Then $\gamma = \phi g_L/(N_{ch}p)$. Substituting,
$$
\frac{\sigma_G}{g_L} = \frac{\sqrt{N_{ch}}\,\gamma\sqrt{p(1-p)}}{g_L} = \phi\sqrt{\frac{1-p}{N_{ch}\,p}}
$$
   True channel noise therefore falls as $N_{ch}^{-1/2}$. This is why A.6 calls 6 mV of noise "far more than stochastic Na$^+$ channel noise in a full-size neuron".

8. *Why $\sqrt{2\tau_m}$: the stationary voltage SD.* Freeze the conductances at constant values and ignore the threshold.

   8a. *Collect the linear terms.* The deterministic right side of T5.1 is
$$
-(1 + g_e + g_i)V + (E_L + g_eE_e + g_iE_i) = -(1 + g_{tot})(V - V_\infty)
$$
   Here $g_{tot} = g_e + g_i$ and
$$
V_\infty = \frac{E_L + g_eE_e + g_iE_i}{1 + g_{tot}}
$$

   8b. *Write T5.1 as an Itô SDE.* Divide by $\tau_m$, set $u = V - V_\infty$ and $dW = \xi\,dt$:
$$
du = -\frac{u}{\tau_{eff}}\,dt + \sigma_{ch}\sqrt{\frac{2}{\tau_m}}\,dW, \qquad \tau_{eff} = \frac{\tau_m}{1 + g_{tot}}
$$
   This is an Ornstein-Uhlenbeck process.

   8c. *Itô's formula for $u^2$.*
$$
d(u^2) = 2u\,du + \frac{2\sigma_{ch}^2}{\tau_m}dt = -\frac{2u^2}{\tau_{eff}}dt + 2u\,\sigma_{ch}\sqrt{\frac{2}{\tau_m}}\,dW + \frac{2\sigma_{ch}^2}{\tau_m}dt
$$

   8d. *Take expectations.* The Itô integral has zero mean:
$$
\frac{d\langle u^2\rangle}{dt} = -\frac{2}{\tau_{eff}}\langle u^2\rangle + \frac{2\sigma_{ch}^2}{\tau_m}
$$

   8e. *Stationary value.* Set the left side to zero:
$$
\langle u^2\rangle^* = \sigma_{ch}^2\,\frac{\tau_{eff}}{\tau_m} = \frac{\sigma_{ch}^2}{1 + g_{tot}}
$$

   8f. *Conclusion.* With no synaptic conductance ($g_{tot} = 0$) the stationary SD is exactly $\sigma_{ch}$. The factor $\sqrt{2\tau_m}$ is the normalization that makes $\sigma_{ch}$ a voltage SD, independent of $\tau_m$. Synaptic conductance shunts the noise: the SD becomes $\sigma_{ch}/\sqrt{1 + g_{tot}}$. For $s > 0$ the drift in 8b also gives $d\langle u(t)u(t+s)\rangle/ds = -\langle u(t)u(t+s)\rangle/\tau_{eff}$, so the voltage autocovariance is $\langle u^2\rangle^*e^{-\lvert s\rvert/\tau_{eff}}$.

9. *Threshold-reset-refractory rule (A4).* This is a hybrid (event) rule. If $V_k(t^-) \ge V_{th}$:
    - a spike is recorded at $t^f_k = t$;
    - $V_k(t^+) = V_{reset}$;
    - $V_k$ is held at $V_{reset}$ on $(t, t + t_{ref}]$.

   The spike time is sent to the synapses (T5.2, arrival at $t + d$) and to the Na$^+$ ledger (T5.5). A.7 and A.8 drop the rule from the printed equation. Without it, T5.1 is a linear SDE that never spikes.

10. *Deterministic firing rate (consequence of Steps 8 and 9).* Set $\sigma_{ch} = 0$, hold the conductances constant, and suppose $V_\infty > V_{th}$. Starting from $V_{reset}$, the solution of 8b is
$$
V(t) = V_\infty + (V_{reset} - V_\infty)\,e^{-t/\tau_{eff}}
$$
   Set $V(T) = V_{th}$ and solve for $T$:
$$
e^{-T/\tau_{eff}} = \frac{V_\infty - V_{th}}{V_\infty - V_{reset}} \quad\Rightarrow\quad T = \tau_{eff}\ln\frac{V_\infty - V_{reset}}{V_\infty - V_{th}}
$$
   The rate is $f = 1/(t_{ref} + T)$, so $f < 1/t_{ref}$ for every input. With noise, the mean first-passage time of the OU process replaces $T$ (Siegert 1951). That noisy LIF f-I curve is the natural candidate for the transfer function $\Phi$ of the rate layer, which no source defines (T1.20).

11. *Gap-junction current for PV cells (Proposal; Aleph Eq. 5.4, T1.4).* Aleph couples PV interneurons through Cx36 junctions but does not say where the current enters. If it enters the PV membrane, add the inward current $I_{gap,k} = g_{gap}\sum_jA_{kj}(V_j - V_k) = -g_{gap}[L_{gap}V_{PV}]_k$ to Step 1 and divide by the PV leak conductance $g_{L,I}$ (A6):
$$
\tau_I\frac{dV_k}{dt} = -(V_k - E_L) - g_{e,k}(V_k - E_e) - g_{i,k}(V_k - E_i) - \frac{g_{gap}}{g_{L,I}}\left[L_{gap}V_{PV}\right]_k + \sigma_{ch}\sqrt{2\tau_I}\,\xi_k(t), \qquad k \in \mathrm{PV}
$$
   In an LIF cell the spike itself is not a voltage excursion, so the junction carries only subthreshold voltage and the reset. Spikelets are lost unless an impulse is added at each presynaptic spike, which is the standard fix for electrically coupled LIF networks (Ostojic, Brunel & Hakim 2009).

**Result.** Under A1-A6 the printed equation follows exactly (Steps 1-7). $\sigma_{ch}$ is the stationary voltage SD of the membrane without synaptic conductance (Step 8). The source is incomplete or inconsistent in several places:

- (i) *One $\tau_m$ for two cell types.* A.6 uses $\tau_E = 15$ ms and $\tau_I = 5$ ms. The equation should read $\tau_{m,k} \in \lbrace\tau_E, \tau_I\rbrace$.
- (ii) *Missing spike rule.* The threshold, reset and refractory rule (Step 9) is stated only in A.6, in words. No source gives $E_L$, $E_e$, $E_i$, $V_{th}$, $V_{reset}$ or $t_{ref}$.
- (iii) *"Channel noise" is a misnomer.* A.6's own Validation 4 showed that noise up to 6 mV never produces fast ripples. A.6 also states that real channel noise is far smaller, which Step 7 confirms through the $N_{ch}^{-1/2}$ scaling. In A.6-A.8 the term is a generic additive membrane noise. Real channel noise is multiplicative, $\delta G(V - E_{ch})$, so A5 freezes its voltage dependence.
- (iv) *Gap junctions.* The Cx36 current that Aleph adds for PV cells is not in the equation. The coupled form is the Proposal in Step 11.
- (v) *No metabolic feedback.* There is no K_ATP term $-g_K(a)(V_k - E_K)$ (T1.6). The spiking layer charges the Na$^+$ and ATP ledgers but cannot be braked by them. A consistent version would add that term, which is a proposal and needs an ATP variable per spiking cell.
- (vi) *Ca$^{2+}$ depletion is not coupled.* The depletion mechanism of T5.3 enters neither T5.1 nor T5.2 (see T5.3).

**Checks.**

- *Dimensions.* $\tau_m\,dV/dt$ is in mV. Each conductance term is a dimensionless number times mV. The noise term is mV × ms$^{1/2}$ × ms$^{-1/2}$ = mV.
- *Passive limit.* With $g_e = g_i = 0$ and $\sigma_{ch} = 0$, $V_k$ relaxes to $E_L$ with time constant $\tau_m$.
- *Bounded subthreshold voltage.* For $g_e, g_i \ge 0$ (guaranteed by T5.2), $V_\infty$ is a convex combination of $E_L$, $E_e$, $E_i$ with weights $1, g_e, g_i$. It therefore lies in $[\min(E_i, E_L), E_e]$, assuming $E_i, E_L < E_e$.
- *Firing condition.* $V_\infty > V_{th}$ means $E_L + g_eE_e + g_iE_i > (1 + g_e + g_i)V_{th}$. Rearranged:
$$
g_e(E_e - V_{th}) > (V_{th} - E_L) + g_i(V_{th} - E_i)
$$
  Each unit of inhibitory conductance raises the excitation needed to fire by $(V_{th} - E_i)/(E_e - V_{th})$. This is positive even when $E_i$ equals the resting potential, where the inhibitory current at rest is zero. That is shunting inhibition, which Tier 1's current-based synapses lack (T1.1 Step 7).
- *High-conductance state.* $\tau_{eff} = \tau_m/(1 + g_{tot})$ shrinks as input grows. This is what lets a 5 ms PV membrane follow sub-millisecond timing. For example, $g_{tot} = 4$ gives $\tau_{eff} = 1$ ms (illustrative).
- *Upper bound on single-cell rate.* $f < 1/t_{ref}$ (Step 10). A fast-ripple peak of 342 Hz has a period of 2.92 ms (computed here). Either every cell fires every cycle, which needs $t_{ref} < 2.92$ ms, or clusters alternate (T5.3 checks).
- *Charge conservation of the gap term.* $\mathbf 1^TL_{gap} = 0$ (T1.4), so the proposed gap current moves charge among PV cells without creating any.
- *Source simulation.* A.6 reports that 1, 3 and 6 mV of noise give ripple peaks of 151, 161 and 151 Hz with weaker locking, and never a fast ripple. This fits Step 8f: noise adds voltage variance of order $\sigma_{ch}^2/(1+g_{tot})$ but adds no new time scale.

**Lineage.**

- **A.4 / A.5.** The change-log row for A.4 in Model_A4_Scientific_Report_and_Formal_Specification (gemini).pdf, which is the A.5 specification, says ripples come from "2-compartment pyramidals with recurrent axo-axonal electrical gap junctions (g_gap)". No equation is given. Its caveat 4 says fast ripples "require discrete stochastic channel noise not currently captured".
- **A.6 Eq. 28** introduces the conductance-based LIF layer (change C8) with $N_E = 400$, $N_I = 80$, $\tau_E = 15$ ms and $\tau_I = 5$ ms. Reset and refractoriness are stated in words. Validation 4 rejects the channel-noise hypothesis (change C9) and the gap-junction ripple mechanism (Stark 2014: Cx36 knockout leaves ripples intact).
- **A.7 annex Eq. 28** (Model A.7 with all equations.docx) is unchanged, without the reset words.
- **A.8** (Model_A8_model only.docx; Model_A8_Scientific_Report.docx) is unchanged. The PDF Sec. 2.5 states $N_E$ and $N_I$ in prose. No Lean file encodes T5.1.
- **A.10** gives prose only: "Conductance-Based CA1 Spiking Layer".
- **Aleph 1** gives the lineage table only. Its A.10.1 column credits Cx36 coupling (Eq. 5.4) with preventing "uncoordinated interneuron desynchronization", but no PV membrane equation contains it.

**Derivation status.** Derived under approximations:

- a single isopotential compartment (A1);
- Ohmic leak and synaptic conductances with fixed reversals (A2, A3);
- the LIF reduction of spike generation (A4);
- a diffusion (white-noise) approximation of channel fluctuations frozen at an operating voltage (A5);
- normalization by $g_L$ (A6).

Incomplete in source:

- cell-type $\tau_m$;
- the reset rule after A.6;
- all reversal, threshold and reset values;
- the Cx36 term that Aleph 1 (A.10.1) claims.

---

## T5.2: Exponential synaptic conductances driven by delayed spike trains (inherited: A.8 Tier 5)

**Equation as stated in the latest source.** The equation appears in the Tier 5 block of Model_A8_model only.docx and Model_A8_Scientific_Report.docx:

$$
\frac{dg_{e,k}}{dt} = -\frac{g_{e,k}}{\tau_{AMPA}} + \sum_j W^E_{kj}\,\delta(t - t^E_j - d), \qquad \frac{dg_{i,k}}{dt} = -\frac{g_{i,k}}{\tau_{GABA}} + \sum_m W^I_{km}\,\delta(t - t^I_m - d)
$$

A.6 Eq. 29 states the same law in jump-and-decay form: "$g_{x,k} \to g_{x,k} + w_{kj}$ at each spike of $j$ (after delay $d$), $dg_{x,k}/dt = -g_{x,k}/\tau_x$ ($x$ = AMPA, GABA$_A$)". A.7 annex Eq. 29 repeats it without the delay.

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $g_{e,k}$, $g_{i,k}$ | AMPA and GABA$_A$ conductance of cell $k$, relative to its leak conductance (T5.1) | dimensionless |
| $\tau_{AMPA}$, $\tau_{GABA}$ | decay time constants: 1.0 ms and 1.5 ms (A.6, "assumed", "tuned once for a normal ripple near 150 Hz") | ms |
| $d$ | synaptic plus conduction delay, 0.6 ms (A.6, same status) | ms |
| $W^E_{kj}$, $W^I_{km}$ | conductance jump per presynaptic spike, relative to leak. A.6 writes $w_{kj}$. The pathological in-cluster value is $w_{in} = 0.15$ (A.6) | dimensionless |
| $t^E_j$, $t^I_m$ | spike times of excitatory presynaptic cell $j$ and inhibitory presynaptic cell $m$. Each cell has many: $t^{f}_j$, $f = 1, 2, \ldots$ | ms |
| $\delta(\cdot)$ | Dirac delta | ms$^{-1}$ |

**Physical starting point.** First-order kinetic gating of postsynaptic receptors driven by a brief transmitter pulse (Destexhe, Mainen & Sejnowski 1994), taken in the limit of instantaneous rise. Spikes add linearly. Assumptions:

- A1. The conductance of receptor type $x$ on cell $k$ is $G_x = \bar g_x s_x$, where $s_x$ is the open fraction of a lumped receptor population.
- A2. Receptors follow two-state kinetics, closed $\rightleftharpoons$ open, with opening rate $\alpha T(t)$ proportional to cleft transmitter $T(t)$ and closing rate $\beta$.
- A3. Each arriving spike makes a pulse $T = T_{max}$ of duration $\Delta t$. The pulse is brief: $\Delta t \to 0$ with $\alpha T_{max}\Delta t = q$ fixed, so $\beta\Delta t \to 0$. This is the instantaneous-rise limit.
- A4. Linearity: $q \ll 1$ and $s \ll 1$. There is no receptor saturation, so the jump does not depend on the prior state, and different synapses add.
- A5. Every connection has the same fixed delay $d$. Release is deterministic: no failures, no short-term plasticity, no dependence on $[Ca^{2+}]_e$.
- A6. Conductances are divided by the leak conductance $g_L$ of the postsynaptic cell (as in T5.1).

**Derivation.**

1. *Kinetic equation (A1, A2).* Mass action on the open fraction:
$$
\frac{ds}{dt} = \alpha T(t)(1 - s) - \beta s
$$

2. *Exact solution during one pulse (A3).* With $T = T_{max}$ on $[t_a, t_a + \Delta t]$ the equation is linear, $ds/dt = \alpha T_{max} - (\alpha T_{max} + \beta)s$. Its solution is
$$
s(t_a + \Delta t) = s'_\infty + \left(s(t_a^-) - s'_\infty\right)e^{-(\alpha T_{max} + \beta)\Delta t}, \qquad s'_\infty = \frac{\alpha T_{max}}{\alpha T_{max} + \beta}
$$

3. *Take the brief-pulse limit (A3).* As $\Delta t \to 0$ with $\alpha T_{max}\Delta t = q$ fixed, $(\alpha T_{max} + \beta)\Delta t \to q$ and $s'_\infty \to 1$:
$$
s(t_a^+) = 1 - \left(1 - s(t_a^-)\right)e^{-q}
$$
   The jump is therefore
$$
\Delta s = s(t_a^+) - s(t_a^-) = \left(1 - s(t_a^-)\right)\left(1 - e^{-q}\right)
$$

4. *Linearize (A4).* Use $1 - e^{-q} = q - q^2/2 + \ldots$ and $1 - s(t_a^-) \approx 1$:
$$
\Delta s \approx q
$$
   This is independent of the prior state. The neglected terms are of relative order $q$ and $s(t_a^-)$.

5. *Decay between pulses.* With $T = 0$, $ds/dt = -\beta s$, so
$$
s(t) = s(t_a^+)\,e^{-\beta(t - t_a)}
$$

6. *Distributional form.* The equation
$$
\frac{ds}{dt} = -\beta s + q\sum_a\delta(t - t_a)
$$
   reproduces Steps 4 and 5. Away from the arrival times the delta terms vanish, which gives Step 5. Integrating across one arrival time over $[t_a - \epsilon, t_a + \epsilon]$ gives
$$
s(t_a + \epsilon) - s(t_a - \epsilon) = -\beta\int_{t_a - \epsilon}^{t_a + \epsilon}s\,dt + q
$$
   The integral of the bounded $s$ vanishes as $\epsilon \to 0$, so the jump is $q$, as in Step 4. This also shows that A.6's jump-and-decay form and A.8's delta form are the same law.

7. *Arrival times and superposition (A4, A5).* A spike of presynaptic cell $j$ at $t^f_j$ arrives at $t_a = t^f_j + d$. Summing over presynaptic cells $j$ of type $x$ and over all their spikes $f$:
$$
\frac{ds_{x,k}}{dt} = -\beta_x s_{x,k} + \sum_j q_{kj}\sum_f\delta(t - t^f_j - d)
$$

8. *Normalize (A6).* Multiply by $\bar g_x/g_L$ and define $g_{x,k} = \bar g_x s_{x,k}/g_L$, $\tau_x = 1/\beta_x$ and $W_{kj} = \bar g_x q_{kj}/g_L$:
$$
\frac{dg_{x,k}}{dt} = -\frac{g_{x,k}}{\tau_x} + \sum_jW_{kj}\sum_f\delta(t - t^f_j - d)
$$
   With $x$ = AMPA ($W^E$, presynaptic pyramidal cells $j$) and $x$ = GABA$_A$ ($W^I$, presynaptic PV cells $m$), this is T5.2 with the sum over spikes written out.

9. *Explicit solution.* Multiply Step 8 by $e^{t/\tau_x}$. By the product rule,
$$
\frac{d}{dt}\left(g_{x,k}e^{t/\tau_x}\right) = e^{t/\tau_x}\sum_jW_{kj}\sum_f\delta(t - t^f_j - d)
$$
   Integrate from 0 to $t$ using the sifting property of the delta, then multiply by $e^{-t/\tau_x}$:
$$
g_{x,k}(t) = g_{x,k}(0)\,e^{-t/\tau_x} + \sum_j\sum_{f:\,0 < t^f_j + d \le t}W_{kj}\,e^{-(t - t^f_j - d)/\tau_x}
$$
   Each spike adds the kernel $W_{kj}e^{-s/\tau_x}$ for $s \ge 0$. Its time integral, the conductance area per spike, is $W_{kj}\tau_x$.

10. *Mean and variance for Poisson input (Campbell's theorem).* Suppose presynaptic cell $j$ fires as an independent Poisson process at rate $\nu_j$. Campbell's theorem gives the mean as rate times kernel integral, and the variance as rate times integral of the squared kernel:
$$
\langle g_{x,k}\rangle = \sum_j\nu_j\int_0^\infty W_{kj}e^{-s/\tau_x}ds = \tau_x\sum_jW_{kj}\nu_j
$$
$$
\mathrm{Var}(g_{x,k}) = \sum_j\nu_j\int_0^\infty W_{kj}^2e^{-2s/\tau_x}ds = \frac{\tau_x}{2}\sum_jW_{kj}^2\nu_j
$$
    The mean conductance is a weighted sum of presynaptic rates. This is the conductance-based counterpart of the rate layer's drive $G_s\sum_jW_{ij}x_{ij}r_j$, which is current-based (T1.1 Steps 5-7).

**Result.** Under A1-A6 the printed law follows exactly as the linear, instantaneous-rise limit of first-order receptor kinetics (Steps 1-8). It matches A.8, and A.6's jump-and-decay form is the same law (Step 6). Issues:

- (i) *Spike index.* The printed $\sum_jW^E_{kj}\,\delta(t - t^E_j - d)$ shows one spike time per presynaptic cell. It must be read as $\sum_j\sum_f$ (Step 8).
- (ii) *Units.* $W$ must be dimensionless, a jump in conductance relative to leak, because $g$ is dimensionless and $\delta$ is in ms$^{-1}$. No source states this.
- (iii) *Rise time.* Rise time is neglected (A3). With $\tau_{AMPA} = 1.0$ ms and $d = 0.6$ ms, any finite rise time is not small against the sub-millisecond timing the layer is meant to resolve. A finite pulse (Step 2 without the limit) gives a rise-then-decay kernel.
- (iv) *Fixed release.* Release does not change. The rate layer has Tsodyks-Markram depression (T1.9), and A.8 says Ca$^{2+}$ depletion "attenuates presynaptic release probability". Neither enters T5.2. The coupling is derived as a proposal in T5.3.
- (v) *Delay.* A.7 drops the delay and A.8 restores it.
- (vi) *Parameter status.* $\tau_{AMPA}$, $\tau_{GABA}$ and $d$ are all "assumed" and were "tuned once". They are not measured values.

**Checks.**

- *Dimensions.* $dg/dt$ and $g/\tau$ are in ms$^{-1}$. $W\delta$ is in ms$^{-1}$ only if $W$ is dimensionless.
- *Positivity.* If $W \ge 0$ and $g(0) \ge 0$, every term in Step 9 is non-negative, so $g(t) \ge 0$. T5.1 relies on this for its bounded-voltage check.
- *Boundedness.* Suppose each presynaptic cell fires at most once per refractory period $t_{ref}$. Then at most one kernel per period is added, and the peak conductance is bounded by a geometric series:
$$
g_{x,k} \le \sum_jW_{kj}\sum_{n=0}^{\infty}e^{-nt_{ref}/\tau_x} = \frac{\sum_jW_{kj}}{1 - e^{-t_{ref}/\tau_x}}
$$
- *PSP size.* For $\tau_x \ll \tau_m$, the voltage hardly moves during the conductance transient. Integrate T5.1 over the transient with $V$ held fixed:
$$
\tau_m\Delta V \approx -(V - E_x)\int g\,dt = -(V - E_x)\,W\tau_x \quad\Rightarrow\quad \Delta V \approx \frac{W\tau_x}{\tau_m}(E_x - V)
$$
  Take A.6's pathological in-cluster weight $w_{in} = 0.15$ as an AMPA jump onto a pyramidal cell ($\tau_x = 1.0$ ms, $\tau_m = 15$ ms). Each spike then moves the target by 1% of its excitatory driving force (computed here). For a driving force of 60-70 mV that is a sub-millivolt EPSP. No source states $E_e$, so the millivolt figure is illustrative.
- *Ripple period (Reconstructed PING estimate; Börgers & Kopell 2003; Brunel & Wang 2003).* Assume a deterministic, synchronous pyramidal-interneuron cycle:
    - a pyramidal volley reaches PV cells after $d$;
    - PV cells fire after a latency $\delta_I$;
    - inhibition reaches pyramidal cells at $2d + \delta_I$, with peak $g^{pk}_i$.

  By the T5.1 firing condition, a pyramidal cell with tonic excitation $g_e$ can fire again only once
$$
g_i < g^c_i = \frac{g_e(E_e - V_{th}) - (V_{th} - E_L)}{V_{th} - E_i}
$$
  Setting $g^{pk}_ie^{-s/\tau_{GABA}} = g^c_i$ gives a release time $s = \tau_{GABA}\ln(g^{pk}_i/g^c_i)$. Adding a pyramidal latency $\delta_E$, the period is
$$
T_{ripple} \approx 2d + \delta_I + \delta_E + \tau_{GABA}\ln\frac{g^{pk}_i}{g^c_i}
$$
  For 150 Hz, $T = 6.67$ ms, and $2d = 1.2$ ms, this requires $\delta_I + \delta_E + 1.5\,\mathrm{ms}\cdot\ln(g^{pk}_i/g^c_i) = 5.47$ ms. With the latencies neglected, $\ln(g^{pk}_i/g^c_i) \approx 3.6$, an inhibitory overshoot of about 38 (computed here). Under PV block the $\tau_{GABA}$ term disappears. The period is then set by the E-E loop ($d$ plus latency) and by refractoriness. This is consistent with the roughly doubled frequency A.6 reports (148 to 312 Hz). The estimate is a reconstruction. It is not in any source, and it ignores noise and heterogeneity.

**Lineage.**

- **A.6 Eq. 29** gives jump-and-decay with delay $d$, and the parameter table gives $\tau_{AMPA} = 1.0$ ms, $\tau_{GABA} = 1.5$ ms, $d = 0.6$ ms.
- **A.7 annex Eq. 29** (Model A.7 with all equations.docx) gives jump-and-decay "at each spike", without the delay.
- **A.8** (Model_A8_model only.docx; Model_A8_Scientific_Report.docx) gives the delta-driven form with delay $d$. The PDF does not print it, and no Lean file encodes it.
- **A.10 and Aleph 1** do not restate it.

**Derivation status.** Derived under approximations:

- two-state receptor kinetics (A2);
- the instantaneous-rise (brief-pulse) limit (A3);
- linear, non-saturating summation (A4);
- one fixed delay and deterministic release with no short-term or Ca$^{2+}$-dependent plasticity (A5);
- normalization by $g_L$ (A6).

The parameter values are assumed and tuned, not measured.

---

## T5.3: Extracellular Ca$^{2+}$ depletion truncating fast-ripple bursts (inherited: A.8 PDF Eq. (16); Aleph lineage: "PV depolarization block with [Ca2+]e cutoff")

**Equation as stated in the latest source.** Model_A8_Scientific_Report.pdf Eq. (16), identical in Model_A8_model only.docx and Model_A8_Scientific_Report.docx:

$$
\tau_{Ca}\frac{d[Ca^{2+}]_e}{dt} = -I_{Ca,burst} + \frac{[Ca^{2+}]_{e,0} - [Ca^{2+}]_e}{\tau_{ref}}
$$

The A.8 Lean files encode it as `dCa_dt (Ca_e I_burst) p := (1 / p.tau_Ca) * (-I_burst + (p.Ca_0 - Ca_e) / p.tau_ref)` (Model_A8_All_Equations.lean; Model_A8_All_Equations_patched.lean).

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $[Ca^{2+}]_e$ (written $c$ below) | interstitial (extracellular) free Ca$^{2+}$ of the fast-ripple generator | mM |
| $[Ca^{2+}]_{e,0}$ (written $c_0$) | resting value, 1.2 mM. A.8: "drives $[Ca^{2+}]_e$ down from 1.2 mM to < 0.6 mM" | mM |
| $I_{Ca,burst}$ | "burst-driven" Ca$^{2+}$ removal. No functional form is given in any source | mM if $\tau_{Ca}$ is a time (see Step 8) |
| $\tau_{Ca}$ | time constant. No value is given | ms (by name) |
| $\tau_{ref}$ | refill constant. No value is given. Steps 7-8 show it must be dimensionless for the printed form to be consistent | dimensionless (required) |
| $\kappa$, $R(t)$, $\tau_{rec}$ | uptake coefficient, population rate per cell, refill time (introduced here) | ms$^{-1}$, ms$^{-1}$, ms |

**Physical starting point.** A mass balance of Ca$^{2+}$ in the extracellular space (ECS) of the generator. Uptake into cells follows the Goldman-Hodgkin-Katz (GHK) flux of Ca$^{2+}$ through voltage-gated channels during spikes. Refill from surrounding tissue is by Fickian diffusion in the tortuous ECS (Nicholson & Syková 1998), reduced to its slowest eigenmode. A.8's stated purpose is that depletion "attenuates presynaptic release probability, terminating the burst naturally after 10-30 ms". The standard law for that step is the Ca$^{2+}$ cooperativity of transmitter release (Dodge & Rahamimoff 1967). It is used below for the Proposal in Step 10. Assumptions:

- A1. The generator region $\Omega$ has tissue volume $V_t$ and ECS volume $V_e = \alpha V_t$, where $\alpha$ is the ECS volume fraction. After the reduction in Step 6, its ECS is described by one mean concentration $c(t)$.
- A2. Each spike of each of the $N$ cells in $\Omega$ moves charge $Q_{Ca}$ into the cell, carried by Ca$^{2+}$ ($z = 2$). Intracellular free Ca$^{2+}$ is negligible against $c$ (of order $10^{-4}$ mM against 1 mM).
- A3. The spike waveform and the Ca$^{2+}$ permeability per spike do not depend on $c$.
- A4. Inside $\Omega$, ECS Ca$^{2+}$ diffuses with effective coefficient $D^* = D/\lambda^2$, where $\lambda$ is the tortuosity. On $\partial\Omega$ it is held at $c_0$ by the surrounding tissue, which acts as a reservoir. Cellular extrusion back into the ECS (PMCA, NCX) is linear in the deficit and lumped into the refill rate.
- A5. ECS Ca$^{2+}$ buffering is neglected. A constant buffer factor would only rescale the uptake coefficient.

**Derivation.**

1. *Amount balance (A1).* With $V_e$ constant,
$$
\frac{d(V_ec)}{dt} = -J_{up} + J_{refill} \quad\Rightarrow\quad \frac{dc}{dt} = -\frac{J_{up}}{V_e} + \frac{J_{refill}}{V_e}
$$

2. *Uptake as a spike-train sum (A2).* One spike removes $Q_{Ca}/(2F)$ moles. Let $S_k(t) = \sum_f\delta(t - t^f_k)$ be the spike train of cell $k$ and $R(t) = N^{-1}\sum_kS_k(t)$ the population rate per cell. Then
$$
J_{up} = \frac{Q_{Ca}}{2F}\sum_kS_k(t) = \frac{NQ_{Ca}}{2F}R(t)
$$

3. *Dependence of the charge on $c$ (A2, A3).* The GHK current for an ion of valence $z$ (outward positive) is
$$
I = P\frac{z^2F^2V}{RT}\cdot\frac{c_i - c\,e^{-zFV/RT}}{1 - e^{-zFV/RT}}
$$
   With $c_i \to 0$ this becomes
$$
I = -P\frac{z^2F^2V}{RT}\cdot\frac{c\,e^{-zFV/RT}}{1 - e^{-zFV/RT}}
$$
   which is exactly proportional to $c$ at every instant of a fixed waveform $V(t)$. Integrating over the spike gives
$$
Q_{Ca}(c) = q_{Ca}\frac{c}{c_0}
$$
   Here $q_{Ca}$ is the (inward) charge per spike at the resting concentration.

4. *Uptake per ECS volume.* Combine Steps 2 and 3 and divide by $V_e$:
$$
\frac{J_{up}}{V_e} = \kappa R(t)\,c, \qquad \kappa = \frac{Nq_{Ca}}{2FV_ec_0} = \frac{\rho_{cell}\,m_{Ca}}{\alpha c_0}
$$
   In the second form, $\rho_{cell} = N/V_t$ is the cell density and $m_{Ca} = q_{Ca}/(2F)$ is the moles of Ca$^{2+}$ per spike at $c_0$.

5. *Refill as diffusion (A4).* Let $u(\mathbf x, t) = c_0 - c(\mathbf x, t)$ be the local deficit and $s(\mathbf x, t) \ge 0$ the local uptake per ECS volume. Then
$$
\frac{\partial u}{\partial t} = D^*\nabla^2u + s, \qquad u = 0 \text{ on } \partial\Omega
$$
   Expand in the orthonormal Dirichlet eigenfunctions $\phi_n$ of $\Omega$ ($-\nabla^2\phi_n = k_n^2\phi_n$, $\phi_n = 0$ on $\partial\Omega$, $\int_\Omega\phi_n\phi_m = \delta_{nm}$): $u = \sum_na_n(t)\phi_n(\mathbf x)$. Multiply by $\phi_n$ and integrate over $\Omega$. Green's identity, with $u = \phi_n = 0$ on the boundary, gives $\int\phi_n\nabla^2u = -k_n^2a_n$. Hence
$$
\frac{da_n}{dt} = -D^*k_n^2\,a_n + s_n(t), \qquad s_n = \int_\Omega s\,\phi_n\,d\mathbf x
$$

6. *One-mode truncation.* Keep the slowest mode, $n = 1$. Higher modes relax $(k_n/k_1)^2$ times faster, and a source that is smooth over $\Omega$ projects mainly onto $\phi_1$. Let $\bar\phi_1 = |\Omega|^{-1}\int\phi_1$. The mean deficit is then $\bar u \approx a_1\bar\phi_1$, and multiplying the $n = 1$ equation by $\bar\phi_1$ gives
$$
\frac{d\bar u}{dt} = -\frac{\bar u}{\tau_{rec}} + \bar\phi_1 s_1, \qquad \tau_{rec} = \frac{1}{D^*k_1^2}
$$
   (A4's linear extrusion adds to $1/\tau_{rec}$.) For a source uniform over $\Omega$, $s_1 = s|\Omega|\bar\phi_1$, so $\bar\phi_1s_1 = \eta s$ with
$$
\eta = |\Omega|\,\bar\phi_1^2 = \frac{\left(\int\phi_1\right)^2}{|\Omega|\int\phi_1^2} \le 1
$$
   The bound is the Cauchy-Schwarz inequality. For a sphere of radius $R_\Omega$, $\phi_1 \propto \sin(\pi r/R_\Omega)/r$ and $k_1 = \pi/R_\Omega$. Then $\int\phi_1\,dV = 4R_\Omega^2$, $\int\phi_1^2\,dV = 2\pi R_\Omega$ and $|\Omega| = 4\pi R_\Omega^3/3$. These give
$$
\eta = \frac{16R_\Omega^4}{(4\pi R_\Omega^3/3)(2\pi R_\Omega)} = \frac{6}{\pi^2} \approx 0.61, \qquad \tau_{rec} = \frac{R_\Omega^2}{\pi^2D^*}
$$

7. *Assemble the derived law.* Use $\bar c = c_0 - \bar u$ and Step 4 for $s$, absorb $\eta$ into $\kappa$, and drop the bar (A1):
$$
\frac{dc}{dt} = -\kappa R(t)\,c + \frac{c_0 - c}{\tau_{rec}}
$$

8. *Map onto the printed form.* Multiply Step 7 by $\tau_{Ca}$:
$$
\tau_{Ca}\frac{dc}{dt} = -\tau_{Ca}\kappa R(t)\,c + (c_0 - c)\frac{\tau_{Ca}}{\tau_{rec}}
$$
   Term-by-term comparison with A.8 Eq. (16) gives
$$
I_{Ca,burst} \equiv \tau_{Ca}\,\kappa R(t)\,c, \qquad \tau_{ref} \equiv \frac{\tau_{rec}}{\tau_{Ca}}
$$
   So the printed equation is the mass balance only if $\tau_{ref}$ is a *dimensionless* ratio and $I_{Ca,burst}$ is in mM. If $\tau_{ref}$ is a time, as its name and the Lean hypothesis `0 < tau_ref` suggest, the recovery term has units mM/ms while the left side has mM. The recovery time would then be $\tau_{Ca}\tau_{ref}$, with units ms$^2$, which is inconsistent. Lean carries no units and cannot detect this. The prefactor $\tau_{Ca}$ is redundant: it can be absorbed into $I_{Ca,burst}$ and $\tau_{ref}$. **Corrected form (derived):**
$$
\frac{d[Ca^{2+}]_e}{dt} = -\kappa R(t)\,[Ca^{2+}]_e + \frac{[Ca^{2+}]_{e,0} - [Ca^{2+}]_e}{\tau_{rec}}
$$

9. *Solutions.*
    - (a) *No bursting* ($R = 0$). The equation is linear with solution
$$
c(t) = c_0 - \left(c_0 - c(t_1)\right)e^{-(t - t_1)/\tau_{rec}}
$$
      Its unique fixed point is $c_0$. This is the content of the Lean theorem `calcium_recovery_equilibrium`: `dCa_dt Ca_e 0 p = 0` implies `Ca_e = Ca_0`, using only $\tau_{Ca}, \tau_{ref} > 0$.
    - (b) *Constant rate during a burst.* Collect terms: $dc/dt = -(\kappa R + 1/\tau_{rec})c + c_0/\tau_{rec}$. Then
$$
c(t) = c^* + (c_0 - c^*)e^{-t/\tau_b}, \qquad c^* = \frac{c_0}{1 + \kappa R\tau_{rec}}, \qquad \tau_b = \frac{\tau_{rec}}{1 + \kappa R\tau_{rec}}
$$
    - (c) *General $R(t)$.* With $\Lambda(t) = \int_0^t\left(\kappa R(s) + 1/\tau_{rec}\right)ds$, the integrating factor $e^{\Lambda}$ gives
$$
c(t) = c(0)\,e^{-\Lambda(t)} + \frac{c_0}{\tau_{rec}}\int_0^te^{-(\Lambda(t) - \Lambda(s))}\,ds
$$
    - (d) *Short event, slow refill* ($t \ll \tau_{rec}$). The refill term is negligible and
$$
c(t) \approx c_0\exp\left(-\kappa\int_0^tR\,ds\right) = c_0\,e^{-\kappa\mathcal S(t)}
$$
      where $\mathcal S(t)$ is the number of spikes per cell since burst onset. Reaching $c_0/2$ (A.8's "< 0.6 mM") needs $\kappa\mathcal S = \ln 2$. With Step 4, the Ca$^{2+}$ moved per spike must be
$$
m_{Ca} = \frac{\alpha c_0\ln 2}{\rho_{cell}\,\mathcal S_{1/2}}
$$
      This is a testable requirement. No source supplies $\alpha$, $\rho_{cell}$ or $m_{Ca}$.

10. *Release-probability coupling (Proposal; Dodge & Rahamimoff 1967).* A.8's mechanism needs $c$ to reach the synapses of T5.2, but no equation does this. The Dodge-Rahamimoff law gives release $\propto \left[c/(1 + c/K_1 + [Mg^{2+}]/K_2)\right]^4$. Normalized to rest:
$$
\psi(c) = \left(\frac{c}{c_0}\right)^4\left(\frac{1 + c_0/K_1 + [Mg^{2+}]/K_2}{1 + c/K_1 + [Mg^{2+}]/K_2}\right)^4, \qquad W^E_{kj}(t) = W^E_{kj,0}\,\psi(c(t))
$$
    In the low-Ca$^{2+}$ limit ($c, c_0 \ll K_1$), $\psi \approx (c/c_0)^4$. Halving $c$ from 1.2 to 0.6 mM then cuts recurrent excitation 16-fold (computed here). Suppose the sprouted E-E loop sustains firing only while its loop gain $G_0\psi(c) \ge 1$. The burst then ends at $c_{end} = c_0G_0^{-1/4}$. By 9(d) that happens after
$$
\mathcal S_{end} = \frac{\ln(c_0/c_{end})}{\kappa} = \frac{\ln G_0}{4\kappa}
$$
    spikes per cell. A.8's end point of 0.6 mM corresponds to $G_0 = 16$. $K_1$, $K_2$ and $G_0$ appear in no source. The exponent 4 is the neuromuscular-junction value.

11. *Cluster heterogeneity (Proposal).* A.8 says depletion "fractionat[es] the population into out-of-phase clusters". A single scalar $c$ acts identically on every synapse, so by itself it cannot desynchronize clusters. A.7's to-do list asked for "heterogeneous extracellular calcium pool depletion" (Model A.7 with all equations.docx). A consistent version gives each cluster $m$ its own pool, coupled to its neighbours by diffusive exchange with time constant $\tau_x$:
$$
\frac{dc_m}{dt} = -\kappa_mR_m(t)\,c_m + \frac{c_0 - c_m}{\tau_{rec}} + \sum_{m'}\frac{c_{m'} - c_m}{\tau_x}
$$

**Result.** The printed equation has the structure of an ECS Ca$^{2+}$ mass balance with first-order refill. The refill term is derived here as the one-mode reduction of diffusion to a reservoir (Steps 5-6). As printed, the equation is incomplete and dimensionally ambiguous:

- (i) *Uptake.* $I_{Ca,burst}$ is never specified. The derived closure is $I_{Ca,burst} = \tau_{Ca}\kappa R(t)[Ca^{2+}]_e$: proportional to the population rate and, by GHK, to $[Ca^{2+}]_e$ itself (Step 3).
- (ii) *Units.* $\tau_{ref}$ must be dimensionless, or else $\tau_{Ca}$ must be dropped. The corrected form is in Step 8.
- (iii) *Release coupling.* The coupling to release probability, which is the whole point of the mechanism, exists only in prose. The Proposal is in Step 10.
- (iv) *Clusters.* A single pool cannot produce cluster fractionation (Step 11).
- (v) *Ledgers.* Ca$^{2+}$ entry is booked in no ledger. Extrusion by NCX imports 3 Na$^+$ per Ca$^{2+}$, which would add to the Na$^+$ ledger (T1.18). Extrusion by PMCA costs 1 ATP per Ca$^{2+}$, which would add to demand (T3.3).
- (vi) *Calibration.* The reported 22.4 ms event and 2.75 ms lag are simulation outputs of an unspecified closure, so they cannot be checked against the equation.

**Checks.**

- *Dimensions.* In the corrected form, $dc/dt$, $\kappa Rc$ and $(c_0 - c)/\tau_{rec}$ are all in mM/ms. For the printed form see Step 8.
- *Positivity.*
    - *Printed form.* Take any uptake that does not vanish at $c = 0$. At $c = 0$ the printed form gives $\tau_{Ca}\,dc/dt = -I_{Ca,burst} + c_0/\tau_{ref}$, which is negative whenever $I_{Ca,burst} > c_0/\tau_{ref}$. So $[Ca^{2+}]_e$ can become negative, and $[0, \infty)$ is not forward-invariant.
    - *Derived form.* At $c = 0$, $dc/dt = c_0/\tau_{rec} > 0$. At $c = c_0$, $dc/dt = -\kappa Rc_0 \le 0$. By Nagumo's theorem $[0, c_0]$ is forward-invariant. This is the same boundary-sign argument used for the Na$^+$ ledger (T1.18).
- *Fixed point without bursting.* $c^* = c_0$ (Step 9a), which agrees with the Lean theorem.
- *Limits.*
    - $\tau_{rec} \to \infty$ (closed pocket): $c$ decays exponentially in the spike count (9d) and never recovers.
    - $\tau_{rec} \to 0$ (fast exchange, e.g. a well-perfused thin slice): $c \equiv c_0$ and the truncation mechanism disappears.
- *Refill time scale (illustrative).* Use free Ca$^{2+}$ diffusion of about $0.79\times10^{-9}$ m$^2$/s and a tortuosity of about 1.6 (Nicholson & Syková 1998). Then $D^* \approx 3.1\times10^{-10}$ m$^2$/s. For a spherical generator of radius 100 µm, Step 6 gives $\tau_{rec} = R_\Omega^2/(\pi^2D^*) \approx 3.3$ s. This is two orders of magnitude longer than a 22.4 ms event. So during an event the pool behaves as closed (9d), and recovery takes seconds.
- *Cluster-lag consistency.* If two clusters alternate, the population period equals the inter-cluster lag. A lag of 2.75 ms implies about 364 Hz (computed here), against A.8's reported 342 ± 18 Hz. That is within about 1.2 SD.
- *Where the depletion happens.* Activity-dependent Ca$^{2+}$ depletion on millisecond time scales is documented inside the synaptic cleft (Rusakov & Fine 2003). Bulk ECS falls of the size A.8 quotes are reported during sustained paroxysmal activity (Heinemann, Lux & Gutnick 1977). No source shows that a 50% bulk fall can develop within one 10-30 ms event; Step 9(d) gives the Ca$^{2+}$ uptake per spike that this would need. A cleft-local pool is therefore a more natural substrate for 10-30 ms truncation than the bulk pool that A.8's wording ("interstitial") implies. The equation has the same form in both cases, but $V_e$, and with it $\kappa$, differ by orders of magnitude.

**Lineage.**

- **A.6** (Sec. 9): fast ripples were "seizure-like (about 270 Hz sustained over the 90 ms window)". A.6 asked A.7 for "heterogeneous cluster excitability and 10-30 ms pathological events".
- **A.7.**
    - Model A.7 Upgrade Doc (gemini).docx says A.7 introduced "heterogeneous cellular excitability and precise spatial transmission delays" against hypersynchrony. It adds that "A.8 must incorporate dynamic, activity-dependent depletion of the extracellular calcium pool".
    - Model A.7 with all equations.docx says A.8 "must introduce heterogeneous extracellular calcium pool depletion".
    - A.8's own lineage table reports A.7's cluster lag as 0.18 ms ("hypersync"). That conflicts with the Upgrade Doc's claim that A.7 fixed hypersynchrony.
- **A.8.** Eq. (16) (PDF; both docx files) introduces the equation. The scorecard reports a 22.4 ms event duration and a 2.75 ms cluster lag. The Lean files add `dCa_dt` and `calcium_recovery_equilibrium`. The unpatched file labels the latter "THEOREM 5.1: Extracellular Calcium Recovery Under Zero Bursting".
- **A.9.** The AQP4 degradation tensor (T6.19) is gated by $\mathcal H([Ca^{2+}]_e - Ca_{thresh})$. Depletion lowers $[Ca^{2+}]_e$, so this gate switches degradation *off* during depleting bursts. The Tier 6 derivation should check that sign.
- **A.10.** Prose only: "pathological fast ripples (340 Hz) truncated by interstitial calcium depletion d[Ca2+]e/dt".
- **Aleph 1.** Lineage table: "CA1 PV depolarization block with [Ca2+]e cutoff" (A.8 column) and "non-divergent seizure truncation" (A.10 column).

**Derivation status.** Incomplete in source.

- *Derived under approximations:* the balance structure, namely a well-mixed ECS pool, GHK uptake with negligible internal Ca$^{2+}$, and a one-mode diffusive refill to a fixed reservoir (Steps 1-8).
- *Phenomenological:* that depletion truncates bursts. The coupling to release is not in any equation, and the Dodge-Rahamimoff closure in Step 10 is a proposal.
- *Supplied here:* the uptake law, the dimensional correction and the per-cluster generalization.

---

## T5.4: PV interneuron depolarization block rule (claimed: Aleph Sec. 2 lineage table, "CA1 PV depolarization block")

**Equation as stated in Aleph 1 or any earlier source.** **NOT STATED IN ANY SOURCE.**

**What the sources say.**

- *A.6.* Eq. 30 reads "pathology = PV cells in depolarisation block + recurrent E-E clusters". The parameter table lists "PV: depolarisation block" as an assumed pathology setting. The development log (item 7) explains the choice: "Weakening PV synapses made PV cells fire at about 600-900 Hz. Schlingloff 2025 shows PV cells *stop* firing (depolarisation block), so PV block replaced weight reduction." Validation 4 runs "PV block only", "PV block + sprouting" and similar as experimental conditions.
- *A.7 and A.8.* They repeat the mechanism in prose: "Triggered when parvalbumin basket cells enter depolarization block". Neither gives a rule saying when a PV cell is blocked or what a blocked cell does.
- *Aleph 1.* The lineage table names "CA1 PV depolarization block with [Ca2+]e cutoff".
- *Rate layer.* The only block formula in the whole model is the rate layer's Na$^+$-fatigue gate $[1 + (n_i/n_c)^6]^{-1}$ (T1.20).

In the sources, then, "PV block" is a scenario switch set by the modeller and not a dynamical rule.

**Symbols and units** (for the proposals below; none of these symbols appear in any source).

| Symbol | Meaning | Units |
|---|---|---|
| $h_k$ | Na$^+$-channel availability (inactivation gate) of PV cell $k$ | dimensionless, in $[0, 1]$ |
| $h_\infty(V)$ | steady-state availability, $[1 + e^{(V - V_h)/k_h}]^{-1}$ | dimensionless |
| $V_h$, $k_h$ | half-inactivation voltage and slope | mV |
| $\tau_h$ | inactivation time constant | ms |
| $h_{crit}$ | minimum availability for a regenerative spike | dimensionless |
| $b_k$ | binary lesion switch | $\lbrace 0, 1\rbrace$ |
| $n_k$ | per-cell Na$^+$ load (from T5.5) | mM |

**Physical starting point.** Depolarization block is the failure of spike generation under sustained depolarization. The cause is steady-state inactivation of voltage-gated Na$^+$ channels: the Hodgkin-Huxley $h$ gate. In bifurcation terms, the limit cycle disappears at high input. An analysis for CA1 cells is Bianchi et al. 2012. The LIF membrane of T5.1 omits the Na$^+$ current (T5.1 A4), so it cannot express this mechanism. Step 1 below proves that. Assumptions for the proposals:

- A1. Na$^+$ activation $m$ is fast and inactivation $h$ is slow on the time scale of the spike upstroke (the fast-slow reduction of Hodgkin-Huxley).
- A2. During slow depolarization, $h$ tracks $h_\infty(\bar V)$ with time constant $\tau_h$.
- A3. A spike can start only if the membrane has a region of negative slope conductance near threshold.

**Derivation (Proposal).**

1. *Theorem: the LIF of T5.1 cannot block.* Take constant drive with $V_\infty > V_{th}$. T5.1 Step 10 gives the interspike interval $t_{ref} + T$ with $T(V_\infty) = \tau_{eff}\ln[(V_\infty - V_{reset})/(V_\infty - V_{th})]$. Differentiate at fixed $\tau_{eff}$:
$$
\frac{dT}{dV_\infty} = \tau_{eff}\left[\frac{1}{V_\infty - V_{reset}} - \frac{1}{V_\infty - V_{th}}\right] = \tau_{eff}\frac{V_{reset} - V_{th}}{(V_\infty - V_{reset})(V_\infty - V_{th})} < 0
$$
   The sign follows because $V_{reset} < V_{th} < V_\infty$. So $T$ falls monotonically, and $T \to \tau_{eff}\ln 1 = 0$ as $V_\infty \to \infty$. If the drive is raised through $g_e$, $\tau_{eff} = \tau_m/(1 + g_{tot})$ also falls, which only shortens $T$ further. The rate $1/(t_{ref} + T)$ therefore rises monotonically towards $1/t_{ref}$ and never falls to zero. This is consistent with A.6's observation that weakened PV cells fired at 600-900 Hz. A block rule has to be *added* to the LIF.

2. *Spike condition with Na$^+$ availability (A1, A3; Reconstructed from Hodgkin & Huxley 1952).* Near threshold, with $h$ frozen, the steady-state membrane current is $I_{ss}(V) = g_L(V - E_L) + g_K(V)(V - E_K) + \bar g_{Na}\,h\,m_\infty(V)^3(V - E_{Na})$. Its slope conductance is
$$
G_{slope}(V; h) = g_L + G_K(V) - h\,\Psi(V), \qquad \Psi(V) = -\bar g_{Na}\left[3m_\infty^2m_\infty'(V - E_{Na}) + m_\infty^3\right]
$$
   Here $G_K = d[g_K(V - E_K)]/dV$, and $\Psi > 0$ wherever Na$^+$ activation is regenerative, because $V - E_{Na} < 0$. A3 requires $G_{slope} < 0$ for some $V$, that is $h\,\Psi(V) > g_L + G_K(V)$. This holds if and only if
$$
h > h_{crit} \equiv \min_{V:\,\Psi(V) > 0}\frac{g_L + G_K(V)}{\Psi(V)}
$$

3. *Block voltage (A2).* Under sustained depolarization $\bar V$, $h \to h_\infty(\bar V)$, and the cell blocks once $h_\infty(\bar V) < h_{crit}$. Solve $h_\infty(V) = h_{crit}$:
$$
\frac{1}{1 + e^{(V - V_h)/k_h}} = h_{crit} \quad\Rightarrow\quad e^{(V - V_h)/k_h} = \frac{1}{h_{crit}} - 1 \quad\Rightarrow\quad V_{block} = V_h + k_h\ln\left(\frac{1}{h_{crit}} - 1\right)
$$
   For $h_{crit} < 1/2$, $V_{block} > V_h$.

4. *Proposal P1: availability-gated LIF for PV cells.* Add one slow state per PV cell and make the spike rule depend on it. The guard is a state condition, not a crossing condition. When $h_k$ recovers while $V_k$ is still above threshold, the cell then fires and resets, which is the exit from block.
$$
\tau_h\frac{dh_k}{dt} = h_\infty(V_k) - h_k
$$
   The spike rule:
    - *Spike:* if $V_k \ge V_{th}$ **and** $h_k \ge h_{crit}$, emit a spike, reset to $V_{reset}$ and apply the refractory period. Optionally, use-dependent inactivation lowers availability at each spike: $h_k \to (1 - \epsilon_h)h_k$.
    - *Block:* if $V_k \ge V_{th}$ and $h_k < h_{crit}$, emit no spike and apply no reset. $V_k$ continues under T5.1 towards $V_\infty$, so the cell sits on a depolarized plateau with no output.

5. *Proposal P2: reuse the rate layer's Na$^+$ gate.* Give each PV cell a Na$^+$ load $n_k$ updated by T5.5. Then let each threshold crossing produce a transmitted spike with probability $[1 + (n_k/n_c)^6]^{-1}$ (T1.20). T5.5 shows that the load per spike is $\nu_{spk} = \epsilon\,c_m\,\Delta V\,(A/Vol)/F$. Without pumping, the number of spikes needed to reach $n_c = 4$ mM is $n_c/\nu_{spk}$. With $c_m = 1$ µF/cm$^2$, $\Delta V = 100$ mV and $\epsilon = 1$ (illustrative):
    - a 10 µm-radius soma needs about 1300 spikes;
    - a 0.5 µm-radius process needs about 97 spikes.

   With the largest overlap factor, $\epsilon = 4$ (T5.5 A2), the counts fall to about 320 and 24. A fast-ripple event has 6-25 spikes per cell (T5.5). P2 could therefore act within one event only in thin processes with a large overlap factor. At somatic geometry it needs 13 to 200 events' worth of spikes. It is essentially a seconds-scale mechanism, suited to the rate layer, where it already sits.

6. *Proposal P3: lesion switch (what A.6 implemented).* Set $b_k \in \lbrace 0, 1\rbrace$ per PV cell as a scenario parameter. Outgoing inhibitory events are multiplied by $(1 - b_k)$, so in T5.2 $W^I_{\cdot k} \to (1 - b_k)W^I_{\cdot k}$. This reproduces "PV block only" and "PV block + sprouting" as lesion conditions, but not as dynamics.

**Result.** No source states a block rule. Step 1 shows that the T5.1 LIF can never block on its own, so some rule is required. P1 follows from Hodgkin-Huxley Na$^+$ inactivation (Steps 2-3). It is the only one of the three proposals that can act within a 10-30 ms event at any cell geometry. P2 is too slow except in thin processes with a large overlap factor (Step 5). P3 is a scenario switch that matches A.6's simulations.

**Checks.**

- *Dimensions.* $h$, $h_\infty$ and $h_{crit}$ are dimensionless. $V_{block}$ is in mV because $k_h\ln(\cdot)$ is in mV.
- *Limits of P1.*
    - $h_{crit} \to 0$: $V_{block} \to \infty$, so there is no block and the plain LIF is recovered.
    - $\tau_h \to 0$: block is instantaneous at $V_{block}$.
    - $\tau_h \to \infty$: availability is frozen, so there is no block.
- *Consistency with T5.1.* A blocked cell does not reset. Its voltage is then bounded by $V_\infty \le E_e$ (T5.1 checks), so P1 cannot produce divergence.
- *Consistency with T5.3.* A.8 calls the Aleph tier "PV block with [Ca2+]e cutoff". Under P1 the block is set by PV depolarization, and the Ca$^{2+}$ cutoff acts on excitatory release (T5.3 Step 10). The two are independent mechanisms that act in sequence.

**Lineage.**

- **A.5.** Fast ripples were attributed to channel noise (caveat 4).
- **A.6.** Eq. 30 states the PV-block pathology in words; the development log records the replacement of weight reduction by "PV block".
- **A.7.** Eq. 30 is unchanged.
- **A.8.** Text only, citing Schlingloff 2025.
- **A.10.** Silent.
- **Aleph 1.** Lineage-table name only.
- **Rate layer.** The Na$^+$-fatigue gate (A.2 onwards, T1.20) is described by A.8 as depolarization block "due to loss of the sodium reversal gradient". It is a different mechanism from PV block in the spiking layer.

**Derivation status.** Incomplete in source; not stated anywhere. P1 is a proposal derived from Hodgkin-Huxley inactivation under a fast-slow reduction. P2 and P3 are proposals. P2 is shown to be too slow for the purpose except in extreme geometry.

---

## T5.5: Per-spike Na$^+$ load linking spiking events to the sodium ledger (inherited: A.7 annex Eq. 30 / A.6 Eq. 30)

**Equation as stated in the latest source.** A.7 annex Eq. 30 (Model A.7 with all equations.docx), "Spiking Na+ load mechanism sharing ledger with Eq. 5":

$$
\Delta n_i = \nu_{spk}\quad\text{per spike}
$$

A.6 Eq. 30 states it as "every spike adds $\nu_{spk}$ to $n$ (Eq. 5)". A.8 does not restate the event rule. It gives the capacitive basis of $\nu_{spk}$ in its Inference 1 (Model_A8_Scientific_Report.docx):

$$
\Delta n_{spk} = \frac{C_{membrane}(V_{peak} - V_{rest})}{F\cdot Vol_i}\left(1 - \frac{n_i}{n_{eq}}\right)
$$

A.8 also gives a fast-ripple load of "$\Delta n_i \approx 25\,\nu_{spk}$ per event (30× the sodium load of a normal ripple)" (Inference 2).

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $\Delta n_i$ | increment of the Na$^+$ ledger (T1.18) per spike | mM |
| $\nu_{spk}$ | Na$^+$ load per spike as a concentration. No value is given in any source | mM |
| $C_{membrane}$ ($C_m$) | total membrane capacitance of the cell | F |
| $c_m$, $A$ | specific capacitance and membrane area, $C_m = c_mA$ (introduced here) | F/m$^2$, m$^2$ |
| $V_{peak}$, $V_{rest}$ | spike peak and resting potential; $\Delta V = V_{peak} - V_{rest}$ | mV |
| $F$ | Faraday constant, 96485 C/mol | C/mol |
| $Vol_i$ | intracellular volume receiving the Na$^+$ | L |
| $n_i$, $n_{eq}$ | Na$^+$ load and its "electrochemical equilibrium" bound (12 mM) | mM |
| $\epsilon$ | overlap factor, Na$^+$ entry divided by the capacitive minimum, $\ge 1$ (introduced here) | dimensionless |

**Physical starting point.** Charge conservation on the membrane capacitor (the capacitive minimum Na$^+$ entry per action potential; Attwell & Laughlin 2001; Alle, Roth & Geiger 2009). It is combined with a Na$^+$ amount balance in a well-mixed volume (T1.18 Step 1). Assumptions:

- A1. The spike charges the whole membrane area $A$ from $V_{rest}$ to $V_{peak}$, and the charge is carried by Na$^+$ ($z = 1$).
- A2. Na$^+$ and K$^+$ currents overlap during the spike, so the actual Na$^+$ entry is $\epsilon \ge 1$ times the capacitive minimum. Measured values range from about 1.3 (hippocampal mossy-fibre axons; Alle et al. 2009) to about 4 (the squid-axon value used by Attwell & Laughlin 2001).
- A3. The Na$^+$ mixes instantly in $Vol_i$.
- A4. The driving-force factor $(1 - n/n_{eq})$ of T1.18 applies to spike influx.

**Derivation.**

1. *Capacitive charge (A1).* A capacitor's charge changes by $C\,\Delta V$ when its voltage changes by $\Delta V$:
$$
Q_{min} = C_m(V_{peak} - V_{rest})
$$

2. *Convert to moles (A1, A2).* Divide by $zF$ with $z = 1$ and include the overlap factor:
$$
N_{Na} = \frac{\epsilon\,Q_{min}}{F}
$$

3. *Convert to concentration (A3).* Divide by $Vol_i$:
$$
\nu_{spk} = \frac{N_{Na}}{Vol_i} = \frac{\epsilon\,C_m(V_{peak} - V_{rest})}{F\,Vol_i}
$$
   With $\epsilon = 1$ this is A.8's capacitive formula without the driving-force factor.

4. *Geometric form.* Write $C_m = c_mA$:
$$
\nu_{spk} = \frac{\epsilon\,c_m\,\Delta V}{F}\cdot\frac{A}{Vol_i}
$$
   The load per spike is set by the surface-to-volume ratio. A sphere of radius $r$ has $A/Vol = 3/r$, and a long cylinder of radius $a$ has $A/Vol = 2/a$. Illustrative values, with $c_m = 0.01$ F/m$^2$ (1 µF/cm$^2$), $\Delta V = 0.1$ V and $\epsilon = 1$:
    - sphere, $r = 10$ µm: $3 \times 0.01 \times 0.1/(96485 \times 10^{-5}) = 3.1\times10^{-3}$ mol/m$^3$ = 3.1 µM per spike;
    - cylinder, $a = 0.5$ µm: $2 \times 0.01 \times 0.1/(96485 \times 5\times10^{-7}) = 4.1\times10^{-2}$ mol/m$^3$ = 41 µM per spike.

5. *Driving-force factor (A4).* A.8 multiplies by $(1 - n_i/n_{eq})$. T1.18 Steps 5-6 show that this factor is exact for a GHK flux at a fixed voltage waveform. In the capacitive picture it is a surrogate: the charge needed for a given $\Delta V$ does not depend on $n$. What actually changes as $E_{Na}$ falls is $\Delta V$, because the spike overshoot is capped by $E_{Na}(n)$. The factor stands in for that shrinkage of the spike.

6. *Event form and the jump rule.* The microscopic ledger with a spike train $S(t) = \sum_f\delta(t - t^f)$ is
$$
\frac{dn}{dt} = \nu_{spk}\left(1 - \frac{n}{n_{eq}}\right)S(t) - \Pi + (\text{other T1.18 terms})
$$
   The delta multiplies a function of $n$, so the jump must be defined. The rule consistent with the continuous flow integrates the flow through the impulse; this is the Marcus interpretation. Over unit pseudo-time $\sigma$, solve $dn/d\sigma = \nu_{spk}(1 - n/n_{eq})$. This is linear in $(n_{eq} - n)$:
$$
\frac{d(n_{eq} - n)}{d\sigma} = -\frac{\nu_{spk}}{n_{eq}}(n_{eq} - n) \quad\Rightarrow\quad n_{eq} - n(\sigma) = (n_{eq} - n^-)e^{-\nu_{spk}\sigma/n_{eq}}
$$
   At $\sigma = 1$:
$$
n^+ = n_{eq} - (n_{eq} - n^-)\,e^{-\nu_{spk}/n_{eq}}
$$
   Expand $e^{-x} = 1 - x + x^2/2 - \ldots$ with $x = \nu_{spk}/n_{eq}$:
$$
n^+ = n^- + \nu_{spk}\left(1 - \frac{n^-}{n_{eq}}\right) + O\left(\frac{\nu_{spk}^2}{n_{eq}}\right)
$$
   To first order this is A.8's formula. Because $e^{-x} > 0$, $n^- < n_{eq}$ implies $n^+ < n_{eq}$, so the event rule preserves the forward invariance of $[0, n_{eq}]$ proved for T1.18. The plain additive rule of A.6 and A.7, $n^+ = n^- + \nu_{spk}$, does not: it overshoots $n_{eq}$ whenever $n^- > n_{eq} - \nu_{spk}$.

7. *Averaging to the rate form.* Take a window $\Delta$ that is longer than the interspike interval but short compared with the time over which $n$ changes appreciably. Let it contain $\mathcal S$ spikes. Summing the jumps of Step 6 and integrating the pump term:
$$
\Delta n \approx \nu_{spk}\left(1 - \frac{n}{n_{eq}}\right)\mathcal S - \Pi\Delta
$$
   Divide by $\Delta$ and use $\mathcal S/\Delta \to r$:
$$
\frac{dn}{dt} \approx \nu_{spk}\,r\left(1 - \frac{n}{n_{eq}}\right) - \Pi
$$
   This is the spike term of T1.18. The event rule and the rate ledger therefore share one constant $\nu_{spk}$, provided the spike and the ledger refer to the same cell volume.

8. *Index mapping and aggregation.* The event rule is written for $n_i$, a rate-layer node, while spikes are indexed by CA1 cell $k$. Suppose node $i$ aggregates $N$ cells, each of volume $v_c$, so that $Vol_i = Nv_c$, and let each cell's spike raise its own load by $\nu_c$. The node mean $\bar n = N^{-1}\sum_kn_k$ then obeys
$$
\frac{d\bar n}{dt} = \frac{\nu_c}{N}\sum_k\left(1 - \frac{n_k}{n_{eq}}\right)S_k(t) - \bar\Pi \approx \nu_c\,\bar r\left(1 - \frac{\bar n}{n_{eq}}\right) - \bar\Pi
$$
   where the last step takes $n_k \approx \bar n$. Each single spike therefore adds $\nu_c/N$, not $\nu_{spk}$, to an aggregated node. "Every spike adds $\nu_{spk}$ to $n$" is correct only for per-cell ledgers. No source says which applies.

9. *ATP cost per spike (T1.19, T3.3).* The pump exports 3 Na$^+$ per ATP. In the same volume, the ATP needed to clear one spike is $\nu_{spk}/3$, which is the event version of the $\Pi/3$ demand in T3.3.

**Result.** The event rule follows from the capacitive minimum charge and an overlap factor (Steps 1-4). It is the microscopic form of T1.18's $\nu_{spk}r_i$ term (Step 7). Issues:

- (i) *Jump rule.* The A.6/A.7 additive rule breaks the $[0, n_{eq}]$ invariance. The Marcus jump of Step 6 keeps it and agrees with A.8's formula to first order.
- (ii) *Aggregation.* The cell-to-node mapping is unstated (Step 8).
- (iii) *Driving force.* In the capacitive picture the factor $(1 - n/n_{eq})$ is a surrogate for shrinking spike amplitude (Step 5).
- (iv) *No value.* No source gives a value for $\nu_{spk}$ or for the geometry that would fix it.
- (v) *Fast-ripple load is inconsistent with A.8's event length.* A.6 measured 25 spikes per pyramidal cell over a 90 ms seizure-like event, at about 270 Hz. A.8 keeps "$\Delta n_i \approx 25\,\nu_{spk}$ per event" but says Ca$^{2+}$ depletion cut the event to 22.4 ms. Twenty-five spikes in 22.4 ms means 1.1 kHz per cell (computed here), above any plausible $1/t_{ref}$. At A.6's 270 Hz a 22.4 ms event has about $270 \times 0.0224 \approx 6$ spikes, so the load would be about $6\,\nu_{spk}$ (computed here). Either way the "25" looks carried over unchanged from A.6.

**Checks.**

- *Dimensions.* $C\,\Delta V/(F\,Vol)$ has units (C/V)·V/((C/mol)·L) = mol/L. The geometric form has units (F/m$^2$)·V·(1/m)/(C/mol) = mol/m$^3$, which is mM.
- *Limits.*
    - $n \to n_{eq}$: $\Delta n \to 0$ (Step 6). The ledger saturates.
    - $\epsilon = 1$: the thermodynamic minimum.
    - $\Delta V \to 0$: no load.
- *Ripple vs fast ripple.* A.6 gives 0.79 spikes per pyramidal cell per ripple and 25 per fast ripple. The ratio is 31.6 (computed here), which matches the "about 30×" of A.6 and A.8 Inference 2.
- *Energetic scale (illustrative).* With the Step 4 values and 25 spikes per event, the ATP needed to clear one event is $25\nu_{spk}/3$:
    - for the 10 µm soma, about 26 µM, about 1% of $a_0 = 2.5$ mM;
    - for 0.5 µm processes, about 0.35 mM, about 14% of $a_0$.

  Whether a single event visibly dips ATP, as A.8 Inference 2 claims, therefore depends on geometry that no source specifies.
- *A.8 pigeon branch.* A.8 scales $C_{membrane} \propto k_{syn}^{2/3}$ and quotes $(1750/10000)^{2/3} = 0.313$ (verified: 0.3129). That factor applies to the *moles* per spike, i.e. the energy per spike. The ledger increment $\Delta n = C\Delta V/(F\,Vol)$ also depends on $Vol$. Under the same compact-geometry assumption, $A \propto Vol^{2/3}$ with $Vol \propto k_{syn}$, the concentration increment scales as $k_{syn}^{2/3}/k_{syn} = k_{syn}^{-1/3}$. For the pigeon that is $0.175^{-1/3} = 1.79$, an *increase* (computed here). A.8 also multiplies 0.313 by the thermal pump factor $2.1^{0.42} = 1.365$ to get "net sodium debt per spike ... 0.427". A faster pump does not change the Na$^+$ entering per spike. It shortens the time the debt persists, so the product has no meaning as a per-spike debt. If the intended quantity were debt-time per spike, the factor would be $0.313/1.365 = 0.229$ (computed here).

**Lineage.**

- **Model A.** No Na$^+$ state. Energy appears as $P_{ATP} \approx \Delta G_{ATP}/(3q_e)\lvert I_{Na}\rvert$ (Model_A_Changelog_Audit_and_Fixes.md).
- **A.2.** $\nu_{spk}r$ enters the Na$^+$ ledger (T1.18).
- **A.6.** Eq. 30: "every spike adds $\nu_{spk}$ to $n$". Validation 4 gives 25 spikes per cell per fast ripple against 0.8 per ripple, and "about 30× the Na$^+$ load and pump ATP".
- **A.7.** Annex Eq. 30: $\Delta n_i = \nu_{spk}$.
- **A.8.** Inference 1 gives the capacitive formula with $(1 - n/n_{eq})$ and the pigeon scaling. Inference 2 gives "25 $\nu_{spk}$ per event, 30×" (docx), and the PDF has "30-fold sodium debt".
- **A.10 and Aleph 1.** Not restated. The Na$^+$ ledger is inherited.

**Derivation status.** Derived under approximations:

- capacitive minimum charge times an overlap factor (A1, A2);
- one well-mixed volume (A3);
- the GHK driving-force factor used as a surrogate for spike-amplitude loss (A4);
- the Marcus interpretation of the multiplicative jump.

Incomplete in source:

- no value of $\nu_{spk}$;
- unstated mapping from cell to node;
- a fast-ripple load inconsistent with A.8's own event duration.

---

## T5.6: Apoptotic node eviction rule (inherited: Aleph Sec. 2 lineage table, A.9 "apoptotic eviction protocol")

**Equation as stated in Aleph 1.** In the lineage table of Model_Aleph_1_only equations.docx and Model_Aleph_1_Comprehensive_Scientific_Report.docx, A.9 column: "Added apoptotic node eviction protocol: excises degenerate nodes (a_i < 0.05 a0) without crash." As an equation:

$$
a_i < 0.05\,a_0 \;\Rightarrow\; \text{node } i \text{ is evicted}
$$

A.10 describes the same protocol differently: "Permanently depolarized nodes undergo graceful apoptotic eviction, preventing numerical divergence" (Model_A10_Comprehensive_Scientific_Report.docx). A.9 names "a graceful apoptotic eviction protocol" but gives no criterion (Model_A9_changes from a8.docx).

**Symbols and units.**

| Symbol | Meaning | Units |
|---|---|---|
| $a_i$ | neuronal ATP of node $i$ (T3.2) | mM |
| $a_0$ | baseline (rest) ATP, 2.5 mM (A.6) | mM |
| $\theta_{ev}$ | eviction fraction, 0.05 (named here) | dimensionless |
| $\mathcal A(t)$ | set of nodes alive at time $t$ (introduced here) | - |
| $t_e$ | eviction time of a node | s |
| $D_0$ | rest ATP demand, $D_{set}$ at $a_0$ (T3.3) | mM/s |
| $K_{aD}$, $K_a$ | demand and pump ATP constants, 0.5 and 0.15 mM (A.6, A.8) | mM |
| $T_d$ | dwell time for the proposed trigger (introduced here) | s |

**Physical starting point.** No source derives the rule, and none could: it is an event rule of a hybrid dynamical system (state-dependent switching; Goebel, Sanfelice & Teel 2009). The biological motivation is energy failure, which leads to loss of ion gradients and then to cell death. Model_Aleph_Equation_Derivations_GPT.docx Sec. 6.2 states the requirements: such a rule "must specify a biologically motivated death criterion, a threshold, hysteresis, and conservation of network bookkeeping after removal". Only the threshold is in the sources. The rest is derived or proposed below. Assumptions:

- A1. Eviction is irreversible: an evicted node never returns.
- A2. The fraction 0.05 is a parameter and cannot be derived.
- A3. For the time-to-threshold estimate: substrate supply is zero, so there is no glycolytic or oxidative ATP production. The CK/PCr buffer is neglected. $D_{set}$ is held at its rest value $D_0$, so $D = D_0\,m(a, K_{aD})/m(a_0, K_{aD})$ (T3.3).
- A4. For the bookkeeping, two cases are covered: (a) a node is a neuron whose ATP and Na$^+$ are its own, inside a voxel whose substrate pools are shared; (b) a node is a whole voxel that carries its own pools.

**Derivation.**

*Part A. Formal rule and its reachability.*

1. *Hybrid-system statement (Proposal; GPT Sec. 6.2 requirements).* The rule has three parts:
    - *Flow set.* $C = \lbrace x : a_i > \theta_{ev}a_0\ \ \forall i \in \mathcal A\rbrace$. On $C$ the model's ODEs and SDEs run unchanged.
    - *Jump set for node $i$.* $D_i = \lbrace x : a_i \le \theta_{ev}a_0\rbrace$.
    - *Jump map (A1).* $\mathcal A^+ = \mathcal A^- \setminus \lbrace i\rbrace$. Every per-node state of $i$ is deleted: $v_i$, $n_i$, $a_i$, $w_i$, $\theta_i$, $L_i$, $x_i$, $g_{AIS,i}$ and so on. All weights $W_{ij}$ and $W_{ji}$ are set to zero. Node $i$ is removed from every sum over nodes: the neurovascular source (T2.1), the territory headroom (T6.5) and, if the node is an electrically coupled PV cell, the gap-junction Laplacian (Step 12).

2. *ATP decay under zero supply (A3).* Let $K = K_{aD}$ and $m_0 = m(a_0, K) = a_0/(a_0 + K)$. Then
$$
\frac{da}{dt} = -\frac{D_0}{m_0}\cdot\frac{a}{a + K}
$$

3. *Separate variables.* Multiply by $(a + K)/a$:
$$
\left(1 + \frac{K}{a}\right)da = -\frac{D_0}{m_0}\,dt
$$

4. *Integrate from $a_0$ at $t = 0$ to $a$ at $t$.*
$$
(a - a_0) + K\ln\frac{a}{a_0} = -\frac{D_0}{m_0}\,t \quad\Rightarrow\quad t(a) = \frac{m_0}{D_0}\left[(a_0 - a) + K\ln\frac{a_0}{a}\right]
$$

5. *Time to the eviction threshold.* Set $a = \theta_{ev}a_0$:
$$
t_{ev} = \frac{m_0}{D_0}\left[(1 - \theta_{ev})\,a_0 + K\ln\frac{1}{\theta_{ev}}\right]
$$
   Two consequences:
    - *A positive threshold is necessary.* As $a \to 0$, $t(a) \to \infty$ logarithmically. Near zero, $da/dt \approx -(D_0/(m_0K))\,a$, so ATP decays exponentially and never reaches zero in finite time. With $\theta_{ev} = 0$ the rule would never fire. More generally, the ATP ledger is non-negative on its own whenever production is non-negative, because demand vanishes at $a = 0$.
    - *Order of magnitude (implied).* Use $a_0 = 2.5$ mM, $K_{aD} = 0.5$ mM and $\theta_{ev} = 0.05$. The bracket is $2.375 + 0.5\ln 20 = 3.873$ mM, and $m_0 = 0.833$, so $t_{ev} = 3.227\,\mathrm{mM}/D_0$. Take $D_0$ from A.6's rest metabolism: CMRglc 0.30 µmol/g/min, 88.3% oxidized at 2 + 29 ATP per glucose and 11.7% aerobic glycolysis at 2 ATP. That gives $0.30 \times (0.883 \times 31 + 0.117 \times 2) = 8.28$ µmol/g/min, or about 0.138 mM/s, and hence $t_{ev} \approx 23$ s (computed here). This uses a tissue-average turnover in place of neuronal demand, which is the main uncertainty. With the turnover fixed, relaxing the rest of A3 can only slow the decay: a falling pump demand ($\Pi \propto m(a, K_a)$), PCr and glycogen all act that way. Within this estimate, 23 s is therefore a lower bound.

6. *State of a node at threshold (computed here from T1.19, T3.3, T1.6).*
    - The pump still runs: $m(0.125, K_a = 0.15) = 0.125/0.275 = 0.45$, i.e. 45% of $\Pi_{max}$ at fixed $n$. The eviction threshold ($0.125$ mM) lies just below the pump's half-saturation point ($K_a = 0.15$ mM $= 0.06\,a_0$).
    - Demand is scaled to $m(0.125, 0.5)/m(2.5, 0.5) = 0.2/0.833 = 0.24$ of $D_{set}$.
    - The K_ATP conductance $g_K(a)$ rises toward $\bar g_K$ as $a$ falls (T1.6). No source gives $K_A$ numerically, but A.8 Inference 2 says the conductance activates "as $a_i$ declines toward 1.2 mM". If so, it is close to $\bar g_K$ at 0.125 mM. The rate-layer potential is then driven *toward* the brake fixed point $(v_{rest} + \bar g_KE_K)/(1 + \bar g_K)$ (T1.1 checks), which is a hyperpolarized state.
    - The Na$^+$ load stays below $n_{eq}$ (T1.18 invariance).

   *Reconciling the two triggers.* A.10 says "permanently depolarized"; the lineage table says $a_i < 0.05a_0$. In Eq. 5.1, ATP failure *hyperpolarizes* through K_ATP. No reversal potential in the rate layer moves with ion loads, so anoxic depolarization has no model variable. "Permanently depolarized" therefore cannot be detected from model states, and the ATP criterion is the only operational one. A combined trigger that also catches Na$^+$-gradient collapse would be (Proposal): evict if $a_i \le \theta_{ev}a_0$ for a dwell time $T_d$, **or** if $n_i \ge n_{ev}$ (close to $n_{eq}$) for $T_d$. $n_{ev}$ and $T_d$ appear in no source.

*Part B. Bookkeeping across the jump (derived).*

7. *Na$^+$ ledger.* Let the total intracellular Na$^+$ amount be $N_{Na}(t) = \sum_{j\in\mathcal A(t)}Vol_jn_j$. Between events, $dN_{Na}/dt = \sum_{j\in\mathcal A}Vol_j(J_j - \Pi_j)$, where $J_j$ is the T1.18 influx. At the eviction of node $i$ at $t_e$, $N_{Na}(t_e^+) = N_{Na}(t_e^-) - Vol_i\,n_i(t_e)$. The integrated ledger is
$$
N_{Na}(t) = N_{Na}(0) + \int_0^t\sum_{j\in\mathcal A(s)}Vol_j(J_j - \Pi_j)\,ds - \sum_{e:\,t_e \le t}Vol_{i_e}\,n_{i_e}(t_e)
$$
   Equivalently, the rate equation carries an impulsive sink $-\sum_eVol_{i_e}n_{i_e}(t_e)\,\delta(t - t_e)$. Extracellular Na$^+$ is held constant (T1.18 A6), so this Na$^+$ leaves the books. It must be reported as an exit, not dropped silently.

8. *ATP ledger.* $a_i(t)$ is continuous, so at the first crossing $a_i(t_e) = \theta_{ev}a_0$ exactly. Each eviction therefore removes exactly $\theta_{ev}a_0\,Vol_i = 0.05\,a_0Vol_i$ of ATP, an amount that is small and known in advance.

9. *Carbon ledger (T3.4).*
    - *Case (a), neuron inside a voxel.* No carbon pool is removed. The voxel's fluxes lose the node's share of $v_{gn}$ and demand. The identity $d[G + \Gamma + (L + p)/2]/dt = J_G - J_L/2 - v_{ox}/2$ is an algebraic consequence of T3.1 for whatever fluxes remain, so it holds unchanged across the event.
    - *Case (b), whole-voxel node.* Its carbon $M_i = V_i[G + \Gamma + (L + p)/2]_i$ leaves with it:
$$
\frac{dM}{dt} = J_G - \frac{J_L}{2} - \frac{v_{ox}}{2} - \sum_eM_{i_e}(t_e)\,\delta(t - t_e)
$$

10. *Headroom barrier (T6.5).* For $i \in Q$,
$$
h_Q^+ = D_{cap} - \sum_{k\in Q\setminus\lbrace i\rbrace}D_k = h_Q^- + D_i(t_e) \ge h_Q^-
$$
    because $D_i \ge 0$. Eviction can only raise headroom, so $h_Q \ge 0$ is preserved. At threshold $D_i(t_e) = 0.24\,D_{set,i}$ (Step 6).

11. *Weights (T6.4): delete, do not redistribute.* Deleting $W_{ij}$ and $W_{ji}$ lowers the maintenance demand $\beta\sum W$ (T3.3), so by Step 10 it cannot break $h_Q \ge 0$. Redistributing the weight to surviving synapses would raise demand elsewhere, and would be admissible only after passing through the T6.4 headroom gate. The targets' loss of input is then compensated on their own time scales by the homeostat (T1.21) and the AIS controllers (Tier 4).

12. *Gap-junction Laplacian (if evictable nodes include Cx36-coupled PV cells).* The correct update deletes row and column $i$ of $A$ and recomputes the degrees: $L' = D' - A'$ with $d'_k = d_k - A_{ki}$. Suppose instead row and column $i$ of $L$ are deleted but the degrees are kept. Call that matrix $\tilde L$. For a neighbour $k$ of $i$:
$$
[\tilde Lv]_k = d_kv_k - \sum_{j\ne i}A_{kj}v_j = (d_k - A_{ki})v_k - \sum_{j\ne i}A_{kj}v_j + A_{ki}v_k = [L'v]_k + A_{ki}v_k
$$
    The current into $k$ is then
$$
-g_{gap}[\tilde Lv]_k = -g_{gap}[L'v]_k + g_{gap}A_{ki}(0 - v_k)
$$
    This is a phantom junction to a node clamped at 0 mV. For a cell near rest ($v_k < 0$) it injects depolarizing current into every former neighbour of the evicted cell. It also breaks charge conservation, since $\mathbf 1^T\tilde L \ne 0$. A "graceful" eviction therefore needs the degree update. With it, $\mathbf 1^TL' = 0$ again (T1.4).

13. *Hysteresis and dwell (Proposal).* By A1 eviction cannot chatter. The remaining risk is a false positive on a transient dip. Two equivalent safeguards are:
    - evict at the first $t$ such that $a_i(s) \le \theta_{ev}a_0$ for all $s \in [t - T_d, t]$;
    - trigger on a filtered $\bar a_i$, with $\tau_{ev}\,d\bar a_i/dt = a_i - \bar a_i$.

    The sources report activation transients far smaller than a 95% drop: $-14.8$% in A.7 and $\pm1.2$% in A.8. False positives would arise only under ischaemia or aglycaemia, which is where eviction is intended.

**Result.** The rule is a modelling choice and the 0.05 threshold cannot be derived (A2). What can be derived:

- (i) A positive threshold is necessary, because ATP decays exponentially near zero and never reaches it (Step 5).
- (ii) Under zero supply the time to eviction is $t_{ev} = (m_0/D_0)[(1 - \theta_{ev})a_0 + K_{aD}\ln(1/\theta_{ev})]$, about 23 s or more with A.6 rest values (Step 5).
- (iii) At threshold the model node is hyperpolarized by K_ATP, Na$^+$-bounded and still pumping at 45%. A.10's "permanently depolarized" trigger is not representable in the model states, so the ATP trigger is the operational one (Step 6).
- (iv) Bookkeeping rules keep every ledger closed. Na$^+$ and ATP leave as impulsive sinks; carbon is unchanged for neuron nodes and leaves as a sink for voxel nodes; headroom can only rise; weights are deleted; the Laplacian degrees must be updated (Steps 7-12).

The sources are incomplete on every point except the threshold. Two further problems:

- *"Apoptotic" is biologically questionable.* Apoptosis needs ATP, and severe ATP depletion switches cell death from apoptosis to necrosis (Leist et al. 1997). A node at 5% of baseline ATP is in the necrotic regime.
- *The divergence it was meant to cure is never identified.* The ledgers that involve ATP (T1.18, T1.19, T3.2, T3.3) stay bounded as $a \to 0$, so the 48-hour divergence in A.8 must have come from elsewhere. One candidate is the logarithmic AIS threshold law if $L_i \to 0$; Tier 4 notes that positivity of $L_i$ is not guaranteed (T4.2, T4.5). Eviction removes the symptom without fixing whichever term diverged.

**Checks.**

- *Dimensions.* $a_i/a_0$ is dimensionless. $t_{ev}$ is in mM/(mM/s) = s.
- *Limits of $\theta_{ev}$.*
    - $\theta_{ev} \to 0$: $t_{ev} \to \infty$, so eviction never happens.
    - $\theta_{ev} \to 1$: $t_{ev} \to 0$, so any dip below baseline evicts, which is absurd.
    - $\theta_{ev} = 0.05$ sits just below the pump's half-saturation point ($K_a/a_0 = 0.06$), so nodes are removed shortly after the pump loses half its capacity.
- *Invariants.* $h_Q \ge 0$ is preserved (Step 10). Ledgers close once the impulsive sinks are included (Steps 7-9). Charge is conserved by the corrected Laplacian (Step 12).
- *Comparison with Aleph Invariant 4.* Aleph gives an ischaemic survival horizon $K_{ischemia} \approx 2.5$ min (human). That is longer than the 23 s lower bound of Step 5. The difference is consistent with the PCr and glycogen reserves, which Step 5 omits and which $K_{ischemia}$ counts explicitly.

**Lineage.**

- **Model A to A.8.** "Eviction" meant *synaptic* eviction, the current $E_{ij}$ (T6.4, T6.6). It is unrelated to this rule.
- **A.8.** Limitations section of Model_A8_model only.docx and Model_A8_Scientific_Report.docx: chronic simulations beyond 48 h cause "permanent cell death cascades that degrade graph connectivity beyond biological bounds".
- **A.9.** "Implements a graceful apoptotic eviction protocol to maintain global computational stability", which "eliminated the 48-hour computational divergence crashes that plagued Model A.8". No criterion is given.
- **Aleph lineage table.** Supplies the criterion $a_i < 0.05\,a_0$ in its A.9 column. The A.10.1 column says "Maintains apoptotic eviction".
- **A.10.** "Permanently depolarized nodes undergo graceful apoptotic eviction, preventing numerical divergence."
- **GPT audit.** Sec. 6.2 says the rule is "not a consequence of [the] membrane equation" and lists what it must specify.

**Derivation status.** Phenomenological closure (event rule), and incomplete in source.

- *Motivation.* Irreversible energy failure, and A.9's need to stop numerical crashes in chronic simulations. No evidence is given for the value 0.05.
- *Missing in source:* the death criterion beyond the threshold, the dwell or hysteresis, the removal of states and weights, and ledger conservation.
- *Supplied here:* Steps 7-12 as derived bookkeeping consequences, and Steps 1, 6 and 13 as proposals.

---

## Summary of Tier 5 status

| Key | Equation | Status | Main issues |
|---|---|---|---|
| T5.1 | CA1 conductance-based LIF with noise | Derived under approximations (single compartment, Ohmic conductances, LIF reduction, white-noise channel fluctuations at a frozen voltage, normalization by $g_L$); incomplete in source | one $\tau_m$ for two cell types (15 and 5 ms); reset and refractory rule only in A.6; no reversal, threshold or reset values; the $\sqrt{2\tau_m}$ factor makes $\sigma_{ch}$ the SD only without synaptic conductance (SD $= \sigma_{ch}/\sqrt{1+g_{tot}}$); "channel noise" is a generic membrane noise; Cx36 current (Aleph Eq. 5.4) absent, coupled PV form proposed; no K_ATP feedback |
| T5.2 | Exponential AMPA/GABA$_A$ conductances | Derived under approximations (two-state kinetics, instantaneous rise, linear summation, fixed delay, deterministic release) | sum over spikes of each presynaptic cell missing from the notation; $W$ must be dimensionless; rise time neglected at sub-ms resolution; no release dynamics or Ca$^{2+}$ dependence; A.7 drops the delay; parameters assumed and tuned |
| T5.3 | Extracellular Ca$^{2+}$ depletion | Incomplete in source (balance structure derived under approximations; truncation mechanism phenomenological) | $I_{Ca,burst}$ never specified (derived: $\propto R(t)[Ca^{2+}]_e$); $\tau_{ref}$ must be dimensionless or $\tau_{Ca}$ redundant; printed form not positivity-preserving; release coupling only in prose (Dodge-Rahamimoff proposal); a single pool cannot make out-of-phase clusters; Ca$^{2+}$ handling not booked in the Na$^+$/ATP ledgers |
| T5.4 | PV depolarization block rule | Incomplete in source (not stated anywhere) | LIF provably cannot block; proposals: P1 Na$^+$-inactivation gate (from Hodgkin-Huxley), P2 Na$^+$-fatigue reuse (too slow except for thin processes with a large overlap factor), P3 lesion switch (what A.6 did) |
| T5.5 | Per-spike Na$^+$ load | Derived under approximations (capacitive minimum times overlap factor, well-mixed volume, GHK factor as surrogate, Marcus jump) | additive A.6/A.7 jump breaks $[0, n_{eq}]$ invariance (Marcus jump fixes it); cell-to-node mapping unstated; no value of $\nu_{spk}$; A.8's 25 $\nu_{spk}$ per 22.4 ms event implies 1.1 kHz per cell; pigeon 0.313 applies to moles, not concentration, and the 0.427 product is not a per-spike debt |
| T5.6 | Apoptotic node eviction | Phenomenological closure (event rule); incomplete in source | threshold not derivable; ATP-based versus "permanently depolarized" triggers (only ATP is representable); time to eviction about 23 s or more under zero supply; bookkeeping derived (Na$^+$/ATP sinks, carbon by case, headroom preserved, weights deleted, Laplacian degree update); "apoptotic" questionable at 5% ATP; the divergence it cures is unidentified |
