// class Hadith {
//   int? id;
//   Metadata? metadata;
//   List<Chapters>? chapters;
//   List<Hadiths>? hadiths;
//
//   Hadith({this.id, this.metadata, this.chapters, this.hadiths});
//
//   Hadith.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     metadata = json['metadata'] != null
//         ? new Metadata.fromJson(json['metadata'])
//         : null;
//     if (json['chapters'] != null) {
//       chapters = <Chapters>[];
//       json['chapters'].forEach((v) {
//         chapters!.add(new Chapters.fromJson(v));
//       });
//     }
//     if (json['hadiths'] != null) {
//       hadiths = <Hadiths>[];
//       json['hadiths'].forEach((v) {
//         hadiths!.add(new Hadiths.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.metadata != null) {
//       data['metadata'] = this.metadata!.toJson();
//     }
//     if (this.chapters != null) {
//       data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
//     }
//     if (this.hadiths != null) {
//       data['hadiths'] = this.hadiths!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Metadata {
//   int? id;
//   int? length;
//   Arabic? arabic;
//   Arabic? english;
//
//   Metadata({this.id, this.length, this.arabic, this.english});
//
//   Metadata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     length = json['length'];
//     arabic =
//     json['arabic'] != null ? new Arabic.fromJson(json['arabic']) : null;
//     english =
//     json['english'] != null ? new Arabic.fromJson(json['english']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['length'] = this.length;
//     if (this.arabic != null) {
//       data['arabic'] = this.arabic!.toJson();
//     }
//     if (this.english != null) {
//       data['english'] = this.english!.toJson();
//     }
//     return data;
//   }
// }
//
// class Arabic {
//   String? title;
//   String? author;
//   String? introduction;
//
//   Arabic({this.title, this.author, this.introduction});
//
//   Arabic.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     author = json['author'];
//     introduction = json['introduction'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['author'] = this.author;
//     data['introduction'] = this.introduction;
//     return data;
//   }
// }
//
// class Chapters {
//   int? id;
//   int? bookId;
//   String? arabic;
//   String? english;
//
//   Chapters({this.id, this.bookId, this.arabic, this.english});
//
//   Chapters.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bookId = json['bookId'];
//     arabic = json['arabic'];
//     english = json['english'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['bookId'] = this.bookId;
//     data['arabic'] = this.arabic;
//     data['english'] = this.english;
//     return data;
//   }
// }
//
// class Hadiths {
//   int? id;
//   int? idInBook;
//   int? chapterId;
//   int? bookId;
//   String? arabic;
//   Arabic? english;
//
//   Hadiths(
//       {this.id,
//         this.idInBook,
//         this.chapterId,
//         this.bookId,
//         this.arabic,
//         this.english});
//
//   Hadiths.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idInBook = json['idInBook'];
//     chapterId = json['chapterId'];
//     bookId = json['bookId'];
//     arabic = json['arabic'];
//     english =
//     json['english'] != null ? new Arabic.fromJson(json['english']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['idInBook'] = this.idInBook;
//     data['chapterId'] = this.chapterId;
//     data['bookId'] = this.bookId;
//     data['arabic'] = this.arabic;
//     if (this.english != null) {
//       data['english'] = this.english!.toJson();
//     }
//     return data;
//   }
// }
//
// class English {
//   String? narrator;
//   String? text;
//
//   English({this.narrator, this.text});
//
//   English.fromJson(Map<String, dynamic> json) {
//     narrator = json['narrator'];
//     text = json['text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['narrator'] = this.narrator;
//     data['text'] = this.text;
//     return data;
//   }
// }

// import 'dart:convert';
//
// class HadithData {
//   int id;
//   Metadata metadata;
//   List<Chapter> chapters;
//   final List<Hadith> hadiths;
//
//   HadithData({
//     this.id,
//     this.metadata,
//     this.chapters,
//     this.hadiths,
//   });
//
//   factory HadithData.fromJson(Map<String, dynamic> json) {
//     return HadithData(
//       id: json['id'] ?? 0,
//       metadata: Metadata.fromJson(json['metadata'] ?? {}),
//       chapters: (json['chapters'] as List<dynamic>?)
//           ?.map((e) => Chapter.fromJson(e))
//           .toList() ??
//           [],
//       hadiths: (json['hadiths'] as List<dynamic>?)
//           ?.map((e) => Hadith.fromJson(e))
//           .toList() ??
//           [],
//     );
//   }
// }
//
// class Metadata {
//   final int id;
//   final int length;
//   final LanguageData arabic;
//   final LanguageData english;
//
//   Metadata({
//     required this.id,
//     required this.length,
//     required this.arabic,
//     required this.english,
//   });
//
//   factory Metadata.fromJson(Map<String, dynamic> json) {
//     return Metadata(
//       id: json['id'] ?? 0,
//       length: json['length'] ?? 0,
//       arabic: LanguageData.fromJson(json['arabic'] ?? {}),
//       english: LanguageData.fromJson(json['english'] ?? {}),
//     );
//   }
// }
//
// class LanguageData {
//   final String title;
//   final String author;
//   final String introduction;
//
//   LanguageData({
//     required this.title,
//     required this.author,
//     required this.introduction,
//   });
//
//   factory LanguageData.fromJson(Map<String, dynamic> json) {
//     return LanguageData(
//       title: json['title'] ?? '',
//       author: json['author'] ?? '',
//       introduction: json['introduction'] ?? '',
//     );
//   }
// }
//
// class Chapter {
//   final int id;
//   final int bookId;
//   final String arabic;
//   final String english;
//
//   Chapter({
//     required this.id,
//     required this.bookId,
//     required this.arabic,
//     required this.english,
//   });
//
//   factory Chapter.fromJson(Map<String, dynamic> json) {
//     return Chapter(
//       id: json['id'] ?? 0,
//       bookId: json['bookId'] ?? 0,
//       arabic: json['arabic'] ?? '',
//       english: json['english'] ?? '',
//     );
//   }
// }
//
// class Hadith {
//   final int id;
//   final int idInBook;
//   final int chapterId;
//   final int bookId;
//   final String arabic;
//   final EnglishHadith? english;
//
//   Hadith({
//     required this.id,
//     required this.idInBook,
//     required this.chapterId,
//     required this.bookId,
//     required this.arabic,
//     this.english,
//   });
//
//   factory Hadith.fromJson(Map<String, dynamic> json) {
//     return Hadith(
//       id: json['id'] ?? 0,
//       idInBook: json['idInBook'] ?? 0,
//       chapterId: json['chapterId'] ?? 0,
//       bookId: json['bookId'] ?? 0,
//       arabic: json['arabic'] ?? '',
//       english: json['english'] != null
//           ? EnglishHadith.fromJson(json['english'])
//           : null,
//     );
//   }
// }
//
// class EnglishHadith {
//   final String narrator;
//   final String text;
//
//   EnglishHadith({
//     required this.narrator,
//     required this.text,
//   });
//
//   factory EnglishHadith.fromJson(Map<String, dynamic> json) {
//     return EnglishHadith(
//       narrator: json['narrator'] ?? '',
//       text: json['text'] ?? '',
//     );
//   }
// }

class Hadith {
  int? id;
  Metadata? metadata;
  List<Chapter>? chapters;
  List<HadithDetail>? hadiths;

  Hadith({this.id, this.metadata, this.chapters, this.hadiths});

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'],
      metadata: json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
      chapters: json['chapters'] != null
          ? (json['chapters'] as List).map((e) => Chapter.fromJson(e)).toList()
          : null,
      hadiths: json['hadiths'] != null
          ? (json['hadiths'] as List).map((e) => HadithDetail.fromJson(e)).toList()
          : null,
    );
  }
}

class Metadata {
  int? id;
  int? length;
  LanguageData? arabic;
  LanguageData? english;

  Metadata({this.id, this.length, this.arabic, this.english});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: json['id'],
      length: json['length'],
      arabic: json['arabic'] != null ? LanguageData.fromJson(json['arabic']) : null,
      english: json['english'] != null ? LanguageData.fromJson(json['english']) : null,
    );
  }
}

class LanguageData {
  String? title;
  String? author;
  String? introduction;

  LanguageData({this.title, this.author, this.introduction});

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      title: json['title'],
      author: json['author'],
      introduction: json['introduction'],
    );
  }
}

class Chapter {
  int? id;
  int? bookId;
  String? arabic;
  String? english;

  Chapter({this.id, this.bookId, this.arabic, this.english});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      bookId: json['bookId'],
      arabic: json['arabic'],
      english: json['english'],
    );
  }
}

class HadithDetail {
  int? id;
  int? idInBook;
  int? chapterId;
  int? bookId;
  String? arabic;
  EnglishText? english;

  HadithDetail({this.id, this.idInBook, this.chapterId, this.bookId, this.arabic, this.english});

  factory HadithDetail.fromJson(Map<String, dynamic> json) {
    return HadithDetail(
      id: json['id'],
      idInBook: json['idInBook'],
      chapterId: json['chapterId'],
      bookId: json['bookId'],
      arabic: json['arabic'],
      english: json['english'] != null ? EnglishText.fromJson(json['english']) : null,
    );
  }
}

class EnglishText {
  String? narrator;
  String? text;

  EnglishText({this.narrator, this.text});

  factory EnglishText.fromJson(Map<String, dynamic> json) {
    return EnglishText(
      narrator: json['narrator'],
      text: json['text'],
    );
  }
}