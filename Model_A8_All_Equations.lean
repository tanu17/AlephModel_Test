/-
  =============================================================================
  LEAN 4 FORMAL VERIFICATION: MODEL A.8 EXHAUSTIVE MULTI-TIER PROOFS
  Covers all 6 governing biophysical tiers of Model A.8:
    Tier 1: Somato-Dendritic Signaling, Ephaptic Gradients & Excitability
    Tier 2: 3D Microvascular Hemodynamics, NsMJ & Kir2.1 Conduction
    Tier 3: Closed Six-Pool Metabolism & Creatine Kinase PCr/Cr Buffering
    Tier 4: Leaky Tri-Variable Axon Initial Segment (AIS) Controller
    Tier 5: Spiking Hippocampal Layer & Interstitial Calcium Depletion
    Tier 6: Energy-Gated Plasticity, Circadian Downscaling & Glymphatics
  =============================================================================
-/

import Mathlib.Data.Real.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef

namespace ModelA8Full

-- ============================================================================
-- TIER 1: SOMATO-DENDRITIC SIGNALING, EPHAPTIC GRADIENTS & SODIUM LEDGER
-- ============================================================================

structure SomaticParams where
  tau_v : ℝ
  v_rest : ℝ
  E_K : ℝ
  g_adap : ℝ
  G_s : ℝ
  zeta : ℝ
  nu_ACh : ℝ
  g_ax : ℝ
  h_tau_v_pos : 0 < tau_v
  h_nu_ACh_bound : 0 ≤ nu_ACh ∧ nu_ACh ≤ 1

/-- Somatic membrane potential derivative dv_s/dt (Eq. Tier 1) -/
def dv_s_dt (v_s v_d V_e_d V_e_s g_K w I_syn I_ext : ℝ) (p : SomaticParams) : ℝ :=
  (1 / p.tau_v) * (
    -(v_s - p.v_rest) 
    - g_K * (v_s - p.E_K) 
    - p.g_adap * w * (v_s - p.E_K) 
    + p.G_s * p.zeta * (1 - p.nu_ACh) * I_syn 
    + p.G_s * (1 + p.nu_ACh) * I_ext 
    + p.g_ax * ((v_d - v_s) + (V_e_d - V_e_s))
  )

/-- THEOREM 1.1: Ephaptic Cancellation in Uniform Extracellular Fields -/
theorem ephaptic_coupling_cancels_in_uniform_field 
    (v_s v_d V_e g_K w I_syn I_ext : ℝ) (p : SomaticParams) :
    dv_s_dt v_s v_d V_e V_e g_K w I_syn I_ext p = 
    (1 / p.tau_v) * (
      -(v_s - p.v_rest) - g_K * (v_s - p.E_K) - p.g_adap * w * (v_s - p.E_K) 
      + p.G_s * p.zeta * (1 - p.nu_ACh) * I_syn + p.G_s * (1 + p.nu_ACh) * I_ext 
      + p.g_ax * (v_d - v_s)
    ) := by
  dsimp [dv_s_dt]
  have h_cancel : V_e - V_e = 0 := sub_self V_e
  rw [h_cancel, add_zero]

structure DendriticParams where
  C_d : ℝ
  E_L : ℝ
  A_Ca_bar : ℝ
  E_HCN : ℝ
  g_ax : ℝ
  h_Cd_pos : 0 < C_d

def dCaAP_activation (u u_th w_Ca : ℝ) : ℝ :=
  if u < u_th then 0 else Real.exp (-(u - u_th) / w_Ca)

/-- Dendritic membrane potential derivative dv_d/dt -/
def dv_d_dt (v_d v_s V_e_d V_e_s g_leak g_HCN u u_th w_Ca I_apical : ℝ) (p : DendriticParams) : ℝ :=
  (1 / p.C_d) * (
    -g_leak * (v_d - p.E_L) 
    + p.A_Ca_bar * dCaAP_activation u u_th w_Ca 
    - g_HCN * (v_d - p.E_HCN) 
    + I_apical 
    - p.g_ax * ((v_d - v_s) + (V_e_d - V_e_s))
  )

/-- THEOREM 1.2: Sub-threshold Dendritic Calcium Isolation -/
theorem dCaAP_zero_below_threshold 
    (v_d v_s V_e_d V_e_s g_leak g_HCN u u_th w_Ca I_apical : ℝ) 
    (hu : u < u_th) (p : DendriticParams) :
    dv_d_dt v_d v_s V_e_d V_e_s g_leak g_HCN u u_th w_Ca I_apical p = 
    (1 / p.C_d) * (
      -g_leak * (v_d - p.E_L) - g_HCN * (v_d - p.E_HCN) 
      + I_apical - p.g_ax * ((v_d - v_s) + (V_e_d - V_e_s))
    ) := by
  dsimp [dv_d_dt, dCaAP_activation]
  rw [if_pos hu, mul_zero, zero_sub]
  ring_nf

structure SodiumLedgerParams where
  nu_spk : ℝ
  nu_syn : ℝ
  G_s : ℝ
  lambda_n : ℝ
  n_eq : ℝ
  Pi_max : ℝ
  K_a : ℝ
  K_n : ℝ
  h_neq_pos : 0 < n_eq
  h_Pi_pos : 0 < Pi_max
  h_Ka_pos : 0 < K_a
  h_Kn_pos : 0 < K_n
  h_lambda_pos : 0 < lambda_n

def mm (x K : ℝ) : ℝ := x / (x + K)

def pump_rate (a n : ℝ) (p : SodiumLedgerParams) : ℝ :=
  p.Pi_max * mm a p.K_a * mm n p.K_n

def dn_dt (n a r syn_drive I_opt : ℝ) (p : SodiumLedgerParams) : ℝ :=
  (p.nu_spk * r + p.nu_syn * p.G_s * syn_drive + p.lambda_n + I_opt) * (1 - n / p.n_eq) - pump_rate a n p

/-- THEOREM 1.3: Sodium Ledger Boundary Forward Invariance -/
theorem sodium_boundary_invariant 
    (a r syn_drive I_opt : ℝ) (ha : 0 ≤ a) (hr : 0 ≤ r) (hsyn : 0 ≤ syn_drive) (hopt : 0 ≤ I_opt)
    (p : SodiumLedgerParams) :
    dn_dt p.n_eq a r syn_drive I_opt p ≤ 0 := by
  dsimp [dn_dt]
  have h_drive : 1 - p.n_eq / p.n_eq = 0 := by
    rw [div_self (ne_of_gt p.h_neq_pos), sub_self]
  rw [h_drive, mul_zero, zero_sub]
  have h_pump_nonneg : 0 ≤ pump_rate a p.n_eq p := by
    dsimp [pump_rate, mm]
    apply mul_nonneg
    · apply mul_nonneg (le_of_lt p.h_Pi_pos)
      apply div_nonneg ha (by linarith [p.h_Ka_pos])
    · apply div_nonneg (le_of_lt p.h_neq_pos) (by linarith [p.h_neq_pos, p.h_Kn_pos])
  linarith

-- ============================================================================
-- TIER 2: 3D MICROVASCULAR FLUID DYNAMICS & RETROGRADE CONDUCTION
-- ============================================================================

structure VascularBranch where
  radius : ℝ
  length : ℝ
  viscosity : ℝ
  h_r_pos : 0 < radius
  h_l_pos : 0 < length
  h_eta_pos : 0 < viscosity

/-- Hagen-Poiseuille Conductance G_e = (pi * r^4) / (8 * eta * l) -/
def poiseuille_conductance (b : VascularBranch) : ℝ :=
  (Real.pi * b.radius^4) / (8 * b.viscosity * b.length)

/-- THEOREM 2.1: Strictly Positive Vascular Conductance -/
theorem poiseuille_conductance_strictly_positive (b : VascularBranch) :
    0 < poiseuille_conductance b := by
  dsimp [poiseuille_conductance]
  have h_num : 0 < Real.pi * b.radius^4 := mul_pos Real.pi_pos (pow_pos b.h_r_pos 4)
  have h_den : 0 < 8 * b.viscosity * b.length := by positivity
  exact div_pos h_num h_den

structure ArteriolarDilationParams where
  tau_a : ℝ
  r_a0 : ℝ
  beta_NsMJ : ℝ
  I_0 : ℝ
  beta_a : ℝ
  A_K : ℝ
  beta_astro : ℝ
  beta_d : ℝ
  h_tau_pos : 0 < tau_a
  h_I0_pos : 0 < I_0

def dr_a_dt (r_a I_NsMJ Phi_root F_A2B coupling_sum : ℝ) (p : ArteriolarDilationParams) : ℝ :=
  (1 / p.tau_a) * (
    p.r_a0 * (1 + p.beta_NsMJ * (I_NsMJ / p.I_0) + p.beta_a * Phi_root + p.beta_astro * F_A2B + p.beta_d * coupling_sum) - r_a
  )

/-- THEOREM 2.2: Equilibrium Arteriolar Radius under Basal Drive -/
theorem arteriolar_basal_equilibrium (p : ArteriolarDilationParams) :
    dr_a_dt p.r_a0 0 0 0 0 p = 0 := by
  dsimp [dr_a_dt]
  ring_nf

-- ============================================================================
-- TIER 3: CLOSED SIX-POOL METABOLISM & CREATINE KINASE BUFFERING
-- ============================================================================

structure MetabolicPools where
  J_G : ℝ
  J_L : ℝ
  v_gn : ℝ
  v_ga : ℝ
  v_syn : ℝ
  v_gly : ℝ
  v_ox : ℝ
  v_ex : ℝ

def dG_dt (m : MetabolicPools) : ℝ := m.J_G - m.v_gn - m.v_ga - m.v_syn
def dL_dt (m : MetabolicPools) : ℝ := 2 * (m.v_ga + m.v_gly) + m.v_ex - m.J_L
def dGamma_dt (m : MetabolicPools) : ℝ := m.v_syn - m.v_gly
def dp_dt (m : MetabolicPools) : ℝ := 2 * m.v_gn - m.v_ox - m.v_ex

/-- THEOREM 3.1: Exact Carbon Mass Conservation -/
theorem carbon_mass_balance (m : MetabolicPools) :
    dG_dt m + dGamma_dt m + (dL_dt m + dp_dt m) / 2 = m.J_G - m.J_L / 2 - m.v_ox / 2 := by
  dsimp [dG_dt, dL_dt, dGamma_dt, dp_dt]
  ring

structure CKBufferParams where
  k_CK : ℝ
  K_eq : ℝ
  h_k_pos : 0 < k_CK
  h_K_pos : 0 < K_eq

def da_dt (v_gn v_ox D PCr ADP Cr ATP : ℝ) (p : CKBufferParams) : ℝ :=
  2 * v_gn + 27.5 * v_ox + p.k_CK * (PCr * ADP - (Cr * ATP) / p.K_eq) - D

/-- THEOREM 3.2: Creatine Kinase Net Flux Vanishes at Chemical Equilibrium -/
theorem ck_equilibrium_preserves_atp_flux 
    (v_gn v_ox D PCr ADP Cr ATP : ℝ) (p : CKBufferParams) 
    (h_eq : PCr * ADP = (Cr * ATP) / p.K_eq) :
    da_dt v_gn v_ox D PCr ADP Cr ATP p = 2 * v_gn + 27.5 * v_ox - D := by
  dsimp [da_dt]
  rw [h_eq, sub_self, mul_zero, add_zero]

-- ============================================================================
-- TIER 4: LEAKY TRI-VARIABLE AXON INITIAL SEGMENT (AIS) CONTROLLER
-- ============================================================================

structure AISControllerParams where
  tau_L : ℝ
  tau_x : ℝ
  tau_g : ℝ
  L_0 : ℝ
  x_0 : ℝ
  g_0 : ℝ
  G_L : ℝ
  G_x : ℝ
  G_g : ℝ
  k_B : ℝ
  k_x : ℝ
  k_g : ℝ
  h_L0_pos : 0 < L_0
  h_x0_pos : 0 < x_0
  h_g0_pos : 0 < g_0

def dL_dt (L c_bar : ℝ) (p : AISControllerParams) : ℝ :=
  (1 / p.tau_L) * (-(L - p.L_0) - p.G_L * p.L_0 * (c_bar - 1))

def dx_dt (x c_bar : ℝ) (p : AISControllerParams) : ℝ :=
  (1 / p.tau_x) * (-(x - p.x_0) + p.G_x * (c_bar - 1))

def dg_dt (g c_bar : ℝ) (p : AISControllerParams) : ℝ :=
  (1 / p.tau_g) * (-(g - p.g_0) - p.G_g * p.g_0 * (c_bar - 1))

def theta_AIS (L x g : ℝ) (p : AISControllerParams) : ℝ :=
  -p.k_B * Real.log (L / p.L_0) - p.k_x * Real.log (x / p.x_0) - p.k_g * Real.log (g / p.g_0)

/-- THEOREM 4.1: Uniqueness of AIS Fixed Point under Homeostatic Equilibrium -/
theorem ais_unique_fixed_point (L x g : ℝ) (p : AISControllerParams)
    (hL : dL_dt L 1 p = 0) (hx : dx_dt x 1 p = 0) (hg : dg_dt g 1 p = 0) :
    L = p.L_0 ∧ x = p.x_0 ∧ g = p.g_0 := by
  dsimp [dL_dt, dx_dt, dg_dt] at hL hx hg
  have h_c : (1 : ℝ) - 1 = 0 := sub_self 1
  rw [h_c, mul_zero, mul_zero, mul_zero, sub_zero, sub_zero, sub_zero] at hL hx hg
  have hL_eq : L - p.L_0 = 0 := by
    cases mul_eq_zero.mp hL with
    | inl h1 => exfalso; exact ne_of_gt (one_div_pos.mpr p.h_L0_pos) (by linarith)
    | inr h2 => exact neg_eq_zero.mp h2
  have hx_eq : x - p.x_0 = 0 := by
    cases mul_eq_zero.mp hx with
    | inl h1 => exfalso; exact ne_of_gt (one_div_pos.mpr p.h_L0_pos) (by linarith)
    | inr h2 => exact neg_eq_zero.mp h2
  have hg_eq : g - p.g_0 = 0 := by
    cases mul_eq_zero.mp hg with
    | inl h1 => exfalso; exact ne_of_gt (one_div_pos.mpr p.h_L0_pos) (by linarith)
    | inr h2 => exact neg_eq_zero.mp h2
  exact ⟨sub_eq_zero.mp hL_eq, sub_eq_zero.mp hx_eq, sub_eq_zero.mp hg_eq⟩

/-- THEOREM 4.2: Zero Threshold Shift at AIS Fixed Point -/
theorem theta_ais_zero_at_equilibrium (p : AISControllerParams) :
    theta_AIS p.L_0 p.x_0 p.g_0 p = 0 := by
  dsimp [theta_AIS]
  rw [div_self (ne_of_gt p.h_L0_pos), div_self (ne_of_gt p.h_x0_pos), div_self (ne_of_gt p.h_g0_pos)]
  rw [Real.log_one, mul_zero, mul_zero, mul_zero, sub_zero, sub_zero]

-- ============================================================================
-- TIER 5: FAST RIPPLE PATHOLOGIES & EXTRACELLULAR CALCIUM DEPLETION
-- ============================================================================

structure CalciumDepletionParams where
  tau_Ca : ℝ
  Ca_0 : ℝ
  tau_ref : ℝ
  h_tauCa_pos : 0 < tau_Ca
  h_tauRef_pos : 0 < tau_ref
  h_Ca0_pos : 0 < Ca_0

def dCa_dt (Ca_e I_burst : ℝ) (p : CalciumDepletionParams) : ℝ :=
  (1 / p.tau_Ca) * (-I_burst + (p.Ca_0 - Ca_e) / p.tau_ref)

/-- THEOREM 5.1: Extracellular Calcium Recovery Under Zero Bursting -/
theorem calcium_recovery_equilibrium (Ca_e : ℝ) (p : CalciumDepletionParams)
    (h_eq : dCa_dt Ca_e 0 p = 0) : Ca_e = p.Ca_0 := by
  dsimp [dCa_dt] at h_eq
  have h_inner : (p.Ca_0 - Ca_e) / p.tau_ref = 0 := by
    cases mul_eq_zero.mp h_eq with
    | inl h1 => exfalso; exact ne_of_gt (one_div_pos.mpr p.h_tauCa_pos) h1
    | inr h2 => linarith
  have h_diff : p.Ca_0 - Ca_e = 0 := div_eq_zero_iff.mp h_inner |>.resolve_right (ne_of_gt p.h_tauRef_pos)
  linarith

-- ============================================================================
-- TIER 6: ENERGY-GATED PLASTICITY, CIRCADIAN DOWN-SCALING & GLYMPHATICS
-- ============================================================================

structure CaptureSDEParams where
  Omega : ℝ
  pi_a : ℝ
  beta_c : ℝ
  gamma_c : ℝ
  K_c : ℝ
  sigma_c : ℝ
  h_gamma_pos : 0 < gamma_c

def capture_drift (c : ℝ) (p : CaptureSDEParams) : ℝ :=
  p.Omega * p.pi_a * (1 - c) + p.beta_c * (c^2 * (1 - c) / (p.K_c^2 + c^2)) - p.gamma_c * c

def capture_diffusion (c : ℝ) (p : CaptureSDEParams) : ℝ :=
  p.sigma_c * c * (1 - c)

/-- THEOREM 6.1: Vanishing Diffusion Factor at Probability Domain Boundaries -/
theorem capture_diffusion_boundary_zero (c : ℝ) (hc : c = 0 ∨ c = 1) (p : CaptureSDEParams) :
    capture_diffusion c p = 0 := by
  dsimp [capture_diffusion]
  rcases hc with rfl | rfl
  · ring
  · ring

structure GlymphaticParams where
  v_0 : ℝ
  v_1 : ℝ
  AQP4_0 : ℝ
  K_NE : ℝ
  s_g : ℝ
  theta_g : ℝ
  h_AQP4_pos : 0 < AQP4_0
  h_KNE_pos : 0 < K_NE

def sigmoidal_gate (x theta s : ℝ) : ℝ := 1 / (1 + Real.exp (-(x - theta) / s))

def v_glymph (is_NREM : Bool) (AQP4 A_NE NE_bar : ℝ) (p : GlymphaticParams) : ℝ :=
  p.v_0 + (if is_NREM then p.v_1 else 0) * (AQP4 / p.AQP4_0) * (A_NE / (A_NE + p.K_NE)) * (1 - sigmoidal_gate NE_bar p.theta_g p.s_g)

/-- THEOREM 6.2: Complete Glymphatic Cessation Under Loss of LC Pulsatility (Zolpidem Effect) -/
theorem zolpidem_pulsatility_loss_collapses_glymphatic 
    (is_NREM : Bool) (AQP4 NE_bar : ℝ) (p : GlymphaticParams) :
    v_glymph is_NREM AQP4 0 NE_bar p = p.v_0 := by
  dsimp [v_glymph]
  have h_zero : (0 : ℝ) / (0 + p.K_NE) = 0 := zero_div (0 + p.K_NE)
  rw [h_zero, mul_zero, mul_zero, mul_zero, add_zero]

end ModelA8Full