# Date Changer + Steam Offline Launcher (for PAYDAY 2)

## 📄 File: `date_changer.ps1`

This PowerShell script is designed to temporarily change your system date and automate launching **PAYDAY 2** in **Steam Offline Mode**. 
This can be useful for reverting to older in-game states or accessing specific time-based content.

---

## 🔧 What the Script Does (Step-by-Step)

1. **Checks if Steam is closed.**
2. **Stops the Windows Time service** to allow manual date changes.
3. **Temporarily sets your system date** to a custom past date (e.g. `07/20/2023`).
4. **Launches PAYDAY 2 in Offline Mode** using the `steam://launch` protocol.
5. **Waits for user confirmation** before restoring the correct date.
6. **Restores your real system date and time** using `w32tm`.
7. **Restarts the Windows Time service**.

---

## 🧍 What You Need To Do (Manually)

After the script launches PAYDAY 2:

1. **Skip the intro cutscenes** as soon as possible.
2. When prompted with the **“Network Error”** popup, click **“PLAY OFFLINE”**.
3. Once you reach the main menu, **press `ENTER` in the PowerShell window** to proceed.
4. The system date will now return to normal automatically.
5. Finally, go back into **Steam** and click **“Go Online”** to return to online mode.

---

## ⚠️ Important Notes

- You **must run this script as Administrator**.
- Script **modifies your system clock temporarily**, which may affect other apps during its run.
