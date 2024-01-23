class DataModel4 {
  String gender1;
  int count1;

  DataModel4({
    required this.gender1,
    required this.count1,
  });

  factory DataModel4.fromJson(Map<String, dynamic> json) => DataModel4(
        gender1: json["gender"],
        count1: int.parse(json["count"]),
      );
}

List<DataModel4> data1ModelFromJson(List data) => List<DataModel4>.from(
      data.map(
        (e) => DataModel4.fromJson(e),
      ),
    );

