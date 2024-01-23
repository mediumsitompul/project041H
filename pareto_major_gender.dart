import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_model_pareto4.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;


class ParetoMajorGender extends StatelessWidget {
  final String major1a;


  const ParetoMajorGender({super.key, required this.major1a});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: Center(child: Text("CRUD OPERATION")),),
          body: MyWidget(major1a_: major1a),
          ),
        
    );
  }
}


class MyWidget extends StatefulWidget {
  final String major1a_;

  const MyWidget({super.key, required this.major1a_});
  

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  var sum1;
  List<DataModel4> dataList = [];
  bool loading = true;

@override
  void initState() {
    getData();
    _queryCount();
    // TODO: implement initState
    super.initState();
  }

  //............................................
  void getData() async {
    final url1a = Uri.parse(
        'https://mediumsitompul.com/crud_restapi/pareto_major_gender.php?auth=kjgdkhdfldfguttedfgr');
    var response = await http.post(url1a, body: {
      "search2": widget.major1a_.toString(),
    });

    List data = jsonDecode(response.body);
    print(data);

    setState(() {
      dataList = data1ModelFromJson(data);
      loading = false;
    });
  }
  //............................................
  //===========================================================================================
  Future<void> _queryCount() async {
    final url1 = Uri.parse(
        "https://mediumsitompul.com/crud_restapi/query_totalrecord_selected.php?auth=kjgdkhdfldfguttedfgr");
    var response = await http.post(url1, body: {
      "search2a": widget.major1a_.toString(),
    });
    var datauser = jsonDecode(response.body);

    if (datauser.isEmpty) {
      setState(() {
        sum1 = "0";
      });
    } else {
      setState(() {
        sum1 = datauser[0]['jumlah'];
      });
    }
  }

  //===========================================================================================
  //===========================================================================================

  //setting chart
  List<charts.Series<DataModel4, String>> _createSampleData() {
    return [
      charts.Series<DataModel4, String>(
          domainFn: (DataModel4 _DataModel, _) => _DataModel.gender1,
          measureFn: (DataModel4 _DataModel, _) => _DataModel.count1,
          id: 'name',
          data: dataList,
          labelAccessorFn: (DataModel4 _DataModel, _) =>
              '\#  ${_DataModel.count1.toString()}')
    ];
  }

  //===========================================================================================



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 600,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                //Text(widget.major1a_),
                const Text(
                  "NUMBER OF STUDENTS, MAJOR",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey),
                ),
                Center(
                    child: Text(
                  widget.major1a_, //++++++
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red),
                )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Sub total = " + sum1.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),

                Expanded(
                  child: charts.BarChart(
                    barRendererDecorator: charts.BarLabelDecorator<String>(),
                    domainAxis: const charts.OrdinalAxisSpec(),
                    vertical: true, //For Chart Horizontal
                    _createSampleData(),
                    animate: false,
                  ),),


              ],
            ),
          )
        ],
      ),
      //................... floatingActionButton >>> IN SCAFFOLD() ................
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          print('Tombol Reffresh di pencettt');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyApp(),
              ));
        }),
        tooltip: 'Reload data',
        child: Icon(Icons.ac_unit),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      //...........................................................................

    );
  }
}
