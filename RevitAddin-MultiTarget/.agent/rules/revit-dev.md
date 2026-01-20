# Revit Plugin Development Standards
- **Project Style:** Always use .NET SDK-style projects (Nice3point standard).
- **Multi-Targeting:** Target `net48` for Revit 2020–2024. Use `<RevitVersion>` properties.
- **API References:** Use `Nice3point.Revit.Api` NuGet packages instead of local DLL paths for portability.
- **Version Shims:** Use `#if REVIT2024` and `#if REVIT2020` for breaking changes (like Units/ForgeTypeId).
- **Naming:** Follow Revit API PascalCase; use `IExternalCommand` for entry points.
