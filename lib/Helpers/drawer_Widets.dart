import 'package:camel_trace/Combonet/Staylle.dart';
import 'package:flutter/material.dart';

class DrawerWidget {
  DrawerWidget({required this.context});
  final BuildContext context;

  Widget myDrawer(String imagePath) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: Stack(children: [
                Image.asset("images/bg.jpg"),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        imagePath,
                        height: 75.0,
                        width: 75.0,
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text(
                    "مراجع",
                    style: h2,
                  ),
                ))
              ]),
            ),
            //DrawerHeader
            ListTile(
              leading: Image.asset("images/element4.png"),
              title: Text(
                'لوحة التحكم',
                style: h2blue,
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ControlBoard()),
                // );
              },
            ),
            ListTile(
              leading: Image.asset(
                "images/iconamoon_profile-fill.png",
                height: 20,
                width: 20,
                color: darkblue,
              ),
              title: Text(
                'الملف الشخصي',
                style: h2bl,
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Image.asset(
                "images/hous.png",
              ),
              title: Text(
                " المواعيد المجدولة",
                style: h2bl,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Image.asset(
                "images/hous.png",
              ),
              title: Text(
                "منازل تحت المعاينة",
                style: h2bl,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Image.asset(
                "images/hous.png",
              ),
              title: Text(
                "منازل تمت المعاينة",
                style: h2bl,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            //     ListTile(
            //   leading: Image.asset("images/pa.png"),
            //   title: Text(
            //     "البطاقات",
            //     style: h2bl,
            //   ),
            //   onTap: () {

            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
