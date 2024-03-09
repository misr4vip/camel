import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/shepherdModel.dart';
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
  List<ShepherdModel> models = [];

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
      appBar: AppBar(),
      drawer: const Helper(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddShepherd()));
        },
      ),
      body: Container(
        child: models.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: const Text("no shephered data to represent"),
              )
            : ListView.builder(
                itemCount: models.length,
                itemBuilder: (context, index) {
                  return Container(
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
                          Text("camels count :${models[index].camelCounts}"),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          w.showAlertDialogOkCancel(
                              context, "are you sure to delete ?", () {
                            FirebaseDatabase.instance
                                .ref()
                                .child("shepherd")
                                .child(ownerId)
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
                          size: 28,
                        ),
                      ),
                      isThreeLine: true,
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 177, 127, 162),
                            width: 2),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditShepherd(
                                  model: models.elementAt(index),
                                )));
                      },
                    ),
                  );
                }),
      ),
    );
  }

  getShepherdsData() {
    List<ShepherdModel> shepherds = [];
    FirebaseDatabase.instance
        .ref()
        .child("shepherd")
        .child(ownerId)
        .get()
        .then((value) {
      if (value.exists) {
        shepherds.clear();
        for (var element in value.children) {
          for (var item in element.children) {
            print(item.value);
            shepherds.add(ShepherdModel.fromJson(item.value as Map));
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
    List<ShepherdModel> shepherds = [];
    FirebaseDatabase.instance
        .ref()
        .child("shepherd")
        .child(ownerId)
        .onValue
        .listen((event) {
      shepherds.clear();
      for (var element in event.snapshot.children) {
        for (var item in element.children) {
          print(item.value);
          shepherds.add(ShepherdModel.fromJson(item.value as Map));
        }
      }
      setState(() {
        models.clear();
        models = shepherds;
      });
    });
  }
}
