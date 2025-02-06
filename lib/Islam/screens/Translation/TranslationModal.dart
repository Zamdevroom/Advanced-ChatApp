class Quran {
  int? code;
  String? status;
  Data? data;

  Quran({this.code, this.status, this.data});

  Quran.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Surahs>? surahs;
  Edition? edition;

  Data({this.surahs, this.edition});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['surahs'] != null) {
      surahs = <Surahs>[];
      json['surahs'].forEach((v) {
        surahs!.add(Surahs.fromJson(v));
      });
    }
    edition = json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (surahs != null) {
      data['surahs'] = surahs!.map((v) => v.toJson()).toList();
    }
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    return data;
  }
}

class Surahs {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayahs>? ayahs;

  Surahs({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  Surahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add(Ayahs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayahs {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final Sajda? sajda;

  Ayahs({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    this.sajda,
  });

  factory Ayahs.fromJson(Map<String, dynamic> json) {
    return Ayahs(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: json['sajda'] == null
          ? null
          : (json['sajda'] is bool
          ? Sajda(isSimple: json['sajda'])
          : Sajda.fromJson(json['sajda'])),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['text'] = text;
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    if (sajda != null) {
      data['sajda'] = sajda!.toJson();
    }
    return data;
  }
}

class Sajda {
  final bool? isSimple;
  final int? id;
  final bool? recommended;
  final bool? obligatory;

  Sajda({
    this.isSimple,
    this.id,
    this.recommended,
    this.obligatory,
  });

  factory Sajda.fromJson(Map<String, dynamic> json) {
    return Sajda(
      id: json['id'],
      recommended: json['recommended'],
      obligatory: json['obligatory'],
    );
  }

  Map<String, dynamic> toJson() {
    if (isSimple != null) {
      return {'isSimple': isSimple};
    }
    return {
      'id': id,
      'recommended': recommended,
      'obligatory': obligatory,
    };
  }
}

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;

  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['format'] = format;
    data['type'] = type;
    return data;
  }
}
