import 'package:covid_app/models/country_model.dart';
import 'package:covid_app/models/world_model.dart';
import 'package:covid_app/screens/countries_list_Screen.dart';
import 'package:covid_app/widgets/custom_track_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String country_name = " ";
  List<CountryModel> dataList = [];
  Future<WorldModel> getData() async {
    print("agsukahs");
    Uri uri = Uri.parse("https://disease.sh/v3/covid-19/all");
    print("abdullah");
    http.Response response = await http.get(uri);
    print(response.body);
    var decodedBody = jsonDecode(response.body);
    WorldModel data = WorldModel.fromJson(decodedBody);
    // getDataofCountries();
    return data;
  }

  // List<CountryModel> dataList = [];
  // var dataOfCountry;
  // Future<List<CountryModel>> getDataofCountries() async {
  //   print("ali");
  //   Uri uri = Uri.parse("https://disease.sh/v3/covid-19/countries");
  //   print("ahmad");
  //   http.Response response = await http.get(uri);
  //   print(response.body);
  //   var decodedBody = jsonDecode(response.body) as List;
  //   for (var i = 0; i < decodedBody.length; i++) {
  //     CountryModel obj = CountryModel.fromJson(decodedBody[i]);
  //     dataList.add(obj);
  //   }
  //   print("dataList of Countries: ${dataList}");
  //   return dataList;
  // }

  // void changed() async {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) {
  //       return CountryDetailScreen(countryName: country_name);
  //     },
  //   ));
  // }

  List<Color> colors = [Colors.blue, Colors.green, Colors.red];

  // void initState() {
  //   super.initState();
  //   getDataofCountries();
  //   // dataOfSingleCountry(dataList);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 49, 49, 49),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
            child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  PieChart(
                    colorList: colors,
                    chartType: ChartType.ring,
                    chartRadius: width * 0.25,
                    ringStrokeWidth: 13,
                    chartLegendSpacing: 50,
                    legendOptions: LegendOptions(
                        legendTextStyle: TextStyle(color: Colors.white),
                        showLegends: true,
                        legendPosition: LegendPosition.left,
                        legendShape: BoxShape.circle),
                    chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true, decimalPlaces: 0),
                    dataMap: <String, double>{
                      "Total": double.parse(snapshot.data!.cases.toString()),
                      "Recovered":
                          double.parse(snapshot.data!.recovered.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths.toString())
                    },
                    animationDuration: const Duration(milliseconds: 800),
                    initialAngleInDegree: 0,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    padding: EdgeInsets.all(height * 0.02),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 65, 65, 65),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data!.cases.toString(),
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
                              snapshot.data!.recovered.toString(),
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
                              snapshot.data!.deaths.toString(),
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
                              snapshot.data!.active.toString(),
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
                              snapshot.data!.critical.toString(),
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
                              "Today Deaths",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              snapshot.data!.todayDeaths.toString(),
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
                              snapshot.data!.todayRecovered.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: width,
                    margin: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    child: Column(
                      children: [
                        CustomTrackButton(
                          action: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CountriesListScreen();
                              },
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              SizedBox(
                height: 100,
                width: width,
                child: Shimmer.fromColors(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.7,
                        )
                      ],
                    ),
                    baseColor: Color.fromARGB(255, 95, 95, 95),
                    highlightColor: Color.fromARGB(255, 219, 219, 219)),
              );
            }
            return Container();
          },
        )),
      ),
    );
  }
}
