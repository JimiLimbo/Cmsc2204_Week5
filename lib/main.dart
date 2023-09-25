import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 6 Git'),
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
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;

  List<Item> items = [
    Item("Doge", "Coin", 69, "Saver"),
    Item("Elon", "Musk", 99, "Spender"),
    Item("Donald", "Trump", 100, "Frequent"),
    Item("Joe", "Blow", 9, "Occasional"),
    Item("Bobbi", "Jo", 48, "Saver"),
    Item("Seth", "Caster", 47, "Saver"),
    Item("Jadie", "Bug", 25, "Spender"),
    Item("Julia", "Dream", 19, "Saver"),
    Item("Jena", "Vieve", 17, "Spender"),
    Item("Arnold", "Layne", 29, "Occasional"),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  void _resetPage() {
    setState(() {
      pageFirstLoad = true;
      isLoadingItemsFromDatabase = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Customer List"),
              )
            : isLoadingItemsFromDatabase
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please Wait")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items.map((item) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(  
                                children: [
                                  Text(item.FirstName, style: TextStyle(fontSize: 20)),
                                  SizedBox(width: 5), 
                                  Text(item.LastName, style: TextStyle(fontSize: 20)),
                                ],
                              ),
                              Text('Id #: ${item.CustomerID.toString()}'),
                              Text('Type: ${item.Type}'),
                              Divider(color:Colors.deepPurple,)
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
      floatingActionButton: (!pageFirstLoad && !isLoadingItemsFromDatabase)
      ? FloatingActionButton(
          onPressed: _resetPage,
          child: Icon(Icons.refresh),
          tooltip: 'Reset Page',
        )
      : null,
    );
  }
}

class Item {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Item(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
