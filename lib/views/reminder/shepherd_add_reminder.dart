import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/camelModel.dart';
import 'package:camel_trace/views/reminder/shepherd_add_reminder_s2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShepherdAddReminder extends StatefulWidget {
  const ShepherdAddReminder({super.key});
  @override
  State<ShepherdAddReminder> createState() => _ShepherdAddReminderState();
}

class _ShepherdAddReminderState extends State<ShepherdAddReminder> {
  var shepherdId = "";
  var isSelected = false;
  List<CamelModel> models = [];
  Map<String, CamelsChecked> checkedGamels = {};
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        shepherdId = value.getString("userId") ?? "";
      });
      getCamelsdata().then((value) {
        setState(() {
          models = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      drawer: const Helper(),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: models.isNotEmpty
            ? Column(
                children: [
                  w.addTitleTextView("Select Camels to add reminder"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: models.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Checkbox(
                              onChanged: (value) {
                                var id = models[index].id;
                                setState(() {
                                  isSelected = value!;
                                });

                                if (value!) {
                                  checkedGamels[id] =
                                      CamelsChecked(id: id, checked: value);
                                } else {
                                  if (checkedGamels.containsKey(id)) {
                                    checkedGamels.remove(id);
                                  }
                                }
                              },
                              value: isSelected,
                            ),
                            title: Text(models[index].camelNumber),
                          );
                        }),
                  ),
                  w.addButton("Next", () {
                    if (checkedGamels.isEmpty) {
                      w.showAlertDialog(context,
                          "Please select at least one camel to add reminders",
                          () {
                        Navigator.of(context).pop();
                      });
                      return;
                    }
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ShepherdAddReminders2(
                          checkedGamels: checkedGamels);
                    }));
                  })
                ],
              )
            : const Text("No data avilable or error in getting data"),
      ),
    );
  }

  Future<List<CamelModel>> getCamelsdata() async {
    List<CamelModel> camels = [];
    await FirebaseDatabase.instance.ref().child("camel").get().then((value) {
      for (var element in value.children) {
        for (var x in element.children) {
          var value = x.value as Map;
          var model = CamelModel.fromJson(value);
          if (model.shepherdId == shepherdId) {
            camels.add(model);
          }
        }
      }
    });
    return camels;
  }
}

class CamelsChecked {
  String? id;
  bool? checked;
  CamelsChecked({this.id, this.checked});
}
