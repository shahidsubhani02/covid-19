import 'dart:math';

import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:covid_tracker/constructor/firstRow.dart';
import 'package:covid_tracker/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //for colors in pie chart
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorldStateRecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                          size: 50,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recover": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration:
                                const Duration(milliseconds: 1500),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius: deviceWidth / 2.5,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.04),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseableRow(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReuseableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReuseableRow(
                                      title: 'Covid Death',
                                      value: snapshot.data!.deaths.toString()),
                                  ReuseableRow(
                                      title: 'Active Cases',
                                      value: snapshot.data!.active.toString()),
                                  ReuseableRow(
                                      title: 'Covid Affected Countries',
                                      value: snapshot.data!.affectedCountries
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountriesList(),
                                ),
                              );
                            },
                            child: Container(
                              height: deviceHeight * 0.07,
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa268),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              //   PieChart(
              //     dataMap: const {
              //       "total": 20,
              //       "Recover": 15,
              //       "death": 5,
              //     },
              //     animationDuration: const Duration(milliseconds: 1200),
              //     chartType: ChartType.ring,
              //     colorList: colorList,
              //     chartRadius: deviceWidth / 2.5,
              //     legendOptions:
              //         const LegendOptions(legendPosition: LegendPosition.left),
              //   ),
              //   Padding(
              //     padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.04),
              //     child: Card(
              //       child: Column(
              //         children: [
              //           ReuseableRow(title: 'Total', value: '20'),
              //           ReuseableRow(title: 'Recover', value: '15'),
              //           ReuseableRow(title: 'Death', value: '5'),
              //         ],
              //       ),
              //     ),
              //   ),
              //   InkWell(
              //     onTap: null,
              //     child: Container(
              //       height: deviceHeight * 0.07,
              //       child: const Center(
              //         child: Text(
              //           'Track Countries',
              //           style: TextStyle(
              //             fontSize: 14,
              //           ),
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //         color: const Color(0xff1aa268),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
