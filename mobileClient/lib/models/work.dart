class Work {
  String title;
  String description;
  bool isDone;
  String goalTime;
  Null owner;
  int ownerId;
  Null person;
  Null personId;
  int id;

  Work(
      {this.title,
      this.description,
      this.isDone,
      this.goalTime,
      this.owner,
      this.ownerId,
      this.person,
      this.personId,
      this.id});

  Work.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
    goalTime = json['goalTime'];
    owner = json['owner'];
    ownerId = json['ownerId'];
    person = json['person'];
    personId = json['personId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['isDone'] = this.isDone;
    data['goalTime'] = this.goalTime;
    data['owner'] = this.owner;
    data['ownerId'] = this.ownerId;
    data['person'] = this.person;
    data['personId'] = this.personId;
    data['id'] = this.id;
    return data;
  }
}