import 'package:flutter/material.dart';

class CustomTrackButton extends StatefulWidget {
  final VoidCallback action;
  CustomTrackButton({Key? key, required this.action}) : super(key: key);

  @override
  State<CustomTrackButton> createState() => _CustomTrackButtonState();
}

class _CustomTrackButtonState extends State<CustomTrackButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: widget.action,
      child: Container(
        // margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
        alignment: Alignment.center,
        height: height * 0.055,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 16, 162, 91),
        ),
        child: Text(
          "Track Countries",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
