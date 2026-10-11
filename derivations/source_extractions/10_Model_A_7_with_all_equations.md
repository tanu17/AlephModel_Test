# Extraction: Model A.7 with all equations.docx
- Model version(s) specified: Model A.7 (with change history A.1-A.7 and stated gaps for A.8)
- One-paragraph summary of the file: Describes Model A.7, a "three-dimensional neurovascular integration" dynamical model. Section 1 gives a short set of governing equations in prose (somatic/dendritic, sodium debt, six-pool metabolism, AIS, 3D microvascular Kirchhoff flow, condensate capture), plus a species parameter table (fly, zebrafish, rat, macaque, human, pigeon). Sections 2-6 discuss modes of explanation (incl. a Kramers-escape forgetting power law), blind species validations, gaps for A.8 (damped ROU compliance, clock-driven sleep tensor, extracellular Ca pool for fast ripples, ANLS stoichiometry), version history and experiments. Section 7 (Annex) gives three short validations (sodium ledger forward invariance, capture variable bounds, Kirchhoff uniqueness) and a complete list of Eq. 1-39 grouped into six tiers.
- Parts that could not be read (if any): None. NOTE: equation numbering in Section 1 prose differs from the Annex list (prose "Eq. 5/6" sodium = Annex Eq. 6/7; prose "Eq. 33" capture = Annex Eq. 33; prose "Eq. 9/10/14" vascular = Annex Eq. 9/10/15 for r_e). Annex Eq. 5 (dn/dt) and Eq. 6 (Pi) are labelled one off: the annex lists "(Eq. 5) dn_i/dt" text actually after "(Eq. 4) s_np"... see E-blocks. Section 1 short forms are recorded separately where they differ.

## Section 1 (prose) forms

### E1: Somatic membrane potential (short form, Section 1 "Eq. 1")
- Section in source: 1, Somatic and Dendritic Signaling
- Tier: 1
- Equation: \tau_v\frac{dv_i}{dt}=-(v_i-v_{rest})-g_K(a_i)(v_i-E_K)+G_s\zeta(1-\nu_{ACh})\sum_j(s_jW_{ij}x_{ij}r_j)+g_{ax}((v_{d,i}-v_i)+(V_e(x_{d,i})-V_e(x_{s,i})))
- Symbols: g_K(a_i) K_ATP shunting conductance depending on ATP a_i; V_e extracellular (ephaptic) potential at dendritic/somatic positions; nu_ACh acetylcholine; others undefined.
- Derivation: none given ("modeled with a K_ATP shunting component and ephaptic coupling").
- Cites: none
- Aleph 1: Aleph Eq. 5.1 (somatic potential with K_ATP brake)
- Changes: Annex version (E14) adds delays tau_ij and an external drive term G_s(1+nu_ACh)I_i(t).

### E2: Dendritic dCaAP compartment (short form, Section 1 "Eq. 2")
- Section: 1
- Tier: 1
- Equation: C_d\frac{dv_{d,i}}{dt}=-g_{leak}(v_{d,i}-E_L)+\bar{A}_{Ca}\Delta(u_{d,i})-g_{HCN}(DA)(v_{d,i}-E_{HCN})-g_{ax}(v_{d,i}-v_i)
- Symbols: dCaAP amplitude \bar{A}_{Ca}, Delta(u) dCaAP nonlinearity (enables XOR), g_HCN dopamine-dependent.
- Derivation: none given; justification "enabling non-linear XOR logic operations".
- Cites: none
- Aleph 1: inherited Tier 1 dendritic potential
- Changes: A.5 added the active dendritic compartment (Sec. 5). Annex version differs (g_L, apical input sum, ephaptic term in axial coupling).

### E3: Sodium debt ledger (Section 1 "Eq. 5")
- Section: 1
- Tier: 1
- Equation: \frac{dn_i}{dt}=[\nu_{spk}r_i+\nu_{syn}G_s\sum_j(W_{ij}x_{ij}r_j)+\lambda_n+\frac{I_{ChR2}}{F\cdot{Vol_i}}](1-\frac{n_i}{n_{eq}})-\Pi_i
- Symbols: n_i intracellular Na; nu_spk, nu_syn loads per spike/synaptic; lambda_n leak; I_ChR2 optogenetic current; F Faraday; Vol_i volume; n_eq equilibrium (driving-force limit).
- Derivation: see invariant E44.
- Aleph 1: inherited Tier 1 sodium debt ledger
- Changes: Annex labels it Eq. 6 and uses I_{ChR2,Na}.

### E4: Na/K pump (Section 1 "Eq. 6")
- Tier: 1
- Equation: \Pi_i=\Pi_{max}m(a_i,K_a)m(n_i,K_n)
- Symbols: m(.,K) saturating (Michaelis-type) function (not defined explicitly).
- Derivation: none given
- Aleph 1: inherited Tier 1 sodium ledger / Tier 3 ATP demand
- Changes: Annex labels Eq. 7 area.

### E5: ATP balance (Section 1 "Eq. 24")
- Tier: 3
- Equation: \frac{da}{dt}=2v_{gn}+Y_{ox}v_{ox}-D
- Derivation: none; text says v_gn is "redox-coupled directly to Na+/K+ pumping demand", glycogenolysis mobilizes during severe glucose depletion.
- Aleph 1: inherited Tier 3 ATP balance

### E6: Glucose pool (Section 1 "Eq. 23")
- Tier: 3
- Equation: \frac{dG}{dt}=J_G-v_{gn}-v_{ga}-v_{syn}
- Derivation: none
- Aleph 1: Tier 3 six-pool (G)

### E7-E9: AIS controller and threshold (Section 1 "Eq. 26a, 26b, 27")
- Tier: 4
- Equations: \tau_L\frac{dL_i}{dt}=-(L_i-L_0)-G_LL_0(\bar{c}_i-1) ; \tau_x\frac{dx_i}{dt}=-(x_i-x_0)+G_x(\bar{c}_i-1) ; \theta_{AIS,i}=-k_B\ln(\frac{L_i}{L_0})-k_x\ln(\frac{x_i}{x_0})
- Symbols: L_i AIS length, x_i position, \bar{c}_i Ca2+ proxy (normalized).
- Derivation: none ("slow, leaky structural controller").
- Aleph 1: Tier 4 AIS leaky controller and threshold law (Aleph adds g_AIS)
- Changes: A.6 "replaced random AIS heuristics with a robust controller tied to Ca2+ proxies".

### E10-E12: Kirchhoff balance, normalized flow, radius (Section 1 "Eq. 9, 10, 14")
- Tier: 2
- Equations: \sum_{e\in{c}}G_e(p_c-p_{c'})=c_ar_a^4(P_a-p_c)-G_vp_c ; f_c=\frac{F_c}{F_{c,0}} ; r_e=r_0(1+\beta_c\bar{\psi}_e)
- Justification: "Radii alterations follow a reflected Ornstein-Uhlenbeck (ROU) process" (no equation given for ROU); flow via Hagen-Poiseuille conductances on 3D capillary graph governed by Kirchhoff's rules; Sec. 2 says it obeys Kirchhoff's laws over a symmetric positive-definite graph Laplacian, balancing mass conservation.
- Cites: Hagen-Poiseuille, Kirchhoff; murine angiome topology (works cited 1,2,5)
- Aleph 1: Aleph Eq. 5.6 (Kirchhoff microvascular balance); inherited Hagen-Poiseuille
- Changes: A.6 2D capillary graph -> A.7 3D network from murine angiomes (recovery 6-10 branches vs 3-4). r_e labelled Eq. 15 in annex (Eq. 14 there is psi dynamics).

### E13: Condensate capture SDE (Section 1 "Eq. 33")
- Tier: 6
- Equation: \tau_c\frac{dc_{ij}}{dt}=\Omega_{ij}\pi(a)(1-c_{ij})+\beta_c\frac{c_{ij}^2(1-c_{ij})}{K_c^2+c_{ij}^2}-\gamma_cc_{ij}+\sigma_cc_{ij}(1-c_{ij})dB_{ij}
- Justification: energy-gated molecular condensation; bistable, forgetting via noise-induced Kramers escapes. Bounds: see E45.
- Aleph 1: Tier 6 condensate capture SDE
- Changes: identical in annex (Eq. 33).

## Annex complete list (Eq. 1-39)

### E14: Somatic potential (Annex Eq. 1)
- Tier: 1
- Equation: \tau_v\frac{dv_i}{dt}=-(v_i-v_{rest})-g_K(a_i)(v_i-E_K)+G_s\zeta(1-\nu_{ACh})\sum_j(s_jW_{ij}x_{ij}r_j(t-\tau_{ij}))+G_s(1+\nu_{ACh})I_i(t)+g_{ax}((v_{d,i}-v_i)+(V_e(x_{d,i})-V_e(x_{s,i})))
- Derivation: none. Aleph 1: Eq. 5.1. Changes: none stated.

### E15: Dendritic potential (Annex Eq. 2)
- Tier: 1
- Equation: C_d\frac{dv_{d,i}}{dt}=-g_L(v_{d,i}-E_L)+\bar{A}_{Ca}\Delta(u_{d,i})-g_{HCN}(DA)(v_{d,i}-E_{HCN})+\sum_{j\in{apical}}(W_{ij}x_{ij}r_j(t-\tau_{ij}))-g_{ax}((v_{d,i}-v_i)+(V_e(x_{d,i})-V_e(x_{s,i})))
- Derivation: none. Aleph 1: inherited dendritic potential.

### E16: HCN dopamine modulation (Annex Eq. 3)
- Tier: 1
- Equation: g_{HCN}(DA)=\bar{g}_{HCN}\frac{DA^3}{K_D^3+DA^3}
- Justification: Sec. 3 macaque D1 "dual cAMP-PKA-HCN mechanism" generating inverted-U. Cites ref 6 (guanfacine/HCN). Aleph 1: none explicit (inherited Tier 1 neuromodulation).

### E17: Non-plastic synaptic scaling by DA (Annex Eq. 4)
- Tier: 1
- Equation: s_{np}(DA)=1-\sigma_1\frac{DA^2}{K_1^2+DA^2}
- Derivation: none. Aleph 1: none.

### E18: Sodium ledger (Annex "Eq. 5" label precedes it; text "(Eq. 5) \frac{dn_i}{dt}=..." )
- Tier: 1
- Equation: \frac{dn_i}{dt}=[\nu_{spk}r_i+\nu_{syn}G_s\sum_j(W_{ij}x_{ij}r_j)+\lambda_n+\frac{I_{ChR2,Na}}{F\cdot{Vol_i}}](1-\frac{n_i}{n_{eq}})-\Pi_i
- Note: In the annex the label "(Eq. 5)" sits before dn/dt, "(Eq. 6)" before Pi_i, "(Eq. 7)" before r_i. Aleph 1: inherited sodium debt ledger.

### E19: Pump (Annex Eq. 6)
- Equation: \Pi_i=\Pi_{max}m(a_i,K_a)m(n_i,K_n)
- Tier 1. Aleph: inherited.

### E20: Firing-rate transfer and adaptation (Annex Eq. 7)
- Tier: 1
- Equation: r_i=[1+(\frac{n_i}{n_c})^6]^{-1}h_K(k_c(i))\phi(g(NE)(v_i-\theta_i-w_i-\theta_0-\theta_{AIS,i})), and \tau_w\frac{dw_i}{dt}=-w_i+m_wr_i
- Symbols: n_c critical Na; h_K(k_c) extracellular K dependence; g(NE) noradrenergic gain; w_i adaptation. Undefined phi.
- Derivation: none. Aleph 1: inherited firing-rate transfer function.

### E21: Hagen-Poiseuille conductance (Annex Eq. 8)
- Tier 2. Equation: G_e=\frac{r_e^4}{\ell_e}. Derivation: none (named Hagen-Poiseuille in Sec 1). Aleph: inherited Hagen-Poiseuille conductance.

### E22: Kirchhoff node balance (Annex Eq. 9)
- Tier 2. Equation: \sum_{e\in{c}}G_e(p_c-p_{c'})=c_ar_a^4(P_a-p_c)-G_vp_c. Justification: see E46. Aleph Eq. 5.6.

### E23: Normalized node flow (Annex Eq. 10)
- Tier 2. Equation: f_c=\frac{F_c}{F_{c,0}}, where F_c=\frac{1}{2}\sum_{e\in{c}}\vert{}q_e\vert{}. Derivation: none. Aleph: Tier 2 (supply to Tier 3).

### E24: Extracellular K signal (Annex Eq. 11)
- Tier 2. Equation: s_c=A_K[\sigma(\frac{k_c-k_{th}}{s_k})\sigma(\frac{k_{off}-k_c}{s_{off}})-\sigma(\frac{k_{rest}-k_{th}}{s_k})\sigma(\frac{k_{off}-k_{rest}}{s_{off}})]
- Derivation: none. Aleph: inherited Kir2.1 dilation signal (likely).

### E25: Propagated conducted dilation field (Annex Eq. 12)
- Tier 2. Equation: \Phi_m(t)=\Phi_{max}\tanh(\sum_n(e^{-C_{nm}}\frac{s_n(t-d_{nm}/v_c)}{\Phi_{max}}))
- Derivation: none. Aleph: inherited conducted dilation (NsMJ/Kir2.1).

### E26: Capillary dilator state (Annex Eq. 13)
- Tier 2. Equation: \tau_\psi\frac{d\psi_c}{dt}=-\psi_c+q_c. Derivation: none.

### E27: Capillary radius (Annex Eq. 14)
- Tier 2. Equation: r_e=r_0(1+\beta_c\bar{\psi}_e). (Labelled "(Eq. 14)" in annex list before this? Annex: "(Eq. 13) tau_psi..." "(Eq. 14) r_e" -- actually text reads "(Eq. 13) \Phi_m..." is preceded by "(Eq. 12)"; ordering: Eq.12 Phi_m? see note.) Note: the annex text labels are "(Eq. 12) \Phi_m", "(Eq. 13) \tau_\psi", "(Eq. 14) r_e", "(Eq. 15) \tau_a"; my E24 (s_c) is Eq. 11. Derivation: none (Sec. 1: radii follow ROU, not written).

### E28: Arteriole radius (Annex Eq. 15)
- Tier 2. Equation: \tau_a\frac{dr_a}{dt}=r_{a0}[1+\beta_a\frac{\Phi_{root}(a)}{A_K}+\beta_d\sum_c(\omega_{ac}\psi_c)]-r_a. Derivation: none. Aleph: inherited dual dilation.

### E29: Glucose transport (Annex Eq. 16)
- Tier 3. Equation: J_G=T_G[1+\gamma_G(f-1)][\frac{G_b}{G_b+K_T}-\frac{G}{G+K_T}]. Derivation: none.

### E30: Oxygen delivery with extraction (Annex Eq. 17)
- Tier 3. Equation: J_O=J_{O0}f\frac{E(f)}{E_0}\frac{o_a-o}{o_a-o_0}, where E(f)=1-(1-E_0)^{1/f}. Derivation: none (Renkin-Crone-type form, not named).

### E31: Neuronal glycolysis (Annex Eq. 18)
- Tier 3. Equation: v_{gn}=V_{gn}m(G,K_G)\theta(a)[1+\chi_g(\frac{D_{set}}{D_0}-1)]_+. Justification: coupled to pump demand (Sec 1).

### E32: Astrocytic glycolysis (Annex Eq. 19)
- Tier 3. Equation: v_{ga}=m(G,K_G)(V_{ga0}+\phi{V_{glu}}u). Derivation: none (u = activity/glutamate drive, undefined).

### E33: Glycogen synthesis (Annex Eq. 20)
- Tier 3. Equation: v_{syn}=V_{syn}m(G,K_{Gs})(1-\frac{\Gamma}{\Gamma_{max}}).

### E34: Glycogenolysis (Annex Eq. 21)
- Tier 3. Equation: v_{gly}=V_{gl}m(\Gamma,K_\Gamma)[1+c_K(u-1)_++c_{NE}NE+c_h\sigma(\frac{G_h-G}{s_h})+c_{h2}\sigma(\frac{G_{h2}-G}{s_{h2}})]. Justification: mobilizes during severe glucose depletion.

### E35: Oxidation, pyruvate-lactate exchange, lactate efflux (Annex Eq. 22)
- Tier 3. Equations: v_{ox}=V_{ox}m(p,K_p)m(o,K_o)\theta(a); v_{ex}=k_{ex}(p-\frac{L}{\rho}); J_L=k_{Lb}(L-L_b). Aleph: OXPHOS / lactate shuttle.

### E36: Pool ODEs (Annex Eq. 23)
- Tier 3. Equations: \frac{dG}{dt}=J_G-v_{gn}-v_{ga}-v_{syn}; \frac{dL}{dt}=2(v_{ga}+v_{gly})+v_{ex}-J_L; \frac{d\Gamma}{dt}=v_{syn}-v_{gly}; \frac{dp}{dt}=2v_{gn}-v_{ox}-v_{ex}; c_O\frac{do}{dt}=J_O-3v_{ox}
- Derivation: none (stoichiometric factors 2 and 3 stated without justification). Aleph: Tier 3 six-pool, carbon balance.

### E37: ATP balance and demand (Annex Eq. 24)
- Tier 3. Equation: \frac{da}{dt}=2v_{gn}+Y_{ox}v_{ox}-D, where D=D_{set}\frac{m(a,K_{aD})}{m(a_0,K_{aD})}. Aleph: inherited Tier 3 ATP balance (Aleph adds CK/PCr buffer).

### E38: Ca proxy filter (Annex Eq. 25)
- Tier 4. Equation: \tau_c\frac{d\bar{c}_i}{dt}=-\bar{c}_i+c_i(t).

### E39: AIS length/position (Annex Eq. 26) — same as E7/E8. Tier 4.
### E40: AIS threshold (Annex Eq. 27) — same as E9. Tier 4.

### E41: CA1 LIF with conductances (Annex Eq. 28)
- Tier 5. Equation: \tau_m\frac{dV_k}{dt}=-(V_k-E_L)-g_{e,k}(V_k-E_e)-g_{i,k}(V_k-E_i)+\sigma_{ch}\sqrt{2\tau_m}\xi_k(t). Derivation: none. Aleph: Tier 5 CA1 conductance-based layer.

### E42: Synaptic conductance jumps/decay (Annex Eq. 29)
- Tier 5. Equation: g_{x,k}\to{g_{x,k}}+w_{kj} at each spike, and \frac{dg_{x,k}}{dt}=-\frac{g_{x,k}}{\tau_x}.

### E43: Spiking Na load (Annex Eq. 30)
- Tier 5. Equation: \Delta{n_i}=\nu_{spk} ("Spiking Na+ load mechanism sharing ledger with Eq. 5").

### E43a: Energy-gated threshold homeostasis (Annex Eq. 31)
- Tier 6. Equation: \tau_\theta\frac{d\theta_i}{dt}=r_i-\rho_i\chi(\frac{a_i}{a_0}), where \chi(e)=\frac{e^4}{e^4+e_h^4}.

### E43b: Weight dynamics (Annex Eq. 32)
- Tier 6. Equation: \tau_w\frac{dW_{ij}}{dt}=(1-b_m)[(s_Q+\psi(1-s_Q))DA^+f^+_{ij}(w_{max}-W_{ij})-(1+DA^-)f^-_{ij}W_{ij}-E_{ij}]-\gamma(1-P_{ij})W_{ij}
- Note: tau_w reused (also adaptation in Eq. 7). Aleph: Tier 6 plasticity/synaptic headroom.

### E43c: Capture SDE (Annex Eq. 33) — identical to E13. Tier 6.

### E43d: Tag Omega and protection P (Annex Eq. 34)
- Tier 6. Equation: \tau_\Omega\frac{d\Omega_{ij}}{dt}=\kappa_\Omega{DA^+}f^+_{ij}(1-\Omega_{ij})-\Omega_{ij}, where P_{ij}=\max(\Omega_{ij},c_{ij})

### E43e: Sleep replay update (Annex Eq. 35)
- Tier 6. Equation: \Delta{W}=\lambda_Q\eta_RP(w_{max}-W)-\pi_R(1-P)\sigma(\frac{w_p-W}{s_w})W. Aleph: sleep pruning.

### E43f: Adenosine (Annex Eq. 36)
- Tier 6. Equation: \frac{d[Ado]}{dt}=\eta\Pi_Q-\lambda_u[Ado]-v_{glymph}[Ado]

### E43g: Sleep pressure (Annex Eq. 37)
- Tier 6. Equation: \frac{dS}{dt}=g_wC(t)(1+\alpha{A_r}) (wake); S(t)=S_{set}+(S(t_0)-S_{set})\exp(-k\int{udt}) (sleep). Justification (Sec 3): zebrafish blind test of "gated relaxation" (13.0 gained, 11.7 predicted lost, 11.9 observed).

### E43h: Glymphatic velocity (Annex Eq. 38)
- Tier 6. Equation: v_{glymph}=v_0+v_1\cdot1_{NREM}\cdot(\frac{AQP4}{AQP4_0})\cdot(\frac{A_{NE}}{A_{NE}+K_{NE}})\cdot[1-\sigma(\frac{\bar{NE}-\theta_g}{s_g})]. Aleph: glymphatic peristalsis / AQP4.

### E43i: Theta phase precession (Annex Eq. 39)
- Tier: other (phase; listed under Tier 6). Equation: \frac{d\phi_i}{dt}=\omega_\theta+2\pi\frac{v(t)}{L_f}

## Section 2 and Annex validations

### E43j: Kramers-escape forgetting law (Sec. 2)
- Tier: invariant
- Equation: P(t)\simeq\Gamma(1+\frac{D}{\mu})(\frac{t}{\tau_0})^{-D/\mu}
- Justification: "Forgetting mathematically maps to noise-driven Kramers escape over a bistable barrier". No steps.
- Aleph: emergent invariant of capture SDE.

### E43k: Q10 temperature scaling (Sec. 2, verbal only)
- Tier: other. No explicit equation; "Q_{10} multipliers derived from species body temperature (T_b)".

### E44: Sodium ledger forward invariance (Annex)
- Tier: invariant
- Statement: dn/dt \propto (1-\frac{n_i}{n_{eq}}); at n_i=n_eq influx factor 0, \Pi\ge0, so dn_i/dt\le0 at boundary; hence [0,n_eq] forward-invariant, precluding runaway depolarization at zero ATP / occlusion. (Lower bound at 0 not argued explicitly.)

### E45: Capture variable bounds (Annex)
- Tier: invariant
- Statement: drift vanishes at c=0 and equals -\gamma_c at c=1; diffusion \sigma_cc_{ij}(1-c_{ij}) zero at both boundaries, so c stays in [0,1]. (Note: drift at c=0 is actually Omega*pi(a) per formula; source says "vanishes" - recorded as stated.)

### E46: Kirchhoff flow uniqueness (Annex)
- Tier: invariant
- Statement: graph Laplacian (Eq. 9) symmetric positive definite -> unique pressure solution; numerical interior divergence 1.2 x 10^-14 claimed to guarantee mass conservation.
