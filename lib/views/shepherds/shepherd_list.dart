import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/UserModel.dart';
import 'package:camel_trace/views/shepherds/add_shepherd.dart';
import 'package:camel_trace/views/shepherds/edit_shepherd.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShepherdList extends StatefulWidget {
  const ShepherdList({super.key});

  @override
  State<ShepherdList> createState() => _ShepherdListState();
}

class _ShepherdListState extends State<ShepherdList> {
  var ownerId = "";
  List<UserModel> models = [];

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    getShepherdsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gray2Color,
      ),
      drawer: const Helper(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightOrangeColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddShepherd()));
        },
      ),
      body: Container(
        color: gray2Color,
        child: models.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: const Text("No shephered data to represent"),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: models.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        margin: const EdgeInsets.fromLTRB(2, 2, 2, 3),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(models[index].name.substring(0, 1)),
                          ),
                          title: Text(models[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(models[index].identityId),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditShepherd(
                                                    model:
                                                        models.elementAt(index),
                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      w.showAlertDialogOkCancel(
                                          context, "are you sure to delete ?",
                                          () {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("users")
                                            .child(models[index].id)
                                            .remove()
                                            .then((value) {
                                          setState(() {
                                            models.removeAt(index);
                                          });
                                        });
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //ToDo  collect camel counts from firebase
                          trailing: const Text(
                            "camels\n    ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          isThreeLine: true,
                          shape: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 177, 127, 162),
                                width: 2),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }

  getShepherdsData() {
    List<UserModel> shepherds = [];
    FirebaseDatabase.instance.ref().child("users").get().then((value) {
      if (value.exists) {
        shepherds.clear();
        for (var element in value.children) {
          var model = UserModel.fromJson(element.value as Map);
          if (model.ownerId == ownerId) {
            shepherds.add(model);
          }
        }
      }
      setState(() {
        models.clear();
        models = shepherds;
      });
    }).onError((error, stackTrace) {
      print("error in geting shepherd List ${error.toString()}");
    });
  }

  updateShepherdsData() {
    List<UserModel> shepherds = [];
    FirebaseDatabase.instance.ref().child("users").onValue.listen((event) {
      shepherds.clear();
      for (var element in event.snapshot.children) {
        for (var item in element.children) {
          var model = UserModel.fromJson(item.value as Map);
          if (model.ownerId == ownerId) {
            shepherds.add(model);
          }
        }
      }
      setState(() {
        models.clear();
        models = shepherds;
      });
    });
  }
}
