import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Countries",
          style: TextStyle(fontSize: 16),
        ),
        leading: null,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 52,
              child: Center(
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: "Search with country...."),
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade100);
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (_searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              name: snapshot.data![index]['country'],
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              todayRecovered: snapshot.data![index]['recovered'],
                                              active:  snapshot.data![index]['active'],
                                              critical: snapshot.data![index]['critical'],
                                              test: snapshot.data![index]['tests'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          todayRecovered: snapshot.data![index]['recovered'],
                                          active:  snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          test: snapshot.data![index]['tests'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                        )));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
