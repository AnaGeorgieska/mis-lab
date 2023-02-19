import 'package:flutter/material.dart';
import 'package:lab3_test/Pages/calendar_page.dart';

import 'Models/list_item.dart';
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
  List<ListItem> _userItems = [
    ListItem(id: "T1", subject: "MIS", date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0)),
    ListItem(id: "T2", subject: "VBS", date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0).add(const Duration(days: 1 ,hours: 2))),
  ];

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
      _userItems.add(item);
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _userItems.removeWhere((elem) => elem.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lists Example"), actions: <Widget>[
        
          TextButton(
            onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CalendarPage(list: _userItems))),
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
          child: _userItems.isEmpty
              ? Text('No elements')
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            _userItems[index].subject,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            _userItems[index].date.toString(),
                            style:
                                TextStyle(color: Colors.grey.withOpacity(1.0)),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(_userItems[index].id);
                            },
                          ),
                        ));
                  },
                  itemCount: _userItems.length),
        ));
  }
}
