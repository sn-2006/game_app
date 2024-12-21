import 'package:flutter/material.dart';

void main() => runApp(DisasterGame());

class DisasterGame extends StatefulWidget {
  @override
  _DisasterGameState createState() => _DisasterGameState();
}

class _DisasterGameState extends State<DisasterGame> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Realm',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  HomeScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rescue Realm'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Disaster Manager!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScenarioScreen()),
                );
              },
              child: const Text('Start Simulation'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScenarioScreen extends StatefulWidget {
  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  String selectedDisaster = "Flood";
  int money = 100;
  int food = 50;
  int rescueTeams = 10;
  int score = 0;

  final Map<String, List<String>> disasterOptions = {
    "Flood": ["Send rescue boats", "Set up shelters", "Distribute food supplies", "Build a dam"],
    "Fire": ["Call fire brigade", "Use water", "Use fire extinguisher", "Cover with a blanket"],
    "Earthquake": ["Hide under a table", "Run outside", "Check for injuries", "Provide first aid"],
  };

  final Map<String, String> disasterDescriptions = {
    "Flood": "A massive flood has hit a city. Thousands are stranded, and food supplies are running out.",
    "Fire": "A large fire has broken out in a residential area. People are trapped, and smoke is spreading.",
    "Earthquake": "An earthquake has shaken the city. Buildings have collapsed, and people need urgent help.",
  };

  void updateResources(String action) {
    setState(() {
      switch (action) {
        case "Send rescue boats":
          money -= 30;
          rescueTeams -= 3;
          score += 50;
          break;
        case "Set up shelters":
          money -= 20;
          food -= 10;
          score += 30;
          break;
        case "Distribute food supplies":
          food -= 20;
          score += 20;
          break;
        case "Call fire brigade":
          money -= 50;
          rescueTeams -= 5;
          score += 60;
          break;
        case "Use water":
          money -= 10;
          food -= 5;
          score += 40;
          break;
        case "Hide under a table":
          score += 30;
          break;
        case "Run outside":
          score += 20;
          break;
        case "Check for injuries":
          score += 50;
          break;
        case "Provide first aid":
          food -= 5;
          rescueTeams -= 2;
          score += 70;
          break;
      }

      if (money < 0 || food < 0 || rescueTeams < 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameOverScreen(score: score),
          ),
        );
      } else if (score >= 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VictoryScreen(score: score),
          ),
        );
      }
    });
  }

  String getOutcome(String action) {
    switch (action) {
      case "Send rescue boats":
        return "You rescued 500 people, but lost resources. Remaining teams: $rescueTeams.";
      case "Set up shelters":
        return "Shelters are operational. Food supplies are now at $food.";
      case "Distribute food supplies":
        return "Food was distributed, but supplies are low ($food left).";
      case "Call fire brigade":
        return "Fire brigade is on the way. People are being rescued!";
      case "Use water":
        return "Water was used to control the fire. Damage is minimized.";
      case "Hide under a table":
        return "You took cover under a table. You are safe!";
      case "Run outside":
        return "You ran outside to safety. No injuries.";
      case "Check for injuries":
        return "Injuries are being treated, but resources are running low.";
      case "Provide first aid":
        return "First aid was provided. Casualties are reduced!";
      default:
        return "Unknown action.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disaster Scenario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a disaster to manage:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedDisaster,
              items: disasterDescriptions.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDisaster = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              disasterDescriptions[selectedDisaster]!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Resources: Money: \$$money, Food: $food, Rescue Teams: $rescueTeams',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose an action:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...disasterOptions[selectedDisaster]!.map((option) {
              return ElevatedButton(
                onPressed: () {
                  updateResources(option);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutcomeScreen(
                        action: option,
                        outcome: getOutcome(option),
                        score: score,
                      ),
                    ),
                  );
                },
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class OutcomeScreen extends StatelessWidget {
  final String action;
  final String outcome;
  final int score;

  OutcomeScreen({required this.action, required this.outcome, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outcome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Action: $action',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              outcome,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Current Score: $score',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Try Another Action'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameOverScreen extends StatelessWidget {
  final int score;

  GameOverScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Over')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              'Your final score: $score',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class VictoryScreen extends StatelessWidget {
  final int score;

  VictoryScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Victory')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              'Your final score: $score',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
