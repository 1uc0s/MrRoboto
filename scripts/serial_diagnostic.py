#!/usr/bin/env python3
"""
Serial Communication Diagnostic Tool
Helps identify why the robot isn't responding to serial commands.
"""

import serial
import serial.tools.list_ports
import time
import sys

def list_serial_ports():
    """List all available serial ports with details."""
    print("\n" + "="*60)
    print("Available Serial Ports")
    print("="*60)
    
    ports = serial.tools.list_ports.comports()
    
    if not ports:
        print("No serial ports found!")
        return []
    
    for port in ports:
        print(f"\nPort: {port.device}")
        print(f"  Description: {port.description}")
        print(f"  Hardware ID: {port.hwid}")
        print(f"  Manufacturer: {port.manufacturer}")
        
        # Check if it's likely an FTDI device (EasyPIC Pro 7)
        if 'FTDI' in port.description or 'FT232' in str(port.hwid):
            print(f"  ⭐ This looks like the EasyPIC Pro 7 (FTDI USB-UART)")
    
    return [port.device for port in ports]

def test_port_connection(port_name, baudrate=9600):
    """Test if a port can be opened."""
    print(f"\n{'='*60}")
    print(f"Testing Connection: {port_name}")
    print(f"{'='*60}")
    
    try:
        ser = serial.Serial(
            port=port_name,
            baudrate=baudrate,
            timeout=1.0,
            write_timeout=1.0
        )
        
        print(f"✓ Port opened successfully")
        print(f"  Baudrate: {ser.baudrate}")
        print(f"  Timeout: {ser.timeout}s")
        print(f"  Bytesize: {ser.bytesize}")
        print(f"  Parity: {ser.parity}")
        print(f"  Stopbits: {ser.stopbits}")
        
        # Wait for connection to stabilize
        time.sleep(2)
        
        # Clear buffers
        ser.reset_input_buffer()
        ser.reset_output_buffer()
        
        return ser
        
    except serial.SerialException as e:
        print(f"✗ Failed to open port: {e}")
        return None

def test_echo(ser, test_count=10):
    """Test echo functionality by sending bytes."""
    print(f"\n{'='*60}")
    print(f"Echo Test: Sending {test_count} bytes")
    print(f"{'='*60}")
    
    if not ser:
        print("✗ Serial port not open")
        return False
    
    success = 0
    fail = 0
    
    for i in range(test_count):
        test_byte = i % 256
        
        # Send byte
        try:
            ser.write(bytes([test_byte]))
            print(f"→ Sent: {test_byte:3d} (0x{test_byte:02X})", end='')
            
            # Wait for response with timeout
            start = time.time()
            response_bytes = ser.read(1)
            elapsed = time.time() - start
            
            if len(response_bytes) == 1:
                received = response_bytes[0]
                if received == test_byte:
                    print(f" ← Received: {received:3d} (0x{received:02X}) ✓ [{elapsed*1000:.1f}ms]")
                    success += 1
                else:
                    print(f" ← Received: {received:3d} (0x{received:02X}) ✗ MISMATCH!")
                    fail += 1
            else:
                print(f" ← No response (timeout after {elapsed*1000:.0f}ms) ✗")
                fail += 1
                
        except serial.SerialException as e:
            print(f" ✗ Error: {e}")
            fail += 1
        
        time.sleep(0.05)  # Small delay between tests
    
    print(f"\n{'='*60}")
    print(f"Results: {success}/{test_count} successful ({100*success/test_count:.1f}%)")
    print(f"{'='*60}")
    
    return fail == 0

def test_with_different_bauds(port_name):
    """Test common baud rates to see if there's a mismatch."""
    print(f"\n{'='*60}")
    print(f"Testing Different Baud Rates")
    print(f"{'='*60}")
    
    baud_rates = [9600, 19200, 38400, 57600, 115200, 4800, 2400]
    
    for baud in baud_rates:
        print(f"\nTrying {baud} baud...", end=' ')
        try:
            ser = serial.Serial(port_name, baudrate=baud, timeout=0.5)
            time.sleep(1)
            
            # Send a few test bytes
            ser.write(b'ABC')
            time.sleep(0.1)
            
            response = ser.read(100)
            if len(response) > 0:
                print(f"✓ Got response: {len(response)} bytes")
                print(f"  Data (hex): {response.hex()}")
                print(f"  Data (ASCII): {response}")
            else:
                print(f"✗ No response")
            
            ser.close()
            
        except Exception as e:
            print(f"✗ Error: {e}")

def check_dtr_rts(ser):
    """Check and toggle DTR/RTS lines (might reset microcontroller)."""
    print(f"\n{'='*60}")
    print(f"Checking DTR/RTS Control Lines")
    print(f"{'='*60}")
    
    if not ser:
        print("✗ Serial port not open")
        return
    
    print(f"DTR (Data Terminal Ready): {ser.dtr}")
    print(f"RTS (Request To Send): {ser.rts}")
    print(f"CTS (Clear To Send): {ser.cts}")
    print(f"DSR (Data Set Ready): {ser.dsr}")
    
    print("\nNote: Some microcontrollers reset when DTR/RTS toggle.")
    print("If your PIC resets on connection, you may need to disable DTR/RTS.")

def main():
    """Run diagnostic tests."""
    print("\n" + "="*60)
    print("PIC18 Serial Communication Diagnostic Tool")
    print("="*60)
    print("\nThis tool helps diagnose serial communication issues.")
    print("Make sure:")
    print("  1. EasyPIC Pro 7 is powered on")
    print("  2. USB cable is connected")
    print("  3. SW5.1 (RC6/TX) and SW5.2 (RC7/RX) are ON")
    print("  4. Firmware is programmed to the PIC18")
    
    # List available ports
    ports = list_serial_ports()
    
    if not ports:
        print("\n✗ No serial ports found. Check USB connection and drivers.")
        return
    
    # Find the most likely port (FTDI device)
    target_port = None
    port_list = serial.tools.list_ports.comports()
    for port in port_list:
        if 'FTDI' in port.description or 'usbserial' in port.device:
            target_port = port.device
            break
    
    if not target_port:
        print("\n⚠ No FTDI device found. Using first available port.")
        target_port = ports[0]
    
    print(f"\n→ Testing port: {target_port}")
    
    # Test connection
    ser = test_port_connection(target_port)
    
    if ser:
        # Check control lines
        check_dtr_rts(ser)
        
        # Test echo
        success = test_echo(ser, test_count=10)
        
        if not success:
            print("\n⚠ Echo test failed!")
            print("\nTroubleshooting steps:")
            print("  1. Check hardware switches (SW5.1 and SW5.2 must be ON)")
            print("  2. Verify firmware is programmed to PIC18")
            print("  3. Press RESET button on EasyPIC Pro 7")
            print("  4. Check power LED is on")
            print("  5. Try different baud rates (see below)")
            
            response = input("\nTest different baud rates? (y/n): ")
            if response.lower() == 'y':
                ser.close()
                test_with_different_bauds(target_port)
        else:
            print("\n✓ Communication working! Your setup is correct.")
        
        if ser.is_open:
            ser.close()
    else:
        print("\n✗ Could not open serial port.")
        print("Check:")
        print("  1. Port permissions (may need sudo on Linux)")
        print("  2. Another program using the port (close other terminals)")
        print("  3. FTDI drivers installed")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nInterrupted by user")
    except Exception as e:
        print(f"\n✗ Unexpected error: {e}")
        import traceback
        traceback.print_exc()

