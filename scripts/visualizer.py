"""
3D Visualization for Robot Arm
Displays robot configuration, workspace, and target positions.
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from mpl_toolkits.mplot3d import Axes3D
from typing import Dict, Optional, List, Tuple
from robot_config import RobotConfig


class RobotVisualizer:
    """3D visualization of robot arm."""
    
    def __init__(self, config: RobotConfig, figsize=(12, 10)):
        """
        Initialize visualizer.
        
        Args:
            config: RobotConfig instance
            figsize: Figure size (width, height)
        """
        self.config = config
        
        # Create figure with two subplots
        self.fig = plt.figure(figsize=figsize)
        self.ax3d = self.fig.add_subplot(121, projection='3d')
        self.ax2d = self.fig.add_subplot(122)
        
        # Current robot state
        self.current_angles = config.home_position.copy()
        self.target_position: Optional[Tuple[float, float, float]] = None
        
        # Plot elements
        self.arm_lines = None
        self.joint_points = None
        self.target_point = None
        self.workspace_boundary = None
        
        self._setup_plot()
    
    def _setup_plot(self):
        """Configure plot appearance."""
        # 3D plot setup
        self.ax3d.set_xlabel('X (mm)')
        self.ax3d.set_ylabel('Y (mm)')
        self.ax3d.set_zlabel('Z (mm)')
        self.ax3d.set_title('Robot Arm - 3D View')
        
        # Set equal aspect ratio
        max_reach = self.config.max_reach if self.config.max_reach else 500
        self.ax3d.set_xlim([-max_reach, max_reach])
        self.ax3d.set_ylim([-max_reach, max_reach])
        self.ax3d.set_zlim([0, max_reach * 1.5])
        
        # Add base reference
        self.ax3d.plot([0], [0], [0], 'ko', markersize=10, label='Base')
        
        # 2D plot setup (top-down view)
        self.ax2d.set_xlabel('X (mm)')
        self.ax2d.set_ylabel('Y (mm)')
        self.ax2d.set_title('Robot Arm - Top View')
        self.ax2d.set_aspect('equal')
        self.ax2d.grid(True, alpha=0.3)
        
        # Draw workspace boundary
        if self.config.max_reach:
            self._draw_workspace()
        
        # Initial robot pose
        self.update_pose(self.current_angles)
    
    def _draw_workspace(self):
        """Draw reachable workspace boundary."""
        # Cylindrical workspace
        theta = np.linspace(0, 2*np.pi, 100)
        
        # Maximum reach circle (top view)
        x_max = self.config.max_reach * np.cos(theta)
        y_max = self.config.max_reach * np.sin(theta)
        self.ax2d.plot(x_max, y_max, 'r--', alpha=0.5, label='Max Reach')
        
        # Minimum reach circle
        if self.config.min_reach and self.config.min_reach > 0:
            x_min = self.config.min_reach * np.cos(theta)
            y_min = self.config.min_reach * np.sin(theta)
            self.ax2d.plot(x_min, y_min, 'b--', alpha=0.5, label='Min Reach')
        
        # 3D workspace cylinder
        z_vals = np.linspace(self.config.workspace_z_min or 0, 
                            self.config.workspace_z_max or 500, 50)
        theta_mesh, z_mesh = np.meshgrid(theta, z_vals)
        
        # Outer cylinder
        x_mesh = self.config.max_reach * np.cos(theta_mesh)
        y_mesh = self.config.max_reach * np.sin(theta_mesh)
        self.ax3d.plot_surface(x_mesh, y_mesh, z_mesh, alpha=0.1, color='red')
        
        self.ax2d.legend()
    
    def _compute_joint_positions(self, angles: Dict[str, float]) -> np.ndarray:
        """
        Compute 3D positions of all joints.
        
        Args:
            angles: Joint angles dictionary
            
        Returns:
            Array of shape (5, 3) with positions: [base, shoulder, elbow, wrist, end]
        """
        theta1 = np.radians(angles['base'])
        theta2 = np.radians(angles['shoulder'])
        theta3 = np.radians(angles['elbow'])
        theta4 = np.radians(angles['wrist'])
        
        L0, L1, L2, L3 = self.config.L0, self.config.L1, self.config.L2, self.config.L3
        
        positions = np.zeros((5, 3))
        
        # Base (origin)
        positions[0] = [0, 0, 0]
        
        # Shoulder (at height L0, rotated by theta1)
        positions[1] = [0, 0, L0]
        
        # Compute in the rotated plane
        # Elbow position relative to shoulder
        elbow_x = L1 * np.cos(theta2)
        elbow_z = L1 * np.sin(theta2)
        
        # Rotate around Z axis by theta1
        positions[2] = [
            elbow_x * np.cos(theta1),
            elbow_x * np.sin(theta1),
            L0 + elbow_z
        ]
        
        # Wrist position
        wrist_x = elbow_x + L2 * np.cos(theta2 + theta3)
        wrist_z = elbow_z + L2 * np.sin(theta2 + theta3)
        
        positions[3] = [
            wrist_x * np.cos(theta1),
            wrist_x * np.sin(theta1),
            L0 + wrist_z
        ]
        
        # End effector
        end_x = wrist_x + L3 * np.cos(theta2 + theta3 + theta4)
        end_z = wrist_z + L3 * np.sin(theta2 + theta3 + theta4)
        
        positions[4] = [
            end_x * np.cos(theta1),
            end_x * np.sin(theta1),
            L0 + end_z
        ]
        
        return positions
    
    def update_pose(self, angles: Dict[str, float]):
        """
        Update robot pose visualization.
        
        Args:
            angles: Joint angles dictionary
        """
        self.current_angles = angles.copy()
        
        # Compute joint positions
        positions = self._compute_joint_positions(angles)
        
        # Clear previous arm lines
        if self.arm_lines:
            for line in self.arm_lines:
                line.remove()
        
        if self.joint_points:
            self.joint_points.remove()
        
        # Plot arm segments in 3D
        self.arm_lines = []
        
        # Base to shoulder
        line, = self.ax3d.plot([positions[0, 0], positions[1, 0]],
                               [positions[0, 1], positions[1, 1]],
                               [positions[0, 2], positions[1, 2]],
                               'b-', linewidth=4, label='Base')
        self.arm_lines.append(line)
        
        # Shoulder to elbow (upper arm)
        line, = self.ax3d.plot([positions[1, 0], positions[2, 0]],
                               [positions[1, 1], positions[2, 1]],
                               [positions[1, 2], positions[2, 2]],
                               'g-', linewidth=4, label='Upper Arm')
        self.arm_lines.append(line)
        
        # Elbow to wrist (forearm)
        line, = self.ax3d.plot([positions[2, 0], positions[3, 0]],
                               [positions[2, 1], positions[3, 1]],
                               [positions[2, 2], positions[3, 2]],
                               'orange', linewidth=4, label='Forearm')
        self.arm_lines.append(line)
        
        # Wrist to end effector
        line, = self.ax3d.plot([positions[3, 0], positions[4, 0]],
                               [positions[3, 1], positions[4, 1]],
                               [positions[3, 2], positions[4, 2]],
                               'r-', linewidth=4, label='End Effector')
        self.arm_lines.append(line)
        
        # Plot joints
        self.joint_points = self.ax3d.scatter(positions[:, 0], positions[:, 1], positions[:, 2],
                                             c='black', s=100, zorder=5)
        
        # Update 2D view
        self.ax2d.clear()
        self.ax2d.set_xlabel('X (mm)')
        self.ax2d.set_ylabel('Y (mm)')
        self.ax2d.set_title('Robot Arm - Top View')
        self.ax2d.set_aspect('equal')
        self.ax2d.grid(True, alpha=0.3)
        
        # Redraw workspace
        if self.config.max_reach:
            theta = np.linspace(0, 2*np.pi, 100)
            x_max = self.config.max_reach * np.cos(theta)
            y_max = self.config.max_reach * np.sin(theta)
            self.ax2d.plot(x_max, y_max, 'r--', alpha=0.5, label='Max Reach')
        
        # Draw arm in 2D
        self.ax2d.plot(positions[:, 0], positions[:, 1], 'bo-', linewidth=2, markersize=8)
        
        # Draw target if set
        if self.target_position:
            rho, phi, z = self.target_position
            x = rho * np.cos(np.radians(phi))
            y = rho * np.sin(np.radians(phi))
            self.ax2d.plot(x, y, 'r*', markersize=15, label='Target')
        
        self.ax2d.legend()
        
        max_reach = self.config.max_reach if self.config.max_reach else 500
        self.ax2d.set_xlim([-max_reach * 1.1, max_reach * 1.1])
        self.ax2d.set_ylim([-max_reach * 1.1, max_reach * 1.1])
        
        # Update title with joint angles
        title = f"θ1={angles['base']:.1f}° θ2={angles['shoulder']:.1f}° θ3={angles['elbow']:.1f}° θ4={angles['wrist']:.1f}°"
        self.fig.suptitle(title, fontsize=12)
        
        plt.draw()
    
    def set_target(self, rho: float, phi: float, z: float):
        """
        Set target position to visualize.
        
        Args:
            rho: Radial distance (mm)
            phi: Azimuthal angle (degrees)
            z: Height (mm)
        """
        self.target_position = (rho, phi, z)
        
        # Convert to Cartesian for 3D plot
        x = rho * np.cos(np.radians(phi))
        y = rho * np.sin(np.radians(phi))
        
        # Remove old target
        if self.target_point:
            self.target_point.remove()
        
        # Plot new target
        self.target_point = self.ax3d.scatter([x], [y], [z], 
                                             c='red', s=200, marker='*', 
                                             label='Target', zorder=10)
        
        plt.draw()
    
    def clear_target(self):
        """Remove target visualization."""
        self.target_position = None
        if self.target_point:
            self.target_point.remove()
            self.target_point = None
        plt.draw()
    
    def animate_trajectory(self, trajectory: List[Dict[str, float]], 
                          interval: int = 100):
        """
        Animate robot following a trajectory.
        
        Args:
            trajectory: List of angle dictionaries
            interval: Time between frames (ms)
        """
        def update(frame):
            if frame < len(trajectory):
                self.update_pose(trajectory[frame])
            return self.arm_lines + [self.joint_points]
        
        anim = FuncAnimation(self.fig, update, frames=len(trajectory),
                           interval=interval, blit=False, repeat=True)
        return anim
    
    def show(self, block: bool = True):
        """Display the visualization."""
        plt.tight_layout()
        plt.show(block=block)
    
    def save(self, filename: str):
        """Save current visualization to file."""
        self.fig.savefig(filename, dpi=150, bbox_inches='tight')
        print(f"Saved visualization to {filename}")


def visualize_workspace(config: RobotConfig):
    """
    Create standalone workspace visualization.
    
    Args:
        config: RobotConfig instance
    """
    fig = plt.figure(figsize=(10, 10))
    ax = fig.add_subplot(111, projection='3d')
    
    # Draw workspace volume
    theta = np.linspace(0, 2*np.pi, 50)
    z_vals = np.linspace(config.workspace_z_min or 0,
                        config.workspace_z_max or 500, 30)
    
    theta_mesh, z_mesh = np.meshgrid(theta, z_vals)
    
    # Outer cylinder
    if config.max_reach:
        x_max = config.max_reach * np.cos(theta_mesh)
        y_max = config.max_reach * np.sin(theta_mesh)
        ax.plot_surface(x_max, y_max, z_mesh, alpha=0.2, color='blue')
    
    # Inner cylinder (minimum reach)
    if config.min_reach and config.min_reach > 0:
        x_min = config.min_reach * np.cos(theta_mesh)
        y_min = config.min_reach * np.sin(theta_mesh)
        ax.plot_surface(x_min, y_min, z_mesh, alpha=0.2, color='red')
    
    ax.set_xlabel('X (mm)')
    ax.set_ylabel('Y (mm)')
    ax.set_zlabel('Z (mm)')
    ax.set_title('Robot Workspace')
    
    plt.show()


def test_visualizer():
    """Test visualization with sample poses."""
    from robot_config import config
    
    viz = RobotVisualizer(config)
    
    # Test poses
    poses = [
        {'base': 0, 'shoulder': 0, 'elbow': 0, 'wrist': 0},      # Home
        {'base': 45, 'shoulder': 30, 'elbow': 30, 'wrist': 0},   # Mid pose
        {'base': 90, 'shoulder': 60, 'elbow': 60, 'wrist': -30}, # Extended
        {'base': -45, 'shoulder': 45, 'elbow': 45, 'wrist': 15}, # Other side
    ]
    
    for i, pose in enumerate(poses):
        print(f"Pose {i+1}: {pose}")
        viz.update_pose(pose)
        plt.pause(1.0)
    
    viz.show()


if __name__ == '__main__':
    test_visualizer()

