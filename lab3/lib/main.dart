import 'package:flutter/material.dart';
import 'package:lab3_test/Models/user.dart';
import 'package:lab3_test/Pages/authentication.dart';
import 'package:lab3_test/Pages/calendar_page.dart';

import 'Models/list_item.dart';
import 'Pages/login_page.dart';
import 'Widgets/nov_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User>? _userItemsList;

  User? _user;

  void initState() {
    _userItemsList = [
    User(id: "T1", username: "ana", password: "ana", listItems: [
    ListItem(id: "T1", subject: "MIS", date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0)),
    ListItem(id: "T2", subject: "VBS", date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0).add(const Duration(days: 1 ,hours: 2))),
  ]),
  ];
  _user = _userItemsList?[0];
    super.initState();
  }

  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NovElement(_addNewItemToList),
              behavior: HitTestBehavior.opaque);
        });
  }

  void _addNewItemToList(ListItem item) {
    setState(() {
      _user?.listItems.add(item);
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _user?.listItems.removeWhere((elem) => elem.id == id);
    });
  }

  bool _login(String username, String password) {
    _user = null;
    _userItemsList?.forEach((element) {
      if(element.username == username && element.password == password){
        setState(() {
          _user=element;
        });
      }
    });

    return (_user!=null);
  }

  bool _addNewUserToList(User item) {
    setState(() {
      _userItemsList?.add(item);
    });
    _user=item;
    return (item!=null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(""),
        actions: <Widget>[
          TextButton(
            onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(login: _login))),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AuthenticationPage(addItem: _addNewUserToList))),
            child: const Text(
              "Register",
              style: TextStyle(color: Colors.white),
            ),
          ),
        
          TextButton(
            onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CalendarPage(list: _user!.listItems))),
            child: const Text(
              "Calendar",
              style: TextStyle(color: Colors.white),
            ),
          ),IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addItemFunction(context),
          ),
        ]),
          
        body: Center(
          child: _user!.listItems.isEmpty
              ? Text('No elements')
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            _user!.listItems[index].subject,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            _user!.listItems[index].date.toString(),
                            style:
                                TextStyle(color: Colors.grey.withOpacity(1.0)),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(_user!.listItems[index].id);
                            },
                          ),
                        ));
                  },
                  itemCount: _user!.listItems.length),
        ));
  }
}
