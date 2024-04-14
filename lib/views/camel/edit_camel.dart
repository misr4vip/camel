import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/camelModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCamel extends StatefulWidget {
  EditCamel({required this.model, super.key});
  CamelModel model;
  @override
  State<EditCamel> createState() => _EditCamelState();
}

class _EditCamelState extends State<EditCamel> {
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
        camelNumberController.text = widget.model.camelNumber;
        hardWareNumberController.text = widget.model.hardWareNumber;
        ageController.text = widget.model.age.toString();
        healthController.text = widget.model.health.toString();
        vaccinationController.text = widget.model.vaccination;
        priceController.text = widget.model.price;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              w.addTitleTextView("Update Camel"),
              const SizedBox(height: 100),
              w.regularEditText(camelNumberController, "camel number",
                  icon: Icons.abc),
              const SizedBox(height: 18),
              w.regularEditText(hardWareNumberController, "hardware number",
                  icon: Icons.note),
              const SizedBox(height: 18),
              w.regularEditText(ageController, "age", icon: Icons.numbers),
              const SizedBox(height: 18),
              w.regularEditText(healthController, "health",
                  icon: Icons.numbers),
              const SizedBox(height: 18),
              w.regularEditText(vaccinationController, "vaccine",
                  icon: Icons.numbers),
              const SizedBox(height: 18),
              w.regularEditText(priceController, "price", icon: Icons.numbers),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  widget.model.camelNumber = camelNumberController.text;
                  widget.model.hardWareNumber = hardWareNumberController.text;
                  widget.model.age = ageController.text;
                  widget.model.health = healthController.text;
                  widget.model.vaccination = vaccinationController.text;
                  widget.model.price = priceController.text;
                  FirebaseDatabase.instance
                      .ref()
                      .child("camel")
                      .child(ownerId)
                      .child(widget.model.id)
                      .set(widget.model.toJson())
                      .then((value) {
                    w.showAlertDialog(context, "Camel Updated successfully!",
                        () {
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
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
