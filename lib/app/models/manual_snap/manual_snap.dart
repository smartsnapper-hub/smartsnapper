class ManualSnap {
  List<CsvDataResult>? csvDataResult;

  ManualSnap({this.csvDataResult});

  ManualSnap.fromJson(Map<String, dynamic> json) {
    if (json['csv_data_result'] != null) {
      csvDataResult = <CsvDataResult>[];
      json['csv_data_result'].forEach((v) {
        csvDataResult!.add(new CsvDataResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.csvDataResult != null) {
      data['csv_data_result'] =
          this.csvDataResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CsvDataResult {
  String? datum;
  String? intNr;
  String? kennzeichen;
  String? modell;
  String? name;
  String? uhrzeit;
  String? areaseal;
  String? blxwsg;
  String? blywsg;
  String? brxwsg;
  String? brywsg;
  String? cxwgs;
  String? cywgs;
  String? latLong;
  String? tlxwsg;
  String? tlywsg;
  String? trxwsg;
  String? trywsg;

  CsvDataResult(
      {this.datum,
      this.intNr,
      this.kennzeichen,
      this.modell,
      this.name,
      this.uhrzeit,
      this.areaseal,
      this.blxwsg,
      this.blywsg,
      this.brxwsg,
      this.brywsg,
      this.cxwgs,
      this.cywgs,
      this.latLong,
      this.tlxwsg,
      this.tlywsg,
      this.trxwsg,
      this.trywsg});

  CsvDataResult.fromJson(Map<String, dynamic> json) {
    datum = json['Datum'];
    intNr = json['Int-Nr'];
    kennzeichen = json['Kennzeichen'];
    modell = json['Modell'];
    name = json['Name'];
    uhrzeit = json['Uhrzeit'];
    areaseal = json['areaseal'];
    blxwsg = json['blxwsg'];
    blywsg = json['blywsg'];
    brxwsg = json['brxwsg'];
    brywsg = json['brywsg'];
    cxwgs = json['cxwgs'];
    cywgs = json['cywgs'];
    latLong = json['lat+long'];
    tlxwsg = json['tlxwsg'];
    tlywsg = json['tlywsg'];
    trxwsg = json['trxwsg'];
    trywsg = json['trywsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Datum'] = this.datum;
    data['Int-Nr'] = this.intNr;
    data['Kennzeichen'] = this.kennzeichen;
    data['Modell'] = this.modell;
    data['Name'] = this.name;
    data['Uhrzeit'] = this.uhrzeit;
    data['areaseal'] = this.areaseal;
    data['blxwsg'] = this.blxwsg;
    data['blywsg'] = this.blywsg;
    data['brxwsg'] = this.brxwsg;
    data['brywsg'] = this.brywsg;
    data['cxwgs'] = this.cxwgs;
    data['cywgs'] = this.cywgs;
    data['lat+long'] = this.latLong;
    data['tlxwsg'] = this.tlxwsg;
    data['tlywsg'] = this.tlywsg;
    data['trxwsg'] = this.trxwsg;
    data['trywsg'] = this.trywsg;
    return data;
  }
}
