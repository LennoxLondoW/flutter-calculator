import 'package:calculator/services/do_math.dart';
import 'package:flutter/material.dart';
import 'package:calculator/components/buttons.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> keyedIn = [];
  List<List> rows = [
    ["7", "8", "9", '/'],
    ["4", "5", "6", '*'],
    ["1", "2", "3", '-'],
    ['.', "0", '00', '+'],
  ];
  String result = "";
  @override
  Widget build(BuildContext context) {
    String mathString = keyedIn.join();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.grey,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    mathString,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: rows
                  .map((buttons) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: buttons
                                .map(
                                  (buttonText) => Button(buttonText, () {
                                    setState(() {
                                      keyedIn.add(buttonText);
                                    });
                                  }),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                  .toList(),
            ),
            Row(
              children: [
                Button('Clear', () {
                  setState(() {
                    keyedIn.clear();
                    result = "";
                  });
                }),
                Button('Delete', () {
                  if (keyedIn.isNotEmpty) {
                    setState(() {
                      keyedIn.removeLast();
                    });
                  }
                }),
                Button('=', () {
                  if (keyedIn.isNotEmpty) {
                    setState(() {
                      DoMath doMath = DoMath(keyedIn);
                      doMath.calculate();
                      result = doMath.result;
                    });
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
