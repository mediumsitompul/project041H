import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'data_model_pareto3.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'main.dart';
import 'table_result_pareto_clickable.dart';

class Major extends StatelessWidget {
  const Major({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('CRUD OPERATION\n (READ ALL DATA)')),
        ),
        body: MyProject(),
      ),
    );
  }
}

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  //Timer? _timer;
  var sum1;

  List<DataModel3> dataList = [];
  bool loading = true;

  @override
  void initState() {
    getData();
    _queryCount();
    //_timer = Timer.periodic(const Duration(seconds: 5), (timer) => getData());
    super.initState();
  }

  //============================================== OKE =========================================
  // FUNCTION

  void getData() async {
    var response = await http.get(Uri.parse(
        "https://mediumsitompul.com/crud_restapi/pareto_major.php?auth=kjgdkhdfldfguttedfgr"));
    List data = json.decode(response.body);
    print(data);

    setState(() {
      dataList = data1ModelFromJson(data);
      print(dataList);
      loading = false;
    });
  }

  //===========================================================================================
  Future<void> _queryCount() async {
    final url1 = Uri.parse(
        "https://mediumsitompul.com/crud_restapi/query_totalrecord.php?auth=kjgdkhdfldfguttedfgr");
    var response = await http.post(url1, body: {});
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

  List<charts.Series<DataModel3, String>> _createSampleData() {
    return [
      charts.Series<DataModel3, String>(
          domainFn: (DataModel3 _DataModel, _) => _DataModel.major1,
          measureFn: (DataModel3 _DataModel, _) => _DataModel.count1,
          id: 'name',
          data: dataList,
          labelAccessorFn: (DataModel3 _DataModel, _) =>
              '\#  ${_DataModel.count1.toString()}')
    ];
  }

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FUNCTION CLICK BAR.CHART xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      setState(() {
        print(selectedDatum.first.datum.major1);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TableResultParetoClickable(
                  major1a: selectedDatum.first.datum.major1),
            ));
      });
    }
  }
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

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
                const Text(
                  "NUMBER OF STUDENTS PER MAJOR",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey),
                ),

                const SizedBox(
                  height: 20,
                ),

                Center(
                  child: Text(
                    "Grand Total = " + sum1.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                //Center(),

                Expanded(
                  child: charts.BarChart(
                    //.................. ADDITION ...............................
                    barGroupingType: charts.BarGroupingType.stacked,
                    selectionModels: [
                      charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: _onSelectionChanged,
                      )
                    ],
                    //...........................................................
                    barRendererDecorator: charts.BarLabelDecorator<String>(),
                    domainAxis: const charts.OrdinalAxisSpec(),
                    vertical: false, //For Chart Horizontal
                    _createSampleData(),
                    animate: false,
                  ),
                ),
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
