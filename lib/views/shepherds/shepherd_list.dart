import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/views/shepherds/add_shepherd.dart';
import 'package:flutter/material.dart';

class ShepherdList extends StatelessWidget {
  const ShepherdList({super.key});
     
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const Helper(),
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddShepherd()));
        },
      ),
      body: Container(
        child: Text("Shepherd List"),
      ),
    );
  }
}
