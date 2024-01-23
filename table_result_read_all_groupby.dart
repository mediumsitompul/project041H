import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_model_table2.dart';
import 'main.dart';
import 'pareto_major_gender.dart';

class ResultReadAllGroupby extends StatelessWidget {
  const ResultReadAllGroupby({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Center(child: Text('CRUD OPERATION\n (READ GROUP BY)')),
        ),
        body: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var result;
  bool dataloaded = false;
  bool error = false;
  int n = 0;

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  //===================================================================================

  void _getData() {
    Future.delayed(Duration.zero, () async {
      var url = Uri.parse(
          "https://mediumsitompul.com/crud_restapi/groupby.php?auth=kjgdkhdfldfguttedfgr");

      var response = await http.post(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        setState(() {
          result = json.decode(response.body);

          print("result ++++++++++++++++++++++++++++++++++++++++++++++++");
          print(result);

          dataloaded = true;
        });
      } else {
        setState(() {
          error = true;
        });
      }
    });
  }

  //===================================================================================

  Widget datalist() {
    if (result["error"] != null) {
      return Text(result["errmsg"]);
    } else {
      List<DataModel2> namelist = List<DataModel2>.from(result["data"].map((i) {
        return DataModel2.fromJSON1(i);
      }));

      return ListView(
        children: [



      //+++++++++++++++++++++++++++++++++++++ HEADER ROW AFTER LIST VIEW +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
                //..........................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Table(
                border: TableBorder.symmetric(
                    inside: const BorderSide(width: 0, color: Colors.blue),
                    outside: const BorderSide(width: 0)),
                columnWidths: const {
                  0: FractionColumnWidth(0.2),
                  1: FractionColumnWidth(0.6),
                  2: FractionColumnWidth(0.2),
                },
                //..........................................................................
                children: const [
                  TableRow(children: [
                    Text(
                      "No",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16, backgroundColor: Colors.amber),
                    ),
                    Text(
                      "MAJOR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.amber,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "JLH",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16, backgroundColor: Colors.amber),
                    ),
                  ])
                ],
              ),
            ),

        //++++++++++++++++++++++++++++++++++++++++++++++ END HEADER ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=


          Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 0, color: Colors.blue),
            outside: const BorderSide(width: 0)),
        columnWidths: const {
          0: FractionColumnWidth(0.2),
          1: FractionColumnWidth(0.6),
          2: FractionColumnWidth(0.2),
        },

            //border: TableBorder.all(width: 1, color: Colors.black45), //YG INI JADI DI HAPUS
            children: namelist.map((dataModel) {
              n++;
              print("n+++++++++++++++++++");
              print(n);

              return TableRow(children: [
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(child: Text(n.toString())))),

                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ParetoMajorGender(
                                            major1a: dataModel.major1),
                                      ));
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(dataModel.major1)))))),
                //.......................................................................
                TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(child: Align(
                          alignment: Alignment.topRight,
                          child: Text(dataModel.jumlah1))))),
                //.........................................................................
              ]);
            }).toList(),
          ),
        ],
      );
    }
  }
  //===================================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //..................................................
      body: Container(
        padding: const EdgeInsets.all(15),
        child: dataloaded
            ? datalist()
            : const Center(child: CircularProgressIndicator()),
      ),
      //..................................................

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
