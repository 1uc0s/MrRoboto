#!/usr/bin/env python3
"""
Verify Serial Echo
------------------
Finds the EasyPIC Pro v7 serial port, sends test data, and verifies the echo.
"""

import serial
import serial.tools.list_ports
import time
import sys
import random

def find_pic_port():
    """Find the most likely port for the PIC/FTDI."""
    ports = serial.tools.list_ports.comports()
    for port in ports:
        # EasyPIC Pro v7 usually uses an FTDI chip
        if 'FTDI' in port.description or 'usbserial' in port.device or 'FT232' in str(port.hwid):
            return port.device
    return None

def test_echo(port, baudrate=9600):
    print(f"Opening {port} at {baudrate} baud...")
    try:
        ser = serial.Serial(port, baudrate, timeout=1.0)
        time.sleep(2) # Wait for connection to stabilize
        
        # Clear buffers
        ser.reset_input_buffer()
        ser.reset_output_buffer()
        
        print("Starting Echo Test...")
        
        # Test 1: Simple Character
        print("Test 1: Single Character 'A'...", end='', flush=True)
        ser.write(b'A')
        echo = ser.read(1)
        if echo == b'A':
            print(" OK")
        else:
            print(f" FAILED (Got {echo})")
            return False
            
        # Test 2: String
        test_str = b"Hello PIC18!"
        print(f"Test 2: String '{test_str.decode()}'...", end='', flush=True)
        ser.write(test_str)
        echo = ser.read(len(test_str))
        if echo == test_str:
            print(" OK")
        else:
            print(f" FAILED (Got {echo})")
            return False
            
        # Test 3: Random Data
        print("Test 3: 100 Bytes Random Data...", end='', flush=True)
        data = bytes([random.randint(0, 255) for _ in range(100)])
        ser.write(data)
        echo = ser.read(100)
        if echo == data:
            print(" OK")
        else:
            print(f" FAILED (Length sent: 100, received: {len(echo)})")
            # Verify partial
            match_count = sum(1 for i in range(min(len(data), len(echo))) if data[i] == echo[i])
            print(f"        Matched {match_count}/100 bytes")
            return False
            
        print("\nSUCCESS! Serial echo is working perfectly.")
        return True
        
    except serial.SerialException as e:
        print(f"\nError opening serial port: {e}")
        return False
    finally:
        if 'ser' in locals() and ser.is_open:
            ser.close()

if __name__ == "__main__":
    target_port = find_pic_port()
    
    if len(sys.argv) > 1:
        target_port = sys.argv[1]
    
    if not target_port:
        print("No suitable serial port found!")
        print("Available ports:")
        for p in serial.tools.list_ports.comports():
            print(f" - {p.device} ({p.description})")
        sys.exit(1)
        
    print(f"Target Port: {target_port}")
    success = test_echo(target_port)
    sys.exit(0 if success else 1)

