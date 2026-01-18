# Project Goals & Overview

## What is this project?
This is a **Modern Revit Plugin Development Framework** designed to work seamlessly with **Google Antigravity** (an AI-powered coding environment).

## Core Objectives
1.  **Multi-Version Support**: Run a single codebase that works perfectly on both **Revit 2020** (older .NET Framework) and **Revit 2024** (modern features), automatically handling the differences between them.
2.  **AI-First Workflow**: The project is structured specifically so AI agents can understand it. It includes "Rules" and "Skills" that teach an AI how to build, deploy, and fix the code without human intervention.
3.  **Rapid Prototyping**: Provide a pre-built scaffold (skeleton) so you can focus on the *feature* (e.g., "Make a wall tool") rather than the *setup* (e.g., "Why won't Visual Studio load?").

## Key Components
- **`src/RevitAddin.Shared`**: The "brain" of the project. You write code here once, and it works everywhere.
- **`.agent/rules`**: The "instruction manual" for the AI. It forces the AI to follow best practices (like using the right Revit API calls).
- **`.agent/skills/deploy.ps1`**: A script that automatically installs your plugin into Revit, handling Windows 11 security settings that usually block plugins.

## Current Status
We have established the **Foundation (Phase 1)**. The directory structure, build system, and basic AI instructions are in place. The system is ready for actual feature development.
