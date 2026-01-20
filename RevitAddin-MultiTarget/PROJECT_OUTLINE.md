# Project Roadmap & Outline

This outline serves as a guide for continuing development. Checkpoints are included to ensure stability before moving forward.

## ✅ Phase 1: Foundation & Infrastructure (Completed)
- [x] **Directory Structure**: Setup `.agent`, `src`, and `output` folders.
- [x] **Build System**: Configured `RevitAddin.csproj` for multi-targeting (Revit 2020 & 2024).
- [x] **AI Configuration**: Defined `.agent/rules/revit-dev.md` for coding standards.
- [x] **Deployment Automation**: Created `deploy.ps1` for Windows 11 compatibility.
- [x] **Proof of Concept**: Implemented `SampleCommand.cs` to verify API version switching.

---

## 🚧 Phase 2: Core Functionality (Current Focus)
**Goal:** Implement the essential interactive features of the plugin.

- [ ] **Checkpoint 2.1: UI Foundation**
    - Set up a WPF (Windows Presentation Foundation) Window for user input.
    - Ensure the UI looks correct in both Revit 2020 (Light Theme) and 2024 (Dark Theme support).
- [ ] **Checkpoint 2.2: Event Handling**
    - Implement `IExternalApplication` to add a Ribbon Tab and Buttons on startup.
    - Add an "Idle" event handler to perform background tasks if needed.
- [ ] **Checkpoint 2.3: Data Logic**
    - Create a model to export Revit Schedule data to CSV/JSON.
    - Test data export on both versions to ensure parameter compatibility.

---

## 🔮 Phase 3: Advanced Integration
**Goal:** Connect the plugin to external systems or advanced AI workflows.

- [ ] **Checkpoint 3.1: External Database**
    - Connect the plugin to a local SQLite or cloud database.
    - **Verify:** Ensure database drivers work on .NET 4.8.
- [ ] **Checkpoint 3.2: AI "Chat with Model"**
    - Implement a dockable pane that allows users to ask questions about the Revit model (using an LLM API).
- [ ] **Checkpoint 3.3: Automated Testing**
    - specific Revit integration tests using `RevitTestFramework` or similar.

---

## 🚀 Phase 4: Polish & Release
**Goal:** Prepare the plugin for distribution to other users.

- [ ] **Checkpoint 4.1: Installer**
    - Create an `.msi` or `.exe` installer using Inno Setup or WiX.
    - Ensure the installer correctly detects installed Revit versions.
- [ ] **Checkpoint 4.2: Signing**
    - Digitally sign the DLLs to remove "Unknown Publisher" warnings.
- [ ] **Checkpoint 4.3: User Manual**
    - Generate a PDF guide with screenshots of the tools.
