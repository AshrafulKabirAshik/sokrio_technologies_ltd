class RepoModel {
  RepoModel({num? page, num? perPage, num? total, num? totalPages, List<Data>? data, Support? support, Meta? meta}) {
    _page = page;
    _perPage = perPage;
    _total = total;
    _totalPages = totalPages;
    _data = data;
    _support = support;
    _meta = meta;
  }

  RepoModel.fromJson(dynamic json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _support = json['support'] != null ? Support.fromJson(json['support']) : null;
    _meta = json['_meta'] != null ? Meta.fromJson(json['_meta']) : null;
  }

  num? _page;
  num? _perPage;
  num? _total;
  num? _totalPages;
  List<Data>? _data;
  Support? _support;
  Meta? _meta;

  RepoModel copyWith({
    num? page,
    num? perPage,
    num? total,
    num? totalPages,
    List<Data>? data,
    Support? support,
    Meta? meta,
  }) => RepoModel(
    page: page ?? _page,
    perPage: perPage ?? _perPage,
    total: total ?? _total,
    totalPages: totalPages ?? _totalPages,
    data: data ?? _data,
    support: support ?? _support,
    meta: meta ?? _meta,
  );

  num? get page => _page;

  num? get perPage => _perPage;

  num? get total => _total;

  num? get totalPages => _totalPages;

  List<Data>? get data => _data;

  Support? get support => _support;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['per_page'] = _perPage;
    map['total'] = _total;
    map['total_pages'] = _totalPages;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_support != null) {
      map['support'] = _support?.toJson();
    }
    if (_meta != null) {
      map['_meta'] = _meta?.toJson();
    }
    return map;
  }
}

/// powered_by : "🚀 ReqRes - Deploy backends in 30 seconds"
/// upgrade_url : "https://app.reqres.in/upgrade"
/// docs_url : "https://reqres.in"
/// template_gallery : "https://app.reqres.in/templates"
/// message : "This API is powered by ReqRes. Deploy your own backend in 30 seconds!"
/// features : ["30 Second Backend Templates","Custom API Endpoints","Data Persistence","Real-time Analytics"]
/// upgrade_cta : "Upgrade to Pro for unlimited requests, custom endpoints, and data persistence"

class Meta {
  Meta({
    String? poweredBy,
    String? upgradeUrl,
    String? docsUrl,
    String? templateGallery,
    String? message,
    List<String>? features,
    String? upgradeCta,
  }) {
    _poweredBy = poweredBy;
    _upgradeUrl = upgradeUrl;
    _docsUrl = docsUrl;
    _templateGallery = templateGallery;
    _message = message;
    _features = features;
    _upgradeCta = upgradeCta;
  }

  Meta.fromJson(dynamic json) {
    _poweredBy = json['powered_by'];
    _upgradeUrl = json['upgrade_url'];
    _docsUrl = json['docs_url'];
    _templateGallery = json['template_gallery'];
    _message = json['message'];
    _features = json['features'] != null ? json['features'].cast<String>() : [];
    _upgradeCta = json['upgrade_cta'];
  }

  String? _poweredBy;
  String? _upgradeUrl;
  String? _docsUrl;
  String? _templateGallery;
  String? _message;
  List<String>? _features;
  String? _upgradeCta;

  Meta copyWith({
    String? poweredBy,
    String? upgradeUrl,
    String? docsUrl,
    String? templateGallery,
    String? message,
    List<String>? features,
    String? upgradeCta,
  }) => Meta(
    poweredBy: poweredBy ?? _poweredBy,
    upgradeUrl: upgradeUrl ?? _upgradeUrl,
    docsUrl: docsUrl ?? _docsUrl,
    templateGallery: templateGallery ?? _templateGallery,
    message: message ?? _message,
    features: features ?? _features,
    upgradeCta: upgradeCta ?? _upgradeCta,
  );

  String? get poweredBy => _poweredBy;

  String? get upgradeUrl => _upgradeUrl;

  String? get docsUrl => _docsUrl;

  String? get templateGallery => _templateGallery;

  String? get message => _message;

  List<String>? get features => _features;

  String? get upgradeCta => _upgradeCta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['powered_by'] = _poweredBy;
    map['upgrade_url'] = _upgradeUrl;
    map['docs_url'] = _docsUrl;
    map['template_gallery'] = _templateGallery;
    map['message'] = _message;
    map['features'] = _features;
    map['upgrade_cta'] = _upgradeCta;
    return map;
  }
}

/// url : "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral"
/// text : "Tired of writing endless social media content? Let Content Caddy generate it for you."

class Support {
  Support({String? url, String? text}) {
    _url = url;
    _text = text;
  }

  Support.fromJson(dynamic json) {
    _url = json['url'];
    _text = json['text'];
  }

  String? _url;
  String? _text;

  Support copyWith({String? url, String? text}) => Support(url: url ?? _url, text: text ?? _text);

  String? get url => _url;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['text'] = _text;
    return map;
  }
}

/// id : 1
/// email : "george.bluth@reqres.in"
/// first_name : "George"
/// last_name : "Bluth"
/// avatar : "https://reqres.in/img/faces/1-image.jpg"

class Data {
  Data({num? id, String? email, String? firstName, String? lastName, String? avatar}) {
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _avatar = avatar;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _avatar = json['avatar'];
  }

  num? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _avatar;

  Data copyWith({num? id, String? email, String? firstName, String? lastName, String? avatar}) => Data(
    id: id ?? _id,
    email: email ?? _email,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    avatar: avatar ?? _avatar,
  );

  num? get id => _id;

  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['avatar'] = _avatar;
    return map;
  }
}
