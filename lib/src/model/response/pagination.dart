class Pagination {
  PData next;
  PData prev;

  Pagination({this.next, this.prev});

  Pagination.fromJson(Map<String, dynamic> json) {
    next = json['next'] != null ? new PData.fromJson(json['next']) : null;
    prev = json['prev'] != null ? new PData.fromJson(json['prev']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    if (this.prev != null) {
      data['prev'] = this.prev.toJson();
    }
    return data;
  }
}

class PData {
  int page;
  int limit;

  PData({this.page, this.limit});

  PData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}