import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // ↓ Add this.
  // 1- Les paraules es guarden a la llista.
  var paraulesGenerades = <WordPair>[];

  // 2- Detall per no perdre la primera paraula generada.
  MyAppState() {
    paraulesGenerades.add(current);
  }

  void getNext() {
    current = WordPair.random();
    paraulesGenerades.add(current);
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    // 2- Mostrar les paraules generades en l'historic.
    var paraulesHistoriques = appState.paraulesGenerades;

    return Scaffold(
      body: Column(
        children: [
          Text('Xa Sans Alfara the masterblack:'),
          BigCard(pair: pair),
          Text('Historic paraules:'),

          // 2- Es veurà l'última generada com a primera, per això s'utilitza reversed.
          // 2- Un container bàsic centrat amb un scroll per a no saturar la vista.
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var paraula in paraulesHistoriques.reversed)
                    Text(paraula.asLowerCase),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase),
      ),
    );
  }
}

// ...
