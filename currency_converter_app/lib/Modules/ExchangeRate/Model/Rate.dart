
class Rate {
  Map<String, dynamic> rates;
  String base;
  String date;

  Rate({this.rates, this.base, this.date});

  Rate.fromJson(Map<String, dynamic> json) {
    rates = json['rates'];
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