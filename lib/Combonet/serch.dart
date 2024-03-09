import 'package:flutter/material.dart';
import 'package:camel_trace/Combonet/Staylle.dart';

class serching extends StatelessWidget {
  const serching({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 111,
          height: 31,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 2,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "images/Group.png",
                    color: darkblue,
                    fit: BoxFit.fill,
                  )),
              InkWell(
                  onTap: () {
                    //
                  },
                  child: Image.asset("images/pdf.png", fit: BoxFit.fill)),
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "images/Icon Left.png",
                    fit: BoxFit.fill,
                  )),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 256,
          height: 31,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 2,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "ابحث",
                  style: h5,
                ),
                const Icon(Icons.search)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
