
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/WorldStatesModel.dart';
import '../services/states_servies.dart';
import 'countries_list.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Covid-19 Tracker",
          style: TextStyle(fontSize: 16),
        ),
        leading: null,
        backgroundColor: Colors.blue.shade200,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered!.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths!.toString())
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ResuableRow(
                                        title: "Total",
                                        value: snapshot.data!.cases.toString()),
                                    ResuableRow(
                                        title: "Deaths",
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ResuableRow(
                                        title: "Recovered",
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ResuableRow(
                                        title: "Active",
                                        value:
                                            snapshot.data!.active.toString()),
                                    ResuableRow(
                                        title: "Critical",
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ResuableRow(
                                        title: "Today Deaths",
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ResuableRow(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountriesListScreen()));
                              },
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text("Track Countries")),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  final String title, value;

  const ResuableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5)
          .copyWith(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
