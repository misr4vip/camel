import 'package:camel_trace/Combonet/Staylle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/shepherds/shepherd_list.dart';
class Helper extends StatefulWidget {
  const Helper({super.key});

  @override
  State<Helper> createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  String userName = "",userType = "",userPhone = "",userEmail = "";
  @override
  void initState() {

    SharedPreferences.getInstance().then((value) {
        setState(() {
          userName = value.getString("userName") ?? "Guest";
          userType = value.getString("userType") ?? "Guest";
          userPhone =value.getString("userPhone") ?? "05xxx xxx";
          userEmail =value.getString("userEmail") ?? "someThing@gmail.com";
        });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person,size: 48,color: Colors.white,),
                  Text(userName,style:const TextStyle(color: Colors.white,fontSize: 14)),
                  const SizedBox(height: 3,),
                  Text(userPhone,style:const TextStyle(color: Colors.white,fontSize: 14)),
                  const SizedBox(height: 3,),
                  Text(userEmail,style:const TextStyle(color: Colors.white,fontSize: 14)),
                ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.home,size: 32),
                  TextButton(onPressed: () {}, child:const Text("Main",style: TextStyle(fontSize: 18,color: Colors.blue)))
                ],
              ),
            ),
            const Divider(color: Colors.black12,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.people,size: 32),
                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShepherdList()));
                  }, child: const Text("Shepherds",style: TextStyle(fontSize: 18,color: Colors.blue)))
                ],
              ),
            ),const Divider(color: Colors.black12,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.apple,size: 32),
                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShepherdList()));
                  }, child: const Text("Camels",style: TextStyle(fontSize: 18,color: Colors.blue)))
                ],
              ),
            ),const Divider(color: Colors.black12,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.person,size: 32),
                  TextButton(onPressed: () {}, child: const Text("profile",style: TextStyle(fontSize: 18,color: Colors.blue)))
                ],
              ),
            ),const Divider(color: Colors.black12,),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.logout,size: 32),
                  TextButton(onPressed: () {}, child: const Text("log out",style: TextStyle(fontSize: 18,color: Colors.blue),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

