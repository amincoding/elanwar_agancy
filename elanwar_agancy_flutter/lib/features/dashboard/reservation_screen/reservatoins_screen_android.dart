import 'dart:io';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

class ReservatoinsScreenAndroid extends ConsumerStatefulWidget {
  const ReservatoinsScreenAndroid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationsScreenState();
}

class _ReservationsScreenState
    extends ConsumerState<ReservatoinsScreenAndroid> {
  String _searchQuery = '';
  bool _showEndedReservations = false;
  bool _showWithDebt = false;

  Future<void> _refreshReservations() async {
    // Add logic here to refresh the reservations.
    // For example, you can trigger the provider to reload data.
    ref.refresh(getAllReservationsProvider);
    // Simulate a delay (e.g., for an API call)
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final reservations = ref.watch(getAllReservationsProvider);

    // Apply filters
    var filteredReservations = reservations.where((reservation) {
      final isNameMatch = reservation!.fullName.contains(_searchQuery);
      final isHotelMatch = reservation.hotel.contains(_searchQuery);
      final isRoomMatch = reservation.room.toString().contains(_searchQuery);
      final isDebtMatch = !_showWithDebt || reservation.debt! > 0.0;
      final isEndedMatch = !_showEndedReservations ||
          isDeadlinePassed(DateTime(reservation.endDate.year,
              reservation.endDate.month, reservation.endDate.day));

      return (isNameMatch || isHotelMatch || isRoomMatch) &&
          isDebtMatch &&
          isEndedMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          width: 125,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: const Center(
            child: Text(
              'قائمة الحجوزات',
              style: TextStyle(
                fontFamily: "Aref",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Field
                TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText:
                        'إبحث بإستعمال إسم الزبون أو إسم الفندق وكذلك رقم الغرفة',
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Filter for ended reservations
                    Checkbox(
                      value: _showEndedReservations,
                      onChanged: (value) {
                        setState(() {
                          _showEndedReservations = value!;
                        });
                      },
                    ),
                    const Text("أظهر الحجوزات المنتهية"),

                    const SizedBox(width: 16),
                    // Filter for users with debt
                    Checkbox(
                      value: _showWithDebt,
                      onChanged: (value) {
                        setState(() {
                          _showWithDebt = value!;
                        });
                      },
                    ),
                    const Text("أظهر أصحاب الديون"),
                  ],
                ),
              ],
            ),
          ),
          // Expanded table with search and filtering
          Expanded(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh:
                  _refreshReservations, // Adding drag-to-refresh capability
              child: filteredReservations.isEmpty
                  ? const Center(
                      child: Text(
                        'No reservations found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis
                          .horizontal, // Horizontal scroll for smaller screens
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: 600), // Ensure minimum width for table
                        child: DataTable(
                          columnSpacing: 12.0, // Adjusted space between columns
                          columns: const [
                            DataColumn(
                              label: Center(
                                  child: Text('المبلغ المتبقي',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('منتهي الصلاحية',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('تاريخ الانتهاء',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('تاريخ الإنشاء',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('المبلغ المدفوع',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('السعر الإجمالي',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('رقم الغرفة',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('الفندق',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('الزبون',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text('المستخدم',
                                      textAlign: TextAlign.center)),
                            ),
                            DataColumn(
                              label: Center(
                                  child:
                                      Text('ID', textAlign: TextAlign.center)),
                            ),
                          ],
                          rows: filteredReservations.map((reservation) {
                            return DataRow(
                              cells: [
                                DataCell(
                                    Text("${reservation!.debt.toString()} دج")),
                                DataCell(
                                  isDeadlinePassed(DateTime(
                                          reservation.endDate.year,
                                          reservation.endDate.month,
                                          reservation.endDate.day))
                                      ? const Icon(Icons.check,
                                          color: Colors.red)
                                      : const Icon(Icons.close,
                                          color: Colors.green),
                                ),
                                // Adjust date display to fit smaller screens
                                DataCell(
                                  Text(
                                    intl.DateFormat('dd/MM/yy')
                                        .format(reservation.endDate),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    intl.DateFormat('dd/MM/yy')
                                        .format(reservation.startDate),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                DataCell(
                                    Text("${reservation.payed.toString()} دج")),
                                DataCell(Text(
                                    "${reservation.totalPrice.toString()} دج")),
                                DataCell(Text(reservation.room.toString())),
                                DataCell(
                                  Text(
                                    reservation.hotel.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    reservation.fullName.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    reservation.user!.userInfo!.userName!
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(Text(reservation.id.toString())),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isDeadlinePassed(DateTime endDate) {
  DateTime now = DateTime.now();

  // Remove time components for accurate day comparison
  DateTime endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);
  DateTime todayOnly = DateTime(now.year, now.month, now.day);

  // Compare dates
  return endDateOnly.isBefore(todayOnly);
}
