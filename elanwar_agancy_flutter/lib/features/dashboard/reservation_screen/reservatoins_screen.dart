import 'dart:io';

import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl; // For formatting dates

class ReservationsScreen extends ConsumerStatefulWidget {
  const ReservationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationsScreenState();
}

class _ReservationsScreenState extends ConsumerState<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    final reservations = ref.watch(getAllReservationsProvider);

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
      body: Platform.isAndroid
          ? Center(
              heightFactor: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: reservations.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد حجوزات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: SingleChildScrollView(
                          dragStartBehavior: DragStartBehavior.start,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing:
                                12.0, // Adjusted space between columns
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
                                    child: Text('ID',
                                        textAlign: TextAlign.center)),
                              ),
                            ],
                            rows: reservations.map((reservation) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(reservation!.debt.toString())),
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
                                  // Formatted date display
                                  DataCell(
                                    Text(
                                      intl.DateFormat('dd/MM/yyyy')
                                          .format(reservation.endDate),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      intl.DateFormat('dd/MM/yyyy')
                                          .format(reservation.startDate),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  DataCell(Text(reservation.payed.toString())),
                                  DataCell(
                                      Text(reservation.totalPrice.toString())),
                                  DataCell(Text(reservation.room.toString())),
                                  DataCell(
                                    Flexible(
                                      child: Text(
                                        reservation.hotel.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Flexible(
                                      child: Text(
                                        reservation.fullName.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Flexible(
                                      child: Text(
                                        reservation.user!.userInfo!.userName!
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
            )
          : Center(
              heightFactor: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: reservations.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد حجوزات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        dragStartBehavior: DragStartBehavior.start,
                        scrollDirection: Axis.vertical,
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
                          rows: reservations.map((reservation) {
                            return DataRow(
                              cells: [
                                DataCell(Text(reservation!.debt.toString())),
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
                                // Formatted date display
                                DataCell(
                                  Text(
                                    intl.DateFormat('dd/MM/yyyy')
                                        .format(reservation.endDate),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    intl.DateFormat('dd/MM/yyyy')
                                        .format(reservation.startDate),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                DataCell(Text(reservation.payed.toString())),
                                DataCell(
                                    Text(reservation.totalPrice.toString())),
                                DataCell(Text(reservation.room.toString())),
                                DataCell(
                                  Flexible(
                                    child: Text(
                                      reservation.hotel.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Flexible(
                                    child: Text(
                                      reservation.fullName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Flexible(
                                    child: Text(
                                      reservation.user!.userInfo!.userName!
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
