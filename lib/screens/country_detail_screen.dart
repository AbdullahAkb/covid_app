import 'package:covid_app/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  final CountryModel details;
  CountryDetailScreen({Key? key, required this.details}) : super(key: key);

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String image = widget.details.countryInfo.flag;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 49, 49, 49),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text(widget.details.country),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Container(
              // margin: EdgeInsets.only(top: height * 0.07),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.4,
                    margin: EdgeInsets.only(
                      left: width * 0.05,
                      top: height * 0.07,
                      right: width * 0.05,
                    ),
                    padding: EdgeInsets.all(height * 0.02),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 65, 65, 65),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cases",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.details.cases.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          height: height * 0.04,
                          thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recovered",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.details.recovered.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          height: height * 0.04,
                          thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Deaths",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.details.deaths.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          height: height * 0.04,
                          thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Active",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.details.active.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          height: height * 0.04,
                          thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Critical",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.details.critical.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          height: height * 0.04,
                          thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today Recovered",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.details.todayRecovered.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        // margin: EdgeInsets.only(left: width*0.0),
                        alignment: Alignment.center,

                        child: Image.network(
                          widget.details.countryInfo.flag,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Flexible(
              child: Container(),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
