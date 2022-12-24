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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text(widget.details.country),
      ),
      body: Container(),
    );
  }
}
