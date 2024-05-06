import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/modles/camelModel.dart';
import 'package:camel_trace/views/camel/camel_list.dart';
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
  String shepherdDropDownText = 'select shepherd';
  String shepherdDropDownValue = "-1";
  var camelNumberController = TextEditingController();
  var hardWareNumberController = TextEditingController();
  var ageController = TextEditingController();
  var healthController = TextEditingController();
  var vaccinationController = TextEditingController();
  var priceController = TextEditingController();
  var nathionalityController = TextEditingController();
  List<UserModel> shepherdsArray = [];
  @override
  void initState() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    await getShepherds().then((value) {
      shepherdsArray.clear();
      setState(() {
        shepherdsArray = value;
      });
    });
    super.initState();
  }

  Future<List<UserModel>> getShepherds() async {
    List<UserModel> arr = [];
    FirebaseDatabase.instance.ref().child("users").get().then((value) {
      for (var element in value.children) {
        var val = element.value as Map;
        var user = UserModel.fromJson(val);
        if (user.ownerId == ownerId) {
          arr.add(user);
        }
      }
    });

    return arr;
  }

  List<DropdownMenuEntry<dynamic>> nathionlityItemList() {
    var listItems = <DropdownMenuEntry<dynamic>>[];
    for (var i in shepherdsArray) {
      listItems.add(DropdownMenuEntry(
        label: i.name.toString(),
        value: i.id,
      ));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: DropdownMenu(
                  width: MediaQuery.of(context).size.width - 50,
                  controller: nathionalityController,
                  enableFilter: false,
                  label: Text(shepherdDropDownText),
                  onSelected: (newValue) {
                    if (newValue == null) {
                      shepherdDropDownText = "Shepherd";
                    } else {
                      shepherdDropDownValue = newValue;
                      for (var element in shepherdsArray) {
                        if (element.id == shepherdDropDownValue) {
                          shepherdDropDownText = element.name;
                        }
                      }
                    }
                  },
                  dropdownMenuEntries: nathionlityItemList(),
                ),
              ),
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
                  var id = Uuid().v1();
                  var model = CamelModel(
                      id: id,
                      camelNumber: camelNumberController.text,
                      hardWareNumber: hardWareNumberController.text,
                      age: ageController.text,
                      health: healthController.text,
                      vaccination: vaccinationController.text,
                      price: priceController.text,
                      shepherdId: shepherdDropDownValue,
                      shepherdName: shepherdDropDownText);
                  FirebaseDatabase.instance
                      .ref()
                      .child("camel")
                      .child(ownerId)
                      .child(id)
                      .set(model.toJson())
                      .then((value) {
                    w.showAlertDialog(context, "Camel added successfully!", () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CamelList()));
                    });
                  }).onError((error, stackTrace) {
                    w.showAlertDialog(context, error.toString(), () {
                      Navigator.of(context).pop();
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightOrangeColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text(Cons.save),
              )
            ],
          ),
        ),
      ),
    );
  }
}
