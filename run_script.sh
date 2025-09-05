#!/bin/bash
# Wrapper script to add additional safety measures

# Set memory and time limits
ulimit -v 100000  # Limit virtual memory to ~100MB
timeout 30s python /app/unsafe_script.py
