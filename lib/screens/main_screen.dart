import 'package:covid_app/models/world_model.dart';
import 'package:covid_app/widgets/custom_track_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';

class MainScreen extends StatefulWidget {
  // final WorldModel data;
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<WorldModel> getData() async {
    print("agsukahs");
    Uri uri = Uri.parse("https://disease.sh/v3/covid-19/all");
    print("abdullah");
    http.Response response = await http.get(uri);
    print(response.body);
    var decodedBody = jsonDecode(response.body);
    WorldModel data = WorldModel.fromJson(decodedBody);

    return data;
  }

  List<Color> colors = [Colors.blue, Colors.green, Colors.red];

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
                // mainAxisAlignment: MainAxisAlignment.center,
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
                        // SizedBox(
                        //   height: 20,
                        // ),
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
                  SizedBox(
                    height: height * 0.1,
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
                            showCountryPicker(
                              context: context,
                              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                              exclude: <String>['KN', 'MF'],
                              favorite: <String>['SE'],
                              //Optional. Shows phone code before the country name.
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                print('Select country: ${country.displayName}');
                              },
                              // Optional. Sets the theme for the country list picker.
                              countryListTheme: CountryListThemeData(
                                textStyle: TextStyle(color: Colors.white),
                                backgroundColor:
                                    Color.fromARGB(255, 49, 49, 49),
                                // Optional. Sets the border radius for the bottomsheet.
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                                // Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: width * 0.05),
                                  // labelText: 'Search with country name',
                                  hintText: 'Search with country name',
                                  // prefixIcon: const Icon(Icons.search),
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: TextStyle(
                                  color: Colors.white,
                                  // fontSize: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              Center(
                child: CupertinoActivityIndicator(color: Colors.grey),
              );
            }
            return Container();
          },
        )),
      ),
    );
  }
}
