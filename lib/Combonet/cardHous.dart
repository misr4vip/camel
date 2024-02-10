import 'package:flutter/material.dart';
import 'package:camel_trace/Combonet/Staylle.dart';

class CardH_Combonet extends StatelessWidget {
  CardH_Combonet(
      {super.key,
      required this.name,
      required this.numberOfConsumers,
      required this.condition,
      required this.district,
      required this.period,
      required this.tankSize});
  String name;
  String district;
  String numberOfConsumers;
  String period;
  String condition;
  String tankSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
              height: 250,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: darkblue)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          style: h2black,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          "images/Sheek.png",
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              condition,
                              style: h6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              " : الحي",
                              style: h5,
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              numberOfConsumers,
                              style: h6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              " : حجم الخزان ",
                              style: h5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              period,
                              style: h6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              " : الحصة",
                              style: h5,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              numberOfConsumers,
                              style: h6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              " : عدد المستهلكين ",
                              style: h5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "تحديد تاريخ القدوم",
                              style: h2blue,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "images/Vector.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          condition,
                          style: h2green,
                        ),
                        Text(
                          "حالة المنزل",
                          style: h2b,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 46,
                      width: 360,
                      color: darkblue,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "اضغط هنا للمراجعة",
                          style: h3,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
