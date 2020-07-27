import 'package:flutter/material.dart';
import 'package:mobileClient/data/work_service.dart';
import 'package:mobileClient/models/work.dart';

class WorkScreen extends StatefulWidget {
  final Work work;

  const WorkScreen({Key key, this.work}) : super(key: key);
  @override
  _WorkScreenState createState() => _WorkScreenState(work);
}

class _WorkScreenState extends State<WorkScreen> {
  Work work;
  _WorkScreenState(this.work);
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final goaltimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = work.title;
    descController.text = work.description;
    goaltimeController.text = work.goalTime == ''
        ? DateTime.now().toString().replaceAll(' ', 'T')
        : work.goalTime;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(work.title.isEmpty ? 'New Work' : work.title),
        centerTitle: true,
        actions: <Widget>[
          work.id != 0
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteDialog(work.id);
                  })
              : SizedBox()
        ],
      ),
      body: formBuilder(),
    );
  }

  formBuilder() {
    final titleField = TextFormField(
      controller: titleController,
      maxLength: 55,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter title';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Title",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    final descriptionField = TextFormField(
      controller: descController,
      maxLines: 5,
      maxLength: 1000,
      keyboardType: TextInputType.multiline,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    final goaltimeField = TextFormField(
      controller: goaltimeController,
      enabled: false,
      keyboardType: TextInputType.datetime,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter goaltime';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "yyyy-mm-dd",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: titleField,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: descriptionField,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: goaltimeField,
                onTap: () => callDatePicker(),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  WorkService.saveWork(Work(
                          id: work.id,
                          title: titleController.text,
                          description: descController.text,
                          goalTime: goaltimeController.text))
                      .then((value) => Navigator.pop(context, true));
                }
              },
              color: Colors.blueAccent,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure delete this work?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green),
                )),
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                WorkService.deleteWork(id).then((value) {
                  Navigator.of(context).pop();
                  Navigator.pop(context, true);
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void callDatePicker() async {
    var order =
        await getDate() ?? DateTime.now().toString().replaceAll(' ', 'T');
    setState(() {
      goaltimeController.text = order.toString().replaceAll(' ', 'T');
    });
  }
}
