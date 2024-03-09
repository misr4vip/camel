import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/camelModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddCamel extends StatefulWidget {
  const AddCamel({super.key});

  @override
  State<AddCamel> createState() => _AddCamelState();
}

class _AddCamelState extends State<AddCamel> {
  var ownerId = "";
  var camelNumberController = TextEditingController();
  var hardWareNumberController = TextEditingController();
  var ageController = TextEditingController();
  var healthController = TextEditingController();
  var vaccinationController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      drawer: const Helper(),
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            w.regularEditText(camelNumberController, "shepherd name",
                icon: Icons.person),
            const SizedBox(height: 18),
            w.regularEditText(hardWareNumberController, "hardware number",
                icon: Icons.note),
            const SizedBox(height: 18),
            w.regularEditText(ageController, "age", icon: Icons.numbers),
            const SizedBox(height: 18),
            w.regularEditText(healthController, "health", icon: Icons.numbers),
            const SizedBox(height: 18),
            w.regularEditText(vaccinationController, "vaccine",
                icon: Icons.numbers),
            const SizedBox(height: 18),
            w.regularEditText(priceController, "price", icon: Icons.numbers),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                var id = Uuid().v1();
                var model = CamelModel(
                    id: id,
                    camelNumber: camelNumberController.text,
                    hardWareNumber: hardWareNumberController.text,
                    age: ageController.text,
                    health: healthController.text,
                    vaccination: vaccinationController.text,
                    price: priceController.text);
                FirebaseDatabase.instance
                    .ref()
                    .child("camel")
                    .child(ownerId)
                    .child(id)
                    .set(model.toJson())
                    .then((value) {
                  w.showAlertDialog(context, "Camel added successfully!", () {
                    Navigator.of(context).pop();
                  });
                }).onError((error, stackTrace) {
                  w.showAlertDialog(context, error.toString(), () {
                    Navigator.of(context).pop();
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(Cons.btnColor),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text(Cons.save),
            )
          ],
        ),
      ),
    );
  }
}
