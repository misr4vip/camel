import 'package:camel_trace/Combonet/mywedjet.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../Helpers/const.dart';
import '../../Helpers/drawer_Widets.dart';

class AddShepherd extends StatefulWidget {
  const AddShepherd({super.key});

  @override
  State<AddShepherd> createState() => _AddShepherdState();
}

class _AddShepherdState extends State<AddShepherd> {
  var ownerId = "";
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var numberOfCamelsController = TextEditingController();
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
      drawer:const Helper(),
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            w.regularEditText(nameController, "shepherd name",icon: Icons.person),
            const SizedBox(height: 18),
            w.regularEditText(idController, "shepherd Identity number",icon: Icons.note),
            const SizedBox(height: 18),
            w.regularEditText(numberOfCamelsController , "number of camels",icon: Icons.numbers),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: (){
                var shepherdId = Uuid().v1();
                FirebaseDatabase.instance.ref().child("shepherd").child(ownerId).child(shepherdId).set({
                  "id":shepherdId,
                  "name": nameController.text,
                  "identityId": idController.text,
                  "camelCounts": numberOfCamelsController.text,
                }).then((value) {

                  w.showAlertDialog(context, "shepherd added successfully!", () {

                    Navigator.of(context).pop();
                  });
                }).onError((error, stackTrace){
                  w.showAlertDialog(context, error.toString(), () {
                    Navigator.of(context).pop();
                  });
                });
              },
              style:ElevatedButton.styleFrom(
                backgroundColor: Color(Cons.btnColor),
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ) ,
              child: Text(Cons.save),)

          ],
        ),
      ),

    );
  }
}
