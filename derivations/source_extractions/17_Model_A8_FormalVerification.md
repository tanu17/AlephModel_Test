# Extraction: Model_A8_FormalVerification.lean
- Model version(s) specified: Model A.8 (namespace ModelA8)
- One-paragraph summary of the file: Lean 4 (Mathlib) file "LEAN 4 FORMAL VERIFICATION: MODEL A.8 BIOPHYSICAL FOUNDATIONS". Header promises four results: (1) forward invariance of the intracellular sodium debt ledger on [0, n_eq]; (2) invariance of the synaptic capture probability interval [0,1]; (3) positive-definiteness and uniqueness of Kirchhoff graph fluid pressures; (4) exact algebraic carbon mass balance. Defines Michaelis-Menten operator, Na+/K+ pump, sodium influx drive, dn/dt, capture SDE drift/diffusion, four metabolic pool ODEs, and proves boundary lemmas and carbon closure. Item (3) (Kirchhoff) is announced in the header and Matrix.PosDef is imported, but NO definition or theorem for it exists in the file.
- Parts that could not be read (if any): none (171 lines, read fully).

### E1: Michaelis-Menten kinetic operator
- Section in source: `def mm`
- Tier: other (helper used in Tier 1/3)
- Equation: $\mathrm{mm}(x,K) = \dfrac{x}{x+K}$
- Symbols: x substrate, K half-saturation constant.
- Derivation or justification: none given.
- Physical law cited: Michaelis-Menten kinetics (name only).
- Corresponding Aleph 1 equation: helper for inherited sodium debt ledger pump term.
- Changes vs earlier versions: none mentioned.

### E2: Na+/K+ ATPase pump extrusion rate
- Section in source: `def pump`
- Tier: 1 (sodium debt ledger) / 3 coupling (ATP a)
- Equation: $\Pi(a,n) = \Pi_{max}\,\dfrac{a}{a+K_a}\,\dfrac{n}{n+K_n}$
- Symbols: a ATP pool; n intracellular sodium debt; Pi_max > 0; K_a > 0; K_n > 0. No units.
- Derivation or justification: none given.
- Physical law cited: Na+/K+ ATPase, Michaelis-Menten.
- Corresponding Aleph 1 equation: inherited Tier 1 sodium debt ledger (pump term).
- Changes: none mentioned.

### E3: Sodium influx drive
- Section in source: `def sodium_influx_drive`
- Tier: 1
- Equation: $D_{Na} = \nu_{spk}\, r + \nu_{syn}\, G_s\, \mathrm{syn\_drive} + \lambda_n + I_{ext}$
- Symbols: nu_spk > 0 (per-spike Na load), r firing rate, nu_syn synaptic Na load coefficient, G_s synaptic conductance, syn_drive synaptic drive, lambda_n > 0 leak, I_ext external input.
- Derivation or justification: none given.
- Physical law cited: none.
- Corresponding Aleph 1 equation: inherited Tier 1 sodium debt ledger (influx term).
- Changes: none mentioned.

### E4: Sodium ledger derivative
- Section in source: `def dn_dt`
- Tier: 1
- Equation: $\dfrac{dn}{dt} = \left(\nu_{spk} r + \nu_{syn} G_s\,\mathrm{syn\_drive} + \lambda_n + I_{ext}\right)\left(1-\dfrac{n}{n_{eq}}\right) - \Pi_{max}\dfrac{a}{a+K_a}\dfrac{n}{n+K_n}$
- Symbols: n_eq > 0 equilibrium/saturation sodium level; others as E2-E3.
- Derivation or justification: none for the form; the logistic factor (1 - n/n_eq) is what makes Theorems 1-2 hold.
- Physical law cited: none.
- Corresponding Aleph 1 equation: inherited Tier 1 sodium debt ledger.
- Changes: none mentioned.

### E5: Theorem 1 – upper boundary invariance of sodium ledger
- Section in source: `theorem sodium_ledger_upper_invariant`
- Tier: invariant
- Equation: $\forall a,r,\mathrm{syn},I_{ext}\ge 0:\ \left.\dfrac{dn}{dt}\right|_{n=n_{eq}} \le 0$
- Symbols: as above.
- Derivation or justification: Docstring: "At n = n_eq, dn/dt <= 0 for all non-negative ATP, firing rates, and inputs. This rigorously precludes runaway depolarization and unbounded sodium inflation." Proof: $1 - n_{eq}/n_{eq} = 0$ (n_eq > 0), so influx term is zero and dn/dt = -pump; pump $\ge 0$ since Pi_max > 0, $a/(a+K_a)\ge0$ (a ≥ 0, K_a > 0), $n_{eq}/(n_{eq}+K_n)\ge 0$; hence $-\Pi \le 0$ (linarith).
- Physical law cited: none (forward invariance argument).
- Corresponding Aleph 1 equation: invariant of inherited sodium debt ledger.
- Changes: none mentioned.

### E6: Theorem 2 – lower boundary invariance of sodium ledger
- Section in source: `theorem sodium_ledger_lower_invariant`
- Tier: invariant
- Equation: $\forall a,r,\mathrm{syn},I_{ext}\ge 0:\ \left.\dfrac{dn}{dt}\right|_{n=0} > 0$
- Symbols: as above (proof additionally uses positivity of nu_syn*G_s*syn_drive via `positivity` though nu_syn, G_s have no stated sign hypothesis [note: not transcribed as hypothesis in structure]).
- Derivation or justification: Docstring: "At n = 0, dn/dt > 0, ensuring intracellular sodium cannot drop below zero." Proof: pump term has factor $0/(0+K_n)=0$; $1-0/n_{eq}=1$; so dn/dt = influx drive = $\nu_{spk}r + \nu_{syn}G_s\,\mathrm{syn} + \lambda_n + I_{ext}$; $\nu_{spk}r\ge0$, $\nu_{syn}G_s\,\mathrm{syn}\ge0$, $\lambda_n>0$, $I_{ext}\ge0$ ⇒ > 0.
- Physical law cited: none.
- Corresponding Aleph 1 equation: invariant of inherited sodium debt ledger.
- Changes: none mentioned.

### E7: Capture SDE drift
- Section in source: `def capture_drift` (under THEOREM 3 docstring)
- Tier: 6
- Equation: $f(c) = \Omega\,\pi_a\,(1-c) + \beta_c\,\dfrac{c^2(1-c)}{K_c^2+c^2} - \gamma_c\, c$
- Symbols: c capture probability; Omega, pi_a (drive factors), beta_c (cooperative self-reinforcement), K_c (Hill constant), gamma_c > 0 decay.
- Derivation or justification: none for form.
- Physical law cited: none (Hill n=2 form implicit).
- Corresponding Aleph 1 equation: Tier 6 condensate capture SDE (drift).
- Changes: none mentioned.

### E8: Capture SDE diffusion
- Section in source: `def capture_diffusion`
- Tier: 6
- Equation: $g(c) = \sigma_c\, c\,(1-c)$  (implied SDE $dc = f(c)\,dt + g(c)\,dW$ – SDE itself not written in file)
- Symbols: sigma_c > 0 noise amplitude.
- Derivation or justification: none for form.
- Physical law cited: none.
- Corresponding Aleph 1 equation: Tier 6 condensate capture SDE (diffusion).
- Changes: none mentioned.

### E9: Theorem 3 – boundary lemmas for capture variable
- Section in source: THEOREM 3; `capture_diffusion_vanishes_at_zero`, `capture_diffusion_vanishes_at_one`, `capture_drift_nonnegative_at_zero`, `capture_drift_negative_at_one`
- Tier: invariant
- Equation: $g(0)=0,\quad g(1)=0,\quad f(0)\ge 0\ (\Omega\ge0,\pi_a\ge0),\quad f(1) < 0$
- Symbols: as above.
- Derivation or justification: Docstring: "Drift and diffusion factors of the SDE both vanish at boundaries c = 0 and c = 1, guaranteeing that the capture variable never escapes the physical probability domain." (Note: docstring says drift vanishes at boundaries but lemmas actually show f(0) = Ω π_a ≥ 0 and f(1) = -γ_c < 0.) Proofs: g(0), g(1) by ring; f(0): Hill term $\beta_c\cdot 0^2(1-0)/(K_c^2+0)=0$, $-\gamma_c\cdot0=0$, leaving $\Omega\pi_a\ge0$; f(1): $\Omega\pi_a(1-1)=0$, Hill term $=0$, leaving $-\gamma_c<0$.
- Physical law cited: none.
- Corresponding Aleph 1 equation: invariant of Tier 6 capture SDE.
- Changes: none mentioned.

### E10: Glucose pool ODE
- Section in source: `def dG_dt`
- Tier: 3
- Equation: $\dfrac{dG}{dt} = J_G - v_{gn} - v_{ga} - v_{syn}$
- Symbols: J_G glucose influx; v_gn neuronal glycolysis(?) [unclear: subscripts not defined in file]; v_ga astrocytic glycolysis [unclear]; v_syn glycogen synthesis [unclear].
- Derivation or justification: none.
- Physical law cited: none.
- Corresponding Aleph 1 equation: Tier 3 six-pool metabolism (G).
- Changes: none mentioned.

### E11: Lactate pool ODE
- Section in source: `def dL_dt`
- Tier: 3
- Equation: $\dfrac{dL}{dt} = 2(v_{ga}+v_{gly}) + v_{ex} - J_L$
- Symbols: v_gly glycogenolysis [unclear], v_ex pyruvate-lactate exchange [unclear], J_L lactate washout (named "lactate washout" in Theorem 4 docstring).
- Derivation or justification: none.
- Corresponding Aleph 1 equation: Tier 3 (L), lactate shuttle.
- Changes: none mentioned.

### E12: Glycogen pool ODE
- Section in source: `def dGamma_dt`
- Tier: 3
- Equation: $\dfrac{d\Gamma}{dt} = v_{syn} - v_{gly}$
- Derivation or justification: none.
- Corresponding Aleph 1 equation: Tier 3 (Gamma).
- Changes: none mentioned.

### E13: Pyruvate pool ODE
- Section in source: `def dp_dt`
- Tier: 3
- Equation: $\dfrac{dp}{dt} = 2v_{gn} - v_{ox} - v_{ex}$
- Symbols: v_ox mitochondrial oxidation ("terminal mitochondrial oxidation").
- Derivation or justification: none.
- Corresponding Aleph 1 equation: Tier 3 (p).
- Changes: none mentioned.

### E14: Theorem 4 – carbon mass balance closure
- Section in source: `theorem carbon_mass_balance_closure`
- Tier: invariant
- Equation: $\dfrac{dG}{dt} + \dfrac{d\Gamma}{dt} + \dfrac{1}{2}\left(\dfrac{dL}{dt}+\dfrac{dp}{dt}\right) = J_G - \dfrac{J_L}{2} - \dfrac{v_{ox}}{2}$, i.e. $\dfrac{d}{dt}\left[G+\Gamma+\tfrac{L+p}{2}\right] = J_G - J_L/2 - v_{ox}/2$
- Symbols: as E10-E13.
- Derivation or justification: Docstring: "The time derivative of total tissue carbon (G + Gamma + (L + p)/2) strictly balances glucose influx minus lactate washout and terminal mitochondrial oxidation." Proof: unfold four ODEs and `ring` (all internal fluxes v_gn, v_ga, v_syn, v_gly, v_ex cancel algebraically). Weighting 1/2 for three-carbon species implicit.
- Physical law cited: carbon mass conservation.
- Corresponding Aleph 1 equation: Tier 3 carbon balance.
- Changes: none mentioned. Note: pools o and a (oxygen, ATP) not included in this file's ledger.

### E15 (announced, absent): Kirchhoff graph pressure positive-definiteness/uniqueness
- Section in source: header item 3 only
- Tier: 2 / invariant
- Equation: none written.
- Derivation: none; no Lean code for it exists.
- Corresponding Aleph 1 equation: Aleph Eq. 5.6 (Kirchhoff microvascular balance).
