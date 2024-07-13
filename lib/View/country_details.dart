import 'package:covid_tracker/constructor/firstRow.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String image;
  String name;
  int todayCases,
      todayDeaths,
      Recovered,
      todayRecovered,
      active,
      critical,
      test,
      population;
  CountryDetails(
      {required this.image,
      required this.name,
      required this.todayCases,
      required this.todayDeaths,
      required this.Recovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.test,
      required this.population});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReuseableRow(
                          title: 'Covid Cases',
                          value: widget.todayCases.toString()),
                      ReuseableRow(
                          title: 'Covid Death',
                          value: widget.todayDeaths.toString()),
                      ReuseableRow(
                          title: 'Total Recovered',
                          value: widget.Recovered.toString()),
                      ReuseableRow(
                          title: 'Active Cases',
                          value: widget.active.toString()),
                      ReuseableRow(
                          title: 'Crirical Cases',
                          value: widget.critical.toString()),
                      ReuseableRow(
                          title: 'Covid Test', value: widget.test.toString()),
                      ReuseableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      ReuseableRow(
                          title: 'Population',
                          value: widget.population.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
