import os
import sys
import time

def potentially_harmful_script():
    """
    Simulate a script with potentially risky operations
    IMPORTANT: This is a DEMO script to show isolation, NOT an actual malicious script
    """
    print("Starting potentially harmful script demonstration...")
    
    # Simulate various potentially risky operations
    try:
        # Attempt to list root directory (simulating file system probe)
        print("Attempting to list root directory:")
        print(os.listdir('/'))
        
        # Simulate trying to access system information
        print("\nTrying to get system information:")
        print(f"Current User: {os.getlogin()}")
        print(f"Current PID: {os.getpid()}")
        
        # Simulate resource consumption
        print("\nSimulating resource consumption:")
        data = []
        for i in range(10):
            data.append('x' * (1024 * 1024))  # Allocate 10MB
            print(f"Allocated {len(data)} MB")
            time.sleep(0.5)
        
    except Exception as e:
        print(f"Operation limited by container isolation: {e}")
    
    print("\nScript completed. Notice how potential harmful actions are contained!")

if __name__ == "__main__":
    potentially_harmful_script()
