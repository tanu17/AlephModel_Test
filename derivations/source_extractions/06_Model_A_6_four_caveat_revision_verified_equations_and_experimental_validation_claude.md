# Extraction: Model A.6 four-caveat revision, verified equations and experimental validation (claude).docx
- Model version(s) specified: Model A.6 (revision of A.5; also corrects carried-over A.4/A.5 errors; lists A.7 next steps)
- One-paragraph summary of the file: Specification and validation report for Model A.6 (dated Oct 9, 2026). It answers four A.5 caveats: (1) discrete supply domains Q replaced by a continuous capillary graph with Poiseuille conductances, Kirchhoff flow and retrograde Kir2.1 conducted vasodilation (Eqs 8-15); (2) lumped ATP e_i replaced by a six-pool metabolism G, L, Gamma, o, p, a (Eqs 16-24); (3) leaky AIS length/position controllers with a logarithmic threshold law (Eqs 25-27); (4) a conductance-based CA1 spiking layer for ripples/fast ripples sharing the Na+ ledger (Eqs 28-30). It also repairs Na+ boundedness (Eq 5), the capture SDE (Eq 33), the REM headroom projection (Eq 35), a unified sleep operator (Eq 37), NE-oscillation glymphatic flow (Eq 38), theta phase (Eq 39), axial-gradient ephaptic term (Eqs 1-2), D1 inverted-U (Eqs 3-4). Section 5 lists verified properties P1-P11; Sections 6-10 validate against literature; Section 11 scorecard (17 hold/7 partial/19 fail).
- Parts that could not be read (if any): None. All equations are given as plain text (not images). The 6 embedded PNGs (image1-image6) are captioned charts/figures (A.5 checks; mesh/occlusion; CMRO2 predictions; AIS; ripple rasters; coupled run) and were not transcribed as equations. Some text table rows were wrapped but read in full.

### E1: Notation: Michaelis saturation, logistic, positive part
- Section in source: 3 (Notation)
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): other
- Equation (LaTeX, transcribed faithfully): $$m(z,K)=\frac{z}{z+K};\quad \sigma(z)=\frac{1}{1+e^{-z}};\quad (z)_+=\max(z,0);\quad e_i = a_i/a_0$$
- Symbols as defined in the source (with units/values if given): a_i neuronal ATP (mM); e_i the A.2-A.5 variable; spike-frequency adaptation renamed w_i (was a_i in A.5).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given (definitions)
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): helper notation used throughout
- Changes vs earlier model versions that the source mentions: e_i (A.2-A.5) now = a_i/a_0; adaptation renamed a_i -> w_i.

### E2: Somatic potential with K_ATP brake, cholinergic gating, axial ephaptic term (Eq. 1)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$\tau_v \frac{dv_i}{dt} = -(v_i-v_{rest}) - g_K(a_i)(v_i-E_K) + G_s\,\zeta\,(1-\nu\,ACh)\sum_j s_j W_{ij} x_{ij} r_j(t-\tau_{ij}) + G_s(1+\nu\,ACh) I_i(t) + g_{ax}\left[(v_{d,i}-v_i) + (V_e(x_{d,i})-V_e(x_{s,i}))\right],\qquad g_K(a)=\frac{\bar g_K}{1+(a/K_A)^{n_K}}$$
- Symbols as defined in the source (with units/values if given): v_i somatic potential (mV scaled); v_d,i dendritic potential; a_i neuronal ATP (mM); W_ij weight; x_ij vesicle fraction; r_j rate; tau_ij axonal delays; g_ax axial conductance; V_e extracellular potential at dendrite x_d,i and soma x_s,i; s_j, zeta, nu, ACh, G_s, I_i not newly defined (A.4 values).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'The field enters only through the axial current, so a uniform potential cancels and a gradient polarises soma and dendrite in opposite directions, as in Bikson et al. 2004.' Delays make state space C([-tau_max,0]). Verified in P10.
- Physical law / prior model / literature it cites: Bikson et al. 2004
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes vs earlier model versions that the source mentions: C15: ephaptic coupling now through axial current between soma and dendrite (A.5 had a uniform-field term in Eqs 1, 27 which has no effect on a point cell). Delays tau_ij now explicit.

### E3: Dendritic compartment with dCaAP (Eq. 2)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$C_d \frac{dv_{d,i}}{dt} = -g_L(v_{d,i}-E_L) + \bar A_{Ca}\,\Delta(u_{d,i}) - g_{HCN}(DA)(v_{d,i}-E_{HCN}) + \sum_{j\in apical} W_{ij}x_{ij}r_j(t-\tau_{ij}) - g_{ax}\left[(v_{d,i}-v_i)+(V_e(x_{d,i})-V_e(x_{s,i}))\right],\qquad \Delta(u)=H(u-u_{th})\exp\!\left(-\frac{u-u_{th}}{w_{Ca}}\right)$$
- Symbols as defined in the source (with units/values if given): Delta = dCaAP activation 'largest at threshold, damped above'; H Heaviside; u_th threshold; w_Ca decay width.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'The dCaAP shape is what lets one human L2/3 cell compute XOR (Gidon et al. 2020).' A monotone activation gives OR not XOR (Section 1b).
- Physical law / prior model / literature it cites: Gidon et al. 2020
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited Tier 1 dendritic potential
- Changes vs earlier model versions that the source mentions: C17: dCaAP activation now peaks at threshold and decays above; A.5 never defined I_dCaAP.

### E4: D1 -> HCN shunt (Eq. 3)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$g_{HCN}(DA)=\frac{\bar g_{HCN}\,DA^3}{K_D^3+DA^3}$$
- Symbols as defined in the source (with units/values if given): DA dopamine; D1 -> cAMP -> HCN opening.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Eqs 3-4 together give inverted-U: 'low DA leaves non-preferred inputs unsuppressed, and high DA shunts everything.' A single monotone shunt only lowers selectivity (Section 1b simulation).
- Physical law / prior model / literature it cites: Arnsten 2011; Gamo 2015
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): none (inherited Tier 1 receptor/dendritic pharmacology)
- Changes vs earlier model versions that the source mentions: C16; same Hill form as the A.5 claim g_HCN = g bar DA^3/(K^3+DA^3), now paired with Eq. 4.

### E5: D1 suppression of non-preferred inputs (Eq. 4)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$s_{np}(DA)=1-\frac{\sigma_1 DA^2}{K_1^2+DA^2}$$
- Symbols as defined in the source (with units/values if given): s_np suppression factor on non-preferred inputs.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): See E4: needed for the rising limb of the inverted-U.
- Physical law / prior model / literature it cites: Arnsten 2011; Gamo 2015
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): none
- Changes vs earlier model versions that the source mentions: C16 new.

### E6: Na+ load with driving-force bound (Eq. 5)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$\frac{dn_i}{dt}=\left[\nu_{spk} r_i + \nu_{syn} G_s\sum_j W_{ij}x_{ij}r_j + \lambda_n + \frac{I_{ChR2,Na}}{F\cdot Vol_i}\right]\left(1-\frac{n_i}{n_{eq}}\right) - \Pi_i$$
- Symbols as defined in the source (with units/values if given): n_i normalised intracellular Na+ (n_c=4, n_eq=12); lambda_n leak; I_ChR2,Na optogenetic Na current; F Faraday; Vol_i volume.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'The factor (1 - n/n_eq) is the falling Na+ driving force, and it bounds n.' See P1.
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited sodium debt ledger
- Changes vs earlier model versions that the source mentions: C10: factor (1 - n/n_eq) added; A.4/A.5 Eq. 7 Na+ load was unbounded at zero ATP (n=23 after 400 s and rising).

### E7: Na/K pump flux (Eq. 6)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$\Pi_i=\Pi_{max}\,m(a_i,K_a)\,m(n_i,K_n)\quad(3\ \text{Na}^+\ \text{per ATP})$$
- Symbols as defined in the source (with units/values if given): Pi_max max pump rate.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited sodium debt ledger
- Changes vs earlier model versions that the source mentions: none stated

### E8: Firing-rate transfer and adaptation (Eq. 7)
- Section in source: 3, Tier 1
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 1
- Equation (LaTeX, transcribed faithfully): $$r_i=\left[1+(n_i/n_c)^6\right]^{-1} h_K(k_{c(i)})\,\varphi\!\left(g(NE)(v_i-\theta_i-w_i-\theta_0-\theta_{AIS,i})\right),\qquad \tau_w\frac{dw_i}{dt}=-w_i+m_w r_i$$
- Symbols as defined in the source (with units/values if given): h_K function of extracellular K+ at node c(i); phi transfer function; g(NE) noradrenergic gain; theta_i homeostatic threshold; w_i adaptation; theta_AIS,i from Eq. 27.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited firing-rate transfer function
- Changes vs earlier model versions that the source mentions: Adds theta_AIS,i; adaptation renamed w_i.

### E9: Capillary graph Poiseuille conductance (Eq. 8)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$G_e=\frac{r_e^4}{\ell_e}$$
- Symbols as defined in the source (with units/values if given): nodes c, segments e of length ell_e, radius r_e. Values: median segment 45 um; degree 3; capillary radius 2.2 um, arteriole 6.0 um.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Poiseuille'. Discrete domains are the limit ell -> 0 with nodes grouped by arteriole territory.
- Physical law / prior model / literature it cites: Poiseuille; Ji 2021; Blinder 2013
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited Hagen-Poiseuille conductance
- Changes vs earlier model versions that the source mentions: C1: replaces discrete supply domains Q.

### E10: Kirchhoff node balance (Eq. 9)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$\sum_{e\ni c} G_e(p_c-p_{c'}) = c_a r_a^4 (P_a-p_c)\cdot[c\ \text{is an arteriole root}] - G_v p_c\cdot[c\ \text{is a venule}]$$
- Symbols as defined in the source (with units/values if given): p_c node pressure (relative, P_a=1); r_a arteriole radius; G_v venule conductance; c_a constant.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Flow is set by the whole network ... occlusion and redistribution follow from Kirchhoff's law instead of being imposed.' P4: weighted graph Laplacian plus venule conductances is symmetric positive definite on a connected graph, so pressures unique.
- Physical law / prior model / literature it cites: Kirchhoff's laws
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Eq. 5.6 (Kirchhoff microvascular balance)
- Changes vs earlier model versions that the source mentions: C1 new.

### E11: Normalised node flow (Eq. 10)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$f_c=F_c/F_{c,0},\qquad F_c=\tfrac12\sum_{e\ni c}|q_e|$$
- Symbols as defined in the source (with units/values if given): q_e segment flow; F_c,0 rest flow.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 2 (Kirchhoff)
- Changes vs earlier model versions that the source mentions: new

### E12: Kir2.1 K+ source (Eq. 11)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$s_c=A_K\left[\sigma\!\left(\frac{k_c-k_{th}}{s_k}\right)\sigma\!\left(\frac{k_{off}-k_c}{s_{off}}\right) - (\text{same at } k_{rest})\right]$$
- Symbols as defined in the source (with units/values if given): k_c extracellular K+ (mM); k_th=6.8, s_k=0.5, k_off=20 mM (Longden 2017); A_K=255 effective gain (calibrated: 23 mV at 500 um).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Dev log item 3: source referenced to rest because 823 nodes x 0.015 mV summed to ~7 mV standing hyperpolarisation. Threshold built in (K+ dose response holds).
- Physical law / prior model / literature it cites: Longden et al. 2017
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited NsMJ + Kir2.1 dual dilation
- Changes vs earlier model versions that the source mentions: C2 new.

### E13: Conducted hyperpolarisation, delayed Green's-function kernel (Eq. 12)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$\Phi_m(t)=\Phi_{max}\tanh\!\left(\frac{\sum_n e^{-C_{nm}} s_n(t-d_{nm}/v_c)}{\Phi_{max}}\right),\quad C_{nm}=\text{least path cost } n\to m:\ \ell_e/\lambda_c \text{ per upstream step},\ \ell_e/\lambda_c+\ln b \text{ per downstream or lateral step}$$
- Symbols as defined in the source (with units/values if given): Phi_max=60 mV; v_c=2 mm/s; lambda_c=2 mm; b=2; d_nm path distance.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Eq. 12 is the solution of a regenerative endothelial cable reduced to its measured properties (velocity v_c, attenuation lambda_c). The junction cost ln b expresses current division at branch points.' Dev log: passive cable (lambda=1 mm) gave 0.06 mV locally, 0.03 mV at arteriole due to current division; Kir2.1 regeneration is why real signal survives, so replaced by Green's function. Isotropic kernel dilated every arteriole, so upstream steps made cheaper than lateral (ln 2 per junction).
- Physical law / prior model / literature it cites: Longden 2017
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited NsMJ + Kir2.1 dual dilation (conducted)
- Changes vs earlier model versions that the source mentions: C2 new.

### E14: Local capillary signal (Eq. 13)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$\tau_\psi\frac{d\psi_c}{dt}=-\psi_c+q_c$$
- Symbols as defined in the source (with units/values if given): q_c local neural/glutamate activity; tau_psi=1.2 s.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: Hall 2014; Isaacs 2024
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited dual dilation
- Changes vs earlier model versions that the source mentions: C3 new.

### E15: Capillary radius (Eq. 14)
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$r_e=r_0(1+\beta_c\bar\psi_e)$$
- Symbols as defined in the source (with units/values if given): beta_c=0.07 (6.7% capillary dilation, Hall 2014); psi bar_e segment-average signal.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: Hall 2014
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited dual dilation
- Changes vs earlier model versions that the source mentions: C3 new.

### E16: Arteriole radius with diffusible vasodilator (Eq. 15) and neuron-node weights
- Section in source: 3, Tier 2
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 2
- Equation (LaTeX, transcribed faithfully): $$\tau_a\frac{dr_a}{dt}=r_{a0}\left[1+\beta_a\frac{\Phi_{root(a)}}{A_K}+\beta_d\sum_c\omega_{ac}\psi_c\right]-r_a,\quad \omega_{ac}\propto e^{-|x_a-x_c|/\ell_d},\ \sum_c\omega_{ac}=1;\qquad K_{ic}\propto e^{-|x_i-y_c|/\ell},\ \sum_c K_{ic}=1$$
- Symbols as defined in the source (with units/values if given): tau_a=2 s; beta_a=2.74 (33% dilation); beta_d=2.94, ell_d=100 um (Kir2.1 KO leaves 51%).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Longden's Kir2.1 knockout leaves 51% of response so a second arteriolar route must exist.
- Physical law / prior model / literature it cites: Longden 2017; Hall 2014; Isaacs 2024
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited dual dilation / noradrenergic vasomotion
- Changes vs earlier model versions that the source mentions: C3 new; K_ic replaces domain membership.

### E17: GLUT1 transport with flow dependence (Eq. 16)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$J_G=T_G\left[1+\gamma_G(f-1)\right]\left[\frac{G_b}{G_b+K_T}-\frac{G}{G+K_T}\right]$$
- Symbols as defined in the source (with units/values if given): G_b=5 mM, K_T=5 mM, gamma_G=0.5 (assumed); T_G from rest.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Forced by data: BBB transport at 61% capacity at rest cannot supply 30-50% CMRglc rise; without it glucose fell 80%.
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 six-pool metabolism (glucose)
- Changes vs earlier model versions that the source mentions: C4/C5 new.

### E18: O2 delivery, Buxton (Eq. 17)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$J_O=J_{O0}\,\frac{f\,E(f)}{E_0}\cdot\frac{o_a-o}{o_a-o_0},\qquad E(f)=1-(1-E_0)^{1/f}$$
- Symbols as defined in the source (with units/values if given): E extraction fraction; o_a arterial O2; o tissue O2.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Buxton delivery'
- Physical law / prior model / literature it cites: Buxton (oxygen limitation model)
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 (o pool)
- Changes vs earlier model versions that the source mentions: new

### E19: Neuronal glycolysis, pump-coupled (Eq. 18)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$v_{gn}=V_{gn}\,m(G,K_G)\,\theta(a)\left[1+\chi_g\left(\frac{D_{set}}{D_0}-1\right)\right]_+,\qquad \theta(a)=\frac{a_{max}-a}{a_{max}-a+K_d}$$
- Symbols as defined in the source (with units/values if given): chi_g=1.49 (calibrated, Dienel 2025 ratio 2:1); K_G=0.5 mM.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Glycolysis and OXPHOS are both driven by ADP (theta). Neuronal glycolysis also tracks pump demand (chi_g), because the Na+/K+ pump draws preferentially on glycolytic ATP; this is the term that makes lactate rise during activation.' Without it lactate fell -4%.
- Physical law / prior model / literature it cites: Dienel 2025
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3
- Changes vs earlier model versions that the source mentions: C5 new.

### E20: Astrocytic glycolysis, ANLS (Eq. 19)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$v_{ga}=m(G,K_G)(V_{ga0}+\varphi V_{glu} u)$$
- Symbols as defined in the source (with units/values if given): u glutamate cycling; phi ANLS share=0.5 (assumed, not identifiable from bulk data).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): scales with glutamate uptake; phi ANLS share
- Physical law / prior model / literature it cites: ANLS
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 lactate shuttle
- Changes vs earlier model versions that the source mentions: new

### E21: Glycogen synthesis (Eq. 20)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$v_{syn}=V_{syn}\,m(G,K_{Gs})(1-\Gamma/\Gamma_{max})$$
- Symbols as defined in the source (with units/values if given): Gamma glycogen (glucosyl, mM).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Glycogen synthesised from glucose.
- Physical law / prior model / literature it cites: Oz 2015
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 (Gamma pool)
- Changes vs earlier model versions that the source mentions: new

### E22: Glycogenolysis (Eq. 21)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$v_{gly}=V_{gl}\,m(\Gamma,K_\Gamma)\left[1+c_K(u-1)_+ + c_{NE}NE + c_h\sigma\!\left(\frac{G_h-G}{s_h}\right)+c_{h2}\sigma\!\left(\frac{G_{h2}-G}{s_{h2}}\right)\right]$$
- Symbols as defined in the source (with units/values if given): c_h=4, c_h2=40, G_h=0.4, G_h2=0.12 mM (mild vs severe glucose lack).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): broken down by K+, NE and glucose lack; graded glycogenolysis under severe glucose lack forced by data (C6).
- Physical law / prior model / literature it cites: Wender 2000
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3
- Changes vs earlier model versions that the source mentions: C6 new.

### E23: OXPHOS, LDH/MCT exchange, lactate efflux (Eq. 22)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$v_{ox}=V_{ox}\,m(p,K_p)\,m(o,K_o)\,\theta(a);\quad v_{ex}=k_{ex}(p-L/\rho);\quad J_L=k_{Lb}(L-L_b)$$
- Symbols as defined in the source (with units/values if given): K_p=50 uM, K_o=3 uM, k_ex=1 s^-1, rho=10, L_b=0.715 mM.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): exchange through LDH/MCT towards L/p = rho.
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 OXPHOS / lactate shuttle
- Changes vs earlier model versions that the source mentions: new

### E24: Pool balances G, L, Gamma, p, o (Eq. 23)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$\frac{dG}{dt}=J_G-v_{gn}-v_{ga}-v_{syn};\ \frac{dL}{dt}=2(v_{ga}+v_{gly})+v_{ex}-J_L;\ \frac{d\Gamma}{dt}=v_{syn}-v_{gly};\ \frac{dp}{dt}=2v_{gn}-v_{ox}-v_{ex};\ c_O\frac{do}{dt}=J_O-3v_{ox}$$
- Symbols as defined in the source (with units/values if given): rest G,L,Gamma,o,a = 1.2, 0.8, 7.0, 0.035, 2.5 mM.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Rest state solved exactly (CMRglc 0.30 umol/g/min, OGI 5.3, AG 11.7%). See P5.
- Physical law / prior model / literature it cites: Vaishnavi 2010; Herculano-Houzel 2011
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 carbon balance
- Changes vs earlier model versions that the source mentions: C4 new.

### E25: Neuronal ATP balance and demand (Eq. 24)
- Section in source: 3, Tier 3
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 3
- Equation (LaTeX, transcribed faithfully): $$\frac{da}{dt}=2v_{gn}+Y_{ox}v_{ox}-D,\quad D=D_{set}\frac{m(a,K_{aD})}{m(a_0,K_{aD})},\quad D_{set}=\Pi/3+m(a)\left[P_0+\beta\sum W+\kappa\sum|dW/dt|+\kappa_c\sum dc^+/dt\right]$$
- Symbols as defined in the source (with units/values if given): Y_ox=14.5 (29 ATP per glucose oxidised); K_aD=0.5 mM; bracket = A.2 consumption terms.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'The A.2 consumption terms are kept intact inside D_set, so the energy ledger, the K_ATP brake and the energy-aware set point all now read a produced ATP.' ATP-dependent demand forced by data (C6).
- Physical law / prior model / literature it cites: A.2 consumption terms
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 3 ATP balance
- Changes vs earlier model versions that the source mentions: C4/C6: replaces lumped e_i.

### E26: AIS Ca2+ proxy (Eq. 25)
- Section in source: 3, Tier 4
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 4
- Equation (LaTeX, transcribed faithfully): $$\tau_c\frac{d\bar c_i}{dt}=-\bar c_i+c_i(t)$$
- Symbols as defined in the source (with units/values if given): c_i Ca2+/depolarisation proxy, c=1 at normal activity.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Both AIS changes act through L-type Ca2+ and calcineurin, hence shared proxy.
- Physical law / prior model / literature it cites: Evans 2015; Grubb & Burrone 2010
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 4 AIS controller
- Changes vs earlier model versions that the source mentions: C7 new.

### E27: Leaky AIS length and position controllers (Eq. 26)
- Section in source: 3, Tier 4
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 4
- Equation (LaTeX, transcribed faithfully): $$\tau_L\frac{dL_i}{dt}=-(L_i-L_0)-G_L L_0(\bar c_i-1);\quad \tau_x\frac{dx_i}{dt}=-(x_i-x_0)+G_x(\bar c_i-1),\ \text{projected onto }[L_{min},L_{max}]\times[x_{min},x_{max}]$$
- Symbols as defined in the source (with units/values if given): L_0=22, x_0=25 um; tau_L=5.7 h, G_L=0.33 (Evans 2015); tau_x=24 h, G_x=6 um (assumed, Grubb 2010).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Depolarisation shortens AIS within hours (Evans 2015), moves it distally over days (Grubb & Burrone 2010); deprivation lengthens (Kuba 2010, Jamann 2021). 'The relaxation terms are required: without them the AIS and the threshold controller of Eq. 31 form two integrators on one error, and the system has no unique equilibrium.'
- Physical law / prior model / literature it cites: Evans 2015; Grubb & Burrone 2010; Kuba 2010; Jamann 2021
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 4 (L, x)
- Changes vs earlier model versions that the source mentions: C7 new; pure-integral version left AIS 1.8 um off target.

### E28: AIS threshold law (Eq. 27)
- Section in source: 3, Tier 4
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 4
- Equation (LaTeX, transcribed faithfully): $$\theta_{AIS,i}=-k_B\ln(L_i/L_0)-k_x\ln(x_i/x_0)$$
- Symbols as defined in the source (with units/values if given): k_B, k_x = 5 mV.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): resistive coupling (Goethals & Brette 2020).
- Physical law / prior model / literature it cites: Goethals & Brette 2020
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 4 threshold law
- Changes vs earlier model versions that the source mentions: C7 new; A.7 proposed adding -k ln g term.

### E29: CA1 spiking membrane (Eq. 28)
- Section in source: 3, Tier 5
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 5
- Equation (LaTeX, transcribed faithfully): $$\tau_m\frac{dV_k}{dt}=-(V_k-E_L)-g_{e,k}(V_k-E_e)-g_{i,k}(V_k-E_i)+\sigma_{ch}\sqrt{2\tau_m}\,\xi_k(t)$$
- Symbols as defined in the source (with units/values if given): spike at V_th, reset, refractory; N_E=400, N_I=80, tau_E=15 ms, tau_I=5 ms.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Ripples come from pyramidal-interneuron cycles (Stark 2014).
- Physical law / prior model / literature it cites: Stark 2014
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 5 CA1 conductance layer
- Changes vs earlier model versions that the source mentions: C8 new.

### E30: Synaptic conductance jumps and decay (Eq. 29)
- Section in source: 3, Tier 5
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 5
- Equation (LaTeX, transcribed faithfully): $$g_{x,k}\to g_{x,k}+w_{kj}\ \text{at each spike of } j\ (\text{after delay } d),\qquad \frac{dg_{x,k}}{dt}=-g_{x,k}/\tau_x\ (x=\text{AMPA},\text{GABA}_A)$$
- Symbols as defined in the source (with units/values if given): tau_AMPA=1.0, tau_GABA=1.5, delay 0.6 ms.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): tuned once for ripple near 150 Hz
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 5
- Changes vs earlier model versions that the source mentions: C8 new.

### E31: Spike Na+ charge and pathology (Eq. 30)
- Section in source: 3, Tier 5
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 5
- Equation (LaTeX, transcribed faithfully): $$\text{every spike adds }\nu_{spk}\text{ to } n\ (\text{Eq. 5});\ \text{pathology}=\text{PV in depolarisation block}+\text{recurrent E-E clusters}$$
- Symbols as defined in the source (with units/values if given): clusters 2x150 cells, p_in 0.3, w_in 0.15.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Fast ripples from failed perisomatic inhibition and interconnected clusters; 'Sharing the Na+ ledger makes the energetic cost of each event explicit.'
- Physical law / prior model / literature it cites: Schlingloff 2025; Bragin 2000
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 5 PV depolarization block
- Changes vs earlier model versions that the source mentions: C9 new; replaces A.5 channel-noise hypothesis.

### E32: Energy-aware homeostatic threshold (Eq. 31)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\tau_\theta\frac{d\theta_i}{dt}=r_i-\rho_i\chi(a_i/a_0),\quad \chi(e)=\frac{e^4}{e^4+e_h^4},\quad \ln\rho_i\sim N(\mu_\rho,\sigma_\rho^2)$$
- Symbols as defined in the source (with units/values if given): rho_i set point.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given here; see P8
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): inherited energy-aware set point
- Changes vs earlier model versions that the source mentions: reads produced ATP a_i/a_0

### E33: Weight dynamics (Eq. 32)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\tau_w\frac{dW_{ij}}{dt}=(1-b_m)\left[(s_Q+\psi(1-s_Q))DA^+f^+_{ij}(w_{max}-W_{ij})-(1+DA^-)f^-_{ij}W_{ij}-E_{ij}\right]-\gamma(1-P_{ij})W_{ij}$$
- Symbols as defined in the source (with units/values if given): s_Q, E_ij as in A.4 Eqs 15-16; Q = set of synapses drawing on one capillary node.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: A.4 Eqs 15-16
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 synaptic headroom
- Changes vs earlier model versions that the source mentions: eviction now inside (1-b_m) bracket; Q redefined.

### E34: Capture SDE (Eq. 33)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\tau_c\,dc_{ij}=\left[\Omega_{ij}\pi(a)(1-c_{ij})+\frac{\beta_c c_{ij}^2(1-c_{ij})}{K_c^2+c_{ij}^2}-\gamma_c c_{ij}\right]dt+\sigma_c c_{ij}(1-c_{ij})\,dB_{ij}$$
- Symbols as defined in the source (with units/values if given): pi(a) energy gate; B_ij Brownian motion.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'Eq. 33 vanishes in drift and noise at c=0 and c=1, so the interval is invariant' (P2).
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 condensate capture SDE
- Changes vs earlier model versions that the source mentions: C11: (1-c) factors and multiplicative noise; A.5 additive noise let c leave [0,1] (98% of paths).

### E35: Tag dynamics and protection (Eq. 34)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\tau_\Omega\frac{d\Omega_{ij}}{dt}=\kappa_\Omega DA^+f^+_{ij}(1-\Omega_{ij})-\Omega_{ij},\quad P_{ij}=\max(\Omega_{ij},c_{ij})$$
- Symbols as defined in the source (with units/values if given): 
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6
- Changes vs earlier model versions that the source mentions: none stated

### E36: Projected REM jump (Eq. 35)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\Delta W=\lambda_Q\cdot\eta_R P(w_{max}-W)-\pi_R(1-P)\sigma\!\left(\frac{w_p-W}{s_w}\right)W,\quad \lambda_Q=\min\left\{1,\frac{h_Q/\beta+\sum dec}{\sum inc}\right\}$$
- Symbols as defined in the source (with units/values if given): h_Q headroom.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): keeps h_Q >= 0 across the jump; P3: lambda_Q chosen so beta(lambda_Q Sum inc - Sum dec) <= h_Q.
- Physical law / prior model / literature it cites: A.4 Theorem 3
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 sleep pruning / headroom
- Changes vs earlier model versions that the source mentions: C12: REM jump previously broke barrier (h -> -0.011).

### E37: Adenosine (Eq. 36)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\frac{d[Ado]}{dt}=\eta\Pi_Q-\lambda_u[Ado]-v_{glymph}[Ado]$$
- Symbols as defined in the source (with units/values if given): Pi_Q pump flux over Q.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none given
- Physical law / prior model / literature it cites: none
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 sleep
- Changes vs earlier model versions that the source mentions: none stated

### E38: Unified wake/sleep synapse operator (Eq. 37)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\text{wake: }\frac{dS}{dt}=g_wC(t)(1+\alpha A_r);\quad \text{sleep: }S(t)=S_{set}+(S(t_0)-S_{set})\exp\!\left(-k\int u\,dt\right),\quad u=\sigma\!\left(\frac{[Ado]-\theta_A}{s_A}\right)\left[1-\sigma\!\left(\frac{NE-\theta_N}{s_N}\right)\right]$$
- Symbols as defined in the source (with units/values if given): C circadian factor; A_r arousal; S synapses/neuron.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 'writes SWS as the exact flow of the gated relaxation, so there is one sleep operator'; circadian wake factor because larvae in constant light gain no synapses awake.
- Physical law / prior model / literature it cites: Suppermpool 2024
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 circadian sleep pruning
- Changes vs earlier model versions that the source mentions: C13: SWS map and old Eq. 24 had different fixed points. Product gate kept from A.4.

### E39: Glymphatic flow driven by NE oscillation (Eq. 38)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$v_{glymph}=v_0+v_1\cdot 1_{NREM}\cdot\frac{AQP4}{AQP4_0}\cdot\frac{A_{NE}}{A_{NE}+K_{NE}}\cdot\left[1-\sigma\!\left(\frac{\bar{NE}-\theta_g}{s_g}\right)\right]$$
- Symbols as defined in the source (with units/values if given): A_NE amplitude of 0.01-0.05 Hz NE oscillation (switchable; contested).
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Follows Hauglund 2025; predicts 47% fall under zolpidem.
- Physical law / prior model / literature it cites: Hauglund 2025; Miao 2024
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph Tier 6 glymphatic peristalsis
- Changes vs earlier model versions that the source mentions: C18: A.5 Eq. 14 used 1 - sigma(mean NE), predicted 71% rise.

### E40: Theta phase precession (Eq. 39)
- Section in source: 3, Tier 6
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): 6
- Equation (LaTeX, transcribed faithfully): $$\frac{d\varphi_i}{dt}=\omega_\theta+\frac{2\pi v(t)}{L_f}$$
- Symbols as defined in the source (with units/values if given): v running speed; L_f field length.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): O'Keefe-Recce phase law; one cycle per field regardless of rate/speed (P9).
- Physical law / prior model / literature it cites: O'Keefe-Recce; Huxter 2003
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): none
- Changes vs earlier model versions that the source mentions: C14: A.5 Eq. 26 scaled with spike count.

### E41: P1 Na+ forward invariance
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$[0,n_{eq}]\ \text{forward-invariant}$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): At n=n_eq influx factor 0 and Pi>=0 so dn/dt<=0; at n=0 influx>=lambda_n>0. Check: max n 11.45 < 12.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E42: P2 Capture invariance
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$c\in[0,1]$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): Drift >=0 at c=0, -gamma_c<0 at c=1; diffusion sigma c(1-c) vanishes at both ends. 0% of 20,000 paths leave.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E43: P3 Headroom across REM
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\beta(\lambda_Q\textstyle\sum inc-\sum dec)\le h_Q$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): h: 0.0028 -> 0.000.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E44: P4 Kirchhoff uniqueness
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\text{Laplacian}+G_v\ \text{SPD}$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): pressures unique; divergence 1.2e-14.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E45: P5 Carbon/O2 ledgers
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\frac{d}{dt}\left[G+\Gamma+\frac{L+p}{2}\right]=J_G-\frac{J_L}{2}-\frac{v_{ox}}{2};\quad c_O\frac{do}{dt}=J_O-3v_{ox}$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): algebraic identities of Eq. 23; residual 1.4e-4.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E46: P6 Rest stability
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\text{all Jacobian eigenvalues real, negative}$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): time constants 0.9 s, 2.1 s, 10.5 s, 63 s, 5.5 min, 12.5 h (O2, ATP, pyruvate, lactate, glucose, glycogen).
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E47: P7 Slow-manifold limit
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\frac{da}{dt}=S(f,a)-D\ \ (\text{A.2: } de/dt=\text{supply}-\text{consumption})$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): times >> 1 min, glycogen frozen, fast pools quasi-steady; S increasing in f, decreasing in a. At 40% flow ATP 88% (A.4 lumped 47%).
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E48: P8 Unique homeostatic equilibrium
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$r_i=\rho_i\chi\Rightarrow\bar c_i=1\Rightarrow L_i=L_0,\ x_i=x_0$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): With pure integral AIS any (theta,L) with theta + k_B ln L fixed is an equilibrium. Offset 1.79 vs 0.05 um.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E49: P9 Precession one cycle
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\int 2\pi v/L_f\,dt=2\pi$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): 360 deg in all 9 cases (A.5: 90-1436 deg).
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E50: P10 Field polarisation
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$v_s=-\frac{(g_{ax}/g_s)E\ell}{1+g_{ax}/g_d+g_{ax}/g_s}\to E\ell\cdot\frac{g_d}{g_s+g_d}\ \text{(strong coupling)};\ 0\ \text{when } V_e(x_d)=V_e(x_s)$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): soma 0.118 mV per V/m (Bikson 0.12 +/- 0.05); dendrite 0.176 opposite sign.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E51: P11 Power-law forgetting
- Section in source: 5 Mathematical verification
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): invariant
- Equation (LaTeX, transcribed faithfully): $$\Delta U\propto(\beta-\beta_c)^{1.5}$$
- Symbols as defined in the source (with units/values if given): see referenced equations
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): A.4 Theorem 5 algebra unchanged; exponential barrier distribution now stated as assumption since Eq. 33 alone gives this scaling.
- Physical law / prior model / literature it cites: Bikson 2004 (P10); A.4 Theorems 1,3,5
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): Aleph emergent invariants (P1 Na bound, P2 capture interval, P5 carbon balance)
- Changes vs earlier model versions that the source mentions: listed as repairs of A.4/A.5 theorems where noted

### E52: Other relations quoted in text
- Section in source: 1b, 2b, 7, 8
- Tier (1-6, or "invariant" for emergent invariants/theorems, or "other"): other
- Equation (LaTeX, transcribed faithfully): $$N=T_\theta/T_\gamma;\quad L/p\approx 10;\quad 29\ \text{ATP per glucose}\Rightarrow Y_{ox}=14.5;\quad \text{activation: glutamate }(1+A),\ \text{demand }(1+A),\ \text{flow }(1+\kappa_f A)$$
- Symbols as defined in the source (with units/values if given): A activity level; kappa_f calibrated on Leontiev & Buxton 2007.
- Derivation or justification given in the source (quote or closely paraphrase every step, assumption and cited law; write "none given" if the file just states it): none (definitions/protocol)
- Physical law / prior model / literature it cites: Leontiev & Buxton 2007
- Corresponding Aleph 1 equation (e.g. "Aleph Eq. 5.2", "inherited Tier 3 ATP balance", or "none"): none
- Changes vs earlier model versions that the source mentions: N=7-15 with A.5's own frequencies (A.5 claimed 4-7).
