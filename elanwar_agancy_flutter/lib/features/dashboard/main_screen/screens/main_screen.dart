import 'dart:io';

import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/core/providers/session_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/add_reservation_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/reservatoins_screen.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/reservatoins_screen_android.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'وكالة الأنوار السياحية',
          style: TextStyle(
            fontFamily: "Aref",
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                ref.refresh(getAllReservationsProvider);
              },
              child: const Text(
                "Refresh",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      drawer: _buildDrawer(context, ref),
      body: Platform.isAndroid
          ? const ReservatoinsScreenAndroid()
          : const ReservationsScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          add(context, ref);
        },
        child: const Text("إضافة "),
      ),
    );
  }

  // Drawer widget function
  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/anwar.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'وكالة الأنوار السياحية',
                  style: TextStyle(
                    fontFamily: "Aref",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // ListTile for home screen
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
              textDirection: TextDirection.rtl,
            ),
            title: const Text(
              textDirection: TextDirection.rtl,
              'الصفحة الرئيسية',
              style: TextStyle(
                fontFamily: "Aref",
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to the home screen or perform some action
            },
          ),

          // ListTile for adding a new customer
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded, color: Colors.blue),
            title: const Text(
              textDirection: TextDirection.rtl,
              'الإحصائيات',
              style: TextStyle(
                fontFamily: "Aref",
                fontSize: 22,
              ),
            ),
            onTap: () {
              context.push("/stats");
            },
          ),
          const ListTile(
            leading: Icon(Icons.add, color: Colors.blue),
            title: Text(
              textDirection: TextDirection.rtl,
              'إضافة زبون',
              style: TextStyle(
                fontFamily: "Aref",
                fontSize: 22,
              ),
            ),
            onTap: null,
          ),

          // Divider to separate logout option
          const Divider(),

          // ListTile for logging out
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              textDirection: TextDirection.rtl,
              'تسجيل الخروج',
              style: TextStyle(
                fontFamily: "Aref",
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              ref.read(sessionProvider.notifier).logOut(); // Logout action
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          ListTile(
            title: Center(
              child: Text(
                textDirection: TextDirection.rtl,
                'مرحبا ${ref.read(sessionProvider).user!.userName}',
                style: const TextStyle(
                  fontFamily: "Aref",
                  fontSize: 22,
                ),
              ),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}

Future<void> add(BuildContext context, WidgetRef ref) async {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController payedController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => _pickDate(context, true),
                                child: Text(
                                  selectedStartDate != null
                                      ? "${selectedStartDate!.toLocal()}"
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
                                      ? selectedStartTime!.format(context)
                                      : 'اختر وقت البدء',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Date & Time Pickers for End Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => _pickDate(context, false),
                                child: Text(
                                  selectedEndDate != null
                                      ? "${selectedEndDate!.toLocal()}"
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
                                      ? selectedEndTime!.format(context)
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
                      ref.read(addReservationProvider(Reservation(
                          userId: user!,
                          fullName: fullNameController.text,
                          hotel: hotelNameController.text,
                          room: int.parse(roomNumberController.text),
                          totalPrice: double.parse(totalPriceController.text),
                          startDate: startTime,
                          endDate: endTime,
                          payed: double.parse(payedController.text),
                          debt: double.parse(totalPriceController.text) -
                              double.parse(payedController.text),
                          isExpired: false)));
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

// Helper function for creating TextFields with icons
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
