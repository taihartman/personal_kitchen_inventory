import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_inventory/AddItemPage.dart';
import 'package:kitchen_inventory/KitchenItem.dart';
import 'package:kitchen_inventory/models/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Kitchen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.w500, color: Colors.white),
          headline6: TextStyle(fontSize: 24.0, fontFamily: 'Roboto'),
          // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const MyHomePage(title: 'My Kitchen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> itemsList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
    super.initState();
  }

  FutureOr refreshPage(dynamic value) {
    setState(() {});
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("items") != null && prefs.getString("items") != '[]') {
      print(prefs.getString("items"));
      var jsonList = jsonDecode(prefs.getString("items") ?? "");

      jsonList.forEach((jsonItem) {
        Item item = Item.fromJson(jsonItem);
        itemsList.add(item);
      });
    } else {
      //load test data
      // final String response =
      //     await rootBundle.loadString('./json/itemsTest.json');
      // var data = await json.decode(response);
      // print("hello");
      // print(data);
      // data = data['items'];
      // var tempItemsList = await jsonDecode(jsonEncode(data));
      // tempItemsList.forEach((jsonItem) {
      //   print(jsonItem);
      //   Item item = Item.fromJson(jsonItem);
      //   itemsList.add(item);
      //   // print(item.name);
      // });
      Item item = Item(
          id: 1,
          changeValue: 0,
          name: "No items here, add one!",
          note: "This is an item!",
          quantity: 0,
          unit: "");
      itemsList.add(item);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Color(0xFF587291),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: itemsList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return KitchenItem(
                      item: itemsList[index],
                      itemsList: itemsList,
                      funCallback: () {
                        setState(() {});
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(
                itemsList: itemsList,
              ),
            ),
          ).then(refreshPage);
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
