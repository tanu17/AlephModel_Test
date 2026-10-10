# Extraction: A.7-research-report.md
- Model version(s) specified: Audit of Model A.7; proposes corrected forms for Model A.8.
- One-paragraph summary of the file: An external-style "research report" auditing Model A.7 claims against 2023-26 literature (opto-fMRI volumetric NVC, Zhang et al. 2024 NsMJs, Theparambil et al. 2024 astrocyte A2B-lactate cascade, high-dimensional topology deemed speculative), listing generic "original vs corrected" equations (flow law, reaction-diffusion, volume factor, pressure flux, leaky voltage with adaptation, Beer-Lambert light attenuation), Neumann boundary conditions, an NWB/DANDI data-integration plan with PyNWB code, recommendations for A.8, assumptions, a roadmap and Table 7. Equations are generic/schematic; symbols are not fully defined ("Symbols are defined in the original model context").
- Parts that could not be read (if any): None. Referenced "Supplementary Math Notes" and "Appendix" (balloon-windkessel derivations) are not included in the file. A figure is only captioned.

### E1: Dimensional fix of activation-to-flow term (k A / V)
- Section in source: Mathematical Verification & Corrected Equations (Dimensional consistency bullet); Table 4 row 3
- Tier: 2
- Equation: Original $Q = A\,k$ ; Corrected $Q = A\,k / V_\text{cortex}$ (text: "$k A/V$ has correct units of [flow]")
- Symbols: $A$ neuronal activation term (unitless); $k$ factor with units [1/time]; $V_\text{cortex}$ cortex volume; $Q$ [unclear: flow/flow per volume]
- Derivation or justification: A unitless times [1/time] was used in a flow-rate equation with units [volume/time]; "We inserted the missing volume factor V_cortex to correct this (so that kA/V has correct units of [flow])". Table note: "for dimensional consistency (flow per volume)". (Note: dividing by V does not yield volume/time; recorded as stated.)
- Physical law / literature: dimensional analysis
- Corresponding Aleph 1 equation: none directly (loosely Tier 2 Kirchhoff flow / Eq 4.2 Q symbol reused, but not the same)
- Changes vs earlier versions: A.7 lacked volume factor; A.8 inserts it.

### E2: NVC flow law (linear)
- Section in source: Mathematical Verification (Flow-volume coupling); Table 4 row 1; Corrected Equations table; Recommendations 2; Table 7
- Tier: 2
- Equation: Original (A.7 Eq. 3) $F = k n^2$ ; Corrected $F = k' n$
- Symbols: $F$ blood flow; $n$ neuronal activity; $k'$ fitted constant (to be calibrated from opto-fMRI slopes)
- Derivation or justification: Quadratic contradicts literature showing linear scaling on single-pulse timescales; "can be derived from a standard hemodynamic balloon model linearization, consistent with Christie et al." (derivation not shown; deferred to Appendix not included). Prevents overestimation of hyperemia for large stimuli.
- Physical law / literature: Christie et al. 2017 opto-fMRI volumetric coupling; balloon model linearization
- Corresponding Aleph 1 equation: none (Aleph uses NsMJ+Kir2.1 dual dilation / Hagen-Poiseuille; this is a precursor of neurovascular coupling)
- Changes: A.7 quadratic -> A.8 linear.

### E3: Volumetric NVC proportionality (claim)
- Section in source: Claim-by-Claim Audit claim 1; Figure caption
- Tier: 2
- Equation: BOLD response ∝ activated tissue volume
- Symbols: none formal
- Derivation or justification: supported by optogenetic fMRI showing directly proportional coupling between light-activated volume and BOLD
- Physical law / literature: Christie et al. 2017
- Corresponding Aleph 1 equation: none
- Changes: none (A.7 assumption judged supported)

### E4: Substrate reaction-diffusion mass balance
- Section in source: Mathematical Verification (Omission of consumption term, A.7 Eq. 5); Table 4 row 2; Corrected Equations table row "Mass balance"
- Tier: 3 (also Tier 2 transport)
- Equation: Text: $\frac{\partial C}{\partial t} = D\nabla^2 C - \gamma C + S(x,t)$. Table 4: Original $\dot{C} = - D\nabla^2 C + S$; Corrected $\dot{C} = - D\nabla^2 C - \gamma C + S$. Corrected Equations table: Original $\partial C/\partial t = D\nabla^2 C + S$; Corrected $\partial C/\partial t = D\nabla^2 C - \gamma C + S$.
- Symbols: $C$ metabolic substrate concentration; $D$ (extracellular) diffusion coefficient; $\gamma$ consumption rate (introduced); $S$ source from blood
- Derivation or justification: original omitted neuronal consumption; adding a sink gives "a standard reaction-diffusion form". Boundary: Neumann (no-flux) at blood-tissue interfaces/tissue boundaries, "as is standard"; then "well-posed". Sensitivity analysis on D, gamma recommended.
- Physical law / literature: reaction-diffusion (Fick + first-order consumption)
- Corresponding Aleph 1 equation: none directly (precursor of Tier 3 substrate pools; Aleph perivascular flux/Peclet)
- Changes: added -γC. NOTE inconsistency: Table 4 has a minus sign on the diffusion term (-D∇²C), whereas the prose and later table have +D∇²C.

### E5: Neumann no-flux boundary condition
- Section in source: Stability and boundary conditions; Corrected Equations table; Assumptions; Table 7
- Tier: other
- Equation: no-flux (Neumann) at tissue boundaries (no explicit formula, i.e. implied $\partial C/\partial n = 0$ not written)
- Symbols: none
- Derivation or justification: standard; conserves mass/energy; cortex treated as isolated volume
- Physical law: conservation
- Corresponding Aleph 1 equation: none
- Changes: A.7 unspecified -> A.8 Neumann

### E6: Flux/pressure units correction
- Section in source: Table 4 row 4
- Tier: other (2)
- Equation: Original $J = \sigma\,E/h$ ; Corrected $J = \sigma E / (h \rho)$
- Symbols: $E$ in joules; $h$ thickness; $\rho$ density; $\sigma$, $J$ [unclear: not defined]
- Derivation or justification: "If h is thickness with density ρ, include ρ to yield correct pressure units (Pa)". (Dimensionally not verified in source beyond this claim.)
- Physical law: dimensional analysis
- Corresponding Aleph 1 equation: none
- Changes: inserted ρ

### E7: Leaky voltage with adaptation
- Section in source: Corrected Equations and Parameter Table, "Voltage decay"
- Tier: 1 (or 5)
- Equation: Original $\tau \dot{V} = -V + I$ ; Corrected $\tau \dot{V} = -V + I - g_{\rm adap}(V-V_{\rm L})$
- Symbols: $\tau$ time constant; $V$ voltage; $I$ input; $g_{\rm adap}$ spike-frequency adaptation conductance; $V_{\rm L}$ [unclear: leak/reversal potential]
- Derivation or justification: "Includes spike-frequency adaptation current for realism"; none further
- Literature: none
- Corresponding Aleph 1 equation: ancestor of Aleph Eq 5.1 somatic potential (Tier 1) / Tier 5 conductance spiking
- Changes: adaptation term added

### E8: Light attenuation (Beer-Lambert) for activated volume
- Section in source: Claim audit 5; Corrected Equations table "Light scattering"; Assumptions
- Tier: 2 (optics)
- Equation: Original $V_{act} \propto \exp(-\mu z)$ ; Corrected $V_{act}(z) = V_0\,\exp(-\mu_a z) \exp(-\mu_s' z)$
- Symbols: $\mu_a$ absorption coefficient; $\mu_s'$ (reduced) scattering coefficient; $z$ depth; $V_0$ [unclear: surface activated volume]; parameters from rodent tissue literature; stimulus 10 ms at 470 nm
- Derivation or justification: Beer-Lambert; separates absorption and scattering "matches optical physics"; standard opto-fMRI protocols. Exec summary mentions "a linear scaling that should be quadratic (or vice versa) according to optical scattering theory" without specifying.
- Literature: Beer-Lambert; Christie et al.
- Corresponding Aleph 1 equation: precursor of Aleph Eq 4.2 optical heat deposition Q (Beer-Lambert)
- Changes: split μ into μ_a and μ_s'

### E9: NsMJ input to arteriole radius equation (proposed, no formula)
- Section in source: Recommendations 1; Table 7
- Tier: 2
- Equation: additional input current $I_{\rm NsMJ}$ to arteriole radius equation, ∝ glutamatergic axon activity (no explicit equation)
- Symbols: $I_{\rm NsMJ}$
- Derivation or justification: Zhang et al. 2024 NsMJs; enables millisecond dilation
- Corresponding Aleph 1 equation: inherited Tier 2 NsMJ + Kir2.1 dual dilation
- Changes: new in A.8 recommendations

### E10: Astrocyte adenosine-A2B-cAMP-lactate cascade (proposed, no formula)
- Section in source: Claim 3; Recommendations 3; Table 7
- Tier: 3
- Equation: none written; "delayed support term (via lactate) to neuronal excitability"
- Literature: Theparambil et al. 2024
- Corresponding Aleph 1 equation: Tier 3 lactate shuttle
- Changes: new in A.8 recommendations

### E11: Stability via eigenvalue analysis (no formula)
- Section in source: Recommendations 6; Table 7
- Tier: other
- Equation: none; eigenvalue analysis of linearized system, constrain time-step
- Corresponding Aleph 1 equation: none
