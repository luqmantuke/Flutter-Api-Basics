import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listResponse;
  Map mapResponse;
  String stringResponse;
  List numberOfFacts;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=2'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        numberOfFacts = mapResponse['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Fetching Data',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
          ),
          body: mapResponse == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        mapResponse['category'].toString(),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Column(children: [
                              Image.network(numberOfFacts[index]['image_url']),
                              Text(
                                numberOfFacts[index]['title'].toString(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                                 Text(
                        numberOfFacts[index]['description'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                       
                        ),
                      ),
                            ]),
                          );
                        },
                        itemCount:
                            numberOfFacts == null ? 0 : numberOfFacts.length,
                      )
                    ],
                  ),
                )),
    );
  }
}
