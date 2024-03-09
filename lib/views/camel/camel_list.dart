import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/camelModel.dart';
import 'package:camel_trace/views/camel/add_camel.dart';
import 'package:camel_trace/views/camel/edit_camel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CamelList extends StatefulWidget {
  const CamelList({super.key});
  @override
  State<CamelList> createState() => _CamelListState();
}

class _CamelListState extends State<CamelList> {
  var ownerId = "";
  var models = <CamelModel>[];
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    models.clear();
    getCamelsData();
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddCamel()));
        },
      ),
      body: Container(
        child: models.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: const Text("no camel data to represent"),
              )
            : ListView.builder(
                itemCount: models.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(2, 2, 2, 3),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(models[index].hardWareNumber),
                      ),
                      title: Text(models[index].camelNumber),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(models[index].age),
                          Text(models[index].price),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          w.showAlertDialogOkCancel(
                              context, "are you sure to delete ?", () {
                            FirebaseDatabase.instance
                                .ref()
                                .child("camel")
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
                            builder: (context) => EditCamel(
                                  model: models.elementAt(index),
                                )));
                      },
                    ),
                  );
                }),
      ),
    );
  }

  getCamelsData() {
    var camelArray = [CamelModel.empty()];
    FirebaseDatabase.instance
        .ref()
        .child("camel")
        .child(ownerId)
        .get()
        .then((value) {
      if (value.exists) {
        camelArray.clear();
        for (var element in value.children) {
          for (var item in element.children) {
            print(item.value);
            camelArray.add(CamelModel.fromJson(item.value as Map));
          }
        }
      }
      setState(() {
        models.clear();
        models = camelArray;
      });
    }).onError((error, stackTrace) {
      print("error in geting shepherd List ${error.toString()}");
    });
  }
}
