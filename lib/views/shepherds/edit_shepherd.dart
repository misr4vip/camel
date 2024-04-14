import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/shepherdModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditShepherd extends StatefulWidget {
  EditShepherd({required this.model, super.key});
  ShepherdModel model;
  @override
  State<EditShepherd> createState() => _EditShepherdState();
}

class _EditShepherdState extends State<EditShepherd> {
  var ownerId = "";
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var numberOfCamelsController = TextEditingController();
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
        nameController.text = widget.model.name;
        idController.text = widget.model.identityId;
        numberOfCamelsController.text = widget.model.camelCounts;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      appBar: AppBar(),
      drawer: const Helper(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            w.addTitleTextView("Update Shpeherd"),
            const SizedBox(height: 100),
            w.regularEditText(nameController, "shepherd name",
                icon: Icons.person),
            const SizedBox(height: 18),
            w.regularEditText(idController, "shepherd Identity number",
                icon: Icons.note),
            const SizedBox(height: 18),
            w.regularEditText(numberOfCamelsController, "number of camels",
                icon: Icons.numbers),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                widget.model.camelCounts = numberOfCamelsController.text;
                widget.model.identityId = idController.text;
                widget.model.name = nameController.text;
                FirebaseDatabase.instance
                    .ref()
                    .child("shepherd")
                    .child(ownerId)
                    .child(widget.model.id)
                    .set(widget.model.toJson())
                    .then((value) {
                  w.showAlertDialog(context, "shepherd Updated successfully!",
                      () {
                    Navigator.of(context).pop();
                    nameController.text = "";
                    idController.text = "";
                    numberOfCamelsController.text = "";
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
              child: Text(Cons.update),
            )
          ],
        ),
      ),
    );
  }
}
