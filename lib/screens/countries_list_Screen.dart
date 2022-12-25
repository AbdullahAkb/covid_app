import 'package:country_picker/country_picker.dart';
import 'package:covid_app/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'country_detail_Screen.dart';

class CountriesListScreen extends StatefulWidget {
  // final String countryName;
  // final String name;
  CountriesListScreen({
    Key? key,
    // required this.name,
    // required this.countryName
  }) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  List<CountryModel> dataList = [];
  List<CountryModel> searchList = [];
  bool shimmerValue = true;
//serachController
  TextEditingController searchController = TextEditingController();
//Api Calling
  Future<List<CountryModel>> getDataofCountries() async {
    print("ali");
    Uri uri = Uri.parse("https://disease.sh/v3/covid-19/countries");
    print("ahmad");
    http.Response response = await http.get(uri);
    print(response.body);
    var decodedBody = jsonDecode(response.body) as List;
    for (var i = 0; i < decodedBody.length; i++) {
      CountryModel obj = CountryModel.fromJson(decodedBody[i]);
      dataList.add(obj);
    }
    await Future<void>.delayed(Duration(seconds: 2));
    shimmerValue = false;
    print(dataList);

    return dataList;
  }

//searchFunction
  Future<List<CountryModel>> search(String query) async {
    List<CountryModel> list = [];
    for (var i = 0; i < dataList.length; i++) {
      if (query == dataList[i].country) {
        CountryModel obj = dataList[i];
        searchList.add(obj);
        break;
      } else if (query == "") {
        searchList = dataList;
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 49, 49, 49),
          title: Text("All Countries"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                  child: TextFormField(
                    enableInteractiveSelection: true,
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search with country Name",
                      contentPadding: EdgeInsets.only(left: width * 0.06),
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      setState(() {
                        search(searchController.text);
                      });
                    },
                  ),
                ),
                FutureBuilder(
                  future: getDataofCountries(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return searchList.isEmpty
                          ? ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                CountryModel details = snapshot.data![index];
                                return shimmerValue == true
                                    ? SizedBox(
                                        height: 100,
                                        width: width,
                                        child: Shimmer.fromColors(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: height * 0.3,
                                                  width: width * 0.7,
                                                )
                                              ],
                                            ),
                                            baseColor:
                                                Color.fromARGB(255, 95, 95, 95),
                                            highlightColor: Color.fromARGB(
                                                255, 219, 219, 219)),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return CountryDetailScreen(
                                                details: details,
                                              );
                                            },
                                          ));
                                        },
                                        child: ListTile(
                                          leading: Container(
                                            height: height * 0.03,
                                            width: width * 0.1,
                                            child: Image.network(
                                              details.countryInfo.flag,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  snapshot.data![index].country
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: height * 0.01),
                                                child: Text(
                                                  snapshot.data![index].cases
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            )
                          : ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                CountryModel details = searchList[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CountryDetailScreen(
                                          details: details,
                                        );
                                      },
                                    ));
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: height * 0.03,
                                      width: width * 0.1,
                                      child: Image.network(
                                        details.countryInfo.flag,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            details.country.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: Text(
                                            details.cases.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
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
                )
              ],
            ),
          ),
        ));
  }
}
