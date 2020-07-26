import 'package:flutter/material.dart';
import 'package:mobileClient/data/user_service.dart';
import 'package:mobileClient/data/work_service.dart';
import 'package:mobileClient/screens/user/loginpage.dart';
import 'package:mobileClient/models/user.dart';
import 'package:mobileClient/models/work.dart';
import 'package:mobileClient/screens/work/work_screen.dart';

class WorkListScreen extends StatefulWidget {
  final User user;
  const WorkListScreen({Key key, this.user}) : super(key: key);
  @override
  _WorkListScreenState createState() => _WorkListScreenState(user);
}

class _WorkListScreenState extends State<WorkListScreen> {
  Future<List<Work>> workList;
  User user;
  _WorkListScreenState(this.user);
  @override
  void initState() {
    super.initState();
    workList = WorkService.getWorks('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        centerTitle: true,
      ),
      drawer: buildDrawer(),
      body: buildWorkList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkScreen(
                  work: Work(),
                ),
              ));
          if (res != null) {
            if (res) {
              setState(() {
                workList = WorkService.getWorks('');
              });
            }
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  buildWorkList(BuildContext context) {
    return FutureBuilder(
        future: workList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Work work = snapshot.data[index];
                  return Card(
                    margin: EdgeInsets.all(5),
                    shadowColor: Colors.blue,
                    child: InkWell(
                      onTap: () async {
                        bool res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkScreen(
                                work: work,
                              ),
                            ));
                        if (res != null) {
                          if (res) {
                            setState(() {
                              workList = WorkService.getWorks('');
                            });
                          }
                        }
                      },
                      child: ListTile(
                        title: Text(work.title),
                        subtitle:
                            Text(work.description.substring(0, 7) + '...'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      user.name.substring(0, 1) +
                          ' ' +
                          user.surname.substring(0, 1),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    backgroundColor: Colors.black26,
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.name + ' ' + user.surname,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('This Week'),
            onTap: () {
              setState(() {
                workList = WorkService.getWorks('');
                Navigator.of(context).pop();
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('This Month'),
            onTap: () {
              setState(() {
                workList = WorkService.getWorks('getMonth');
                Navigator.of(context).pop();
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('This Year'),
            onTap: () {
              setState(() {
                workList = WorkService.getWorks('getYear');
                Navigator.of(context).pop();
              });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: Text('Log out'),
            onTap: () {
              UserService.removeCurrentUser()
                  .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      )));
            },
          ),
        ],
      ),
    );
  }
}
