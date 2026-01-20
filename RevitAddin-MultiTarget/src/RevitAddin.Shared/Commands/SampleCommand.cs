using System;
using Autodesk.Revit.Attributes;
using Autodesk.Revit.DB;
using Autodesk.Revit.UI;

namespace RevitAddin.Commands
{
    [Transaction(TransactionMode.Manual)]
    public class SampleCommand : IExternalCommand
    {
        public Result Execute(ExternalCommandData commandData, ref string message, ElementSet elements)
        {
            Document doc = commandData.Application.ActiveUIDocument.Document;

            // Example: Select first Wall and get Volume
            Element selected = new FilteredElementCollector(doc).OfClass(typeof(Wall)).FirstElement();

            if (selected == null)
            {
                TaskDialog.Show("Error", "No walls found in the document.");
                return Result.Failed;
            }

            Parameter volParam = selected.get_Parameter(BuiltInParameter.HOST_VOLUME_COMPUTED);
            double volume = 0;

            if (volParam != null && volParam.HasValue)
            {
#if REVIT2024
                volume = volParam.AsDouble(); // 2024 uses ForgeTypeId internally but AsDouble returns internal units (cubic feet)
                // If we needed to convert units using UnitUtils:
                // double cubicMeters = UnitUtils.ConvertFromInternalUnits(volume, UnitTypeId.CubicMeters);
#else
                volume = volParam.AsDouble(); // 2020 uses DisplayUnitType
                // double cubicMeters = UnitUtils.ConvertFromInternalUnits(volume, DisplayUnitType.DUT_CUBIC_METERS);
#endif
            }

            TaskDialog.Show("Volume", $"Wall Volume: {volume:F2} (Internal Units)");

            return Result.Succeeded;
        }
    }
}
