import 'package:elanwar_agancy_flutter/core/providers/session_provider.dart';
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
        leading: TextButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).logOut();
            },
            child: const Icon(Icons.logout_outlined)),
        actions: [
          const Text(
            'وكالة الأنوار السياحية',
            style: TextStyle(
              fontFamily: "Aref",
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset("assets/images/anwar.png"),
        ],
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add(context, ref);
        },
        child: const Text("إضافة "),
      ),
    );
  }

  // Helper function for building text fields
  Widget _buildTravelTextField({required String hint, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: true,
        fillColor: Colors.teal[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

Future<void> add(BuildContext context, WidgetRef ref) async {
  final user = ref.read(sessionProvider).user;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController payedController = TextEditingController();
  TextEditingController debtController = TextEditingController();

  return showDialog<void>(
    barrierColor: Colors.teal[100],
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Condition for enabling or disabling the debt field
          bool isDebtVisible =
              (double.tryParse(totalPriceController.text) ?? 0) >
                  (double.tryParse(payedController.text) ?? 0);

          return AlertDialog(
            title: const Center(
                child: Text(
              'أضف زبونا بملأ كل الخانات ثم إضغط على تأكيد',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 28,
                color: Colors.black,
              ),
            )),
            content: Container(
              width: MediaQuery.of(context).size.width *
                  0.7, // Adjusted the width to be wider
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
                            icon: Icon(
                              Icons.text_fields_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Hotel Name TextField
                          _buildTravelTextField(
                            label: 'إسم الفندق',
                            hint: 'إسم الفندق',
                            controller: hotelNameController,
                            icon: Icon(
                              Icons.home_work_outlined,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Room Number TextField
                          _buildTravelTextField(
                            label: 'رقم الغرفة',
                            hint: 'رقم الغرفة',
                            controller: roomNumberController,
                            icon: Icon(
                              Icons.bed,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Total Price TextField
                          _buildTravelTextField(
                            label: 'السعر الإجمالي',
                            hint: 'السعر الإجمالي',
                            controller: totalPriceController,
                            icon: Icon(
                              Icons.price_check_sharp,
                              color: Colors.teal,
                            ),
                            onChanged: (value) {
                              setState(() {
                                isDebtVisible = (double.tryParse(
                                            totalPriceController.text) ??
                                        0) >
                                    (double.tryParse(payedController.text) ??
                                        0);
                              });
                            },
                          ),
                          SizedBox(height: 10),

                          // Payed TextField
                          _buildTravelTextField(
                            label: 'الديون',
                            hint: 'الديون',
                            controller: payedController,
                            icon: Icon(
                              Icons.monetization_on,
                              color: Colors.teal,
                            ),
                            onChanged: (value) {
                              setState(() {
                                isDebtVisible = (double.tryParse(
                                            totalPriceController.text) ??
                                        0) >
                                    (double.tryParse(payedController.text) ??
                                        0);
                              });
                            },
                          ),
                          SizedBox(height: 10),

                          // Debt TextField (only visible when total price > payed)
                          if (isDebtVisible)
                            _buildTravelTextField(
                              label: 'الباقي',
                              hint: 'الباقي',
                              controller: debtController,
                              isEnabled: true,
                              icon: Icon(
                                Icons.money_off,
                                color: Colors.teal,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
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
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

// Helper function to build the text fields
Widget _buildTravelTextField({
  required String label,
  required String hint,
  required Icon icon,
  required TextEditingController controller,
  bool isEnabled = true,
  Function(String)? onChanged,
}) {
  return TextField(
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    controller: controller,
    enabled: isEnabled,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintTextDirection: TextDirection.rtl,
      alignLabelWithHint: true,
      hintText: hint,
      fillColor: isEnabled ? Colors.teal[50] : Colors.grey[300],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: icon,
    ),
  );
}
