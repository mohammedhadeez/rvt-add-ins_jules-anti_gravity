# User Guide: The Antigravity Revit Workflow

## 🚀 The Layman's Guide ("Just tell me how to drive")

**What is this?**
Think of this as a "Smart Factory" for building Revit Add-ins. You don't build the car by hand; you tell the robots (Agents) what you want, and they assemble it using the parts we've organized.

**How do I use it?**
1.  **Open the Folder:** Open this repository in your Antigravity (or VS Code) editor.
2.  **Tell the Agent:** Open the "Chat" or "Manager" view and say:
    > "Create a new button on the Revit Ribbon that selects all Doors in the project."
3.  **Watch it Build:** The Agent will write the code, and then you (or the agent) will run the build command.
4.  **Open Revit:** Your new tool will appear.
    *   *Note: By default, simple commands appear under the "Add-Ins" tab > "External Tools". To get a custom Ribbon button, you specifically need to ask the Agent to "Implement IExternalApplication".*

**What if it breaks?**
If Revit gives you an error, take a screenshot of the error, show it to the Agent, and say "Fix this." The Agent has a rulebook (`.agent/rules`) that tells it how to solve common Revit problems.

---

## 🛠 Structured Technical Guide

### 1. Prerequisites
- **Windows 11** (Recommended)
- **Visual Studio 2022** (Installed with .NET Desktop Development workload).
- **Revit 2020** and/or **Revit 2024** installed.

### 2. Building the Project
You can build the project manually using the terminal. Open the `RevitAddin-MultiTarget` folder in a terminal:

**To build for Revit 2024:**
```powershell
dotnet build src/RevitAddin.csproj -c "Release 2024"
```

**To build for Revit 2020:**
```powershell
dotnet build src/RevitAddin.csproj -c "Release 2020"
```

### 3. Deploying (Installing to Revit)
We have an automated script for this. After building, run:

```powershell
# Deploy 2024 version
./.agent/skills/deploy.ps1 -version "2024"

# Deploy 2020 version
./.agent/skills/deploy.ps1 -version "2020"
```
*This script will copy the files to `%AppData%\Autodesk\Revit\Addins\` and unblock them so Windows doesn't complain.*

### 4. Extending the Plugin
To add new features manually:
1.  Go to `src/RevitAddin.Shared/Commands/`.
2.  Duplicate `SampleCommand.cs`.
3.  Rename the class and change the logic inside `Execute`.
4.  **Important:** If using a Revit API feature that changed (like Units), use `#if REVIT2024` blocks as shown in `SampleCommand.cs`.

### 5. Troubleshooting
- **"Command Not Found"**: Check your `.addin` file in the deployment folder to make sure the paths are correct.
- **"Could not load file or assembly"**: Run the `deploy.ps1` script again to ensure files are "Unblocked".
