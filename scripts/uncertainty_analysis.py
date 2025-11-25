"""
Uncertainty Analysis for Robot Arm
Calculates angular uncertainty from stepper motor resolution and propagates
it to positional uncertainty at the end effector.
"""

import numpy as np
import matplotlib.pyplot as plt
from robot_config import config

def calculate_gear_ratio(steps, degrees):
    """
    Calculate gear ratio from measured movement.
    
    Args:
        steps: Number of steps sent to motor
        degrees: Resulting angular movement
        
    Returns:
        Gear ratio in steps/degree
    """
    return steps / degrees

def calculate_angular_uncertainty(gear_ratio):
    """
    Calculate angular uncertainty from stepper resolution.
    
    Assumes ±0.5 step uncertainty (quantization error).
    
    Args:
        gear_ratio: Steps per degree
        
    Returns:
        Angular uncertainty in degrees (±)
    """
    # Quantization uncertainty: ±0.5 steps
    step_uncertainty = 0.5
    angular_uncertainty = step_uncertainty / gear_ratio
    return angular_uncertainty

def calculate_end_effector_uncertainty(theta2, theta3, delta_theta2, delta_theta3, L1, L2, L3=0):
    """
    Propagate angular uncertainties to end effector position uncertainty.
    
    For a 2-link planar arm in the vertical plane:
    x = rho = L1*sin(θ2) + L2*sin(θ2 + θ3) + L3*sin(θ2 + θ3)
    z = L0 + L1*cos(θ2) + L2*cos(θ2 + θ3) + L3*cos(θ2 + θ3)
    
    Uncertainty propagation (assuming independent uncertainties):
    Δx = √[(∂x/∂θ2 * Δθ2)² + (∂x/∂θ3 * Δθ3)²]
    Δz = √[(∂z/∂θ2 * Δθ2)² + (∂z/∂θ3 * Δθ3)²]
    
    Args:
        theta2: Shoulder angle (degrees)
        theta3: Elbow angle (degrees, relative to upper arm)
        delta_theta2: Angular uncertainty in shoulder (degrees)
        delta_theta3: Angular uncertainty in elbow (degrees)
        L1: Upper arm length (mm)
        L2: Forearm length (mm)
        L3: End effector length (mm)
        
    Returns:
        (delta_rho, delta_z, delta_total): Radial, vertical, and total uncertainties (mm)
    """
    # Convert to radians for calculations
    theta2_rad = np.radians(theta2)
    theta3_rad = np.radians(theta3)
    delta_theta2_rad = np.radians(delta_theta2)
    delta_theta3_rad = np.radians(delta_theta3)
    
    # Total arm length for end effector calculations
    L_total = L2 + L3
    
    # Partial derivatives of rho (radial position)
    # ∂rho/∂θ2 = L1*cos(θ2) + L_total*cos(θ2 + θ3)
    drho_dtheta2 = L1 * np.cos(theta2_rad) + L_total * np.cos(theta2_rad + theta3_rad)
    
    # ∂rho/∂θ3 = L_total*cos(θ2 + θ3)
    drho_dtheta3 = L_total * np.cos(theta2_rad + theta3_rad)
    
    # Partial derivatives of z (height)
    # ∂z/∂θ2 = -L1*sin(θ2) - L_total*sin(θ2 + θ3)
    dz_dtheta2 = -L1 * np.sin(theta2_rad) - L_total * np.sin(theta2_rad + theta3_rad)
    
    # ∂z/∂θ3 = -L_total*sin(θ2 + θ3)
    dz_dtheta3 = -L_total * np.sin(theta2_rad + theta3_rad)
    
    # Propagate uncertainties (quadrature sum)
    delta_rho = np.sqrt(
        (drho_dtheta2 * delta_theta2_rad)**2 + 
        (drho_dtheta3 * delta_theta3_rad)**2
    )
    
    delta_z = np.sqrt(
        (dz_dtheta2 * delta_theta2_rad)**2 + 
        (dz_dtheta3 * delta_theta3_rad)**2
    )
    
    # Total positional uncertainty
    delta_total = np.sqrt(delta_rho**2 + delta_z**2)
    
    return delta_rho, delta_z, delta_total

def analyze_uncertainty_workspace():
    """
    Analyze how uncertainty varies across the workspace.
    """
    # Get robot parameters
    L1 = config.L1
    L2 = config.L2
    L3 = config.L3
    
    # Calculate gear ratio from measurement
    measured_steps = 96
    measured_degrees = 18.5
    gear_ratio = calculate_gear_ratio(measured_steps, measured_degrees)
    
    # Calculate angular uncertainty
    delta_theta = calculate_angular_uncertainty(gear_ratio)
    
    print("=" * 70)
    print("ROBOT ARM UNCERTAINTY ANALYSIS")
    print("=" * 70)
    print(f"\n1. GEAR RATIO CALCULATION")
    print(f"   Measurement: {measured_steps} steps → {measured_degrees}°")
    print(f"   Gear Ratio: {gear_ratio:.6f} steps/degree")
    print(f"   Or: {1/gear_ratio:.6f} degrees/step")
    
    print(f"\n2. ANGULAR UNCERTAINTY")
    print(f"   Step uncertainty: ±0.5 steps (quantization)")
    print(f"   Angular uncertainty: ±{delta_theta:.6f}° (±{delta_theta*60:.4f} arcmin)")
    print(f"   In radians: ±{np.radians(delta_theta):.6f} rad")
    
    print(f"\n3. ROBOT PARAMETERS")
    print(f"   L1 (upper arm): {L1} mm")
    print(f"   L2 (forearm): {L2} mm")
    print(f"   L3 (end effector): {L3} mm")
    print(f"   Total reach: {L1 + L2 + L3} mm")
    
    print(f"\n4. END EFFECTOR UNCERTAINTY AT KEY POSITIONS")
    print(f"   (Assuming both joints have same angular uncertainty)")
    print("-" * 70)
    
    # Test positions
    test_positions = [
        (0, 0, "Home (arm vertical, fully extended)"),
        (45, 0, "45° shoulder, straight elbow"),
        (90, 0, "90° shoulder (horizontal), straight elbow"),
        (45, 45, "45° shoulder, 45° elbow"),
        (90, 90, "90° shoulder, 90° elbow (maximum bend)"),
        (30, -30, "30° shoulder, -30° elbow (opposite bend)"),
    ]
    
    for theta2, theta3, description in test_positions:
        delta_rho, delta_z, delta_total = calculate_end_effector_uncertainty(
            theta2, theta3, delta_theta, delta_theta, L1, L2, L3
        )
        print(f"\n   {description}")
        print(f"   θ2={theta2}°, θ3={theta3}°")
        print(f"   Δρ (radial): ±{delta_rho:.3f} mm")
        print(f"   Δz (vertical): ±{delta_z:.3f} mm")
        print(f"   Δtotal: ±{delta_total:.3f} mm")
    
    print("\n" + "=" * 70)
    
    # Generate heat map of uncertainty across workspace
    create_uncertainty_heatmap(L1, L2, L3, delta_theta)

def create_uncertainty_heatmap(L1, L2, L3, delta_theta):
    """
    Create a heat map showing how uncertainty varies across the workspace.
    """
    # Create grid of joint angles
    theta2_range = np.linspace(0, 135, 50)
    theta3_range = np.linspace(-90, 90, 50)
    
    Theta2, Theta3 = np.meshgrid(theta2_range, theta3_range)
    
    # Calculate uncertainty at each point
    Uncertainty = np.zeros_like(Theta2)
    for i in range(Theta2.shape[0]):
        for j in range(Theta2.shape[1]):
            _, _, delta_total = calculate_end_effector_uncertainty(
                Theta2[i, j], Theta3[i, j], delta_theta, delta_theta, L1, L2, L3
            )
            Uncertainty[i, j] = delta_total
    
    # Create figure
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
    
    # Heat map
    im1 = ax1.contourf(Theta2, Theta3, Uncertainty, levels=20, cmap='viridis')
    ax1.set_xlabel('Shoulder Angle θ2 (degrees)', fontsize=12)
    ax1.set_ylabel('Elbow Angle θ3 (degrees)', fontsize=12)
    ax1.set_title('End Effector Positional Uncertainty', fontsize=14, fontweight='bold')
    cbar1 = plt.colorbar(im1, ax=ax1)
    cbar1.set_label('Uncertainty (mm)', fontsize=12)
    ax1.grid(True, alpha=0.3)
    
    # Contour plot
    contours = ax2.contour(Theta2, Theta3, Uncertainty, levels=10, colors='black', alpha=0.4)
    ax2.clabel(contours, inline=True, fontsize=8, fmt='%.2f mm')
    im2 = ax2.contourf(Theta2, Theta3, Uncertainty, levels=20, cmap='plasma')
    ax2.set_xlabel('Shoulder Angle θ2 (degrees)', fontsize=12)
    ax2.set_ylabel('Elbow Angle θ3 (degrees)', fontsize=12)
    ax2.set_title('Uncertainty Contours', fontsize=14, fontweight='bold')
    cbar2 = plt.colorbar(im2, ax=ax2)
    cbar2.set_label('Uncertainty (mm)', fontsize=12)
    ax2.grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('/Users/lucasertugrul/LocalRepos/Year 3 Physics/MrRoboto/docs/uncertainty_analysis.png', 
                dpi=300, bbox_inches='tight')
    print(f"\n📊 Heat map saved to: docs/uncertainty_analysis.png")
    plt.show()

if __name__ == "__main__":
    analyze_uncertainty_workspace()




