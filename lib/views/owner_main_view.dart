import 'package:camel_trace/Combonet/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/drawer_Widets.dart';

class OwnerMain extends StatefulWidget {
  const OwnerMain({super.key});

  @override
  State<OwnerMain> createState() => _OwnerMainState();
}

class _OwnerMainState extends State<OwnerMain> {
  String userName = "", userType = "", userPhone = "", userEmail = "";
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userName = value.getString("userName") ?? "Guest";
        userType = value.getString("userType") ?? "Guest";
        userPhone = value.getString("userPhone") ?? "05xxx xxx";
        userEmail = value.getString("userEmail") ?? "someThing@gmail.com";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var helper = Helper();
    var w = MyWidgets(context: context);
    return Scaffold(
      appBar: AppBar(),
      drawer: const Helper(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "welcome back, $userName ",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            w.addLogoImage("images/camel2.png"),
          ],
        ),
      ),
    );
  }
}
