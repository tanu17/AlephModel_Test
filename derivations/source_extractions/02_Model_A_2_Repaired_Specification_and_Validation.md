# Extraction: Model A.2 Repaired Specification and Validation.docx
- Model version(s) specified: Model A.2 (repair of Model A, building on v7.3; Oct 8, 2026)
- One-paragraph summary of the file: Specifies Model A.2 as "twelve equations plus two sleep maps": a rate-based neuron (voltage with K_ATP conductance, firing rate gated by Na+ load, adaptation), an intracellular Na+ debt ledger repaid only by the ATP-driven pump, cellular ATP, a supply domain (domain energy with Buxton oxygen extraction, blood flow, extracellular K+), an energy-aware homeostatic set point, vesicle depletion, plasticity with an exact energy barrier and salience-gated eviction, bounded tag Omega and energy-gated capture c, and SWS/REM sleep maps. It gives a fix register (E1-E9, P1-P10), five proved properties (positivity, exact energy balance, exact barrier, sleep-map contraction, no controller conflict), colleague-lens notes, benchmarks (Padamsey, Placais & Preat, spacing, de Vivo, power-law forgetting, Leontiev/Buxton BOLD, Herculano-Houzel), FlyWire and Allen/MICrONS validation, shortfalls and novelty.
- Parts that could not be read (if any): None. Equations are present as LaTeX text in the conversion (no equation images). The two images (image1.png Allen rate chart, image2.png MICrONS motif chart) are data figures, not equations; not transcribed.

### E1: Michaelis-Menten saturation
- Section in source: The Model A.2 equations (intro)
- Tier: 1 (general helper used throughout; ATP-consuming processes)
- Equation: $m(x) = x/(x+K)$
- Symbols: x substrate; K half-saturation constant.
- Derivation or justification: "Michaelis--Menten saturation, which every ATP-consuming process obeys."
- Physical law cited: Michaelis-Menten kinetics
- Corresponding Aleph 1 equation: inherited helper (Tier 1/3 saturations)
- Changes vs earlier versions: none stated

### E2: Membrane voltage with K_ATP conductance
- Section in source: The Model A.2 equations - Membrane and firing
- Tier: 1
- Equation: $\tau_v \dot v_i = -v_i - g_{K}(e_i)\,(v_i - E_K) + G\,\zeta(1-\nu\,\mathrm{ACh})\sum_j s_j W_{ij} x_{ij} r_j + G\,(1+\nu\,\mathrm{ACh})\,I_i$
- Symbols: v_i voltage of neuron i; tau_v membrane time constant; g_K(e_i) K_ATP conductance; E_K K+ reversal; G systemic synaptic gain (feeding state, leptin; "low-power mode" input); zeta synaptic scale [not further defined]; nu ACh modulation strength; ACh acetylcholine (neuromodulators declared as inputs); s_j transmitter sign; W_ij weight; x_ij vesicle resource; r_j presynaptic rate; I_i external input. Cell type tau in {E, PV, SST, VIP} (mammals) or transmitter sign (flies).
- Derivation or justification: "K_ATP is now a conductance that opens as ATP falls, so energy shortage both hyperpolarises and shunts." ACh suppresses recurrent and boosts feedforward input (implied by the (1-nu ACh)/(1+nu ACh) factors; not stated in words).
- Physical law cited: none explicit beyond K_ATP channel physiology
- Corresponding Aleph 1 equation: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes: Fix E3/P3 and Colleague 4: K_ATP now a conductance in voltage equation; the "Δθ(e) patch" (K_ATP threshold patch) removed. Systemic scaling labelled G (Colleague 1).

### E3: K_ATP conductance law
- Section: Membrane and firing
- Tier: 1
- Equation: $g_K(e)=\frac{\bar g_K}{1+(e/K_A)^{n}}$
- Symbols: \bar g_K maximal conductance; K_A K_ATP ATP affinity; n Hill exponent; e cellular ATP.
- Derivation: opens as ATP falls (as E2). Morris screen: K_A barely moves ischaemic ATP (mu* <= 0.002); K_ATP parameters not identifiable from rates and ATP alone (need assay P1).
- Law cited: Hill-type inhibition
- Aleph: Aleph Eq. 5.1 K_ATP brake
- Changes: replaces Model A threshold patch

### E4: Firing-rate transfer function with Na+ gradient gate
- Section: Membrane and firing
- Tier: 1
- Equation: $r_i = \underbrace{\frac{1}{1+(n_i/n_c)^{6}}}_{\text{Na}^+\ \text{gradient}}\; h_K(k_Q)\;\phi_\tau\big(g(\mathrm{NE})\,(v_i-\theta_i-a_i-\theta_0)\big)$
- Symbols: n_i intracellular Na+ load; n_c critical Na+ load (gradient collapse level stated as 4); h_K(k_Q) gating by extracellular K+ of domain [function not defined in text]; phi_tau type-specific transfer function; g(NE) noradrenergic gain; theta_i adaptive threshold; a_i adaptation; theta_0 offset.
- Derivation: "firing fails at high Na+ load" (E2/P2); n bounded because firing stops at high n.
- Law cited: none
- Aleph: inherited Tier 1 firing-rate transfer function
- Changes: Na+ gate new in A.2

### E5: Spike-frequency adaptation
- Section: Membrane and firing
- Tier: 1
- Equation: $\tau_{ad}\dot a_i = -a_i + m\,r_i$
- Symbols: a_i adaptation; tau_ad time constant; m adaptation gain [same letter as m(x); unclear whether same].
- Derivation: none given. a_i restored from v7.3 (E1/P1).
- Aleph: inherited Tier 1 (firing / adaptation)
- Changes: restored from v7.3

### E6: Na+ debt ledger
- Section: Energy as Na+ debt
- Tier: 1 (inherited sodium debt ledger)
- Equation: $\dot n_i = \nu_{spk} r_i + \nu_{syn} G \sum_j W_{ij}x_{ij}r_j + \lambda_n - \Pi_i$
- Symbols: nu_spk Na+ per spike rate; nu_syn Na+ per synaptic current; lambda_n leak Na+ influx; Pi_i pump rate.
- Derivation: "Spikes and synaptic currents load Na+; the pump removes 3 Na+ per ATP and slows as ATP falls. Nothing else can spend energy, so no spike is free." 99.98% of spike Na+ pumped over 200 s.
- Aleph: inherited sodium debt ledger (Tier 1)
- Changes: new variable in A.2 (main change); removes free-spiking leak (E2/P2) where Model A throttled consumption by h(e) not firing.

### E7: Na+/K+-ATPase pump rate
- Section: Energy as Na+ debt
- Tier: 1/3
- Equation: $\Pi_i = \Pi_{max}\, m(e_i)\, m(n_i)$
- Symbols: Pi_max pump capacity.
- Derivation: pump slows as ATP falls; pump is the energy sensor (Colleague 4, Am J Physiol Cell 2025). Pi_max barely affects ischaemic ATP.
- Aleph: inherited sodium debt / ATP balance
- Changes: new

### E8: Cellular ATP balance
- Section: Energy as Na+ debt
- Tier: 3
- Equation: $\dot e_i = g_x(e_Q - e_i) - \tfrac{1}{3}\Pi_i - m(e_i)\Big[P_0 + \beta\sum_j W_{ij} + \kappa\sum_j|\dot W_{ij}| + \kappa_c\sum_j \dot c_{ij}^{+}\Big]$
- Symbols: e_i cellular ATP (concentration); g_x cell-domain exchange; e_Q domain energy; 1/3 Pi_i: one ATP per 3 Na+; P_0 basal cost; beta per-weight maintenance cost; kappa plasticity cost; kappa_c capture cost (positive part of c-dot).
- Derivation: 3 Na+ per ATP; every drain carries m(e_i) (Property 1). g_x is a main driver of ischaemic ATP (mu* = 0.13). Units: energy is a concentration with compartment volumes (Colleague 5).
- Aleph: inherited Tier 3 ATP balance
- Changes: replaces h(e)-throttled consumption of Model A

### E9: Supply-domain energy with Buxton extraction
- Section: Supply domain
- Tier: 2
- Equation: $V_Q\dot e_Q = J_0\,\frac{f_Q E(f_Q)}{E_0}(1-e_Q) - \sum_{i\in Q} g_x(e_Q-e_i) + D_A\!\sum_{Q'\sim Q}(e_{Q'}-e_Q)$
- Symbols: V_Q domain volume; J_0 baseline supply; f_Q normalized flow; E(f) oxygen extraction fraction; E_0 baseline extraction; D_A astroglial exchange between neighbouring domains Q'~Q.
- Derivation: "Oxygen delivery rises less than flow because extraction falls (Buxton): this is what produces positive BOLD." Delivery scales as f·E(f). Control parameter Gamma = J_0/(N_Q p_ref).
- Law cited: Buxton oxygen limitation model; Leontiev, Dubowitz & Buxton 2007
- Aleph: Aleph Eq. 5.6 Kirchhoff microvascular balance (precursor; supply side)
- Changes: E6/P5: Model A had constant supply J_Q.

### E10: Oxygen extraction fraction
- Section: Supply domain
- Tier: 2
- Equation: $E(f)=1-(1-E_0)^{1/f}$
- Derivation: Buxton (as E9)
- Aleph: none direct (Tier 2 supply)

### E11: Blood-flow dynamics
- Section: Supply domain
- Tier: 2
- Equation: $\tau_f \dot f_Q = -(f_Q-1) + \kappa_N\big(u_Q/\bar u_Q - 1\big) + \kappa_K(k_Q-k_{rest})$
- Symbols: tau_f flow time constant; kappa_N neurovascular gain (calibrated; n ≈ 0.99 at 0.5, 3.1 at 2.0); u_Q feedforward synaptic drive, \bar u_Q its slow baseline; kappa_K K+ gain; k_rest resting K+.
- Derivation: "Blood flow follows feedforward synaptic drive and extracellular K+, relative to its slow baseline." kappa_K term follows Longden 2017 capillary K+ sensing and PNAS 2024 K_ATP pericyte signalling.
- Aleph: inherited Kir2.1 dilation / Tier 2 dual dilation (precursor)
- Changes: new coupling (E6/P5)

### E12: Extracellular K+ clearance
- Section: Supply domain
- Tier: 2 (or 1)
- Equation: $\tau_K\dot k_Q = -m(e_Q)(k_Q-k_{rest}) + \gamma_K \bar r_Q$
- Symbols: k_Q extracellular K+; tau_K; gamma_K K+ release per mean rate \bar r_Q.
- Derivation: K+ clearance costs energy (astrocytic α2 pump isoform, Colleague 4); "restored k_Q (now with energy-dependent glial clearance)".
- Aleph: none direct (supports Tier 2 Kir2.1)
- Changes: energy-dependent clearance new vs v7.3

### E13: Energy-aware homeostatic threshold
- Section: Homeostasis with an energy-aware set point
- Tier: 4 (intrinsic/threshold homeostasis; precursor of AIS controller)
- Equation: $\tau_\theta\dot\theta_i = r_i - \rho_\tau\,\chi(e_i)$, projected onto $[\theta_{min},\theta_{max}]$
- Symbols: rho_tau type-specific target rate; theta bounds.
- Derivation: set point falls with ATP so supply cut lowers target (E3/P3, Property 5). Equation 9 labelled intrinsic (threshold) plasticity.
- Aleph: Tier 4 AIS controller / threshold law (precursor)
- Changes: Model A integral controller with fixed set point cancelled K_ATP brake.

### E14: Set-point energy factor
- Section: Homeostasis
- Tier: 4
- Equation: $\chi(e)=\frac{e^{4}}{e^{4}+e_h^{4}}$
- Symbols: e_h set-point threshold (main driver, mu* = 0.23).
- Aleph: Tier 4 precursor

### E15: Vesicle depletion
- Section: Synapses
- Tier: 1 (synaptic)
- Equation: $\dot x_{ij} = (1-x_{ij})/\tau_{rec} - U x_{ij} r_j$
- Symbols: tau_rec recovery; U release fraction.
- Derivation: none; x_ij restored from v7.3.
- Aleph: none listed (inherited synaptic)

### E16: Plasticity with energy barrier and eviction
- Section: Synapses
- Tier: 6
- Equation: $\tau_w\dot W_{ij} = (1-b_m)\big[(s_Q+\psi(1-s_Q))\,\mathrm{DA}^{+} f^{+}_{ij}(w_{max}-W_{ij}) - (1+\mathrm{DA}^{-})f^{-}_{ij}W_{ij}\big] - \gamma(1-P_{ij})W_{ij} - \psi(1-s_Q)\,\Pi_Q\,\frac{\omega_{ij}}{\sum_{Q}\omega}$
- Symbols: b_m [undefined in this text; Model A issue E1 said b_m undefined]; DA+/DA- dopamine; f+_ij, f-_ij potentiation/depression drives; w_max; gamma decay of unprotected weight; psi ∈ [0,1] salience gate; Pi_Q domain total potentiation drive; D_Q total depression and decay; omega_ij eviction weights.
- Derivation: potentiation gate s+psi(1-s) matched by eviction psi(1-s)Pi so they cancel in domain sum (E7).
- Aleph: Tier 6 synaptic headroom (precursor)
- Changes: E7: Model A net loss (2s-1)Pi with unproven barrier.

### E17: Barrier gate, headroom, eviction weights, protection
- Section: Synapses
- Tier: 6
- Equation: $s_Q=\min\Big\{1,\ \frac{D_Q+\gamma_h\tau_w h_Q/\beta}{\Pi_Q}\Big\},\quad h_Q = C_{max,Q}-\beta\sum_Q W,\quad \omega_{ij}=(1-P_{ij})\,W_{ij}\,e^{-f^{+}_{ij}/f_0},\quad P_{ij}=\max(\Omega_{ij},c_{ij})$
- Symbols: h_Q headroom; C_max,Q weight-cost cap; gamma_h; f_0 recency scale; P_ij protection.
- Derivation: "Π_Q, D_Q and s_Q defined in closed form" (E1). s_Q min is non-smooth (needs Filippov).
- Aleph: Tier 6 synaptic headroom

### E18: Fast tag
- Section: Synapses
- Tier: 6
- Equation: $\tau_\Omega\dot\Omega_{ij} = \kappa_\Omega\,\mathrm{DA}^{+} f^{+}_{ij}(1-\Omega_{ij}) - \Omega_{ij}$
- Changes: E5/P4: Model A tag Omega = u^1, fastest and unbounded; now bounded.
- Aleph: Tier 6 condensate capture (precursor, deterministic)

### E19: Energy-gated capture
- Section: Synapses
- Tier: 6
- Equation: $\tau_c\dot c_{ij} = \Omega_{ij}\,\pi(e_Q)\,(1-c_{ij}) - \gamma_{c,ij}\,c_{ij}$
- Derivation: capture gated by domain energy; produces starvation (c 0.82 fed vs 0.15 starved) and spacing effects; pi(e_Q) stands for mushroom-body mitochondrial metabolism (eLife 2024, Curr Biol 2024). Lifetimes 1/gamma_c distributed; set forgetting exponent.
- Aleph: Tier 6 condensate capture SDE (precursor)

### E20: Capture energy gate
- Tier: 6
- Equation: $\pi(e)=\frac{e^{4}}{e^{4}+e_\pi^{4}}$

### E21: SWS sleep map
- Section: Sleep, once per cycle
- Tier: 6
- Equation: $\text{SWS: } W \leftarrow \big(1-\delta(1-P)\big)W$
- Derivation: acts only on plastic synapses; tags spare strong synapses; delta = 0.20 fitted (de Vivo 2017).
- Aleph: Tier 6 circadian sleep pruning tensor

### E22: REM sleep map
- Tier: 6
- Equation: $\text{REM: } W \leftarrow W + \eta_R P(w_{max}-W) - \pi_R(1-P)\,\sigma\!\big(\tfrac{w_p-W}{s_w}\big)W$
- Symbols: eta_R; pi_R prune strength; sigma sigmoid; w_p prune threshold; s_w width.
- Changes: E8: REM previously only strengthened.
- Aleph: Tier 6 sleep pruning tensor

### E23: Positivity / forward invariance (Property 1)
- Section: Proven and tested properties
- Tier: invariant
- Equation: (verbal) drains on e_i carry m(e_i), on n_i carry m(n_i); loss terms ∝ W at W=0; potentiation zero at w_max; Omega, c logistic → state box forward-invariant (T1).
- Derivation: as quoted. Replaces v7.3 T1.

### E24: Exact energy balance (Property 2)
- Tier: invariant
- Equation: $\frac{d}{dt}\Big(\sum_i e_i + \sum_Q V_Q e_Q\Big) = \sum_Q J_Q(1-e_Q) - \sum_i C_i$
- Derivation: "Astroglial exchange cancels across domains"; integrating Na+ equation gives ∫(spike + synaptic Na+ load) dt = ∫Π dt + Δn, n bounded since firing stops at high n → each spike paid within bounded lag; supply bound T2 holds without h(e) patch. Ledger closes to 6×10⁻⁶ (Euler error). C_i (consumption) and J_Q not explicitly defined here (J_Q presumably J_0 f E(f)/E_0) [note: the e_i equation has no V_Q weighting; as written].
- Changes: Model A left 65% unpaid.

### E25: Na+ integral identity
- Tier: invariant
- Equation: $\int(\text{spike + synaptic Na}^+\text{ load})\,dt = \int\Pi\,dt + \Delta n$ (stated in words)

### E26: Exact energy barrier (Property 3)
- Tier: invariant
- Equation: $\sum_{Q} \dot W = \frac{s_Q\Pi_Q - D_Q}{\tau_w}\ \le\ \frac{\gamma_h h_Q}{\beta}\quad\Rightarrow\quad \dot h_Q \ge -\gamma_h h_Q \quad\Rightarrow\quad h_Q(t)\ge h_Q(0)\,e^{-\gamma_h t} \ge 0$
- Derivation: summing plasticity eq over domain, extra potentiation psi(1-s)Pi and eviction psi(1-s)Pi cancel; holds for any psi. Test: 30/30 memories with eviction vs 17/30 without.

### E27: Sleep-map contraction (Property 4)
- Tier: invariant
- Equation: SWS factor in [1-δ,1]; REM strengthening slope 1-η_R P ∈ [1-η_R,1]; REM pruning Lipschitz constant ≤ $1 + \pi_R w_p/(4 s_w) = 1.94$ at defaults; per-cycle contraction factor $e^{-c\,T_{wake}}$ (T6). Measured 0.85 away from band, 1.06 near.

### E28: No controller conflict (Property 5)
- Tier: invariant
- Equation: $r^* = \rho\cdot\chi(e^*)$
- Derivation: at steady state from E13; ischaemia test 3.6→1.6 Hz, ATP 0.58→0.27; fixed set point gives ATP 0.04, Na+ 4.5 past collapse 4 (spreading depolarisation route).

### E29: Supply/demand control parameter
- Section: Colleague 5
- Tier: 2/3 (other)
- Equation: $\Gamma = J_0/(N_Q\cdot p_{ref})$
- Symbols: N_Q neurons in domain; p_ref reference demand.

### E30: Metabolic sleep-pressure readout
- Section: Colleague 4
- Tier: 6
- Equation: $m(e)(1 - C/C_{max})$ (accumulated surplus)
- Derivation: proposed from Sarnataro et al. 2025 (mitochondrial electron leak when demand below supply); specified, not simulated.

### E31: Power-law forgetting from lifetime distribution
- Section: Benchmarks
- Tier: 6 (invariant/emergent)
- Equation: lifetime density $\propto \gamma^{(a-1)}$ ⇒ retention $\propto t^{-a}$; a = 0.5 gives fitted slope −0.52.
- Derivation: "by construction"; none further.

### E32: Coupling ratio / energy-per-synapse arithmetic
- Section: Benchmarks / FlyWire
- Tier: other
- Equation: n = ΔCBF/ΔCMRO2 (implied: 74%/32% → n = 2.33); fly 1.1–6 µW / 54.5×10⁶ synapses = 20–110 fW; human 20 W / (1.5×10¹⁴–10¹⁵) = 20–133 fW; per-neuron cost 1.06×10⁻⁸ µmol glucose/min at 4 Hz (Attwell-Laughlin); inverted gives 5.9 Hz (3.8–8.1 Hz). Cost law itself not written out (figure caption calls it "Model B cost law").
