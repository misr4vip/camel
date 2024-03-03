import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:flutter/material.dart';

class ShepherdList extends StatelessWidget {
  const ShepherdList({super.key});
     
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const Helper(),
      appBar: AppBar(),
      body: Container(
        child: Text("Shepherd List"),
      ),
    );
  }
}
