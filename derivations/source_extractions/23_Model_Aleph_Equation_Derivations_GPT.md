# Extraction: Model_Aleph_Equation_Derivations_GPT.docx
- Model version(s) specified: Aleph / A.10.1 (target), with lineage references to A.3, A.4 (validation only), A.5-A.10. A.1/A.2 explicitly absent from its sources.
- One-paragraph summary of the file: "Equation-by-Equation Derivations, Mathematical Lineage, and Scientific Rigor Audit" (dated 11 Oct 2026), written by another AI (GPT). For each principal Aleph equation it quotes the printed form, gives a short derivation sketch from the governing law, a lineage note (which A.x version introduced it), and a critical qualification (units, assumptions, closure vs derivation). It classifies terms as exact derivation / standard model / constitutive closure / empirical parameter / hypothesis. Strongest derivations named: membrane current balance, gap-junction Laplacian, competitive Michaelis-Menten uptake, Poiseuille conductance, Peclet number, Pennes. Flags as closures: thermal dilation, logistic stall, AQP4 exponential, HDAC repression, activity-driven vascular forcing. Audits the 10 claimed invariants as dimensionally incomplete/unproven hypotheses. Notes Eq 5.3 contains an undefined "tau_s·(...)" term. Gives no derivation for PLC-IP3-Ca cascade (source illegible), ontogenetic tensor, CA1 spiking layer details, sodium ledger beyond a balance identity.
- Parts that could not be read (if any): none; whole text read. (Source itself says A.9 PLC/IP3/Ca equations were illegible to it.)

### E1: Generic conservation identity (illustrative)
- Section in source: 2.1
- Tier: other (methodological)
- Equation: $dG/dt = \text{inflow} - \text{consumption}$
- Symbols: G glucose.
- Derivation: Balance identity; flux law is a separate constitutive assumption. Same for charge conservation -> membrane balance.
- Physical law cited: conservation
- Corresponding Aleph equation: Tier 3 glucose balance (generic)
- Changes: none

### E2: Somatic membrane potential
- Section in source: 3.1
- Tier: 1
- Equation: $\tau_v \frac{dv_i}{dt} = -(v_i - v_{rest}) - g_K(a_i)(v_i - E_K) - g_{adap} w_i (v_i - E_K) + G_s \zeta (1-\nu_{ACh}) \sum_j [s_j W_{ij} x_{ij} r_j(t-\tau_{ij})] + G_s(1+\nu_{ACh}) I_i(t) + I_{ax,i}$
- Symbols: s_j sign, W_ij weight, x_ij resource factor, tau_ij delay; g_K(a_i) ATP-dependent K (K_ATP); w_i adaptation; I_ax axial current. No units given.
- Derivation: Kirchhoff current law for a compartment: $C_m dV_i/dt = -I_{leak} - I_{KATP} - I_{adaptation} + I_{syn} + I_{external} + I_{axial}$; Ohmic terms $I_x = g_x(V_i - E_x)$; divide by reference conductance and rewrite time with membrane time constant -> voltage-normalized form of A.7/A.8. Synaptic sum = sum of presynaptic rate contributions with sign, weight, resource, delay.
- Checks: units consistent only if g_K, g_adap, G_s, I_ax pre-normalized to voltage/time; should return to $C_m dV/dt=\sum I$ or define normalized coefficients; define whether I_i(t) is current/dimensionless/normalized.
- Physical law cited: Kirchhoff's current law, Ohm's law
- Corresponding Aleph equation: Aleph Eq. 5.1
- Changes: A.7 somatic eq with KATP shunting and ephaptic coupling; A.8 bicompartmental, adaptation, synaptic resources, metabolic dependence; 5.1 is compact integrated form.

### E3: Kirchhoff membrane current balance (intermediate)
- Section: 3.1 — Tier 1 — $C_m dV_i/dt = -I_{leak} - I_{KATP} - I_{adaptation} + I_{syn} + I_{external} + I_{axial}$, with $I_x = g_x(V_i - E_x)$. Derivation step of E2. Aleph: Eq 5.1 basis.

### E4: Woodhull NMDA block
- Section: 3.2
- Tier: 1
- Equation: $I_{NMDA}(v,[Mg^{2+}]_e,[B]) = \bar g_{NMDA}(v - E_{rev})\left[1 + \frac{[Mg^{2+}]_e}{\delta_{Mg}}\exp(-\alpha_{Mg} v) + \frac{[B]}{K_B}\exp\left(-\frac{z\delta_B F v}{R T_b}\right)\right]^{-1}$
- Symbols: delta_B electrical-distance fraction, z charge, B blocker, K_B, T_b temperature.
- Derivation: charged blocker moving fraction delta_B of field: $\Delta G(v) = \Delta G(0) + z\delta_B F v$ (sign convention dependent); Boltzmann weighting gives association factor ∝ $\exp(-z\delta_B F v/RT)$; unblocked + blocked states -> availability $B(v) = 1/[1+\text{blocker term}]$; $I = \bar g B(v)(v-E_{rev})$. Mg term same structure; the two block terms added in denominator assuming independent block.
- Qualification: classical Woodhull is equilibrium binding, not kinetic trapping; no open/closed/trapped states or time constants; exponent sign convention must be declared; additive Mg+drug is an assumption.
- Cited: Woodhull 1973, Boltzmann
- Aleph: Eq. 5.2
- Changes: introduced in A.10 (pore trapping for channel blockers); retained in Aleph.

### E5: Woodhull free-energy and availability (intermediate)
- Section 3.2, Tier 1: $\Delta G(v)=\Delta G(0)+z\delta_B F v$; $B(v)=1/[1+\text{blocker-term}]$; $I=\bar g\,B(v)(v-E_{rev})$.

### E6: Vectorized Hall-Ehlert GABA_A allosteric law
- Section: 3.3
- Tier: 1
- Equation: $(E/E_{max})_{GABA} = \sum_s f_s(x)\cdot \frac{[A]/K_{A,s} + \alpha_s\beta_s([A]/K_{A,s})([B]/K_{B,s})}{1 + [A]/K_{A,s} + [B]/K_{B,s} + \alpha_s([A]/K_{A,s})([B]/K_{B,s}) + \tau_s\cdot(\ldots)}$
- Symbols: A orthosteric agonist, B allosteric modulator, alpha binding cooperativity, beta [efficacy modulation, not defined in source], f_s subunit weights.
- Derivation: receptor-state binding polynomial; independent binding gives weights 1, [A]/K_A, [B]/K_B, alpha[A][B]/(K_A K_B); assign each state efficacy; response = efficacy-weighted sum / total polynomial; operational transduction term may be added (basis of operational allosteric models).
- Qualification: tau_s·(...) undefined -> not publication-ready/not uniquely derivable; f_s should be nonnegative, sum to one.
- Cited: Hall 2000; Black-Leff
- Aleph: Eq. 5.3
- Changes: A.9 Black-Leff; A.10 allosteric modulators and subunit-selective GABA_A; Aleph vectorizes over subunit classes.

### E7: Cx36 gap-junction current
- Section: 3.4
- Tier: 1
- Equation: $I_{gap,k} = \sum_{j\in PV\ nbrs} g_{gap}(v_{PV,j} - v_{PV,k}) = -g_{gap}[L_{gap} v_{PV}]_k$
- Derivation: ohmic junction current into k = g(V_j - V_k); sum: $I_k = g_{gap}\sum_j A_{kj}(V_j - V_k)$; with $L = D - A$, $I = -g_{gap} L V$. Exact for undirected symmetric network. Heterogeneous -> weighted Laplacian; internal currents cancel (charge conserved). Does not guarantee synchrony.
- Cited: graph Laplacian identity
- Aleph: Eq. 5.4
- Changes: added in A.10.1 final-fix table to fix synchronization deficit.

### E8: Monoamine transporter reuptake
- Section: 3.5
- Tier: 1
- Equation: $\frac{d[M]_{syn}}{dt} = R_{release}(r_{presyn}) - \frac{V_{max,T}[M]_{syn}}{K_{m,T}(1+[Inhibitor]/K_i) + [M]_{syn}} - k_{clear}[M]_{syn}$
- Derivation: mass balance (release - uptake - other clearance); competitive inhibition MM: $v_T = V_{max}[M]/(K_m(1+[I]/K_i)+[M])$; substitute. Quasi-steady-state approximation; assumes fast transporter binding, reversible competitive inhibition; other mechanisms need extra terms.
- Cited: Michaelis-Menten
- Aleph: Eq. 5.5
- Changes: A.10 adds SERT/DAT/NET.

### E9: Kirchhoff microvascular balance
- Section: 4.1
- Tier: 2
- Equation: $\sum_{e\ni c} G_e(p_c - p_{c'}) = c_a r_a^4 (P_a - p_c)\mathbf 1_{c\in Art} - G_v p_c \mathbf 1_{c\in Ven} + \frac{k' n_c}{V_{cortex}}$
- Derivation: Hagen-Poiseuille $Q_e = \frac{\pi r_e^4}{8\eta\ell_e}(p_c - p_{c'}) = G_e\Delta p$; volume conservation at node: sum signed edge flows = source - sink; arterial supply/venous drain as conductance-pressure terms; neural source as model forcing.
- Qualification: c_a must include geometric/viscous constants; k' n_c/V_cortex needs coupling coefficient with flow units; boundary conditions needed; balance + constitutive choices.
- Aleph: Eq. 5.6
- Changes: A.6 continuous capillary mesh & Kirchhoff; A.7/A.8 3D graph + HP conductances; Aleph adds neural source.

### E10: Stuart-Landau LC oscillator
- Section: 4.2
- Tier: 2
- Equation: $\frac{dNE_{LC}}{dt} = (\lambda_{LC} + i\omega_{LC})NE_{LC} - |NE_{LC}|^2 NE_{LC} - g_{GABA}NE_{LC} - g_{\alpha2}NE_{LC}$
- Derivation: center-manifold reduction near supercritical Hopf: $dZ/dt = (\lambda+i\omega)Z - c|Z|^2 Z$, c rescaled to 1; real part growth, imaginary frequency, cubic saturates; inhibitory/autoreceptor terms appended as reductions of linear growth rate.
- Checks: NE_LC must be complex amplitude; g's in 1/time; need mapping amplitude->NE release.
- Aleph: Eq. 5.7
- Changes: A.9 introduced, coupled to vasomotion and Peclet; A.10 retained.

### E11: Hopf normal form (intermediate) — Sec 4.2, Tier 2: $dZ/dt = (\lambda + i\omega)Z - c|Z|^2 Z$.

### E12: Pennes bioheat + thermal dilation
- Section: 4.3
- Tier: 2
- Equation: $\rho C_p \frac{\partial T}{\partial t} = k_{th}\nabla^2 T - \omega_b C_b (T - T_b) + Q_{laser}(x,\lambda)$; $\Delta r_{e,thermal} = r_{e0}\kappa_T \max(0, T - T_b)$
- Derivation: first law for continuum; Fourier $q = -k_{th}\nabla T$ -> $k_{th}\nabla^2 T$; Pennes perfusion exchange $-\omega_b C_b(T-T_b)$; optical absorption as volumetric source. Radius law = separate phenomenological linear-rectified relation, not derived from Pennes.
- Checks: units of omega_b; kappa_T needs measurement; boundary conditions.
- Cited: Pennes 1948, Fourier
- Aleph: Eq. 5.8
- Changes: Aleph adds Pennes to correct photothermal artifact absent in A.10.

### E13: Fourier law — Sec 4.3, Tier 2: $q = -k_{th}\nabla T$.

### E14: Optical heat deposition
- Section: 4.4
- Tier: 2
- Equation: $Q(x,\lambda) = \mu_a(\lambda)\Phi(x)$; $\mu_a(\lambda) = \ln(10)([HbO_2]\varepsilon_{HbO_2}(\lambda) + [HbR]\varepsilon_{HbR}(\lambda)) + \mu_{a,water}(\lambda) + \mu_{a,lipid}(\lambda)$
- Derivation: absorbed power density = absorption coefficient × fluence rate (radiative transfer); Beer-Lambert; base-10 -> natural conversion gives ln(10); additive mixture of absorbers.
- Checks: Q in W/m^3 only if Phi is fluence rate W/m^2, mu_a m^-1; diffusion approximation not accurate near small source.
- Aleph: Eq. 4.2
- Changes: replaces arbitrary optical-heating scalar.

### E15: Capillary stall probability
- Section: 4.5
- Tier: 2
- Equation: $P(stall_e) = [1 + \exp(-(\beta_{adh}[ICAM\text{-}1]_e + \beta_{geom}(r_{crit}/r_e)^2 - \beta_{shear}(\tau_{w,e}/\tau_{crit})))]^{-1}$; $G_e = S_e G_{Poiseuille}$
- Derivation: logistic link $p = 1/(1+e^{-\eta})$ maps predictor to probability; predictor combines adhesion, geometry, shear; Bernoulli S_e (1 patent, 0 stalled) switches conductance.
- Qualification: statistical choice, not from Navier-Stokes/adhesion mechanics; betas need fitting; argument must be dimensionless; reopening, correlation, percolation threshold unspecified.
- Aleph: Eq. 5.9
- Changes: A.10.1 final-fix adds stall/percolation operator.

### E16: Generic substrate balance
- Section: 5.1
- Tier: 3
- Equation: $\frac{dC_k}{dt} = \sum_j J_{j\to k} - \sum_j J_{k\to j} + R_k - U_k$
- Derivation: control-volume balance; stoichiometric coefficients required (1 glucose -> 2 lactate); carbon conservation: weight each pool by carbon content and sum, internal transfers cancel.
- Aleph: Tier 3 six-pool metabolism / carbon balance
- Changes: A.6 lumped ATP -> multi-substrate; A.7/A.8 G, L, Gamma, p, o, a; retained A.8/A.10 with PCr buffer.

### E17: ATP balance
- Section: 5.2
- Tier: 3
- Equation: $\frac{da}{dt} = 2v_{gn} + Y_{ox}v_{ox} - D$
- Derivation: bookkeeping of glycolytic and OXPHOS ATP production minus demand; valid only if 2 and Y_ox are ATP yields per flux unit; should not be called a thermodynamic law.
- Aleph: inherited Tier 3 ATP balance (A.7 example)

### E18: Sodium amount balance
- Section: 5.3
- Tier: 1 (sodium debt ledger) / 3
- Equation: $\frac{d n_{Na}}{dt} = J_{Na,in} - J_{Na,pump}$
- Derivation: ionic amount balance, convert to concentration by volume; pump ATP- and Na-dependent. A.6 corrected zero-ATP unbounded-load by adding a sodium driving-force factor. Caution: zero ATP cost for Cl- currents is coarse.
- Aleph: inherited sodium debt ledger

### E19: Leaky AIS controllers
- Section: 6.1
- Tier: 4
- Equation: $\tau_L \frac{dL_i}{dt} = -(L_i - L_0) - G_L L_0(\bar c_i - 1)$; $\tau_x\frac{dx_i}{dt} = -(x_i - x_0) + G_x(\bar c_i - 1)$
- Derivation: first-order relaxation to baselines; activity term shifts equilibrium proportional to deviation of mean activity from set point.
- Aleph: Tier 4 AIS controller (L, x) (g_AIS not given)
- Changes: A.6 adds AIS length/position; A.7/A.8 retain.

### E20: AIS threshold law
- Section: 6.1
- Tier: 4
- Equation: $\theta_{AIS,i} = -k_B\ln(L_i/L_0) - k_x\ln(x_i/x_0)$
- Derivation: constitutive mapping encoding diminishing sensitivity to multiplicative changes; not implied by cable theory; k_B, k_x to be fit to threshold/rheobase.
- Aleph: Tier 4 threshold law; introduced A.6.

### E21: Conductance-based membrane (CA1 layer)
- Section: 6.2
- Tier: 5
- Equation: $C_m dV/dt = -\sum_j g_j(V-E_j) + I_{syn} + I_{ext}$ (gating variables by kinetic eqs)
- Derivation: stated as correct basis; node eviction is a separate hybrid event rule needing death criterion, threshold, hysteresis, bookkeeping. A.6 fast-ripple implementation was hypersynchronous (unresolved).
- Aleph: Tier 5 CA1 spiking / eviction (A.10)

### E22: Synaptic capture SDE
- Section: 7.1
- Tier: 6
- Equation: $\tau_c\, dc_{ij}/dt = \Omega_{ij}\pi(a)(1-c_{ij}) + \beta_c c_{ij}^2(1-c_{ij})/(K_c^2 + c_{ij}^2) - \gamma_c c_{ij} + \sigma_c c_{ij}(1-c_{ij})\, dB_{ij}$
- Derivation: energy-gated capture + positive-feedback (bistability) + linear decay; multiplicative noise c(1-c) vanishes at 0 and 1, helps preserve interval but invariance needs formal argument (Ito/Stratonovich). Kramers escape approximates transitions; power-law forgetting does not follow automatically.
- Aleph: Tier 6 condensate capture SDE
- Changes: A.3 bistable capture; A.6 boundary fix; A.7/A.8 energy-gated + sleep pruning.

### E23: AQP4 hydraulic floor
- Section: 7.3
- Tier: 6
- Equation: $L_p(t) = L_{p,min} + (L_{p,0} - L_{p,min})\exp(\lambda(P_{AQP4}(t) - 1))$
- Derivation: exponential constitutive map with floor; P in [0,1], lambda>0 -> exp in [e^{-λ},1]; at P=1, L_p = L_{p,0}; positive, bounded below. Requires lambda dimensionless, L_{p,0} > L_{p,min} ≥ 0. Numerical regularization, not biology proof.
- Aleph: Eq. 5.11
- Changes: A.9 AQP4 degradation; A.10 adds floor; Aleph retains.

### E24: HDAC chromatin operator
- Section: 7.4
- Tier: 6
- Equation: $\tau_{epig}\frac{dH_{HDAC}}{dt} = k_{stress}F_{chronic\_stress} - k_{acetyl}a_i H_{HDAC}$; $k_{BDNF,eff} = k_{BDNF}/[1 + \exp(\gamma_{silence}(H_{HDAC} - \theta_{epig}))]$
- Derivation: driven first-order state (stress accumulates, ATP-dependent removal); logistic smooth-switch repression of BDNF. Phenomenological; units/normalization of H undefined.
- Aleph: Eq. 5.10
- Changes: new in Aleph (HDAC2/5).

### E25: Stress coefficient
- Section: 7.5
- Tier: 6
- Equation: $k_{stress} = k_{transloc}\cdot\frac{CORT_{free}^{n_H}}{K_{d,GR}^{n_H} + CORT_{free}^{n_H}}$
- Derivation: Hill occupancy × nuclear translocation rate; k_transloc 1/time, bracket dimensionless. Not first-principles for GR homodimerization.
- Aleph: Eq. 4.1

### E26: Black-Leff operational model
- Section: 8.1
- Tier: 1
- Equation: $E/E_{max} = \tau[L]/(K_A + (\tau+1)[L])$
- Derivation: occupancy-response with receptor reserve and transduction parameter tau; equilibrium & saturation assumptions.
- Cited: Black & Leff 1983
- Aleph: inherited Black-Leff (A.9)

### E27: PLC-IP3-Ca cascade — Sec 8.2, Tier 1: no equation; source equations "not fully legible"; mechanism chain only.

### E28: Peclet number
- Section: 8.3 — Tier 2 — $Pe = vL/D$; derivation: $Pe = (L^2/D)/(L/v) = vL/D$ from nondimensionalizing advection-diffusion. Aleph: inherited perivascular Peclet.

### E29: Hagen-Poiseuille conductance
- Section 8.4 — Tier 2 — $G_e = \pi r_e^4/(8\eta\ell_e)$; $Q_e = G_e\Delta p$; steady laminar Newtonian, rigid tube, no-slip, low Re.

### E30: Wall shear stress — Section 8.4, Tier 2: $\tau_w = 4\eta Q/(\pi r_e^3)$; same assumptions.

### E31: Capillary stall threshold
- Section 9.1 — invariant — $\Pi_{stall} = \sum_{e\in stalled}\ell_e/\sum_{e\in total}\ell_e \ge p_c^* \approx 0.075$. Critique: dimensionless but 0.075 not derivable; topology dependent.

### E32: DBS suppression ratio
- Section 9.2 — invariant — $\Omega_{DBS} = f_{DBS}/f_\beta \ge 1/(\pi\tau_{GABA,I} f_\beta) \approx 4.3$. Critique: needs inhibitory kernel derivation; proposed criterion.

### E33: Glymphatic stability ratio
- Section 9.3 — invariant — $\Lambda_{glymph} = (k_0 L_{p,0}\Delta p_{PVS})/(\dot m_{prod}R_{PVS}) > 1$. Critique: dimensionality unclear.

### E34: Ischemic horizon
- Section 9.4 — invariant — $K_{ischemia} = ([PCr]_0 + 2[ATP]_0 + 2\Gamma_0)/(\lambda_n n_{eq} F_{Faraday})$. Critique: units don't reduce to time; should integrate energy balance.

### E35: Pore-block selectivity
- Section 9.5 — invariant — $\Psi_{pore} = \frac{k_{off}}{k_{on}[Glu]_{peak}}\exp(z\delta_B F v_{spike}/(RT_b)) \ge 1$. Critique: dimensionless but a proposed criterion.

### E36: Gap-junction synchronization
- Section 9.6 — invariant — $\Sigma_{sync} = (g_{gap}\lambda_2(L_{gap}))/(\bar g_{GABA}\sigma_v^2) \ge 1$. Critique: units 1/V^2 unless normalized; needs master-stability derivation.

### E37: Neurotrophic hysteresis
- Section 9.7 — invariant — $\Xi_{BDNF} = (\kappa_{BDNF}k_{BDNF}a_i)/(\gamma_{prune}(1+\exp(\gamma_{silence}(H_{HDAC}-\theta)))S_{set,0})$ (no threshold printed). Critique: sigmoid alone not hysteresis.

### E38: Vasomotion/peristalsis
- Section 9.8 — invariant — $\Phi_{peristalsis} = \frac{\omega_{LC}\tau_v}{\sqrt{1+(\kappa_{stiff}C_{amyloid})^2}}\cdot\frac{r_{a0}^4}{8\eta R_{PVS}D} \ge 1$. Critique: second factor not obviously dimensionless.

### E39: Ictal wavefront velocity
- Section 9.9 — invariant — $c_{ictal} = 2\sqrt{D_K[(\nu_K r_{max}h_K(k_c)/\Delta k_c) - 1/\tau_K]}$. Justification: Fisher-KPP-like pulled front $2\sqrt{D\cdot\text{growth}}$; bracket must be 1/time and positive.

### E40: Optothermal threshold
- Section 9.10 — invariant — $\Theta_{optothermal} = \frac{\mu_a(\lambda)P_{laser}\delta_{pulse}}{(\omega_b C_b + k_{th}/r_{beam}^2)\cdot 0.5\,^\circ C} < 1$. Critique: units depend on P_laser/delta_pulse; should bound Pennes solution.

### Non-equation claims (Sec 10): allosteric ceiling vs r_min>0, ketamine 4.74-fold ratio, SSRI 14-21 day latency, tachyphylaxis fractal scaling, cross-species invariant — prose critiques only, no equations.
