// lib/widgets/custom_table.dart

import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomTable extends StatelessWidget {
  final List<String> columnTitles;
  final List<Map<String, dynamic>> data;
  final Map<String, String> fieldMapping;
  final VoidCallback onAddPressed;
  final Function(Map<String, dynamic>) onInfoPressed;
  final Function(Map<String, dynamic>) onEditPressed;
  final Function(Map<String, dynamic>) onDeletePressed;

  CustomTable({
    required this.columnTitles,
    required this.data,
    required this.fieldMapping,
    required this.onAddPressed,
    required this.onInfoPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                columnSpacing: 20.0,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => primaryColor1),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => backgroundColor1),
                columns: columnTitles
                    .map((title) => DataColumn(
                          label: Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ))
                    .toList(),
                rows: data.map((item) {
                  return DataRow(
                    cells: columnTitles.map((title) {
                      if (title == 'Actions') {
                        return DataCell(Row(
                          children: [
                            Tooltip(
                              message: 'View Info',
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () => onInfoPressed(item),
                                child: Icon(Icons.info, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 4),
                            Tooltip(
                              message: 'Edit',
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () => onEditPressed(item),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 4),
                            Tooltip(
                              message: 'Delete',
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () => onDeletePressed(item),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ],
                        ));
                      } else {
                        return DataCell(Text(
                          item[fieldMapping[title]]?.toString() ?? 'N/A',
                          style: TextStyle(color: textColor3, fontSize: 14),
                        ));
                      }
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
