class DataModel2 {
  String n, major1, jumlah1;

  DataModel2({
    this.n = "",
    this.major1 = "",
    this.jumlah1 = "",
  });

  //DataModel.fromJSON1
  factory DataModel2.fromJSON1(Map<String, dynamic> convertJson) {
    return DataModel2(
        //n: convertJson["n"],
        major1: convertJson["major"],
        jumlah1: convertJson["jumlah"]);
  }
}
