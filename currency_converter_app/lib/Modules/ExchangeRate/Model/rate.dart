class Rate {
  Map<String, double> rates;
  String base;
  String date;

  Rate({this.rates, this.base, this.date});

  Rate.fromJson(Map<String, dynamic> json) {
    rates = Map.from(json["rates"])
        .map((k, v) => MapEntry<String, double>(k, v.toDouble()));
    base = json['base'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rates != null) {
      data['rates'] = this.rates;
    }
    data['base'] = this.base;
    data['date'] = this.date;
    return data;
  }
}
