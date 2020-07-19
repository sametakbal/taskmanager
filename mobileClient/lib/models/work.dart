class Work {
  String title;
  String description;
  bool isDone;
  String goalTime;
  int ownerId;
  int personId;
  int id;

  Work(
      {this.title = '',
      this.description = '',
      this.isDone = false,
      this.goalTime ='',
      this.ownerId =0,
      this.personId=0,
      this.id=0});

  Work.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
    goalTime = json['goalTime'];
    ownerId = json['ownerId'];
    personId = json['personId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['goalTime'] = this.goalTime;
    data['ownerId'] = this.ownerId;
    data['personId'] = this.personId;
    data['id'] = this.id;
    return data;
  }
}