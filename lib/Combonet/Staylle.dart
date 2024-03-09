import 'package:flutter/material.dart';

Color lightblue = const Color.fromRGBO(102, 231, 237, 1);
Color darkblue = const Color.fromRGBO(3, 137, 237, 1);
Color black = const Color.fromARGB(255, 37, 38, 39);
Color gray = const Color(0xFF999999);
Color grren = const Color(0xFF2CDF00);
Color black26 = const Color(0xFF475F7B);
Image cheekblack = Image.asset("images/Sheek.png");
Image cheekbGreen = Image.asset("images/chekgreen.png");

var gradient = const LinearGradient(
  colors: [Color(0xFF0086EC), Color(0xFF6BECEC)],
);

TextStyle h1 = TextStyle(
  color: darkblue,
  fontSize: 18,
  fontFamily: 'Cairo-Regular',
  height: 0.07,
  fontWeight: FontWeight.w400,
);
TextStyle h2 = TextStyle(
  color: black,
  fontSize: 18,
  fontFamily: 'Cairo-Regular',
  height: 0.07,
  fontWeight: FontWeight.w400,
);
TextStyle h2blue = TextStyle(
  color: darkblue,
  fontSize: 13,
  fontFamily: 'Cairo-Regular',
  height: 0.07,
  fontWeight: FontWeight.w600,
);
TextStyle h2b = TextStyle(
  color: darkblue,
  fontSize: 13,
  fontFamily: 'Cairo-Regular',
  height: 0.07,
  fontWeight: FontWeight.w500,
);
TextStyle h2bl = TextStyle(
  color: black,
  fontSize: 12,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w500,
  height: 0.11,
);
TextStyle h2green = const TextStyle(
  color: Color(0xFF2CDF00),
  fontSize: 13,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  height: 0.13,
  letterSpacing: 0.46,
);
TextStyle h2black = const TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w700,
  height: 0.05,
);
TextStyle h3 = const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontFamily: './assets/fonts/Cairo-SemiBold.ttf',
  height: 0.07,
  fontWeight: FontWeight.w500,
);
TextStyle h4 = const TextStyle(
  color: Colors.white,
  fontSize: 8,
  fontFamily: './assets/fonts/Cairo-SemiBold.ttf',
  height: 0.07,
  fontWeight: FontWeight.w800,
);

//color: Color(0xFF0086EC),
TextStyle underline = TextStyle(
    color: black,
    fontSize: 18,
    fontFamily: 'Cairo-Regular',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline);
TextStyle underline2 = TextStyle(
    color: darkblue,
    fontSize: 14,
    fontFamily: 'Cairo-Regular',
    fontWeight: FontWeight.w800,
    decoration: TextDecoration.underline);

TextStyle h5 = TextStyle(
  color: gray,
  fontSize: 14,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w500,
  height: 0.08,
);
TextStyle h6 = TextStyle(
  color: black,
  fontSize: 14,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w700,
  height: 0.08,
);
TextStyle h6black = TextStyle(
  color: black26,
  fontSize: 14,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w400,
  height: 0.08,
);

AppBar myappBar = AppBar(
  leading: IconButton(
      icon: const Icon(Icons.notifications_active,
          color: Color.fromARGB(255, 230, 224, 224)),
      onPressed: () {}),
  title: Image.asset(
    'images/logo.png',
    fit: BoxFit.fill,
    width: 80,
    height: 80,
  ),
  centerTitle: true,
  backgroundColor: darkblue,
  elevation: 2,
);

Drawer mydrawer = Drawer(
    child: ListView(padding: const EdgeInsets.all(0), children: [
  Container(
      child: Stack(children: [
    Image.asset(
      "assets/images/profile.jpg",
      height: 200,
      fit: BoxFit.fill,
    ),
    Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(
              "https://example.com/image.png",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "الاسم",
            style: h3,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "مراجع",
            style: h4,
          ),
          const SizedBox(
            height: 18,
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text(' My Profile '),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text(' My Course '),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text(' Go Premium '),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text(' Saved Videos '),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text(' Edit Profile '),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset("assets/images/element4.png"),
            title: const Text('LogOut'),
            onTap: () {},
          ),
        ],
      ),
    ),
  ])),
]));
