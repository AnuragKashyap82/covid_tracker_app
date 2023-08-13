import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen(
      {required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 16),
        ),
        leading: null,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ResuableRow(
                          title: "Cases",
                          value: widget.totalCases.toString(),),
                      ResuableRow(
                        title: "Active",
                        value: widget.active.toString(),),
                      ResuableRow(
                        title: "Recovered",
                        value: widget.totalRecovered.toString(),),
                      ResuableRow(
                        title: "Deaths",
                        value: widget.totalDeaths.toString(),),
                      ResuableRow(
                        title: "Critical",
                        value: widget.critical.toString(),),
                      ResuableRow(
                        title: "Today Recovered",
                        value: widget.totalRecovered.toString(),),
                      ResuableRow(
                        title: "Today Deaths",
                        value: widget.totalDeaths.toString(),),
                      ResuableRow(
                        title: "Tests",
                        value: widget.test.toString(),),

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
