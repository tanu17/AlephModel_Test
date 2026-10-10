# Extraction: Model_A_Biological_Neuroenergetics_Specification.pdf
- Model version(s) specified: "Model A" (reduced 6-equation core), presented as the corrected successor of precursor "Models v0.1 through v5.0". Dated October 2026. It does NOT use the A.1-A.10 / Aleph 1 numbering and contains none of the Aleph 1 tier equations (no K_ATP brake ODE in Aleph form, no Woodhull, Hall-Ehlert, Kirchhoff, Pennes, Stuart-Landau, six-pool metabolism, AIS controller, etc.).
- One-paragraph summary of the file: A 7-page "biophysical specification" monograph. Sec 1 lists six axioms (A1-A6). Sec 2/Table 1 audits errors in precursor versions v0.1-v5.0 (1D axon paradox, contraction condition, sheaf cohomology, participation ratio, proportional metabolic penalty, energy reallocation, insect brain power, plasticity deadlock) with corrective formulas. Sec 3 gives the reduced core: (1) leaky membrane potential with ACh modulation and firing-rate law with K_ATP threshold shift and K+ gate; (2) local NVU ATP buffer (cell + domain pools) and power dissipation; (3) three-factor dopamine plasticity with headroom gate and demand-driven eviction; (4) homeostatic threshold integral control; (5) Benna-Fusi multi-timescale consolidation cascade; (6) two-phase SWS/REM sleep operator. Sec 4 introduces species parameter vector Theta_s and a cross-taxon table (mammals, birds, insects, cephalopods). Sec 5 lists falsification assays P1-P3. Equations stated, essentially no derivations.
- Parts that could not be read (if any): None for equations (pages 3-5 checked against PDF images). The cephalopod row of the clade table (p.6) is cut off at the page bottom in the source itself.

### E1: Electrotonic length-constant scaling (Axiom A6)
- Section in source: 1, Axiom A6
- Tier: other (cable dynamics; closest Tier 1)
- Equation: $\lambda(d) \propto \sqrt{d}$
- Symbols: λ electrotonic length constant; d axon diameter (implied).
- Derivation: none given (stated as axiom).
- Cites: cable dynamics (no reference).
- Aleph 1 equivalent: none
- Changes: none mentioned.

### E2: Point-process channel capacity (1D axon "paradox" refutation)
- Section: 2, Table 1
- Tier: other
- Equation: $C_e = \frac{\lambda_0}{e \ln 2} \approx 53.1\ \text{bits/s at } 100\ \text{Hz}$
- Symbols: C_e capacity of scalar point-process channel; λ_0 rate (100 Hz).
- Derivation: none; cites Kabanov (1978). Used to argue axons carry high-dimensional temporal information via spike timing.
- Aleph 1: none
- Changes: replaces precursor claim that 1D scalar cable conduction forbids high-dimensional coding (requiring "tensor synapses").

### E3: Precursor contraction condition (rejected)
- Section: 2, Table 1
- Tier: other
- Equation: $\rho\left(\sum M_k W^{(k)}\right) < 1/\max(\sigma')$
- Symbols: ρ spectral radius; M_k, W^{(k)} matrices; σ' activation derivative.
- Derivation: stated "False": non-normal matrices can diverge despite ρ<1; global contraction also eliminates multistable memory.
- Aleph 1: none
- Changes: precursor (v0.1-v5.0) error.

### E4: Local contraction via matrix measure (replacement)
- Section: 2, Table 1
- Tier: invariant
- Equation: $\mu_2(J) \le -c$ (within certified memory basins)
- Symbols: μ_2 matrix measure (log-norm, 2-norm); J Jacobian; c>0.
- Derivation: none beyond the rejection of E3.
- Aleph 1: none
- Changes: replaces global spectral-radius contraction.

### E5: Euler characteristic / sheaf cohomology correction
- Section: 2, Table 1
- Tier: invariant
- Equation: $\dim H^0 - \dim H^1 = d(1-b_1)$; with flat holonomy $\dim H^0 = d \Rightarrow \dim H^1 = d\cdot b_1$ (maximal)
- Symbols: H^0, H^1 cohomology groups; d fiber dimension; b_1 first Betti number.
- Derivation: Euler characteristic argument as quoted; precursor claimed flat holonomy implies H^1=0, which is "False".
- Aleph 1: none
- Changes: replaced by "gauge-invariant Stiefel manifold synchronization".

### E6: Participation ratio arithmetic correction
- Section: 2, Table 1
- Tier: other
- Equation: precursor $\sigma_k \propto e^{-k/3.8}$, claimed $D_{\text{eff}} \in [12,16]$; corrected $PR = \frac{1+r}{1-r} = 3.89$
- Symbols: σ_k k-th singular value/spectrum; r geometric ratio (implicitly e^{-1/3.8}... [not stated; r not defined in source]); D_eff effective dimensionality.
- Derivation: "The geometric sum yields PR = (1+r)/(1-r) = 3.89." Johnson-Nyquist noise declared irrelevant.
- Aleph 1: none
- Changes: precursor arithmetic error.

### E7: Proportional metabolic penalty (rejected) and its steady-state overshoot
- Section: 2, Table 1
- Tier: other
- Equation: $\lambda = \max(0, \eta[P - P_{\max}])$; overshoot $P^* = P_{\max} + \lambda^*/\eta$
- Symbols: λ penalty; η gain; P power; P_max ceiling.
- Derivation: "Proportional control guarantees steady-state overshoot" (inverting λ* = η(P*-P_max)).
- Aleph 1: none (replaced by supply-limited buffer kinetics and Control Barrier Functions)
- Changes: precursor violated bound.

### E8: Insect brain power numbers / reallocation range (parameter relations)
- Section: 2, Table 1
- Tier: other
- Equation: fly brain 1.1-1.2 µW ex vivo (~1-6 µW in vivo) vs precursor 25 µW (whole-body respiration, "overestimated by 20x"); neurovascular coupling local < 50 µm.
- Derivation: none.
- Aleph 1: none.

### E9: Unmet learning demand (Eviction T13')
- Section: 2 Table 1 and 3.3
- Tier: 6
- Equation: $U_Q = (1 - s_Q)\Pi_Q$
- Symbols: U_Q unmet / unallocated potentiation drive in domain Q; s_Q headroom gate; Π_Q potentiation drive.
- Derivation: none; labelled theorem/mechanism "T13'".
- Aleph 1: Tier 6 synaptic headroom (partial)
- Changes: solves precursor "plasticity deadlock" where hard weight caps blocked learning.

### E10: Somatic membrane potential (Eq 1)
- Section: 3.1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{\text{rest}}) + \zeta(1 - \nu\cdot\text{ACh}) \sum_{j\in\mathcal{N}_{\text{in}}(i)} s_j W_{ij} x_{ij} r_j - c_a a_Q + (1 + \nu\cdot\text{ACh}) I_i(t)$
- Symbols: v_i somatic potential; τ_v time constant; ζ membrane unit conversion factor; ν ACh modulation gain; s_j∈{+1,-1} Dale sign; W_ij weight; x_ij∈[0,1] readily releasable vesicle fraction; r_j presynaptic rate; c_a, a_Q [not defined in source: coefficient and domain-level adaptation/adenosine-like term]; I_i external current.
- Derivation: none ("leaky integration with cell-type-specific neuromodulation").
- Aleph 1: Aleph Eq. 5.1 (somatic potential; but here no explicit K_ATP term in the voltage equation)
- Changes: none mentioned.

### E11: Firing-rate law with metabolic and ionic gating (Eq 2)
- Section: 3.1
- Tier: 1
- Equation: $r_i(t) = h_K(k_Q)\cdot \phi_\tau\Big(g_\tau(\text{NE})\cdot\big(v_i - \theta_i - a_i - \Delta\theta(e_i)\big)\Big)$
- Symbols: h_K(k_Q)∈[0,1] smooth non-increasing gate shutting spiking as extracellular K+ k_Q approaches spreading-depolarization ceiling k_ceil ≈ 12 mM; φ_τ cell-type transfer function; g_τ(NE) noradrenergic gain; θ_i threshold; a_i adaptation; Δθ(e_i) ≥ 0 K_ATP-mediated threshold shift: as ATP e_i falls below e_thr, K_ATP conductance increases, hyperpolarizing and raising threshold.
- Derivation: qualitative justification only (K_ATP mechanism); functional forms of h_K, Δθ not given.
- Aleph 1: inherited firing-rate transfer function; K_ATP brake of Eq 5.1 (here as threshold shift)
- Changes: none.

### E12: Spike-frequency adaptation
- Section: 3.1 (bullet)
- Tier: 1
- Equation: $\tau_{\text{ad}}\dot a_i = -a_i + m\cdot r_i$
- Symbols: τ_ad adaptation time constant; m adaptation gain.
- Derivation: none.
- Aleph 1: none explicit (part of Tier 1 / Tier 5 spiking).

### E13: Cellular ATP pool (Eq 3)
- Section: 3.2
- Tier: 3
- Equation: $\frac{de_i}{dt} = g(e_Q - e_i) - h(e_i)p_i(t)$
- Symbols: e_i cellular ATP; e_Q domain energy pool; g exchange conductance; h(e_i) consumption efficiency function [form not given]; p_i power dissipation.
- Derivation: "Energy is strictly supply-limited"; domain Q = capillary bed (mammals) or tracheal-glial unit (insects).
- Aleph 1: inherited Tier 3 ATP balance (much simplified vs six-pool)

### E14: Local supply-domain pool (Eq 4)
- Section: 3.2
- Tier: 2/3
- Equation: $\frac{de_Q}{dt} = J_Q\left(1 - \frac{e_Q}{E_Q}\right) - \sum_{i\in Q} g(e_Q - e_i)$
- Symbols: J_Q vascular supply rate; E_Q domain capacity.
- Derivation: none (logistic-type supply).
- Aleph 1: none directly (closest Tier 2 Eq 5.6 supply / Tier 3)

### E15: Cellular power dissipation (Eq 5)
- Section: 3.2
- Tier: 3
- Equation: $p_i(t) = P_0(d_i) + \alpha(d_i,\ell_i) r_i + \alpha_{\text{syn}}\sum_j W_{ij}x_{ij}r_j + \beta\sum_j W_{ij} + \kappa\sum_j\left|\frac{dW_{ij}}{dt}\right|$
- Symbols: P_0(d_i) baseline cost (diameter d_i); α(d_i,ℓ_i) per-spike cost (diameter, length ℓ_i); α_syn synaptic transmission cost; β weight maintenance cost; κ plasticity cost.
- Derivation: "accounts for baseline, action potential, and synaptic maintenance costs".
- Aleph 1: inherited sodium debt ledger / Tier 3 ATP demand (approx.)

### E16: Pump ATP linear in sodium current
- Section: 3.2
- Tier: 1/3
- Equation: $P_{\text{ATP}} \approx 0.17\ \text{V} \times |I_{\text{Na}}|$
- Derivation: asserted "Crucially ... linear in sodium current, not quadratic Joule dissipation." No derivation.
- Aleph 1: inherited sodium debt ledger.

### E17: Local weight-cost headroom
- Section: 3.3
- Tier: 6
- Equation: $h_{C,Q} = C_{\max,Q} - \beta\sum_{kl\in Q} W_{kl}$
- Symbols: C_max,Q weight-cost budget of domain Q; β maintenance cost per weight.
- Aleph 1: Tier 6 synaptic headroom.

### E18: Three-factor plasticity (Eq 6)
- Section: 3.3
- Tier: 6
- Equation: $\tau_w\frac{dW_{ij}}{dt} = (1-b_m)\left[\text{DA}^+ s_Q f^+(r_i,r_j)(w_{\max}-W_{ij}) - (1+\text{DA}^-)f^-(r_i,r_j)W_{ij}\right] - \gamma(1-\Omega_{ij})W_{ij} - E_{ij}$
- Symbols: W_ij∈[0,w_max]; τ_w; b_m [not defined in source]; DA+/DA- dopamine signals; f^+, f^- Hebbian potentiation/depression functions; γ decay rate; Ω_ij consolidation tag; E_ij eviction.
- Derivation: none ("dopamine-modulated Hebbian plasticity").
- Aleph 1: Tier 6 plasticity (no direct numbered equation).

### E19: Headroom barrier gate (Eq 7)
- Section: 3.3
- Tier: 6
- Equation: $s_Q = \min\left\{1, \frac{\Delta_Q + \frac{\tau_w\gamma_h}{\beta}h_{C,Q}}{\bar\Pi_Q + \varepsilon}\right\}$
- Symbols: s_Q∈[0,1]; Δ_Q [not defined; presumably depression/freed capacity]; γ_h headroom rate; \bar Π_Q mean potentiation drive; ε small regularizer. (Text extraction rendered the fraction as "τwβγh"; PDF image shows τ_wγ_h over β.)
- Derivation: none (barrier-function style gate).
- Aleph 1: Tier 6 synaptic headroom.

### E20: Demand-driven eviction (Eq 8)
- Section: 3.3
- Tier: 6
- Equation: $E_{ij} = U_Q\cdot\frac{(1-\Omega_{ij}+\varepsilon)W_{ij}}{\sum_{kl\in Q}(1-\Omega_{kl}+\varepsilon)W_{kl}}$
- Derivation: eviction "targeted specifically at the least-consolidated synapses" when s_Q<1. Proportional allocation; sums to U_Q.
- Aleph 1: Tier 6 (headroom/eviction); Tier 5 "apoptotic node eviction" is a different (node) mechanism.

### E21: Homeostatic threshold integral control (Eq 9)
- Section: 3.4
- Tier: 4/6 (homeostasis)
- Equation: $\tau_\theta\frac{d\theta_i}{dt} = r_i(t) - \rho_\tau,\quad \theta_i\in[\theta_{\min},\theta_{\max}]$
- Symbols: ρ_τ target rate for τ∈{E, PV, SST, VIP}.
- Derivation: justification: prevent runaway positive feedback; cites Turrigiano synaptic scaling.
- Aleph 1: none exact (closest Tier 4 AIS threshold law).

### E22: Benna-Fusi consolidation cascade (Eq 10)
- Section: 3.5
- Tier: 6
- Equation: $C_k\frac{du^k_{ij}}{dt} = g_{k-1}(u^{k-1}_{ij} - u^k_{ij}) - g_k(u^k_{ij} - u^{k+1}_{ij}),\quad \Omega_{ij} = u^1_{ij}$, with $C_k = 2^k$, $g_k \propto 2^{-k}$
- Derivation: cites Benna & Fusi (2016); yields power-law forgetting $t^{-1/2}$ (stated, not derived).
- Aleph 1: Tier 6 condensate capture / consolidation (different form).

### E23: SWS downscaling (Eq 11)
- Section: 3.6
- Tier: 6
- Equation: $W_{ij} \leftarrow \big(1 - \delta(1-\Omega_{ij})\big)W_{ij}$, δ ≈ 0.18-0.20
- Derivation: "shrinks noise and untagged weights by fraction δ".
- Aleph 1: Tier 6 circadian sleep pruning tensor.

### E24: REM re-strengthening (Eq 12)
- Section: 3.6
- Tier: 6
- Equation: $W_{ij} \leftarrow W_{ij} + \eta_R\Omega_{ij}(w_{\max} - W_{ij})$
- Derivation: "re-strengthening tagged assemblies"; executes once per sleep cycle.
- Aleph 1: Tier 6 sleep operator.

### E25: Species parameter vector (Eq 13)
- Section: 4
- Tier: other (Tier 6 ontogenetic/scaling)
- Equation: $\Theta_s = [N, e_n, L_{\text{brain}}, T_b, \text{Myelin}, \Delta_{\text{in}}, \text{SupplyType}, \psi_{\text{ref}}]^T$
- Derivation: species differences handled entirely by Θ_s without changing ODEs.
- Aleph 1: loosely Tier 6 ontogenetic scaling tensor.

### E26: Cross-taxon table parameter relations
- Section: 4 table
- Tier: other
- Equation(s): Q10 ≈ 2-3 scales all τ (birds, T_b ≈ 41 °C); insect graded-signaling crossover $x^* \approx 3.9\lambda \approx 0.4-1.9$ mm; Kenyon cell expansion K ≈ 6-10; mammal theta 6-10 Hz, gamma 30-80 Hz; human brain ~20 W; bird neurons ~1/3 mammalian glucose per cell (von Eugen 2022).
- Derivation: none. Cites de Vivo (2017), Royer (2012), FlyWire, theorems T21, T22, T53 (not given in file).
