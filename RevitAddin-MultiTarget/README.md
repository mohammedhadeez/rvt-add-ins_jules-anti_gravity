# RevitAddin Multi-Target

This project is configured to target Revit 2020 and Revit 2024 using a single codebase and SDK-style project.

## Structure

- `.agent/`: Antigravity configuration (Rules and Skills).
- `src/`: Source code.
  - `RevitAddin.Shared/`: Shared code for all versions.
  - `RevitAddin.csproj`: Multi-target project file.
- `output/`: Build artifacts directory.

## Building

Use the Antigravity workflow or `dotnet build` with the specific configuration:

```bash
dotnet build -c "Release 2020"
dotnet build -c "Release 2024"
```

## Deployment

See `.agent/skills/deploy.ps1` for deployment logic.
