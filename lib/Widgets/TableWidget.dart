import 'dart:math';

import 'package:church_admin/Widgets/OptionButton.dart';
import 'package:church_admin/Widgets/TableStatusWidget.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import '../CustomColors.dart';
import '../view/Tables/UserListList.dart';
import 'TableUserNameWidget.dart';

class TableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> testData;
  final String name;
  final double heightSize;

  const TableWidget({
    super.key,
    required this.testData,
    required this.name,
    this.heightSize = 0.52,
  });

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  int? _hoveredRowIndex;
  late int _rowsPerPage;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = WidgetsBinding.instance.window.physicalSize.height / WidgetsBinding.instance.window.devicePixelRatio > 800 ? 15 : 10;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.testData.isEmpty) {
      return const Center(child: Text("No data available."));
    }

    final tableData = widget.testData.first;
    final headers = tableData['header'] as List<String>? ?? [];
    final dataTypes = tableData['dataType'] as List<String>? ?? [];
    var dataRows = tableData['data'] as List<dynamic>? ?? [];

    if (headers.isEmpty || dataTypes.isEmpty || dataRows.isEmpty) {
      return const Center(child: Text("No data available."));
    }

    final double calculatedHeight =
        max(widget.heightSize, tableData['data'].length * 0.1);
    final double screenHeight = MediaQuery.of(context).size.height;
    print('Data ${dataRows.length}');
    print('Height Size$calculatedHeight');
    print('ScreenHeight$screenHeight');
    print('Container Height ${screenHeight * calculatedHeight}');

    var paginatedDataRows =
        dataRows.skip(_currentPage * _rowsPerPage).take(_rowsPerPage).toList();

    return Container(
      width: MediaQuery.of(context).size.width * 0.61,
      // height: 40 + (_rowsPerPage * 60) + 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFEEF1F4), width: 1.0),
      ),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10),

              //header
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2C3442),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
              const SizedBox(height: 2.0),

              // table
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: const Color(0xFFF6F7F9),
                    dataTableTheme: DataTableThemeData(
                      dividerThickness: 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xFFEEF1F4), width: 1.0),
                      ),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return DataTable(
                        border: const TableBorder(
                          horizontalInside:
                              BorderSide(color: Color(0xFFF7F9FC), width: 1.5),
                        ),
                        headingRowHeight: 35,
                        showCheckboxColumn: false,
                        columnSpacing: 0,
                        columns: headers.map((header) {
                          return DataColumn(
                            label: Container(
                              width: (MediaQuery.of(context).size.width * 0.61 -
                                      32) /
                                  headers.length,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  header,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        rows: List<DataRow>.generate(
                          paginatedDataRows.length,
                          (index) {
                            final row = paginatedDataRows[index];
                            return DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                (states) => _hoveredRowIndex == index
                                    ? Color(0xFFF6F7F9)
                                    : null,
                              ),
                              cells: List<DataCell>.generate(headers.length,
                                  (cellIndex) {
                                final cellType = dataTypes[cellIndex];
                                final cellKey = headers[cellIndex];
                                final cellData = row[cellKey] ?? 'Unknown';
                                return DataCell(
                                  Container(
                                    width: (MediaQuery.of(context).size.width *
                                                0.60 -
                                            32) /
                                        headers.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: MouseRegion(
                                        onEnter: (_) => setState(
                                            () => _hoveredRowIndex = index),
                                        onExit: (_) => setState(
                                            () => _hoveredRowIndex = null),
                                        child: _buildCellContent(
                                            cellType, cellData),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _rowsPerPage,
                        icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowDown01,
                            color: Colors.black54,
                            size: 18),
                        items: [5, 10, 15].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value rows per page'),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _rowsPerPage = newValue!;
                            _currentPage = 0;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowLeft01,
                              color: Colors.black54,
                              size: 18),
                          onPressed: _currentPage > 0
                              ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                            '${_currentPage + 1} of ${(dataRows.length / _rowsPerPage).ceil()}'),
                        IconButton(
                          icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.black54,
                              size: 18),
                          onPressed: (_currentPage + 1) * _rowsPerPage <
                                  dataRows.length
                              ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCellContent(String type, dynamic data) {
  switch (type) {
    case 'UserNameWithProfile':
      if (data is Map<String, dynamic>) {
        return UsernameWidget(
          username: data['name'] ?? 'Unknown',
          profilePictures: data['profilePictures'] ?? 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        );
      }
      return const Text('Invalid Data');

    case 'UserList':
      if (data is Map<String, dynamic>) {
        return UserList(userImages: data["profilePictures"] ,count: data["count"],);
      }
      return const Text('Invalid Data');

    case 'Date':
      return Tooltip(
        message: formatDate(data),
        child: Text(formatDate(data), overflow: TextOverflow.ellipsis),
      );

    case "Icon":
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(
            icon: data == 'Like'
                ? HugeIcons.strokeRoundedThumbsUp
                : HugeIcons.strokeRoundedView,
            color: Colors.black54,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(data.toString(), overflow: TextOverflow.ellipsis),
        ],
      );

    case 'Action':
      return OptionButton(menuItems: data   );

    case "Status":
      return data is String
          ? Status_Widget(status: data, statusColors: statusColors)
          : const Text('Invalid Data');

    case "Text":
      return Text(data.toString());

    case "Record Type":
      return Text(
        data.toString(),
        style:
            TextStyle(color: data == 'Receivable' ? Colors.green : Colors.red),
      );

    default:
      return const Text('Unknown');
  }
}

String formatDate(String date) {
  try {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = date.contains('T')
        ? DateFormat('hh:mm a, MMM dd, yyyy')
        : DateFormat('MMM dd, yyyy');
    return formatter.format(parsedDate);
  } catch (e) {
    return 'Invalid Date';
  }
}
