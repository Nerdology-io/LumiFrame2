TITLE: Complete Flutter App: Asynchronous Data Loading and ListView Display
DESCRIPTION: This comprehensive Flutter application showcases how to build a StatefulWidget that fetches data asynchronously from a REST API upon initialization (initState) and displays it in a ListView.builder. It integrates http for network requests and dart:convert for JSON parsing, ensuring a responsive UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Offload JSON Parsing to Background Isolate with Flutter compute()
DESCRIPTION: This Dart code demonstrates how to prevent UI jank by moving the expensive JSON parsing operation to a separate background isolate using Flutter's `compute()` function. The `fetchPhotos()` function is updated to call `compute(parsePhotos, response.body)`, ensuring that the parsing runs off the main thread and returns the result asynchronously.
SOURCE: https://docs.flutter.dev/cookbook/networking/background-parsing

LANGUAGE: dart
CODE:
```
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}
```

----------------------------------------

TITLE: Accessing State: Passing Callback to Child Widget
DESCRIPTION: Shows a simple method of accessing state from a child widget by passing a callback function from the parent. This allows the child to notify the parent of events, such as a user tap.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return SomeWidget(
    // Construct the widget, passing it a reference to the method above.
    MyListItem(myTapCallback),
  );
}

void myTapCallback(Item item) {
  print('user tapped on $item');
}
```

----------------------------------------

TITLE: Define a CartModel using ChangeNotifier in Flutter
DESCRIPTION: This Dart code defines a `CartModel` class that extends `ChangeNotifier` to manage a shopping cart's state. It includes methods for adding and removing items, and a getter for the total price. The `notifyListeners()` method is called to alert UI widgets of state changes.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Fetch Album Data from API and Parse Response in Dart
DESCRIPTION: Updates the `fetchAlbum()` function to make an HTTP GET request to a specified URL. It parses the JSON response into an `Album` object if the server returns a 200 OK status code; otherwise, it throws an `Exception` indicating a failure to load the album.
SOURCE: https://docs.flutter.dev/cookbook/networking/fetch-data

LANGUAGE: Dart
CODE:
```
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
```

----------------------------------------

TITLE: Complete Flutter Navigation Example
DESCRIPTION: A comprehensive example showcasing full navigation flow in Flutter, including app setup, defining FirstRoute and SecondRoute widgets, and implementing navigation forward with Navigator.push() and backward with Navigator.pop(). It provides distinct implementations for Material Design and Cupertino styles.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigation-basics

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

LANGUAGE: dart
CODE:
```
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CupertinoApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter Widget Hierarchy Example
DESCRIPTION: This Dart code fragment demonstrates a typical Flutter widget hierarchy, showing how Container, Row, Image.network, and Text widgets are nested to compose a UI. It serves as an example of the initial widget structure before Flutter's build process expands it.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: dart
CODE:
```
Container(
  color: Colors.blue,
  child: Row(
    children: [
      Image.network('https://www.example.com/1.png'),
      const Text('A'),
    ],
  ),
);
```

----------------------------------------

TITLE: Flutter Sample App: Network Data Fetching with Progress Indicator
DESCRIPTION: A comprehensive Flutter example demonstrating a full application flow: fetching data from a remote API, displaying a `CircularProgressIndicator` while data loads, and then rendering the fetched data in a `ListView`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }
    return getListView();
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
}
```

----------------------------------------

TITLE: Flutter Example: Retrieve Text Input from TextField
DESCRIPTION: This Flutter code snippet demonstrates a complete application that retrieves text input from a TextField using a TextEditingController. When the floating action button is pressed, the current text from the TextField is displayed in an AlertDialog. It also shows proper disposal of the controller.
SOURCE: https://docs.flutter.dev/cookbook/forms/retrieve-input

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Offload computation with Isolate.run() in Dart
DESCRIPTION: This Dart example shows how to use Isolate.run() (available since Dart 2.19) to offload a potentially long-running computation, such as JSON decoding, to a separate isolate. This prevents the main thread from being blocked, allowing the UI to remain responsive while data is processed asynchronously.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/dart-swift-concurrency

LANGUAGE: dart
CODE:
```
void main() async {
  // Read some data.
  final jsonData = await Isolate.run(() => jsonDecode(jsonString) as Map<String, dynamic>);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}
```

----------------------------------------

TITLE: Implement User Text Input in Flutter with TextField
DESCRIPTION: The `TextField` widget provides a text box for users to enter text using a keyboard. It offers extensive configuration options, including `InputDecoration` for appearance, `TextEditingController` for programmatic control, `onChanged` for real-time updates, and `onSubmitted` for handling completion. This snippet demonstrates a basic `TextField` with a controller and a label.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
final TextEditingController _controller = TextEditingController();

@override
Widget build(BuildContext context) {
  return TextField(
    controller: _controller,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Mascot Name',
    ),
  );
}
```

----------------------------------------

TITLE: Basic Flutter Material App Structure
DESCRIPTION: This Flutter code demonstrates the fundamental structure of a Material Design application. It initializes the app with `MaterialApp`, defines a `TutorialHome` StatelessWidget that uses `Scaffold` for its main layout, including an `AppBar`, a centered body, and a `FloatingActionButton`. This example illustrates how to integrate common Material Components.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Flutter Tutorial', home: TutorialHome()));
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: const Center(child: Text('Hello, world!')),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implement Custom Recipe Response Widget in Flutter
DESCRIPTION: This Dart code defines `RecipeResponseView`, a StatelessWidget that processes an LLM's JSON response. It parses the response to extract introductory text and recipe details, then dynamically builds a UI including recipe title, description, content, and an 'Add Recipe' button. It includes error handling for JSON parsing.
SOURCE: https://docs.flutter.dev/ai-toolkit/feature-integration

LANGUAGE: dart
CODE:
```
class RecipeResponseView extends StatelessWidget {
  const RecipeResponseView(this.response, {super.key});
  final String response;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    String? finalText;

    // created with the response from the LLM as the response streams in, so
    // many not be a complete response yet
    try {
      final map = jsonDecode(response);
      final recipesWithText = map['recipes'] as List<dynamic>;
      finalText = map['text'] as String?;

      for (final recipeWithText in recipesWithText) {
        // extract the text before the recipe
        final text = recipeWithText['text'] as String?;
        if (text != null && text.isNotEmpty) {
          children.add(MarkdownBody(data: text));
        }

        // extract the recipe
        final json = recipeWithText['recipe'] as Map<String, dynamic>;
        final recipe = Recipe.fromJson(json);
        children.add(const Gap(16));
        children.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.title, style: Theme.of(context).textTheme.titleLarge),
            Text(recipe.description),
            RecipeContentView(recipe: recipe),
          ],
        ));

        // add a button to add the recipe to the list
        children.add(const Gap(16));
        children.add(OutlinedButton(
          onPressed: () => RecipeRepository.addNewRecipe(recipe),
          child: const Text('Add Recipe'),
        ));
        children.add(const Gap(16));
      }
    } catch (e) {
      debugPrint('Error parsing response: $e');
    }

    ...

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
```

----------------------------------------

TITLE: Dart Program to Fetch and Decode JSON
DESCRIPTION: This Dart example demonstrates fetching data from a URL using the `http` package, decoding the JSON response, and modeling it with a custom `Package` class. It showcases basic network operations, JSON parsing, and class usage in Dart.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/dart

LANGUAGE: Dart
CODE:
```
import 'dart:convert';
import 'package:http/http.dart' as http;

class Package {
  final String name;
  final String latestVersion;
  final String? description;

  Package(this.name, this.latestVersion, {this.description});

  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';
  }
}

void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final httpPackageResponse = await http.get(httpPackageUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  final json = jsonDecode(httpPackageResponse.body);
  final package = Package(
    json['name'],
    json['latestVersion'],
    description: json['description'],
  );
  print(package);
}
```

----------------------------------------

TITLE: Defining a Basic Flutter StatelessWidget
DESCRIPTION: This Dart code snippet provides the foundational structure for defining a `StatelessWidget` in Flutter. It includes the necessary `material.dart` import, a `main` function to run the application with an instance of `MyStatelessWidget`, and the beginning of the `MyStatelessWidget` class definition, which extends `StatelessWidget` for immutable UI components.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(
  const MyStatelessWidget(
    text: 'StatelessWidget Example to show immutable data',
  ),
);

class MyStatelessWidget extends StatelessWidget {
```

----------------------------------------

TITLE: Full Flutter App: Dismissing Items with Interactive Example
DESCRIPTION: This complete Flutter application demonstrates the full implementation of swipe-to-dismiss functionality. It uses a `StatefulWidget` to manage a list of items, `ListView.builder` to display them, and `Dismissible` widgets for each item. The example includes removing items from the data source, showing a `SnackBar` on dismissal, and providing a red background as a visual 'leave behind' indicator.
SOURCE: https://docs.flutter.dev/cookbook/gestures/dismissible

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    const title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text(item)),
            );
          },
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Dynamically updating UI with StatefulWidget in Flutter
DESCRIPTION: This example illustrates how to use a StatefulWidget to dynamically change UI elements based on user interaction. It shows how to wrap a Text widget in a StatefulWidget, manage its state using the State object, and trigger UI updates with setState() when a FloatingActionButton is pressed.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Create a new Flutter project with web support
DESCRIPTION: Use the `flutter create` command to initialize a new Flutter application. By default, this command creates a project with support for all available platforms, including web.
SOURCE: https://docs.flutter.dev/platform-integration/web/building

LANGUAGE: Shell
CODE:
```
flutter create my_app
```

----------------------------------------

TITLE: Write Flutter Integration Test for Counter App
DESCRIPTION: This Dart code snippet demonstrates how to write an integration test for a Flutter counter application. It initializes the `IntegrationTestWidgetsFlutterBinding`, loads the app widget, verifies initial state, simulates a tap on a floating action button, and asserts the counter increment. The test file should be placed in `integration_test/app_test.dart` and import your app's `main.dart`.
SOURCE: https://docs.flutter.dev/testing/integration-tests

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_to/main.dart';
import 'package:integration_test/integration_test';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (
      tester,
    ) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final fab = find.byKey(const ValueKey('increment'));

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
    });
  });
}
```

----------------------------------------

TITLE: Default Flutter App `main` Entrypoint
DESCRIPTION: Illustrates the standard `main` function in a Flutter application's `lib/main.dart` file. This function is the primary entry point, responsible for initializing and running the Flutter widget tree via `runApp()`.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/dart

LANGUAGE: Dart
CODE:
```
void main() {
  runApp(const MyApp());
}
```

----------------------------------------

TITLE: Flutter: Create Data with HTTP POST and Display Response
DESCRIPTION: This snippet demonstrates a complete Flutter application that sends data (an album title) to a REST API using an HTTP POST request. It defines an 'Album' model, a 'createAlbum' function for the network call, and a 'StatefulWidget' ('MyApp') that manages user input, triggers the API call, and displays the response or an error.
SOURCE: https://docs.flutter.dev/cookbook/networking/send-data

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'title': title}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title} => Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Create Data Example')),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
```

----------------------------------------

TITLE: Create two basic Flutter routes
DESCRIPTION: This section demonstrates how to create two simple routes (screens) in Flutter. Each route is a StatelessWidget containing an AppBar (or CupertinoNavigationBar) and a centered ElevatedButton (or CupertinoButton). The first route's button is intended to navigate to the second, and the second route's button is for returning to the first. Separate implementations are provided for Material Design (Android) and Cupertino (iOS) styles.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigation-basics

LANGUAGE: dart
CODE:
```
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

LANGUAGE: dart
CODE:
```
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Create Basic Flutter App Structure
DESCRIPTION: This snippet provides the foundational code for a Flutter application, including the `main` function, `MyApp` StatelessWidget, `MaterialApp`, `Scaffold`, and `AppBar`. It sets up a basic 'Hello World' display and demonstrates how to use a parameter for the app title, simplifying the code.
SOURCE: https://docs.flutter.dev/ui/layout/tutorial

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Add Click/Press Listener to Widgets in Flutter
DESCRIPTION: This Flutter snippet illustrates the basic structure for adding interaction to widgets. It highlights that click or press listeners can be added using widgets with an `onPress` field (like buttons) or by wrapping any widget with a `GestureDetector` for more advanced gesture recognition.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
@override
Widget build(BuildContext context) {
```

----------------------------------------

TITLE: Update UI with ListenableBuilder and ChangeNotifier in Flutter
DESCRIPTION: This example demonstrates how to use ListenableBuilder to reactively update a part of the UI based on changes in a ChangeNotifier. The builder function automatically rebuilds whenever counterNotifier.notifyListeners() is called, ensuring the displayed count is always current.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/state-management

LANGUAGE: dart
CODE:
```
Column(
  children: [
    ListenableBuilder(
      listenable: counterNotifier,
      builder: (context, child) {
        return Text('counter: ${counterNotifier.count}');
      },
    ),
    TextButton(
      child: Text('Increment'),
      onPressed: () {
        counterNotifier.increment();
      },
    ),
  ],
)
```

----------------------------------------

TITLE: Flutter CLI: Create, Analyze, Test, and Run an App
DESCRIPTION: Demonstrates the typical workflow for using the `flutter` tool to initialize a new application, navigate into its directory, analyze its code for potential issues, run tests, and finally execute the application.
SOURCE: https://docs.flutter.dev/reference/flutter-cli

LANGUAGE: Bash
CODE:
```
flutter create my_app
cd my_app
flutter analyze
flutter test
flutter run lib/main.dart
```

----------------------------------------

TITLE: Flutter Widget.build Method API Reference
DESCRIPTION: The `build()` method describes the part of the user interface represented by this widget. It is called by the framework when the widget is inserted into the tree, when its dependencies change, or when `setState` is called. It should return a widget tree that represents the current state.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
Widget.build(context: BuildContext): Widget
  context: The `BuildContext` for the widget, providing access to the widget tree location.
```

----------------------------------------

TITLE: Understanding Flutter Hot Reload vs. Hot Restart Mechanics
DESCRIPTION: Differentiate between Flutter's hot reload and hot restart functionalities. Hot reload injects code changes into the running Dart VM, while hot restart is required for changes to global variable initializers, static field initializers, or the main() method. Learn how to trigger a hot restart without ending your debugging session.
SOURCE: https://docs.flutter.dev/tools/android-studio

LANGUAGE: Flutter
CODE:
```
Hot reload:
- Injects updated source code files into the running Dart VM.
- Supports adding new classes, methods, fields, and changing existing functions.
- Limitations: Cannot hot reload global variable initializers, static field initializers, or the main() method.

Hot restart:
- Fully restarts the application without ending the debugging session.
- Required for changes that cannot be hot reloaded.
- How to perform: Re-click Run/Debug button, or shift-click the 'hot reload' button.
```

----------------------------------------

TITLE: Recommended Flutter Project Directory Structure
DESCRIPTION: This snippet illustrates the recommended package structure for a Flutter application, organizing code into `lib`, `test`, and `testing` folders. It details the subdirectories within `lib` for `ui` (feature-based), `domain` (models), and `data` (repositories, services, API models), along with `config`, `utils`, `routing`, and main entry points. It also shows the structure for `test` (unit/widget tests) and `testing` (mocks/utilities).
SOURCE: https://docs.flutter.dev/app-architecture/case-study

LANGUAGE: Project Structure
CODE:
```
lib
├─┬─ ui
│ ├─┬─ core
│ │ ├─┬─ ui
│ │ │ └─── <shared widgets>
│ │ └─── themes
│ └─┬─ <FEATURE NAME>
│   ├─┬─ view_model
│   │ └─── <view_model class>.dart
│   └─┬─ widgets
│     ├── <feature name>_screen.dart
│     └── <other widgets>
├─┬─ domain
│ └─┬─ models
│   └─── <model name>.dart
├─┬─ data
│ ├─┬─ repositories
│ │ └─── <repository class>.dart
│ ├─┬─ services
│ │ └─── <service class>.dart
│ └─┬─ model
│   └─── <api model class>.dart
├─── config
├─── utils
├─── routing
├─── main_staging.dart
├─── main_development.dart
└─── main.dart

// The test folder contains unit and widget tests
test
├─── data
├─── domain
├─── ui
└─── utils

// The testing folder contains mocks other classes need to execute tests
testing
├─── fakes
└─── models
```

----------------------------------------

TITLE: Flutter: Calling showDialog in build method (Problematic)
DESCRIPTION: This snippet demonstrates a common anti-pattern in Flutter where `showDialog` is called directly within the `build` method. This indirectly triggers `setState` during the build phase, leading to the 'setState() or markNeedsBuild() called during build' error. This approach is problematic because the `build` method can be invoked frequently by the framework.
SOURCE: https://docs.flutter.dev/testing/common-errors

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  // Don't do this.
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(title: Text('Alert Dialog'));
    },
  );

  return const Center(
    child: Column(children: <Widget>[Text('Show Material Dialog')]),
  );
}
```

----------------------------------------

TITLE: Pushing a new screen onto the Navigator stack
DESCRIPTION: This Dart code snippet demonstrates how to navigate to a new screen using Navigator.of(context).push(). It utilizes MaterialPageRoute to define the new screen (SecondScreen) and handles the platform-specific transition animations, effectively adding the new screen to the navigation history stack.
SOURCE: https://docs.flutter.dev/ui/navigation

LANGUAGE: dart
CODE:
```
child: const Text('Open second screen'),
onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const SecondScreen()),
  );
}
```

----------------------------------------

TITLE: Create a Scaffold for a Flutter Material App
DESCRIPTION: This snippet demonstrates how to set up a basic Flutter application with a `MaterialApp` and a `Scaffold`. The `Scaffold` widget provides the fundamental visual structure for Material Design apps, ensuring elements like `SnackBar` are positioned correctly without overlapping other widgets.
SOURCE: https://docs.flutter.dev/cookbook/design/snackbars

LANGUAGE: dart
CODE:
```
return MaterialApp(
  title: 'SnackBar Demo',
  home: Scaffold(
    appBar: AppBar(title: const Text('SnackBar Demo')),
    body: const SnackBarPage(),
  ),
);
```

----------------------------------------

TITLE: Flutter StatelessWidget: Building UI
DESCRIPTION: Explains how StatelessWidget defines its UI by overriding the build() method, which returns a new element tree representing the widget's part of the user interface. Emphasizes that build functions should be free of side effects and return quickly.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: APIDOC
CODE:
```
Class: StatelessWidget
  Description: A widget that has no mutable state; its properties do not change over time.
  Methods:
    build(BuildContext context):
      Description: Determines the visual representation of the widget by returning a new element tree.
      Parameters:
        context: The BuildContext for the widget.
      Return Type: Widget
      Constraints: Should be free of side effects and return quickly.
```

----------------------------------------

TITLE: Complete Flutter HTTP GET and DELETE Example with FutureBuilder
DESCRIPTION: This comprehensive Flutter example demonstrates how to perform asynchronous HTTP GET and DELETE requests using the `http` package. It includes data model definition, JSON parsing, error handling, and integrates network operations with the UI using `FutureBuilder` to display fetched data and trigger deletion.
SOURCE: https://docs.flutter.dev/cookbook/networking/delete-data

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then return an empty Album. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.empty();
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

class Album {
  int? id;
  String? title;

  Album({this.id, this.title});

  Album.empty();

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title} => Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Delete Data Example')),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              // If the connection is done,
              // check for response data or an error.
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.title ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum = deleteAlbum(
                              snapshot.data!.id.toString(),
                            );
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implement exit confirmation for Flutter app bar back button
DESCRIPTION: This snippet shows how to prompt the user for confirmation before exiting a setup flow, especially when the back arrow in the app bar or the device's hardware back button is pressed. It uses `PopScope` and an `AlertDialog` to prevent accidental loss of progress.
SOURCE: https://docs.flutter.dev/cookbook/effects/nested-nav

LANGUAGE: dart
CODE:
```
Future<void> _onExitPressed() async {
  final isConfirmed = await _isExitDesired();

  if (isConfirmed && mounted) {
    _exitSetup();
  }
}

Future<bool> _isExitDesired() async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'If you exit device setup, your progress will be lost.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Leave'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Stay'),
              ),
            ],
          );
        },
      ) ??
      false;
}

void _exitSetup() {
  Navigator.of(context).pop();
}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) async {
      if (didPop) return;

      if (await _isExitDesired() && context.mounted) {
        _exitSetup();
      }
    },
    child: Scaffold(appBar: _buildFlowAppBar(), body: const SizedBox()),
  );
}

PreferredSizeWidget _buildFlowAppBar() {
  return AppBar(
    leading: IconButton(
      onPressed: _onExitPressed,
      icon: const Icon(Icons.chevron_left),
    ),
    title: const Text('Bulb Setup'),
  );
}
```

----------------------------------------

TITLE: Display Validation Errors for Flutter Text Fields
DESCRIPTION: This comprehensive example shows how to implement dynamic validation error messages for a TextField in Flutter. It demonstrates updating the errorText property of InputDecoration based on user input and includes a full application structure with state management and a basic email validation function.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: TextField(
          onSubmitted: (text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'This is a hint',
            errorText: _getErrorText(),
          ),
        ),
      ),
    );
  }

  String? _getErrorText() {
    return _errorText;
  }

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[]\\.,;:\s@\"]+(\.[^<>()[]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }
}
```

----------------------------------------

TITLE: Implement State and State Management in Flutter
DESCRIPTION: This code defines the State class '_MyStatefulWidgetState' for 'MyStatefulWidget'. It includes mutable state variables and a 'toggleBlinkState' method that uses setState() to update the UI when the state changes, demonstrating how Flutter rebuilds widgets.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool showText = true;
  bool toggleState = true;
  Timer? t2;

  void toggleBlinkState() {
    setState(() {
      toggleState = !toggleState;
    });
    if (!toggleState) {
```

----------------------------------------

TITLE: Create Scrollable Views in Flutter using ListView
DESCRIPTION: Flutter's ListView widget serves as both a ScrollView and a traditional Android ListView, providing an easy way to display a scrollable list of widgets when content exceeds screen size.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

----------------------------------------

TITLE: Material Design Flutter App Layout with Scaffold Widget
DESCRIPTION: Illustrates how to build a Flutter application following Material Design principles using the `Scaffold` widget. `Scaffold` provides a default app bar, background color, and APIs for additional UI components like drawers and snack bars, simplifying the creation of a Material-themed home page.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter UI Structure with Asynchronous Data Loading via Isolates
DESCRIPTION: This comprehensive Flutter snippet demonstrates building a `StatefulWidget` with a `ListView` to display data. It includes advanced asynchronous data fetching using Dart Isolates to perform network requests in the background, preventing UI freezes, and updating the UI with `setState`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  Future<void> loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    SendPort sendPort = await receivePort.first as SendPort;

    final msg =
        await sendReceive(
              sendPort,
              'https://jsonplaceholder.typicode.com/posts',
            )
            as List<Object?>;

    setState(() {
      widgets = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0] as String;
      SendPort replyTo = msg[1] as SendPort;

      String dataURL = data;
      http.Response response = await http.get(Uri.parse(dataURL));
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future<Object?> sendReceive(SendPort port, Object? msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }

}
```

----------------------------------------

TITLE: Complete Flutter Example for Fetching and Updating Data
DESCRIPTION: This comprehensive Flutter example demonstrates how to fetch data from a REST API, update it, and display it in a user interface. It includes asynchronous functions for fetching and updating an 'Album' object, a model class for 'Album' with JSON deserialization, and a 'StatefulWidget' that manages the UI. The UI features a 'TextField' for user input and an 'ElevatedButton' to trigger data updates, showing a loading indicator while operations are in progress.
SOURCE: https://docs.flutter.dev/cookbook/networking/update-data

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'title': title}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title} => Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Update Data Example')),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data!.title),
                      TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter Title',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = updateAlbum(_controller.text);
                          });
                        },
                        child: const Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Integrate StatelessWidget into Flutter Widget Tree
DESCRIPTION: This Dart example demonstrates how to define a `StatelessWidget` (MyStatelessWidget) and integrate another widget (MyStatefulWidget) into the application's widget tree using `MaterialApp`. It serves as the root of a Flutter application, showcasing basic app setup and widget inclusion.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: dart
CODE:
```
class MyStatelessWidget extends StatelessWidget {
  // This widget is the root of your application.
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyStatefulWidget(title: 'State Change Demo'),
    );
  }
}
```

----------------------------------------

TITLE: Implement a Checkbox in Flutter
DESCRIPTION: Demonstrates how to create and manage the state of a Checkbox widget in Flutter, allowing users to toggle a boolean value. It uses `setState` to update the `isChecked` variable when the checkbox is toggled.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
bool isChecked = false;

@override
Widget build(BuildContext context) {
  return Checkbox(
    checkColor: Colors.white,
    value: isChecked,
    onChanged: (bool? value) {
      setState(() {
        isChecked = value!;
      });
    },
  );
}
```

----------------------------------------

TITLE: Decode JSON string to Dart object using json_serializable
DESCRIPTION: Demonstrates how to decode a JSON string into a Dart object by calling the `fromJson` factory method generated by `json_serializable`.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
final user = User.fromJson(userMap);
```

----------------------------------------

TITLE: Implement a Flutter Form with Input Validation
DESCRIPTION: This Dart code snippet demonstrates how to create a Flutter `Form` widget using a `GlobalKey` for state management. It includes a `TextFormField` for email input with basic validation and an `ElevatedButton` to trigger the validation process. The `validator` function checks for empty input, and `_formKey.currentState!.validate()` is used to perform validation on button press.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your email',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // Process data.
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    ),
  );
}
```

----------------------------------------

TITLE: Implement HTTP POST Request to Create Album in Dart
DESCRIPTION: This function sends an HTTP POST request to a specified endpoint to create a new album with a given title. It sets the 'Content-Type' header and encodes the title as JSON in the request body. Upon receiving a 201 CREATED status code, it parses the JSON response into an Album object using the 'fromJson' factory. Otherwise, it throws an Exception, ensuring proper error handling and preventing null returns.
SOURCE: https://docs.flutter.dev/cookbook/networking/send-data

LANGUAGE: dart
CODE:
```
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'title': title}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
```

----------------------------------------

TITLE: Flutter: Distributing Space with Expanded Flex Property
DESCRIPTION: Illustrates how to use the `flex` property of the `Expanded` widget to assign relative space to children within a `Row` or `Column`. By setting `flex` to a value greater than 1, a widget can occupy a proportionally larger share of the available space compared to its siblings.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return const Row(
    children: [
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        flex: 2,
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
    ],
  );
}
```

----------------------------------------

TITLE: Declare Variables in Dart
DESCRIPTION: Demonstrates how to declare variables in Dart, showing both explicit type declaration using `String` and type inference using `var` for string types. Dart variables are strongly typed.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
String name = 'dart'; // Explicitly typed as a [String].
var otherName = 'Dart'; // Inferred [String] type.
```

----------------------------------------

TITLE: Flutter State.setState Method API Reference
DESCRIPTION: The `setState()` method is crucial for updating the UI in a `StatefulWidget`. It notifies the Flutter framework that the internal state of the object has changed, marking the widget as dirty and scheduling it to be rebuilt. Forgetting to call `setState` after modifying state will prevent the UI from updating.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
State.setState(fn: VoidCallback): void
  fn: A callback function containing the state changes. The framework calls `build` after the callback completes.
```

----------------------------------------

TITLE: Declare and Assign Variables in Dart and JavaScript
DESCRIPTION: Dart is a type-safe language, enforcing type matching through static and runtime checks, though type inference can make annotations optional. In contrast, JavaScript variables are dynamically typed and do not require explicit type declarations, offering more flexibility but less compile-time safety.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: javascript
CODE:
```
// JavaScript
let name = 'JavaScript';
```

LANGUAGE: dart
CODE:
```
/// Dart
/// Both variables are acceptable.
```

----------------------------------------

TITLE: Flutter Widget: Container
DESCRIPTION: A convenience widget that combines common painting, positioning, and sizing widgets.
SOURCE: https://docs.flutter.dev/ui/widgets/layout

LANGUAGE: APIDOC
CODE:
```
Container Class:
  Description: A convenience widget that combines common painting, positioning, and sizing widgets.
  API Reference: https://api.flutter.dev/flutter/widgets/Container-class.html
```

----------------------------------------

TITLE: Display Asynchronous Album Data with FutureBuilder in Flutter
DESCRIPTION: Illustrates using the `FutureBuilder` widget to display the `Album` data. It handles different states of the `Future` (loading, success, error) by showing a `CircularProgressIndicator` during loading, the album title on success, or an error message on failure, based on the `snapshot` state.
SOURCE: https://docs.flutter.dev/cookbook/networking/fetch-data

LANGUAGE: Dart
CODE:
```
FutureBuilder<Album>(
  future: futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.title);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
)
```

----------------------------------------

TITLE: Basic Flutter App Structure with Widget Composition
DESCRIPTION: This Dart code snippet demonstrates a minimal Flutter application, illustrating the core concept of widget composition. It shows how various widgets like MaterialApp, Scaffold, AppBar, Text, Center, Column, SizedBox, and ElevatedButton are nested to create a simple UI, highlighting the hierarchical structure of Flutter applications.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/widgets

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Root widget
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  const Text('Hello, World!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('A button'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter AnimationController API Reference
DESCRIPTION: The AnimationController is a specialized Animation object in Flutter that generates values for animation frames. It typically interpolates from 0.0 to 1.0 over a specified duration and requires a vsync provider to optimize resource usage. It offers methods like forward() to start the animation and fling() for physics-based animations.
SOURCE: https://docs.flutter.dev/ui/animations/index

LANGUAGE: APIDOC
CODE:
```
class AnimationController extends Animation<double> {
  // Constructor
  AnimationController({
    required Duration duration,
    required TickerProvider vsync,
    // ... other optional parameters
  });

  // Methods
  void forward();
  void fling({double velocity, Force force, double? position});

  // Properties
  double get value; // Inherited from Animation<double>
}
```

----------------------------------------

TITLE: Define DemoLocalizations Class for Flutter App Localization
DESCRIPTION: This Dart class, `DemoLocalizations`, encapsulates the localized strings for a Flutter application. It uses the `intl` package's `initializeMessages()` function for loading messages and `Intl.message()` for looking up translated strings based on the current locale. It provides static methods for loading and accessing localized resources within the app context, ensuring proper internationalization.
SOURCE: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

LANGUAGE: dart
CODE:
```
class DemoLocalizations {
  DemoLocalizations(this.localeName);

  static Future<DemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return DemoLocalizations(localeName);
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}
```

----------------------------------------

TITLE: Implement Flutter HomePage with Scaffold Layout
DESCRIPTION: This Dart snippet demonstrates the `HomePage` widget, which uses a `Scaffold` to provide a basic visual structure for the app screen. Inside the `Scaffold`'s body, it centers a `Text` widget displaying 'Hello, World!'. `Scaffold` is fundamental for implementing Material Design layouts in Flutter.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: dart
CODE:
```
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Common @JsonKey Annotations for JSON Serialization in Dart
DESCRIPTION: Illustrates the usage of `defaultValue`, `required`, and `ignore` parameters within the `@JsonKey` annotation to handle missing keys, enforce required fields, or exclude fields from serialization.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
/// Tell json_serializable to use "defaultValue" if the JSON doesn't
/// contain this key or if the value is `null`.
@JsonKey(defaultValue: false)
final bool isAdult;

/// When `true` tell json_serializable that JSON must contain the key,
/// If the key doesn't exist, an exception is thrown.
@JsonKey(required: true)
final String id;

/// When `true` tell json_serializable that generated code should
/// ignore this field completely.
@JsonKey(ignore: true)
final String verificationCode;
```

----------------------------------------

TITLE: Flutter StatefulWidget and State: Managing Mutable UI
DESCRIPTION: Describes StatefulWidget for widgets whose characteristics change over time, such as due to user interaction. Explains that mutable state is stored in a separate State class, and setState() must be called to signal the framework to rebuild the UI when state changes.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: APIDOC
CODE:
```
Class: StatefulWidget
  Description: A widget whose unique characteristics need to change based on user interaction or other factors. It stores mutable state in a separate State class.
  Methods:
    createState():
      Description: Creates the mutable state for this widget at a given location in the tree.
      Return Type: State<StatefulWidget>

Class: State<T extends StatefulWidget>
  Description: The mutable state for a StatefulWidget. The user interface for a StatefulWidget is built through its State object.
  Methods:
    setState(VoidCallback fn):
      Description: Notifies the framework that the internal state of this object has changed, which causes the framework to schedule a rebuild of this State object.
      Parameters:
        fn: A callback function that updates the state.
      Return Type: void
      Constraints: Must be called whenever the State object is mutated to update the UI.
    build(BuildContext context):
      Description: Describes the part of the user interface represented by this widget.
      Parameters:
        context: The BuildContext for the widget.
      Return Type: Widget
```

----------------------------------------

TITLE: Flutter Example: Displaying Progress Indicator for Network Data Loading
DESCRIPTION: This Dart code provides a complete Flutter application demonstrating how to show a `CircularProgressIndicator` while fetching data from a network API (jsonplaceholder.typicode.com/posts). It uses a `StatefulWidget` to manage the loading state, displaying the progress indicator when data is empty and switching to a `ListView` once data is loaded. The `loadData` method performs the asynchronous network request and updates the UI using `setState`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget getBody() {
    bool showLoadingDialog = widgets.isEmpty;
    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  Future<void> loadData() async {
    final dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(dataURL);
    setState(() {
      widgets = (jsonDecode(response.body) as List)
          .cast<Map<String, Object?>>();
    });
  }
}
```

----------------------------------------

TITLE: Perform Asynchronous Network Request in Flutter
DESCRIPTION: Illustrates how to use Dart's async/await to perform a network request without blocking the main UI thread, similar to runOnUiThread in Android. After data is fetched, setState() is called to update the UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(dataURL);
  setState(() {
    widgets = (jsonDecode(response.body) as List)
        .cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: ListView Widget API Documentation
DESCRIPTION: A scrollable, linear list of widgets. ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction....
SOURCE: https://docs.flutter.dev/ui/widgets/scrolling

LANGUAGE: APIDOC
CODE:
```
ListView
```

----------------------------------------

TITLE: Implement Asynchronous Data Loading and UI Notification in Flutter ViewModel
DESCRIPTION: This code demonstrates the `_load` method within `HomeViewModel`, responsible for asynchronously fetching data from repositories. It updates the view model's internal state based on the fetched data and ensures `notifyListeners()` is called in a `finally` block to inform the UI of state changes, triggering a re-render.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: dart
CODE:
```
class HomeViewModel extends ChangeNotifier {
  // ...

 Future<Result> _load() async {
    try {
      final userResult = await _userRepository.getUser();
      switch (userResult) {
        case Ok<User>():
          _user = userResult.value;
          _log.fine('Loaded user');
        case Error<User>():
          _log.warning('Failed to load user', userResult.error);
      }

      // ...

      return userResult;
    } finally {
      notifyListeners();
    }
  }
}
```

----------------------------------------

TITLE: Flutter Project Pubspec.yaml Full Example
DESCRIPTION: This comprehensive example showcases a typical `pubspec.yaml` file for a basic Flutter application. It defines project metadata, specifies SDK and package dependencies, and configures Flutter-specific elements such as assets, fonts, and material design usage. This file is crucial for project setup and build processes.
SOURCE: https://docs.flutter.dev/tools/pubspec

LANGUAGE: yaml
CODE:
```
name: <project name>
description: A new Flutter project.

publish_to: none
version: 1.0.0+1

environment:
  sdk: ^3.8.0

dependencies:
  flutter:       # Required for every Flutter project
    sdk: flutter # Required for every Flutter project
  flutter_localizations: # Required to enable localization
    sdk: flutter         # Required to enable localization

  cupertino_icons: ^1.0.8 # Only required if you use Cupertino (iOS style) icons

dev_dependencies:
  flutter_test:
    sdk: flutter # Required for a Flutter project that includes tests

  flutter_lints: ^6.0.0 # Contains a set of recommended lints for Flutter code

flutter:

  uses-material-design: true # Required if you use the Material icon font

  generate: true # Enables generation of localized strings from arb files

  config: # App-specific configuration flags that mirror flutter config
    enable-swift-package-manager: true

  assets:  # Lists assets, such as image files
    - images/a_dot_burr.png
    - images/a_dot_ham.png

  fonts:              # Required if your app uses custom fonts
    - family: Schyler
      fonts:
        - asset: fonts/Schyler-Regular.ttf
        - asset: fonts/Schyler-Italic.ttf
          style: italic
    - family: Trajan Pro
      fonts:
        - asset: fonts/TrajanPro.ttf
        - asset: fonts/TrajanPro_Bold.ttf
          weight: 700
```

----------------------------------------

TITLE: Efficiently update Flutter ListView using ListView.builder
DESCRIPTION: This example demonstrates the recommended and efficient way to dynamically update a Flutter ListView using `ListView.builder`. It's suitable for large and dynamic datasets, similar to Android's RecyclerView, as it recycles list elements. The `ItemBuilder` function efficiently renders rows, and new items are added directly to the list without recreating the entire list object, improving performance.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(padding: const EdgeInsets.all(10), child: Text('Row $i')),
    );
  }
}
```

----------------------------------------

TITLE: Define User Model Class for Manual JSON Serialization
DESCRIPTION: This Dart code defines a `User` class with `name` and `email` fields. It includes a `User.fromJson()` constructor to instantiate a `User` object from a `Map<String, dynamic>` (parsed JSON) and a `toJson()` method to convert the `User` object back into a `Map` for JSON encoding. This approach ensures type safety and compile-time error checking for data fields.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      email = json['email'] as String;

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
```

----------------------------------------

TITLE: Dart: Loading ToDo Items in ViewModel
DESCRIPTION: This method in `TodoListViewModel` fetches the list of ToDo items from `TodoRepository`. It handles success and error cases using a `Result` type and notifies listeners upon completion.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/sql

LANGUAGE: dart
CODE:
```
List<Todo> _todos = [];

List<Todo> get todos => _todos;

Future<Result<void>> _load() async {
  try {
    final result = await _todoRepository.fetchTodos();
    switch (result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        return Result.ok(null);
      case Error():
        return Result.error(result.error);
    }
  } on Exception catch (e) {
    return Result.error(e);
  } finally {
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Define a StatefulWidget in Flutter
DESCRIPTION: This snippet defines a basic StatefulWidget named 'MyStatefulWidget'. It includes a constructor to pass data (like a title) and overrides the createState method to link it with its corresponding State class.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});

  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
```

----------------------------------------

TITLE: HomeViewModel Unit Test for Loading Bookings
DESCRIPTION: This Dart unit test demonstrates how to test the UI logic of a HomeViewModel. It uses a faked `FakeBookingRepository` to simulate data interactions, ensuring the test does not rely on Flutter libraries or external dependencies. The test verifies that bookings are loaded correctly into the view model.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/testing

LANGUAGE: dart
CODE:
```
void main() {
  group('HomeViewModel tests', () {
    test('Load bookings', () {
      // HomeViewModel._load is called in the constructor of HomeViewModel.
      final viewModel = HomeViewModel(
        bookingRepository: FakeBookingRepository()
          ..createBooking(kBooking),
        userRepository: FakeUserRepository(),
      );

      expect(viewModel.bookings.isNotEmpty, true);
    });
  });
}
```

----------------------------------------

TITLE: Flutter Nested Containers Sizing with Center
DESCRIPTION: Demonstrates how a parent Container without a fixed size will size itself to its child's size when wrapped by a Center widget. The inner green Container has a fixed size (30x30), causing the outer red Container to match its size, making the red color invisible.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Center(
   child: Container(color: red
      child: Container(color: green, width: 30, height: 30)))
```

----------------------------------------

TITLE: Defining a Custom InheritedWidget (MyState)
DESCRIPTION: This Dart code defines `MyState`, a custom `InheritedWidget`. It holds a `data` string and provides a static `of()` method to retrieve the nearest `MyState` instance from the context. The `updateShouldNotify` method ensures dependent widgets rebuild only when the data changes.
SOURCE: https://docs.flutter.dev/get-started/fwe/state-management

LANGUAGE: dart
CODE:
```
class MyState extends InheritedWidget {
  const MyState({
    super.key,
    required this.data,
    required super.child,
  });

  final String data;

  static MyState of(BuildContext context) {
    // This method looks for the nearest `MyState` widget ancestor.
    final result = context.dependOnInheritedWidgetOfExactType<MyState>();

    assert(result != null, 'No MyState found in context');

    return result!;
  }

  @override
  // This method should return true if the old widget's data is different
  // from this widget's data. If true, any widgets that depend on this widget
  // by calling `of()` will be re-built.
  bool updateShouldNotify(MyState oldWidget) => data != oldWidget.data;
}
```

----------------------------------------

TITLE: Implement a Basic Tab Bar in Flutter
DESCRIPTION: This Dart code snippet demonstrates how to create a simple tabbed interface in a Flutter application. It uses a `DefaultTabController` to manage the tabs, an `AppBar` with a `TabBar` for navigation, and a `TabBarView` to display content corresponding to each tab. The example shows three tabs with icons for car, transit, and bike.
SOURCE: https://docs.flutter.dev/cookbook/design/tabs

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Fixing 'Vertical viewport was given unbounded height' with Expanded
DESCRIPTION: This Dart code snippet demonstrates how to resolve the 'Vertical viewport was given unbounded height' error. By wrapping the `ListView` with an `Expanded` widget, it is constrained to take up the remaining available vertical space within the `Column`, thereby providing the necessary bounds and allowing the UI to render correctly.
SOURCE: https://docs.flutter.dev/testing/common-errors

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        const Text('Header'),
        Expanded(
          child: ListView(
            children: const <Widget>[
              ListTile(leading: Icon(Icons.map), title: Text('Map')),
              ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
            ],
          ),
        ),
      ],
    ),
  );
}
```

----------------------------------------

TITLE: Flutter ThemeData Class and Properties
DESCRIPTION: API documentation for the `ThemeData` class in Flutter, which is used to define the visual styling for a Material app. It outlines key properties like `colorScheme` for defining app-wide colors and `textTheme` for setting default text styles, both crucial for consistent UI design.
SOURCE: https://docs.flutter.dev/cookbook/design/themes

LANGUAGE: APIDOC
CODE:
```
ThemeData Class:
  Purpose: Defines the visual styling for a Material app.
  Usage: Set as the 'theme' property of a MaterialApp constructor.

  Properties:
    colorScheme:
      Type: ColorScheme
      Description: Defines the default brightness and colors for the app.
      Reference: https://api.flutter.dev/flutter/material/ThemeData/colorScheme.html

    textTheme:
      Type: TextTheme
      Description: Defines the default text styling for headlines, titles, bodies of text, and more.
      Reference: https://api.flutter.dev/flutter/material/ThemeData/textTheme.html
```

----------------------------------------

TITLE: Display List Items with Flutter ListView.builder
DESCRIPTION: This example illustrates the basic usage of `ListView.builder` in Flutter for efficiently displaying a list of items. The `itemBuilder` callback is invoked for each item, providing the `BuildContext` and the item's index, which is used to retrieve and display data from a `ToDo` object within a `Row` widget.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
final List<ToDo> items = Repository.fetchTodos();

Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, idx) {
      var item = items[idx];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.description),
            Text(item.isComplete),
          ],
        ),
      );
    },
  );
}
```

----------------------------------------

TITLE: Verify Widget Presence in Flutter Test with Matcher
DESCRIPTION: Shows how to use `Matcher` constants, such as `findsOneWidget`, provided by `flutter_test` to verify that the located widgets appear on screen as expected. This step confirms the correct rendering and presence of UI elements.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/introduction

LANGUAGE: dart
CODE:
```
void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

----------------------------------------

TITLE: Migrating Navigator Page APIs
DESCRIPTION: Demonstrates the migration from the deprecated `onPopPage` property to the new `onDidRemovePage` property and the use of `Page.canPop` for controlling pop behavior in Flutter's Navigator API. The 'before' example shows how `onPopPage` was used to veto a pop, while the 'after' example illustrates the updated approach using `onDidRemovePage` for page removal and `Page.canPop` for pop prevention.
SOURCE: https://docs.flutter.dev/release/breaking-changes/navigator-and-page-api

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

final MaterialPage<void> page1 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page2 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page3 = MaterialPage<void>(child: Placeholder());

void main() {
  final List<Page<void>> pages = <Page<void>>[page1, page2, page3];
  runApp(
    MaterialApp(
      home: Navigator(
        pages: pages,
        onPopPage: (Route<Object?> route, Object? result) {
          if (route.settings == page2) {
            return false;
          }
          if (route.didPop) {
            pages.remove(route.settings);
            return true;
          }
          return false;
        },
      ),
    ),
  );
}
```

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

final MaterialPage<void> page1 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page2 = MaterialPage<void>(canPop: false, child: Placeholder());
final MaterialPage<void> page3 = MaterialPage<void>(child: Placeholder());

void main() {
  final List<Page<void>> pages = <Page<void>>[page1, page2, page3];
  runApp(
    MaterialApp(
      home: Navigator(
        pages: pages,
        onDidRemovePage: (Page<Object?> page) {
          pages.remove(page);
        },
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Using shared_preferences in a Flutter Background Isolate
DESCRIPTION: Demonstrates how to initialize and use a Flutter platform plugin, specifically `shared_preferences`, within a background isolate. This prevents UI thread blocking for platform-dependent computations by utilizing `BackgroundIsolateBinaryMessenger` to register the background isolate with the root isolate.
SOURCE: https://docs.flutter.dev/perf/isolates

LANGUAGE: dart
CODE:
```
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Identify the root isolate to pass to the background isolate.
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  Isolate.spawn(_isolateMain, rootIsolateToken);
}

Future<void> _isolateMain(RootIsolateToken rootIsolateToken) async {
  // Register the background isolate with the root isolate.
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // You can now use the shared_preferences plugin.
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  print(sharedPreferences.getBool('isDebug'));
}
```

----------------------------------------

TITLE: Manage Flutter Widget State with Lifecycle Methods
DESCRIPTION: Explains the core lifecycle methods of a Flutter State object: initState() for one-time setup after creation, and dispose() for cleanup before removal. It highlights their purpose, typical usage, and the requirement to call super in implementations.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
StatefulWidget:
  createState(): Creates the mutable state for this widget at a given location in the tree.

State:
  initState():
    Purpose: Called exactly once when the State object is first created.
    Usage: Override to perform one-time initialization, such as configuring animations, subscribing to platform services, or initializing data.
    Requirement: Must call super.initState() as the first line.
  dispose():
    Purpose: Called when this State object will never build again.
    Usage: Override to perform cleanup work, such as canceling timers, unsubscribing from platform services, or releasing resources.
    Requirement: Typically ends by calling super.dispose().
```

----------------------------------------

TITLE: Accessing InheritedWidget Data in Flutter
DESCRIPTION: Shows how to access data from an `InheritedWidget` (like `StudentState`) using the `of(context)` method. This method takes the build context and returns the nearest ancestor of the specified type in the widget tree.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: dart
CODE:
```
final studentState = StudentState.of(context);
```

----------------------------------------

TITLE: Flutter Example: Returning Data from a Selection Screen
DESCRIPTION: This comprehensive Flutter example demonstrates how to navigate from a HomeScreen to a SelectionScreen and receive data back. The HomeScreen uses a SelectionButton to launch the SelectionScreen, awaiting a result from Navigator.pop. The SelectionScreen provides options that, when pressed, close the screen and return a string value. The example also correctly handles asynchronous context checks using `context.mounted` and displays the returned data using a SnackBar.
SOURCE: https://docs.flutter.dev/cookbook/navigation/returning-data

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Returning Data', home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Returning Data Demo')),
      body: const Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick an option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Yep!');
                },
                child: const Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Nope." as the result.
                  Navigator.pop(context, 'Nope.');
                },
                child: const Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: ConstrainedBox: Child Larger Than Max Constraints
DESCRIPTION: Center allows ConstrainedBox to be any size up to the screen size.The ConstrainedBox imposes ADDITIONAL constraints from its 'constraints' parameter onto its child

The Container must be between 70 and 150 pixels. It wants to have 1000 pixels, so it ends up having 150 (the MAXIMUM).
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
                 minWidth: 70, minHeight: 70,
                 maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 1000, height: 1000))))
```

----------------------------------------

TITLE: Flutter Material AlertDialog Widget API Reference
DESCRIPTION: Provides a high-level description of the Flutter Material AlertDialog widget, outlining its purpose and typical usage.
SOURCE: https://docs.flutter.dev/ui/widgets/material

LANGUAGE: APIDOC
CODE:
```
AlertDialog:
  Description: Hovering containers that prompt app users to provide more data or make a decision.
```

----------------------------------------

TITLE: Good Example: Declarative Widget Build with Current State
DESCRIPTION: Illustrates how a widget's build method should declaratively construct the UI based on the current state. The widget simply declares what to show for any given state, without needing imperative update methods.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
// GOOD
Widget build(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context);
  return SomeWidget(
    // Just construct the UI once, using the current state of the cart.
    // ···
  );
}
```

----------------------------------------

TITLE: Subclassing StatefulWidget in Flutter
DESCRIPTION: This snippet demonstrates how to create a StatefulWidget by extending the StatefulWidget class. It shows the override of the createState() method, which is responsible for returning an instance of the associated State object, allowing the framework to build the widget and manage its mutable state.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: dart
CODE:
```
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}
```

----------------------------------------

TITLE: Efficiently Update Flutter ListView with ListView.builder
DESCRIPTION: This example illustrates the recommended and efficient way to build and update a Flutter ListView using `ListView.builder`. This method is ideal for dynamic lists or very large datasets, similar to Android's RecyclerView, as it automatically recycles list elements. The `onTap()` function demonstrates adding new items without recreating the entire list.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('Row $index');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $index'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Add `url_launcher` package dependency to Flutter project
DESCRIPTION: Demonstrates how to add the `url_launcher` package as a dependency to a Flutter project using the `flutter pub add` command. This command automatically updates the `pubspec.yaml` file and fetches the necessary packages.
SOURCE: https://docs.flutter.dev/testing/native-debugging

LANGUAGE: Shell
CODE:
```
flutter pub add url_launcher
```

----------------------------------------

TITLE: Complete Flutter Video Player Implementation
DESCRIPTION: This comprehensive Flutter application demonstrates how to integrate and control video playback using the `video_player` package. It initializes a `VideoPlayerController` from a network URL, manages its lifecycle (initialization, looping, disposal), and displays the video within an `AspectRatio` widget. A `FutureBuilder` handles the loading state, and a `FloatingActionButton` provides play/pause functionality.
SOURCE: https://docs.flutter.dev/cookbook/plugins/play-video

LANGUAGE: Dart
CODE:
```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Butterfly Video')),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Minimal Flutter 'Hello, world!' App
DESCRIPTION: This snippet demonstrates the simplest possible Flutter application. It uses `runApp()` to make a `Center` widget containing a `Text` widget the root of the widget tree, displaying 'Hello, world!' centered on the screen. It also highlights the need to specify `textDirection` when `MaterialApp` is not used and introduces the concepts of `StatelessWidget` and `StatefulWidget` for building custom widgets.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Flutter: Animating Logo Size with AnimationController
DESCRIPTION: This Flutter snippet modifies the `_LogoAppState` to animate the Flutter logo's size. It introduces `AnimationController` with `SingleTickerProviderStateMixin` for `vsync`, `Tween` for animation range, and `addListener()` with `setState()` to trigger rebuilds based on animation value. The controller is disposed to prevent memory leaks.
SOURCE: https://docs.flutter.dev/ui/animations/tutorial

LANGUAGE: dart
CODE:
```
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

----------------------------------------

TITLE: Complete Example: Fetching and Displaying Data in Flutter
DESCRIPTION: This Dart code snippet provides a full Flutter application demonstrating how to fetch data from a remote API (JSONPlaceholder) using the `http` package. It defines an `Album` model, includes a `fetchAlbum` function for network requests, and uses `FutureBuilder` to asynchronously display the fetched data's title in the UI, complete with loading and error states.
SOURCE: https://docs.flutter.dev/cookbook/networking/fetch-data

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}
```

----------------------------------------

TITLE: Define Flutter MaterialApp Widget for App Structure
DESCRIPTION: This Dart snippet defines the `MyApp` widget, a `StatelessWidget` that serves as the root of a Flutter application's UI. It returns a `MaterialApp`, which provides essential Material Design functionalities and sets the `HomePage` as the initial screen. This structure is common for Flutter apps.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
```

----------------------------------------

TITLE: Displaying Async Data with FutureBuilder in Flutter
DESCRIPTION: This Flutter code snippet demonstrates the use of the FutureBuilder widget to display asynchronous data. It takes a Future (e.g., _futureAlbum) and a builder function. The builder function conditionally renders UI based on the snapshot's state: displaying the data if available, an error message if an error occurred, or a CircularProgressIndicator while loading. It's crucial that the Future resolves with data or throws an exception for correct state management.
SOURCE: https://docs.flutter.dev/cookbook/networking/update-data

LANGUAGE: Dart
CODE:
```
FutureBuilder<Album>(
  future: _futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.title);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    return const CircularProgressIndicator();
  },
);
```

----------------------------------------

TITLE: Implement State for a Stateful Widget with UI Logic
DESCRIPTION: This code implements the `_MyHomePageState` class, which manages the mutable state for `MyHomePage`. It includes a counter, a method to increment it using `setState()` to trigger UI updates, and the `build()` method to construct the UI, demonstrating a basic Flutter page with an app bar, body, and floating action button.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set the appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Run Flutter Doctor in Verbose Mode for Troubleshooting
DESCRIPTION: Execute the `flutter doctor` command with the verbose flag (`-v`) to obtain detailed diagnostic output. This is crucial for identifying the root cause of errors related to your Flutter installation, development tools like VS Code or Android Studio, connected devices, or network configurations. Review the output for specific software requirements or further actions.
SOURCE: https://docs.flutter.dev/get-started/install/windows/mobile

LANGUAGE: PowerShell
CODE:
```
flutter doctor -v
```

----------------------------------------

TITLE: Troubleshoot Flutter doctor issues with verbose output
DESCRIPTION: When `flutter doctor` returns an error, running it with the `-v` (verbose) flag provides more detailed output. This additional information can help diagnose issues related to Flutter, VS Code, Xcode, connected devices, or network resources, aiding in effective troubleshooting.
SOURCE: https://docs.flutter.dev/get-started/install/macos/web

LANGUAGE: bash
CODE:
```
flutter doctor -v
```

----------------------------------------

TITLE: Create new Flutter project
DESCRIPTION: Use the `flutter create` command to initialize a new Flutter application. This command sets up the basic project structure for your app.
SOURCE: https://docs.flutter.dev/cookbook/navigation/set-up-universal-links

LANGUAGE: bash
CODE:
```
flutter create deeplink_cookbook
```

----------------------------------------

TITLE: Complete Flutter App with Async Data Loading
DESCRIPTION: A full Flutter application demonstrating how to integrate asynchronous data loading from a REST API into a StatefulWidget. It fetches data on initialization and displays it in a ListView, showcasing a common pattern for dynamic UI updates.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  Future<void> loadData() async {
    final dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(dataURL);
    setState(() {
      widgets = (jsonDecode(response.body) as List)
          .cast<Map<String, Object?>>();
    });
  }

}
```

----------------------------------------

TITLE: Implement Linear Layouts in Flutter using Row and Column
DESCRIPTION: In Flutter, Row and Column widgets are used to arrange children widgets linearly, either horizontally or vertically, similar to Android's LinearLayout. They support `mainAxisAlignment` to control child positioning.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Column One'),
      Text('Column Two'),
      Text('Column Three'),
      Text('Column Four'),
    ],
  );
}
```

----------------------------------------

TITLE: Listen and Dispose TextEditingController Listeners in Flutter
DESCRIPTION: Explains how to use `addListener()` in `initState()` to begin listening for text changes on a `TextEditingController`. It also reiterates the importance of removing the listener in `dispose()` to prevent memory leaks and ensure efficient resource management.
SOURCE: https://docs.flutter.dev/cookbook/forms/text-field-changes

LANGUAGE: dart
CODE:
```
@override
void initState() {
  super.initState();

  // Start listening to changes.
  myController.addListener(_printLatestValue);
}
```

LANGUAGE: dart
CODE:
```
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  myController.dispose();
  super.dispose();
}
```

----------------------------------------

TITLE: Integrate ImageSection Widget into Flutter Children List
DESCRIPTION: This Dart snippet shows how to incorporate the previously defined `ImageSection` widget into an existing `children` list within a Flutter layout. By placing `ImageSection` as the first child and setting its `image` property to the asset path, the image will be displayed at the top of the layout. This demonstrates how to compose custom widgets into a larger UI structure.
SOURCE: https://docs.flutter.dev/ui/layout/tutorial

LANGUAGE: dart
CODE:
```
children: [
  ImageSection(
    image: 'images/lake.jpg',
  ),
  TitleSection(
    name: 'Oeschinen Lake Campground',
    location: 'Kandersteg, Switzerland',

```

----------------------------------------

TITLE: Defining a View in Flutter with ListenableBuilder
DESCRIPTION: This snippet shows how a Flutter View (widget) can react to changes in a `ChangeNotifier`-based `ViewModel` using `ListenableBuilder`. It demonstrates displaying the count, showing user-friendly error messages from the ViewModel, and triggering ViewModel actions like incrementing the count.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/state-management

LANGUAGE: dart
CODE:
```
ListenableBuilder(
  listenable: viewModel,
  builder: (context, child) {
    return Column(
      children: [
        if (viewModel.errorMessage != null)
          Text(
            'Error: ${viewModel.errorMessage}',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Colors.red),
          ),
        Text('Count: ${viewModel.count}'),
        TextButton(
          onPressed: () {
            viewModel.increment();
          },
          child: Text('Increment'),
        ),
      ],
    );
  },
)
```

----------------------------------------

TITLE: Complete Flutter Example for Passing Data Between Screens
DESCRIPTION: This comprehensive Flutter example demonstrates how to pass data between screens using `Navigator.push` and `RouteSettings`. It defines a `Todo` model, creates a list of `Todo` items, displays them in a `ListView` on a `TodosScreen`, and navigates to a `DetailScreen` when an item is tapped, passing the selected `Todo` object.
SOURCE: https://docs.flutter.dev/cookbook/navigation/passing-data

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          20,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(arguments: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter Row with Expanded Widgets
DESCRIPTION: Demonstrates how `Expanded` widgets within a `Row` distribute available space proportionally based on their flex parameter. Each `Expanded` widget forces its child to fill its allocated width, effectively ignoring the child's preferred size.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Row(
      children: [
        Expanded(
          child: Container(
            color: red,
            child: const Text(
              'This is a very long text that won\'t fit the line.',
              style: big,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: green,
            child: const Text('Goodbye!', style: big),
          ),
        ),
      ],
    )
```

----------------------------------------

TITLE: Write a Basic Unit Test for a Flutter Class
DESCRIPTION: Demonstrates how to create a simple unit test for a Dart class. It shows importing the `test` package, defining a test block with `test()`, and asserting expected values using `expect()` to verify class behavior.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/introduction

LANGUAGE: dart
CODE:
```
// Import the test package and Counter class
import 'package:counter_app/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
```

----------------------------------------

TITLE: Basic Flutter ListView Implementation
DESCRIPTION: Demonstrates the fundamental usage of the ListView widget in Flutter. Similar to Column or Row, ListView arranges children vertically but automatically provides scrolling. It requires its children to take up all available space on the cross axis.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return ListView(
    children: const [
      BorderedImage(),
      BorderedImage(),
      BorderedImage(),
    ],
  );
}
```

----------------------------------------

TITLE: Displaying a simple ListView in Flutter
DESCRIPTION: This snippet demonstrates how to create a basic scrollable list of widgets using Flutter's `ListView`. It shows how to populate the list with dynamically generated `Text` widgets wrapped in `Padding`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    final List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(
        Padding(padding: const EdgeInsets.all(10), child: Text('Row $i')),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: _getListData()),
    );
  }
}
```

----------------------------------------

TITLE: Flutter Widget: Column Layout
DESCRIPTION: The Column widget arranges a list of child widgets vertically. It is fundamental for creating linear vertical layouts in Flutter applications.
SOURCE: https://docs.flutter.dev/ui/widgets/layout

LANGUAGE: APIDOC
CODE:
```
Column:
  Layout a list of child widgets in the vertical direction.
```

----------------------------------------

TITLE: Navigate to Second Screen using Named Route in Flutter
DESCRIPTION: Demonstrates how to navigate from the first screen to a second screen using Navigator.pushNamed() with a named route in Flutter. This method pushes a new route onto the navigation stack, making the second screen active.
SOURCE: https://docs.flutter.dev/cookbook/navigation/named-routes

LANGUAGE: dart
CODE:
```
// Within the `FirstScreen` widget
onPressed: () {
  // Navigate to the second screen using a named route.
  Navigator.pushNamed(context, '/second');
}
```

----------------------------------------

TITLE: Combine Text and Center Widgets in Flutter
DESCRIPTION: Shows how to nest a `Text` widget inside a `Center` widget using the `child` property. This combines a visible widget with a layout widget to center 'Hello World' on the screen.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: dart
CODE:
```
const Center(
  child: Text('Hello World'),
),
```

----------------------------------------

TITLE: Create TextEditingController in Flutter StatefulWidget
DESCRIPTION: Demonstrates how to define a `TextEditingController` within a `StatefulWidget`'s `State` class in Flutter. It includes the essential `dispose` method to ensure proper resource cleanup when the widget is removed from the tree.
SOURCE: https://docs.flutter.dev/cookbook/forms/text-field-changes

LANGUAGE: dart
CODE:
```
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
  }
}
```

----------------------------------------

TITLE: Flutter App Structure with Data Fetching and UI Rendering
DESCRIPTION: This Dart code defines a `StatefulWidget` for a sample Flutter app. It manages data fetching, displays a loading indicator, and renders a `ListView` with parsed data. It also includes inter-isolate communication via `SendPort` for background processing.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
    }
  }

  Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
    final ReceivePort response = ReceivePort();
    port.send(<dynamic>[msg, response.sendPort]);
    return response.first as Future<List<Map<String, dynamic>>>;
  }

  Widget getBody() {
    bool showLoadingDialog = data.isEmpty;

    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
```

----------------------------------------

TITLE: Implementing the Build Method for Flutter State
DESCRIPTION: This snippet illustrates the build() method within the _FavoriteWidgetState class. It constructs the UI for the favorite button, consisting of an IconButton (which responds to taps) and a Text widget displaying the favorite count. The IconButton dynamically changes its icon based on the _isFavorited state and calls _toggleFavorite on press.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: dart
CODE:
```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(width: 18, child: SizedBox(child: Text('$_favoriteCount'))),
      ],
    );
  }

  // ···
}
```

----------------------------------------

TITLE: Text Widget API
DESCRIPTION: Documents a widget that displays a run of text with a single consistent style.
SOURCE: https://docs.flutter.dev/reference/widgets

LANGUAGE: APIDOC
CODE:
```
Text Class:
  Description: A run of text with a single style.
  API Link: https://api.flutter.dev/flutter/widgets/Text-class.html
```

----------------------------------------

TITLE: Flutter Widget Test for Todo List Add/Remove Functionality
DESCRIPTION: This Dart code snippet defines a complete Flutter widget test that verifies the functionality of a `TodoList` widget. It simulates adding a new todo item by entering text and tapping a button, then asserts its presence. Subsequently, it simulates dismissing the item by dragging and asserts its removal from the screen. The snippet also includes the `TodoList` StatefulWidget implementation.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/tap-drag

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add and remove a todo', (tester) async {
    // Build the widget.
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));

    // Rebuild the widget with the new item.
    await tester.pump();

    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);

    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(_appTitle)),
        body: Column(
          children: [
            TextField(controller: controller),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Scaffold Widget API Reference
DESCRIPTION: Documentation for the Scaffold widget, which implements the basic Material Design visual layout structure and provides APIs for showing drawers, snack bars, and bottom sheets.
SOURCE: https://docs.flutter.dev/ui/widgets/basics

LANGUAGE: APIDOC
CODE:
```
Scaffold:
  Description: Implements the basic Material Design visual layout structure. This class provides APIs for showing drawers, snack bars, and bottom sheets.
```

----------------------------------------

TITLE: Flutter Stateful Widget with Separated UI Components
DESCRIPTION: This Dart example refines the counter application by separating the display and incrementing logic into distinct StatelessWidget's (CounterDisplay and CounterIncrementor). The main Counter StatefulWidget still manages the _counter state, but it passes the _counter value down to CounterDisplay and a callback function (_increment) to CounterIncrementor, illustrating how state flows down and events flow up in the widget tree.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: const Text('Increment'));
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CounterIncrementor(onPressed: _increment),
        const SizedBox(width: 16),
        CounterDisplay(count: _counter),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
```

----------------------------------------

TITLE: Column Widget API Reference
DESCRIPTION: Documentation for the Column widget, used to layout a list of child widgets in the vertical direction.
SOURCE: https://docs.flutter.dev/ui/widgets/basics

LANGUAGE: APIDOC
CODE:
```
Column:
  Description: Layout a list of child widgets in the vertical direction.
```

----------------------------------------

TITLE: Define AppBar and Body in Flutter
DESCRIPTION: This snippet shows how to define the `appBar` and `body` properties within a Flutter widget, setting a title for the app bar and an empty container for the body. This is typically part of a `Scaffold` widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
    appBar: AppBar(title: const Text('Home')),
    body: Container(),
  );
```

----------------------------------------

TITLE: Implementing State Toggle Logic in Flutter
DESCRIPTION: This snippet defines the _toggleFavorite() method, which is invoked when the favorite IconButton is pressed. Crucially, it uses setState() to notify the Flutter framework that the widget's internal state (_isFavorited and _favoriteCount) has changed, prompting a redraw of the UI to reflect the updated favorite status and count.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: dart
CODE:
```
void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _favoriteCount -= 1;
      _isFavorited = false;
    } else {
      _favoriteCount += 1;
      _isFavorited = true;
    }
  });
}
```

----------------------------------------

TITLE: Row Widget API Reference
DESCRIPTION: Documentation for the Row widget, used to layout a list of child widgets in the horizontal direction.
SOURCE: https://docs.flutter.dev/ui/widgets/basics

LANGUAGE: APIDOC
CODE:
```
Row:
  Description: Layout a list of child widgets in the horizontal direction.
```

----------------------------------------

TITLE: Center Widget API Documentation
DESCRIPTION: Alignment block that centers its child within itself.
SOURCE: https://docs.flutter.dev/reference/widgets

LANGUAGE: APIDOC
CODE:
```
Center:
  Alignment block that centers its child within itself.
```

----------------------------------------

TITLE: Full Flutter App: Interactive Mixed List Example
DESCRIPTION: This comprehensive Flutter example showcases a `ListView.builder` implementation that displays a mixed list of different item types (headings and messages). It includes the main application setup, `MyApp` widget, and abstract `ListItem` class with concrete `HeadingItem` and `MessageItem` implementations, demonstrating how to render varied content within a single list.
SOURCE: https://docs.flutter.dev/cookbook/lists/mixed-list

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<ListItem>.generate(
        1000,
        (i) => i % 6 == 0
            ? HeadingItem('Heading $i')
            : MessageItem('Sender $i', 'Message body $i'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

```

----------------------------------------

TITLE: Flutter Text Field Focus Management Example
DESCRIPTION: This Flutter application demonstrates how to manage focus for text fields using `FocusNode`. It includes a `StatefulWidget` that initializes and disposes a `FocusNode`, and uses it to shift focus between two `TextField` widgets when a `FloatingActionButton` is pressed. The first text field is automatically focused on app start.
SOURCE: https://docs.flutter.dev/cookbook/forms/focus

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Text Field Focus', home: MyCustomForm());
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Field Focus')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // The first text field is focused on as soon as the app starts.
            const TextField(autofocus: true),
            // The second text field is focused on when a user taps the
            // FloatingActionButton.
            TextField(focusNode: myFocusNode),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the button is pressed,
        // give focus to the text field using myFocusNode.
        onPressed: () => myFocusNode.requestFocus(),
        tooltip: 'Focus Second Text Field',
        child: const Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

----------------------------------------

TITLE: Flutter: Sizing Widgets with Expanded for Equal Distribution
DESCRIPTION: Demonstrates how to use the `Expanded` widget to make child widgets fit within a `Row` or `Column`, preventing overflow errors. Each `Expanded` widget takes an equal share of the available space, ensuring all children are visible and properly sized.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return const Row(
    children: [
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
      Expanded(
        child: BorderedImage(width: 150, height: 150),
      ),
    ],
  );
}
```

----------------------------------------

TITLE: Flutter Optimistic State Subscribe Button Implementation
DESCRIPTION: This Dart code provides a complete Flutter application demonstrating optimistic state. It includes the main `MyApp` widget, a `SubscribeButton` StatefulWidget, its `_SubscribeButtonState`, a `SubscribeButtonStyle` utility class, a `SubscribeButtonViewModel` (ChangeNotifier) for state management, and a `SubscriptionRepository` that simulates an asynchronous network call and throws an exception to trigger the error handling. The example shows how to update the UI optimistically and revert on failure, displaying a Snackbar for errors.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/optimistic-state

LANGUAGE: dart
CODE:
```
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SubscribeButton(
            viewModel: SubscribeButtonViewModel(
              subscriptionRepository: SubscriptionRepository(),
            ),
          ),
        ),
      ),
    );
  }
}

/// A button that simulates a subscription action.
/// For example, subscribing to a newsletter or a streaming channel.
class SubscribeButton extends StatefulWidget {
  const SubscribeButton({super.key, required this.viewModel});

  /// Subscribe button view model.
  final SubscribeButtonViewModel viewModel;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return FilledButton(
          onPressed: widget.viewModel.subscribe,
          style: widget.viewModel.subscribed
              ? SubscribeButtonStyle.subscribed
              : SubscribeButtonStyle.unsubscribed,
          child: widget.viewModel.subscribed
              ? const Text('Subscribed')
              : const Text('Subscribe'),
        );
      },
    );
  }

  /// Listen to ViewModel changes.
  void _onViewModelChange() {
    // If the subscription action has failed
    if (widget.viewModel.error) {
      // Reset the error state
      widget.viewModel.error = false;
      // Show an error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to subscribe')));
    }
  }

}

class SubscribeButtonStyle {
  static const unsubscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.red),
  );

  static const subscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.green),
  );
}

/// Subscribe button View Model.
/// Handles the subscribe action and exposes the state to the subscription.
class SubscribeButtonViewModel extends ChangeNotifier {
  SubscribeButtonViewModel({required this.subscriptionRepository});

  final SubscriptionRepository subscriptionRepository;

  // Whether the user is subscribed
  bool subscribed = false;

  // Whether the subscription action has failed
  bool error = false;

  // Subscription action
  Future<void> subscribe() async {
    // Ignore taps when subscribed
    if (subscribed) {
      return;
    }

    // Optimistic state.
    // It will be reverted if the subscription fails.
    subscribed = true;
    // Notify listeners to update the UI
    notifyListeners();

    try {
      await subscriptionRepository.subscribe();
    } catch (e) {
      print('Failed to subscribe: $e');
      // Revert to the previous state
      subscribed = false;
      // Set the error state
      error = true;
    } finally {
      notifyListeners();
    }
  }

}

/// Repository of subscriptions.
class SubscriptionRepository {
  /// Simulates a network request and then fails.
  Future<void> subscribe() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 1));
    // Fail after one second
    throw Exception('Failed to subscribe');
  }
}
```

----------------------------------------

TITLE: Display Asynchronously Loaded Data in Flutter ListView
DESCRIPTION: This complete Flutter application demonstrates loading data asynchronously from a network API and displaying it within a `ListView`. The data fetching is initiated in `initState`, and the UI is updated using `setState` once the data is available, ensuring a smooth user experience.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Define Root Application Widget with MaterialApp
DESCRIPTION: This code defines the `MyApp` class as a `StatelessWidget`, serving as the root of the Flutter application. It uses `MaterialApp` to set up the application's basic structure, including the title and the initial home page, `MyHomePage`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

----------------------------------------

TITLE: Implementing getUserProfile with Result.ok and Result.error
DESCRIPTION: This code shows the full implementation of the 'getUserProfile' method within 'ApiClientService', demonstrating how to use 'Result.ok' for successful responses and 'Result.error' for handling HTTP errors or other exceptions. It includes a 'try-catch' block to wrap any exceptions into a 'Result.error' and ensures proper resource closure in a 'finally' block, providing robust error management without throwing exceptions.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
class ApiClientService {
  // ···

  Future<Result<UserProfile>> getUserProfile() async {
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return Result.ok(UserProfile.fromJson(jsonDecode(stringData)));
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
  }
}
```

----------------------------------------

TITLE: Provide multiple state models using MultiProvider in Flutter
DESCRIPTION: This Dart code demonstrates how to use `MultiProvider` to provide multiple state management classes, including `ChangeNotifier` instances and other `Provider` types, to the widget tree. This is useful for applications with several independent state models that need to be accessible throughout the application.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MyApp(),
    ),
  );
}
```

----------------------------------------

TITLE: Flutter Chat Application with Dynamic Gradient Bubbles
DESCRIPTION: This comprehensive Flutter code creates a chat application featuring dynamically colored message bubbles. The `BubblePainter` class, a `CustomPainter`, applies a linear gradient to bubbles. The gradient's colors are determined by the `MessageBubble` based on the message owner, and the gradient's application is dynamically adjusted based on the bubble's vertical position within the scrollable view, creating a visual effect where bubbles at the bottom appear darker. Note that `MessageGenerator` and the full `Message` class definition (specifically the `isMine` getter) are not included in this snippet.
SOURCE: https://docs.flutter.dev/cookbook/effects/gradient-bubbles

LANGUAGE: Dart
CODE:
```
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  runApp(const App(home: ExampleGradientBubbles()));
}

@immutable
class App extends StatelessWidget {
  const App({super.key, this.home});

  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData.dark(),
      home: home,
    );
  }
}

@immutable
class ExampleGradientBubbles extends StatefulWidget {
  const ExampleGradientBubbles({super.key});

  @override
  State<ExampleGradientBubbles> createState() => _ExampleGradientBubblesState();
}

class _ExampleGradientBubblesState extends State<ExampleGradientBubbles> {
  late final List<Message> data;

  @override
  void initState() {
    super.initState();
    data = MessageGenerator.generate(60, 1337);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF4F4F4F),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter Chat')),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          reverse: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final message = data[index];
            return MessageBubble(message: message, child: Text(message.text));
          },
        ),
      ),
    );
  }
}

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.child});

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment = message.isMine
        ? Alignment.topLeft
        : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: [
                if (message.isMine) ...const [
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ] else ...const [Color(0xFF19B7FF), Color(0xFF491CCB)],
              ],
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({super.key, required this.colors, this.child});

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  }) : _scrollable = scrollable,
       _bubbleContext = bubbleContext,
       _colors = colors,
       super(repaint: scrollable.position);

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final origin = bubbleBox.localToGlobal(
      Offset.zero,
      ancestor: scrollableBox,
    );
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}

enum MessageOwner { myself, other }

@immutable
class Message {
  const Message({required this.owner, required this.text});

  final MessageOwner owner;
  final String text;
}
```

----------------------------------------

TITLE: Dart APIClient Service Definition
DESCRIPTION: This service class, `ApiClient`, demonstrates how to wrap an external API in a stateless manner. Its methods handle various CRUD operations, such as fetching continents, destinations, activities, and managing bookings, returning asynchronous `Result` objects. This class acts as a direct interface to the client-facing server.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/data-layer

LANGUAGE: dart
CODE:
```
class ApiClient {
  // Some code omitted for demo purposes.

  Future<Result<List<ContinentApiModel>>> getContinents() async { /* ... */ }

  Future<Result<List<DestinationApiModel>>> getDestinations() async { /* ... */ }

  Future<Result<List<ActivityApiModel>>> getActivityByDestination(String ref) async { /* ... */ }

  Future<Result<List<BookingApiModel>>> getBookings() async { /* ... */ }

  Future<Result<BookingApiModel>> getBooking(int id) async { /* ... */ }

  Future<Result<BookingApiModel>> postBooking(BookingApiModel booking) async { /* ... */ }

  Future<Result<void>> deleteBooking(int id) async { /* ... */ }

  Future<Result<UserApiModel>> getUser() async { /* ... */ }
}
```

----------------------------------------

TITLE: Flutter Navigation with Arguments Example
DESCRIPTION: This Flutter application demonstrates two primary methods for passing arguments between screens using named routes. It includes an 'ExtractArgumentsScreen' that retrieves arguments directly from the ModalRoute, and a 'PassArgumentsScreen' where arguments are processed and passed via the 'onGenerateRoute' function of the MaterialApp, showcasing flexible navigation patterns.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
      },
      // Provide a function to handle named routes.
      // Use this function to identify the named
      // route being pushed, and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Navigation with Arguments',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button,
                // navigate to a named route and
                // provide the arguments as an optional
                // parameter.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
              child: const Text('Navigate to screen that extracts arguments'),
            ),
            // A button that navigates to a named route.
            // For this route, extract the arguments in
            // the onGenerateRoute function and pass them
            // to the screen.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button, navigate
                // to a named route and provide the arguments
                // as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute '
                        'function.',
                  ),
                );
              },
              child: const Text('Navigate to a named that accepts arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Center(child: Text(args.message)),
    );
  }
}

// A Widget that accepts the necessary arguments via the
// constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor
  // parameters. It does not extract the arguments from
  // the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute
  // function provided to the MaterialApp widget.
  const PassArgumentsScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(message)),
    );
  }
}

// You can pass any object to the arguments parameter. In this example, you'll
// pass a ScreenArguments object to the ExtractArgumentsScreen. 
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

----------------------------------------

TITLE: Flutter Stateful Widget for Basic Counter
DESCRIPTION: This Dart code demonstrates a basic Flutter StatefulWidget named Counter that manages an integer state. It shows how to use setState within the _increment method to update the _counter variable, which then triggers a rebuild of the Widget build method, reflecting the new count in the UI via an ElevatedButton and Text widget.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Counter())),
    ),
  );
}
```

----------------------------------------

TITLE: FutureBuilder Widget API Reference
DESCRIPTION: Documentation for the Flutter FutureBuilder widget, which constructs itself based on the latest snapshot of interaction with a Future object. It is essential for displaying UI that depends on the completion of an asynchronous operation.
SOURCE: https://docs.flutter.dev/ui/widgets/async

LANGUAGE: APIDOC
CODE:
```
FutureBuilder:
  Description: Widget that builds itself based on the latest snapshot of interaction with a Future.
  Reference: https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
```

----------------------------------------

TITLE: Access Shared State from InheritedWidget in Flutter
DESCRIPTION: This example demonstrates how a StatelessWidget can access data provided by an InheritedWidget ancestor. By calling MyState.of(context).data within the build method, the HomeScreen widget retrieves and displays the shared state, ensuring automatic updates when the InheritedWidget rebuilds.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/state-management

LANGUAGE: dart
CODE:
```
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = MyState.of(context).data;
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Dart ViewModel Command for Deleting Booking Data
DESCRIPTION: This Dart code from `home_viewmodel.dart` defines the `_deleteBooking` method, which acts as a command to handle the deletion of a booking. It interacts with `_bookingRepository` to perform the actual data modification and then calls `notifyListeners()` to inform the UI of the state change, ensuring data persistence and UI synchronization.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: dart
CODE:
```
Future<Result<void>> _deleteBooking(int id) async {
  try {
    final resultDelete = await _bookingRepository.delete(id);
    switch (resultDelete) {
      case Ok<void>():
        _log.fine('Deleted booking $id');
      case Error<void>():
        _log.warning('Failed to delete booking $id', resultDelete.error);
        return resultDelete;
    }

    // Some code was omitted for brevity.
    // final  resultLoadBookings = ...;

    return resultLoadBookings;
  } finally {
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Show SnackBar using new ScaffoldMessenger API
DESCRIPTION: Illustrates the updated method for displaying a SnackBar using `ScaffoldMessenger.of(context).showSnackBar`. This approach simplifies the code by removing the need for a `Builder` and ensures the SnackBar persists across route transitions, improving reliability and error handling.
SOURCE: https://docs.flutter.dev/release/breaking-changes/scaffold-messenger

LANGUAGE: Dart
CODE:
```
Scaffold(
  key: scaffoldKey,
  body: GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('snack'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ),
      ));
    },
    child: const Text('SHOW SNACK'),
  ),
);
```

----------------------------------------

TITLE: Define Tabs using TabBar in Flutter AppBar
DESCRIPTION: This code shows how to create a `TabBar` with three `Tab` widgets, each displaying an icon, and place it within an `AppBar`. The `TabBar` automatically connects to the `DefaultTabController` to manage tab selection and visual presentation.
SOURCE: https://docs.flutter.dev/cookbook/design/tabs

LANGUAGE: dart
CODE:
```
return MaterialApp(
  home: DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
    ),
  ),
);
```

----------------------------------------

TITLE: Implement a Navigation Drawer in Flutter
DESCRIPTION: This Flutter code demonstrates how to create a navigation drawer within a `Scaffold`. It includes a `Drawer` with `ListTile` items, an `AppBar` with a menu icon to open the drawer, and a stateful widget to manage the selected item's index and display corresponding content. The `_onItemTapped` function updates the UI and closes the drawer.
SOURCE: https://docs.flutter.dev/cookbook/design/drawer

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Business', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            )
          ]
        )
      )
    );
  }
}
```

----------------------------------------

TITLE: Add Static Image in Flutter
DESCRIPTION: Demonstrates how to include a static image from your app's assets using the Image.asset constructor in Flutter. The image path should be relative to the project's assets folder.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: dart
CODE:
```
Image.asset('assets/background.png');
```

----------------------------------------

TITLE: Flutter Stateful Parent Widget for Shopping List
DESCRIPTION: Illustrates the beginning of a `StatefulWidget` (`ShoppingList`) designed to act as a parent for `ShoppingListItem`. This pattern demonstrates how mutable state can be managed higher in the widget hierarchy, allowing the parent to update its internal state upon receiving callbacks from child widgets, triggering UI rebuilds with new data.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {

```

----------------------------------------

TITLE: Handle Gestures with GestureDetector in Flutter
DESCRIPTION: This snippet demonstrates how to use Flutter's GestureDetector to respond to various user interactions. It specifically shows an example of rotating a Flutter logo when a double tap gesture is detected, utilizing AnimationController for the rotation effect.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: RotationTransition(
            turns: curve,
            child: const FlutterLogo(size: 200),
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implementing a Flutter View with ListenableBuilder
DESCRIPTION: This Dart code demonstrates how to use a `ListenableBuilder` in a Flutter View to react to changes notified by a `ChangeNotifier` (like a ViewModel). It rebuilds the UI to display the current count and any error messages, and provides a button to trigger the `increment()` method on the ViewModel, effectively separating UI logic from business logic.
SOURCE: https://docs.flutter.dev/get-started/fwe/state-management

LANGUAGE: dart
CODE:
```
ListenableBuilder(
  listenable: viewModel,
  builder: (context, child) {
    return Column(
      children: [
        if (viewModel.errorMessage != null)
          Text(
            'Error: ${viewModel.errorMessage}',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Colors.red),
          ),
        Text('Count: ${viewModel.count}'),
        TextButton(
          onPressed: () {
            viewModel.increment();
          },
          child: Text('Increment'),
        ),
      ],
    );
  },
)
```

----------------------------------------

TITLE: Basic Flutter Widget Hierarchy Example
DESCRIPTION: This example demonstrates a basic Flutter application structure, showcasing how widgets like `MaterialApp`, `Scaffold`, `AppBar`, `Text`, `Column`, `SizedBox`, and `ElevatedButton` are composed hierarchically to build a user interface. It illustrates the `main` function, a `StatelessWidget` for the app, and how to define a simple UI with interactive elements.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My Home Page')),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  const Text('Hello World'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('A button'),
                  )
                ]
              );
            }
          )
        )
      )
    );
  }
}
```

----------------------------------------

TITLE: Flutter Navigator Widget API Reference
DESCRIPTION: Documentation for the Flutter Navigator widget, which manages a stack of child widgets for navigation.
SOURCE: https://docs.flutter.dev/ui/widgets/interaction

LANGUAGE: APIDOC
CODE:
```
Class: Navigator
  Description: A widget that manages a set of child widgets with a stack discipline. Many apps have a navigator near the top of their widget hierarchy...
  See also: https://api.flutter.dev/flutter/widgets/Navigator-class.html
```

----------------------------------------

TITLE: Navigate to New Route with Navigator.push()
DESCRIPTION: Demonstrates how to add a new route to the navigation stack using Navigator.push(). It includes examples for both MaterialPageRoute for Android-style transitions and CupertinoPageRoute for iOS-style transitions, showing how to update an onPressed callback to trigger navigation.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigation-basics

LANGUAGE: dart
CODE:
```
// Within the `FirstRoute` widget:
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SecondRoute()),
  );
}
```

LANGUAGE: dart
CODE:
```
// Within the `FirstRoute` widget:
onPressed: () {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => const SecondRoute()),
  );
}
```

----------------------------------------

TITLE: Complete Flutter app for long list display
DESCRIPTION: A full, runnable Flutter application demonstrating the use of ListView.builder to display a long list of items. This example includes the main application setup, a StatelessWidget for the app, and the ListView.builder implementation within a Scaffold.
SOURCE: https://docs.flutter.dev/cookbook/lists/long-lists

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          prototypeItem: ListTile(title: Text(items.first)),
          itemBuilder: (context, index) {
            return ListTile(title: Text(items[index]));
          },
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Create a basic ListView with ListTile
DESCRIPTION: This snippet demonstrates how to use the standard ListView constructor for lists containing a few items. It utilizes the built-in ListTile widget to give items a clear visual structure, displaying an icon and text for each entry.
SOURCE: https://docs.flutter.dev/cookbook/lists/basic-list

LANGUAGE: dart
CODE:
```
ListView(
  children: const <Widget>[
    ListTile(leading: Icon(Icons.map), title: Text('Map')),
    ListTile(leading: Icon(Icons.photo_album), title: Text('Album')),
    ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
  ],
),
```

----------------------------------------

TITLE: Perform GET Network Request and Parse JSON in Flutter
DESCRIPTION: This Dart function demonstrates making an asynchronous GET request to a specified URL using the `http` package. It parses the JSON response body into a list of maps and updates the application's state accordingly.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Create a Stateful Counter Widget in Flutter
DESCRIPTION: This Dart code defines a StatefulWidget named CounterWidget that demonstrates how to manage mutable state. It includes a private _counter variable, an _incrementCounter method that updates the counter using setState to rebuild the UI, and a build method that displays the counter's current value. This example illustrates the basic structure of a stateful widget and the use of setState for UI updates.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/widgets

LANGUAGE: dart
CODE:
```
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_counter');
  }
}
```

----------------------------------------

TITLE: Flutter Flex Widget Property: mainAxisAlignment
DESCRIPTION: Documentation for the `mainAxisAlignment` property of Flutter `Flex` widgets (e.g., `Row`, `Column`), detailing its purpose and supported enumeration values for aligning children along the main axis.
SOURCE: https://docs.flutter.dev/tools/devtools/legacy-inspector

LANGUAGE: APIDOC
CODE:
```
Property: mainAxisAlignment
Description: Controls how children are aligned along the main axis of a Flex widget.
Applies to: Flex, Row, Column widgets
Supported Values:
  - MainAxisAlignment.start
  - MainAxisAlignment.end
  - MainAxisAlignment.center
  - MainAxisAlignment.spaceBetween
  - MainAxisAlignment.spaceAround
  - MainAxisAlignment.spaceEvenly
```

----------------------------------------

TITLE: Complete Flutter Example for Background JSON Parsing
DESCRIPTION: This Dart code provides a full Flutter application demonstrating how to fetch a list of photos from a JSON API, parse the JSON data on a separate isolate using `compute` to avoid blocking the UI thread, and display the images in a `GridView`. It includes `http` for network requests, `Photo` model definition, and stateful/stateless widgets for the UI.
SOURCE: https://docs.flutter.dev/cookbook/networking/background-parsing

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List)
      .cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
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
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error has occurred!'));
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
```

----------------------------------------

TITLE: Use ValueListenableBuilder with ValueNotifier in Flutter
DESCRIPTION: Illustrates how to use ValueListenableBuilder to react to changes in a ValueNotifier. The builder callback provides the current value, and a TextButton increments the notifier's value, triggering UI updates.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/state-management

LANGUAGE: dart
CODE:
```
Column(
  children: [
    ValueListenableBuilder(
      valueListenable: counterNotifier,
      builder: (context, value, child) {
        return Text('counter: $value');
      },
    ),
    TextButton(
      child: Text('Increment'),
      onPressed: () {
        counterNotifier.value++;
      },
    ),
  ],
)
```

----------------------------------------

TITLE: Adding Click Listeners in Flutter
DESCRIPTION: Demonstrates two methods for adding click listeners in Flutter: using `onPressed` for widgets that support it (like `ElevatedButton`) and wrapping a widget in `GestureDetector` for others.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
 return ElevatedButton(
   onPressed: () {
     developer.log('click');
   },
   child: const Text('Button'),
 );
}
```

LANGUAGE: dart
CODE:
```
class SampleTapApp extends StatelessWidget {
 const SampleTapApp({super.key});

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: GestureDetector(
         onTap: () {
           developer.log('tap');
         },
         child: const FlutterLogo(size: 200),
       ),
     ),
   );
 }
}
```

----------------------------------------

TITLE: Initialize and Cache a Pre-warmed FlutterEngine
DESCRIPTION: This code shows how to instantiate a FlutterEngine, execute its Dart entrypoint, and cache it for later use. Pre-warming the engine in an Application class or similar early stage reduces the initial load time for FlutterFragment, improving the user experience by avoiding a blank UI.
SOURCE: https://docs.flutter.dev/add-to-app/android/add-flutter-fragment

LANGUAGE: kotlin
CODE:
```
// Somewhere in your app, before your FlutterFragment is needed,
// like in the Application class ...
// Instantiate a FlutterEngine.
val flutterEngine = FlutterEngine(context)

// Start executing Dart code in the FlutterEngine.
flutterEngine.getDartExecutor().executeDartEntrypoint(
    DartEntrypoint.createDefault()
)

// Cache the pre-warmed FlutterEngine to be used later by FlutterFragment.
FlutterEngineCache
  .getInstance()
  .put("my_engine_id", flutterEngine)
```

LANGUAGE: java
CODE:
```
// Somewhere in your app, before your FlutterFragment is needed,
// like in the Application class ...
// Instantiate a FlutterEngine.
FlutterEngine flutterEngine = new FlutterEngine(context);

// Start executing Dart code in the FlutterEngine.
flutterEngine.getDartExecutor().executeDartEntrypoint(
    DartEntrypoint.createDefault()
);

// Cache the pre-warmed FlutterEngine to be used later by FlutterFragment.
FlutterEngineCache
  .getInstance()
  .put("my_engine_id", flutterEngine);
```

----------------------------------------

TITLE: Implement CheckboxListTile and SwitchListTile in Flutter
DESCRIPTION: This snippet demonstrates how to use Flutter's CheckboxListTile and SwitchListTile widgets, which are convenience wrappers around Checkbox and Switch that include a ListTile for labels. It shows how to manage their state using setState to update values like timeDilation and a boolean flag.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
double timeDilation = 1.0;
bool _lights = false;

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      CheckboxListTile(
        title: const Text('Animate Slowly'),
        value: timeDilation != 1.0,
        onChanged: (bool? value) {
          setState(() {
            timeDilation = value! ? 10.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
      SwitchListTile(
        title: const Text('Lights'),
        value: _lights,
        onChanged: (bool value) {
          setState(() {
            _lights = value;
          });
        },
        secondary: const Icon(Icons.lightbulb_outline),
      ),
    ],
  );
}
```

----------------------------------------

TITLE: Avoid Overriding operator == on Widget Objects
DESCRIPTION: Overriding `operator ==` on `Widget` objects generally harms performance by resulting in O(N²) behavior, even if it seems to prevent unnecessary rebuilds. Caching widgets is usually preferred.
SOURCE: https://docs.flutter.dev/perf/best-practices

LANGUAGE: APIDOC
CODE:
```
Pitfall: Overriding `operator ==` on `Widget` objects.
Impact: Results in O(N²) behavior, hurting performance.
Exception: Only for leaf widgets (no children) where property comparison is significantly more efficient than rebuilding, and the widget rarely changes configuration. Even then, caching is generally preferred as overriding can lead to across-the-board performance degradation.
```

----------------------------------------

TITLE: Flutter Widgets Column
DESCRIPTION: Layout a list of child widgets in the vertical direction.
SOURCE: https://docs.flutter.dev/reference/widgets

LANGUAGE: APIDOC
CODE:
```
Class: Column
Description: Layout a list of child widgets in the vertical direction.
```

----------------------------------------

TITLE: Implement a Flutter Download Progress Indicator Widget
DESCRIPTION: This Dart/Flutter code defines a widget's properties and its `build` method to render an animated `CircularProgressIndicator`. The indicator's appearance (background, color, and value) dynamically adjusts based on `downloadProgress`, `isDownloading`, and `isFetching` boolean flags, providing clear visual feedback during file download operations.
SOURCE: https://docs.flutter.dev/cookbook/effects/download-button

LANGUAGE: Dart
CODE:
```
    required this.downloadProgress,
    required this.isDownloading,
    required this.isFetching,
  });

  final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return CircularProgressIndicator(
            backgroundColor: isDownloading
                ? CupertinoColors.lightBackgroundGray
                : Colors.transparent,
            valueColor: AlwaysStoppedAnimation(
              isFetching
                  ? CupertinoColors.lightBackgroundGray
                  : CupertinoColors.activeBlue,
            ),
            strokeWidth: 2,
            value: isFetching ? null : progress,
          );
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter UI Update with ListenableBuilder and ViewModel
DESCRIPTION: This Dart code snippet from `home_screen.dart` demonstrates how the `HomeScreen` widget uses `ListenableBuilder` to reactively update its UI. It listens to a `viewModel` (a `ChangeNotifier` subtype) and rebuilds the `CustomScrollView` and its `SliverList.builder` whenever the view model's data, such as `bookings`, changes, ensuring the UI reflects the latest state.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return Scaffold(
    // Some code was removed for brevity.
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(),
                SliverList.builder(
                  itemCount: viewModel.bookings.length,
                  itemBuilder: (_, index) =>
                      _Booking(
                        key: ValueKey(viewModel.bookings[index].id),
                        booking: viewModel.bookings[index],
                        onTap: () =>
                            context.push(Routes.bookingWithId(
                                viewModel.bookings[index].id)
                            ),
                        onDismissed: (_) =>
                            viewModel.deleteBooking.execute(
                              viewModel.bookings[index].id,
                            ),
                      ),
                ),
              ],
            );
          }
        )
      )
  );
}
```

----------------------------------------

TITLE: Fetch Data and Display in Flutter App
DESCRIPTION: This Dart code defines a Flutter application that fetches album data from a JSONPlaceholder API endpoint. It includes an `Album` model, a `fetchAlbum` function for network requests, and a `MyApp` widget that uses `FutureBuilder` to display the fetched data or a loading indicator/error message.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/mocking

LANGUAGE: Dart
CODE:
```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Dart: Conditionally Rendering UI based on Command State
DESCRIPTION: This Dart Flutter code demonstrates how to use a `ListenableBuilder` to react to the state of an asynchronous `Command` (e.g., `viewModel.load`). It conditionally renders a `CircularProgressIndicator` while the command is running, an `ErrorIndicator` if an error occurs, or the main view once the command completes successfully, ensuring a responsive and informative UI during data fetching.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: Dart
CODE:
```
// ...
child: ListenableBuilder(
  listenable: viewModel.load,
  builder: (context, child) {
    if (viewModel.load.running) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.load.error) {
      return ErrorIndicator(
        title: AppLocalization.of(context).errorWhileLoadingHome,
        label: AppLocalization.of(context).tryAgain,
          onPressed: viewModel.load.execute,
        );
     }

    // The command has completed without error.
    // Return the main view widget.
    return child!;
  },
),

// ...
```

----------------------------------------

TITLE: Retrieve User Input from Flutter TextField using TextEditingController
DESCRIPTION: This comprehensive example demonstrates how to capture and manage user input from a `TextField` widget in a Flutter stateful widget. It covers the creation, attachment, and proper disposal of a `TextEditingController`, and shows how to retrieve and display the entered text in an `AlertDialog`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Initialize and Run a Basic Flutter Application
DESCRIPTION: This Dart code defines the entry point for a Flutter application using `void main() => runApp(const MyApp());`. It then defines `MyApp`, a `StatelessWidget` that sets up a `MaterialApp` with a `Scaffold`, an `AppBar` displaying 'Welcome to Flutter', and a `Center` widget containing 'Hello world' in the body. This is the standard boilerplate for a minimal Flutter app.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Welcome to Flutter')),
        body: const Center(child: Text('Hello world')),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Comprehensive Error Handling for All Error Types in Flutter
DESCRIPTION: This comprehensive snippet combines multiple error handling strategies to provide robust error management. It initializes a custom error handler, sets `FlutterError.onError` for UI-related errors, and configures `PlatformDispatcher.instance.onError` for asynchronous and platform-specific errors, ensuring that all types of exceptions are caught and processed.
SOURCE: https://docs.flutter.dev/testing/errors

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'dart:ui';

Future<void> main() async {
  await myErrorsHandler.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    myErrorsHandler.onErrorDetails(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    myErrorsHandler.onError(error, stack);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw StateError('widget is null');
      },
    );
  }
}
```

----------------------------------------

TITLE: Customize Material Design Theme in Flutter
DESCRIPTION: This snippet demonstrates how to set up a Material Design application using `MaterialApp` and customize its global theme. It shows how to pass a `ThemeData` object to `MaterialApp` to define properties like the color scheme from a seed color and the divider color, affecting all child components.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        dividerColor: Colors.grey,
      ),
      home: const SampleAppPage(),
    );
  }
}
```

----------------------------------------

TITLE: Communicating with Isolates for CPU-intensive tasks in Flutter
DESCRIPTION: Illustrates how to use Flutter `Isolate`s for computationally intensive tasks to avoid blocking the UI thread. It shows the pattern for spawning an `Isolate` and communicating data back to the main thread using `ReceivePort` and `SendPort`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message.
  final SendPort sendPort = await receivePort.first as SendPort;

  final List<Map<String, dynamic>> msg = await sendReceive(
    sendPort,
    'https://jsonplaceholder.typicode.com/posts',
  );

  setState(() {
    data = msg;
  });
}

// The entry point for the isolate.
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  final ReceivePort port = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (final dynamic msg in port) {
    final String url = msg[0] as String;
    final SendPort replyTo = msg[1] as SendPort;

    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
  }
}

Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
  final ReceivePort response = ReceivePort();
  port.send(<dynamic>[msg, response.sendPort]);
  return response.first as Future<List<Map<String, dynamic>>>;
}
```

----------------------------------------

TITLE: Migrate Deprecated Scaffold SnackBar Methods to ScaffoldMessenger
DESCRIPTION: This snippet illustrates the migration of deprecated `Scaffold` `SnackBar` methods (`showSnackBar`, `removeCurrentSnackBar`, `hideCurrentSnackBar`) to their equivalents in `ScaffoldMessenger`. `ScaffoldMessenger` provides a more robust way to manage `SnackBar`s across different contexts.
SOURCE: https://docs.flutter.dev/release/breaking-changes/2-10-deprecations

LANGUAGE: dart
CODE:
```
Scaffold.of(context).showSnackBar(mySnackBar);
Scaffold.of(context).removeCurrentSnackBar(mySnackBar);
Scaffold.of(context).hideCurrentSnackBar(mySnackBar);
```

LANGUAGE: dart
CODE:
```
ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
ScaffoldMessenger.of(context).removeCurrentSnackBar(mySnackBar);
ScaffoldMessenger.of(context).hideCurrentSnackBar(mySnackBar);
```

----------------------------------------

TITLE: Flutter Download Button Shape Animation with AnimatedContainer
DESCRIPTION: This Dart code defines two `StatelessWidget`s, `DownloadButton` and `ButtonShapeWidget`, to animate a button's shape based on its `DownloadStatus`. `DownloadButton` manages the status and passes it to `ButtonShapeWidget`. `ButtonShapeWidget` uses an `AnimatedContainer` with `ShapeDecoration` to transition between a `StadiumBorder` (rounded rectangle) for 'not downloaded'/'downloaded' states and a `CircleBorder` (transparent circle) for 'fetching'/'downloading' states, ensuring a smooth visual transition.
SOURCE: https://docs.flutter.dev/cookbook/effects/download-button

LANGUAGE: dart
CODE:
```
@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.status,
    this.transitionDuration = const Duration(milliseconds: 500),
  });

  final DownloadStatus status;
  final Duration transitionDuration;

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  @override
  Widget build(BuildContext context) {
    return ButtonShapeWidget(
      transitionDuration: transitionDuration,
      isDownloaded: _isDownloaded,
      isDownloading: _isDownloading,
      isFetching: _isFetching,
    );
  }
}

@immutable
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget({
    super.key,
    required this.isDownloading,
    required this.isDownloaded,
    required this.isFetching,
    required this.transitionDuration,
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    final ShapeDecoration shape;
    if (isDownloading || isFetching) {
      shape = const ShapeDecoration(
        shape: CircleBorder(),
        color: Colors.transparent,
      );
    } else {
      shape = const ShapeDecoration(
        shape: StadiumBorder(),
        color: CupertinoColors.lightBackgroundGray,
      );
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: const SizedBox(),
    );
  }
}
```

----------------------------------------

TITLE: Complete Flutter application with Isolate for background processing
DESCRIPTION: A full, runnable Flutter application demonstrating the integration of `Isolate`s for background data processing. This example includes the UI setup, state management, and the complete logic for spawning an Isolate, fetching data, and updating the UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message.
    final SendPort sendPort = await receivePort.first as SendPort;

    final List<Map<String, dynamic>> msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );

    setState(() {
      data = msg;
    });
  }

  // The entry point for the isolate.
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (final dynamic msg in port) {
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;

```

----------------------------------------

TITLE: Navigating Pages with Flutter Navigator and Named Routes
DESCRIPTION: Explains how to use Flutter's Navigator with named routes for page navigation. This includes defining routes, pushing named routes with arguments, and extracting arguments in the destination widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/swiftui-devs

LANGUAGE: Dart
CODE:
```
// Defines the route name as a constant
// so that it's reusable.
const detailsPageRouteName = '/details';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePage(),
      // The [routes] property defines the available named routes
      // and the widgets to build when navigating to those routes.
      routes: {detailsPageRouteName: (context) => const DetailsPage()},
    );
  }
}
```

LANGUAGE: Dart
CODE:
```
ListView.builder(
  itemCount: mockPersons.length,
  itemBuilder: (context, index) {
    final person = mockPersons.elementAt(index);
    final age = '${person.age} years old';
    return ListTile(
      title: Text(person.name),
      subtitle: Text(age),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // When a [ListTile] that represents a person is
        // tapped, push the detailsPageRouteName route
        // to the Navigator and pass the person's instance
        // to the route.
        Navigator.of(
          context,
        ).pushNamed(detailsPageRouteName, arguments: person);
      },
    );
  },
),
```

LANGUAGE: Dart
CODE:
```
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the person instance from the arguments.
    final Person person = ModalRoute.of(context)?.settings.arguments as Person;
    // Extract the age.
    final age = '${person.age} years old';
    return Scaffold(
      // Display name and age.
      body: Column(children: [Text(person.name), Text(age)]),
    );
  }
}
```

----------------------------------------

TITLE: Store Key-Values with shared_preferences Flutter Plugin
DESCRIPTION: Persist key-value data in Flutter apps using the `shared_preferences` plugin. This plugin utilizes Apple's `@AppStorage` property wrapper and `NSUserDefaults` for storing simple data.
SOURCE: https://docs.flutter.dev/platform-integration/ios/apple-frameworks

LANGUAGE: APIDOC
CODE:
```
Use Case: Store key-values
Apple Framework/Class: @AppStorage property wrapper and NSUserDefaults
Flutter Plugin: shared_preferences
```

----------------------------------------

TITLE: Change UI in Declarative Style (Flutter)
DESCRIPTION: This snippet illustrates how UI changes are managed in a declarative framework like Flutter. Instead of mutating an existing instance, a new, immutable widget configuration is returned. The framework then handles the reconciliation and updates the underlying render objects efficiently, abstracting away direct manipulation.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/declarative

LANGUAGE: dart
CODE:
```
// Declarative style
return ViewB(color: red, child: const ViewC());
```

----------------------------------------

TITLE: Fetch Photos from JSONPlaceholder API in Dart
DESCRIPTION: Demonstrates how to make a network request to fetch a large JSON document containing a list of 5000 photo objects from the JSONPlaceholder REST API using the `http.get()` method. The function accepts an `http.Client` instance, which makes it easier to test and use in different environments.
SOURCE: https://docs.flutter.dev/cookbook/networking/background-parsing

LANGUAGE: Dart
CODE:
```
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
}
```

----------------------------------------

TITLE: Implementing a DropdownMenu in Flutter
DESCRIPTION: The `DropdownMenu` widget allows users to select an option from a list and filter items based on text input. This snippet demonstrates its basic implementation, including defining menu entries using an enum, setting an initial selection, handling user selections with `onSelected`, and customizing appearance.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

// StatefulWidget...
@override
Widget build(BuildContext context) {
  return DropdownMenu<ColorLabel>(
    initialSelection: ColorLabel.green,
    controller: colorController,
    // requestFocusOnTap is enabled/disabled by platforms when it is null.
    // On mobile platforms, this is false by default. Setting this to true will
    // trigger focus request on the text field and virtual keyboard will appear
    // afterward. On desktop platforms however, this defaults to true.
    requestFocusOnTap: true,
    label: const Text('Color'),
    onSelected: (ColorLabel? color) {
      setState(() {
        selectedColor = color;
      });
    },
    dropdownMenuEntries: ColorLabel.values
      .map<DropdownMenuEntry<ColorLabel>>(
          (ColorLabel color) {
            return DropdownMenuEntry<ColorLabel>(
              value: color,
              label: color.label,
              enabled: color.label != 'Grey',
              style: MenuItemButton.styleFrom(
                foregroundColor: color.color,
              ),
            );
      }).toList(),
  );
}
```

----------------------------------------

TITLE: Define Custom Error Widget for Flutter Build Phase Errors
DESCRIPTION: This snippet demonstrates how to use `MaterialApp.builder` to display a custom error widget whenever a widget fails to build. It includes logic to wrap the error widget in a `Scaffold` if the failed widget was a `Scaffold` or `Navigator`, ensuring proper display.
SOURCE: https://docs.flutter.dev/testing/errors

LANGUAGE: dart
CODE:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw StateError('widget is null');
      },
    );
  }
}
```

----------------------------------------

TITLE: TextField Widget
DESCRIPTION: A widget that provides a box into which app users can enter text. TextField widgets are commonly used in forms and dialogs for user input.
SOURCE: https://docs.flutter.dev/reference/widgets

LANGUAGE: APIDOC
CODE:
```
TextField:
  Description: Box for user text input, commonly used in forms and dialogs.
```

----------------------------------------

TITLE: Flutter: Fixing InputDecorator Unbounded Width Error with Expanded
DESCRIPTION: Shows how to resolve the 'unbounded width' error for TextField or TextFormField by wrapping it with an Expanded widget within a Row. This provides the necessary width constraint to prevent the error.
SOURCE: https://docs.flutter.dev/testing/common-errors

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Unbounded Width of the TextField')),
      body: Row(children: [Expanded(child: TextFormField())]),
    ),
  );
}
```

----------------------------------------

TITLE: Troubleshoot Flutter Doctor Issues with Verbose Output
DESCRIPTION: Explains how to use the `flutter doctor -v` command to get detailed diagnostic output when encountering errors with Flutter, VS Code, connected devices, or network resources. This verbose output helps identify missing software or further tasks required for a successful Flutter setup.
SOURCE: https://docs.flutter.dev/get-started/install/chromeos/android

LANGUAGE: Shell
CODE:
```
flutter doctor -v
```

----------------------------------------

TITLE: Navigate to a new screen using go_router in Flutter
DESCRIPTION: This Dart snippet demonstrates how to programmatically navigate to a new screen using the context.go() method provided by the go_router package. It's typically used within a button's onPressed callback to trigger a route change to the '/second' path.
SOURCE: https://docs.flutter.dev/ui/navigation

LANGUAGE: dart
CODE:
```
child: const Text('Open second screen'),
onPressed: () => context.go('/second'),
```

----------------------------------------

TITLE: Flutter Staggered Speech Bubble Animation
DESCRIPTION: This Dart code implements a `TypingIndicator` widget that uses Flutter's animation framework to create a staggered appearance effect for three speech bubbles. It manages `AnimationController`s and `CurvedAnimation`s to control the scale and position of bubbles, making them appear sequentially. The animation is triggered and reversed based on the `showIndicator` property, providing a dynamic typing indicator.
SOURCE: https://docs.flutter.dev/cookbook/effects/typing-indicator

LANGUAGE: dart
CODE:
```
class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.0, end: 60.0));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(height: _indicatorSpaceAnimation.value, child: child);
      },
      child: Stack(
        children: [
          AnimatedBubble(
            animation: _smallBubbleAnimation,
            left: 8,
            bottom: 8,
            bubble: CircleBubble(size: 8, bubbleColor: widget.bubbleColor),
          ),
          AnimatedBubble(
            animation: _mediumBubbleAnimation,
            left: 10,
            bottom: 10,
            bubble: CircleBubble(size: 16, bubbleColor: widget.bubbleColor),
          ),
          AnimatedBubble(
            animation: _largeBubbleAnimation,
            left: 12,
            bottom: 12,
            bubble: StatusBubble(
              dotIntervals: _dotIntervals,
              flashingCircleDarkColor: widget.flashingCircleDarkColor,
              flashingCircleBrightColor: widget.flashingCircleBrightColor,
              bubbleColor: widget.bubbleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleBubble extends StatelessWidget {
  const CircleBubble({
    super.key,
    required this.size,
    required this.bubbleColor,
  });

  final double size;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bubbleColor),
    );
  }
}

class AnimatedBubble extends StatelessWidget {
  const AnimatedBubble({
    super.key,
    required this.animation,
    required this.left,
    required this.bottom,
    required this.bubble,
  });

  final Animation<double> animation;
  final double left;
  final double bottom;
  final Widget bubble;

  @override
```

----------------------------------------

TITLE: Define a StatefulWidget for managing visibility
DESCRIPTION: To control the visibility of the animated box, a StatefulWidget named MyHomePage is defined. This widget creates a _MyHomePageState object, which holds the _visible boolean state. The State class is responsible for managing this data and rebuilding the UI when the state changes, allowing the box's visibility to be toggled.
SOURCE: https://docs.flutter.dev/cookbook/animation/opacity-animation

LANGUAGE: dart
CODE:
```
// The StatefulWidget's job is to take data and create a State class.
// In this case, the widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible.
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // The green box goes here with some other Widgets.
  }
}
```

----------------------------------------

TITLE: Flutter: Use Isolates for CPU-bound Work and Communication
DESCRIPTION: For computationally intensive tasks that would block the main thread, Flutter uses `Isolate`s. Isolates are separate execution threads that do not share memory. This example demonstrates how to spawn an Isolate, send data to it, and receive processed results back to update the UI safely.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
Future<void> loadData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message
  final SendPort sendPort = await receivePort.first as SendPort;
  final List<Map<String, dynamic>> msg = await sendReceive(
    sendPort,
    'https://jsonplaceholder.typicode.com/posts',
  );
  setState(() {
    data = msg;
  });
}

// The entry point for the isolate
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  final ReceivePort port = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);
  await for (final dynamic msg in port) {
    final String url = msg[0] as String;
    final SendPort replyTo = msg[1] as SendPort;

    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
  }
}

Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
  final ReceivePort response = ReceivePort();
  port.send(<dynamic>[msg, response.sendPort]);
  return response.first as Future<List<Map<String, dynamic>>>;
}
```

----------------------------------------

TITLE: Flutter Widget: Row Layout
DESCRIPTION: The Row widget arranges a list of child widgets horizontally. It is essential for creating linear horizontal layouts in Flutter applications.
SOURCE: https://docs.flutter.dev/ui/widgets/layout

LANGUAGE: APIDOC
CODE:
```
Row:
  Layout a list of child widgets in the horizontal direction.
```

----------------------------------------

TITLE: Configure VS Code for Flutter Hot Reload on Save
DESCRIPTION: This JSON configuration snippet shows how to enable autosave and automatic hot reload on save for Flutter projects within VS Code. Add these settings to your `.vscode/settings.json` file to streamline your development workflow.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: JSON
CODE:
```
"files.autoSave": "afterDelay",
"dart.flutterHotReloadOnSave": "all"
```

----------------------------------------

TITLE: Propagating Result Object in Repository Layer
DESCRIPTION: This snippet illustrates how the repository layer adapts to the result pattern by returning a 'Future<Result<UserProfile>>' from its 'getUserProfile' method. It simply forwards the 'Result' object obtained from the '_apiClientService', ensuring that the error handling pattern is consistently propagated through different layers of the application.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
Future<Result<UserProfile>> getUserProfile() async {
  return await _apiClientService.getUserProfile();
}
```

----------------------------------------

TITLE: Flutter Container Fixed Size Constraint Example
DESCRIPTION: Illustrates a `Container` attempting to be 100x100 pixels. The explanation highlights that despite the requested size, the `Container` still fills the screen due to the parent's (screen's) forcing constraints.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
class Example2 extends Example {
  const Example2({super.key});

  @override
  final code = 'Container(width: 100, height: 100, color: red)';
  @override
  final String explanation =
      'The red Container wants to be 100x100, but it can\'t, '
      'because the screen forces it to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen.';

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: red);
  }
}
```

----------------------------------------

TITLE: Handling I/O-bound work with async/await in Flutter
DESCRIPTION: Demonstrates how to perform I/O-bound operations like network calls using `async`/`await`. This approach is suitable for tasks that don't block the main thread significantly, allowing the UI to remain responsive while waiting for data.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Define UserProfile with Synchronization Flag (Dart)
DESCRIPTION: Demonstrates how to add a `synchronized` boolean flag to a data model, `UserProfile`, using the `freezed` package in Dart. This flag is crucial for tracking whether local data changes have been successfully pushed to the remote API.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String name,
    required String photoUrl,
    @Default(false) bool synchronized,
  }) = _UserProfile;
}
```

----------------------------------------

TITLE: Flutter: Embedding a Counter Widget in Scaffold
DESCRIPTION: This snippet demonstrates how to embed a `Counter` widget within a `Scaffold`'s body, centered on the screen. It illustrates basic widget composition for an application's home screen setup, showcasing how a custom widget can be integrated.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
home: Scaffold(body: Center(child: Counter())),
    ),
  );
}
```

----------------------------------------

TITLE: Flutter ConstrainedBox Interaction with Parent Constraints
DESCRIPTION: Explains that ConstrainedBox only imposes *additional* constraints. When the screen forces it to fill the screen, its internal min/max constraints are ignored, and it passes the screen's size to its child.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: dart
CODE:
```
ConstrainedBox(
  constraints: const BoxConstraints(
    minWidth: 70,
    minHeight: 70,
    maxWidth: 150,
    maxHeight: 150,
  ),
  child: Container(color: red, width: 10, height: 10),
)
```

----------------------------------------

TITLE: Define HomeViewModel Class for UI State in Flutter
DESCRIPTION: This snippet defines the `HomeViewModel` class, which extends `ChangeNotifier` to manage UI state in a Flutter application. It initializes with `BookingRepository` and `UserRepository` dependencies and exposes `user` and `bookings` as public members for the view to observe.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: dart
CODE:
```
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
   required BookingRepository bookingRepository,
   required UserRepository userRepository,
  }) : _bookingRepository = bookingRepository,
      _userRepository = userRepository;
  final BookingRepository _bookingRepository;
  final UserRepository _userRepository;

  User? _user;
  User? get user => _user;

  List<BookingSummary> _bookings = [];
  List<BookingSummary> get bookings => _bookings;

  // ...
}
```

----------------------------------------

TITLE: Combine ListenableBuilders for Command and ViewModel States (Dart)
DESCRIPTION: Shows how to nest ListenableBuilder widgets to first handle Command states (like 'running' or 'error') and then render the ViewModel's data. This pattern ensures that UI updates are based on both command progress and data availability, providing a robust user experience.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
body: ListenableBuilder(
  listenable: widget.viewModel.load,
  builder: (context, child) {
    if (widget.viewModel.load.running) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.viewModel.load.error != null) {
      return Center(
        child: Text('Error: ${widget.viewModel.load.error}'),
      );
    }

    return child!;
  },
  child: ListenableBuilder(
    listenable: widget.viewModel,
    builder: (context, _) {
      // ···
    },
  ),
),
```

----------------------------------------

TITLE: Flutter FormState Class and validate() Method
DESCRIPTION: Documentation for the `FormState` class in Flutter, which is automatically created by the `Form` widget. It details the `validate()` method, explaining how it runs `validator()` functions for each `TextFormField` and returns `true` if all inputs are valid, or `false` otherwise, while also rebuilding the form to display errors.
SOURCE: https://docs.flutter.dev/cookbook/forms/validation

LANGUAGE: APIDOC
CODE:
```
FormState Class:
  Description: Automatically created by Flutter when building a Form. Provides methods to interact with the form's state.
  Methods:
    validate():
      Description: Runs the validator() function for each text field in the form.
      Returns:
        bool:
          - true: If all text fields are valid.
          - false: If any text field contains errors (also rebuilds the form to display error messages).
```

----------------------------------------

TITLE: Initialize Flutter Animation Controller and Tween
DESCRIPTION: This snippet demonstrates how to set up an AnimationController and a Tween animation in a Flutter State class. It uses SingleTickerProviderStateMixin to provide the vsync for the controller, which is essential for managing animation frames. The animation is configured to last 3000 milliseconds with an easeIn curve, animating a double value from 0.0 to 1.0.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
class _LogoFadeState extends State<LogoFade>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);
  }
```

----------------------------------------

TITLE: Decode JSON String to User Object Manually
DESCRIPTION: This snippet demonstrates how to decode a JSON string into a `User` object using the `User.fromJson()` constructor. It first parses the JSON string into a `Map<String, dynamic>` and then passes it to the constructor, leveraging the manual serialization logic defined within the `User` model class.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
final user = User.fromJson(userMap);

print('Howdy, ${user.name}!');
print('We sent the verification link to ${user.email}.');
```

----------------------------------------

TITLE: Flutter Performance: Lazy Loading for Grids and Lists
DESCRIPTION: Best practice for building large grids and lists in Flutter using lazy builder methods to ensure only visible portions are built at startup, improving performance.
SOURCE: https://docs.flutter.dev/perf/best-practices

LANGUAGE: APIDOC
CODE:
```
Lazy Builders for Grids and Lists:
- Use ListView.builder for large lists to build only visible items.
  API Link: https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html
- Related resources:
  - Working with long lists: /cookbook/lists/long-lists
  - Creating a ListView that loads one page at a time (community article): https://medium.com/saugo360/flutter-creating-a-listview-that-loads-one-page-at-a-time-c5c91b6fabd3
```

----------------------------------------

TITLE: Save integer data using SharedPreferences
DESCRIPTION: This snippet demonstrates how to save an integer value to persistent storage. First, obtain an instance of `SharedPreferences`, then use a setter method like `setInt` to store the key-value pair. The data is updated synchronously in memory and then persisted to disk.
SOURCE: https://docs.flutter.dev/cookbook/persistence/key-value

LANGUAGE: dart
CODE:
```
// Load and obtain the shared preferences for this app.
final prefs = await SharedPreferences.getInstance();

// Save the counter value to persistent storage under the 'counter' key.
await prefs.setInt('counter', counter);
```

----------------------------------------

TITLE: Complete Flutter Example for Shared Preferences Counter
DESCRIPTION: This Dart code provides a full Flutter application that uses `shared_preferences` to persist a simple counter. The counter value is loaded when the app starts and saved every time it is incremented by a Floating Action Button, demonstrating basic data persistence.
SOURCE: https://docs.flutter.dev/cookbook/persistence/key-value

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shared preferences demo',
      home: MyHomePage(title: 'Shared preferences demo'),
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
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  /// Load the initial counter value from persistent storage on start,
  /// or fallback to 0 if it doesn't exist.
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  /// After a click, increment the counter state and
  /// asynchronously save it to persistent storage.
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times: '),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Convert data to widgets using ListView.builder
DESCRIPTION: This snippet demonstrates how to use `ListView.builder` in Flutter to dynamically convert a list of data items into a list of widgets. It utilizes an `itemBuilder` function to create appropriate widgets based on the type of each item, such as `ListTile`.
SOURCE: https://docs.flutter.dev/cookbook/lists/mixed-list

LANGUAGE: Dart
CODE:
```
ListView.builder(
  // Let the ListView know how many items it needs to build.
  itemCount: items.length,
  // Provide a builder function. This is where the magic happens.
  // Convert each item into a widget based on the type of item it is.
  itemBuilder: (context, index) {
    final item = items[index];

    return ListTile(
      title: item.buildTitle(context),
      subtitle: item.buildSubtitle(context),
    );
  },
)
```

----------------------------------------

TITLE: Flutter: Nesting Widgets for Layout and Properties
DESCRIPTION: Illustrates how Flutter uses nested widgets, such as Padding and Text, to define UI components and their properties. Each element, including properties, is a widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: dart
CODE:
```
Padding(                         // <-- This is a Widget
  padding: EdgeInsets.all(10.0), // <-- So is this
  child: Text("Hello, World!"),  // <-- This, too
)));
```

----------------------------------------

TITLE: Write Unit Tests for HTTP Success and Error Scenarios in Flutter
DESCRIPTION: This snippet provides comprehensive unit tests for the `fetchAlbum` function, covering both successful HTTP responses and error conditions. It utilizes `mockito`'s `when().thenAnswer()` to control the `MockClient`'s behavior, asserting the correct return type for success and an exception for failure.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/mocking

LANGUAGE: Dart
CODE:
```
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
```

----------------------------------------

TITLE: Performing GET Network Requests in Flutter with http Package
DESCRIPTION: Illustrates how to make an asynchronous GET request to a URL using the `http` package, parse the JSON response, and update the application's state within a Flutter widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Implement Offline-First User Profile Retrieval with Fallback
DESCRIPTION: This getUserProfile method within the UserProfileRepository demonstrates an offline-first approach. It first attempts to fetch the user profile from the remote API. If the network request fails, it falls back to retrieving the profile from the local database, ensuring data availability even when offline.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
Future<UserProfile> getUserProfile() async {
  try {
    // Fetch the user profile from the API
    final apiUserProfile = await _apiClientService.getUserProfile();
    //Update the database with the API result
    await _databaseService.updateUserProfile(apiUserProfile);

    return apiUserProfile;
  } catch (e) {
    // If the network call failed,
    // fetch the user profile from the database
    final databaseUserProfile = await _databaseService.fetchUserProfile();

    // If the user profile was never fetched from the API
    // it will be null, so throw an  error
    if (databaseUserProfile != null) {
      return databaseUserProfile;
    } else {
      // Handle the error
      throw Exception('User profile not found');
    }
  }
}
```

----------------------------------------

TITLE: Provide a ChangeNotifier instance using ChangeNotifierProvider in Flutter
DESCRIPTION: This Dart code shows how to use `ChangeNotifierProvider` to make a `CartModel` instance available to the widget tree. It's typically placed high up in the widget tree, like in the `main` function, to ensure descendant widgets can access the state without polluting the scope unnecessarily.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}
```

----------------------------------------

TITLE: Demonstrating 'Vertical viewport was given unbounded height' error
DESCRIPTION: This Dart code snippet illustrates a common Flutter layout error where a `ListView` is placed directly inside a `Column` without any height constraints. Since `ListView` attempts to expand indefinitely in the scrolling direction and `Column` does not impose default height limits on its children, this combination leads to the 'Vertical viewport was given unbounded height' assertion.
SOURCE: https://docs.flutter.dev/testing/common-errors

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        const Text('Header'),
        ListView(
          children: const <Widget>[
            ListTile(leading: Icon(Icons.map), title: Text('Map')),
            ListTile(leading: Icon(Icons.subway), title: Text('Subway')),
          ],
        ),
      ],
    ),
  );
}
```

----------------------------------------

TITLE: Fetch Network Data Asynchronously in Flutter
DESCRIPTION: This Dart function demonstrates fetching data from a remote API using http.get and updating a widget's state. It utilizes async/await to perform the network request off the main UI thread and setState to trigger a UI rebuild once data is received.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Navigate to a Named Flutter Route with Arguments
DESCRIPTION: This `ElevatedButton` example demonstrates how to navigate to a named route (`ExtractArgumentsScreen.routeName`) using `Navigator.pushNamed()`. It passes `ScreenArguments` as an optional `arguments` parameter, which the destination screen can then extract.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments

LANGUAGE: dart
CODE:
```
// A button that navigates to a named route.
// The named route extracts the arguments
// by itself.
ElevatedButton(
  onPressed: () {
    // When the user taps the button,
    // navigate to a named route and
    // provide the arguments as an optional
    // parameter.
    Navigator.pushNamed(
      context,
      ExtractArgumentsScreen.routeName,
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );
  },
  child: const Text('Navigate to screen that extracts arguments'),
),
```

----------------------------------------

TITLE: Process HTTP Response and Update State in Flutter
DESCRIPTION: This Dart code snippet illustrates how to send an HTTP request, await its response, decode the response body as UTF-8, parse it as JSON to extract an 'origin' IP address, and then update a '_ipAddress' state variable within a 'setState' call to reflect changes in the UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  final ip = jsonDecode(responseBody)['origin'] as String;
  setState(() {
    _ipAddress = ip;
  });
}
```

----------------------------------------

TITLE: Implement Staggered Animations and Sliding Menu in Flutter
DESCRIPTION: This Flutter code snippet provides a complete application demonstrating a sliding drawer menu with an AppBar icon that toggles its state, and a 'Menu' widget that uses staggered animations for its list items. It utilizes AnimationController, SingleTickerProviderStateMixin, and various Flutter widgets to create a dynamic and interactive UI.
SOURCE: https://docs.flutter.dev/cookbook/effects/staggered-menu-animation

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleStaggeredAnimations(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ExampleStaggeredAnimations extends StatefulWidget {
  const ExampleStaggeredAnimations({super.key});

  @override
  State<ExampleStaggeredAnimations> createState() =>
      _ExampleStaggeredAnimationsState();
}

class _ExampleStaggeredAnimationsState extends State<ExampleStaggeredAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(children: [_buildContent(), _buildDrawer()]),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Flutter Menu', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        AnimatedBuilder(
          animation: _drawerSlideController,
          builder: (context, child) {
            return IconButton(
              onPressed: _toggleDrawer,
              icon: _isDrawerOpen() || _isDrawerOpening()
                  ? const Icon(Icons.clear, color: Colors.black)
                  : const Icon(Icons.menu, color: Colors.black),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContent() {
    // Put page content here.
    return const SizedBox();
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : const Menu(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Declarative style',
    'Premade widgets',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration =
      _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [_buildFlutterLogo(), _buildContent()],
      ),
    );
  }

  Widget _buildFlutterLogo() {
```

----------------------------------------

TITLE: Navigate Imperatively using Navigator.push with MaterialPageRoute
DESCRIPTION: This example illustrates how to perform imperative navigation by pushing a new Route onto the navigator's stack. MaterialPageRoute is commonly used to create a full-screen modal route with platform-adaptive transitions, requiring a WidgetBuilder to construct the new screen.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const UsualNavScreen()),
```

----------------------------------------

TITLE: Flutter: Define Icons Row with Nested Columns and Text Styles
DESCRIPTION: This Dart code sets `descTextStyle` for consistent text styling and `iconList` for the icons row. `iconList` uses `DefaultTextStyle.merge` to apply the style to a `Container` holding a `Row`. This row contains three `Column` widgets, each with an icon and two lines of text, demonstrating nested layout for displaying feature details.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: dart
CODE:
```
const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            const Text('PREP:'),
            const Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            const Text('COOK:'),
            const Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            const Text('FEEDS:'),
            const Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);
```

----------------------------------------

TITLE: Display Asynchronous Data with FutureBuilder in Flutter
DESCRIPTION: This Flutter widget uses FutureBuilder to asynchronously display the result of an HTTP request. It takes '_futureAlbum' as its future and provides a builder function to render different UI states: displaying the album title on success (snapshot.hasData), showing an error message (snapshot.hasError), or a CircularProgressIndicator while loading. It emphasizes the importance of throwing exceptions for errors rather than returning null to ensure the loading indicator behaves correctly.
SOURCE: https://docs.flutter.dev/cookbook/networking/send-data

LANGUAGE: dart
CODE:
```
FutureBuilder<Album>(
  future: _futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.title);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    return const CircularProgressIndicator();
  },
)
```

----------------------------------------

TITLE: Create Listener Function for TextEditingController in Flutter
DESCRIPTION: Illustrates how to create a private method within a Flutter `State` class that can retrieve and print the current text value from a `TextEditingController`. This function will be called whenever the text field's content changes.
SOURCE: https://docs.flutter.dev/cookbook/forms/text-field-changes

LANGUAGE: dart
CODE:
```
void _printLatestValue() {
  final text = myController.text;
  print('Second text field: $text (${text.characters.length})');
}
```

----------------------------------------

TITLE: Customize Flutter App Theme with MaterialApp
DESCRIPTION: Demonstrates how to declare a top-level `MaterialApp` widget and customize its theme using a `ThemeData` object. This example sets the `colorScheme` from a deep purple seed color and changes the `textSelectionColor` to red, showcasing basic Material Design theme customization.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: const SampleAppPage(),
    );
  }
}
```

----------------------------------------

TITLE: Defining widget layout with padding in Flutter
DESCRIPTION: This snippet demonstrates how to structure widgets in a tree to define UI layout in Flutter, contrasting with Android's XML layouts. It shows a basic Scaffold with an AppBar, a centered ElevatedButton, and applies padding using EdgeInsets.only().
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sample App')),
    body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 20, right: 30),
        ),
        onPressed: () {},
        child: const Text('Hello'),
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Applying Flutter Theme Data with InheritedWidget
DESCRIPTION: Illustrates how Flutter's `Theme.of(context)` method, which leverages `InheritedWidget`, is used to access and apply application-wide visual theme properties like colors and text styles to widgets.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: dart
CODE:
```
Container(
  color: Theme.of(context).secondaryHeaderColor,
  child: Text(
    'Text with a background color',
    style: Theme.of(context).textTheme.titleLarge,
  ),
);
```

----------------------------------------

TITLE: Access Shared Preferences in Flutter
DESCRIPTION: This snippet demonstrates how to use the `shared_preferences` plugin in Flutter to store and retrieve simple key-value pairs, similar to Android's SharedPreferences API. It shows an example of incrementing an integer counter and persisting it across app launches.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Counter'),
          ),
        ),
      ),
    ),
  );
}

Future<void> _incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  await prefs.setInt('counter', counter);
}
```

----------------------------------------

TITLE: Build and Use Custom Widgets in Flutter by Composition
DESCRIPTION: Illustrates the Flutter approach to building custom widgets by composing smaller widgets, rather than extending existing ones. This example defines a CustomButton that wraps an ElevatedButton and demonstrates how to use it like any other Flutter widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}

@override
Widget build(BuildContext context) {
  return const Center(child: CustomButton('Hello'));
}
```

----------------------------------------

TITLE: Implement Asynchronous Subscribe Method in ViewModel
DESCRIPTION: Defines the `subscribe()` method within `SubscribeButtonViewModel`. This asynchronous method implements optimistic state updates by immediately setting `subscribed` to `true` and notifying listeners. It then attempts the actual subscription via a repository call, reverting the state and setting `error` to `true` if the operation fails.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/optimistic-state

LANGUAGE: dart
CODE:
```
// Subscription action
Future<void> subscribe() async {
  // Ignore taps when subscribed
  if (subscribed) {
    return;
  }

  // Optimistic state.
  // It will be reverted if the subscription fails.
  subscribed = true;
  // Notify listeners to update the UI
  notifyListeners();

  try {
    await subscriptionRepository.subscribe();
  } catch (e) {
    print('Failed to subscribe: $e');
    // Revert to the previous state
    subscribed = false;
    // Set the error state
    error = true;
  } finally {
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Flutter: Encapsulate Policy Logic in a Dedicated Class
DESCRIPTION: Illustrates the best practice of moving platform-specific policy logic, like `shouldAllowPurchaseClick`, into a dedicated `Policy` class. This encapsulation enhances modularity, allows for easier mocking in widget tests, and simplifies future modifications to policy rules without affecting dependent UI components.
SOURCE: https://docs.flutter.dev/ui/adaptive-responsive/capabilities

LANGUAGE: dart
CODE:
```
class Policy {

  bool shouldAllowPurchaseClick() {
    // Banned by Apple App Store guidelines.
    return !Platform.isIOS;
  }
}
```

----------------------------------------

TITLE: Implementing Form Widgets with TextFormField Validation in Flutter
DESCRIPTION: This Dart code demonstrates how to set up a Form widget in Flutter to manage multiple input fields. It includes a TextFormField with a validator function to perform basic input validation, ensuring the input contains an '@' symbol. A GlobalKey (formKey) is used to manage the form state for validation and saving.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value != null && value.contains('@')) {
              return null;
            }
```

----------------------------------------

TITLE: Full Flutter app with basic ListView example
DESCRIPTION: This complete, runnable Flutter application showcases how to integrate a basic ListView within a Material App. It sets up a Scaffold with an AppBar and populates the body with a ListView containing several ListTile widgets, providing an interactive demonstration of list display.
SOURCE: https://docs.flutter.dev/cookbook/lists/basic-list

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView(
          children: const <Widget>[
            ListTile(leading: Icon(Icons.map), title: Text('Map')),
            ListTile(leading: Icon(Icons.photo_album), title: Text('Album')),
            ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
          ],
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Center a Widget in Flutter
DESCRIPTION: Demonstrates how to horizontally and vertically center a single child widget using the `Center` widget in Flutter. This is a common way to position elements on the screen.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: Dart
CODE:
```
Widget build(BuildContext context) {
  return Center(
    child: BorderedImage(),
  );
}
```

----------------------------------------

TITLE: Complete example for authenticated data fetching (Dart)
DESCRIPTION: This comprehensive Dart example illustrates how to fetch data from a web service with authorization headers, parse the JSON response, and map it to a custom `Album` class. It includes error handling for parsing failures and demonstrates the full lifecycle of an authenticated API call.
SOURCE: https://docs.flutter.dev/cookbook/networking/authenticated-requests

LANGUAGE: Dart
CODE:
```
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return Album.fromJson(responseJson);
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
```

----------------------------------------

TITLE: Flutter: Displaying ToDo List with ListenableBuilder
DESCRIPTION: This snippet demonstrates how to use `ListenableBuilder` to react to changes in the `TodoListViewModel` and display a list of ToDo items. Each item is rendered as a `ListTile` with a delete button.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/sql

LANGUAGE: dart
CODE:
```
ListenableBuilder(
  listenable: widget.viewModel,
  builder: (context, child) {
    return ListView.builder(
      itemCount: widget.viewModel.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.viewModel.todos[index];
        return ListTile(
          title: Text(todo.task),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.viewModel.delete.execute(todo.id),
          ),
        );
      },
    );
  },
)
```

----------------------------------------

TITLE: Verify Button Tap Adds Item in Flutter Widget Test
DESCRIPTION: This Dart test snippet extends the previous one by showing how to simulate a tap on a `FloatingActionButton` using `tester.tap()`. After the tap, `tester.pump()` is used to rebuild the widget tree, and an assertion verifies that the new todo item appears on screen.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/tap-drag

LANGUAGE: dart
CODE:
```
testWidgets('Add and remove a todo', (tester) async {
  // Enter text code...

  // Tap the add button.
  await tester.tap(find.byType(FloatingActionButton));

  // Rebuild the widget after the state has changed.
  await tester.pump();

  // Expect to find the item on screen.
  expect(find.text('hi'), findsOneWidget);
});
```

----------------------------------------

TITLE: Updating UI Dynamically with StatefulWidget
DESCRIPTION: This example illustrates how to use a `StatefulWidget` to create dynamic UI that responds to user interactions. It shows how to wrap a `Text` widget within a `StatefulWidget` and update its content using the `setState()` method when a `FloatingActionButton` is pressed, demonstrating Flutter's state management for UI updates.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  /// Default placeholder text
  String textToShow = 'I Like Flutter';

  void _updateText() {
    setState(() {
      // Update the text
      textToShow = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Efficiently Update Flutter ListView with ListView.builder
DESCRIPTION: Presents the recommended and efficient method for building and updating dynamic lists in Flutter using `ListView.builder`. This approach is ideal for large datasets as it only builds items that are visible. It demonstrates how to use `itemCount` and `itemBuilder` and efficiently add new items without recreating the entire list.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(padding: const EdgeInsets.all(10), child: Text('Row $i')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) {
          return getRow(position);
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter: Create a Stateless Widget for Todo Detail Screen (DetailScreen)
DESCRIPTION: Defines `DetailScreen`, a `StatelessWidget` to display detailed information for a single `Todo`. It requires a `Todo` object in its constructor and shows the todo's title in the app bar and its description in the body. This screen provides a dedicated view for individual todo details.
SOURCE: https://docs.flutter.dev/cookbook/navigation/passing-data

LANGUAGE: dart
CODE:
```
class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Dart compute() Method for Background Processing
DESCRIPTION: Documentation for the compute() method in Flutter's foundation library, used to run expensive Dart async functions on a separate isolate to prevent UI thread blocking.
SOURCE: https://docs.flutter.dev/perf/faq

LANGUAGE: APIDOC
CODE:
```
compute method:
  Package: flutter/foundation
  Purpose: Runs a function on a separate isolate and returns its result.
  Signature: Future<R> compute<Q, R>(ComputeCallback<Q, R> callback, Q message, {String? debugLabel})
  Parameters:
    callback: The function to run in the new isolate.
    message: The message to pass to the callback function.
  Returns: A Future that completes with the result of the callback.
  Usage: Ideal for offloading CPU-intensive tasks like JSON parsing or image processing.
  Reference: https://api.flutter.dev/flutter/foundation/compute-constant.html
```

----------------------------------------

TITLE: Flutter Widget Composition Example
DESCRIPTION: This snippet illustrates how Flutter represents UI components and their properties as 'widgets'. It shows a nested structure where 'Padding' is a widget, and its 'child' is a 'Text' widget, both acting as UI components or properties.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/swiftui-devs

LANGUAGE: dart
CODE:
```
Padding(                         // <-- This is a Widget
  padding: EdgeInsets.all(10.0), // <-- So is this
  child: Text("Hello, World!"),  // <-- This, too
)))
```

----------------------------------------

TITLE: Flutter: Toggle Widget Visibility with FloatingActionButton
DESCRIPTION: This snippet demonstrates how to display a FloatingActionButton that toggles a boolean state variable. When pressed, the button calls setState() to flip the boolean value, prompting Flutter to rebuild the UI and reflect the visibility change.
SOURCE: https://docs.flutter.dev/cookbook/animation/opacity-animation

LANGUAGE: dart
CODE:
```
FloatingActionButton(
  onPressed: () {
    // Call setState. This tells Flutter to rebuild the
    // UI with the changes.
    setState(() {
      _visible = !_visible;
    });
  },
  tooltip: 'Toggle Opacity',
  child: const Icon(Icons.flip),
)
```

----------------------------------------

TITLE: Dart: ApiClientService with Exception Handling
DESCRIPTION: This class demonstrates an API client service method, `getUserProfile`, that performs an HTTP GET request. It handles successful responses by parsing JSON and throws `HttpException` for non-200 status codes. It also implicitly handles other exceptions like network issues or JSON parsing errors within its `try-finally` block, ensuring the client is closed.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
class ApiClientService {
  // ···

  Future<UserProfile> getUserProfile() async {
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return UserProfile.fromJson(jsonDecode(stringData));
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
```

----------------------------------------

TITLE: Define named routes in Flutter MaterialApp
DESCRIPTION: This Dart code demonstrates how to configure named routes within a Flutter MaterialApp widget. It sets the initialRoute to '/' to specify the starting screen and defines a routes map that associates named paths ('/' and '/second') with their corresponding widget builders (FirstScreen and SecondScreen). A warning is included to avoid using the home property when initialRoute is defined.
SOURCE: https://docs.flutter.dev/cookbook/navigation/named-routes

LANGUAGE: dart
CODE:
```
MaterialApp(
  title: 'Named Routes Demo',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => const FirstScreen(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/second': (context) => const SecondScreen(),
  },
)
```

----------------------------------------

TITLE: Flutter: Handle I/O-bound Work with Async/Await
DESCRIPTION: For I/O-bound operations like network requests or disk access, declare the function as `async` and `await` long-running tasks. This approach is suitable for operations that spend most of their time waiting for external resources, preventing the UI from freezing.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Define an App-Wide Theme in Flutter
DESCRIPTION: This Dart code snippet demonstrates how to define an app-wide theme by setting the `theme` property of the `MaterialApp` constructor. It illustrates configuring `colorScheme` for default brightness and colors, and `textTheme` for specifying default text styling using `TextStyle` and `GoogleFonts`.
SOURCE: https://docs.flutter.dev/cookbook/design/themes

LANGUAGE: Dart
CODE:
```
MaterialApp(
  title: appName,
  theme: ThemeData(
    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      // ···
      brightness: Brightness.dark,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: GoogleFonts.oswald(
        fontSize: 30,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: GoogleFonts.merriweather(),
      displaySmall: GoogleFonts.pacifico(),
    ),
  ),
  home: const MyHomePage(title: appName),
);
```

----------------------------------------

TITLE: Flutter Container Sizing with Padding and Nested Child
DESCRIPTION: Illustrates how a parent Container with padding and a child sizes itself to its child's size plus its own padding. The red Container becomes visible due to the padding, while the inner green Container maintains its fixed size.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Center(
   child: Container(color: red
      padding: const EdgeInsets.all(20),
      child: Container(color: green, width: 30, height: 30)))
```

----------------------------------------

TITLE: Complete Flutter Camera App: Take and Display Picture
DESCRIPTION: This comprehensive Dart code provides a full Flutter application that initializes the camera, allows users to take a picture, and then displays the captured image on a new screen. It includes `CameraController` setup, `FutureBuilder` for camera preview, and navigation for displaying the image.
SOURCE: https://docs.flutter.dev/cookbook/plugins/picture-using-camera

LANGUAGE: Dart
CODE:
```
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
```

----------------------------------------

TITLE: Interactive Flutter Layout Examples Application
DESCRIPTION: This extensive Flutter application provides an interactive viewer for 29 different layout examples. It initializes a `HomePage` that orchestrates the display of various `Example` widgets, managed by `FlutterLayoutArticle`. The UI includes navigation to switch between examples and dynamically displays the code and explanation for the currently selected layout, demonstrating a robust pattern for showcasing multiple UI patterns.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const HomePage());

const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = TextStyle(fontSize: 30);

//////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlutterLayoutArticle([
      Example1(),
      Example2(),
      Example3(),
      Example4(),
      Example5(),
      Example6(),
      Example7(),
      Example8(),
      Example9(),
      Example10(),
      Example11(),
      Example12(),
      Example13(),
      Example14(),
      Example15(),
      Example16(),
      Example17(),
      Example18(),
      Example19(),
      Example20(),
      Example21(),
      Example22(),
      Example23(),
      Example24(),
      Example25(),
      Example26(),
      Example27(),
      Example28(),
      Example29(),
    ]);
  }
}

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
  const Example({super.key});

  String get code;

  String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
  const FlutterLayoutArticle(this.examples, {super.key});

  final List<Example> examples;

  @override
  State<FlutterLayoutArticle> createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late Widget example;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = const Example1().code;
    explanation = const Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: const Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      child: widget.examples[count - 1],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 273,
                    color: Colors.grey[50],
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        key: ValueKey(count),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(child: Text(code)),
                              const SizedBox(height: 15),
                              Text(
                                explanation,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
```

----------------------------------------

TITLE: Custom Flutter App Structure with AppBar and Scaffold
DESCRIPTION: This comprehensive Dart code snippet illustrates how to construct a basic Flutter application using custom StatelessWidget classes for an AppBar and a Scaffold. It demonstrates the use of Container, Row, Column, Text, IconButton, and Expanded widgets to create a structured UI. The main function initializes the app with MaterialApp and SafeArea, showcasing a complete runnable example of a custom Flutter layout.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child
          // to fill the available space.
          Expanded(child: title),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'Example title',
              style:
                  Theme.of(context) //
                      .primaryTextTheme
                      .titleLarge,
            ),
          ),
          const Expanded(child: Center(child: Text('Hello, world!'))),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(child: MyScaffold()),
    ),
  );
}
```

----------------------------------------

TITLE: Declare Dart Package Dependencies with Flexible Version Ranges in pubspec.yaml
DESCRIPTION: This YAML snippet demonstrates best practices for declaring Dart package dependencies in `pubspec.yaml`. It contrasts using flexible version ranges (e.g., `^5.4.0`) which allow for minor updates, against strict version pinning (e.g., `'5.4.3'`) which can lead to dependency conflicts. Adopting version ranges helps pub automatically resolve compatible versions.
SOURCE: https://docs.flutter.dev/packages-and-plugins/using-packages

LANGUAGE: yaml
CODE:
```
dependencies:
  url_launcher: ^5.4.0    # Good, any version >= 5.4.0 but < 6.0.0
  image_picker: '5.4.3'   # Not so good, only version 5.4.3 works.
```

----------------------------------------

TITLE: Exposing a ValueChanged Callback in a Widget
DESCRIPTION: This `MyCounter` StatefulWidget demonstrates how to expose a `ValueChanged<int>` callback named `onChanged` in its constructor. This allows parent widgets to subscribe to and react to changes in the counter's internal state.
SOURCE: https://docs.flutter.dev/get-started/fwe/state-management

LANGUAGE: dart
CODE:
```
class MyCounter extends StatefulWidget {
  const MyCounter({super.key, required this.onChanged});

  final ValueChanged<int> onChanged;

  @override
  State<MyCounter> createState() => _MyCounterState();
}
```

----------------------------------------

TITLE: Unwrapping Result object in Flutter ViewModel
DESCRIPTION: Demonstrates how a `UserProfileViewModel` unwraps a `Result` object, which can be either `Ok` (containing a value) or `Error` (containing an exception). This pattern, using a `switch` statement on a `sealed` class, ensures all outcomes are explicitly handled, preventing uncaught exceptions and improving code robustness.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
class UserProfileViewModel extends ChangeNotifier {
  // ···

  UserProfile? userProfile;

  Exception? error;

  Future<void> load() async {
    final result = await userProfileRepository.getUserProfile();
    switch (result) {
      case Ok<UserProfile>():
        userProfile = result.value;
      case Error<UserProfile>():
        error = result.error;
    }
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Create a Flutter module for Android
DESCRIPTION: This snippet demonstrates how to create a new Flutter module project within an existing Android application's directory structure. It uses the `flutter create -t module` command, which generates a Flutter project with an `.android/` subfolder for standalone execution and embedding. Important notes include avoiding source control for `.android/` and ensuring `flutter.androidPackage` differs from the host app's package name to prevent Dex merging issues.
SOURCE: https://docs.flutter.dev/add-to-app/android/project-setup

LANGUAGE: bash
CODE:
```
cd some/path/
flutter create -t module --org com.example flutter_module
```

----------------------------------------

TITLE: Build Flutter Module as Android Archive (AAR)
DESCRIPTION: This command builds the Flutter module into an Android Archive (AAR) package, creating a local Maven repository with AAR and POM artifacts. This allows the host Android application to depend on the Flutter module without requiring the Flutter SDK to be installed on the build machine. The output shows the generated directory structure containing debug, profile, and release builds.
SOURCE: https://docs.flutter.dev/add-to-app/android/project-setup

LANGUAGE: Shell
CODE:
```
cd some/path/flutter_module
flutter build aar
```

LANGUAGE: Text
CODE:
```
build/host/outputs/repo
└── com
    └── example
        └── flutter_module
            ├── flutter_release
            │   ├── 1.0
            │   │   ├── flutter_release-1.0.aar
            │   │   ├── flutter_release-1.0.aar.md5
            │   │   ├── flutter_release-1.0.aar.sha1
            │   │   ├── flutter_release-1.0.pom
            │   │   ├── flutter_release-1.0.pom.md5
            │   │   └── flutter_release-1.0.pom.sha1
            │   ├── maven-metadata.xml
            │   ├── maven-metadata.xml.md5
            │   └── maven-metadata.xml.sha1
            ├── flutter_profile
            │   ├── ...
            └── flutter_debug
                └── ...
```

----------------------------------------

TITLE: Dart: Implement LlmProvider with Configuration Support
DESCRIPTION: Demonstrates how to implement the `LlmProvider` interface in Dart to support full configurability by allowing the underlying `GenerativeModel` to be passed as a constructor parameter, ensuring future compatibility and user control over model settings.
SOURCE: https://docs.flutter.dev/ai-toolkit/custom-llm-providers

LANGUAGE: dart
CODE:
```
class GeminiProvider extends LlmProvider ... {
  @immutable
  GeminiProvider({
    required GenerativeModel model,
    ...
  })  : _model = model,
        ...

  final GenerativeModel _model;
  ...
}
```

----------------------------------------

TITLE: Create Basic Scroll View in Flutter using ListView
DESCRIPTION: Illustrates the simplest way to create a scrollable area in Flutter using the `ListView` widget. This widget acts as both a scroll view and a vertical layout container, allowing multiple widgets to be displayed and scrolled if they exceed the available screen space.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

----------------------------------------

TITLE: Sizing Row Children with Expanded Widget in Flutter
DESCRIPTION: This example shows how to use the `Expanded` widget to make children within a `Row` or `Column` automatically size to fit the available space, preventing overflow. Each child wrapped with `Expanded` will take an equal share of the remaining space by default.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: dart
CODE:
```
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(child: Image.asset('images/pic1.jpg')),
    Expanded(child: Image.asset('images/pic2.jpg')),
    Expanded(child: Image.asset('images/pic3.jpg')),
  ],
);
```

----------------------------------------

TITLE: Implement a Stateful Flutter Shopping List Application
DESCRIPTION: This code defines a complete Flutter application for a shopping list. It includes the `ShoppingList` StatefulWidget, its associated `_ShoppingListState` class for managing the shopping cart, and the `main` function to run the app. It demonstrates how to use `setState` to trigger UI rebuilds when the cart content changes.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
  const ShoppingList({required this.products, super.key});

  final List<Product> products;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'Shopping App',
      home: ShoppingList(
        products: [
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Dart Result Class Implementation for Error Handling
DESCRIPTION: This Dart code defines a `sealed` `Result` class, which can be either an `Ok` (success with a value) or an `Error` (failure with an exception). It provides factory constructors for creating `Ok` and `Error` instances and demonstrates how to evaluate the result using a switch statement, promoting explicit error checking and improved control flow.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;
}

/// A successful [Result] with a returned [value].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// An error [Result] with a resulting [error].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// The resulting error of this result.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
```

----------------------------------------

TITLE: Update Flutter App Version in pubspec.yaml
DESCRIPTION: Modify the `version` field in `pubspec.yaml` to set the app's user-facing version and an optional build number. This directly influences `CFBundleShortVersionString` and `CFBundleVersion` for iOS builds.
SOURCE: https://docs.flutter.dev/deployment/ios

LANGUAGE: yaml
CODE:
```
version: 1.0.0+1
```

----------------------------------------

TITLE: Trace Dart Code Performance with Timeline Utilities
DESCRIPTION: Demonstrates how to use `dart:developer`'s `Timeline` utilities to perform custom performance traces and measure wall or CPU time for arbitrary segments of Dart code. This helps in identifying performance bottlenecks within specific functions or code blocks.
SOURCE: https://docs.flutter.dev/testing/code-debugging

LANGUAGE: Dart
CODE:
```
import 'dart:developer';

void main() {
  Timeline.startSync('interesting function');
  // iWonderHowLongThisTakes();
  Timeline.finishSync();
}
```

----------------------------------------

TITLE: Manually Add Flutter Package Dependency via `pubspec.yaml` and `flutter pub get`
DESCRIPTION: This snippet illustrates the manual process of adding a package dependency. It involves editing the `pubspec.yaml` file to declare the dependency, then running `flutter pub get` to fetch it. An import statement in Dart code and a full app restart might be necessary for packages with platform-specific code.
SOURCE: https://docs.flutter.dev/packages-and-plugins/using-packages

LANGUAGE: YAML
CODE:
```
dependencies:
  css_colors: ^1.0.0
```

LANGUAGE: Shell
CODE:
```
flutter pub get
```

----------------------------------------

TITLE: Exposing Services and Repositories with MultiProvider in Flutter
DESCRIPTION: Illustrates how to use Flutter's `MultiProvider` to make various API clients, services, and repositories available throughout the widget tree. Services are typically injected into repositories using `context.read()`.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/dependency-injection

LANGUAGE: dart
CODE:
```
runApp(
  MultiProvider(
    providers: [
      Provider(create: (context) => AuthApiClient()),
      Provider(create: (context) => ApiClient()),
      Provider(create: (context) => SharedPreferencesService()),
      ChangeNotifierProvider(
        create: (context) => AuthRepositoryRemote(
          authApiClient: context.read(),
          apiClient: context.read(),
          sharedPreferencesService: context.read(),
        ) as AuthRepository,
      ),
      Provider(create: (context) =>
        DestinationRepositoryRemote(
          apiClient: context.read(),
        ) as DestinationRepository,
      ),
      Provider(create: (context) =>
        ContinentRepositoryRemote(
          apiClient: context.read(),
        ) as ContinentRepository,
      ),
      // In the Compass app, additional service and repository providers live here.
    ],
    child: const MainApp(),
  ),
);
```

----------------------------------------

TITLE: Run Flutter Doctor Command
DESCRIPTION: This command validates that all components of a complete Flutter development environment for Windows are correctly installed and configured. It provides a summary of the setup status.
SOURCE: https://docs.flutter.dev/get-started/install/windows/desktop

LANGUAGE: PowerShell
CODE:
```
PS C:> flutter doctor
```

----------------------------------------

TITLE: Flutter: Create a Stateless Widget for Todo List Screen (TodosScreen)
DESCRIPTION: Defines `TodosScreen`, a `StatelessWidget` displaying a list of `Todo` items. It uses `ListView.builder` to render each todo's title, requiring the list of `Todo` objects in its constructor. This screen serves as the main view for all todos.
SOURCE: https://docs.flutter.dev/cookbook/navigation/passing-data

LANGUAGE: dart
CODE:
```
class TodosScreen extends StatelessWidget {
  // Requiring the list of todos.
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      //passing in the ListView.builder
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(todos[index].title));
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Validate Flutter Installation
DESCRIPTION: Run this command in your preferred terminal to verify that Flutter is correctly installed and configured. It provides a detailed report of your Flutter setup, including installed tools and any missing dependencies.
SOURCE: https://docs.flutter.dev/install/with-vs-code

LANGUAGE: Shell
CODE:
```
flutter doctor -v
```

----------------------------------------

TITLE: Extend SingleTickerProviderStateMixin and initialize AnimationController
DESCRIPTION: This snippet modifies the `_DraggableCardState` class to extend `SingleTickerProviderStateMixin`, which is necessary for the `AnimationController`. It then initializes the `AnimationController` in `initState` and disposes of it in `dispose`.
SOURCE: https://docs.flutter.dev/cookbook/animation/physics-simulation

LANGUAGE: dart
CODE:
```
class _DraggableCardState extends State<DraggableCard> {
class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
```

----------------------------------------

TITLE: Create New Flutter Project in IDE
DESCRIPTION: Instructions for creating a new Flutter project from the starter app template in both Android Studio and IntelliJ IDEA. The process involves specifying the Flutter SDK path, project details, and optionally setting a company domain for future publishing.
SOURCE: https://docs.flutter.dev/tools/android-studio

LANGUAGE: Android Studio IDE Configuration
CODE:
```
1. In the IDE, click **New Flutter Project** from the **Welcome** window or **File > New > New Flutter Project** from the main IDE window.- Specify the **Flutter SDK path** and click **Next**.- Enter your desired **Project name**, **Description**, and **Project location**.- If you might publish this app, [set the company domain](#set-the-company-domain).- Click **Finish**.
```

LANGUAGE: IntelliJ IDEA IDE Configuration
CODE:
```
1. In the IDE, click **New Project** from the **Welcome** window or **File > New > Project** from the main IDE window.- Select **Flutter** from the **Generators** list in the left panel- Specify the **Flutter SDK path** and click **Next**.- Enter your desired **Project name**, **Description**, and **Project location**.- If you might publish this app, [set the company domain](#set-the-company-domain).- Click **Finish**.
```

----------------------------------------

TITLE: Implement Custom Theming in a Flutter Application
DESCRIPTION: This Dart code snippet provides a complete Flutter application demonstrating how to define and apply custom themes. It showcases the use of ThemeData to set a global ColorScheme and TextTheme (integrating google_fonts). It also illustrates how to use Theme.of(context) to access the current theme and how to apply a local theme override for a specific widget like a FloatingActionButton.
SOURCE: https://docs.flutter.dev/cookbook/design/themes

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
// Include the Google Fonts package to provide more text format options
// https://pub.dev/packages/google_fonts
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // TRY THIS: Change to "Brightness.light"
          //           and see that all colors change
          //           to better contrast a light background.
          brightness: Brightness.dark,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // TRY THIS: Change one of the GoogleFonts
          //           to "lato", "poppins", or "lora".
          //           The title uses "titleLarge"
          //           and the middle text uses "bodyMedium".
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            'Text with a background color',
            // TRY THIS: Change the Text value
            //           or change the Theme.of(context).textTheme
            //           to "displayLarge" or "displaySmall".
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          // TRY THIS: Change the seedColor to "Colors.red" or
          //           "Colors.blue".
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            brightness: Brightness.dark,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Aligning Widgets Evenly in a Row using MainAxisAlignment.spaceEvenly in Flutter
DESCRIPTION: Shows how to use `mainAxisAlignment` with `MainAxisAlignment.spaceEvenly` to distribute horizontal space evenly around children widgets within a `Row`. This ensures consistent spacing between, before, and after each `BorderedImage`.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      BorderedImage(),
      BorderedImage(),
      BorderedImage(),
    ],
  );
}
```

----------------------------------------

TITLE: Creating a Static Text Widget (StatelessWidget)
DESCRIPTION: This snippet demonstrates a basic `StatelessWidget` using the `Text` widget in Flutter. `StatelessWidget`s are used for UI elements that do not change during runtime, such as static labels or images. The `Text` widget renders the provided string and style without any internal state.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
const Text(
  'I like Flutter!',
  style: TextStyle(fontWeight: FontWeight.bold),
);
```

----------------------------------------

TITLE: Flutter Scaffold with Loose Container Constraints
DESCRIPTION: Shows a `Scaffold` containing a `Container` with a `Column` of `Text` widgets. The screen forces the `Scaffold` to fill its size, and the `Scaffold` then provides 'loose' constraints to its `Container` child, allowing it to be any size it wants, but not bigger than the screen.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Scaffold(
      body: Container(
        color: blue,
        child: const Column(children: [Text('Hello!'), Text('Goodbye!')]),
      ),
    )
```

----------------------------------------

TITLE: Flutter: Pop Current Route with a Result
DESCRIPTION: This example demonstrates how to pop the current route from the `Navigator` stack, passing a result back to the route that pushed it. This is useful for returning data, such as user selections, from a child route.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});
```

----------------------------------------

TITLE: Handle Asynchronous Operations with Dart async/await
DESCRIPTION: This snippet demonstrates how to use `async` and `await` keywords in Dart for performing asynchronous operations, such as fetching an IP address. It includes a `try-catch` block for robust error handling during the asynchronous call.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
/// return `Future<void>`.
void main() async {
  final example = Example();
  try {
    final ip = await example._getIPAddress();
    print(ip);
  } catch (error) {
    print(error);
  }
}
```

----------------------------------------

TITLE: Displaying static text with StatelessWidget in Flutter
DESCRIPTION: This snippet demonstrates the use of a StatelessWidget, specifically the Text widget. StatelessWidgets are immutable and are used for UI parts that do not change during runtime, rendering only what is passed in their constructors.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
Text(
  'I like Flutter!',
  style: TextStyle(fontWeight: FontWeight.bold),
);
```

----------------------------------------

TITLE: Implementing a ViewModel with ChangeNotifier
DESCRIPTION: View model classes in Flutter are typically implemented by extending the `ChangeNotifier` class. This allows view models to call `notifyListeners()` to refresh views when data is updated.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
class HomeViewModel extends ChangeNotifier {
  // ···
}
```

----------------------------------------

TITLE: Dart: Implement In-Memory User Caching with UserRepository
DESCRIPTION: This Dart code defines a `UserRepository` class that caches user data in memory to prevent redundant network requests. It uses dependency injection for an `Api` service and stores `User` objects in a `_userCache` map. The `loadUser` method checks the cache first, fetching from the API only if the user is not found, and handles API responses to populate the cache.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/local-caching

LANGUAGE: Dart
CODE:
```
class UserRepository {
  UserRepository(this.api);

  final Api api;
  final Map<int, User?> _userCache = {};

  Future<User?> loadUser(int id) async {
    if (!_userCache.containsKey(id)) {
      final response = await api.get(id);
      if (response.statusCode == 200) {
        _userCache[id] = User.fromJson(response.body);
      } else {
        _userCache[id] = null;
      }
    }
    return _userCache[id];
  }
}
```

----------------------------------------

TITLE: Flutter: Passing Data via Constructor for Todo App
DESCRIPTION: This comprehensive Flutter example demonstrates how to pass data between screens using direct constructor injection. It defines a Todo model, initializes a list of todos, and sets up a TodosScreen that navigates to a DetailScreen, passing the selected Todo object directly to its constructor. This method is straightforward for simple data transfers.
SOURCE: https://docs.flutter.dev/cookbook/navigation/passing-data

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          20,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implement ThemeSwitchViewModel for MVVM Logic
DESCRIPTION: The `ThemeSwitchViewModel` acts as the view model in an MVVM architecture, managing the dark mode state (`_isDarkMode`) for the `ThemeSwitch` widget. It interacts with `ThemeRepository` for persistence and exposes `load` and `toggle` commands to manage theme settings. Both `_load` and `_toggle` methods update the internal state and notify listeners to refresh the UI.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/key-value-data

LANGUAGE: dart
CODE:
```
class ThemeSwitchViewModel extends ChangeNotifier {
  ThemeSwitchViewModel(this._themeRepository) {
    load = Command0(_load)..execute();
    toggle = Command0(_toggle);
  }

  final ThemeRepository _themeRepository;

  bool _isDarkMode = false;

  /// If true show dark mode
  bool get isDarkMode => _isDarkMode;

  late Command0 load;

  late Command0 toggle;

  /// Load the current theme setting from the repository
  Future<Result<void>> _load() async {
    try {
      final result = await _themeRepository.isDarkMode();
      if (result is Ok<bool>) {
        _isDarkMode = result.value;
      }
      return result;
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  /// Toggle the theme setting
  Future<Result<void>> _toggle() async {
    try {
      _isDarkMode = !_isDarkMode;
      return await _themeRepository.setDarkMode(_isDarkMode);
    } on Exception catch (e) {
      return Result.error(e);
    }
  } finally {
      notifyListeners();
    }
  }
}
```

----------------------------------------

TITLE: Flutter: Create a TextField with InputDecoration
DESCRIPTION: This snippet demonstrates how to create a basic `TextField` widget in Flutter. It uses `InputDecoration` to add an `OutlineInputBorder` and hint text, making it suitable for general text input. `TextField` is the most commonly used text input widget.
SOURCE: https://docs.flutter.dev/cookbook/forms/text-input

LANGUAGE: dart
CODE:
```
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'Enter a search term',
  ),
),
```

----------------------------------------

TITLE: Flutter: Constrain SingleChildScrollView with LayoutBuilder
DESCRIPTION: This snippet demonstrates how to wrap a `SingleChildScrollView` with a `ConstrainedBox` inside a `LayoutBuilder`. The `ConstrainedBox` uses the `LayoutBuilder`'s `maxHeight` to set a minimum height for its child, ensuring the content fills the available space while still allowing vertical scrolling if the content exceeds that height.
SOURCE: https://docs.flutter.dev/cookbook/lists/spaced-items

LANGUAGE: dart
CODE:
```
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Placeholder(),
      ),
    );
  },
);
```

----------------------------------------

TITLE: Flutter: Navigating to a new screen and showing a dialog (Solution)
DESCRIPTION: This Flutter example demonstrates a correct way to show a dialog immediately upon navigating to a new screen, avoiding the 'setState called during build' error. It uses `Navigator.pushNamed` for the main screen and `Navigator.push` with `PageRouteBuilder` for the dialog, pushing both as separate routes. This ensures `setState` is not called during the build phase of the initial screen.
SOURCE: https://docs.flutter.dev/testing/common-errors

LANGUAGE: dart
CODE:
```
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
            // Immediately show a dialog upon loading the second screen.
            Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) => const MyDialog(),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Complete Flutter SQFlite CRUD Example
DESCRIPTION: This comprehensive Dart code demonstrates how to implement a local SQLite database in a Flutter application using the `sqflite` package. It covers database initialization, table creation, and full CRUD (Create, Read, Update, Delete) operations for a 'Dog' object, including data model definition and example usage within the `main` function. The example shows how to insert, retrieve, update, and delete records, and how to define a data model class that can be converted to and from database maps.
SOURCE: https://docs.flutter.dev/cookbook/persistence/sqlite

LANGUAGE: Dart
CODE:
```
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {'id': id as int, 'name': name as String, 'age': age as int}
          in dogMaps)
        Dog(id: id, name: name, age: age),
    ];
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Dog(id: 0, name: 'Fido', age: 35);

  await insertDog(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(id: fido.id, name: fido.name, age: fido.age + 7);
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
```

----------------------------------------

TITLE: Subscribe to User Profile Stream in Dart View Model
DESCRIPTION: This Dart code shows how a view model subscribes to a Stream<UserProfile> from a repository. It listens for emitted user profile updates, assigns them to a local variable, and calls notifyListeners() to refresh the UI. The asFuture() call ensures the load method awaits the stream's completion.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
Future<void> load() async {
  await _userProfileRepository
      .getUserProfile()
      .listen(
        (userProfile) {
          _userProfile = userProfile;
          notifyListeners();
        },
        onError: (error) {
          // handle error
        },
      )
      .asFuture();
}
```

----------------------------------------

TITLE: Return to Previous Route with Navigator.pop()
DESCRIPTION: Illustrates how to remove the current route from the navigation stack and return to the previous one using Navigator.pop(). This code snippet updates an onPressed callback within the SecondRoute widget to enable going back.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigation-basics

LANGUAGE: dart
CODE:
```
// Within the SecondRoute widget
onPressed: () {
  Navigator.pop(context);
}
```

----------------------------------------

TITLE: Load Keystore Properties in Gradle Kotlin DSL
DESCRIPTION: Kotlin DSL code for `build.gradle.kts` to load keystore properties from `key.properties` file. This snippet reads the sensitive signing information into a `Properties` object, making it accessible for Gradle's signing configuration.
SOURCE: https://docs.flutter.dev/deployment/android

LANGUAGE: kotlin
CODE:
```
import java.util.Properties
import java.io.FileInputStream

plugins {
   ...
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
   ...
}
```

----------------------------------------

TITLE: Defining the Dart Result Class for Error Handling
DESCRIPTION: This code defines a 'sealed' class 'Result<T>' along with its subclasses 'Ok<T>' and 'Error<T>'. 'Result.ok' is a factory constructor for successful outcomes, wrapping a value of type 'T'. 'Result.error' is a factory constructor for error outcomes, wrapping an 'Exception'. This structure provides a clear, type-safe way to represent either a successful value or an error without throwing exceptions.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(Exception error) => Error(error);
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Error<T> {
  const Error(this.error);

  /// Returned error in result
  final Exception error;
}
```

----------------------------------------

TITLE: Associate FocusNode with TextField in Flutter
DESCRIPTION: This code snippet illustrates how to link a previously created FocusNode to a specific TextField widget. By passing the FocusNode to the 'focusNode' property of the TextField in the build() method, you establish the connection necessary for focus management.
SOURCE: https://docs.flutter.dev/cookbook/forms/focus

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return TextField(focusNode: myFocusNode);
}
```

----------------------------------------

TITLE: Flutter Default Project Directory Structure
DESCRIPTION: This snippet displays the standard directory layout automatically generated for a new Flutter project. It highlights the primary folders like `android`, `ios`, `lib`, and `test`, along with crucial files such as `main.dart` and `pubspec.yaml`, explaining their roles.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: plaintext
CODE:
```
┬
└ project_name
  ┬
  ├ android      - Contains Android-specific files.
  ├ build        - Stores iOS and Android build files.
  ├ ios          - Contains iOS-specific files.
  ├ lib          - Contains externally accessible Dart source files.
    ┬
    └ src        - Contains additional source files.
    └ main.dart  - The Flutter entry point and the start of a new app.
                   This is generated automatically when you create a Flutter
                    project.
                   It's where you start writing your Dart code.
  ├ test         - Contains automated test files.
  └ pubspec.yaml - Contains the metadata for the Flutter app.
```

----------------------------------------

TITLE: Corrected User class with explicitToJson: true for nested objects
DESCRIPTION: Provides the corrected Dart `User` class definition, demonstrating how to use `explicitToJson: true` in the `@JsonSerializable()` annotation to properly serialize nested objects into their JSON representation.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(this.name, this.address);

  String name;
  Address address;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

----------------------------------------

TITLE: Declare Package Dependencies in pubspec.yaml
DESCRIPTION: Shows how to add a package dependency to the `dependencies` section of a `pubspec.yaml` file, making its Dart API available to the current package.
SOURCE: https://docs.flutter.dev/packages-and-plugins/developing-packages

LANGUAGE: YAML
CODE:
```
dependencies:
  url_launcher: ^6.3.1
```

----------------------------------------

TITLE: Implement Input Validation Errors in Flutter TextField
DESCRIPTION: This snippet demonstrates how to show validation errors dynamically in a Flutter `TextField`. It uses an `InputDecoration` object with `errorText` to display messages based on user input, such as an email validation check, and updates the UI via `setState`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  String? _errorText;

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\\]\\.,;:\s@\"]+(\\.[^<>()[\\]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\\[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|'
        r'(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: TextField(
          onSubmitted: (text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'This is a hint',
            errorText: _errorText,
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implementing Form Validation in Flutter
DESCRIPTION: This Flutter code snippet demonstrates how to build a form with input validation. It uses a GlobalKey to manage the form's state, a TextFormField with a custom validator function to check input, and an ElevatedButton to trigger validation and display a SnackBar based on the validation result.
SOURCE: https://docs.flutter.dev/cookbook/forms/validation

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
```

----------------------------------------

TITLE: Define User Model with json_serializable in Dart
DESCRIPTION: This snippet demonstrates how to define a `User` class using `json_serializable` annotations. It includes the `part` directive, `@JsonSerializable` annotation, constructor, factory constructor for `fromJson`, and `toJson` method for automatic JSON serialization/deserialization.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class User {
  User(this.name, this.email);

  String name;
  String email;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

----------------------------------------

TITLE: Complete Flutter App for File Persistence (Dart)
DESCRIPTION: This comprehensive Flutter example showcases a full application that reads and writes an integer counter to a file. It integrates `path_provider` for directory access, `CounterStorage` for file operations, and a `StatefulWidget` to manage UI updates based on file content, providing a complete persistence solution.
SOURCE: https://docs.flutter.dev/cookbook/persistence/reading-writing-files

LANGUAGE: dart
CODE:
```
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading and Writing Files')),
      body: Center(
        child: Text('Button tapped $_counter time${_counter == 1 ? '' : 's'}.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Dart to Kotlin Data Type Mapping
DESCRIPTION: This table illustrates how Dart data types are automatically serialized and deserialized to their corresponding Kotlin types when using Flutter's StandardMessageCodec for platform channel communication.
SOURCE: https://docs.flutter.dev/platform-integration/platform-channels

LANGUAGE: APIDOC
CODE:
```
Dart: null -> Kotlin: null
Dart: bool -> Kotlin: Boolean
Dart: int (<=32 bits) -> Kotlin: Int
Dart: int (>32 bits) -> Kotlin: Long
Dart: double -> Kotlin: Double
Dart: String -> Kotlin: String
Dart: Uint8List -> Kotlin: ByteArray
Dart: Int32List -> Kotlin: IntArray
Dart: Int64List -> Kotlin: LongArray
Dart: Float32List -> Kotlin: FloatArray
Dart: Float64List -> Kotlin: DoubleArray
Dart: List -> Kotlin: List
Dart: Map -> Kotlin: HashMap
```

----------------------------------------

TITLE: http.get() method and related classes
DESCRIPTION: Documentation for the `http.get()` method, `Future` class, and `http.Response` class, which are essential for asynchronous network operations in Dart/Flutter.
SOURCE: https://docs.flutter.dev/cookbook/networking/fetch-data

LANGUAGE: APIDOC
CODE:
```
http.get(Uri url):
  Description: Makes an HTTP GET request to the specified URI.
  Parameters:
    url (Uri): The URI to which the GET request is made.
  Returns: Future<http.Response>

Future<T> class:
  Description: A core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.

http.Response class:
  Description: Contains the data received from a successful http call.
```

----------------------------------------

TITLE: Good Example: Declarative State Update Handler
DESCRIPTION: Demonstrates the correct approach to updating state by modifying a model. This change in the model will then trigger a rebuild of the UI from the parent, adhering to Flutter's declarative paradigm.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
// GOOD
void myTapHandler(BuildContext context) {
  var cartModel = somehowGetMyCartModel(context);
  cartModel.add(item);
}
```

----------------------------------------

TITLE: Add a Button to Launch Selection Screen and Handle Result
DESCRIPTION: This snippet creates the `SelectionButton` StatefulWidget. When tapped, it launches the `SelectionScreen` using `Navigator.push` and then asynchronously waits for a result to be returned from the `SelectionScreen` via `Navigator.pop`.
SOURCE: https://docs.flutter.dev/cookbook/navigation/returning-data

LANGUAGE: Dart
CODE:
```
class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );
  }
}
```

----------------------------------------

TITLE: Defining a ViewModel in Flutter with ChangeNotifier
DESCRIPTION: This Dart code defines a `CounterViewModel` that extends `ChangeNotifier`. It acts as an intermediary between the `CounterModel` and the UI, handling data loading, incrementing the count, and managing error states. It uses `notifyListeners()` to inform the View of changes, and stores `errorMessage` to provide user-friendly feedback.
SOURCE: https://docs.flutter.dev/get-started/fwe/state-management

LANGUAGE: dart
CODE:
```
import 'package:flutter/foundation.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterModel model;
  int? count;
  String? errorMessage;
  CounterViewModel(this.model);

  Future<void> init() async {
    try {
      count = (await model.loadCountFromServer()).count;
    } catch (e) {
      errorMessage = 'Could not initialize counter';
    }
    notifyListeners();
  }

  Future<void> increment() async {
    final currentCount = count;
    if (currentCount == null) {
      throw('Not initialized');
    }
    try {
      final incrementedCount = currentCount + 1;
      await model.updateCountOnServer(incrementedCount);
      count = incrementedCount;
    } catch(e) {
      errorMessage = 'Could not update count';
    }
    notifyListeners();
  }
}
```

----------------------------------------

TITLE: Flutter and Compose Approaches to Responsive and Adaptive Design
DESCRIPTION: This section outlines different strategies for implementing responsive and adaptive designs in Jetpack Compose and Flutter. It lists key classes and concepts like `WindowSizeClass` and `BoxWithConstraints` for Compose, and `LayoutBuilder` and `MediaQuery.of()` for Flutter, which are used to adapt UI based on available space or device properties.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: APIDOC
CODE:
```
Jetpack Compose Adaptive Design Options:
  - Custom layout
  - WindowSizeClass: Used for determining window size categories.
  - BoxWithConstraints: Provides constraints for its content, allowing conditional UI.
  - Material 3 adaptive library: Utilizes WindowSizeClass with specialized composable layouts.

Flutter Responsive Design Options:
  - LayoutBuilder: Provides BoxConstraints object to its builder function, enabling layout-based responsiveness.
  - MediaQuery.of(): Retrieves current media information (e.g., size, orientation) from the nearest MediaQuery ancestor, useful for global responsiveness.
```

----------------------------------------

TITLE: Manage ViewModel Listener Lifecycle (Dart)
DESCRIPTION: Illustrates the correct way to add and remove a listener to the ViewModel (or Command) within a StatefulWidget's initState and dispose methods. This ensures proper resource management and prevents memory leaks.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
@override
void initState() {
  super.initState();
  widget.viewModel.addListener(_onViewModelChanged);
}

@override
void dispose() {
  widget.viewModel.removeListener(_onViewModelChanged);
  super.dispose();
}
```

----------------------------------------

TITLE: Create a Reusable TitleSection Widget in Flutter
DESCRIPTION: Defines a `StatelessWidget` named `TitleSection` that displays a name and location. It uses `Expanded` to fill available space, `Column` for vertical arrangement, `Padding` for spacing, and combines `Text` widgets with an `Icon` to form a visually distinct title block. This widget is designed for reusability across different parts of an application. To use all remaining free space in the row, use the `Expanded` widget to stretch the `Column` widget. To place the column at the start of the row, set the `crossAxisAlignment` property to `CrossAxisAlignment.start`. To add space between the rows of text, put those rows in a `Padding` widget. The title row ends with a red star icon and the text `41`. The entire row falls inside a `Padding` widget and pads each edge by 32 pixels.
SOURCE: https://docs.flutter.dev/ui/layout/tutorial

LANGUAGE: dart
CODE:
```
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          /*3*/
          Icon(Icons.star, color: Colors.red[500]),
          const Text('41'),
        ],
      ),
    );
  }
}
```

----------------------------------------

TITLE: Define Album Class for JSON Deserialization in Dart
DESCRIPTION: This class defines the structure for an Album object, including an 'id' and 'title'. It provides a factory constructor, 'fromJson', to parse a JSON Map into an Album instance using Dart's pattern matching for robust deserialization. It handles cases where the JSON format is unexpected by throwing a FormatException.
SOURCE: https://docs.flutter.dev/cookbook/networking/send-data

LANGUAGE: dart
CODE:
```
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title} => Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
```

----------------------------------------

TITLE: Use an OrientationBuilder to change the number of columns
DESCRIPTION: To determine the app's current Orientation, use the OrientationBuilder widget. The OrientationBuilder calculates the current Orientation by comparing the width and height available to the parent widget, and rebuilds when the size of the parent changes.
Using the Orientation, build a list that displays two columns in portrait mode, or three columns in landscape mode.
SOURCE: https://docs.flutter.dev/cookbook/design/orientation

LANGUAGE: dart
CODE:
```
body: OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      // Create a grid with 2 columns in portrait mode,
      // or 3 columns in landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
),
```

----------------------------------------

TITLE: Define Custom Gradle Configuration for Flutter Profile Build (Kotlin DSL)
DESCRIPTION: This code snippet illustrates how to define a custom Gradle configuration named `profileImplementation` within the `configurations` block of the `app/build.gradle.kts` file. This custom configuration is necessary to properly handle the `profileImplementation` dependency for the Flutter module in a Kotlin DSL-based Android project.
SOURCE: https://docs.flutter.dev/add-to-app/android/project-setup

LANGUAGE: Kotlin
CODE:
```
configurations {
    getByName("profileImplementation") {
    }
}
```

----------------------------------------

TITLE: Perform CPU-bound work with Isolates in Flutter
DESCRIPTION: Illustrates the use of `Isolate`s in Flutter for computationally intensive tasks to prevent blocking the main event loop. This example shows how to spawn an isolate, establish communication channels (SendPort/ReceivePort), send data to the isolate, and receive processed results back to update the UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: Dart
CODE:
```
Future<void> loadData() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message.
  SendPort sendPort = await receivePort.first as SendPort;

  final msg =
      await sendReceive(
            sendPort,
            'https://jsonplaceholder.typicode.com/posts',
          )
          as List<Object?>;

  setState(() {
    widgets = msg;
  });
}

// The entry point for the isolate.
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  ReceivePort port = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (var msg in port) {
    String data = msg[0] as String;
    SendPort replyTo = msg[1] as SendPort;

    String dataURL = data;
    http.Response response = await http.get(Uri.parse(dataURL));
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body));
  }
}

Future<Object?> sendReceive(SendPort port, Object? msg) {
  ReceivePort response = ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}
```

----------------------------------------

TITLE: Flutter ButtonStyle API Overview
DESCRIPTION: This section provides an overview of the new ButtonStyle object and MaterialStateProperty in Flutter. ButtonStyle is used to configure the visual attributes of new button classes, allowing overrides of default properties. MaterialStateProperty enables defining different values for properties based on the button's state (e.g., hovered, focused, pressed).
SOURCE: https://docs.flutter.dev/release/breaking-changes/buttons

LANGUAGE: APIDOC
CODE:
```
ButtonStyle:
  Purpose: Configures visual attributes of new button classes (TextButton, ElevatedButton, OutlinedButton).
  Usage: Assigned to the 'style' property of button widgets.
  Behavior: Defines overrides of a button's default visual properties.
  Key Feature: Most properties are defined with MaterialStateProperty to represent state-dependent values.

MaterialStateProperty<T>:
  Purpose: A class that can represent different values depending on a widget's MaterialState (e.g., pressed, focused, hovered).
  Methods:
    - static all<T>(value: T):
        Description: Returns a MaterialStateProperty that provides the same 'value' for all states.
        Parameters:
          - value: T - The value to be used for all states.
    - static resolveWith<T>(resolver: (Set<MaterialState> states) => T?):
        Description: Returns a MaterialStateProperty that resolves to a value based on the current set of MaterialStates.
        Parameters:
          - states: Set<MaterialState> - The current states of the widget (e.g., MaterialState.hovered, MaterialState.focused, MaterialState.pressed).
        Returns: T? - The resolved value for the current state. Returning null defers to the widget's default.
```

----------------------------------------

TITLE: Perform Asynchronous Network Calls with async/await in Flutter
DESCRIPTION: This example illustrates how to make non-blocking network requests in Flutter using Dart's `async` and `await` keywords. It fetches data from a URL and updates the application's state upon completion to reflect the new data in the UI.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Customize JSON Key Naming with @JsonKey in Dart
DESCRIPTION: Shows how to use the `@JsonKey(name: '...')` annotation to map a JSON field with a different naming convention (e.g., snake_case) to a Dart property (e.g., lowerCamelCase).
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
/// Tell json_serializable that "registration_date_millis" should be
/// mapped to this property.
@JsonKey(name: 'registration_date_millis')
final int registrationDateMillis;
```

----------------------------------------

TITLE: Implement MainAppViewModel for Theme State Management
DESCRIPTION: Defines the `MainAppViewModel` class, a `ChangeNotifier` that observes `ThemeRepository` for dark mode changes. It manages the `_isDarkMode` state, notifies listeners on updates, and handles initial loading and error cases for theme settings, including proper resource disposal.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/key-value-data

LANGUAGE: dart
CODE:
```
class MainAppViewModel extends ChangeNotifier {
  MainAppViewModel(this._themeRepository) {
    _subscription = _themeRepository.observeDarkMode().listen((isDarkMode) {
      _isDarkMode = isDarkMode;
      notifyListeners();
    });
    _load();
  }

  final ThemeRepository _themeRepository;
  StreamSubscription<bool>? _subscription;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> _load() async {
    try {
      final result = await _themeRepository.isDarkMode();
      if (result is Ok<bool>) {
        _isDarkMode = result.value;
      }
    } on Exception catch (_) {
      // handle error
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
```

----------------------------------------

TITLE: Flutter API: TextStyle Class Reference
DESCRIPTION: The `TextStyle` class in Flutter defines the visual properties of text. It can be applied to a `Text` widget's `style` property to control aspects like font size, color, weight, and more. Creating a `TextStyle` object allows for consistent styling across multiple `Text` widgets.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: APIDOC
CODE:
```
Class: TextStyle
  Description: Defines the visual properties of text, such as font size, color, and weight.
  Constructor: TextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    // ... other properties like fontStyle, letterSpacing, etc.
  })
    Parameters:
      color: Color - The color to use when painting the text.
      fontSize: double - The size of the glyphs (in logical pixels) to use when painting the text.
      fontWeight: FontWeight - The typeface thickness to use when painting the text.
    Returns: TextStyle - A new TextStyle object.
  Usage: Can be assigned to the 'style' property of a Text widget to apply consistent styling.
```

----------------------------------------

TITLE: Complete Flutter app displaying a network image
DESCRIPTION: A full Flutter application demonstrating how to display a network image within a MaterialApp and Scaffold structure. It sets up a basic app with an AppBar and displays an image in the body.
SOURCE: https://docs.flutter.dev/cookbook/images/network-image

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter Material Common Buttons (ButtonStyle)
DESCRIPTION: Clickable blocks that start an action, such as sending an email, sharing a document, or liking a comment.
SOURCE: https://docs.flutter.dev/reference/widgets

LANGUAGE: APIDOC
CODE:
```
Class: ButtonStyle
Description: Clickable blocks that start an action, such as sending an email, sharing a document, or liking a comment.
```

----------------------------------------

TITLE: Flutter Migration: WillPopScope to PopScope (onPopInvoked)
DESCRIPTION: Illustrates migrating `WillPopScope` to `PopScope` when the original `onWillPop` was used for side effects. `onPopInvoked` is used to perform actions after the pop is handled, noting its different timing compared to `onWillPop`.
SOURCE: https://docs.flutter.dev/release/breaking-changes/android-predictive-back

LANGUAGE: dart
CODE:
```
WillPopScope(
  onWillPop: () async {
    _myHandleOnPopMethod();
    return true;
  },
  child: ...
),
```

LANGUAGE: dart
CODE:
```
PopScope(
  canPop: true,
  onPopInvoked: (bool didPop) {
    _myHandleOnPopMethod();
  },
  child: ...
),
```

----------------------------------------

TITLE: Display Camera Preview with FutureBuilder in Flutter
DESCRIPTION: This snippet demonstrates how to display the camera's live feed using the `CameraPreview` widget. It utilizes a `FutureBuilder` to ensure the `CameraController` is fully initialized before rendering the preview, showing a loading indicator otherwise.
SOURCE: https://docs.flutter.dev/cookbook/plugins/picture-using-camera

LANGUAGE: Dart
CODE:
```
// You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the
// controller has finished initializing.
FutureBuilder<void>(
  future: _initializeControllerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // If the Future is complete, display the preview.
      return CameraPreview(_controller);
    } else {
      // Otherwise, display a loading indicator.
      return const Center(child: CircularProgressIndicator());
    }
  },
)
```

----------------------------------------

TITLE: Perform PUT Request to Update Data in Dart
DESCRIPTION: This Dart function demonstrates how to send a PUT request using `http.put()` to update an album title on a REST API endpoint. It sets the `Content-Type` header and encodes the body as JSON.
SOURCE: https://docs.flutter.dev/cookbook/networking/update-data

LANGUAGE: dart
CODE:
```
Future<http.Response> updateAlbum(String title) {
  return http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'title': title}),
  );
}
```

----------------------------------------

TITLE: Dart: Home ViewModel with Asynchronous Command Loading
DESCRIPTION: This Dart code defines the `HomeViewModel`, a `ChangeNotifier` responsible for managing application state. It initializes `Command0` for data loading (`_load`) and `Command1` for deleting bookings (`_deleteBooking`) in its constructor, ensuring these commands are ready before any data is fetched. It also exposes `user` and `bookings` properties for the view.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/ui-layer

LANGUAGE: Dart
CODE:
```
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
   required BookingRepository bookingRepository,
   required UserRepository userRepository,
  }) : _bookingRepository = bookingRepository,
      _userRepository = userRepository {
    // Load required data when this screen is built.
    load = Command0(_load)..execute();
    deleteBooking = Command1(_deleteBooking);
  }

  final BookingRepository _bookingRepository;
  final UserRepository _userRepository;

  late Command0 load;
  late Command1<void, int> deleteBooking;

  User? _user;
  User? get user => _user;

  List<BookingSummary> _bookings = [];
  List<BookingSummary> get bookings => _bookings;

  Future<Result> _load() async {
    // ...
  }

  Future<Result<void>> _deleteBooking(int id) async {
    // ...
  }

  // ...
}
```

----------------------------------------

TITLE: Define Named Routes in Flutter using MaterialApp
DESCRIPTION: This Dart code demonstrates how to set up named routes within a Flutter application using the `MaterialApp` widget. It defines a map of string keys to `WidgetBuilder` functions, where each key represents a unique route name. This approach simplifies navigation by allowing developers to refer to screens by their names, with the `home` property serving as the default route.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
void main() {
  runApp(
    MaterialApp(
      home: const MyAppHome(), // Becomes the route named '/'.
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}
```

----------------------------------------

TITLE: Get application documents directory path in Flutter
DESCRIPTION: This snippet demonstrates how to find the correct local path for storing application-specific files using the `path_provider` package. It retrieves the application's documents directory, which is suitable for persistent data.
SOURCE: https://docs.flutter.dev/cookbook/persistence/reading-writing-files

LANGUAGE: Dart
CODE:
```
import 'package:path_provider/path_provider.dart';
  // ···
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
```

----------------------------------------

TITLE: Implement and Use a Custom Card Widget in Flutter
DESCRIPTION: This snippet defines a `UseCard` StatelessWidget that demonstrates how to integrate and use a `CustomCard` widget. It passes a dynamic `index` and provides an `onPress` callback to handle button presses, printing the card's index to the console.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
class UseCard extends StatelessWidget {
  const UseCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    /// Usage
    return CustomCard(
      index: index,
      onPress: () {
        print('Card $index');
      },
    );
  }
}
```

----------------------------------------

TITLE: Forwarding Android OS Signals to FlutterFragment
DESCRIPTION: This code demonstrates how to override common Android Activity lifecycle methods and forward the corresponding OS signals to a FlutterFragment instance. This ensures proper behavior and integration of the Flutter UI within an existing Android app, handling events like activity results, permission requests, and memory warnings.
SOURCE: https://docs.flutter.dev/add-to-app/android/add-flutter-fragment

LANGUAGE: kotlin
CODE:
```
    flutterFragment!!.onActivityResult(
      requestCode,
      resultCode,
      data
    )
  }

  override fun onUserLeaveHint() {
    flutterFragment!!.onUserLeaveHint()
  }

  override fun onTrimMemory(level: Int) {
    super.onTrimMemory(level)
    flutterFragment!!.onTrimMemory(level)
  }
}
```

LANGUAGE: java
CODE:
```
public class MyActivity extends FragmentActivity {
    @Override
    public void onPostResume() {
        super.onPostResume();
        flutterFragment.onPostResume();
    }

    @Override
    protected void onNewIntent(@NonNull Intent intent) {
        flutterFragment.onNewIntent(intent);
    }

    @Override
    public void onBackPressed() {
        flutterFragment.onBackPressed();
    }

    @Override
    public void onRequestPermissionsResult(
        int requestCode,
        @NonNull String[] permissions,
        @NonNull int[] grantResults
    ) {
        flutterFragment.onRequestPermissionsResult(
            requestCode,
            permissions,
            grantResults
        );
    }

    @Override
    public void onActivityResult(
        int requestCode,
        int resultCode,
        @Nullable Intent data
    ) {
        super.onActivityResult(requestCode, resultCode, data);
        flutterFragment.onActivityResult(
            requestCode,
            resultCode,
            data
        );
    }

    @Override
    public void onUserLeaveHint() {
        flutterFragment.onUserLeaveHint();
    }

    @Override
    public void onTrimMemory(int level) {
        super.onTrimMemory(level);
        flutterFragment.onTrimMemory(level);
    }
}
```

----------------------------------------

TITLE: Creating a new Flutter application
DESCRIPTION: Use the `flutter create` command to initialize a new Flutter project directory, setting up the basic project structure for your application.
SOURCE: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

LANGUAGE: bash
CODE:
```
flutter create <name_of_flutter_app>
```

----------------------------------------

TITLE: Best Practice for Deep Consumer Placement in Flutter Widget Tree
DESCRIPTION: This example illustrates the recommended best practice for placing `Consumer` widgets as deep as possible within the widget tree. This minimizes the scope of UI rebuilds when the model changes, improving application performance.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
// DO THIS
return HumongousWidget(
  // ...
  child: AnotherMonstrousWidget(
    // ...
    child: Consumer<CartModel>(
      builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
      },
    ),
  ),
);
```

----------------------------------------

TITLE: Define a simple Counter class in Dart
DESCRIPTION: This Dart class, `Counter`, serves as a unit to be tested. It initializes a `value` to 0 and provides methods to `increment` and `decrement` this value. This example demonstrates a basic class structure for unit testing.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/introduction

LANGUAGE: Dart
CODE:
```
class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}
```

----------------------------------------

TITLE: Flutter Widget Causing Full Page Repaint
DESCRIPTION: This example demonstrates a Flutter widget where a CircularProgressIndicator causes the entire Scaffold to repaint on every frame. This scenario highlights how a small animation can lead to inefficient repainting of a large area, potentially harming performance. The 'Highlight repaints' debug option would show the entire screen changing colors.
SOURCE: https://docs.flutter.dev/tools/devtools/legacy-inspector

LANGUAGE: dart
CODE:
```
class EverythingRepaintsPage extends StatelessWidget {
  const EverythingRepaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repaint Example')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
```

----------------------------------------

TITLE: Accessing InheritedWidget Data in a Child Widget
DESCRIPTION: This `HomeScreen` StatelessWidget demonstrates how to access data provided by an `InheritedWidget` (like `MyState`) using its static `of()` method within the `build` context. This allows child widgets to efficiently retrieve shared state without explicit passing.
SOURCE: https://docs.flutter.dev/get-started/fwe/state-management

LANGUAGE: dart
CODE:
```
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = MyState.of(context).data;
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter API Reference: StatefulWidget and setState()
DESCRIPTION: This section provides API documentation for key Flutter elements used in state management: `StatefulWidget` for widgets with mutable state, and `setState()` for notifying the framework of state changes to trigger UI rebuilds.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
StatefulWidget:
  Description: A widget that has mutable state.
  Purpose: Used for widgets that need to change their appearance or behavior dynamically over time.
  Reference: https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html

setState():
  Description: Notifies the Flutter framework that the internal state of this object has changed.
  Purpose: Triggers a rebuild of the widget tree to reflect the updated state.
  Context: Called within a `State` object.
  Reference: https://api.flutter.dev/flutter/widgets/State/setState.html
```

----------------------------------------

TITLE: Full Flutter App with AnimatedLogo and AnimationController
DESCRIPTION: Demonstrates a complete Flutter application (`LogoApp`) that integrates the `AnimatedLogo` widget. It sets up an `AnimationController` and `Tween` in `initState` to manage the animation, and passes the resulting `Animation` object to `AnimatedLogo` for rendering. This snippet shows the full context of how `AnimatedWidget` is used within a `StatefulWidget`.
SOURCE: https://docs.flutter.dev/ui/animations/tutorial

LANGUAGE: dart
CODE:
```
void main() => runApp(const LogoApp());

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  // ...

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  // ...
}
```

----------------------------------------

TITLE: Complete setMethodCallHandler for Battery Level
DESCRIPTION: Completes the `setMethodCallHandler` for the `batteryChannel` to process the `getBatteryLevel` method call from Flutter. It invokes the native `getBatteryLevel()` function and returns the battery level to Flutter, or a `FlutterError` if the level is unavailable or the method is not recognized.
SOURCE: https://docs.flutter.dev/platform-integration/platform-channels

LANGUAGE: swift
CODE:
```
batteryChannel.setMethodCallHandler { (call, result) in
  switch call.method {
  case "getBatteryLevel":
    guard let level = getBatteryLevel() else {
      result(
        FlutterError(
          code: "UNAVAILABLE",
          message: "Battery level not available",
          details: nil))
     return
    }
    result(level)
  default:
    result(FlutterMethodNotImplemented)
  }
}
```

----------------------------------------

TITLE: Managing Multiple Action States in HomeViewModel
DESCRIPTION: This Dart `HomeViewModel` demonstrates how to manage separate `running` and `error` states for distinct actions like `load` and `edit`. This approach allows for independent UI feedback for each action, addressing complexity when a view model has multiple functionalities.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
class HomeViewModel extends ChangeNotifier {
  User? get user => // ...

  bool get runningLoad => // ...

  Exception? get errorLoad => // ...

  bool get runningEdit => // ...

  Exception? get errorEdit => // ...

  void load() {
    // load user
  }

  void edit(String name) {
    // edit user
  }
}
```

----------------------------------------

TITLE: Complete FlutterMethodChannel handler for getBatteryLevel method
DESCRIPTION: Shows how to complete the setMethodCallHandler logic in Swift to specifically handle the 'getBatteryLevel' method call from Flutter. It dispatches the call to the native battery retrieval method and reports 'FlutterMethodNotImplemented' for any unknown method calls.
SOURCE: https://docs.flutter.dev/platform-integration/platform-channels

LANGUAGE: Swift
CODE:
```
batteryChannel.setMethodCallHandler({
  [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
  // This method is invoked on the UI thread.
  guard call.method == "getBatteryLevel" else {
    result(FlutterMethodNotImplemented)
    return
  }
  self?.receiveBatteryLevel(result: result)
})
```

----------------------------------------

TITLE: Flutter Config: Removal of Android v2 Embedding Toggle
DESCRIPTION: The `enable-android-embedding-v2` flag has been removed from `flutter config`. This means there is no longer an option to toggle between v1 and v2 Android embeddings for new projects, as v2 is now the sole default and only option.
SOURCE: https://docs.flutter.dev/release/breaking-changes/android-v1-embedding-create-deprecation

LANGUAGE: CLI
CODE:
```
flutter config
```

----------------------------------------

TITLE: Flutter Material NavigationBar Widget Overview
DESCRIPTION: Documents the NavigationBar widget, a persistent container for switching between primary destinations, with a link to its full API documentation.
SOURCE: https://docs.flutter.dev/ui/widgets/material

LANGUAGE: APIDOC
CODE:
```
Widget Name: NavigationBar
Purpose: Persistent container that enables switching between primary destinations in an app.
API Documentation: https://api.flutter.dev/flutter/material/NavigationBar-class.html
```

----------------------------------------

TITLE: Update fetchAlbum Function for Testability in Dart
DESCRIPTION: This snippet modifies the `fetchAlbum` function to accept an `http.Client` as a parameter, making it easier to test by allowing the injection of mock clients. It fetches data from a placeholder API and parses the JSON response, throwing an exception on failure.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/mocking

LANGUAGE: Dart
CODE:
```
Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
```

----------------------------------------

TITLE: StreamBuilder Widget API Reference
DESCRIPTION: Documentation for the Flutter StreamBuilder widget, which constructs itself based on the latest snapshot of interaction with a Stream object. It is used to react to changes in a stream of data and update the UI accordingly.
SOURCE: https://docs.flutter.dev/ui/widgets/async

LANGUAGE: APIDOC
CODE:
```
StreamBuilder:
  Description: Widget that builds itself based on the latest snapshot of interaction with a Stream.
  Reference: https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html
```

----------------------------------------

TITLE: Parse HTTP Response to List of Photo Objects in Dart
DESCRIPTION: This Dart snippet provides a `parsePhotos()` function to convert a raw JSON response body string into a `List<Photo>` by decoding the JSON and mapping each item to a `Photo` object using its `fromJson` constructor. It also shows an updated `fetchPhotos()` function that fetches data and then synchronously calls `parsePhotos()` on the response body.
SOURCE: https://docs.flutter.dev/cookbook/networking/background-parsing

LANGUAGE: dart
CODE:
```
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List)
      .cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );

  // Synchronously run parsePhotos in the main isolate.
  return parsePhotos(response.body);
}
```

----------------------------------------

TITLE: Enable Visual Debugging with debugPaintSizeEnabled
DESCRIPTION: This Dart code snippet demonstrates how to enable `debugPaintSizeEnabled` in a Flutter application. When active, this flag visually highlights layout boundaries, padding, alignment, and spacers, aiding in debugging layout issues. It's part of a suite of debug flags that only function in Flutter's debug mode.
SOURCE: https://docs.flutter.dev/testing/code-debugging

LANGUAGE: Dart
CODE:
```
// Add import to the Flutter rendering library.
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}
```

----------------------------------------

TITLE: Migrate Route.willPop to Route.popDisposition in Flutter
DESCRIPTION: This snippet demonstrates migrating the `Route.willPop` method, which returned a `Future<RoutePopDisposition>`, to the synchronous `Route.popDisposition` getter. This change simplifies pop logic now that pops can no longer be canceled asynchronously.
SOURCE: https://docs.flutter.dev/release/breaking-changes/android-predictive-back

LANGUAGE: Dart
CODE:
```
if (await myRoute.willPop() == RoutePopDisposition.doNotPop) {
  ...
}
```

LANGUAGE: Dart
CODE:
```
if (myRoute.popDisposition == RoutePopDisposition.doNotPop) {
  ...
}
```

----------------------------------------

TITLE: Add Flutter Swipe Animation to Cards using Dismissible
DESCRIPTION: This Dart code snippet shows the basic usage of Flutter's `Dismissible` widget, which is used to add swipe-to-dismiss functionality to UI elements, typically cards or list items. It allows users to dismiss an item by swiping it off the screen.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
return Dismissible(
```

----------------------------------------

TITLE: Combine Tweens using chain() for Complex Animations
DESCRIPTION: Combine multiple Tweens, such as an Offset Tween and a CurveTween, using the chain() method. This creates a single Animatable that first applies the curve, then maps the result to the desired offset, providing a combined animation effect.
SOURCE: https://docs.flutter.dev/cookbook/animation/page-route-animation

LANGUAGE: dart
CODE:
```
const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.ease;

var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
```

LANGUAGE: dart
CODE:
```
return SlideTransition(position: animation.drive(tween), child: child);
```

----------------------------------------

TITLE: Animating Typing Indicator Height in Flutter
DESCRIPTION: This Dart code defines a `_TypingIndicatorState` class that manages the animated height of a typing indicator. It utilizes `AnimationController` and `CurvedAnimation` to smoothly expand or contract a `SizedBox` widget's height based on a `showIndicator` flag. The animation curves are specifically tailored for different directions: a fast expansion to quickly make space, and a slower contraction to allow internal speech bubbles to disappear gracefully. The `AnimatedBuilder` widget is used to efficiently rebuild only the `SizedBox` as the animation progresses, optimizing CPU cycles.
SOURCE: https://docs.flutter.dev/cookbook/effects/typing-indicator

LANGUAGE: Dart
CODE:
```
class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late Animation<double> _indicatorSpaceAnimation;

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(vsync: this);

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.0, end: 60.0));

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(height: _indicatorSpaceAnimation.value);
      },
    );
  }
}
```

----------------------------------------

TITLE: Create Album Class with JSON Factory in Dart
DESCRIPTION: Defines the `Album` data model with `userId`, `id`, and `title` properties. It includes a factory constructor `fromJson` to parse JSON data into an `Album` object, handling successful parsing and format exceptions using Dart's pattern matching.
SOURCE: https://docs.flutter.dev/cookbook/networking/fetch-data

LANGUAGE: Dart
CODE:
```
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
```

----------------------------------------

TITLE: Initialize Widget Data in Flutter Build Method
DESCRIPTION: Demonstrates how to initialize a child widget with data using a constructor and passing it within the `build()` method of a parent widget. `importantState` represents the data to be passed.
SOURCE: https://docs.flutter.dev/resources/architectural-overview

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
   return ContentWidget(importantState);
}
```

----------------------------------------

TITLE: Dart: DatabaseService Insert Method
DESCRIPTION: Implements the `insert()` method in `DatabaseService` to add a new ToDo item to the database. It uses the `sqflite` package's insert function, automatically generating an ID, and returns a `Result` object containing the newly created `Todo` instance or an error.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/sql

LANGUAGE: dart
CODE:
```
Future<Result<Todo>> insert(String task) async {
  try {
    final id = await _database!.insert(_kTableTodo, {_kColumnTask: task});
    return Result.ok(Todo(id: id, task: task));
  } on Exception catch (e) {
    return Result.error(e);
  }
}
```

----------------------------------------

TITLE: Flutter Customer Cart Display Widget
DESCRIPTION: This widget displays a customer's cart information, including their image, name, and a summary of items and total price. It features dynamic styling based on whether the cart is highlighted or contains items, using `Transform.scale`, `Material` elevation, and `Visibility` for conditional content display, making it suitable for interactive cart UIs.
SOURCE: https://docs.flutter.dev/cookbook/effects/drag-a-widget

LANGUAGE: Dart
CODE:
```
class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Image(
                    image: customer.imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                customer.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: hasItems ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      customer.formattedTotalItemPrice,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Identifying Memory Leaks with Closures in Dart (Bad Practice)
DESCRIPTION: This code snippet demonstrates a leak-prone pattern where a closure implicitly captures a reference to a short-lived object (`myHugeObject`), preventing its garbage collection as long as the handler is reachable.
SOURCE: https://docs.flutter.dev/tools/devtools/memory

LANGUAGE: Dart
CODE:
```
  final handler = () => print(myHugeObject.name);
  setHandler(handler);
```

----------------------------------------

TITLE: Full Flutter app with a horizontal ListView
DESCRIPTION: This complete Flutter application demonstrates how to embed a horizontal ListView within a Scaffold. It includes the necessary imports, a main function, and a StatelessWidget to display the horizontal list, providing a runnable example.
SOURCE: https://docs.flutter.dev/cookbook/lists/horizontal-list

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(width: 160, color: Colors.red),
              Container(width: 160, color: Colors.blue),
              Container(width: 160, color: Colors.green),
              Container(width: 160, color: Colors.yellow),
              Container(width: 160, color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implement a Radio Button Group in Flutter
DESCRIPTION: Illustrates how to create a group of mutually exclusive Radio buttons using `ListTile` in Flutter. It defines an `enum` for character types and manages the selected value (`_character`) using `setState` in the `onChanged` callback.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/user-input

LANGUAGE: dart
CODE:
```
enum Character { musician, chef, firefighter, artist }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  Character? _character = Character.musician;

  void setCharacter(Character? value) {
    setState(() {
      _character = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Musician'),
          leading: Radio<Character>(
            value: Character.musician,
            groupValue: _character,
            onChanged: setCharacter,
          ),
        ),
        ListTile(
          title: const Text('Chef'),
          leading: Radio<Character>(
            value: Character.chef,
            groupValue: _character,
            onChanged: setCharacter,
          ),
        ),
        ListTile(
          title: const Text('Firefighter'),
          leading: Radio<Character>(
            value: Character.firefighter,
            groupValue: _character,
            onChanged: setCharacter,
          ),
        ),
        ListTile(
          title: const Text('Artist'),
          leading: Radio<Character>(
            value: Character.artist,
            groupValue: _character,
            onChanged: setCharacter,
          ),
        ),
      ],
    );
  }
}
```

----------------------------------------

TITLE: Create a Basic ListView in Flutter
DESCRIPTION: This example illustrates how to create a simple ListView in Flutter, which is the equivalent of an Android ListView. Unlike Android, Flutter's immutable widget pattern handles row recycling automatically, simplifying list creation and ensuring smooth scrolling performance. The snippet generates a list of 100 text rows.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: _getListData()),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(
        Padding(padding: const EdgeInsets.all(10), child: Text('Row $i')),
      );
    }
    return widgets;
  }
}
```

----------------------------------------

TITLE: Install essential development tools for Flutter on Linux
DESCRIPTION: This command installs core development utilities like curl, git, unzip, xz-utils, zip, and libglu1-mesa, which are prerequisites for Flutter development on Linux. It first updates and upgrades existing packages.
SOURCE: https://docs.flutter.dev/get-started/install/linux/android

LANGUAGE: Linux Shell
CODE:
```
sudo apt-get update -y && sudo apt-get upgrade -y;
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
```

----------------------------------------

TITLE: Implementing Nested Navigation with Navigator and onGenerateRoute in Flutter
DESCRIPTION: This Dart code demonstrates how to set up a nested `Navigator` within a Flutter widget, specifically for a multi-page setup flow. It uses a `GlobalKey` to control navigation, defines callbacks for flow progression (`_onDiscoveryComplete`, `_onDeviceSelected`, `_onConnectionEstablished`), and implements `_onGenerateRoute` to dynamically return different `MaterialPageRoute` pages based on route names. The `PopScope` widget is included to manage exit behavior from the flow.
SOURCE: https://docs.flutter.dev/cookbook/effects/nested-nav

LANGUAGE: dart
CODE:
```
final _navigatorKey = GlobalKey<NavigatorState>();

void _onDiscoveryComplete() {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
}

void _onDeviceSelected(String deviceId) {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
}

void _onConnectionEstablished() {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) async {
      if (didPop) return;

      if (await _isExitDesired() && context.mounted) {
        _exitSetup();
      }
    },
    child: Scaffold(
      appBar: _buildFlowAppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    ),
  );
}

Route<Widget> _onGenerateRoute(RouteSettings settings) {
  final page = switch (settings.name) {
    routeDeviceSetupStartPage => WaitingPage(
      message: 'Searching for nearby bulb...',
      onWaitComplete: _onDiscoveryComplete,
    ),
    routeDeviceSetupSelectDevicePage => SelectDevicePage(
      onDeviceSelected: _onDeviceSelected,
    ),
    routeDeviceSetupConnectingPage => WaitingPage(
      message: 'Connecting...',
      onWaitComplete: _onConnectionEstablished,
    ),
    routeDeviceSetupFinishedPage => FinishedPage(onFinishPressed: _exitSetup),
    _ => throw StateError('Unexpected route name: ${settings.name}!'),
  };

  return MaterialPageRoute(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
```

----------------------------------------

TITLE: Gradle Build Configuration Properties Reference
DESCRIPTION: This section provides a detailed reference for key properties configurable within the `build.gradle.kts` file for Android Flutter projects. It outlines the purpose and default values for properties related to SDK versions, application identification, and app versioning.
SOURCE: https://docs.flutter.dev/deployment/android

LANGUAGE: APIDOC
CODE:
```
Property: compileSdk
  Purpose: The Android API level against which your app is compiled. This should be the highest version available. If you set this property to 31, you run your app on a device running API 30 or earlier as long as your app makes uses no APIs specific to 31.
Property: defaultConfig
  Property: .applicationId
    Purpose: The final, unique application ID that identifies your app.
  Property: .minSdk
    Purpose: The minimum Android API level for which you designed your app to run.
    Default Value: flutter.minSdkVersion
  Property: .targetSdk
    Purpose: The Android API level against which you tested your app to run. Your app should run on all Android API levels up to this one.
    Default Value: flutter.targetSdkVersion
  Property: .versionCode
    Purpose: A positive integer that sets an internal version number. This number only determines which version is more recent than another. Greater numbers indicate more recent versions. App users never see this value.
  Property: .versionName
    Purpose: A string that your app displays as its version number. Set this property as a raw string or as a reference to a string resource.
Property: .buildToolsVersion
  Purpose: The Gradle plugin specifies the default version of the Android build tools that your project uses. To specify a different version of the build tools, change this value.
```

----------------------------------------

TITLE: Define a Flutter Widget Test with testWidgets
DESCRIPTION: Explains how to use the `testWidgets()` function from the `flutter_test` package to define a new widget test. This function provides a `WidgetTester` instance, which is essential for building and interacting with widgets within the test environment.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/introduction

LANGUAGE: dart
CODE:
```
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (tester) async {
    // Test code goes here.
  });
}
```

----------------------------------------

TITLE: Set Container Width and Max-Width in Flutter and CSS
DESCRIPTION: Explains how to control container width. Flutter's Container uses width for fixed sizes, while constraints with BoxConstraints (e.g., maxWidth) mimics CSS max-width. Demonstrates how nested containers behave when parent width is less than child's.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/web-devs

LANGUAGE: css
CODE:
```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    width: 100%;
    max-width: 240px;
}
```

LANGUAGE: dart
CODE:
```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      width: 240, // max-width is 240
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

----------------------------------------

TITLE: Dart AlertDialog Code After Migration
DESCRIPTION: This Dart code shows the simplified AlertDialog structure following the migration. The explicit SingleChildScrollView is removed from the content, as the framework now internally handles scrolling for both the title and content, streamlining the widget hierarchy and resolving previous overflow issues.
SOURCE: https://docs.flutter.dev/release/breaking-changes/scrollable-alert-dialog

LANGUAGE: dart
CODE:
```
AlertDialog(
  title: Text('Very, very large title', textScaleFactor: 5),
  content: Text('Very, very large content', textScaleFactor: 5),
  actions: <Widget>[
    TextButton(child: Text('Button 1'), onPressed: () {}),
    TextButton(child: Text('Button 2'), onPressed: () {}),
  ],
)
```

----------------------------------------

TITLE: Handling Basic Taps with ElevatedButton and GestureDetector in Flutter
DESCRIPTION: This snippet demonstrates two primary methods for handling tap gestures in Flutter. For widgets that inherently support interaction, such as `ElevatedButton`, the `onPressed` callback can be used directly. For other widgets, wrapping them in a `GestureDetector` allows for custom tap detection via its `onTap` property. Both methods log a message upon interaction.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      developer.log('click');
    },
    child: const Text('Button'),
  );
}
```

LANGUAGE: dart
CODE:
```
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            developer.log('tap');
          },
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Subscribing to ViewModel Changes in Flutter View
DESCRIPTION: This Dart code shows how to subscribe to a view model's changes in a Flutter widget's `initState` method and unsubscribe in `dispose`. This pattern ensures proper resource management and allows the view to react to state updates from the view model.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
@override
void initState() {
  super.initState();
  widget.viewModel.addListener(_onViewModelChanged);
}

@override
void dispose() {
  widget.viewModel.removeListener(_onViewModelChanged);
  super.dispose();
}
```

----------------------------------------

TITLE: Flutter: Create a TextFormField with InputDecoration
DESCRIPTION: This example shows how to create a `TextFormField` widget in Flutter. It includes an `UnderlineInputBorder` and a label using `InputDecoration`. `TextFormField` wraps a `TextField` and integrates with a `Form` for validation and other form field functionalities.
SOURCE: https://docs.flutter.dev/cookbook/forms/text-input

LANGUAGE: dart
CODE:
```
TextFormField(
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Enter your username',
  ),
),
```

----------------------------------------

TITLE: Migrating Material Theme Configuration in Flutter
DESCRIPTION: This snippet demonstrates the required migration for ThemeData.cardTheme, ThemeData.dialogTheme, and ThemeData.tabBarTheme. Previously, these properties accepted Object? for a smooth transition, but now strictly require CardThemeData?, DialogThemeData?, and TabBarThemeData? respectively. The 'before' code shows the old usage with CardTheme(), DialogTheme(), and TabBarTheme(), while the 'after' code illustrates the updated usage with their *Data() counterparts.
SOURCE: https://docs.flutter.dev/release/breaking-changes/material-theme-system-updates

LANGUAGE: dart
CODE:
```
final ThemeData theme = ThemeData(
    cardTheme: CardTheme(),
    dialogTheme: DialogTheme(),
    tabBarTheme: TabBarTheme(),
);
```

LANGUAGE: dart
CODE:
```
final ThemeData theme = ThemeData(
    cardTheme: CardThemeData(),
    dialogTheme: DialogThemeData(),
    tabBarTheme: TabBarThemeData(),
);
```

----------------------------------------

TITLE: Configure Gemini AI Provider in Flutter
DESCRIPTION: Initialize the `LlmChatView` widget with `GeminiProvider`, creating a `GenerativeModel` instance that specifies the Gemini model name and your API key for direct Google Gemini AI integration.
SOURCE: https://docs.flutter.dev/ai-toolkit

LANGUAGE: dart
CODE:
```
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... app stuff here

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: LlmChatView(
          provider: GeminiProvider(
            model: GenerativeModel(
              model: 'gemini-2.0-flash',
              apiKey: 'GEMINI-API-KEY',
            ),
          ),
        ),
      );
}
```

----------------------------------------

TITLE: Displaying Progress Indicator and Data List in Flutter
DESCRIPTION: This Flutter example demonstrates how to show a ProgressIndicator while data is being loaded from a network call and then display the loaded data in a ListView. The UI updates are controlled by a boolean flag (showLoadingDialog) which is true when data is empty, triggering the progress indicator, and false when data is loaded, showing the list.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/uikit-devs

LANGUAGE: dart
CODE:
```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool get showLoadingDialog => data.isEmpty;

  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }

  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }

    return getListView();
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Row ${data[i]["title"]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
}
```

----------------------------------------

TITLE: Style and Align Text in Flutter and CSS
DESCRIPTION: Demonstrates how to apply font styles, sizes, and weights using Flutter's TextStyle and align text with textAlign, contrasting with CSS font and text-align properties. Both frameworks default to top-left anchoring for child elements.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/web-devs

LANGUAGE: css
CODE:
```
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Georgia;
}
```

LANGUAGE: dart
CODE:
```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: const Text(
    'Lorem ipsum',
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
);
```

----------------------------------------

TITLE: Exposing UI State in a ViewModel
DESCRIPTION: View models contain a representation of the UI state, including the data being displayed. This example shows how a `HomeViewModel` exposes a `User` instance to the view.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/command

LANGUAGE: dart
CODE:
```
class HomeViewModel extends ChangeNotifier {

  User? get user => // ...
  // ···
}
```

----------------------------------------

TITLE: Optimize AnimatedBuilder Subtree Rebuilds
DESCRIPTION: Placing widgets that don't depend on the animation inside an `AnimatedBuilder`'s builder function causes unnecessary rebuilds for every animation tick. Optimize by building static parts once and passing them as children.
SOURCE: https://docs.flutter.dev/perf/best-practices

LANGUAGE: APIDOC
CODE:
```
Pitfall: Putting non-animation-dependent subtrees in `AnimatedBuilder`'s builder function.
Recommendation: Build static parts of the subtree once and pass as a child to `AnimatedBuilder`.
Reference: AnimatedBuilder API page - Performance optimizations.
```

----------------------------------------

TITLE: Flutter Mix-and-Match State Management Example
DESCRIPTION: This Dart code demonstrates a 'mix-and-match' approach to state management in Flutter. The ParentWidget manages the _active state of TapboxC and updates it via a callback. TapboxC internally manages its _highlight state, which controls a visual border, and uses GestureDetector to handle tap events. It exports its _active state changes back to the parent. The example shows how setState() is used in both parent and child states to update the UI.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TapboxC(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  const TapboxC({super.key, this.active = false, required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<TapboxC> createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(color: Colors.teal[700]!, width: 10)
              : null,
        ),
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Render data source into widgets with ListView.builder in Flutter
DESCRIPTION: Illustrates how to convert a data source into a scrollable list of widgets using Flutter's ListView.builder. This method efficiently builds list items only when they are visible on screen, optimizing performance for long lists.
SOURCE: https://docs.flutter.dev/cookbook/lists/long-lists

LANGUAGE: dart
CODE:
```
ListView.builder(
  itemCount: items.length,
  prototypeItem: ListTile(title: Text(items.first)),
  itemBuilder: (context, index) {
    return ListTile(title: Text(items[index]));
  },
)
```

----------------------------------------

TITLE: Injecting Repositories into View Models using GoRouter in Flutter
DESCRIPTION: Demonstrates how `package:go_router` can be configured to create screen-specific view models and inject necessary repositories into them using `context.read()` within the `builder` function of `GoRoute`.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/dependency-injection

LANGUAGE: dart
CODE:
```
// This code was modified for demo purposes.
GoRouter router(
  AuthRepository authRepository,
) =>
    GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      redirect: _redirect,
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) {
            return LoginScreen(
              viewModel: LoginViewModel(
                authRepository: context.read(),
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            final viewModel = HomeViewModel(
              bookingRepository: context.read(),
            );
            return HomeScreen(viewModel: viewModel);
          },
          routes: [
            // ...
          ],
        )
      ]
    );
```

----------------------------------------

TITLE: Control Dark Mode Theme (Flutter)
DESCRIPTION: This snippet shows how to implement dark mode in Flutter applications. Flutter controls brightness at the app-level using the `theme` property of `CupertinoApp`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/swiftui-devs

LANGUAGE: Dart
CODE:
```
const CupertinoApp(
  theme: CupertinoThemeData(brightness: Brightness.dark),
  home: HomePage(),
);
```

----------------------------------------

TITLE: Flutter ConstrainedBox with Center Widget
DESCRIPTION: Shows how wrapping a ConstrainedBox with a Center widget allows the ConstrainedBox to apply its constraints effectively, as Center provides flexible constraints up to the screen size, enabling the ConstrainedBox to impose its own limits.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
                 minWidth: 70, minHeight: 70,
                 maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 10, height: 10))))
```

----------------------------------------

TITLE: Position buttons using a Row widget in Flutter
DESCRIPTION: This code demonstrates how to use a `Row` widget to position multiple instances of the `ButtonWithText` widget horizontally. It adds three `ButtonWithText` instances, each with specific icons and labels, and uses `MainAxisAlignment.spaceEvenly` to distribute space equally around the buttons along the row's main axis.
SOURCE: https://docs.flutter.dev/ui/layout/tutorial

LANGUAGE: dart
CODE:
```
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(color: color, icon: Icons.call, label: 'CALL'),
          ButtonWithText(color: color, icon: Icons.near_me, label: 'ROUTE'),
          ButtonWithText(color: color, icon: Icons.share, label: 'SHARE'),
        ],
      ),
    );
  }

}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      // ···
    );
  }

}
```

----------------------------------------

TITLE: Packing Row Children with mainAxisSize.min in Flutter Dart
DESCRIPTION: This Dart code snippet demonstrates how to use `mainAxisSize.min` on a `Row` widget to make it occupy only the minimum space required by its children along the main axis. This effectively packs the star icons closely together, contrasting with the default behavior where a Row or Column expands to fill available space.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: Dart
CODE:
```
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
)
```

----------------------------------------

TITLE: ViewModel with Future for asynchronous weather fetching in Dart
DESCRIPTION: Defines a `HomePageViewModel` that uses a `Future` to represent an asynchronously provided weather value. The `load()` function is marked `async` and returns a `Future<Weather>`.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/dart-swift-concurrency

LANGUAGE: dart
CODE:
```
@immutable
class HomePageViewModel {
  const HomePageViewModel();
  Future<Weather> load() async {
    await Future.delayed(const Duration(seconds: 1));
    return Weather.sunny;
  }
}
```

----------------------------------------

TITLE: Provide FirebaseFirestore Instance to Flutter App
DESCRIPTION: This snippet demonstrates how to make the `FirebaseFirestore` instance accessible throughout your Flutter application using the `provider` package. It replaces the standard `runApp()` call to wrap `MyApp` with a `Provider.value`.
SOURCE: https://docs.flutter.dev/cookbook/games/firestore-multiplayer

LANGUAGE: dart
CODE:
```
runApp(Provider.value(value: FirebaseFirestore.instance, child: MyApp()));
```

----------------------------------------

TITLE: Understand Flutter Keys for Efficient Widget Rebuilding
DESCRIPTION: Describes how Flutter uses keys to control widget matching during rebuilds, contrasting it with the default runtimeType and order matching. It explains how keys enable more efficient updates and state retention, especially in dynamic lists.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
Widget:
  runtimeType: The type of the widget at runtime. Used by default for widget matching.
  key:
    Type: Key
    Purpose: An identifier for this widget that can be used to distinguish it from other widgets in the same list.
    Usage: When a widget rebuilds, the framework matches widgets in the current and previous build based on their runtimeType and key (if provided). This is crucial for efficient updates and preserving state in dynamic lists.
```

----------------------------------------

TITLE: Illustrative generated _$UserToJson function for nested objects (without explicitToJson)
DESCRIPTION: Displays the problematic generated `_$UserToJson` function from `json_serializable` when `explicitToJson` is not set, showing how it serializes nested objects as `Instance of 'address'`.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
};
```

----------------------------------------

TITLE: Create a Flutter app with a long scrollable list
DESCRIPTION: This code creates a basic Flutter application displaying a long list of items. It uses `ListView.builder` to efficiently render 10,000 items and adds `Key`s to the `ListView` and individual `Text` widgets. These keys are crucial for identifying and interacting with widgets during integration tests, allowing testers to find specific items and scroll through the list programmatically.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/scrolling

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(items: List<String>.generate(10000, (i) => 'Item $i')));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          // Add a key to the ListView. This makes it possible to
          // find the list and scroll through it in the tests.
          key: const Key('long_list'),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                // Add a key to the Text widget for each item. This makes
                // it possible to look for a particular item in the list
                // and verify that the text is correct
                key: Key('item_${index}_text'),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Fetch IP Address Asynchronously in Dart
DESCRIPTION: Demonstrates how to use `async` and `await` in Dart to perform an asynchronous HTTP GET request to `httpbin.org/ip` and parse the JSON response to extract the 'origin' (IP address). It requires the `dart:convert` and `package:http` libraries.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: dart
CODE:
```
// Dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class Example {
  Future<String> _getIPAddress() async {
    final url = Uri.https('httpbin.org', '/ip');
    final response = await http.get(url);
    final ip = jsonDecode(response.body)['origin'] as String;
    return ip;
  }
}
```

----------------------------------------

TITLE: Implement ThemeSwitch StatelessWidget for UI
DESCRIPTION: The `ThemeSwitch` is a `StatelessWidget` that encapsulates a `Switch` widget, providing the user interface for toggling dark mode. It observes the `isDarkMode` state from the `ThemeSwitchViewModel` and executes the `toggle` command on the view model when the switch is interacted with, ensuring UI updates reflect the underlying state.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/key-value-data

LANGUAGE: dart
CODE:
```
class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key, required this.viewmodel});

  final ThemeSwitchViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Text('Dark Mode'),
          ListenableBuilder(
            listenable: viewmodel,
            builder: (context, _) {
              return Switch(
                value: viewmodel.isDarkMode,
                onChanged: (_) {
                  viewmodel.toggle.execute();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
```

----------------------------------------

TITLE: Define Photo Class with fromJson Factory in Dart
DESCRIPTION: This Dart code defines a `Photo` class to structure photo data, including `albumId`, `id`, `title`, `url`, and `thumbnailUrl`. It features a `fromJson()` factory constructor, enabling easy instantiation of `Photo` objects directly from a `Map<String, dynamic>` JSON object.
SOURCE: https://docs.flutter.dev/cookbook/networking/background-parsing

LANGUAGE: dart
CODE:
```
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
```

----------------------------------------

TITLE: Flutter Gesture Detection API Reference
DESCRIPTION: Reference for Flutter widgets involved in gesture detection. It details the GestureDetector widget for custom gesture handling and highlights common button widgets like IconButton, ElevatedButton, and FloatingActionButton that provide onPressed callbacks for tap events.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
Widget: GestureDetector
  Description: A widget that detects gestures. It does not have a visual representation itself but wraps other widgets to make them interactive.
  Common Callbacks:
    onTap: Called when the user taps this widget.
    Other Gestures: Supports various gestures like drags, scales, etc.

Related Widgets with Gesture Callbacks:
  IconButton
    onPressed: Callback triggered on tap.
  ElevatedButton
    onPressed: Callback triggered on tap.
  FloatingActionButton
    onPressed: Callback triggered on tap.
```

----------------------------------------

TITLE: Migrate Flutter BottomNavigationBar to NavigationBar
DESCRIPTION: This snippet demonstrates how to replace the Material 2 style `BottomNavigationBar` widget with the new Material 3 `NavigationBar` widget. The new widget is slightly taller, features pill-shaped navigation indicators, and uses updated color mappings.
SOURCE: https://docs.flutter.dev/release/breaking-changes/material-3-migration

LANGUAGE: dart
CODE:
```
BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'School',
    ),
  ],
),
```

LANGUAGE: dart
CODE:
```
NavigationBar(
  destinations: const <Widget>[
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    NavigationDestination(
      icon: Icon(Icons.school),
      label: 'School',
    ),
  ],
),
```

----------------------------------------

TITLE: Flutter Widget Build Method with Scaling Animation
DESCRIPTION: This snippet illustrates a Flutter `build` method that positions a widget and applies a scaling animation using `AnimatedBuilder` and `Transform.scale`. It's designed for dynamic UI elements where a child widget (e.g., a bubble) needs to animate its size based on an animation controller.
SOURCE: https://docs.flutter.dev/cookbook/effects/typing-indicator

LANGUAGE: Dart
CODE:
```
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }
```

----------------------------------------

TITLE: Catch Asynchronous Errors Using `PlatformDispatcher.instance.onError` in Flutter
DESCRIPTION: This snippet demonstrates how to implement a global error handler for errors that are not caught by `FlutterError.onError`, specifically those forwarded to `PlatformDispatcher`. It shows how to set `PlatformDispatcher.instance.onError` to process and potentially send error details to a backend service.
SOURCE: https://docs.flutter.dev/testing/errors

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  MyBackend myBackend = MyBackend();
  PlatformDispatcher.instance.onError = (error, stack) {
    myBackend.sendError(error, stack);
    return true;
  };
  runApp(const MyApp());
}
```

----------------------------------------

TITLE: Connect to a WebSocket Server in Flutter
DESCRIPTION: This snippet demonstrates how to establish a connection to a WebSocket server using the `web_socket_channel` package. It creates a `WebSocketChannel` instance by parsing a WebSocket URI, enabling both listening for and pushing messages.
SOURCE: https://docs.flutter.dev/cookbook/networking/web-sockets

LANGUAGE: Dart
CODE:
```
final channel = WebSocketChannel.connect(
  Uri.parse('wss://echo.websocket.events'),
);
```

----------------------------------------

TITLE: Flutter FittedBox Inside Center: Scaling Large Text to Fit Screen
DESCRIPTION: Illustrates FittedBox behavior when inside a Center widget and its child (Text) is too large for the screen. FittedBox attempts to size itself to the Text but is limited by the screen size. It then assumes the screen size and resizes the Text to fit within those bounds.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
Center(
   child: FittedBox(
      child: Text('…')));
```

----------------------------------------

TITLE: Perform I/O-bound work with async/await in Flutter
DESCRIPTION: Demonstrates how to fetch data from a network resource using `async`/`await` for I/O-bound operations in Flutter. This pattern is suitable for network or database calls and updates the UI upon completion without blocking the main thread.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: Dart
CODE:
```
Future<void> loadData() async {
  final dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(dataURL);
  setState(() {
    widgets = (jsonDecode(response.body) as List)
        .cast<Map<String, Object?>>();
  });
}
```

----------------------------------------

TITLE: Flutter Tap Gesture Handling with GestureDetector
DESCRIPTION: This Flutter example demonstrates how to detect tap gestures on a custom button using a `GestureDetector` widget. When the button is tapped, a `SnackBar` is displayed at the bottom of the screen. It showcases basic UI setup with `MaterialApp`, `Scaffold`, and custom `StatelessWidget` components.
SOURCE: https://docs.flutter.dev/cookbook/gestures/handling-taps

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Gesture Demo';

    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        const snackBar = SnackBar(content: Text('Tap'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      // The custom button
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('My Button'),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Full Flutter example for background work with Isolates
DESCRIPTION: A complete Flutter application demonstrating how to integrate `Isolate`s for background processing. It includes the main app structure, state management, and the `loadData` function utilizing isolates to fetch and process data, displaying a loading dialog until data is ready.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: Dart
CODE:
```
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget getBody() {
    bool showLoadingDialog = widgets.isEmpty;
    if (showLoadingDialog) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
```

----------------------------------------

TITLE: Define Address class for json_serializable in Dart
DESCRIPTION: Provides the Dart code for an `Address` class, annotated with `@JsonSerializable()`, including constructor, fields, and the `fromJson`/`toJson` factory methods required for `json_serializable`.
SOURCE: https://docs.flutter.dev/data-and-backend/serialization/json

LANGUAGE: dart
CODE:
```
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String street;
  String city;

  Address(this.street, this.city);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
```

----------------------------------------

TITLE: Flutter Parent Widget Manages Child Widget State via Callback
DESCRIPTION: This Dart code demonstrates how a `ParentWidget` (a StatefulWidget) manages the `_active` state for `TapboxB` (a StatelessWidget). `TapboxB` notifies its parent of tap events via the `onChanged` callback, allowing the parent to update the shared state and rebuild the UI. This pattern is useful when the parent needs to react to changes in the child's state, centralizing state management.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

// ParentWidget manages the state for TapboxB.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TapboxB(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  const TapboxB({super.key, this.active = false, required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Request Shared Data from Android Native Side in Flutter using MethodChannel
DESCRIPTION: This Dart code demonstrates how a Flutter application requests shared text data from the native Android side using a `MethodChannel`. It initializes the channel with the same name as defined in Java (`app.channel.shared.data`) and invokes the `getSharedText` method. The received data is then displayed in the Flutter UI, with the data request initiated when the widget is initialized (`initState`).
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Shared App Handler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  static const platform = MethodChannel('app.channel.shared.data');
  String dataShared = 'No data';

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(dataShared)));
  }

  Future<void> getSharedText() async {
    var sharedData = await platform.invokeMethod('getSharedText');
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData as String;
      });
    }
  }
}
```

----------------------------------------

TITLE: Updating ApiClientService Method Signature to Return Result
DESCRIPTION: This snippet demonstrates how to modify a method signature, specifically 'getUserProfile' in 'ApiClientService', to return a 'Future<Result<UserProfile>>' instead of directly returning 'UserProfile'. This change indicates that the method will now encapsulate its outcome (success or error) within a 'Result' object, aligning with the result pattern for error handling.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/result

LANGUAGE: dart
CODE:
```
class ApiClientService {
  // ···

  Future<Result<UserProfile>> getUserProfile() async {
    // ···
  }
}
```

----------------------------------------

TITLE: Flutter AnimatedContainer Interactive Demo
DESCRIPTION: This Dart code defines a Flutter application that uses an `AnimatedContainer` widget. It demonstrates how to dynamically update the container's width, height, color, and border radius using `setState` when a FloatingActionButton is pressed, with smooth transitions provided by `AnimatedContainer`.
SOURCE: https://docs.flutter.dev/cookbook/animation/animated-container

LANGUAGE: Dart
CODE:
```
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const AnimatedContainerApp());

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedContainer Demo')),
        body: Center(
          child: AnimatedContainer(
            // Use the properties stored in the State class.
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            // Define how long the animation should take.
            duration: const Duration(seconds: 1),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {
              // Create a random number generator.
              final random = Random();

              // Generate a random width and height.
              _width = random.nextInt(300).toDouble();
              _height = random.nextInt(300).toDouble();

              // Generate a random color.
              _color = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );

              // Generate a random border radius.
              _borderRadius = BorderRadius.circular(
                random.nextInt(100).toDouble(),
              );
            });
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Manage UI State in Compose and Flutter
DESCRIPTION: This snippet demonstrates how to manage local UI state in both Jetpack Compose and Flutter. Compose uses the `remember` API and `MutableState` for state observation, while Flutter relies on `StatefulWidget` and `setState()` to trigger UI updates and redraw the widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: kotlin
CODE:
```
Scaffold(
   content = { padding ->
      var _counter = remember {  mutableIntStateOf(0) }
      Column(horizontalAlignment = Alignment.CenterHorizontally,
         verticalArrangement = Arrangement.Center,
         modifier = Modifier.fillMaxSize().padding(padding)) {
            Text(_counter.value.toString())
            Spacer(modifier = Modifier.height(16.dp))
            FilledIconButton (onClick = { -> _counter.intValue += 1 }) {
               Text("+")
            }
      }
   }
)
```

LANGUAGE: dart
CODE:
```
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter'),
            TextButton(
              onPressed: () => setState(() {
                _counter++;
              }),
              child: const Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Build a Card List Item with Loading State in Flutter
DESCRIPTION: This Flutter `StatelessWidget` creates a card-style list item that can display either an image and text, or placeholder shimmer-like rectangles when in a loading state. It uses `AspectRatio`, `Container`, `BoxDecoration`, `ClipRRect` for the image, and conditionally renders text or loading placeholders based on the `isLoading` property.
SOURCE: https://docs.flutter.dev/cookbook/effects/shimmer-loading

LANGUAGE: Dart
CODE:
```
class CardListItem extends StatelessWidget {
  const CardListItem({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImage(), const SizedBox(height: 16), _buildText()],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://docs.flutter.dev/cookbook'
            '/img-files/effects/split-check/Food1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 250,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      );
    }
  }
}
```

----------------------------------------

TITLE: Apply Custom Themes in Flutter with MaterialApp
DESCRIPTION: This Dart code snippet demonstrates how to apply a custom theme to a Flutter application using the `MaterialApp` widget. It shows how to configure a `ThemeData` object to set a custom color scheme from a seed color (deepPurple) and define a specific text selection color (red), providing a consistent visual style across the app.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: const SampleAppPage(),
    );
  }
}
```

----------------------------------------

TITLE: Initialize Firebase for Vertex AI in Flutter
DESCRIPTION: Perform asynchronous initialization of Firebase in your Flutter application's `main` function. This step is crucial for using Firebase Vertex AI, ensuring `WidgetsFlutterBinding.ensureInitialized()` and `Firebase.initializeApp()` are called with platform-specific options.
SOURCE: https://docs.flutter.dev/ai-toolkit

LANGUAGE: dart
CODE:
```
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... other imports

import 'firebase_options.dart'; // from `flutterfire config`

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

// ...app stuff here
```

----------------------------------------

TITLE: Flutter Widget: ListView Scrolling
DESCRIPTION: The ListView widget creates a scrollable, linear list of widgets. It is one of the most frequently used scrolling widgets in Flutter, efficiently displaying large numbers of items.
SOURCE: https://docs.flutter.dev/ui/widgets/layout

LANGUAGE: APIDOC
CODE:
```
ListView:
  A scrollable, linear list of widgets. ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction....
```

----------------------------------------

TITLE: Flutter Layouts: ListView Widget (Optimized Scrolling for Many Items)
DESCRIPTION: This example demonstrates Flutter's ListView, an optimized widget for scrolling a list of many items, even of different types. It is more performant than Xamarin.Forms' ListView due to Flutter's rendering approach.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}
```

----------------------------------------

TITLE: Add Padding to a Widget with Flutter Container
DESCRIPTION: Illustrates how to apply uniform padding around a widget using the `Container` widget's `padding` property. This example uses `EdgeInsets.all` to apply 16 logical pixels of padding on all sides.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: Dart
CODE:
```
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: BorderedImage(),
  );
}
```

----------------------------------------

TITLE: Flutter Scaffold Filling Screen with Loose Constraints
DESCRIPTION: Shows how `Scaffold` fills the entire screen and provides loose constraints to its `body` child. This allows the child (`Container` in this example) to be any size it wants, but not bigger than the screen, demonstrating a 'loose' constraint.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: dart
CODE:
```
Scaffold(
  body: Container(
    color: blue,
    child: const Column(children: [Text('Hello!'), Text('Goodbye!')]),
  ),
)
```

----------------------------------------

TITLE: Define UserProfileViewModel for UI Data Management
DESCRIPTION: The UserProfileViewModel extends ChangeNotifier and uses the UserProfileRepository to manage and display UserProfile data on a widget. It includes methods to load the user profile from the database or network and save updated profile information.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
class UserProfileViewModel extends ChangeNotifier {
  // ···
  final UserProfileRepository _userProfileRepository;

  UserProfile? get userProfile => _userProfile;
  // ···

  /// Load the user profile from the database or the network
  Future<void> load() async {
    // ···
  }

  /// Save the user profile with the new name
  Future<void> save(String newName) async {
    // ···
  }
}
```

----------------------------------------

TITLE: Updating Local State from Firestore and Custom Exception Handling in Dart
DESCRIPTION: This Dart code snippet demonstrates how to update the local game state (`PlayingArea`) based on new data received from a Firestore `DocumentSnapshot`. It checks for changes to avoid unnecessary updates and defines a custom `FirebaseControllerException` class for specific error handling within the application.
SOURCE: https://docs.flutter.dev/cookbook/games/firestore-multiplayer

LANGUAGE: Dart
CODE:
```
void _updateLocalFromFirestore(
    PlayingArea area,
    DocumentSnapshot<List<PlayingCard>> snapshot,
  ) {
    _log.fine('Received new data from Firestore (${snapshot.data()})');

    final cards = snapshot.data() ?? [];

    if (listEquals(cards, area.cards)) {
      _log.fine('No change');
    } else {
      _log.fine('Updating local data with Firestore data ($cards)');
      area.replaceWith(cards);
    }
  }
}

class FirebaseControllerException implements Exception {
  final String message;

  FirebaseControllerException(this.message);

  @override
  String toString() => 'FirebaseControllerException: $message';
}
```

----------------------------------------

TITLE: Create a Tappable Button with GestureDetector in Flutter
DESCRIPTION: This Flutter code demonstrates how to create a simple interactive button using the GestureDetector widget. It wraps a Container to make it tappable, and when tapped, the onTap callback prints a message to the console, illustrating basic gesture detection.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen[500],
        ),
        child: const Center(child: Text('Engage')),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: MyButton())),
    ),
  );
}
```

----------------------------------------

TITLE: Read integer data from SharedPreferences
DESCRIPTION: To retrieve data, use the appropriate getter method from the `SharedPreferences` class, such as `getInt`. This example shows how to read an integer value, providing a default of 0 if the key is not found in storage. Be aware that an exception is thrown if the stored value's type does not match the getter method's expected type.
SOURCE: https://docs.flutter.dev/cookbook/persistence/key-value

LANGUAGE: dart
CODE:
```
final prefs = await SharedPreferences.getInstance();

// Try reading the counter value from persistent storage.
// If not present, null is returned, so default to 0.
final counter = prefs.getInt('counter') ?? 0;
```

----------------------------------------

TITLE: Fetch User Profile with Stream in Dart (Offline-First)
DESCRIPTION: This Dart function demonstrates fetching a user profile using a Stream. It first attempts to retrieve data from a local database, yielding it if found. Subsequently, it fetches the latest data from an API, updates the database, and yields the API result. This ensures the view model receives both cached and up-to-date information.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
Stream<UserProfile> getUserProfile() async* {
  // Fetch the user profile from the database
  final userProfile = await _databaseService.fetchUserProfile();
  // Returns the database result if it exists
  if (userProfile != null) {
    yield userProfile;
  }

  // Fetch the user profile from the API
  try {
    final apiUserProfile = await _apiClientService.getUserProfile();
    //Update the database with the API result
    await _databaseService.updateUserProfile(apiUserProfile);
    // Return the API result
    yield apiUserProfile;
  } catch (e) {
    // Handle the error
  }
}
```

----------------------------------------

TITLE: Validate Flutter and Dart SDK PATH setup
DESCRIPTION: After modifying and applying changes to your environment variables, run these commands in a new Zsh session to confirm that the 'flutter' and 'dart' tools are accessible and correctly configured in your PATH.
SOURCE: https://docs.flutter.dev/install/add-to-path

LANGUAGE: bash
CODE:
```
flutter --version
dart --version
```

----------------------------------------

TITLE: Defining Initial State Variables in Flutter State Class
DESCRIPTION: This snippet shows the initial definition of the _FavoriteWidgetState class, which extends State<FavoriteWidget>. It declares two private mutable fields, _isFavorited (boolean) and _favoriteCount (integer), to store the widget's current favorite status and count, respectively. These values represent the initial state when the app launches.
SOURCE: https://docs.flutter.dev/ui/interactivity

LANGUAGE: dart
CODE:
```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
```

----------------------------------------

TITLE: Complete Flutter Widget Testing Example with findsOneWidget
DESCRIPTION: This Dart code provides a complete example of how to test a Flutter widget. It defines a `MyWidget` with a title and message, then uses `testWidgets` to build and interact with it, verifying the presence of the title and message text using the `findsOneWidget` matcher.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/introduction

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text(message)),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Create a Flutter Form with GlobalKey
DESCRIPTION: This snippet demonstrates how to create a `Form` widget in Flutter and associate it with a `GlobalKey<FormState>`. The `Form` acts as a container for grouping and validating multiple form fields. Using a `StatefulWidget` is recommended to efficiently manage the `GlobalKey` and prevent its regeneration on every build, ensuring consistent form state and validation access.
SOURCE: https://docs.flutter.dev/cookbook/forms/validation

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: const Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
```

----------------------------------------

TITLE: Run Flutter Doctor to verify development setup
DESCRIPTION: Command to run `flutter doctor`, which validates all components of the Flutter development environment for macOS, checking for missing dependencies or configurations. It provides a summary of the setup status.
SOURCE: https://docs.flutter.dev/get-started/install/macos/desktop

LANGUAGE: bash
CODE:
```
flutter doctor
```

----------------------------------------

TITLE: Flutter CLI: Manage Pub Dependencies
DESCRIPTION: Shows how to use the `flutter` tool to interact with Dart's package manager, `pub`. This includes fetching dependencies, checking for outdated packages, and upgrading them.
SOURCE: https://docs.flutter.dev/reference/flutter-cli

LANGUAGE: Bash
CODE:
```
flutter pub get
flutter pub outdated
flutter pub upgrade
```

----------------------------------------

TITLE: Define BubbleBackground Widget and Initial BubblePainter in Flutter
DESCRIPTION: This snippet introduces `BubbleBackground`, a `StatelessWidget` that uses `CustomPaint` to render a `BubblePainter`. It also defines the initial structure of `BubblePainter`, an implementation of `CustomPainter` responsible for drawing gradients, with `paint()` and `shouldRepaint()` methods as placeholders.
SOURCE: https://docs.flutter.dev/cookbook/effects/gradient-bubbles

LANGUAGE: dart
CODE:
```
@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({super.key, required this.colors, this.child});

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(colors: colors),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({required List<Color> colors}) : _colors = colors;

  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO:
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    // TODO:
    return false;
  }
}
```

----------------------------------------

TITLE: Add go_router package to Flutter project
DESCRIPTION: Add the `go_router` package as a dependency to your Flutter project using `flutter pub add`. This package simplifies complex routing scenarios and is recommended for handling deep links.
SOURCE: https://docs.flutter.dev/cookbook/navigation/set-up-app-links

LANGUAGE: bash
CODE:
```
flutter pub add go_router
```

----------------------------------------

TITLE: Adding a Flutter package dependency
DESCRIPTION: Command to add a Flutter package, such as `awesome_package`, to an application's `pubspec.yaml` using the `flutter pub add` command-line tool.
SOURCE: https://docs.flutter.dev/cookbook/design/package-fonts

LANGUAGE: bash
CODE:
```
flutter pub add awesome_package
```

----------------------------------------

TITLE: Create a basic Flutter ListView
DESCRIPTION: This snippet demonstrates how to create a simple ListView in Flutter. Unlike Xamarin.Forms, Flutter's ListView takes a list of widgets directly, leveraging its immutable widget pattern for efficient rendering and smooth scrolling without manual cell recycling.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatelessWidget {
  const SampleAppPage({super.key});

  List<Widget> _getListData() {
    return List<Widget>.generate(
      100,
      (index) =>
          Padding(padding: const EdgeInsets.all(10), child: Text('Row $index')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: _getListData()),
    );
  }
}
```

----------------------------------------

TITLE: Read and Synchronize User Profile with Local Data in Dart
DESCRIPTION: This Dart snippet provides two functions for an offline-first approach relying primarily on local data. getUserProfile fetches the profile from the database, throwing an error if not found. sync fetches the latest profile from the API and updates the local database, handling network errors gracefully. This pattern is suitable for applications where immediate server synchronization is not critical.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
Future<UserProfile> getUserProfile() async {
  // Fetch the user profile from the database
  final userProfile = await _databaseService.fetchUserProfile();

  // Return the database result if it exists
  if (userProfile == null) {
    throw Exception('Data not found');
  }

  return userProfile;
}

Future<void> sync() async {
  try {
    // Fetch the user profile from the API
    final userProfile = await _apiClientService.getUserProfile();

    // Update the database with the API result
    await _databaseService.updateUserProfile(userProfile);
  } catch (e) {
    // Try again later
  }
}
```

----------------------------------------

TITLE: Displaying Lists with Iteration and Lazy Loading (Compose & Flutter)
DESCRIPTION: This snippet illustrates two methods for displaying lists: simple iteration for small datasets and performance-optimized lazy lists for large datasets. It demonstrates `Column` with `forEach` and `LazyColumn` with `items` in Compose, and `ListView.builder` in Flutter for efficient list rendering, along with data model definitions.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/compose-devs

LANGUAGE: kotlin
CODE:
```
data class Person(val name: String)

val people = arrayOf(
   Person(name = "Person 1"),
   Person(name = "Person 2"),
   Person(name = "Person 3")
)

@Composable
fun ListDemo(people: List<Person>) {
   Column {
      people.forEach {
         Text(it.name)
      }
   }
}

@Composable
fun ListDemo2(people: List<Person>) {
   LazyColumn {
      items(people) { person ->
         Text(person.name)
      }
   }
}
```

LANGUAGE: dart
CODE:
```
class Person {
  String name;
  Person(this.name);
}

var items = [
  Person('Person 1'),
  Person('Person 2'),
  Person('Person 3'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
          );
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Create Responsive Layouts with Flutter LayoutBuilder
DESCRIPTION: This snippet demonstrates how to use Flutter's `LayoutBuilder` widget to create responsive user interfaces. It utilizes the `BoxConstraints` provided by the parent widget to conditionally render different layouts (`_MobileLayout` or `_DesktopLayout`) based on the available width, specifically at a 600-pixel breakpoint.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/layout

LANGUAGE: dart
CODE:
```
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 600) {
        return _MobileLayout();
      } else {
        return _DesktopLayout();
      }
    },
  );
}
```

----------------------------------------

TITLE: Navigating to a named route in Flutter
DESCRIPTION: This Dart code snippet illustrates how to navigate to a predefined named route using Navigator.pushNamed(context, '/second'). Named routes are declared in MaterialApp.routes and provide a way to handle simple deep linking, though they come with certain limitations regarding customizability and browser history support.
SOURCE: https://docs.flutter.dev/ui/navigation

LANGUAGE: dart
CODE:
```
child: const Text('Open second screen'),
onPressed: () {
  Navigator.pushNamed(context, '/second');
}
```

----------------------------------------

TITLE: Create a Toggling ElevatedButton in Flutter
DESCRIPTION: This snippet demonstrates how to implement an `ElevatedButton` in Flutter that changes its displayed text ('Blink' or 'Stop Blinking') based on a `toggleState` boolean variable. The button's `onPressed` callback invokes `toggleBlinkState`, which is expected to update the `toggleState` and trigger a UI rebuild. The button is placed within a `Container` with top padding for layout purposes, showing a common way to position widgets.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
Container(
  padding: const EdgeInsets.only(top: 70),
  child: ElevatedButton(
    onPressed: toggleBlinkState,
    child: toggleState
        ? const Text('Blink')
        : const Text('Stop Blinking'),
  ),
)
```

----------------------------------------

TITLE: Flutter StatefulWidget Class API Reference
DESCRIPTION: The `StatefulWidget` is a type of widget that has mutable state. Unlike `StatelessWidget`, its state can change over time. The framework calls `createState()` to create the associated `State` object when the widget is first inserted into the widget tree.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
StatefulWidget:
  createState(): State<StatefulWidget>
    Description: Creates the mutable state for this widget at a given location in the tree.
```

----------------------------------------

TITLE: Configure Android Toolchain in Android Studio (First Time User)
DESCRIPTION: Instructions for first-time Android Studio users to install necessary Android SDK components via the Setup Wizard. This ensures the environment is ready for Flutter Android development.
SOURCE: https://docs.flutter.dev/get-started/install/macos/mobile-android

LANGUAGE: APIDOC
CODE:
```
Android Studio Setup (First Time User):
  1. Launch Android Studio.
  2. Follow the Android Studio Setup Wizard.
  3. Install the following components:
     - Android SDK Platform, API 35
     - Android SDK Command-line Tools
     - Android SDK Build-Tools
     - Android SDK Platform-Tools
     - Android Emulator
```

----------------------------------------

TITLE: Define initial Flutter architecture classes
DESCRIPTION: This snippet defines the initial Dart classes for a Flutter feature, including a StatefulWidget for the UI, a ChangeNotifier for the view model, and a repository for data operations, following architectural guidelines.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/optimistic-state

LANGUAGE: dart
CODE:
```
class SubscribeButton extends StatefulWidget {
  const SubscribeButton({super.key});

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SubscribeButtonViewModel extends ChangeNotifier {}

class SubscriptionRepository {}
```

----------------------------------------

TITLE: Implement Flutter Form Input with Validation and Submission
DESCRIPTION: This snippet demonstrates how to define a TextFormField for email input with a validator and an onSaved callback. It also shows an ElevatedButton that triggers the form submission logic. The _submit function validates and saves the form data using formKey.currentState.validate() and form.save(), then shows a dialog.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
            return 'Not a valid email.';
          },
          onSaved: (val) {
            _email = val;
          },
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            labelText: 'Email',
          ),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Login')),
      ],
    ),
  );
}
```

LANGUAGE: Dart
CODE:
```
void _submit() {
  final form = formKey.currentState;
  if (form != null && form.validate()) {
    form.save();
    showDialog(
      context: context,
```

----------------------------------------

TITLE: Flutter ShoppingListItem Stateless Widget Definition
DESCRIPTION: Defines the `Product` class, `CartChangedCallback` typedef, and the `ShoppingListItem` stateless widget. This widget displays a product, changes its visual style based on whether it's in the cart, and uses a callback (`onCartChanged`) to notify its parent of user interactions, adhering to the pattern of managing state higher in the widget tree. Includes a `main` function for a standalone demonstration.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ShoppingListItem(
            product: const Product(name: 'Chips'),
            inCart: true,
            onCartChanged: (product, inCart) {},
          ),
        ),
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Flutter Container Sizing with Padding
DESCRIPTION: Illustrates that a parent Container with padding will size itself to its child's size plus the specified padding. The red color becomes visible around the green child due to the added padding.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: dart
CODE:
```
Center(
  child: Container(
    padding: const EdgeInsets.all(20),
    color: red,
    child: Container(color: green, width: 30, height: 30),
  ),
)
```

----------------------------------------

TITLE: Dynamically Toggle Widget Visibility in Flutter
DESCRIPTION: This example illustrates how to dynamically show or hide widgets in Flutter by controlling their creation with a boolean flag. It demonstrates toggling between two different Text widgets based on a state variable when a FloatingActionButton is pressed, showcasing the use of StatefulWidget and setState.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  /// Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    }
    return CupertinoButton(onPressed: () {}, child: const Text('Toggle Two'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: _getToggleChild()),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Flutter: Building Fully Custom Toolbar with contextMenuBuilder
DESCRIPTION: This Dart example demonstrates how to construct a fully custom context menu toolbar using `contextMenuBuilder` for a `TextField`. It includes a custom `_MyContextMenu` widget and shows how to integrate default adaptive buttons within it.
SOURCE: https://docs.flutter.dev/release/breaking-changes/context-menus

LANGUAGE: dart
CODE:
```
class _MyContextMenu extends StatelessWidget {
  const _MyContextMenu({
    required this.anchor,
    required this.children,
  });

  final Offset anchor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: anchor.dy,
          left: anchor.dx,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.amberAccent,
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _MyTextField extends StatelessWidget {
  const _MyTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 4,
      minLines: 2,
      contextMenuBuilder: (context, editableTextState) {
        return _MyContextMenu(
          anchor: editableTextState.contextMenuAnchors.primaryAnchor,
          children: AdaptiveTextSelectionToolbar.getAdaptiveButtons(
            context,
            editableTextState.contextMenuButtonItems,
          ).toList(),
        );
      },
    );
  }
}
```

----------------------------------------

TITLE: Displaying a SnackBar with an Action Button in Flutter
DESCRIPTION: This Flutter code snippet demonstrates how to create a simple application that displays a SnackBar when an ElevatedButton is pressed. The SnackBar includes a text message and an 'Undo' action button. It utilizes `ScaffoldMessenger.of(context).showSnackBar` to present the SnackBar to the user.
SOURCE: https://docs.flutter.dev/cookbook/design/snackbars

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() => runApp(const SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('SnackBar Demo')),
        body: const SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Implement SharedPreferencesService for Dark Mode Storage
DESCRIPTION: The SharedPreferencesService wraps the SharedPreferences plugin functionality, providing methods to store and retrieve the dark mode setting. This service hides the third-party dependency from the rest of the application, ensuring a cleaner architecture.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/key-value-data

LANGUAGE: dart
CODE:
```
class SharedPreferencesService {
  static const String _kDarkMode = 'darkMode';

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDarkMode, value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kDarkMode) ?? false;
  }
}
```

----------------------------------------

TITLE: Call Asynchronous IP Address Fetch (JavaScript-like)
DESCRIPTION: Demonstrates how to instantiate an 'Example' class and call its '_getIPAddress' method, handling the asynchronous result with '.then()' for success and '.catch()' for errors. This snippet illustrates the consumption of a Future/Promise-based API pattern.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: javascript
CODE:
```
  const example = new Example();
  example
    ._getIPAddress()
    .then(ip => console.log(ip))
    .catch(error => console.error(error));
}

main();
```

----------------------------------------

TITLE: Flutter Expandable Floating Action Button (FAB) Implementation
DESCRIPTION: This Dart code implements an interactive expandable Floating Action Button (FAB) in Flutter. The FAB, initially an Edit icon, expands into three satellite buttons ('Create Post', 'Upload Photo', 'Upload Video') upon click, replacing itself with a close button. Clicking the close button retracts the satellite buttons. Tapping any satellite button triggers a dialog displaying its action. The implementation includes custom widgets for the expandable FAB, action buttons, and animation control.
SOURCE: https://docs.flutter.dev/cookbook/effects/expandable-fab

LANGUAGE: Dart
CODE:
```
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleExpandableFab(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class ExampleExpandableFab extends StatelessWidget {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  const ExampleExpandableFab({super.key});

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expandable Fab')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 25,
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (
      var i = 0, angleInDegrees = 0.0;
      i < count;
      i++, angleInDegrees += step
    ) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,

```

----------------------------------------

TITLE: Add Flutter SDK bin to PATH for Various Shells
DESCRIPTION: These commands demonstrate how to permanently add the Flutter SDK's `bin` directory to the system's PATH environment variable. This allows `flutter` and `dart` commands to be executed from any directory. Instructions are provided for common shells, including generic placeholders and specific examples for a typical user directory installation.
SOURCE: https://docs.flutter.dev/install/manual

LANGUAGE: bash
CODE:
```
echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile
```

LANGUAGE: bash
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bash_profile
```

LANGUAGE: zsh
CODE:
```
echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.zshenv
```

LANGUAGE: zsh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.zshenv
```

LANGUAGE: fish
CODE:
```
fish_add_path -g -p <path-to-sdk>/bin
```

LANGUAGE: fish
CODE:
```
fish_add_path -g -p ~/development/flutter/bin
```

LANGUAGE: csh
CODE:
```
echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.cshrc
```

LANGUAGE: csh
CODE:
```
echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.cshrc
```

LANGUAGE: tcsh
CODE:
```
echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.tcshrc
```

LANGUAGE: tcsh
CODE:
```
echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.tcshrc
```

LANGUAGE: ksh
CODE:
```
echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
```

LANGUAGE: ksh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
```

LANGUAGE: sh
CODE:
```
echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
```

LANGUAGE: sh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
```

----------------------------------------

TITLE: Update User Profile with Online-Only Write in Dart
DESCRIPTION: This Dart function demonstrates an online-only writing strategy for user profiles. It first attempts to update the profile via an API call. Only if the API call is successful, the local database is updated. This ensures data consistency with the server but requires an active internet connection for write operations.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/offline-first

LANGUAGE: dart
CODE:
```
Future<void> updateUserProfile(UserProfile userProfile) async {
  try {
    // Update the API with the user profile
    await _apiClientService.putUserProfile(userProfile);

    // Only if the API call was successful
    // update the database with the user profile
    await _databaseService.updateUserProfile(userProfile);
  } catch (e) {
    // Handle the error
  }
}
```

----------------------------------------

TITLE: Flutter: Managing Ephemeral State with StatefulWidget
DESCRIPTION: This Dart code snippet illustrates how to manage ephemeral state within a Flutter `StatefulWidget`. It demonstrates a `BottomNavigationBar` where the `_index` field, representing the currently selected tab, is updated using `setState()` within the `_MyHomepageState` class. This pattern is ideal for UI-specific state that is contained within a single widget and does not require sharing across the application or persistence between sessions.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app

LANGUAGE: dart
CODE:
```
class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: (newIndex) {
        setState(() {
          _index = newIndex;
        });
      },
      // ... items ...
    );
  }
}
```

----------------------------------------

TITLE: Configure Custom Fonts in Flutter pubspec.yaml
DESCRIPTION: This snippet shows how to declare custom font families and their asset paths within the `flutter` section of your `pubspec.yaml` file. It includes examples for Raleway and RobotoMono fonts, specifying regular, italic, and bold styles. This configuration is essential for Flutter to recognize and load your custom fonts.
SOURCE: https://docs.flutter.dev/cookbook/design/fonts

LANGUAGE: shell
CODE:
```
vi pubspec.yaml
```

LANGUAGE: yaml
CODE:
```
name: custom_fonts
description: An example of how to use custom fonts with Flutter

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: fonts/Raleway-Regular.ttf
        - asset: fonts/Raleway-Italic.ttf
          style: italic
    - family: RobotoMono
      fonts:
        - asset: fonts/RobotoMono-Regular.ttf
        - asset: fonts/RobotoMono-Bold.ttf
          weight: 700
  uses-material-design: true
```

----------------------------------------

TITLE: Migrate SnackBar Management from Scaffold to ScaffoldMessenger
DESCRIPTION: This migration guide demonstrates the transition of SnackBar management in Flutter from using `Scaffold` to the new `ScaffoldMessenger` API. It covers how to show, hide, and remove SnackBars using both context-based access and `GlobalKey` access, including the new `MaterialApp.scaffoldMessengerKey` for root-level access.
SOURCE: https://docs.flutter.dev/release/breaking-changes/scaffold-messenger

LANGUAGE: dart
CODE:
```
// The ScaffoldState of the current context was used for managing SnackBars.
Scaffold.of(context).showSnackBar(mySnackBar);
Scaffold.of(context).hideCurrentSnackBar(mySnackBar);
Scaffold.of(context).removeCurrentSnackBar(mySnackBar);

// If a Scaffold.key is specified, the ScaffoldState can be directly
// accessed without first obtaining it from a BuildContext via
// Scaffold.of. From the key, use the GlobalKey.currentState
// getter. This was previously used to manage SnackBars.
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
Scaffold(
  key: scaffoldKey,
  body: ...,
);

scaffoldKey.currentState.showSnackBar(mySnackBar);
scaffoldKey.currentState.hideCurrentSnackBar(mySnackBar);
scaffoldKey.currentState.removeCurrentSnackBar(mySnackBar);
```

LANGUAGE: dart
CODE:
```
// The ScaffoldMessengerState of the current context is used for managing SnackBars.
ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
ScaffoldMessenger.of(context).hideCurrentSnackBar(mySnackBar);
ScaffoldMessenger.of(context).removeCurrentSnackBar(mySnackBar);

// If a ScaffoldMessenger.key is specified, the ScaffoldMessengerState can be directly
// accessed without first obtaining it from a BuildContext via
// ScaffoldMessenger.of. From the key, use the GlobalKey.currentState
// getter. This is used to manage SnackBars.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
ScaffoldMessenger(
  key: scaffoldMessengerKey,
  child: ...
)

scaffoldMessengerKey.currentState.showSnackBar(mySnackBar);
scaffoldMessengerKey.currentState.hideCurrentSnackBar(mySnackBar);
scaffoldMessengerKey.currentState.removeCurrentSnackBar(mySnackBar);

// The root ScaffoldMessenger can also be accessed by providing a key to
// MaterialApp.scaffoldMessengerKey. This way, the ScaffoldMessengerState can be directly accessed
// without first obtaining it from a BuildContext via ScaffoldMessenger.of. From the key, use
// the GlobalKey.currentState getter.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
MaterialApp(
  scaffoldMessengerKey: rootScaffoldMessengerKey,
  home: ...
)

rootScaffoldMessengerKey.currentState.showSnackBar(mySnackBar);
rootScaffoldMessengerKey.currentState.hideCurrentSnackBar(mySnackBar);
rootScaffoldMessengerKey.currentState.removeCurrentSnackBar(mySnackBar);
```

----------------------------------------

TITLE: Unit Testing Asynchronous Data Fetching in Flutter
DESCRIPTION: This Dart test file demonstrates how to write unit tests for the `fetchAlbum` function using `flutter_test` and `mockito`. It includes tests for successful API responses and error handling, using a `MockClient` to simulate network behavior.
SOURCE: https://docs.flutter.dev/cookbook/testing/unit/mocking

LANGUAGE: Dart
CODE:
```
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
```

----------------------------------------

TITLE: Flutter UI Implementation for Orientation-Adaptive GridView
DESCRIPTION: This Dart code snippet defines the main application (`MyApp`) and an `OrientationList` widget that demonstrates how to create a `GridView` that dynamically adjusts its number of columns based on the device's orientation. It uses an `OrientationBuilder` to set `crossAxisCount` to 2 for portrait and 3 for landscape, displaying 100 items.
SOURCE: https://docs.flutter.dev/cookbook/testing/widget/orientation

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Orientation Demo';

    return const MaterialApp(
      title: appTitle,
      home: OrientationList(title: appTitle),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  const OrientationList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or
            // 3 columns in landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 widgets that display their index in the list.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: TextTheme.of(context).displayLarge,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
```

----------------------------------------

TITLE: Detect Taps on Any Flutter Widget using GestureDetector
DESCRIPTION: When a Flutter widget does not natively support event detection, it can be wrapped in a GestureDetector widget. This allows for attaching various touch listeners, including `onTap`, to any child widget.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/android-devs

LANGUAGE: dart
CODE:
```
class SampleTapApp extends StatelessWidget {
  const SampleTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            developer.log('tap');
          },
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Bad Example: Imperative UI Update in Flutter
DESCRIPTION: Illustrates an incorrect approach to updating UI by attempting to call methods on widgets directly, which goes against Flutter's declarative nature and leads to complex, bug-prone code.
SOURCE: https://docs.flutter.dev/data-and-backend/state-mgmt/simple

LANGUAGE: dart
CODE:
```
// BAD: DO NOT DO THIS
void myTapHandler() {
  var cartWidget = somehowGetMyCartWidget();
  cartWidget.updateWith(item);
}
```

----------------------------------------

TITLE: Implement InheritedWidget for Global State in Flutter
DESCRIPTION: This snippet defines a MyState class that extends InheritedWidget, providing a mechanism to host and propagate data down the widget tree. It includes the of() static method for child widgets to access the shared data and updateShouldNotify() to control widget rebuilds upon data changes.
SOURCE: https://docs.flutter.dev/get-started/fundamentals/state-management

LANGUAGE: dart
CODE:
```
class MyState extends InheritedWidget {
  const MyState({
    super.key,
    required this.data,
    required super.child,
  });

  final String data;

  static MyState of(BuildContext context) {
    // This method looks for the nearest `MyState` widget ancestor.
    final result = context.dependOnInheritedWidgetOfExactType<MyState>();

    assert(result != null, 'No MyState found in context');

    return result!;
  }

  @override
  // This method should return true if the old widget's data is different
  // from this widget's data. If true, any widgets that depend on this widget
  // by calling `of()` will be re-built.
  bool updateShouldNotify(MyState oldWidget) => data != oldWidget.data;
}
```

----------------------------------------

TITLE: Flutter go_router setup in main.dart
DESCRIPTION: Configure the `GoRouter` object in your `main.dart` file to handle application routing. This example sets up a basic home screen and a details screen, demonstrating how `go_router` manages navigation based on paths for deep linking.
SOURCE: https://docs.flutter.dev/cookbook/navigation/set-up-universal-links

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MaterialApp.router(routerConfig: router));

/// This handles '/' and '/details'.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
      ),
      routes: [
        GoRoute(
          path: 'details',
          builder: (_, __) => Scaffold(
            appBar: AppBar(title: const Text('Details Screen')),
          ),
        ),
      ],
    ),
  ],
);
```

----------------------------------------

TITLE: Parsing Large JSON with Isolate.run in Flutter
DESCRIPTION: This code snippet demonstrates how to use `Isolate.run` to perform a CPU-intensive task, such as decoding a large JSON string into custom Dart objects, on a separate isolate. This prevents the main UI thread from blocking and ensures a responsive user interface.
SOURCE: https://docs.flutter.dev/perf/isolates

LANGUAGE: Dart
CODE:
```
// Produces a list of 211,640 photo objects.
// (The JSON file is ~20MB.)
Future<List<Photo>> getPhotos() async {
  final String jsonString = await rootBundle.loadString('assets/photos.json');
  final List<Photo> photos = await Isolate.run<List<Photo>>(() {
    final List<Object?> photoData = jsonDecode(jsonString) as List<Object?>;
    return photoData.cast<Map<String, Object?>>().map(Photo.fromJson).toList();
  });
  return photos;
}
```

----------------------------------------

TITLE: Add web support to an existing Flutter project
DESCRIPTION: To enable web support for an existing Flutter project, navigate to the project's root directory and execute `flutter create . --platforms web`. This command generates the necessary web assets and configuration files within a new `web/` directory.
SOURCE: https://docs.flutter.dev/platform-integration/web/building

LANGUAGE: Shell
CODE:
```
flutter create . --platforms web
```

----------------------------------------

TITLE: Flutter Image Asset Folder Structure
DESCRIPTION: Illustrates the recommended folder structure for organizing image assets with different density variants (1.0x, 2.0x, 3.0x) within a Flutter project. The base image is placed in the main folder, and higher-density variants are placed in sub-folders named by their ratio multiplier.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: Filesystem
CODE:
```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

----------------------------------------

TITLE: Complete Flutter App with Named Route Navigation Example
DESCRIPTION: A full Flutter application demonstrating named route navigation. It sets up two screens (FirstScreen and SecondScreen) and defines named routes for them. This example includes the main application setup, route definitions, and the navigation logic for both pushing to a new screen and popping back.
SOURCE: https://docs.flutter.dev/cookbook/navigation/named-routes

LANGUAGE: dart
CODE:
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const SecondScreen(),
      },
    ),
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

----------------------------------------

TITLE: Center Components Horizontally and Vertically in Flutter and CSS
DESCRIPTION: Compares Flutter's Center widget, which automatically centers its child, with CSS techniques using display: flex, align-items: center, and justify-content: center on the parent element to achieve similar centering effects.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/web-devs

LANGUAGE: css
CODE:
```
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
```

LANGUAGE: dart
CODE:
```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Text(
      'Lorem ipsum',
      style: bold24Roboto,
    ),
  ),
);
```

----------------------------------------

TITLE: UnconstrainedBox: Child Sizing Freely
DESCRIPTION: The screen forces the UnconstrainedBox to be exactly the same size as the screen.However, the UnconstrainedBox lets its child Container be any size it wants.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: Dart
CODE:
```
UnconstrainedBox(
   child: Container(color: red, width: 20, height: 50));
```

----------------------------------------

TITLE: Configuring MaterialApp for internationalization
DESCRIPTION: Configure your `MaterialApp` or `CupertinoApp` by specifying `localizationsDelegates` to provide localized values for Material, Widgets, and Cupertino libraries, and `supportedLocales` to declare the languages your app supports.
SOURCE: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

LANGUAGE: dart
CODE:
```
return const MaterialApp(
  title: 'Localizations Sample App',
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('en'), // English
    Locale('es'), // Spanish
  ],
  home: MyHomePage(),
);
```

----------------------------------------

TITLE: Flutter State Class API Reference
DESCRIPTION: The `State` class holds the mutable state for a `StatefulWidget`. Subclasses are typically private (named with leading underscores). It provides access to the associated widget via the `widget` property and allows for notification of widget changes through `didUpdateWidget()`.
SOURCE: https://docs.flutter.dev/ui

LANGUAGE: APIDOC
CODE:
```
State:
  widget: StatefulWidget
    Description: The current configuration of the widget that this `State` is associated with.
  didUpdateWidget(oldWidget: StatefulWidget): void
    Description: Called when the widget associated with this `State` changes. `oldWidget` is the previous widget instance.
```

----------------------------------------

TITLE: Force Specific Dart Package Version with dependency_overrides in pubspec.yaml
DESCRIPTION: This YAML configuration shows how to resolve incompatible Dart package versions by forcing a specific version using the `dependency_overrides` section in `pubspec.yaml`. This is useful when multiple packages depend on different, conflicting versions of the same library, allowing the developer to manually specify a compatible version for the entire project.
SOURCE: https://docs.flutter.dev/packages-and-plugins/using-packages

LANGUAGE: yaml
CODE:
```
dependencies:
  some_package:
  another_package:
dependency_overrides:
  url_launcher: '5.4.0'
```

----------------------------------------

TITLE: Flutter Card Widget Example: Displaying Contact Information
DESCRIPTION: This Dart code illustrates the use of a `Card` widget to present structured contact information. It contains multiple `ListTile` widgets for phone, email, and address, separated by a `Divider`, and is constrained in size using a `SizedBox`.
SOURCE: https://docs.flutter.dev/ui/layout

LANGUAGE: dart
CODE:
```
Widget _buildCard() {
  return SizedBox(
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '1625 Main Street',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('My City, CA 99984'),
            leading: Icon(Icons.restaurant_menu, color: Colors.blue[500]),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              '(408) 555-1212',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(Icons.contact_phone, color: Colors.blue[500]),
          ),
          ListTile(
            title: const Text('costa@example.com'),
            leading: Icon(Icons.contact_mail, color: Colors.blue[500]),
          ),
        ],
      ),
    ),
  );
}
```

----------------------------------------

TITLE: Flutter Widget Build Method with Scaffold
DESCRIPTION: This Dart code defines the `build` method for a Flutter widget. It constructs a basic UI using a `Scaffold`, which provides a visual structure, an `AppBar` for the title, and a `Center` widget displaying a message. This method is fundamental for rendering UI in Flutter.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments

LANGUAGE: Dart
CODE:
```
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(message)),
    );
  }
```

----------------------------------------

TITLE: Apply Global Theme with MaterialApp in Flutter
DESCRIPTION: This snippet demonstrates how to define and apply a global theme to a Flutter application using the `ThemeData` class and passing it to the `theme` property of the `MaterialApp` widget. It sets the primary color to cyan and brightness to dark, affecting the entire app.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(primaryColor: Colors.cyan, brightness: Brightness.dark),
    home: const StylingPage(),
  );
}
```

----------------------------------------

TITLE: Create New Flutter Application Project
DESCRIPTION: Command-line instructions to initialize a new Flutter project, demonstrating how to specify preferred languages for Android (Java/Kotlin) and iOS (Objective-C/Swift) platform code.
SOURCE: https://docs.flutter.dev/platform-integration/platform-channels

LANGUAGE: Shell
CODE:
```
flutter create batterylevel
```

LANGUAGE: Shell
CODE:
```
flutter create -i objc -a java batterylevel
```

----------------------------------------

TITLE: Create a Stateful Widget Class
DESCRIPTION: This code defines the `MyHomePage` class as a `StatefulWidget`. This part of a stateful widget is immutable and is responsible for creating its associated `State` object. It includes a constructor and overrides `createState()` to link to the mutable state.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
```

----------------------------------------

TITLE: Flutter: Push Named Route and Await Result
DESCRIPTION: This code illustrates pushing a named route onto the `Navigator` stack and awaiting a result from it. The `await` keyword ensures that the calling route pauses until the pushed route is popped with a return value.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs

LANGUAGE: dart
CODE:
```
Object? coordinates = await Navigator.of(context).pushNamed('/location');
```

----------------------------------------

TITLE: Populate a Flutter Drawer with ListView Items
DESCRIPTION: To add content to the `Drawer`, use a `ListView` widget. `ListView` is preferred over `Column` as it allows scrolling if the content exceeds screen space. This example populates the `ListView` with a `DrawerHeader` and two `ListTile` widgets, demonstrating basic drawer content.
SOURCE: https://docs.flutter.dev/cookbook/design/drawer

LANGUAGE: Dart
CODE:
```
Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Item 1'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: const Text('Item 2'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      )
    ]
  )
);
```

----------------------------------------

TITLE: Process JSON Response and Handle Future in Dart
DESCRIPTION: This Dart snippet illustrates the final steps of processing an HTTP response within a Future.then() callback, extracting data using jsonDecode, and demonstrating how to call an asynchronous method and handle its success or error using then() and catchError() in the main function.
SOURCE: https://docs.flutter.dev/get-started/flutter-for/react-native-devs

LANGUAGE: Dart
CODE:
```
      final ip = jsonDecode(response.body)['origin'] as String;
      return ip;
    });
  }
}

void main() {
  final example = Example();
  example
      ._getIPAddress()
      .then((ip) => print(ip))
      .catchError((error) => print(error));
}
```

----------------------------------------

TITLE: Layout Multiple Widgets with Row
DESCRIPTION: This example shows a Row widget placing multiple Container children side-by-side. The Row does not impose constraints on its children, allowing them to define their own sizes. Any remaining space within the Row remains empty.
SOURCE: https://docs.flutter.dev/ui/layout/constraints

LANGUAGE: dart
CODE:
```
Row(
  children: [
    Container(
      color: red,
      child: const Text('Hello!', style: big),
    ),
    Container(
      color: green,
      child: const Text('Goodbye!', style: big),
    ),
  ],
)
```

----------------------------------------

TITLE: Open SQFlite Database in Flutter
DESCRIPTION: This snippet demonstrates how to initialize Flutter widgets binding and open a connection to a SQLite database using `sqflite` and `path` packages. It sets the database path using `getDatabasesPath()` and `join()` functions.
SOURCE: https://docs.flutter.dev/cookbook/persistence/sqlite

LANGUAGE: dart
CODE:
```
// Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
final database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
);
```

----------------------------------------

TITLE: Handle Flutter Platform Method Call for Battery Level (Java)
DESCRIPTION: Updates the `setMethodCallHandler()` method in `MainActivity.java` to process incoming method calls from Flutter. It specifically handles the `getBatteryLevel` method, invoking the native Android code and returning the battery level or an error if unavailable.
SOURCE: https://docs.flutter.dev/platform-integration/platform-channels

LANGUAGE: java
CODE:
```
      new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            // This method is invoked on the main thread.
            if (call.method.equals("getBatteryLevel")) {
              int batteryLevel = getBatteryLevel();

              if (batteryLevel != -1) {
                result.success(batteryLevel);
              } else {
                result.error("UNAVAILABLE", "Battery level not available.", null);
              }
            } else {
              result.notImplemented();
            }
          }
      );
```

----------------------------------------

TITLE: Flutter API Changes: Non-nullable 'of' Methods
DESCRIPTION: Existing Flutter 'of' methods have been modified to return non-nullable values, ensuring that a valid instance is always returned when these methods are called. Developers should ensure the context provides the required instance or handle potential errors if the instance is not found.
SOURCE: https://docs.flutter.dev/release/breaking-changes/eliminating-nullok-parameters

LANGUAGE: APIDOC
CODE:
```
Modified APIs (now non-nullable):
- MediaQuery.of
- Navigator.of
- ScaffoldMessenger.of
- Scaffold.of
- Router.of
- Localizations.localeOf
- FocusTraversalOrder.of
- FocusTraversalGroup.of
- Focus.of
- Shortcuts.of
- Actions.handler
- Actions.find
- Actions.invoke
- AnimatedList.of
- SliverAnimatedList.of
- CupertinoDynamicColor.resolve
- CupertinoDynamicColor.resolveFrom
- CupertinoUserInterfaceLevel.of
- CupertinoTheme.brightnessOf
- CupertinoThemeData.resolveFrom
- NoDefaultCupertinoThemeData.resolveFrom
- CupertinoTextThemeData.resolveFrom
- MaterialBasedCupertinoThemeData.resolveFrom
```

----------------------------------------

TITLE: Add Flutter to PATH Environment Variable
DESCRIPTION: These commands append or set the Flutter bin directory to the PATH environment variable for various shells, making Flutter commands accessible globally. The changes typically require restarting terminal sessions to take effect.
SOURCE: https://docs.flutter.dev/get-started/install/linux/android

LANGUAGE: bash
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bash_profile
```

LANGUAGE: zsh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.zshenv
```

LANGUAGE: fish
CODE:
```
fish_add_path -g -p ~/development/flutter/bin
```

LANGUAGE: csh
CODE:
```
echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.cshrc
```

LANGUAGE: tcsh
CODE:
```
echo 'setenv PATH "$HOME/development/flutter/bin:$PATH"' >> ~/.tcshrc
```

LANGUAGE: ksh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
```

LANGUAGE: sh
CODE:
```
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.profile
```

----------------------------------------

TITLE: Flutter Navigator Class Additional Navigation Methods
DESCRIPTION: Documentation for various static methods available in Flutter's Navigator class for managing the navigation stack, including adding, replacing, removing, and restoring routes.
SOURCE: https://docs.flutter.dev/cookbook/navigation/navigation-basics

LANGUAGE: APIDOC
CODE:
```
Navigator Class Methods:
  pushAndRemoveUntil: Adds a navigation route to the stack and then removes the most recent routes from the stack until a condition is met.
  pushReplacement: Replaces the current route on the top of the stack with a new one.
  replace: Replace a route on the stack with another route.
  replaceRouteBelow: Replace the route below a specific route on the stack.
  popUntil: Removes the most recent routes that were added to the stack of navigation routes until a condition is met.
  removeRoute: Remove a specific route from the stack.
  removeRouteBelow: Remove the route below a specific route on the stack.
  restorablePush: Restore a route that was removed from the stack.
```

----------------------------------------

TITLE: Dart: Deleting a Booking via Repository
DESCRIPTION: This snippet shows the delete method within the BookingRepository, which delegates the actual deletion of a booking to the _apiClient. It wraps the API call in a try-catch block and returns a Result object to indicate success or error.
SOURCE: https://docs.flutter.dev/app-architecture/case-study/data-layer

LANGUAGE: dart
CODE:
```
Future<Result<void>> delete(int id) async {
  try {
    return _apiClient.deleteBooking(id);
  } on Exception catch (e) {
    return Result.error(e);
  }
}
```

----------------------------------------

TITLE: Add css_colors Package Dependency to Flutter pubspec.yaml
DESCRIPTION: Shows how to add the `css_colors` package as a dependency in a Flutter project's `pubspec.yaml` file. This snippet also includes the standard Flutter SDK dependency.
SOURCE: https://docs.flutter.dev/packages-and-plugins/using-packages

LANGUAGE: yaml
CODE:
```
dependencies:
  flutter:
    sdk: flutter
  css_colors: ^1.0.0
```

----------------------------------------

TITLE: Defining Customer Model for Cart Management in Flutter
DESCRIPTION: This snippet provides the `Customer` class definition, which is essential for managing customer data, including their name, image, and a list of items in their shopping cart. It also includes a getter for the formatted total price of items in the cart.
SOURCE: https://docs.flutter.dev/cookbook/effects/drag-a-widget

LANGUAGE: dart
CODE:
```
class Customer {
  Customer({required this.name, required this.imageProvider, List<Item>? items})
    : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents = items.fold<int>(
      0,
      (prev, item) => prev + item.totalPriceCents,
    );
    return '\${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
```

----------------------------------------

TITLE: Flutter: Registering and Unregistering ViewModel Listeners
DESCRIPTION: This snippet demonstrates how to properly register a listener for a ViewModel in `initState()` and unregister it in `dispose()`. This pattern ensures that the widget reacts to ViewModel changes while preventing memory leaks by cleaning up resources when the widget is removed from the tree.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/optimistic-state

LANGUAGE: dart
CODE:
```
@override
void initState() {
  super.initState();
  widget.viewModel.addListener(_onViewModelChange);
}

@override
void dispose() {
  widget.viewModel.removeListener(_onViewModelChange);
  super.dispose();
}
```

----------------------------------------

TITLE: Pass ThemeRepository to ThemeSwitchViewModel
DESCRIPTION: Illustrates passing the `ThemeRepository` as a dependency to the `ThemeSwitchViewModel` when instantiating the `ThemeSwitch` widget, ensuring the view model has access to theme-related data.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/key-value-data

LANGUAGE: dart
CODE:
```
ThemeSwitch(
  viewmodel: ThemeSwitchViewModel(widget.themeRepository),
),
```

----------------------------------------

TITLE: Configure analysis_options.yaml for New Projects (YAML)
DESCRIPTION: Content for a new `analysis_options.yaml` file to include the recommended lints from `package:flutter_lints`. This file should be placed in the root directory of the project, next to `pubspec.yaml`.
SOURCE: https://docs.flutter.dev/release/breaking-changes/flutter-lints-package

LANGUAGE: YAML
CODE:
```
include: package:flutter_lints/flutter.yaml
```

----------------------------------------

TITLE: Generate Upload Keystore for Android App Signing
DESCRIPTION: Commands to create a Java KeyStore (JKS) file containing a new key pair for signing Android applications. The keystore is stored in the user's home directory by default. It uses RSA algorithm, 2048-bit key size, and is valid for 10000 days.
SOURCE: https://docs.flutter.dev/deployment/android

LANGUAGE: shell
CODE:
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload
```

LANGUAGE: powershell
CODE:
```
keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
        -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
        -alias upload
```

----------------------------------------

TITLE: Dart: ToDo Data Model Definition with Freezed
DESCRIPTION: This snippet defines the immutable `Todo` data class using the `freezed` package. It includes properties for a unique integer `id` and a string `task` description, representing the core data structure for ToDo items.
SOURCE: https://docs.flutter.dev/app-architecture/design-patterns/sql

LANGUAGE: dart
CODE:
```
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    /// The unique identifier of the Todo item.
    required int id,

    /// The task description of the Todo item.
    required String task,
  }) = _Todo;
}
```