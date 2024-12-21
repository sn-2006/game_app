import 'package:flutter/material.dart';

void main() => runApp(DisasterGame());

class DisasterGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disaster Simulation Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disaster Simulation Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Disaster Manager!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScenarioScreen()),
                );
              },
              child: Text('Start Simulation'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScenarioScreen extends StatelessWidget {
  final String scenario = "A massive flood has hit a city. Thousands are stranded.";
  final List<String> actions = [
    "Send rescue boats",
    "Set up shelters",
    "Distribute food supplies"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disaster Scenario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disaster Scenario:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              scenario,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Choose an action:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...actions.map((action) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OutcomeScreen(action: action)),
                  );
                },
                child: Text(action),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class OutcomeScreen extends StatelessWidget {
  final String action;

  OutcomeScreen({required this.action});

  String getOutcome() {
    switch (action) {
      case "Send rescue boats":
        return "You successfully rescued 500 people, but resources are running low.";
      case "Set up shelters":
        return "Shelters are operational, but food supplies are scarce.";
      case "Distribute food supplies":
        return "You fed 1,000 people, but rescue efforts are delayed.";
      default:
        return "Unknown action.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Outcome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Action: $action',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              getOutcome(),
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Try Another Action'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
