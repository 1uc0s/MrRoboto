#!/usr/bin/env python3
"""
Simple demonstration of the Python IK control system.
Run without hardware to see visualization and IK solving.
"""

import time
import numpy as np
import matplotlib.pyplot as plt

from robot_config import config
from ik_solver import IKSolver
from visualizer import RobotVisualizer


def demo_basic_ik():
    """Demonstrate basic inverse kinematics solving."""
    print("="*60)
    print("Demo 1: Basic Inverse Kinematics")
    print("="*60)
    
    solver = IKSolver(config)
    
    # Test positions
    test_positions = [
        (200, 0, 200, "Front, medium height"),
        (150, 45, 250, "Front-right, high"),
        (180, 90, 180, "Right side, medium"),
        (200, -45, 220, "Front-left, medium"),
    ]
    
    print("\nSolving IK for test positions:\n")
    
    for rho, phi, z, description in test_positions:
        print(f"Position: ({rho}, {phi}°, {z}) - {description}")
        
        success, angles, message = solver.solve(rho, phi, z)
        
        if success:
            print(f"  ✓ Success: {message}")
            print(f"    θ1={angles['base']:.1f}° θ2={angles['shoulder']:.1f}° "
                  f"θ3={angles['elbow']:.1f}° θ4={angles['wrist']:.1f}°")
            
            # Verify with forward kinematics
            rho_fk, phi_fk, z_fk = solver.forward_kinematics(
                angles['base'], angles['shoulder'], angles['elbow'], angles['wrist']
            )
            error = np.sqrt((rho-rho_fk)**2 + (z-z_fk)**2)
            print(f"    Verification error: {error:.2f}mm")
        else:
            print(f"  ✗ Failed: {message}")
        
        print()


def demo_coupling():
    """Demonstrate shoulder-elbow coupling constraint."""
    print("="*60)
    print("Demo 2: Shoulder-Elbow Coupling")
    print("="*60)
    
    print(f"\nCoupling relationship: θ3 = {config.coupling_ratio:.3f} × θ2 + {config.coupling_offset:.3f}")
    print("\nShoulder-Elbow angles with coupling:\n")
    
    for theta2 in [0, 30, 60, 90, 120]:
        theta3 = config.apply_coupling(theta2)
        print(f"  θ2={theta2:3.0f}° → θ3={theta3:.1f}°")


def demo_visualization():
    """Demonstrate 3D visualization."""
    print("\n" + "="*60)
    print("Demo 3: 3D Visualization")
    print("="*60)
    print("\nShowing robot in different configurations...")
    print("Close the visualization window to continue.\n")
    
    viz = RobotVisualizer(config)
    solver = IKSolver(config)
    
    # Trajectory: circular path
    num_points = 16
    radius = 180
    height = 200
    
    angles_list = []
    
    for angle_deg in np.linspace(0, 360, num_points, endpoint=False):
        # Solve IK for circular position
        success, angles, _ = solver.solve(radius, angle_deg, height)
        
        if success:
            angles_list.append(angles)
    
    # Animate trajectory
    print("Animating circular trajectory...")
    
    for i, angles in enumerate(angles_list):
        viz.update_pose(angles)
        plt.pause(0.3)
    
    # Return to home
    viz.update_pose(config.home_position)
    
    print("\n✓ Visualization complete")
    viz.show(block=True)


def demo_workspace():
    """Demonstrate workspace boundary checking."""
    print("\n" + "="*60)
    print("Demo 4: Workspace Boundary")
    print("="*60)
    
    print(f"\nWorkspace parameters:")
    print(f"  Max reach: {config.max_reach:.1f}mm")
    print(f"  Min reach: {config.min_reach:.1f}mm")
    print(f"  Z range: {config.workspace_z_min:.1f} to {config.workspace_z_max:.1f}mm")
    
    print("\nTesting positions:\n")
    
    test_cases = [
        (200, 200, True, "Inside workspace"),
        (400, 200, False, "Too far"),
        (50, 200, False, "Too close"),
        (200, 500, False, "Too high"),
        (200, -50, False, "Too low"),
    ]
    
    for rho, z, expected_reachable, description in test_cases:
        reachable, reason = config.is_position_reachable(rho, z)
        status = "✓" if reachable == expected_reachable else "✗"
        print(f"  {status} (ρ={rho}, z={z}): {description}")
        if not reachable:
            print(f"      → {reason}")


def demo_trajectory_generation():
    """Demonstrate trajectory generation."""
    print("\n" + "="*60)
    print("Demo 5: Trajectory Generation")
    print("="*60)
    
    solver = IKSolver(config)
    
    # Generate figure-eight trajectory
    print("\nGenerating figure-eight trajectory...")
    
    t = np.linspace(0, 2*np.pi, 24)
    size = 60
    center_rho = 200
    center_z = 200
    
    waypoints = []
    
    for ti in t:
        # Lemniscate of Gerono
        x = center_rho + size * np.cos(ti)
        y = size * np.sin(ti) * np.cos(ti)
        
        rho = np.sqrt(x**2 + y**2)
        phi = np.degrees(np.arctan2(y, x))
        z = center_z
        
        success, angles, _ = solver.solve(rho, phi, z)
        if success:
            waypoints.append((rho, phi, z, angles))
    
    print(f"  Generated {len(waypoints)} waypoints")
    print(f"  Total path length: ~{2 * np.pi * size:.0f}mm")
    
    # Show first few waypoints
    print("\n  First 3 waypoints:")
    for i, (rho, phi, z, angles) in enumerate(waypoints[:3]):
        print(f"    {i+1}. (ρ={rho:.1f}, φ={phi:.1f}°, z={z:.1f})")
        print(f"       θ=[{angles['base']:.1f}°, {angles['shoulder']:.1f}°, "
              f"{angles['elbow']:.1f}°, {angles['wrist']:.1f}°]")


def main():
    """Run all demonstrations."""
    print("\n")
    print("╔" + "="*58 + "╗")
    print("║" + " "*18 + "Robot IK Demo" + " "*27 + "║")
    print("╚" + "="*58 + "╝")
    print()
    
    print("This demo shows the Python IK control system capabilities.")
    print("No hardware required - all simulated.\n")
    
    input("Press Enter to start...")
    
    # Run demonstrations
    demo_basic_ik()
    input("\nPress Enter for next demo...")
    
    demo_coupling()
    input("\nPress Enter for next demo...")
    
    demo_workspace()
    input("\nPress Enter for next demo...")
    
    demo_trajectory_generation()
    input("\nPress Enter for visualization demo...")
    
    demo_visualization()
    
    print("\n" + "="*60)
    print("All demos complete!")
    print("="*60)
    print()
    print("Next steps:")
    print("  1. Calibrate robot: python main_control.py --calibrate")
    print("  2. Run tests: python main_control.py --test all")
    print("  3. Interactive mode: python main_control.py --interactive")
    print()


if __name__ == '__main__':
    main()

