# FileIntegrityMonitor
This project involves developing a custom File Integrity Monitor using PowerShell. It leverages hashing algorithms like SHA-512 to detect unauthorized changes to critical files, helping to ensure system integrity and security.

# 🛠️ Features
Uses SHA-512 (or other algorithms) to generate file hashes

Automates the process of generating and comparing file hashes

Supports real-time or scheduled monitoring

Alerts when unauthorized file modifications are detected

Easy to customize for different directories or file types

# 📦 Requirements
Windows OS

PowerShell 5.1 or later

Administrative privileges (recommended for critical system files)

# 🚀 Setup Instructions
1. Create a powershell file : fim.ps1

2. Prepare the target folder

3. Create a folder to monitor (if you haven’t already):
   C:\Users\arjun\OneDrive\Desktop\FIM
   Put the critical files you want to monitor into this folder.

4. Check or adjust the execution policy
   PowerShell may block the script by default. Open PowerShell as Administrator and run: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   This will allow scripts to run in your current session without changing the system-wide policy.

5. Run the script

6. Navigate to the directory where the script is saved:cd C:\Users\arjun\OneDrive\Desktop

7. Run the script: .\fim.ps1

8. Choose an option when prompted

   Press A → to collect a new baseline (creates baseline.txt with file hashes).
   Press B → to start monitoring files against the saved baseline.

   New baseline (A) → overwrites baseline.txt with fresh hashes of all files in the FIM folder.
   Monitor (B) → runs an infinite loop:

   Reports new files → shows in green.
   Reports modified files → shows in yellow.
   Reports deleted files → shows in red.

9. (Optional) Stop monitoring
    Since option B runs in an infinite loop, press:Ctrl + C in PowerShell to stop it.
   
# 📸 Screenshots
![Screenshot 2025-05-02 170913](https://github.com/user-attachments/assets/2582c35c-b1de-48ef-a947-e3d288ecc2cc)

