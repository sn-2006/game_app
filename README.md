Game Structure:
  Home Screen
    Welcome message and navigation to the simulation.
    Theme toggle button for switching between light and dark mode.
  Scenario Screen:
    Select a disaster to manage (Flood, Fire, Earthquake).
    Resource display: Money, Food, Rescue Teams.
    Actions available based on the selected disaster.
  Outcome Screen:
    Displays the result of the chosen action, current resources, and updated score.
    Option to return to the scenario screen or the home screen.
    Victory & Game Over Screens
    Victory: Achieve a high score by effectively managing resources.
    Game Over: Depletion of any resource (money, food, or rescue teams).
  How to Play:
    Launch the app and start a new simulation.
    Select a disaster and review the scenario description.
    Choose actions to manage the disaster effectively while monitoring resources.
    Strive to maximize your score without depleting any resource.
    Reach a score of 200 to win, or face a game over if resources run out.
  Customization:
    Adding New Disasters
    Update the disasterOptions map with actions for the new disaster.
    Add a description to the disasterDescriptions map.
    Implement resource changes and outcomes for each action in updateResources and getOutcome methods.
  Technologies Used:
    Flutter
    Dart
