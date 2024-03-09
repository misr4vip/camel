import 'package:flutter/material.dart';
import '../Helpers/drawer_Widets.dart';

class OwnerMain extends StatefulWidget {
  const OwnerMain({super.key});

  @override
  State<OwnerMain> createState() => _OwnerMainState();
}

class _OwnerMainState extends State<OwnerMain> {
  @override
  Widget build(BuildContext context) {
 // var helper = Helper();
    return Scaffold(
      appBar: AppBar(),
      drawer:const Helper(),
      body: Container(
        child: const  Text("owner"),
      ),
    );
  }
}
