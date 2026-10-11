# Extraction: Model_A_Changelog_Audit_and_Fixes.md
- Model version(s) specified: Original "Model A" (base model a / A.1), extracted from precursor monographs v0.1, v5.0, v6.0, v7.3. Not Aleph 1.
- One-paragraph summary of the file: Changelog/audit document. Sec. 2 lists seven issues in precursor models (1D cable "paradox", contraction criterion, sheaf cohomology H^1=0, participation-ratio arithmetic, proportional penalty, whole-brain metabolic reallocation, animal physiology numbers), each with a refutation and the fix adopted in Model A. Sec. 3 gives the "reduced system" of six coupled equations (membrane/firing rate with K_ATP gating, NVU ATP buffers, three-factor plasticity with eviction T13', homeostatic threshold, cascade consolidation tags, two-phase sleep operator). Sec. 4 is a cross-species parameter plan; Sec. 5 discusses a colleague's tensor proposal, the hierarchical state vectors H_i and Q, an information-preservation reduction criterion, and a bound taxonomy. Theorems T6, T10, T13', T16, T17, T21, T35 are cited by name only (not stated).
- Parts that could not be read (if any): None. Note the Markdown escapes (e.g. pmatrix/bmatrix rows "\\" rendered as single "\"); set braces in K_m lost escaping; one stray "*" in E27 subscripts (markdown italics corruption: \mathbf{H}*{\text{reduced}}, X*{\text{full}}).

### E1: Passive 1D cable equation (precursor, cited for refutation)
- Section in source: 2, Issue 1
- Tier: other
- Equation: \lambda^2 \frac{\partial^2 V}{\partial x^2} - c_m \frac{\partial V}{\partial t} = \frac{V - V_{\text{rest}}}{r_m}
- Symbols: V voltage along passive wire; x position; lambda length constant; c_m, r_m membrane capacitance/resistance (not further defined).
- Derivation/justification: none; quoted as precursor's basis for claiming an axon conveys only a scalar. Refuted as conflating spatial dimensionality with channel capacity of a point process.
- Physical law cited: cable theory.
- Corresponding Aleph 1 equation: none (inherited dendritic potential conceptually distinct).
- Changes: removed as justification; replaced by E2.

### E2: Poisson spike-train edge capacity
- Section: 2, Issue 1
- Tier: other (information-theoretic bound)
- Equation: C_e = \frac{\lambda_0}{e \ln 2} \approx 53.1\text{ bits/second}, with \lambda_0 = 100\text{ Hz}
- Symbols: lambda_0 mean rate 100 Hz; C_e edge capacity.
- Derivation: continuous-time point-process information theory (Kabanov 1978). With refractory dead-time 2 ms and dark rate 0.5 Hz, capacity ~44-50 bits/s (no steps given).
- Cites: Kabanov (1978).
- Aleph 1: none.
- Changes: replaces precursor "1D axonal cable paradox"/tensor neurons. Reused in Sec 5 bound C_e <= 53.1 bits/s.

### E3: Precursor global contraction criterion
- Section: 2, Issue 2
- Tier: invariant (rejected)
- Equation: \rho\left(\sum_k M_k(t) W^{(k)}\right) < \frac{1}{\max(\sigma')}
- Symbols: rho spectral radius; M_k(t) modulators; W^{(k)} weight matrices; sigma' activation slope.
- Derivation: refuted: (1) non-normal transient growth; (2) global contraction implies unique equilibrium (contraction mapping theorem), destroying multistability.
- Aleph 1: none.
- Changes: replaced by E5.

### E4: Non-normal counterexample
- Section: 2, Issue 2
- Tier: invariant
- Equation: A = \begin{pmatrix} 0 & 3 \\ 0 & 0 \end{pmatrix},\ \rho(A)=0,\ \mu_2(J) = 0.5 > 0
- Symbols: mu_2 logarithmic norm (matrix measure). [unclear: source writes mu_2(J) for matrix A; for this A, mu_2 would be 1.5 — recorded as given, value 0.5]
- Derivation: stated only.
- Aleph 1: none.

### E5: Certified local contraction basin
- Section: 2, Issue 2
- Tier: invariant
- Equation: K_m = \{ |z - z^*|_P \le c/L_P \}; contraction at rate e^{-ct}
- Symbols: z state, z^* memory equilibrium, P-weighted norm, c contraction rate, L_P Lipschitz constant [inferred from notation only, not defined].
- Derivation: none; references Theorems T6 and T21.
- Aleph 1: none.
- Changes: local contraction replaces global contraction; preserves multistability.

### E6: Euler-Poincaré for cellular sheaf on graph
- Section: 2, Issue 3
- Tier: invariant
- Equation: \dim H^0 - \dim H^1 = d(|V| - |E|) = d(1 - b_1)
- Symbols: G=(V,E) connected graph, stalks R^d, b_1 first Betti number (independent cycles).
- Derivation: Euler-Poincaré formula on connected graph.
- Aleph 1: none.

### E7: Dimension of first cohomology under flat holonomy
- Section: 2, Issue 3
- Tier: invariant
- Equation: \dim H^1 = d \cdot b_1
- Derivation: flat holonomy => global consensus => dim H^0 = d; substitute in E6. Hence H^1 maximal; H^1=0 would require 2-cells filling every cycle.
- Cites: McRae & Boumal (2024) for replacement: synchronization on Stiefel manifolds St(d,p), p >= d+2.
- Aleph 1: none. Changes: precursor H^1=0 claim discarded.

### E8: Participation ratio for exponential spectrum
- Section: 2, Issue 4
- Tier: invariant
- Equation: \sigma_k \propto e^{-k/3.8};\ r = e^{-2/3.8} \approx 0.5908;\ PR = \frac{1+r}{1-r} \approx 3.887 (K=16 truncation: 3.885)
- Derivation: variance ratio r of geometric series; precursor claimed D_eff in [12,16], "off by a factor of 4".
- Aleph 1: none. Theorem T10 makes PR data- and cutoff-dependent.

### E9: Participation ratio for power-law spectrum
- Section: 2, Issue 4
- Tier: invariant
- Equation: \sigma_k = k^{-0.52},\ \lambda_k = k^{-1.04};\ \sum_{k=1}^{49}\lambda_k \approx 4.193,\ \sum\lambda_k^2 \approx 1.562,\ PR = (4.193)^2/1.562 = 11.25
- Derivation: numeric sums; precursor claimed 14.28 at K=49; at K=10^4 PR ~43 ("diverges"). Also: SVD threshold not Johnson-Nyquist noise; biological noise is quantal/synaptic (mV scale).
- Aleph 1: none.

### E10: Precursor proportional metabolic penalty
- Section: 2, Issue 5
- Tier: other (rejected)
- Equation: \lambda(t) = \max(0, \eta [P(t) - P_{\max}])
- Derivation: refuted via E11; also lambda only scales weight decay, spiking unthrottled.
- Aleph 1: none. Changes: replaced by h(e_i) ATP-buffer scaling and CBF gating s_Q (T13').

### E11: Steady-state constraint violation
- Section: 2, Issue 5
- Tier: invariant
- Equation: P^* = P_{\max} + \frac{\lambda^*}{\eta} > P_{\max}
- Derivation: at active equilibrium lambda^*>0, inverting E10.

### E12: Precursor whole-brain reallocation
- Section: 2, Issue 6
- Tier: other (rejected)
- Equation: \Delta P = P_{\max} - P_{\text{habit}};\ M_{\text{sensory}} = M_{\text{base}} + \xi \cdot \Delta P
- Derivation: refuted: neurovascular coupling local (~50 um); global CMRglc constant within ±1-5% (Raichle & Mintun 2006).
- Changes: reallocation restricted to local supply domain Q (T16, T17): increased e_Q for neighbors.
- Aleph 1: none (local domain concept feeds Tier 2/3).

### E13: ATP power from Na+ current
- Section: 2, Issue 7
- Tier: 1 (sodium debt ledger, inherited) / 3
- Equation: P_{\text{ATP}} \approx \frac{\Delta G_{\text{ATP}}}{3 q_e} |I_{\text{Na}}| \approx 0.17\text{ V} \times |I_{\text{Na}}|
- Symbols: Delta G_ATP free energy of ATP hydrolysis; q_e elementary charge; I_Na sodium current.
- Derivation: ATP cost is Na+/K+-ATPase active transport (3 Na+ per ATP), linear in Na current, replacing ohmic P = \sum g(v-E)^2 (precursor, also recorded here as rejected form).
- Other numbers: fly brain 1-6 uW (Neville et al. 2018; whole body 20-25 uW, brain ~6%); theta jitter 15-30 deg (10-20 ms).
- Aleph 1: inherited sodium debt ledger (Tier 1).

### E14: Membrane potential (Model A eq. 1a)
- Section: 3, item 1
- Tier: 1
- Equation: \tau_v \frac{dv_i}{dt} = -(v_i - v_{\text{rest}}) + \zeta (1 - \nu \cdot \text{ACh}) \sum_j s_j W_{ij} x_{ij} r_j - c_a a_Q + (1 + \nu \cdot \text{ACh}) I_i(t)
- Symbols: s_j sign, W_ij efficacy, x_ij vesicle fraction, r_j rate, a_Q local inhibitory pool, ACh acetylcholine with gain nu, I_i external input. Others undefined.
- Derivation: none given.
- Aleph 1: precursor of Eq 5.1 somatic potential (K_ATP brake enters via E15 here).

### E15: Firing rate with K_ATP gating
- Section: 3, item 1
- Tier: 1
- Equation: r_i = h_K(k_Q) \cdot \phi_\tau\Big( g_\tau(\text{NE}) \cdot \big( v_i - \theta_i - a_i - \Delta\theta(e_i) \big) \Big)
- Symbols: k_Q extracellular K+; h_K gating; NE norepinephrine gain; theta_i threshold; a_i adaptation; Delta theta(e_i) ATP-dependent threshold shift ("acute K_ATP threshold gating").
- Derivation: none. Aleph 1: inherited firing-rate transfer function; K_ATP brake of Eq 5.1.

### E16: Cellular and domain ATP buffers
- Section: 3, item 2
- Tier: 3
- Equation: \frac{de_i}{dt} = g (e_Q - e_i) - h(e_i) p_i, \quad \frac{de_Q}{dt} = J_Q \left(1 - \frac{e_Q}{E_Q}\right) - \sum_{i \in Q} g (e_Q - e_i)
- Symbols: e_i cellular ATP buffer; e_Q vascular/glial reserve; J_Q supply (oxygen perfusion limit); E_Q capacity; g exchange rate.
- Derivation: none (Issue 5/6 motivation: supply-limited buffers, local domain).
- Aleph 1: precursor of Tier 3 substrate pools / ATP balance.

### E17: Power demand p_i
- Section: 3, item 2
- Tier: 3
- Equation: p_i = P_0(d_i) + \alpha(d_i, \ell_i) r_i + \alpha_{\text{syn}} \sum_j W_{ij} x_{ij} r_j + \beta \sum_j W_{ij} + \kappa \sum_j \left| \frac{dW_{ij}}{dt} \right|
- Symbols: d_i diameter, ell_i length [inferred]; housekeeping, spiking, synaptic, maintenance, plasticity costs.
- Derivation: none. Aleph 1: inherited Tier 3 ATP consumption.

### E18: Three-factor plasticity (T13')
- Section: 3, item 3
- Tier: 6
- Equation: \tau_w \frac{dW_{ij}}{dt} = (1 - b_m) \left[ \text{DA}^+ s_Q f^+ (w_{\max} - W_{ij}) - (1 + \text{DA}^-) f^- W_{ij} \right] - \gamma (1 - \Omega_{ij}) W_{ij} - E_{ij}
- Symbols: b_m [unclear: undefined gating, plausibly sleep/mode]; DA^± dopamine; s_Q headroom barrier in [0,1]; f^± Hebbian factors; Omega_ij consolidation tag.
- Derivation: Issue 5: CBF headroom s_Q scales potentiation before C_max is breached.
- Aleph 1: precursor of Tier 6 synaptic headroom.

### E19: Demand-driven eviction
- Section: 3, item 3
- Tier: 6
- Equation: E_{ij} = (1 - s_Q) \Pi_Q \cdot \frac{(1 - \Omega_{ij} + \varepsilon) W_{ij}}{\sum_{kl \in Q} (1 - \Omega_{kl} + \varepsilon) W_{kl}}
- Symbols: Pi_Q domain eviction budget [undefined]; epsilon regulariser.
- Derivation: none. Aleph 1: Tier 6 headroom.

### E20: Homeostatic threshold integral control
- Section: 3, item 4
- Tier: 4 (threshold law precursor)
- Equation: \tau_\theta \frac{d\theta_i}{dt} = r_i - \rho_\tau, \quad \theta_i \in [\theta_{\min}, \theta_{\max}]
- Derivation: none. Aleph 1: precursor of Tier 4 threshold law.

### E21: Multi-timescale cascade tags
- Section: 3, item 5
- Tier: 6
- Equation: C_k \frac{du_{ij}^k}{dt} = g_{k-1}(u_{ij}^{k-1} - u_{ij}^k) - g_k(u_{ij}^k - u_{ij}^{k+1}), \quad \Omega_{ij} = u_{ij}^1
- Derivation: none (beaker-chain form implied, not named). Aleph 1: precursor of condensate capture / consolidation (Tier 6).

### E22: Two-phase sleep operator
- Section: 3, item 6
- Tier: 6
- Equation: \text{SWS:}\ W_{ij} \leftarrow (1 - \delta(1 - \Omega_{ij})) W_{ij}, \qquad \text{REM:}\ W_{ij} \leftarrow W_{ij} + \eta_R \Omega_{ij} (w_{\max} - W_{ij})
- Derivation: none. Aleph 1: precursor of circadian sleep pruning tensor.

### E23: Drosophila graded/spiking crossover
- Section: 4
- Tier: other (species parameter)
- Equation: x^* \approx 3.9\lambda \approx 0.4-1.9\text{ mm}; d \ge 0.1\ \mu m; K \approx 6-10
- Also: birds T_b = 41 C (Q_10 scaling), 2-3x neuron density, 1/3 glucose/neuron. Species vector Theta_s.
- Derivation: none.

### E24: Information-preservation reduction criterion
- Section: 5 (intro, item 3)
- Tier: invariant
- Equation: \mathcal{I}(X_{\text{biological}}; Y) \approx \mathcal{I}(X_{\text{reduced}}; Y)
- Derivation: colleague's criterion, adopted as defense of reduction.

### E25: Dense tensor memory cost (rejected)
- Section: 5.A.1
- Tier: other
- Equation: X \in \mathbb{R}^{N \times 8 \times T}; 10^4 synapses x 10^3 steps -> 80\times10^6 floats (~320 MB)/neuron; 10^5 neurons -> 32 TB; complexity O(N D T) -> O(N)
- Derivation: arithmetic; >98% synapses silent per ms (r_j(t)=0); sparse CSR adopted.

### E26: Somatic state vector
- Section: 5.A.2
- Tier: 1/3/4
- Equation: \mathbf{H}_i(t) = [v_i(t), \theta_i(t), a_i(t), e_i(t)]^T \in \mathbb{R}^4 (bmatrix in source)
- Symbols: membrane potential, homeostatic threshold, adaptation, cellular ATP buffer.

### E27: Supply domain vector
- Section: 5.A.2
- Tier: 2/3
- Equation: \mathbf{Q}(t) = [e_Q(t), k_Q(t), a_Q(t)]^T \in \mathbb{R}^3
- Symbols: vascular/glial energy reserve, extracellular K+, local inhibitory pool. Output Y_i: r_i(t), spike times {t_{i,k}}.

### E28: Mutual information loss bound
- Section: 5.A.3
- Tier: invariant
- Equation (as written, with markdown corruption): \frac{\mathcal{I}(X_{\text{full}}; Y) - \mathcal{I}(\mathbf{H}*{\text{reduced}}; Y)}{\mathcal{I}(X*{\text{full}}; Y)} < 0.02  [intended: \mathbf{H}_{\text{reduced}}, X_{\text{full}}]
- Derivation: effective parameters (tau_v, g_syn, Delta theta(e_i), tau_w) capture dominant slow manifold; spike generator is integrate-and-fire bottleneck, so high-frequency biochemical fluctuations project into its null space; "rate-distortion analysis confirms" <2% (no calculation shown).

### E29: Tripartite bound taxonomy
- Section: 5.A.4
- Tier: invariant
- Equation: p \in [0,1],\ x_{ij} \in [0,1],\ s_Q \in [0,1];\ V_{\text{rest}} \approx -70\text{ mV};\ k_{\text{ceil}} \approx 12\text{ mM};\ C_e \le 53.1\text{ bits/s}; Fano bound on phase decoding (T35, not stated)
- Derivation: none.
