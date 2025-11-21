# Quick Start Guide

Get up and running with the robot arm Python control system in 5 minutes.

## Installation

```bash
cd scripts
pip install -r requirements.txt
```

## First Run (No Hardware)

Test the system without connecting to the robot:

```bash
python demo_ik.py
```

This demonstrates:
- ✓ IK solving
- ✓ Coupling constraints
- ✓ Workspace boundaries
- ✓ Trajectory generation
- ✓ 3D visualization

## Interactive Mode (No Hardware)

Play with the robot interactively:

```bash
python main_control.py --mock --interactive
```

Try these commands:
```
robot> move 200 0 200      # Move to position (ρ=200, φ=0°, z=200)
robot> move 180 45 250     # Move to another position
robot> test circle         # Run circular trajectory
robot> test eight          # Run figure-eight
robot> home                # Return to home
robot> status              # Show current position
robot> quit                # Exit
```

## With Hardware

### 1. Connect

- Connect PIC18 board to computer via USB-to-Serial
- Check port: `ls /dev/tty.*` (macOS) or Device Manager (Windows)
- Update port in `robot_config.py` line 73:
  ```python
  'port': '/dev/tty.usbserial-YOUR_PORT'
  ```

### 2. Calibrate (First Time Only)

```bash
python main_control.py --calibrate
```

Follow the wizard to measure:
- Link lengths (L0, L1, L2, L3)
- Gear ratios
- Coupling relationship
- Joint limits

Saves to `calibration.json`.

### 3. Run Tests

```bash
python main_control.py --load-calib calibration.json --test all
```

This runs:
- Point-to-point movements
- Circular trajectory
- Figure-eight pattern
- Workspace boundary exploration

### 4. Interactive Control

```bash
python main_control.py --load-calib calibration.json --interactive
```

Now you can control the real robot!

## Command Reference

```bash
# Testing without hardware
python main_control.py --mock --test circle

# Calibration
python main_control.py --calibrate

# Load calibration and run test
python main_control.py --load-calib calibration.json --test all

# Interactive mode
python main_control.py --load-calib calibration.json --interactive

# Disable visualization (faster)
python main_control.py --no-viz --test circle

# Debug output
python main_control.py --debug --interactive

# Demo (no hardware, educational)
python demo_ik.py
```

## Test Types

- `point` - Simple point-to-point movements
- `circle` - Circular path in XY plane
- `eight` - Figure-eight trajectory
- `boundary` - Workspace edge exploration
- `all` - Run complete test suite

## Troubleshooting

**Can't find serial port:**
```bash
ls /dev/tty.*  # macOS/Linux
# or check Device Manager on Windows
```

**Permission denied:**
```bash
sudo chmod 666 /dev/tty.usbserial-XXX
```

**"Unreachable" errors:**
- Check link lengths are correct in calibration
- Try positions closer to center: `move 150 0 200`
- Verify workspace: `config.max_reach`, `config.min_reach`

**Visualization issues:**
- Close window before running again
- Use `--no-viz` flag if display problems

## Next Steps

1. **Read the full documentation**: `README.md` in this directory
2. **Customize parameters**: Edit `robot_config.py`
3. **Create custom trajectories**: See examples in `main_control.py`
4. **Integrate with PIC18**: Use `serial_handler.s` assembly code

## Files Overview

```
scripts/
├── QUICK_START.md      ← You are here
├── README.md           ← Complete documentation
├── requirements.txt    ← Dependencies
├── demo_ik.py         ← Educational demo
├── main_control.py    ← Main program
├── robot_config.py    ← Robot parameters
├── ik_solver.py       ← IK algorithm
├── serial_interface.py ← Serial communication
├── visualizer.py      ← 3D visualization
└── calibration.py     ← Calibration wizard
```

## Support

For detailed documentation, see:
- `README.md` - Full documentation
- `../README.md` - Project overview
- `../CHANGELOG.md` - What's new
- `../docs/` - Hardware and assembly guides

Happy robot controlling! 🤖

