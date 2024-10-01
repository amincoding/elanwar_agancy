import 'dart:io';
import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/core/providers/session_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/providers/delete_reservation_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/providers/update_reservation_provider.dart';
import 'package:elanwar_agancy_flutter/features/invoice_screen/screens/invoice_screen.dart';
import 'package:elanwar_agancy_flutter/utils/toast_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

class ReservationsScreen extends ConsumerStatefulWidget {
  const ReservationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationsScreenState();
}

class _ReservationsScreenState extends ConsumerState<ReservationsScreen> {
  String _searchQuery = '';
  bool _showEndedReservations = false;
  bool _showWithDebt = false;

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
            child: filteredReservations.isEmpty
                ? const Center(
                    child: Text(
                      'لا يوجد ماتبحث عنه',
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
                              child: Text('تعديل أو إلغاء',
                                  textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child:
                                  Text('الديون', textAlign: TextAlign.center)),
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
                              child:
                                  Text('الفندق', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child:
                                  Text('الزبون', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('المستخدم',
                                  textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('رقم بطاقة التعريف',
                                  textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('ID', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(
                              child:
                                  Text('Action', textAlign: TextAlign.center)),
                        ),
                      ],
                      rows: filteredReservations.map((reservation) {
                        int index = filteredReservations.indexOf(reservation) +
                            1; // Get the index (1-based)

                        return DataRow(
                          cells: [
                            DataCell(TextButton(
                              child: const Icon(Icons.edit),
                              onPressed: () {
                                edit(context, ref, reservation!.id!);
                              },
                            )),
                            DataCell(
                                Text("${reservation!.debt.toString()} دج")),
                            DataCell(
                              isDeadlinePassed(DateTime(
                                      reservation.endDate.year,
                                      reservation.endDate.month,
                                      reservation.endDate.day))
                                  ? const Icon(Icons.check, color: Colors.red)
                                  : const Icon(Icons.close,
                                      color: Colors.green),
                            ),
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
                            DataCell(Text(reservation.idCardNumber.toString())),
                            // Index column
                            DataCell(Text(
                                index.toString())), // Display the row number
                            DataCell(TextButton(
                              child: const Icon(Icons.print),
                              onPressed: () async {
                                await context
                                    .push(InvoiceScreen.route(index - 1));
                              },
                            )),
                          ],
                        );
                      }).toList(),
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

Future<void> edit(BuildContext context, WidgetRef ref, int id) async {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController payedController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idCardNumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  final reservations = ref.read(getAllReservationsProvider);

  return showDialog<void>(
    barrierColor: Colors.blue[50],
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Function to calculate remaining debt
          double calculateRemainingDebt() {
            double totalPrice = double.tryParse(totalPriceController.text) ?? 0;
            double payedPrice = double.tryParse(payedController.text) ?? 0;
            return totalPrice - payedPrice;
          }

          // Determine if the debt field is visible
          bool isDebtVisible = calculateRemainingDebt() > 0;

          // Function to pick date
          Future<void> _pickDate(BuildContext context, bool isStart) async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                if (isStart) {
                  selectedStartDate = pickedDate;
                } else {
                  selectedEndDate = pickedDate;
                }
              });
            }
          }

          // Function to pick time
          Future<void> _pickTime(BuildContext context, bool isStart) async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                if (isStart) {
                  selectedStartTime = pickedTime;
                } else {
                  selectedEndTime = pickedTime;
                }
              });
            }
          }

          return AlertDialog(
            title: const Center(
                child: Text(
              'أضف زبونا بملأ كل الخانات ثم إضغط على تأكيد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 28,
                color: Colors.black,
              ),
            )),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset(
                        "assets/images/client.png",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Full Name TextField
                          _buildTravelTextField(
                            label: 'الإسم الكامل',
                            hint: 'الإسم الكامل',
                            controller: fullNameController,
                            icon: const Icon(
                              Icons.text_fields_outlined,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Hotel Name TextField
                          _buildTravelTextField(
                            label: 'إسم الفندق',
                            hint: 'إسم الفندق',
                            controller: hotelNameController,
                            icon: const Icon(
                              Icons.home_work_outlined,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Room Number TextField
                          _buildTravelTextField(
                            label: 'رقم الغرفة',
                            hint: 'رقم الغرفة',
                            controller: roomNumberController,
                            icon: const Icon(
                              Icons.bed,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTravelTextField(
                            label: 'رقم بطاقة التعريق',
                            hint: 'رقم بطاقة التعريق',
                            controller: idCardNumberController,
                            icon: const Icon(
                              Icons.call_to_action_rounded,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTravelTextField(
                            label: 'رقم الهاتق',
                            hint: 'رقم الهاتق',
                            controller: phoneNumberController,
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTravelTextField(
                            label: 'مكان السكن',
                            hint: 'مكان السكن',
                            controller: adressController,
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Total Price TextField
                          _buildTravelTextField(
                            label: 'السعر الإجمالي',
                            hint: 'السعر الإجمالي',
                            controller: totalPriceController,
                            icon: const Icon(
                              Icons.price_check_sharp,
                              color: Colors.blue,
                            ),
                            onChanged: (value) {
                              setState(() {
                                isDebtVisible = calculateRemainingDebt() > 0;
                              });
                            },
                          ),
                          const SizedBox(height: 10),

                          // Payed TextField
                          _buildTravelTextField(
                            label: 'المبلغ المدفوع',
                            hint: 'المبلغ المدفوع',
                            controller: payedController,
                            icon: const Icon(
                              Icons.monetization_on,
                              color: Colors.blue,
                            ),
                            onChanged: (value) {
                              setState(() {
                                isDebtVisible = calculateRemainingDebt() > 0;
                              });
                            },
                          ),
                          const SizedBox(height: 10),

                          // Debt (readonly, showing remaining price)
                          if (isDebtVisible)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 125,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue[50],
                                  ),
                                  child: Center(
                                    child: Text(
                                      ("دج ${calculateRemainingDebt().toString()}"),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'الباقي',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 20),

                          // Date & Time Pickers for Start Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => _pickDate(context, true),
                                child: Text(
                                  selectedStartDate != null
                                      ? "تم الإختيار"
                                      : 'اختر تاريخ البدء',
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.001),
                              ElevatedButton(
                                onPressed: () => _pickTime(context, true),
                                child: Text(
                                  selectedStartTime != null
                                      ? "تم الإختيار"
                                      : 'اختر وقت البدء',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Date & Time Pickers for End Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => _pickDate(context, false),
                                child: Text(
                                  selectedEndDate != null
                                      ? "تم الإختيار"
                                      : 'اختر تاريخ النهاية',
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.001),
                              ElevatedButton(
                                onPressed: () => _pickTime(context, false),
                                child: Text(
                                  selectedEndTime != null
                                      ? "تم الإختيار"
                                      : 'اختر وقت النهاية',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final user = ref.read(sessionProvider).user!.id;
                      var startTime = DateTime(
                        selectedStartDate!.year,
                        selectedStartDate!.month,
                        selectedStartDate!.day,
                        selectedStartTime!.hour,
                        selectedStartTime!.minute,
                      );
                      var endTime = DateTime(
                        selectedEndDate!.year,
                        selectedEndDate!.month,
                        selectedEndDate!.day,
                        selectedEndTime!.hour,
                        selectedEndTime!.minute,
                      );
                      ref.read(
                        updateReservationProvider(
                          Reservation(
                              id: id,
                              userId: user!,
                              fullName: fullNameController.text,
                              hotel: hotelNameController.text,
                              room: int.parse(roomNumberController.text),
                              totalPrice:
                                  double.parse(totalPriceController.text),
                              startDate: startTime,
                              endDate: endTime,
                              payed: double.parse(payedController.text),
                              debt: double.parse(totalPriceController.text) -
                                  double.parse(payedController.text),
                              isExpired: false,
                              createAt: DateTime.now(),
                              phoneNumber: phoneNumberController.text,
                              idCardNumber:
                                  int.parse(idCardNumberController.text),
                              adress: adressController.text),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'تأكيد ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final success = await ref
                          .read(deleteReservationProvider(id).notifier)
                          .deleteReservation();
                      if (success) {
                        context.pop();
                        toast(context, "عملية حذف ناجحة",
                            "تم حذف الحجز الخاص بعميلك ");
                      } else {
                        // Handle failure
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'حذف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'إلغاء ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildTravelTextField({
  required String label,
  required String hint,
  required TextEditingController controller,
  required Icon icon,
  Function(String)? onChanged,
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    textDirection: TextDirection.rtl,
    decoration: InputDecoration(
      alignLabelWithHint: true,
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
  );
}
