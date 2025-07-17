TITLE: Objective-C FlutterBasicMessageChannel API Definition
DESCRIPTION: Defines the `FlutterBasicMessageChannel` class, a core component for asynchronous message passing between Flutter and the native iOS side. It provides constructors to create channels identified by a name, using a binary messenger and an optional message codec. This class is crucial for implementing platform channels in Flutter applications.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8h_source

LANGUAGE: Objective-C
CODE:
```
FlutterBasicMessageChannel:
  Description: A channel for communicating with the Flutter side using basic, asynchronous message passing.
  Inherits: NSObject

  Class Methods:
    messageChannelWithName:binaryMessenger:
      Signature: + (instancetype)messageChannelWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
      Description: Creates a `FlutterBasicMessageChannel` with the specified name and binary messenger. The channel uses `FlutterStandardMessageCodec` to encode and decode messages.
      Parameters:
        name: The channel name (NSString*). Logically identifies the channel; identically named channels interfere with each other's communication.
        messenger: The binary messenger (NSObject<FlutterBinaryMessenger>*). A facility for sending raw, binary messages to the Flutter side, implemented by `FlutterEngine` and `FlutterViewController`.
      Returns: instancetype

    messageChannelWithName:binaryMessenger:codec:
      Signature: + (instancetype)messageChannelWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger codec:(NSObject<FlutterMessageCodec>*)codec;
      Description: Creates a `FlutterBasicMessageChannel` with the specified name, binary messenger, and message codec.
      Parameters:
        name: The channel name (NSString*).
        messenger: The binary messenger (NSObject<FlutterBinaryMessenger>*).
        codec: The message codec (NSObject<FlutterMessageCodec>*).
      Returns: instancetype

  Instance Methods:
    initWithName:binaryMessenger:codec:
      Signature: - (instancetype)initWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger codec:(NSObject<FlutterMessageCodec>*)codec;
      Description: Initializes a `FlutterBasicMessageChannel` with the specified name, binary messenger, and message codec.
      Parameters:
        name: The channel name (NSString*).
        messenger: The binary messenger (NSObject<FlutterBinaryMessenger>*).
        codec: The message codec (NSObject<FlutterMessageCodec>*).
      Returns: instancetype
```

----------------------------------------

TITLE: Flutter MethodChannel API Definition
DESCRIPTION: Definition of the `MethodChannel` class, used for invoking platform methods and receiving method calls from the Flutter engine.
SOURCE: https://api.flutter.dev/windows-embedder/text__input__plugin_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::MethodChannel
  Definition: method_channel.h:34
```

----------------------------------------

TITLE: MethodChannel.setMethodCallHandler API Definition
DESCRIPTION: Defines the signature and behavior of the `setMethodCallHandler` method within Flutter's `MethodChannel` class, including its parameters and how return values are processed.
SOURCE: https://api.flutter.dev/flutter/services/MethodChannel/setMethodCallHandler

LANGUAGE: APIDOC
CODE:
```
MethodChannel.setMethodCallHandler:
  signature: void setMethodCallHandler(Future handler(MethodCall call)?)
  parameters:
    handler:
      type: Future<dynamic> Function(MethodCall call)?
      description: A callback for receiving method calls on this channel. If null, the handler is removed.
```

----------------------------------------

TITLE: Navigator.pushNamedAndRemoveUntil API Reference (Flutter)
DESCRIPTION: Pushes a named route onto the navigator and then removes all previous routes until the `predicate` returns true. This combines named navigation with stack clearing functionality.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
pushNamedAndRemoveUntil<T extends Object?>(BuildContext context, String newRouteName, RoutePredicate predicate, {Object? arguments}) -> Future<T?>
  Description: Push the route with the given name onto the navigator that most tightly encloses the given context, and then remove all the previous routes until the `predicate` returns true.
```

----------------------------------------

TITLE: FlutterActivity Class API Documentation
DESCRIPTION: Detailed API documentation for the `io.flutter.embedding.android.FlutterActivity` class. This class extends `android.app.Activity` and implements `androidx.lifecycle.LifecycleOwner`, providing the simplest way to integrate Flutter within an Android app. It outlines the class hierarchy, implemented interfaces, core responsibilities, and methods for configuring Dart entrypoints, arguments, and initial routes.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
Class: FlutterActivity
  Package: io.flutter.embedding.android
  Extends:
    - java.lang.Object
    - android.content.Context
    - android.content.ContextWrapper
    - android.view.ContextThemeWrapper
    - android.app.Activity
  Implements:
    - android.content.ComponentCallbacks
    - android.content.ComponentCallbacks2
    - android.view.KeyEvent.Callback
    - android.view.LayoutInflater.Factory
    - android.view.LayoutInflater.Factory2
    - android.view.View.OnCreateContextMenuListener
    - android.view.Window.Callback
    - androidx.lifecycle.LifecycleOwner
    - io.flutter.embedding.android.FlutterEngineConfigurator
    - io.flutter.embedding.android.FlutterEngineProvider
    - io.flutter.plugin.platform.PlatformPlugin.PlatformPluginDelegate

  Description: Activity which displays a fullscreen Flutter UI. Simplest and most direct way to integrate Flutter within an Android app.

  Responsibilities:
    - Displays an Android launch screen.
    - Configures the status bar appearance.
    - Chooses the Dart execution app bundle path, entrypoint and entrypoint arguments.
    - Chooses Flutter's initial route.
    - Renders Activity transparently, if desired.
    - Offers hooks for subclasses to provide and configure a FlutterEngine.
    - Save and restore instance state (see #shouldRestoreAndSaveState()).

  Dart Entrypoint, Arguments, and Initial Route Configuration:
    - Default Dart entrypoint: "main()"
    - To change entrypoint: Subclass FlutterActivity and override getDartEntrypointFunctionName().
    - Non-main entrypoints require @pragma('vm:entry-point') annotation in Dart.
    - Dart entrypoint arguments: Passed as a list of strings to Dart's entrypoint function.
      - Configured via FlutterActivity.NewEngineIntentBuilder.dartEntrypointArgs.
    - Default initial route: "/"
    - To change initial route: Pass as String in FlutterActivityLaunchConfigs.EXTRA_INITIAL_ROUTE or via FlutterActivity.NewEngineIntentBuilder.initialRoute.
    - App bundle path, Dart entrypoint, Dart entrypoint arguments, and initial route can be controlled by overriding respective methods in a subclass:
      - getAppBundlePath()
      - getDartEntrypointFunctionName()
      - getDartEntrypointArgs()
      - getInitialRoute()
    - Note: Dart entrypoint and app bundle path are not supported as Intent parameters for security reasons.
```

----------------------------------------

TITLE: Flutter Example: Nested Navigator for User Registration Flow
DESCRIPTION: This Flutter code demonstrates how to implement a nested Navigator to manage a multi-step user registration (signup) journey. It showcases a root MaterialApp Navigator for main app routes and a separate Navigator within the SignUpPage to handle its internal flow (CollectPersonalInfoPage -> ChooseCredentialsPage). The example illustrates navigation within the nested stack and how to complete the flow, returning control to the top-level Navigator.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';

/// Flutter code sample for [Navigator].

void main() => runApp(const NavigatorExampleApp());

class NavigatorExampleApp extends StatelessWidget {
  const NavigatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomePage(),
        '/signup': (BuildContext context) => const SignUpPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineMedium!,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text('Home Page'),
      ),
    );
  }
}

class CollectPersonalInfoPage extends StatelessWidget {
  const CollectPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineMedium!,
      child: GestureDetector(
        onTap: () {
          // This moves from the personal info page to the credentials page,
          // replacing this page with that one.
          Navigator.of(context).pushReplacementNamed('signup/choose_credentials');
        },
        child: Container(
          color: Colors.lightBlue,
          alignment: Alignment.center,
          child: const Text('Collect Personal Info Page'),
        ),
      ),
    );
  }
}

class ChooseCredentialsPage extends StatelessWidget {
  const ChooseCredentialsPage({super.key, required this.onSignupComplete});

  final VoidCallback onSignupComplete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSignupComplete,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headlineMedium!,
        child: Container(
          color: Colors.pinkAccent,
          alignment: Alignment.center,
          child: const Text('Choose Credentials Page'),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SignUpPage builds its own Navigator which ends up being a nested
    // Navigator in our app.
    return Navigator(
      initialRoute: 'signup/personal_info',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'signup/personal_info':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            builder = (BuildContext context) => const CollectPersonalInfoPage();
          case 'signup/choose_credentials':
            // Assume ChooseCredentialsPage collects new credentials and then
            // invokes 'onSignupComplete()'.
            builder =
                (BuildContext _) => ChooseCredentialsPage(
                  onSignupComplete: () {
                    // Referencing Navigator.of(context) from here refers to the
                    // top level Navigator because SignUpPage is above the

```

----------------------------------------

TITLE: FlutterEngine::Run (with entry_point)
DESCRIPTION: Documents the `Run` method of the `flutter::FlutterEngine` class, which takes a `const char* entry_point` as a parameter. This method initializes and starts the Flutter engine, including error handling for failed creation or attempts to run the engine more than once. It delegates the actual engine execution to `FlutterDesktopEngineRun`.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_engine

LANGUAGE: C++
CODE:
```
bool flutter::FlutterEngine::Run(const char *entry_point)
Definition at line 53 of file flutter_engine.cc.

53  {
54  if (!engine_) {
55  std::cerr << "Cannot run an engine that failed creation." << std::endl;
56  return false;
57  }
58  if (run_succeeded_) {
59  std::cerr << "Cannot run an engine more than once." << std::endl;
60  return false;
61  }
62  bool run_succeeded = FlutterDesktopEngineRun(engine_, entry_point);
63  if (!run_succeeded) {
64  std::cerr << "Failed to start engine." << std::endl;
65  }
66  run_succeeded_ = true;
67  return run_succeeded;
68  }

FlutterDesktopEngineRun
bool FlutterDesktopEngineRun(FlutterDesktopEngineRef engine, const char *entry_point)
Definition: flutter_windows.cc:206
```

----------------------------------------

TITLE: Define flutter::BinaryMessenger Class
DESCRIPTION: Defines the `BinaryMessenger` class, which is a core component for sending and receiving binary messages between Flutter and the host platform.
SOURCE: https://api.flutter.dev/windows-embedder/cursor__handler_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::BinaryMessenger
```

----------------------------------------

TITLE: FlutterStandardMessageCodec Class API
DESCRIPTION: API documentation for the FlutterStandardMessageCodec class, a standard message codec used for encoding and decoding messages over Flutter channels.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterStandardMessageCodec
```

----------------------------------------

TITLE: FlutterMethodChannel
DESCRIPTION: API definition for FlutterMethodChannel.
SOURCE: https://api.flutter.dev/macos-embedder/annotated

LANGUAGE: Objective-C
CODE:
```
interface FlutterMethodChannel
```

----------------------------------------

TITLE: FlutterPlugin Protocol API Reference
DESCRIPTION: Defines the interface for Flutter iOS plugins, including methods for handling method calls, detaching from the engine, and managing plugin registration. It also inherits a comprehensive set of application lifecycle delegate methods.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_plugin-p

LANGUAGE: APIDOC
CODE:
```
Protocol: <FlutterPlugin>
Inherits from: <FlutterApplicationLifeCycleDelegate>

Instance Methods:
  - (void) handleMethodCall: (id)call result: (FlutterResult)result
  - (void) detachFromEngineForRegistrar: (id<FlutterPluginRegistrar>)registrar

Instance Methods inherited from <FlutterApplicationLifeCycleDelegate>:
  - (BOOL) application: (UIApplication*)application didFinishLaunchingWithOptions: (NSDictionary*)launchOptions
  - (BOOL) application: (UIApplication*)application willFinishLaunchingWithOptions: (NSDictionary*)launchOptions
  - (void) applicationDidBecomeActive: (UIApplication*)application
  - (void) applicationWillResignActive: (UIApplication*)application
  - (void) applicationDidEnterBackground: (UIApplication*)application
  - (void) applicationWillEnterForeground: (UIApplication*)application
  - (void) applicationWillTerminate: (UIApplication*)application
  - (void) application: (UIApplication*)application didRegisterUserNotificationSettings: (UIUserNotificationSettings*)notificationSettings
  - (void) application: (UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken: (NSData*)deviceToken
  - (void) application: (UIApplication*)application didFailToRegisterForRemoteNotificationsWithError: (NSError*)error
  - (BOOL) application: (UIApplication*)application didReceiveRemoteNotification: (NSDictionary*)userInfo fetchCompletionHandler: (void (^)(UIBackgroundFetchResult))completionHandler
  - (void) application: (UIApplication*)application didReceiveLocalNotification: (UILocalNotification*)notification
  - (BOOL) application: (UIApplication*)application openURL: (NSURL*)url options: (NSDictionary*)options
  - (BOOL) application: (UIApplication*)application handleOpenURL: (NSURL*)url
  - (BOOL) application: (UIApplication*)application openURL: (NSURL*)url sourceApplication: (NSString*)sourceApplication annotation: (id)annotation
  - (BOOL) application: (UIApplication*)application performActionForShortcutItem: (UIApplicationShortcutItem*)shortcutItem completionHandler: (void (^)(BOOL))completionHandler
  - (BOOL) application: (UIApplication*)application handleEventsForBackgroundURLSession: (NSString*)identifier completionHandler: (void (^)(void))completionHandler
  - (BOOL) application: (UIApplication*)application performFetchWithCompletionHandler: (void (^)(UIBackgroundFetchResult))completionHandler
  - (BOOL) application: (UIApplication*)application continueUserActivity: (NSUserActivity*)userActivity restorationHandler: (void (^)(NSArray*))restorationHandler

Class Methods:
  + (void) registerWithRegistrar: (id<FlutterPluginRegistrar>)registrar
  + (void) setPluginRegistrantCallback: (FlutterPluginRegistrantCallback)callback
```

----------------------------------------

TITLE: FlutterPluginRegistrar Protocol API Reference (Objective-C)
DESCRIPTION: Defines the interface for registering Flutter plugins and managing interactions with the Flutter engine, including method call handling, asset lookup, view factory registration, and texture management.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_plugin_registrar-p-members

LANGUAGE: APIDOC
CODE:
```
protocol FlutterPluginRegistrar:
  Description: A protocol for registering Flutter plugins and interacting with the Flutter engine on iOS.
  Members:
    - addApplicationDelegate:(id<FlutterApplicationLifeCycleDelegate>)delegate
      Description: Adds an application delegate to receive application lifecycle events.
    - addMethodCallDelegate:(id<FlutterMethodCallDelegate>)delegate channel:(FlutterMethodChannel*)channel
      Description: Registers a method call delegate for a specific method channel.
    - lookupKeyForAsset:(NSString*)asset -> NSString*
      Description: Looks up the key for a given asset.
    - lookupKeyForAsset:(NSString*)asset fromPackage:(NSString*)package -> NSString*
      Description: Looks up the key for a given asset from a specific package.
    - messenger: id<FlutterBinaryMessenger> (property)
      Description: The binary messenger used for communication with the Flutter engine.
    - publish:(NSObject*)value
      Description: Publishes a value to the Flutter engine.
    - registerViewFactory:(id<FlutterPlatformViewFactory>)factory withId:(NSString*)factoryId
      Description: Registers a platform view factory with a given ID.
    - registerViewFactory:(id<FlutterPlatformViewFactory>)factory withId:(NSString*)factoryId gestureRecognizersBlockingPolicy:(FlutterPlatformViewGestureRecognizersBlockingPolicy)policy
      Description: Registers a platform view factory with a given ID and gesture recognizer blocking policy.
    - textures: id<FlutterTextureRegistry> (property)
      Description: The texture registry for managing textures.
```

----------------------------------------

TITLE: Navigator.restorablePushNamed
DESCRIPTION: Push a named route onto the navigator that most tightly encloses the given context.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorablePushNamed<T extends Object?>(BuildContext context, String routeName, {Object? arguments}) → String
```

----------------------------------------

TITLE: Flutter LocalizationChannel API Reference
DESCRIPTION: API documentation for the `LocalizationChannel` class, including its associated interfaces and methods for handling localization messages and sending locale data between the platform and Dart.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/LocalizationChannel

LANGUAGE: APIDOC
CODE:
```
LocalizationChannel:
  Description: Manages localization events and requests parsed from the underlying platform channel.
  Associated Components:
    LocalizationMessageHandler:
      Type: interface in io.flutter.embedding.engine.systemchannels
      Description: Receives all events and requests parsed from the underlying platform channel.
  Methods:
    sendLocales:
      Signature: public void sendLocales(@NonNull List<Locale> locales)
      Parameters:
        locales:
          Type: List<Locale>
          Description: The list of locales to send to Dart.
      Return Type: void
      Description: Sends the given locales to Dart.
```

----------------------------------------

TITLE: FlutterResult Type Definition (Objective-C)
DESCRIPTION: Defines FlutterResult as a block type used for asynchronous operation results in Flutter channels, typically returning nil for success or a FlutterError for failures.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_platform_view_controller_8h_source

LANGUAGE: APIDOC
CODE:
```
void(^ FlutterResult)(id _Nullable result)
```

----------------------------------------

TITLE: FlutterWindowsView Class Public API
DESCRIPTION: Detailed API specification for the public member functions of the `flutter::FlutterWindowsView` class, including constructors, destructors, and methods for view management, rendering, and event handling.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_windows_view

LANGUAGE: APIDOC
CODE:
```
flutter::FlutterWindowsView Class

Public Member Functions:

- FlutterWindowsView(
    FlutterViewId view_id,
    FlutterWindowsEngine *engine,
    std::unique_ptr<WindowBindingHandler> window_binding,
    std::shared_ptr<WindowsProcTable> windows_proc_table = nullptr
  )
  Description: Constructor for FlutterWindowsView, initializing the view with an ID, engine, window binding, and an optional Windows procedure table.

- virtual ~FlutterWindowsView()
  Description: Destructor for FlutterWindowsView, handling cleanup of resources.

- FlutterViewId view_id() const
  Description: Returns the unique identifier for this Flutter view.
  Returns: FlutterViewId

- bool IsImplicitView() const
  Description: Checks if this view is an implicit view.
  Returns: bool

- void CreateRenderSurface()
  Description: Creates the underlying render surface for the view.

- egl::WindowSurface * surface() const
  Description: Returns a pointer to the EGL window surface associated with this view.
  Returns: egl::WindowSurface *

- virtual HWND GetWindowHandle() const
  Description: Returns the native window handle (HWND) for this view.
  Returns: HWND

- FlutterWindowsEngine * GetEngine() const
  Description: Returns a pointer to the FlutterWindowsEngine associated with this view.
  Returns: FlutterWindowsEngine *

- void ForceRedraw()
  Description: Forces a redraw of the view's content.

- virtual bool ClearSoftwareBitmap()
  Description: Clears the software bitmap used for rendering.
  Returns: bool

- virtual bool PresentSoftwareBitmap(
    const void *allocation,
    size_t row_bytes,
    size_t height
  )
  Description: Presents a software bitmap to the view's rendering surface.
  Parameters:
    allocation: Pointer to the bitmap data.
    row_bytes: The number of bytes per row in the bitmap.
    height: The height of the bitmap in pixels.
  Returns: bool

- FlutterWindowMetricsEvent CreateWindowMetricsEvent() const
  Description: Creates a FlutterWindowMetricsEvent reflecting the current window metrics.
  Returns: FlutterWindowMetricsEvent

- void SendInitialBounds()
  Description: Sends the initial bounds of the window to the Flutter engine.

- void AnnounceAlert(const std::wstring &text)
  Description: Announces an accessibility alert with the given text.
  Parameters:
    text: The text of the alert to announce.

- void OnHighContrastChanged() override
  Description: Handles changes in the system's high contrast settings.

- bool OnEmptyFrameGenerated()
  Description: Callback invoked when an empty frame is generated by the engine.
  Returns: bool

- bool OnFrameGenerated(size_t width, size_t height)
  Description: Callback invoked when a new frame is generated by the engine.
  Parameters:
    width: The width of the generated frame.
    height: The height of the generated frame.
  Returns: bool

- virtual void OnFramePresented()
  Description: Callback invoked when a frame has been successfully presented to the display.

- bool OnWindowSizeChanged(size_t width, size_t height) override
  Description: Handles changes in the window's size.
  Parameters:
    width: The new width of the window.
    height: The new height of the window.
  Returns: bool

- void OnWindowRepaint() override
  Description: Handles requests to repaint the window.

- void OnPointerMove(
    double x,
    double y,
    FlutterPointerDeviceKind device_kind,
    int32_t device_id,
    int modifiers_state
  ) override
  Description: Handles pointer move events, including mouse and touch movements.
  Parameters:
    x: The X coordinate of the pointer.
    y: The Y coordinate of the pointer.
    device_kind: The type of pointer device (e.g., mouse, touch).
    device_id: The ID of the pointer device.
    modifiers_state: The state of modifier keys (e.g., Shift, Ctrl).

- void OnPointerDown(
    double x,
    double y,
    FlutterPointerDeviceKind device_kind,
    int32_t device_id,
    FlutterPointerMouseButtons button
  ) override
  Description: Handles pointer down events, such as mouse clicks or touch presses.
  Parameters:
    x: The X coordinate of the pointer.
    y: The Y coordinate of the pointer.
    device_kind: The type of pointer device.
    device_id: The ID of the pointer device.
    button: The mouse button that was pressed.

- void OnPointerUp(
    double x,
    double y,
    FlutterPointerDeviceKind device_kind,
    int32_t device_id,
    FlutterPointerMouseButtons button
  ) override
  Description: Handles pointer up events, such as mouse button releases or touch lifts.
  Parameters:
    x: The X coordinate of the pointer.
    y: The Y coordinate of the pointer.
    device_kind: The type of pointer device.
    device_id: The ID of the pointer device.
    button: The mouse button that was released.

- void OnPointerLeave(
    double x,
    double y,
    FlutterPointerDeviceKind device_kind,
    int32_t device_id = 0
  ) override
  Description: Handles pointer leave events when the pointer exits the view's bounds.
  Parameters:
    x: The X coordinate of the pointer at the time of leaving.
    y: The Y coordinate of the pointer at the time of leaving.
    device_kind: The type of pointer device.
    device_id: The ID of the pointer device (defaults to 0).

```

----------------------------------------

TITLE: StandardMessageCodec Class API Reference (Java)
DESCRIPTION: Detailed API documentation for the `io.flutter.plugin.common.StandardMessageCodec` class, including its inheritance, implemented interfaces, supported data types, fields, constructors, and methods for encoding and decoding messages.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/StandardMessageCodec

LANGUAGE: APIDOC
CODE:
```
Class: StandardMessageCodec
  Extends: java.lang.Object
  Implements: MessageCodec<Object>

  Description:
    MessageCodec using the Flutter standard binary encoding.
    This codec is guaranteed to be compatible with the corresponding StandardMessageCodec on the Dart side.
    These parts of the Flutter SDK are evolved synchronously.

  Supported Message Types (Java -> Dart):
    - null -> null
    - Booleans -> bool
    - Bytes, Shorts, Integers, Longs -> int
    - BigIntegers -> String (hexadecimal representation)
    - Floats, Doubles -> double
    - Strings -> String
    - byte[] -> Uint8List
    - int[] -> Int32List
    - long[] -> Int64List
    - float[] -> Float32List
    - double[] -> Float64List
    - Lists of supported values -> List
    - Maps with supported keys and values -> Map

  Extension:
    To extend the codec, overwrite the writeValue and readValueOfType methods.

  Fields:
    - INSTANCE: static final StandardMessageCodec

  Constructors:
    - StandardMessageCodec()

  Methods:
    - decodeMessage(java.nio.ByteBuffer message)
      Returns: Object
      Description: Decodes the specified message from binary.

    - encodeMessage(java.lang.Object message)
      Returns: java.nio.ByteBuffer
      Description: Encodes the specified message into binary.

    - readAlignment(java.nio.ByteBuffer buffer, int alignment)
      Returns: protected static final void
      Description: Reads alignment padding bytes as written by writeAlignment.

    - readBytes(java.nio.ByteBuffer buffer)
      Returns: protected static final byte[]
      Description: Reads a byte array as written by writeBytes.

    - readSize(java.nio.ByteBuffer buffer)
      Returns: protected static final int
      Description: Reads an int representing a size as written by writeSize.

    - readValue(java.nio.ByteBuffer buffer)
      Returns: protected final Object
      Description: Reads a value as written by writeValue.

    - readValueOfType(byte type, java.nio.ByteBuffer buffer)
      Returns: protected Object
      Description: Reads a value of the specified type.

    - writeAlignment(java.io.ByteArrayOutputStream stream, int alignment)
      Returns: protected static final void
      Description: Writes a number of padding bytes to the specified stream to ensure that the next value is aligned to a whole multiple of the specified alignment.

    - (Incomplete method signature from source)
      Returns: protected static final void
```

----------------------------------------

TITLE: Navigator.replace
DESCRIPTION: Replaces a route on the navigator that most tightly encloses the given context with a new route.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
replace<T extends Object?>(BuildContext context, {required Route oldRoute, required Route<T> newRoute}) → void
```

----------------------------------------

TITLE: Flutter C++ BinaryMessenger Class API
DESCRIPTION: Defines the abstract `BinaryMessenger` class, which provides the fundamental interface for sending and receiving binary messages between Flutter and the host platform. It includes methods for sending raw binary data and setting binary message handlers.
SOURCE: https://api.flutter.dev/macos-embedder/basic__message__channel_8h_source

LANGUAGE: C++
CODE:
```
flutter::BinaryMessenger:
  Send(channel: const std::string&, message: const uint8_t*, message_size: size_t, reply: BinaryReply = nullptr) const: virtual void
  SetMessageHandler(channel: const std::string&, handler: BinaryMessageHandler): virtual void
```

----------------------------------------

TITLE: Dart VM Library: dart:isolate
DESCRIPTION: Enables concurrent programming using isolates: independent workers that are similar to threads but don't share memory, communicating only via messages.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Library: dart:isolate
Description: Concurrent programming using isolates: independent workers that are similar to threads but don't share memory, communicating only via messages.
```

----------------------------------------

TITLE: Flutter Linux Embedder API Class and Struct Index
DESCRIPTION: An alphabetical listing of all classes and structs available in the Flutter Linux Embedder API, providing quick access to their respective documentation pages and an overview of the API's structure.
SOURCE: https://api.flutter.dev/linux-embedder/classes

LANGUAGE: APIDOC
CODE:
```
Class Index:

A:
  - AccessibilityBridge (flutter)
  - ActionData
  - AlertPlatformNodeDelegate (flutter)

B:
  - BasicMessageChannel (flutter)
  - BinaryMessenger (flutter)
  - BinaryMessengerImpl (flutter)
  - ByteBufferStreamReader (flutter)
  - ByteBufferStreamWriter (flutter)
  - ByteStreamReader (flutter)
  - ByteStreamWriter (flutter)

C:
  - CallRecord
  - CustomEncodableValue (flutter)

E:
  - EditingDelta
  - EditingState
  - EncodableValue (flutter)
  - EngineMethodResult (flutter)
  - EventChannel (flutter)
  - EventSink (flutter)

F:
  - FlAccessibleNodePrivate
  - FlApplicationPrivate
  - FlGnomeSettingsTest
  - FlKeyboardChannelVTable
  - FlKeyEmbedderCheckedKey
  - FlMouseCursorChannelVTable
  - FlPixelBufferTexturePrivate
  - FlPlatformChannelVTable
  - FlSetting
  - FlTextInputChannelVTable
  - FlTextureGLPrivate
  - FlutterDesktopGpuSurfaceDescriptor
  - FlutterDesktopGpuSurfaceTextureConfig
  - FlutterDesktopMessage
  - FlutterDesktopPixelBuffer
  - FlutterDesktopPixelBufferTextureConfig
  - FlutterDesktopTextureInfo
  - FlutterPlatformNodeDelegate (flutter)
  - FlValueBool
  - FlValueCustom
  - FlValueDouble
  - FlValueFloat32List
  - FlValueFloatList
  - FlValueHandler
  - FlValueInt
  - FlValueInt32List
  - FlValueInt64List
  - FlValueList
  - FlValueMap
  - FlValueString
  - FlValueUint8List
  - FlWindowingChannelVTable
  - FlWindowingHandlerPrivate
  - FlWindowingSize

G:
  - GpuSurfaceTexture (flutter)

H:
  - HandleEventData

I:
  - IncomingMessageDispatcher (flutter)
  - InputConfig

J:
  - JsonMessageCodec (flutter)
  - JsonMethodCodec (flutter)

K:
  - KeyEventData

L:
  - LayoutGoal

M:
  - (List continues...)
```

----------------------------------------

TITLE: Flutter Plugin: handleMethodCall:result: (Objective-C API)
DESCRIPTION: This method is called if the plugin has been registered to receive FlutterMethodCalls. It allows the plugin to process incoming method calls and submit results.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_plugin-p

LANGUAGE: APIDOC
CODE:
```
- (void) handleMethodCall: (FlutterMethodCall *) call result: (FlutterResult) result
  Parameters:
    call: FlutterMethodCall* - The method call command object.
    result: FlutterResult - A callback for submitting the result of the call.
```

----------------------------------------

TITLE: FlutterEngine Interface API Reference
DESCRIPTION: Detailed API documentation for the `FlutterEngine` interface, outlining its properties for inter-platform communication and view management, and methods for lifecycle control, including proper shutdown procedures.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterEngine Interface:
  Properties:
    binaryMessenger: id<FlutterBinaryMessenger> (nonatomic, nonnull, readonly)
      Description: Provides a messenger for sending and receiving binary messages between Flutter and the host platform.
    viewController: FlutterViewController*
      Description: The view controller associated with the Flutter engine.
  Methods:
    shutDownEngine(): void
      Description: Shuts the Flutter engine if it is running. The FlutterEngine instance must always be shutdown before it may be collected. Not shutting down the FlutterEngine instance before releasing it will result in the leak of that engine instance.
    NS_UNAVAILABLE(): nonnull instancetype
      Description: Indicates that the default initializer for FlutterEngine is unavailable.
```

----------------------------------------

TITLE: Navigator.pop API Reference (Flutter)
DESCRIPTION: Pops the top-most route off the navigator that most tightly encloses the given context. This action removes the current screen from the navigation stack.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
pop<T extends Object?>(BuildContext context, T? result) -> void
  Description: Pop the top-most route off the navigator that most tightly encloses the given context.
```

----------------------------------------

TITLE: Get Dart Entrypoint Library URI
DESCRIPTION: Returns the Dart library URI for the entrypoint to be executed upon Dart snapshot loading, e.g., "package:foo/bar.dart". This preference can be set using a `<meta-data>` tag in the Android manifest. A `null` value defaults to the root library. Subclasses can override this method for direct control.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
getDartEntrypointLibraryUri(): String @Nullable
  Purpose: Specifies the Dart library URI for the entrypoint.
  Example: "package:foo/bar.dart"
  Control: Android Manifest (<meta-data> FlutterActivityLaunchConfigs.DART_ENTRYPOINT_URI_META_DATA_KEY).
  Null Value: Means use the default root library.
  Override: Subclasses can override.
```

----------------------------------------

TITLE: Dart Core Library: dart:core
DESCRIPTION: Contains built-in types, collections, and other core functionality for every Dart program.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Library: dart:core
Description: Built-in types, collections, and other core functionality for every Dart program.
```

----------------------------------------

TITLE: FlutterPlugin Lifecycle Method Summary
DESCRIPTION: An overview of the primary lifecycle methods for `FlutterPlugin`s, detailing how they are notified when associated with or removed from a `FlutterEngine` instance.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin

LANGUAGE: APIDOC
CODE:
```
Methods:
  onAttachedToEngine:
    Signature: void onAttachedToEngine(io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding binding)
    Description: This FlutterPlugin has been associated with a FlutterEngine instance.
  onDetachedFromEngine:
    Signature: void onDetachedFromEngine(io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding binding)
    Description: This FlutterPlugin has been removed from a FlutterEngine instance.
```

----------------------------------------

TITLE: Set Method Call Handler for Flutter MethodChannel
DESCRIPTION: Sets a callback for receiving method calls on this channel.
SOURCE: https://api.flutter.dev/flutter/services/MethodChannel-class

LANGUAGE: APIDOC
CODE:
```
setMethodCallHandler(Future handler(MethodCall call)?) → void
```

----------------------------------------

TITLE: Invoke Method on Flutter MethodChannel
DESCRIPTION: Invokes a specified method on this MethodChannel with the given arguments. This is the general method invocation for the channel.
SOURCE: https://api.flutter.dev/flutter/services/MethodChannel-class

LANGUAGE: APIDOC
CODE:
```
invokeMethod<T>(String method, dynamic arguments) → Future<T?>
```

----------------------------------------

TITLE: Set up FlView in a GTK Application
DESCRIPTION: An example demonstrating how to initialize a FlDartProject, create an FlView, add it to a GTK container, and set up binary messengers for channels or plugins.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8cc

LANGUAGE: C
CODE:
```
FlDartProject *project = fl_dart_project_new ();
FlView *view = fl_view_new (project);
gtk_widget_show (GTK_WIDGET (view));
gtk_container_add (GTK_CONTAINER (parent), view);

FlBinaryMessenger *messenger = fl_engine_get_binary_messenger (fl_view_get_engine (view));
setup_channels_or_plugins (messenger);
```

----------------------------------------

TITLE: EventChannel Class
DESCRIPTION: A named channel for communicating with platform plugins using event streams, allowing continuous data flow.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
EventChannel:
```

----------------------------------------

TITLE: Flutter Method Result Handler Typedefs
DESCRIPTION: API documentation for `std::function` based typedefs used to define callbacks for various method call outcomes. `ResultHandlerSuccess` handles successful results, `ResultHandlerError` manages errors with code, message, and optional details, and `ResultHandlerNotImplemented` is for cases where a method is not implemented.
SOURCE: https://api.flutter.dev/windows-embedder/method__result__functions_8h

LANGUAGE: APIDOC
CODE:
```
Typedefs:
  template<typename T >
  using flutter::ResultHandlerSuccess = std::function< void(const T *result)>

  template<typename T >
  using flutter::ResultHandlerError = std::function< void(const std::string &error_code, const std::string &error_message, const T *error_details)>

  template<typename T >
  using flutter::ResultHandlerNotImplemented = std::function< void()>
```

----------------------------------------

TITLE: FlutterMethodChannel Interface Definition
DESCRIPTION: Defines the FlutterMethodChannel interface, used for method calls between Flutter and the host platform.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel
  Type: Interface
  Definition: FlutterChannels.h:221
```

----------------------------------------

TITLE: flutter::JsonMethodCodec Class API Reference
DESCRIPTION: API documentation for the flutter::JsonMethodCodec class, which handles JSON-based encoding and decoding for Flutter method channels. It details internal methods for encoding method calls and success envelopes, and provides access to its singleton instance.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_json_method_codec

LANGUAGE: APIDOC
CODE:
```
class flutter::JsonMethodCodec:
  // Inherits from flutter::MethodCodec<rapidjson::Document>

  EncodeMethodCallInternal(method_call: const MethodCall<rapidjson::Document>&) -> std::unique_ptr<std::vector<uint8_t>>
    Description: Encodes a MethodCall object into a JSON rapidjson::Document message.
    Parameters:
      method_call: The MethodCall object to encode.
    Returns: A unique pointer to a vector of bytes representing the encoded message.
    Implements: flutter::MethodCodec<rapidjson::Document>::EncodeMethodCallInternal

  EncodeSuccessEnvelopeInternal(result: const rapidjson::Document*) -> std::unique_ptr<std::vector<uint8_t>>
    Description: Encodes a successful method call result into a JSON rapidjson::Document envelope.
    Parameters:
      result: A pointer to the rapidjson::Document representing the result.
    Returns: A unique pointer to a vector of bytes representing the encoded envelope.
    Implements: flutter::MethodCodec<rapidjson::Document>::EncodeSuccessEnvelopeInternal

  GetInstance() -> const JsonMethodCodec&
    Description: Provides a static singleton instance of the JsonMethodCodec.
    Returns: A const reference to the singleton JsonMethodCodec instance.

  operator=(const JsonMethodCodec&) -> JsonMethodCodec&
    Description: Deleted copy assignment operator to prevent copying.
    Type: Deleted
```

----------------------------------------

TITLE: Objective-C: Register Flutter Method Call Handler
DESCRIPTION: Registers a handler for method calls originating from the Flutter side. This replaces any existing handler. Passing `nil` unregisters the current handler.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h_source

LANGUAGE: Objective-C
CODE:
```
- (void)setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler;
```

----------------------------------------

TITLE: Navigator.push API Reference (Flutter)
DESCRIPTION: Pushes the given route onto the navigator that most tightly encloses the given context. This adds a new screen to the top of the navigation stack.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
push<T extends Object?>(BuildContext context, Route<T> route) -> Future<T?>
  Description: Push the given route onto the navigator that most tightly encloses the given context.
```

----------------------------------------

TITLE: flutter::MethodChannel Class API Documentation
DESCRIPTION: Detailed API reference for the `flutter::MethodChannel` class template, which facilitates communication between Flutter and the host platform. It includes constructors, destructor, and methods for invoking platform methods and setting method call handlers.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_method_channel

LANGUAGE: APIDOC
CODE:
```
flutter::MethodChannel< T > Class Template Reference

Description:
  Definition at line 34 of file method_channel.h.

Constructors:
  MethodChannel(
    BinaryMessenger *messenger,
    const std::string &name,
    const MethodCodec< T > *codec
  )
  MethodChannel(MethodChannel const &) = delete

Destructor:
  ~MethodChannel() = default

Public Member Functions:
  MethodChannel & operator=(MethodChannel const &) = delete
  void InvokeMethod(
    const std::string &method,
    std::unique_ptr< T > arguments,
    std::unique_ptr< MethodResult< T >> result = nullptr
  )
  void SetMethodCallHandler(
    MethodCallHandler< T > handler
  ) const
  void Resize(
    int new_size
  )
  void SetWarnsOnOverflow(
    bool warns
  )
```

----------------------------------------

TITLE: API: Start Flutter Engine
DESCRIPTION: Starts the Flutter engine, initializing its Dart VM and rendering capabilities. This function must be called before the engine can process Flutter UI or logic.
SOURCE: https://api.flutter.dev/linux-embedder/fl__binary__messenger__test_8cc_source

LANGUAGE: APIDOC
CODE:
```
gboolean fl_engine_start(FlEngine *self, GError **error)
  self: The FlEngine instance.
  error: A GError pointer to capture any errors.
```

----------------------------------------

TITLE: Flutter: Navigating to a Named Route
DESCRIPTION: This snippet shows how to navigate to a previously defined named route using `Navigator.pushNamed`. This method simplifies navigation in applications with many routes by referring to them by their assigned names.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
Navigator.pushNamed(context, '/b');
```

----------------------------------------

TITLE: Flutter Services: rootBundle Property
DESCRIPTION: This property represents the AssetBundle from which the application was loaded. It is a final property.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
rootBundle: AssetBundle
  Type: AssetBundle
  Access: final
```

----------------------------------------

TITLE: FlutterRunLoop: Perform Block on RunLoop
DESCRIPTION: Executes a given block of code on the Flutter run loop. This method ensures that the block is performed on the correct thread, which is essential for UI operations and thread safety.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_display_link_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterRunLoop:
  performBlock(block: void(^)(void))
    void performBlock:(void(^ block)(void))
```

----------------------------------------

TITLE: FlutterEngine Class API Reference
DESCRIPTION: Defines the FlutterEngine class, its constructors, methods for controlling the Flutter runtime, and properties for interacting with the Flutter UI and messaging system. Includes inherited methods from FlutterPluginRegistry.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
FlutterEngine Class Reference
#import <FlutterEngine.h>

Inheritance diagram for FlutterEngine: (image reference)

Instance Methods:
  - (instancetype) init
  - (instancetype) initWithName:
  - (instancetype) initWithName:project:
  - (instancetype) initWithName:project:allowHeadlessExecution:
  - (instancetype) initWithName:project:allowHeadlessExecution:restorationEnabled:
  - (BOOL) run
  - (BOOL) runWithEntrypoint:
  - (BOOL) runWithEntrypoint:initialRoute:
  - (BOOL) runWithEntrypoint:libraryURI:
  - (BOOL) runWithEntrypoint:libraryURI:initialRoute:
  - (BOOL) runWithEntrypoint:libraryURI:initialRoute:entrypointArgs:
  - (void) destroyContext
  - (void) ensureSemanticsEnabled
  - (NSURL *observatoryUrl) FLUTTER_DEPRECATED
  - (flutter::Shell &) shell
  - (flutter::PlatformViewIOS *) platformView
  - (void) setBinaryMessenger:
  - (flutter::IOSRenderingAPI) platformViewsRenderingAPI
  - (void) waitForFirstFrame:callback:
  - (FlutterEngine *) spawnWithEntrypoint:libraryURI:initialRoute:entrypointArgs:
  - (const flutter::ThreadHost &) threadHost
  - (void) updateDisplays
  - (void) flutterTextInputView:performAction:withClient:
  - (void) sceneWillEnterForeground:
  - (void) sceneDidEnterBackground:
  - (void) applicationWillEnterForeground:
  - (void) applicationDidEnterBackground:

Instance Methods inherited from <FlutterPluginRegistry>:
  - (nullable NSObject<FlutterPluginRegistrar> *) registrarForPlugin:
  - (BOOL) hasPlugin:
  - (nullable NSObject *) valuePublishedByPlugin:

Properties:
  - FlutterViewController * viewController
  - FlutterMethodChannel * localizationChannel
  - FlutterMethodChannel * navigationChannel
```

----------------------------------------

TITLE: C++ BasicMessageChannel Class API
DESCRIPTION: The `BasicMessageChannel` class provides a mechanism for asynchronous message communication with the Flutter engine. It is templated to support different message types and uses a `MessageCodec` for encoding/decoding. This snippet defines its constructor, destructor, copy prevention, and the `Send` method for sending messages without expecting a reply.
SOURCE: https://api.flutter.dev/macos-embedder/basic__message__channel_8h_source

LANGUAGE: C++
CODE:
```
template <typename T = EncodableValue>
class BasicMessageChannel {
 public:
  // Creates an instance that sends and receives method calls on the channel
  // named |name|, encoded with |codec| and dispatched via |messenger|.
  BasicMessageChannel(BinaryMessenger* messenger,
                      const std::string& name,
                      const MessageCodec<T>* codec)
      : messenger_(messenger), name_(name), codec_(codec) {}

  ~BasicMessageChannel() = default;

  // Prevent copying.
  BasicMessageChannel(BasicMessageChannel const&) = delete;
  BasicMessageChannel& operator=(BasicMessageChannel const&) = delete;

  // Sends a message to the Flutter engine on this channel.
  void Send(const T& message) {
    std::unique_ptr<std::vector<uint8_t>> raw_message =
        codec_->EncodeMessage(message);
    messenger_->Send(name_, raw_message->data(), raw_message->size());
  }

  // Sends a message to the Flutter engine on this channel expecting a reply.
```

----------------------------------------

TITLE: Color Class
DESCRIPTION: Represents an immutable color value, typically in ARGB (Alpha, Red, Green, Blue) format, used for painting and styling.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
Color:
  An immutable color value in ARGB format.
```

----------------------------------------

TITLE: flutter::FlutterEngine::FlutterEngine (Constructor)
DESCRIPTION: Constructs a new FlutterEngine instance, initializing it with a specified Dart project.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__engine_8h_source

LANGUAGE: C++
CODE:
```
FlutterEngine(const DartProject &project)
```

----------------------------------------

TITLE: Navigator Property: key
DESCRIPTION: Documents the 'key' property, inherited from the Widget class. It controls how one widget replaces another in the widget tree.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
Property: key
Type: Key?
Description: Controls how one widget replaces another widget in the tree.
Modifiers: final, inherited
```

----------------------------------------

TITLE: FlutterViewController iOS API Methods and Properties
DESCRIPTION: Defines properties and methods for the FlutterViewController, covering lifecycle events, input handling, keyboard management, and internal plugin setup within the Flutter iOS embedding. This includes handling touch events, orientation updates, keyboard notifications, and application/scene lifecycle changes.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_test_8mm_source

LANGUAGE: Objective-C
CODE:
```
@property(nonatomic, strong) VSyncClient* touchRateCorrectionVSyncClient;
- (void)createTouchRateCorrectionVSyncClientIfNeeded;
- (void)surfaceUpdated:(BOOL)appeared;
- (void)performOrientationUpdate:(UIInterfaceOrientationMask)new_preferences;
- (void)handlePressEvent:(FlutterUIPressProxy*)press
 nextAction:(void (^)())next API_AVAILABLE(ios(13.4));
- (void)discreteScrollEvent:(UIPanGestureRecognizer*)recognizer;
- (void)updateViewportMetricsIfNeeded;
- (void)onUserSettingsChanged:(NSNotification*)notification;
- (void)applicationWillTerminate:(NSNotification*)notification;
- (void)goToApplicationLifecycle:(nonnull NSString*)state;
- (void)handleKeyboardNotification:(NSNotification*)notification;
- (CGFloat)calculateKeyboardInset:(CGRect)keyboardFrame keyboardMode:(int)keyboardMode;
- (BOOL)shouldIgnoreKeyboardNotification:(NSNotification*)notification;
- (FlutterKeyboardMode)calculateKeyboardAttachMode:(NSNotification*)notification;
- (CGFloat)calculateMultitaskingAdjustment:(CGRect)screenRect keyboardFrame:(CGRect)keyboardFrame;
- (void)startKeyBoardAnimation:(NSTimeInterval)duration;
- (void)hideKeyboardImmediately;
- (UIView*)keyboardAnimationView;
- (SpringAnimation*)keyboardSpringAnimation;
- (void)setUpKeyboardSpringAnimationIfNeeded:(CAAnimation*)keyboardAnimation;
- (void)setUpKeyboardAnimationVsyncClient:
 (FlutterKeyboardAnimationCallback)keyboardAnimationCallback;
- (void)ensureViewportMetricsIsCorrect;
- (void)invalidateKeyboardAnimationVSyncClient;
- (void)addInternalPlugins;
- (flutter::PointerData)generatePointerDataForFake;
- (void)sharedSetupWithProject:(nullable FlutterDartProject*)project
 initialRoute:(nullable NSString*)initialRoute;
- (void)applicationBecameActive:(NSNotification*)notification;
- (void)applicationWillResignActive:(NSNotification*)notification;
- (void)applicationWillTerminate:(NSNotification*)notification;
- (void)applicationDidEnterBackground:(NSNotification*)notification;
- (void)applicationWillEnterForeground:(NSNotification*)notification;
- (void)sceneBecameActive:(NSNotification*)notification API_AVAILABLE(ios(13.0));
- (void)sceneWillResignActive:(NSNotification*)notification API_AVAILABLE(ios(13.0));
- (void)sceneWillDisconnect:(NSNotification*)notification API_AVAILABLE(ios(13.0));
- (void)sceneDidEnterBackground:(NSNotification*)notification API_AVAILABLE(ios(13.0));
- (void)sceneWillEnterForeground:(NSNotification*)notification API_AVAILABLE(ios(13.0));
- (void)triggerTouchRateCorrectionIfNeeded:(NSSet*)touches;
@end
```

----------------------------------------

TITLE: FlutterViewController Class API Reference
DESCRIPTION: Documents the `flutter::FlutterViewController` class, including its public member functions, constructors, and destructor. It provides an overview of the class's interface for managing Flutter views and engines within a Windows application.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_view_controller

LANGUAGE: APIDOC
CODE:
```
flutter::FlutterViewController Class Reference
  #include <flutter_view_controller.h>

  Public Member Functions:
    FlutterViewController(int width, int height, const DartProject &project)
    virtual ~FlutterViewController()
    FlutterViewController(FlutterViewController const &)=delete
    FlutterViewController &operator=(FlutterViewController const &)=delete
    FlutterViewId view_id() const
    FlutterEngine *engine() const
    FlutterView *view() const
    void ForceRedraw()
    std::optional< LRESULT > HandleTopLevelWindowProc(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)

  Constructor & Destructor Documentation:
    FlutterViewController(int width, int height, const DartProject &project)
      Parameters:
        width: int
        height: int
        project: const DartProject &
```

----------------------------------------

TITLE: flutter::KeyboardKeyHandler::KeyboardHook
DESCRIPTION: Handles a key event. Returns whether this handler claims to handle the event, which is true if and only if the event is a non-synthesized event. Windows requires a synchronous response of whether a key event should be handled, while the query to Flutter is always asynchronous. This is resolved by the "redispatching" algorithm: by default, the response to a fresh event is always true. The event is then sent to the framework. If the framework later decides not to handle the event, this class will create an identical event and dispatch it to the system, and remember all synthesized events. The first time an exact event (by `ComputeEventHash`) is received in the future, the new event is considered a synthesized one, causing `KeyboardHook` to return false to fall back to other keyboard handlers. Whether a non-synthesized event is considered handled by the framework is decided by dispatching the event to all delegates, simultaneously, unconditionally, in insertion order, and collecting their responses later. It's not supported to prevent any delegates to process the events, because in reality this will only support 2 hardcoded delegates, and only to continue supporting the legacy API (channel) during the deprecation window, after which the channel delegate should be removed. Inherited from `KeyboardHandlerBase`.
SOURCE: https://api.flutter.dev/windows-embedder/keyboard__key__handler_8h_source

LANGUAGE: APIDOC
CODE:
```
void KeyboardHook(
  int key,
  int scancode,
  int action,
  char32_t character,
  bool extended,
  bool was_down,
  KeyEventCallback callback
) override;
Parameters:
  key: The key identifier.
  scancode: The scancode of the key.
  action: The action performed (e.g., key down, key up).
  character: The character generated by the key event.
  extended: True if the key is an extended key.
  was_down: True if the key was previously down.
  callback: A callback function of type KeyEventCallback to report results.
Returns:
  bool: True if the event is handled (non-synthesized), false otherwise.
```

----------------------------------------

TITLE: flutter::Rect Class API Reference
DESCRIPTION: Comprehensive API documentation for the flutter::Rect class, detailing its constructors, assignment and equality operators, and methods to access its geometric properties such as bottom, height, left, origin, right, size, top, and width.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_rect-members

LANGUAGE: APIDOC
CODE:
```
flutter::Rect Class
  Description: Complete list of members for flutter::Rect, including all inherited members.

  Constructors:
    Rect()=default
      Description: Default constructor for Rect.
    Rect(const Point &origin, const Size &size)
      Parameters:
        origin: const Point & - The top-left corner of the rectangle.
        size: const Size & - The width and height of the rectangle.
      Description: Constructs a Rect from an origin point and a size.
    Rect(const Rect &rect)=default
      Parameters:
        rect: const Rect & - The rectangle to copy.
      Description: Copy constructor for Rect.

  Operators:
    operator=(const Rect &other)=default
      Parameters:
        other: const Rect & - The rectangle to assign from.
      Returns: Rect &
      Description: Assignment operator.
    operator==(const Rect &other) const
      Parameters:
        other: const Rect & - The rectangle to compare with.
      Returns: bool
      Description: Equality operator, returns true if rectangles are equal.

  Methods:
    bottom() const
      Returns: double
      Description: Returns the bottom coordinate of the rectangle.
    height() const
      Returns: double
      Description: Returns the height of the rectangle.
    left() const
      Returns: double
      Description: Returns the left coordinate of the rectangle.
    origin() const
      Returns: Point
      Description: Returns the origin (top-left Point) of the rectangle.
    right() const
      Returns: double
      Description: Returns the right coordinate of the rectangle.
    size() const
      Returns: Size
      Description: Returns the size (width and height) of the rectangle.
    top() const
      Returns: double
      Description: Returns the top coordinate of the rectangle.
    width() const
      Returns: double
      Description: Returns the width of the rectangle.
```

----------------------------------------

TITLE: APIDOC: FlutterMethodCallHandler Typedef
DESCRIPTION: Defines a callback for handling incoming method calls from Flutter. It provides the method call object and a result callback for asynchronous responses.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h

LANGUAGE: APIDOC
CODE:
```
typedef void(^ FlutterMethodCallHandler) (FlutterMethodCall *call, FlutterResult result)
Parameters:
  call: The incoming method call.
  result: A callback to asynchronously submit the result of the call. Invoke the callback with a FlutterError to indicate that the call failed. Invoke the callback with FlutterMethodNotImplemented to indicate that the method was unknown. Any other values, including nil, are interpreted as successful results. This can be invoked from any thread.
```

----------------------------------------

TITLE: FlutterEngine Interface and shutDownEngine Method
DESCRIPTION: Represents the core Flutter engine, providing methods for lifecycle management like shutting down.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_test_utils_8mm_source

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterEngine
Definition: FlutterEngine.h:32

Method: -[FlutterEngine shutDownEngine]
  Signature: void shutDownEngine()
  Description: Shuts down the Flutter engine.
  Definition: FlutterEngine.mm:1177
```

----------------------------------------

TITLE: APIDOC: Flutter Platform Method Call API Definitions
DESCRIPTION: This section provides API documentation for key types and constants used in handling Flutter platform method calls, including the `handleMethodCall:result:` signature, `FlutterResult` callback type, `FlutterMethodNotImplemented` constant, and `FlutterMethodCall` class with its properties (`method` and `arguments`). These definitions are crucial for understanding the interface between Flutter and native platform code.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_platform_plugin

LANGUAGE: APIDOC
CODE:
```
handleMethodCall:result:
  - (void) handleMethodCall: (FlutterMethodCall*)call result: (FlutterResult)result
    call: FlutterMethodCall* - The incoming method call from Flutter.
    result: FlutterResult - A callback to send the result back to Flutter.

FlutterResult:
  Type: void(^ FlutterResult)(id _Nullable result)
  Definition: FlutterChannels.h:194
  Purpose: A block/typedef for returning results from native code back to Flutter.

FlutterMethodNotImplemented:
  Type: NSObject const *
  Purpose: A constant indicating that a method is not implemented.

FlutterMethodCall:
  Definition: FlutterCodecs.h:221
  Properties:
    method: NSString * - The name of the method being called.
    arguments: id - The arguments passed with the method call.
```

----------------------------------------

TITLE: Flutter Channels API Classes Overview
DESCRIPTION: Overview of core classes for handling messages, method calls, and event streams between Flutter and the host platform.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h

LANGUAGE: APIDOC
CODE:
```
Classes:
  FlutterBasicMessageChannel
  FlutterMethodChannel
  <FlutterStreamHandler> (protocol)
  FlutterEventChannel
```

----------------------------------------

TITLE: Set Dart Entrypoint Arguments in Flutter DartProject (C++)
DESCRIPTION: This method sets the command line arguments that should be passed to the Dart entrypoint. It takes a `std::vector<std::string>` representing the arguments and stores them internally for the Dart project.
SOURCE: https://api.flutter.dev/windows-embedder/dart__project_8h_source

LANGUAGE: C++
CODE:
```
void set_dart_entrypoint_arguments(std::vector<std::string> arguments) {
  dart_entrypoint_arguments_ = std::move(arguments);
}
```

----------------------------------------

TITLE: Flutter PluginRegistrarManager GetRegistrar Template Method Implementation
DESCRIPTION: Implementation of the templated `GetRegistrar` method for `flutter::PluginRegistrarManager`, used to retrieve or create a plugin registrar of a specified type and set its destruction handler.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_plugin_registrar_manager

LANGUAGE: C++
CODE:
```
template<class T >
T* flutter::PluginRegistrarManager::GetRegistrar(FlutterDesktopPluginRegistrarRef registrar_ref) inline
{
  auto insert_result =
  registrars_.emplace(registrar_ref, std::make_unique<T>(registrar_ref));
  auto& registrar_pair = *(insert_result.first);
  FlutterDesktopPluginRegistrarSetDestructionHandler(registrar_pair.first,
  OnRegistrarDestroyed);
  return static_cast<T*>(registrar_pair.second.get());
}
```

----------------------------------------

TITLE: Navigator.pushReplacement
DESCRIPTION: Replace the current route of the navigator that most tightly encloses the given context by pushing the given route and then disposing the previous route once the new route has finished animating in.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
pushReplacement<T extends Object?, TO extends Object?>(BuildContext context, Route<T> newRoute, {TO? result}) → Future<T?>
```

----------------------------------------

TITLE: Execute Dart entrypoint with arguments
DESCRIPTION: Initiates the execution of Dart code based on the given dartEntrypoint and a list of string arguments. Refer to DartExecutor.DartEntrypoint for configuration options.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/dart/DartExecutor

LANGUAGE: APIDOC
CODE:
```
DartExecutor:
  executeDartEntrypoint(dartEntrypoint: DartExecutor.DartEntrypoint, dartEntrypointArgs: List<String>): void
    Parameters:
      dartEntrypoint: specifies which Dart function to run, and where to find it
      dartEntrypointArgs: Arguments passed as a list of string to Dart's entrypoint function.
```

----------------------------------------

TITLE: Access Embedder API Function Pointers (Objective-C)
DESCRIPTION: Provides direct access to a table of function pointers for interacting with the low-level embedder.h API. This property allows for advanced customization and integration with the Flutter engine's embedding layer.
SOURCE: https://api.flutter.dev/macos-embedder/category_flutter_engine_07_08

LANGUAGE: APIDOC
CODE:
```
Property: embedderAPI
Type: FlutterEngineProcTable&
Access: readwrite, nonatomic, assign
Description: Function pointers for interacting with the embedder.h API.
Defined at: FlutterEngine_Internal.h:98
```

----------------------------------------

TITLE: C++ Set Message Callback for Channel
DESCRIPTION: Registers or unregisters a callback function for a specific message channel. If a callback is provided, it's associated with the channel; if `nullptr` is passed, the existing callback for that channel is removed, effectively unregistering the handler.
SOURCE: https://api.flutter.dev/macos-embedder/incoming__message__dispatcher_8cc_source

LANGUAGE: C++
CODE:
```
void IncomingMessageDispatcher::SetMessageCallback(
    const std::string& channel,
    FlutterDesktopMessageCallback callback,
    void* user_data) {
    if (!callback) {
        callbacks_.erase(channel);
        return;
    }
    callbacks_[channel] = std::make_pair(callback, user_data);
}
```

----------------------------------------

TITLE: Instantiate and Manage FlutterJNI Connection
DESCRIPTION: This Java snippet demonstrates how to instantiate a `FlutterJNI` object, attach it to the native C/C++ engine, use it for dispatching data, and then detach it to release resources. This is the fundamental lifecycle for interacting with the Flutter engine from Java.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterJNI

LANGUAGE: Java
CODE:
```
 // Instantiate FlutterJNI and attach to the native side.
 FlutterJNI flutterJNI = new FlutterJNI();
 flutterJNI.attachToNative();

 // Use FlutterJNI as desired. flutterJNI.dispatchPointerDataPacket(...);

 // Destroy the connection to the native side and cleanup.
 flutterJNI.detachFromNativeAndReleaseResources();
```

----------------------------------------

TITLE: Configure GTK Event Box and Gesture Recognizers in C
DESCRIPTION: This C code snippet initializes a GtkEventBox, configures it to expand, and adds it to the parent container. It then attaches a comprehensive set of event masks for pointer, button, scroll, and touch interactions. Multiple signal handlers are connected for various events like button presses, releases, scrolling, motion, enter/leave notifications, and touch events. Additionally, it sets up GtkGestureZoom and GtkGestureRotate objects on the event box, connecting their respective begin, scale/angle-changed, and end callbacks to handle multi-touch gestures. Finally, it initializes a GtkGLArea, sets its alpha property, and adds it to the event box, connecting a render callback.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8cc_source

LANGUAGE: C
CODE:
```
self->background_color = gdk_rgba_copy(&default_background);

GtkWidget* event_box = gtk_event_box_new();
gtk_widget_set_hexpand(event_box, TRUE);
gtk_widget_set_vexpand(event_box, TRUE);
gtk_container_add(GTK_CONTAINER(self), event_box);
gtk_widget_show(event_box);
gtk_widget_add_events(event_box,
GDK_POINTER_MOTION_MASK | GDK_BUTTON_PRESS_MASK |
GDK_BUTTON_RELEASE_MASK | GDK_SCROLL_MASK |
GDK_SMOOTH_SCROLL_MASK | GDK_TOUCH_MASK);

g_signal_connect_swapped(event_box, "button-press-event",
G_CALLBACK(button_press_event_cb), self);
g_signal_connect_swapped(event_box, "button-release-event",
G_CALLBACK(button_release_event_cb), self);
g_signal_connect_swapped(event_box, "scroll-event",
G_CALLBACK(scroll_event_cb), self);
g_signal_connect_swapped(event_box, "motion-notify-event",
G_CALLBACK(motion_notify_event_cb), self);
g_signal_connect_swapped(event_box, "enter-notify-event",
G_CALLBACK(enter_notify_event_cb), self);
g_signal_connect_swapped(event_box, "leave-notify-event",
G_CALLBACK(leave_notify_event_cb), self);
GtkGesture* zoom = gtk_gesture_zoom_new(event_box);
g_signal_connect_swapped(zoom, "begin", G_CALLBACK(gesture_zoom_begin_cb),
self);
g_signal_connect_swapped(zoom, "scale-changed",
G_CALLBACK(gesture_zoom_update_cb), self);
g_signal_connect_swapped(zoom, "end", G_CALLBACK(gesture_zoom_end_cb), self);
GtkGesture* rotate = gtk_gesture_rotate_new(event_box);
g_signal_connect_swapped(rotate, "begin",
G_CALLBACK(gesture_rotation_begin_cb), self);
g_signal_connect_swapped(rotate, "angle-changed",
G_CALLBACK(gesture_rotation_update_cb), self);
g_signal_connect_swapped(rotate, "end", G_CALLBACK(gesture_rotation_end_cb),
self);
g_signal_connect_swapped(event_box, "touch-event", G_CALLBACK(touch_event_cb),
self);

self->gl_area = GTK_GL_AREA(gtk_gl_area_new());
gtk_gl_area_set_has_alpha(self->gl_area, TRUE);
gtk_widget_show(GTK_WIDGET(self->gl_area));
gtk_container_add(GTK_CONTAINER(event_box), GTK_WIDGET(self->gl_area));
g_signal_connect_swapped(self->gl_area, "render", G_CALLBACK(render_cb),
self);
```

----------------------------------------

TITLE: Send Message via BasicMessageChannel
DESCRIPTION: Documentation for the `Send` method overloads of `flutter::BasicMessageChannel`, including their C++ implementations and API definitions. These methods facilitate sending messages through the channel, with one overload supporting a reply callback.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_basic_message_channel

LANGUAGE: C++
CODE:
```
{
std::unique_ptr<std::vector<uint8_t>> raw_message =
codec_->EncodeMessage(message);
messenger_->Send(name_, raw_message->data(), raw_message->size());
}
```

LANGUAGE: C++
CODE:
```
{
std::unique_ptr<std::vector<uint8_t>> raw_message =
codec_->EncodeMessage(message);
messenger_->Send(name_, raw_message->data(), raw_message->size(),
std::move(reply));
}
```

LANGUAGE: APIDOC
CODE:
```
flutter::BasicMessageChannel<T>::Send(const T &message)
  Description: Sends a message through the channel without expecting a reply.
  Parameters:
    message: const T& - The message to send, encoded by the channel's codec.
  Returns: void

flutter::BasicMessageChannel<T>::Send(const T &message, BinaryReply reply)
  Description: Sends a message through the channel and provides a callback for a reply.
  Parameters:
    message: const T& - The message to send, encoded by the channel's codec.
    reply: BinaryReply - A callback function to handle the reply from the recipient.
  Returns: void
```

----------------------------------------

TITLE: FlutterBasicMessageChannel Class Definition
DESCRIPTION: Defines the `FlutterBasicMessageChannel` interface, a fundamental component for basic message communication between Flutter and platform code.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channel_key_responder_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterBasicMessageChannel:
  Definition: FlutterChannels.h:38
```

----------------------------------------

TITLE: API Documentation for SystemChannel Class
DESCRIPTION: Detailed API specification for the SystemChannel class, including its package, inheritance, fields, constructors, and methods. This class is part of the Flutter embedding engine and facilitates system-level communication.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/SystemChannel

LANGUAGE: APIDOC
CODE:
```
Class SystemChannel
  Package: io.flutter.embedding.engine.systemchannels
  Extends: java.lang.Object

  Fields:
    channel: final BasicMessageChannel<Object>

  Constructors:
    SystemChannel(dartExecutor: DartExecutor)

  Methods:
    sendMemoryPressureWarning(): void
```

----------------------------------------

TITLE: FlutterMessageHandler Strategy Definition
DESCRIPTION: Defines a strategy for handling incoming method calls from Flutter. It provides the method call details and a callback to asynchronously submit the result. The callback can be invoked with `FlutterError` for failure, `FlutterMethodNotImplemented` for unknown methods, or any other value (including `nil`) for success. This callback can be invoked from any thread.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h_source

LANGUAGE: Objective-C
CODE:
```
FlutterMessageHandler:
  - (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
    call: The incoming method call.
    result: A callback to asynchronously submit the result of the call.
            Invoke with FlutterError for failure.
            Invoke with FlutterMethodNotImplemented for unknown methods.
            Any other values (including nil) are successful results.
            Can be invoked from any thread.
```

----------------------------------------

TITLE: Asynchronously Send Message on FlBasicMessageChannel
DESCRIPTION: Initiates an asynchronous send operation for a message from the C side to the Dart side of the channel. The message must be compatible with the channel's FlMessageCodec. A GCancellable can be provided, and a GAsyncReadyCallback can be set to handle the response asynchronously.
SOURCE: https://api.flutter.dev/linux-embedder/fl__basic__message__channel_8h_source

LANGUAGE: C
CODE:
```
void fl_basic_message_channel_send(FlBasicMessageChannel* channel,
FlValue* message,
GCancellable* cancellable,
GAsyncReadyCallback callback,
gpointer user_data);
```

LANGUAGE: APIDOC
CODE:
```
fl_basic_message_channel_send:
  @channel: an #FlBasicMessageChannel.
  @message: (allow-none): message to send, must match what the #FlMessageCodec supports.
  @cancellable: (allow-none): a #GCancellable or %NULL.
  @callback: (scope async): (allow-none): a #GAsyncReadyCallback to call when the request is satisfied or %NULL to ignore the response.
  @user_data: (closure): user data to pass to @callback.
```

----------------------------------------

TITLE: File System Core Interfaces
DESCRIPTION: Documents the 'file' module, defining the abstract FileSystem interface and related types.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Package: file
Module: file
Description: Core interfaces containing the abstract FileSystem interface definition and all associated types used by FileSystem.
```

----------------------------------------

TITLE: FlutterBinaryMessenger Protocol API Reference
DESCRIPTION: This snippet provides a detailed reference for the FlutterBinaryMessenger protocol, outlining its methods for handling binary messages, managing connections, and setting message handlers on specific channels within the Flutter iOS embedder. It is crucial for implementing custom platform channels.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_binary_messenger-p-members

LANGUAGE: APIDOC
CODE:
```
protocol FlutterBinaryMessenger {
  // Cleans up a connection.
  - (void)cleanUpConnection:(id)connection;

  // Creates a background task queue.
  - (id)makeBackgroundTaskQueue;

  // Sends a binary message on a specified channel.
  - (void)sendOnChannel:(NSString *)channel message:(NSData *)message;

  // Sends a binary message on a specified channel and expects a binary reply.
  - (void)sendOnChannel:(NSString *)channel message:(NSData *)message binaryReply:(FlutterBinaryReply)callback;

  // Sets a binary message handler for a specified channel.
  - (void)setMessageHandlerOnChannel:(NSString *)channel binaryMessageHandler:(FlutterBinaryMessageHandler)handler;

  // Sets a binary message handler for a specified channel with a specific task queue.
  - (void)setMessageHandlerOnChannel:(NSString *)channel binaryMessageHandler:(FlutterBinaryMessageHandler)handler taskQueue:(dispatch_queue_t)taskQueue;
}
```

----------------------------------------

TITLE: Flutter EventSink Class Template API Reference
DESCRIPTION: Comprehensive API documentation for the `flutter::EventSink` class template, detailing its constructors, destructors, public methods for event handling, and protected pure virtual methods for internal implementation.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_event_sink

LANGUAGE: APIDOC
CODE:
```
flutter::EventSink< T > Class Template Reference abstract
#include <event_sink.h>

template<typename T = EncodableValue>
class flutter::EventSink< T >

Public Member Functions:
  EventSink() = default
  virtual ~EventSink() = default
  EventSink(EventSink const &) = delete
  EventSink & operator=(EventSink const &) = delete
  void Success(const T &event)
  void Success()
  void Error(const std::string &error_code, const std::string &error_message, const T &error_details)
  void Error(const std::string &error_code, const std::string &error_message="")
  void EndOfStream()

Protected Member Functions:
  virtual void SuccessInternal(const T *event=nullptr) = 0
  virtual void ErrorInternal(const std::string &error_code, const std::string &error_message, const T *error_details) = 0
  virtual void EndOfStreamInternal() = 0

Detailed Documentation:

Constructor & Destructor Documentation:
  EventSink() [1/2]
    template<typename T = EncodableValue>
    flutter::EventSink< T >::EventSink() default

  ~EventSink()
    template<typename T = EncodableValue>
    virtual flutter::EventSink< T >::~EventSink() virtualdefault

  EventSink() [2/2] (Deleted Copy Constructor)
    template<typename T = EncodableValue>
    flutter::EventSink< T >::EventSink(EventSink< T > const &) delete

Member Function Documentation:
  EndOfStream()
    template<typename T = EncodableValue>
    void flutter::EventSink< T >::EndOfStream() inline
    Definition at line 45 of file event_sink.h.
    Code: { EndOfStreamInternal(); }
    References flutter::EventSink< T >::EndOfStreamInternal().

  EndOfStreamInternal()
    template<typename T = EncodableValue>
    virtual void flutter::EventSink< T >::EndOfStreamInternal() protected pure virtual
    Referenced by flutter::EventSink< T >::EndOfStream().
```

----------------------------------------

TITLE: Objective-C: FlutterPlugin-p handleMethodCall:result:
DESCRIPTION: Defines the required method for a Flutter plugin to handle incoming method calls from the Flutter side. It receives a FlutterMethodCall object containing the method name and arguments, and a FlutterResult block to respond back to Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_menu_plugin_test_8mm_source

LANGUAGE: Objective-C
CODE:
```
void handleMethodCall:result:(FlutterMethodCall *call,[result] FlutterResult result)
```

----------------------------------------

TITLE: flutter::BinaryMessenger Class API
DESCRIPTION: API documentation for the `BinaryMessenger` abstract class, which provides the fundamental interface for sending and receiving binary messages between Flutter and the host platform. It defines pure virtual methods for sending raw binary data and setting binary message handlers.
SOURCE: https://api.flutter.dev/ios-embedder/basic__message__channel_8h_source

LANGUAGE: C++
CODE:
```
virtual void Send(const std::string &channel, const uint8_t *message, size_t message_size, BinaryReply reply=nullptr) const =0
```

LANGUAGE: C++
CODE:
```
virtual void SetMessageHandler(const std::string &channel, BinaryMessageHandler handler)=0
```

----------------------------------------

TITLE: withCachedEngine Method
DESCRIPTION: Returns a FlutterFragment.CachedEngineFragmentBuilder to create a FlutterFragment with a cached FlutterEngine in FlutterEngineCache. This promotes engine reuse.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: APIDOC
CODE:
```
static FlutterFragment.CachedEngineFragmentBuilder withCachedEngine(String engineId)
  engineId: The ID of the cached engine to use.
```

----------------------------------------

TITLE: API: Set Flutter Method Channel Handler
DESCRIPTION: Sets a method call handler for the channel. This handler will process incoming method calls on the associated Flutter MethodChannel.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/BackGestureChannel

LANGUAGE: APIDOC
CODE:
```
public void setMethodCallHandler(@Nullable MethodChannel.MethodCallHandler handler)

Parameters:
  handler - The handler to set for the channel.
```

----------------------------------------

TITLE: Dart Core Library: dart:async
DESCRIPTION: Provides support for asynchronous programming, with classes such as Future and Stream.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Library: dart:async
Description: Support for asynchronous programming, with classes such as Future and Stream.
```

----------------------------------------

TITLE: FlutterMethodChannel Class API Reference
DESCRIPTION: API documentation for the FlutterMethodChannel class, used for invoking methods on the platform side from Flutter and vice versa. It facilitates communication between Flutter and native code.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_restoration_plugin_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel
```

----------------------------------------

TITLE: Respond to Method Call (C API)
DESCRIPTION: Responds to a method call with a generic FlMethodResponse. This is the fundamental way to send a result back to Flutter, whether it's a success, error, or not implemented response.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__call_8h_source

LANGUAGE: APIDOC
CODE:
```
fl_method_call_respond:
  @method_call: an #FlMethodCall.
  @response: an #FlMethodResponse.
  @error: (allow-none): #GError location to store the error occurring, or %NULL to ignore.
  Responds to a method call.
  Returns: %TRUE on success.

gboolean fl_method_call_respond(FlMethodCall* method_call,
  FlMethodResponse* response,
  GError** error);
```

----------------------------------------

TITLE: createSurfaceTexture Method
DESCRIPTION: Creates and registers a `SurfaceTexture` managed by the Flutter engine. This method returns a `SurfaceTextureEntry`.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/view/TextureRegistry

LANGUAGE: APIDOC
CODE:
```
@NonNull
TextureRegistry.SurfaceTextureEntry createSurfaceTexture()

Returns:
  A SurfaceTextureEntry.
```

----------------------------------------

TITLE: Get Dart Entrypoint Function Name
DESCRIPTION: Retrieves the name of the Dart entrypoint function to be executed when the Dart snapshot loads. This can be configured via an `Intent` extra or a `<meta-data>` tag in the Android manifest. The `Intent` preference takes priority if both are set. Subclasses can override this method for direct control.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
getDartEntrypointFunctionName(): String @NonNull
  Purpose: Specifies the Dart entrypoint function name.
  Control: 
    1. Intent (FlutterActivityLaunchConfigs.EXTRA_DART_ENTRYPOINT)
    2. Android Manifest (<meta-data> FlutterActivityLaunchConfigs.DART_ENTRYPOINT_META_DATA_KEY)
  Priority: Intent preference takes priority.
  Override: Subclasses can override.
```

----------------------------------------

TITLE: Send Binary Message to Flutter Desktop with Reply Callback
DESCRIPTION: Sends a binary message to the Flutter side on the specified channel and registers a callback to be executed when a response is received. This function is used for request-response communication.
SOURCE: https://api.flutter.dev/linux-embedder/flutter__messenger_8h_source

LANGUAGE: C
CODE:
```
FLUTTER_EXPORT bool FlutterDesktopMessengerSendWithReply(
    FlutterDesktopMessengerRef messenger,
    const char* channel,
    const uint8_t* message,
    const size_t message_size,
    const FlutterDesktopBinaryReply reply);
```

----------------------------------------

TITLE: FlutterMethodChannel Interface API Reference
DESCRIPTION: Documents the `FlutterMethodChannel` interface, a communication channel for invoking methods and receiving results between Flutter and the host platform, supporting method call handlers and custom codecs.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel Interface
  Instance Methods:
    setMethodCallHandler:(FlutterMethodCallHandler _Nullable handler): void
  Class Methods:
    methodChannelWithName:binaryMessenger:codec:(NSString *name, NSObject< FlutterBinaryMessenger > *messenger, NSObject< FlutterMethodCodec > *codec): instancetype
```

----------------------------------------

TITLE: Clipboard Class
DESCRIPTION: Provides static utility methods for reading from and writing to the system clipboard.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
Clipboard:
  Utility methods for interacting with the system's clipboard.
```

----------------------------------------

TITLE: Navigator.maybeOf API Reference (Flutter)
DESCRIPTION: Retrieves the state from the closest instance of the `Navigator` class that encloses the given context, if one exists. This method provides a safe way to access the navigator state without throwing an error if no navigator is found.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
maybeOf(BuildContext context, {bool rootNavigator = false}) -> NavigatorState?
  Description: The state from the closest instance of this class that encloses the given context, if any.
```

----------------------------------------

TITLE: Invoke Method on Channel (No Result)
DESCRIPTION: Invokes a method on this channel, expecting no result. This is suitable for fire-and-forget operations where no return value or callback is needed.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodChannel

LANGUAGE: Java
CODE:
```
public void invokeMethod(@NonNull String method, @Nullable Object arguments)

Invokes a method on this channel, expecting no result.

Parameters:
  method: the name String of the method.
  arguments: the arguments for the invocation, possibly null.
```

----------------------------------------

TITLE: API Documentation for DeferredComponentChannel Class
DESCRIPTION: Detailed API reference for the `DeferredComponentChannel` class, including its constructor and methods for managing deferred component installations in Flutter's embedding engine. It outlines how to handle installation success/failure and set the component manager.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/DeferredComponentChannel

LANGUAGE: APIDOC
CODE:
```
Class: DeferredComponentChannel
  Package: io.flutter.embedding.engine.systemchannels
  Extends: java.lang.Object
  Description: Method channel that handles manual installation requests and queries for installation state for deferred components. This channel is able to handle multiple simultaneous installation requests.

  Constructors:
    DeferredComponentChannel(DartExecutor dartExecutor)
      Description: Constructs a "DeferredComponentChannel" that connects Android to the Dart code running in "dartExecutor". The given "dartExecutor" is permitted to be idle or executing code.
      Parameters:
        dartExecutor: DartExecutor - The DartExecutor to connect to.

  Methods:
    completeInstallError(String componentName, String errorMessage): void
      Description: Finishes the "installDeferredComponent" method channel call for the specified componentName with an error/failure.
      Parameters:
        componentName: String - The name of the android deferred component install request to complete.
        errorMessage: String - The error message.

    completeInstallSuccess(String componentName): void
      Description: Finishes the "installDeferredComponent" method channel call for the specified componentName with a success.
      Parameters:
        componentName: String - The name of the android deferred component install request to complete.

    setDeferredComponentManager(io.flutter.embedding.engine.deferredcomponents.DeferredComponentManager deferredComponentManager): void
      Description: Sets the DeferredComponentManager to execute method channel calls with.
      Parameters:
        deferredComponentManager: io.flutter.embedding.engine.deferredcomponents.DeferredComponentManager - The DeferredComponentManager to use.

  Methods inherited from class java.lang.Object:
    clone(), equals(Object), finalize(), getClass(), hashCode(), notify(), notifyAll(), toString(), wait(), wait(long), wait(long, int)
```

----------------------------------------

TITLE: APIDOC: FlutterViewController Class
DESCRIPTION: API documentation for the FlutterViewController class, which is an iOS UIViewController subclass that hosts a Flutter view.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_plugin_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterViewController:
  Definition: interface_flutter_view_controller.html
  Source: FlutterViewController.h:57
```

----------------------------------------

TITLE: BasicMessageChannel<T> Class API Reference
DESCRIPTION: Detailed API documentation for the `BasicMessageChannel<T>` class, including its constructors, properties, and methods for inter-platform communication.
SOURCE: https://api.flutter.dev/flutter/services/BasicMessageChannel-class

LANGUAGE: APIDOC
CODE:
```
BasicMessageChannel<T> class
  Description: A named channel for communicating with platform plugins using asynchronous message passing.
  Constructors:
    BasicMessageChannel(String name, MessageCodec<T> codec, {BinaryMessenger? binaryMessenger})
      Description: Creates a BasicMessageChannel with the specified name, codec and binaryMessenger.
  Properties:
    binaryMessenger: BinaryMessenger
      Description: The messenger which sends the bytes for this channel.
    codec: MessageCodec<T>
      Description: The message codec used by this channel, not null.
    hashCode: int (inherited)
      Description: The hash code for this object.
    name: String
      Description: The logical channel on which communication happens, not null.
    runtimeType: Type (inherited)
      Description: A representation of the runtime type of the object.
  Methods:
    checkMockMessageHandler(Object? handler): bool
      Description: Available on BasicMessageChannel<T>, provided by the TestBasicMessageChannelExtension extension. Shim for TestDefaultBinaryMessenger.checkMockMessageHandler.
    noSuchMethod(Invocation invocation): dynamic (inherited)
      Description: Invoked when a nonexistent method or property is accessed.
    send(T message): Future<T?>
      Description: Sends the specified message to the platform plugins on this channel.
    setMessageHandler(Future<T> handler(T? message)?): void
      Description: Sets a callback for receiving messages from the platform plugins on this channel. Messages may be null.
    setMockMessageHandler(Future<T> handler(T? message)?): void
      Description: Available on BasicMessageChannel<T>, provided by the TestBasicMessageChannelExtension extension. Shim for TestDefaultBinaryMessenger.setMockDecodedMessageHandler.
    toString(): String (inherited)
      Description: A string representation of this object.
```

----------------------------------------

TITLE: Set Message Handler with flutter::BinaryMessenger
DESCRIPTION: The `SetMessageHandler` method is a pure virtual function in `flutter::BinaryMessenger` that registers a callback to handle incoming binary messages on a specific channel. This allows the platform side to receive messages from the Flutter engine.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_binary_messenger

LANGUAGE: APIDOC
CODE:
```
virtual void flutter::BinaryMessenger::SetMessageHandler(
  const std::string &channel,      // The name of the channel to listen for messages on.
  BinaryMessageHandler handler      // The callback function to handle incoming messages.
) = 0;
```

----------------------------------------

TITLE: C++ Flutter Messenger Send Method Definition
DESCRIPTION: Defines the `Send` method, likely part of a messenger interface, for sending binary messages over a channel with a reply callback. This method is an override, indicating it implements an interface.
SOURCE: https://api.flutter.dev/ios-embedder/binary__messenger__impl_8h_source

LANGUAGE: C++
CODE:
```
void Send(const std::string &channel, const uint8_t *message, size_t message_size, BinaryReply reply) const override
```

----------------------------------------

TITLE: SystemChromeStyle Constructor
DESCRIPTION: Initializes a new instance of the SystemChromeStyle class. This constructor allows setting the colors and icon brightness for the status and navigation bars, along with contrast enforcement options.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/PlatformChannel.SystemChromeStyle

LANGUAGE: APIDOC
CODE:
```
Constructor:
  SystemChromeStyle(
    statusBarColor: @Nullable Integer,
    statusBarIconBrightness: @Nullable PlatformChannel.Brightness,
    systemStatusBarContrastEnforced: @Nullable Boolean,
    systemNavigationBarColor: @Nullable Integer,
    systemNavigationBarIconBrightness: @Nullable PlatformChannel.Brightness,
    systemNavigationBarDividerColor: @Nullable Integer,
    systemNavigationBarContrastEnforced: @Nullable Boolean
  )
```

----------------------------------------

TITLE: Navigator.popAndPushNamed API Reference (Flutter)
DESCRIPTION: Pops the current route off the navigator and then pushes a named route in its place. This is useful for replacing the current screen with a new one without adding it to the back stack.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
popAndPushNamed<T extends Object?, TO extends Object?>(BuildContext context, String routeName, {TO? result, Object? arguments}) -> Future<T?>
  Description: Pop the current route off the navigator that most tightly encloses the given context and push a named route in its place.
```

----------------------------------------

TITLE: Send Message to Flutter Side (Asynchronous Reply Expected)
DESCRIPTION: Sends a message from the native side to the Flutter side, expecting an asynchronous reply. A callback is provided to handle the reply received from Flutter. The message must be compatible with the channel's configured codec.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h_source

LANGUAGE: Objective-C
CODE:
```
- (void)sendMessage:(id _Nullable)message reply:(FlutterReply _Nullable)callback;

Parameters:
  message: The message. Must be supported by the codec of this channel.
  callback: A callback to be invoked with the message reply from Flutter.
```

----------------------------------------

TITLE: APIDOC: Flutter Core Channel Classes and Methods
DESCRIPTION: Detailed API documentation for key Flutter C++ classes and methods involved in platform channel communication, including `BinaryMessenger`, `MethodCall`, and `MethodChannel`, with their definitions and method signatures.
SOURCE: https://api.flutter.dev/macos-embedder/method__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger
  Definition: binary_messenger.h:28

flutter::BinaryMessenger::Send
  virtual void Send(const std::string &channel, const uint8_t *message, size_t message_size, BinaryReply reply=nullptr) const =0

flutter::BinaryMessenger::SetMessageHandler
  virtual void SetMessageHandler(const std::string &channel, BinaryMessageHandler handler)=0

flutter::MethodCall
  Definition: method_call.h:18

flutter::MethodChannel
  Definition: method_channel.h:34

flutter::MethodChannel::SetMethodCallHandler
```

----------------------------------------

TITLE: FlutterPlugin Interface Definition and Lifecycle Methods
DESCRIPTION: Defines the `FlutterPlugin` interface and its core lifecycle methods, `onAttachedToEngine` and `onDetachedFromEngine`, which manage the plugin's interaction with a `FlutterEngine` and provide access to platform resources via `FlutterPluginBinding`.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin

LANGUAGE: APIDOC
CODE:
```
public interface FlutterPlugin

  Methods:
    onAttachedToEngine(binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding)
      Description: Called when the plugin is added to a FlutterEngine.
      Parameters:
        binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding - Provides access to FlutterEngine resources like application Context and BinaryMessenger.
      Return: void

    onDetachedFromEngine(binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding)
      Description: Called when the plugin is removed from a FlutterEngine or the FlutterEngine is destroyed.
      Parameters:
        binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding - The binding that was provided in onAttachedToEngine.
      Return: void
      Note: The binding is no longer valid after this call.
```

----------------------------------------

TITLE: Flutter: Pushing a New Route with MaterialPageRoute
DESCRIPTION: This example shows how to push a new full-screen route onto the navigation stack using `Navigator.push` and `MaterialPageRoute`. The `builder` function defines the widget tree for the new route, which includes an AppBar and a TextButton to pop the route.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
Navigator.push(context, MaterialPageRoute<void>(
  builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: Center(
        child: TextButton(
          child: const Text('POP'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  },
));
```

----------------------------------------

TITLE: Navigator.popUntil API Reference (Flutter)
DESCRIPTION: Repeatedly calls `pop` on the navigator that most tightly encloses the given context until the provided predicate returns true. This allows for popping multiple routes at once until a specific condition is met.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
popUntil(BuildContext context, RoutePredicate predicate) -> void
  Description: Calls pop repeatedly on the navigator that most tightly encloses the given context until the predicate returns true.
```

----------------------------------------

TITLE: <FlutterBinaryMessenger> API Reference
DESCRIPTION: API definition for <FlutterBinaryMessenger> (Protocol).
SOURCE: https://api.flutter.dev/macos-embedder/annotated

LANGUAGE: APIDOC
CODE:
```
Protocol: <FlutterBinaryMessenger>
```

----------------------------------------

TITLE: Flutter MessageCodec Class Template API Reference
DESCRIPTION: Comprehensive API documentation for the `flutter::MessageCodec<T>` class template, outlining its constructors, destructors, public and protected methods for message serialization and deserialization. This abstract class serves as a base for concrete message codec implementations.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_message_codec

LANGUAGE: APIDOC
CODE:
```
class flutter::MessageCodec< T > (abstract)
  #include <message_codec.h>

  // Public Member Functions
  MessageCodec() = default
  virtual ~MessageCodec() = default
  MessageCodec(MessageCodec< T > const &) = delete
  operator=(MessageCodec< T > const &) = delete
  std::unique_ptr< T > DecodeMessage(const uint8_t *binary_message, const size_t message_size) const
  std::unique_ptr< T > DecodeMessage(const std::vector< uint8_t > &binary_message) const
  std::unique_ptr< std::vector< uint8_t > > EncodeMessage(const T &message) const

  // Protected Member Functions
  virtual std::unique_ptr< T > DecodeMessageInternal(const uint8_t *binary_message, const size_t message_size) const = 0
  virtual std::unique_ptr< std::vector< uint8_t > > EncodeMessageInternal(const T &message) const = 0

Detailed Description:
  template<typename T> class flutter::MessageCodec< T >
  Defined in message_codec.h at line 17.

Constructor & Destructor Documentation:
  MessageCodec() [1/2]
    template<typename T > flutter::MessageCodec< T >::MessageCodec ( ) default

  ~MessageCodec()
    template<typename T > virtual flutter::MessageCodec< T >::~MessageCodec ( ) virtualdefault

  MessageCodec() [2/2]
    template<typename T > flutter::MessageCodec< T >::MessageCodec ( MessageCodec< T > const & ) delete
```

----------------------------------------

TITLE: PlatformView Interface API Reference
DESCRIPTION: Comprehensive API documentation for the `PlatformView` interface, including its definition, method summaries, and detailed descriptions of each method's purpose, parameters, and behavior within the Flutter Android embedding context.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformView

LANGUAGE: APIDOC
CODE:
```
Interface: PlatformView
  public interface PlatformView
  Description: A handle to an Android view to be embedded in the Flutter hierarchy.

  Methods Summary:
    - void dispose()
      Description: Dispose this platform view.
    - View getView()
      Description: Returns the Android view to be embedded in the Flutter hierarchy.
    - default void onFlutterViewAttached(View flutterView)
      Description: Called by the FlutterEngine that owns this PlatformView when the Android View responsible for rendering a Flutter UI is associated with the FlutterEngine.
    - default void onFlutterViewDetached()
      Description: Called by the FlutterEngine that owns this PlatformView when the Android View responsible for rendering a Flutter UI is detached and disassociated from the FlutterEngine.
    - default void onInputConnectionLocked()
      Description: Callback fired when the platform's input connection is locked, or should be used.
    - default void onInputConnectionUnlocked()
      Description: Callback fired when the platform input connection has been unlocked.

  Method Details:
    - getView()
      Signature: @Nullable View getView()
      Description: Returns the Android view to be embedded in the Flutter hierarchy.

    - onFlutterViewAttached(flutterView: View)
      Signature: default void onFlutterViewAttached(@NonNull View flutterView)
      Description: Called by the FlutterEngine that owns this PlatformView when the Android View responsible for rendering a Flutter UI is associated with the FlutterEngine. This means that our associated FlutterEngine can now render a UI and interact with the user. Some platform views may have unusual dependencies on the View that renders Flutter UIs, such as unique keyboard interactions. That View is provided here for those purposes. Use of this View should be avoided if it is not absolutely necessary, because depending on this View will tend to make platform view code more brittle to future changes.
      Parameters:
        - flutterView: View (NonNull) - The Android View responsible for rendering a Flutter UI.

    - onFlutterViewDetached()
      Signature: default void onFlutterViewDetached()
      Description: Called by the FlutterEngine that owns this PlatformView when the Android View responsible for rendering a Flutter UI is detached and disassociated from the FlutterEngine. This means that our associated FlutterEngine no longer has a rendering surface, or a user interaction surface of any kind. This platform view must release any references related to the Android View that was provided in onFlutterViewAttached(View).

    - dispose()
      Signature: void dispose()
      Description: Dispose this platform view.
```

----------------------------------------

TITLE: APIDOC: flutter::MethodChannel<T> Class Reference
DESCRIPTION: Comprehensive API documentation for the `flutter::MethodChannel` class template, detailing its constructors, operators, and public methods for inter-platform communication in Flutter. This class facilitates sending and receiving method calls between the Flutter engine and the host platform.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_method_channel

LANGUAGE: APIDOC
CODE:
```
flutter::MethodChannel< T > Class Template Reference

Template Parameter: T = EncodableValue
Include: #include <method_channel.h>

Public Member Functions:
  MethodChannel(BinaryMessenger *messenger, const std::string &name, const MethodCodec< T > *codec)
    Description: Constructor for MethodChannel. Initializes the channel with a messenger, a name, and a codec.
    Parameters:
      messenger: Pointer to a BinaryMessenger instance used for sending and receiving binary messages.
      name: The unique name of this channel as a string.
      codec: Pointer to a MethodCodec instance used for encoding and decoding method calls and results.
    Initialization: messenger_(messenger), name_(name), codec_(codec)

  ~MethodChannel()
    Description: Default destructor for MethodChannel. Cleans up resources associated with the channel.

  MethodChannel(MethodChannel const &)
    Description: Deleted copy constructor. This prevents copying of MethodChannel objects, ensuring unique channel instances.

  MethodChannel& operator=(MethodChannel const &)
    Description: Deleted assignment operator. This prevents assignment of MethodChannel objects, maintaining unique channel instances.

  void InvokeMethod(const std::string &method, std::unique_ptr< T > arguments, std::unique_ptr< MethodResult< T >> result=nullptr)
    Description: Invokes a method on the channel with specified arguments and an optional result handler.
    Parameters:
      method: The name of the method to invoke.
      arguments: A unique pointer to the arguments for the method call. The type T must be encodable by the channel's codec.
      result: An optional unique pointer to a MethodResult to handle the method call result. Defaults to nullptr if no result handling is needed.

  void SetMethodCallHandler(MethodCallHandler< T > handler) const
    Description: Sets a method call handler for the channel. This handler will be invoked when a method call is received from the Flutter engine.
    Parameters:
      handler: The handler function to be called when a method is invoked on this channel.

  void Resize(int new_size)
    Description: Resizes an internal component or buffer associated with the channel. The exact purpose depends on the internal implementation.
    Parameters:
      new_size: The new size as an integer.

  void SetWarnsOnOverflow(bool warns)
    Description: Configures whether the channel should issue warnings if internal buffers or queues overflow.
    Parameters:
      warns: Boolean value; true to enable warnings on overflow, false to disable them.
```

----------------------------------------

TITLE: PlatformChannel Method: setPlatformMessageHandler(PlatformMessageHandler)
DESCRIPTION: Sets the PlatformChannel.PlatformMessageHandler responsible for receiving all events and requests parsed from the underlying platform channel. This method allows custom handling of messages from the platform.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/PlatformChannel

LANGUAGE: APIDOC
CODE:
```
public void setPlatformMessageHandler(@Nullable
PlatformChannel.PlatformMessageHandler platformMessageHandler)
```

----------------------------------------

TITLE: Navigator Property: onGenerateRoute
DESCRIPTION: Documents the 'onGenerateRoute' factory, which is called to generate a route for a given RouteSettings.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
Property: onGenerateRoute
Type: RouteFactory?
Description: Called to generate a route for a given RouteSettings.
Modifiers: final
```

----------------------------------------

TITLE: Flutter TextRange Class API Reference
DESCRIPTION: API documentation for the `flutter::TextRange` class, which represents a range of text. It defines properties like start, end, base, and extent, and methods to query the range's characteristics such as its length or if it's collapsed.
SOURCE: https://api.flutter.dev/ios-embedder/text__input__model_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::TextRange {
  // Methods
  void set_end(size_t pos);
  size_t position() const;
  size_t start() const;
  size_t base() const;
  bool collapsed() const;
  size_t length() const;
  size_t extent() const;
  size_t end() const;
}
```

----------------------------------------

TITLE: Android View Class Callback Methods Reference
DESCRIPTION: This section provides a reference to various callback methods of the `android.view.View` class, which are crucial for customizing UI behavior, responding to user interactions, and integrating with system features like accessibility and autofill. Each entry lists the method signature as found in the official Android documentation.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/mutatorsstack/FlutterMutatorView

LANGUAGE: APIDOC
CODE:
```
android.view.View methods:
  onCreateViewTranslationRequest(int[], java.util.function.Consumer)
  onCreateVirtualViewTranslationRequests(long[], int[], java.util.function.Consumer)
  onDisplayHint(int)
  onDragEvent(android.view.DragEvent)
  onDraw(android.graphics.Canvas)
  onDrawForeground(android.graphics.Canvas)
  onDrawScrollBars(android.graphics.Canvas)
  onFilterTouchEventForSecurity(android.view.MotionEvent)
  onFinishInflate()
  onFinishTemporaryDetach()
  onFocusChanged(boolean, int, android.graphics.Rect)
  onGenericMotionEvent(android.view.MotionEvent)
  onHoverChanged(boolean)
  onHoverEvent(android.view.MotionEvent)
  onInitializeAccessibilityEvent(android.view.accessibility.AccessibilityEvent)
  onInitializeAccessibilityNodeInfo(android.view.accessibility.AccessibilityNodeInfo)
  onKeyDown(int, android.view.KeyEvent)
  onKeyLongPress(int, android.view.KeyEvent)
  onKeyMultiple(int, int, android.view.KeyEvent)
  onKeyPreIme(int, android.view.KeyEvent)
  onKeyShortcut(int, android.view.KeyEvent)
  onKeyUp(int, android.view.KeyEvent)
  onOverScrolled(int, int, boolean, boolean)
  onPointerCaptureChange(boolean)
  onPopulateAccessibilityEvent(android.view.accessibility.AccessibilityEvent)
  onProvideAutofillStructure(android.view.ViewStructure, int)
  onProvideAutofillVirtualStructure(android.view.ViewStructure, int)
  onProvideContentCaptureStructure(android.view.ViewStructure, int)
  onProvideStructure(android.view.ViewStructure)
  onProvideVirtualStructure(...)
```

----------------------------------------

TITLE: MethodChannel Constructors
DESCRIPTION: Provides various constructors for initializing a MethodChannel, allowing specification of the binary messenger, channel name, and optional method codec or task queue for handling method calls.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodChannel

LANGUAGE: APIDOC
CODE:
```
public MethodChannel(
  @NonNull io.flutter.plugin.common.BinaryMessenger messenger,
  @NonNull java.lang.String name
)
  messenger: io.flutter.plugin.common.BinaryMessenger - a BinaryMessenger.
  name: java.lang.String - a channel name String.

public MethodChannel(
  @NonNull io.flutter.plugin.common.BinaryMessenger messenger,
  @NonNull java.lang.String name,
  @NonNull io.flutter.plugin.common.MethodCodec codec
)
  messenger: io.flutter.plugin.common.BinaryMessenger - a BinaryMessenger.
  name: java.lang.String - a channel name String.
  codec: io.flutter.plugin.common.MethodCodec - a MessageCodec.

public MethodChannel(
  @NonNull io.flutter.plugin.common.BinaryMessenger messenger,
  @NonNull java.lang.String name,
  @NonNull io.flutter.plugin.common.MethodCodec codec,
  @Nullable io.flutter.plugin.common.BinaryMessenger.TaskQueue taskQueue
)
  messenger: io.flutter.plugin.common.BinaryMessenger - a BinaryMessenger.
  name: java.lang.String - a channel name String.
  codec: io.flutter.plugin.common.MethodCodec - a MessageCodec.
  taskQueue: io.flutter.plugin.common.BinaryMessenger.TaskQueue - a BinaryMessenger.TaskQueue that specifies what thread will execute the handler. Specifying null means execute on the platform thread. See also BinaryMessenger.makeBackgroundTaskQueue().
```

----------------------------------------

TITLE: Flutter Windows Core API Definitions
DESCRIPTION: Comprehensive API documentation for key Flutter Windows classes and their methods, including definitions and source file locations. Covers engine, view, lifecycle management, and testing utilities.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows__engine__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::AlertPlatformNodeDelegate
  Definition: alert_platform_node_delegate.h:18

flutter::FlutterEngine
  Definition: flutter_engine.h:28
  Run()
    Signature: bool Run()
    Definition: flutter_engine.cc:49

flutter::FlutterWindowsEngine
  Definition: flutter_windows_engine.h:90
  UpdateSemanticsEnabled(bool enabled)
    Signature: void UpdateSemanticsEnabled(bool enabled)
    Definition: flutter_windows_engine.cc:949
  CreateView(std::unique_ptr< FlutterWindowsView > window)
    Signature: std::unique_ptr< FlutterWindowsView > CreateView(std::unique_ptr< WindowBindingHandler > window)
    Definition: flutter_windows_engine.cc:512

flutter::FlutterWindowsView
  Definition: flutter_windows_view.h:34

flutter::WindowsLifecycleManager
  Definition: windows_lifecycle_manager.h:37
  Quit(std::optional< HWND > window, std::optional< WPARAM > wparam, std::optional< LPARAM > lparam, UINT exit_code)
    Signature: virtual void Quit(std::optional< HWND > window, std::optional< WPARAM > wparam, std::optional< LPARAM > lparam, UINT exit_code)
    Definition: windows_lifecycle_manager.cc:21
  BeginProcessingLifecycle()
    Signature: virtual void BeginProcessingLifecycle()
    Definition: windows_lifecycle_manager.cc:187
  DispatchMessage(HWND window, UINT msg, WPARAM wparam, LPARAM lparam)
    Signature: virtual void DispatchMessage(HWND window, UINT msg, WPARAM wparam, LPARAM lparam)
    Definition: windows_lifecycle_manager.cc:34
  IsLastWindowOfProcess()
    Signature: virtual bool IsLastWindowOfProcess()
    Definition: windows_lifecycle_manager.cc:164
  SetLifecycleState(AppLifecycleState state)
    Signature: virtual void SetLifecycleState(AppLifecycleState state)
    Definition: windows_lifecycle_manager.cc:195

flutter::testing::FlutterWindowsEngineTest
  Definition: flutter_windows_engine_unittests.cc:49

flutter::testing::MockFlutterWindowsView
  ~MockFlutterWindowsView()
    Signature: ~MockFlutterWindowsView()
    Definition: flutter_windows_engine_unittests.cc:657
  MOCK_METHOD(bool, Focus,(),(override))
    Signature: MOCK_METHOD(bool, Focus,(),(override))
  MOCK_METHOD(void, NotifyWinEventWrapper,(ui::AXPlatformNodeWin *, ax::mojom::Event),(override))
    Signature: MOCK_METHOD(void, NotifyWinEventWrapper,(ui::AXPlatformNodeWin *, ax::mojom::Event),(override))
```

----------------------------------------

TITLE: Release FlutterEngine control from Activity
DESCRIPTION: Irreversibly releases this activity's control of the FlutterEngine and its subcomponents. This disconnects the activity's view from the Flutter renderer, detaches from plugins' ActivityControlSurface, and stops system channel messages. The activity should be disposed immediately after calling this method.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
@VisibleForTesting
public void release()
```

----------------------------------------

TITLE: Flutter Android System Channels API Reference
DESCRIPTION: Detailed reference for classes and interfaces used in Flutter's Android embedding for system channel communication, including platform message handling, view management, UI overlays, and text processing.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/package-summary

LANGUAGE: APIDOC
CODE:
```
PlatformChannel.PlatformMessageHandler
  Type: interface
  Package: io.flutter.embedding.engine.systemchannels
  Description: Handler that receives platform messages sent from Flutter to Android through a given PlatformChannel.
```

LANGUAGE: APIDOC
CODE:
```
PlatformChannel.SoundType
  Type: enum
  Package: io.flutter.embedding.engine.systemchannels
  Description: Types of sounds the Android OS can play on behalf of an application.
```

LANGUAGE: APIDOC
CODE:
```
PlatformChannel.SystemChromeStyle
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: The color and brightness of system chrome, e.g., status bar and system navigation bar.
```

LANGUAGE: APIDOC
CODE:
```
PlatformChannel.SystemUiMode
  Type: enum
  Package: io.flutter.embedding.engine.systemchannels
  Description: The set of Android system fullscreen modes as perceived by the Flutter application.
```

LANGUAGE: APIDOC
CODE:
```
PlatformChannel.SystemUiOverlay
  Type: enum
  Package: io.flutter.embedding.engine.systemchannels
  Description: The set of Android system UI overlays as perceived by the Flutter application.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: System channel that sends 2-way communication between Flutter and Android to facilitate embedding
  of Android Views within a Flutter application.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewBufferResized
  Type: interface
  Package: io.flutter.embedding.engine.systemchannels
  Description: Allows to notify when a platform view buffer has been resized.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewBufferSize
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: The platform view buffer size.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewCreationRequest
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: Request sent from Flutter to create a new platform view.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode
  Type: enum
  Package: io.flutter.embedding.engine.systemchannels
  Description: Platform view display modes that can be requested at creation time.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewResizeRequest
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: Request sent from Flutter to resize a platform view.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewsHandler
  Type: interface
  Package: io.flutter.embedding.engine.systemchannels
  Description: Handler that receives platform view messages sent from Flutter to Android through a given
  PlatformViewsChannel.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel.PlatformViewTouch
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: The state of a touch event in Flutter within a platform view.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel2
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: System channel that sends 2-way communication between Flutter and Android to facilitate embedding
  of Android Views within a Flutter application.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel2.PlatformViewCreationRequest
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: Request sent from Flutter to create a new platform view.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel2.PlatformViewsHandler
  Type: interface
  Package: io.flutter.embedding.engine.systemchannels
  Description: Handler that receives platform view messages sent from Flutter to Android through a given
  PlatformViewsChannel.
```

LANGUAGE: APIDOC
CODE:
```
PlatformViewsChannel2.PlatformViewTouch
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: The state of a touch event in Flutter within a platform view.
```

LANGUAGE: APIDOC
CODE:
```
ProcessTextChannel
  Type: class
  Package: io.flutter.embedding.engine.systemchannels
  Description: ProcessTextChannel is a platform channel that is used by the framework to initiate text
  processing feature in the embedding and for the embedding to send back the results.
```

LANGUAGE: APIDOC
CODE:
```
ProcessTextChannel.ProcessTextMethodHandler
  Type: interface
  Package: io.flutter.embedding.engine.systemchannels
  Description: (No description provided)
```

LANGUAGE: APIDOC
CODE:
```
RestorationChannel
  Type: class
  Package: io.flutter.embedding.engine.
```

----------------------------------------

TITLE: FlutterMethodChannel Class API Reference
DESCRIPTION: Comprehensive API documentation for the FlutterMethodChannel class, which facilitates asynchronous method communication between Flutter and the native platform. It provides methods for creating channels and invoking Flutter methods.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel:
  Description: A channel for communicating with the Flutter side using invocation of asynchronous methods.
  Methods:
    + methodChannelWithName:binaryMessenger:
      Description: Creates a FlutterMethodChannel with the specified name and binary messenger.
      Parameters:
        name: The channel name.
        messenger: The binary messenger.
      Returns: instancetype
    + methodChannelWithName:binaryMessenger:codec:
      Description: Creates a FlutterMethodChannel with the specified name, binary messenger, and method codec.
      Parameters:
        name: The channel name.
        messenger: The binary messenger.
        codec: The method codec.
      Returns: instancetype
    - initWithName:binaryMessenger:codec:
      Description: Initializes a FlutterMethodChannel with the specified name, binary messenger, and method codec.
      Parameters:
        name: The channel name.
        messenger: The binary messenger.
        codec: The method codec.
      Returns: instancetype
    - initWithName:binaryMessenger:codec:taskQueue:
      Description: Initializes a FlutterMethodChannel with the specified name, binary messenger, method codec, and task queue.
      Parameters:
        name: The channel name.
        messenger: The binary messenger.
        codec: The method codec.
        taskQueue: The FlutterTaskQueue that executes the handler (see -[FlutterBinaryMessenger makeBackgroundTaskQueue]).
      Returns: instancetype
    - (Method Signature Not Provided)
      Description: Invokes the specified Flutter method with the specified arguments, expecting no results.
      Parameters:
        method: The name of the method to invoke.
      See Also: MethodChannel.setMethodCallHandler
```

----------------------------------------

TITLE: FlutterEngineGroupCache Class API Reference
DESCRIPTION: Detailed API specification for the `FlutterEngineGroupCache` class, including its inheritance and all public methods for managing cached `FlutterEngineGroup` instances. This class acts as a central repository for `FlutterEngineGroup` objects, identified by unique string IDs.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngineGroupCache

LANGUAGE: APIDOC
CODE:
```
Class: FlutterEngineGroupCache
  Extends: java.lang.Object
  Package: io.flutter.embedding.engine
  
  Description: Static singleton cache that holds FlutterEngineGroup instances identified by Strings. The ID of a given FlutterEngineGroup can be whatever String is desired. FlutterActivity and FlutterFragment use the FlutterEngineGroupCache singleton internally when instructed to use a cached FlutterEngineGroup based on a given ID.

  Methods:
    clear(): void
      Description: Removes all FlutterEngineGroup's that are currently in the cache.

    contains(String engineGroupId): boolean
      Description: Returns true if a FlutterEngineGroup in this cache is associated with the given engineGroupId.
      Parameters:
        engineGroupId: String - The ID of the engine group to check.

    get(String engineGroupId): FlutterEngineGroup
      Description: Returns the FlutterEngineGroup in this cache that is associated with the given engineGroupId, or null if no such FlutterEngineGroup exists.
      Parameters:
        engineGroupId: String - The ID of the engine group to retrieve.

    getInstance(): static FlutterEngineGroupCache
      Description: Returns the static singleton instance of FlutterEngineGroupCache.

    put(String engineGroupId, FlutterEngineGroup engineGroup): void
      Description: Places the given FlutterEngineGroup in this cache and associates it with the given engineGroupId.
      Parameters:
        engineGroupId: String - The ID to associate with the engine group.
        engineGroup: FlutterEngineGroup - The engine group to cache.

    remove(String engineGroupId): void
      Description: Removes any FlutterEngineGroup that is currently in the cache that is identified by the given engineGroupId.
      Parameters:
        engineGroupId: String - The ID of the engine group to remove.
```

----------------------------------------

TITLE: Respond to a Basic Message Channel Message (C/C++ API)
DESCRIPTION: Responds to a message received on a basic message channel. This function is used to send a reply back to the sender of the original message, typically after processing an incoming message.
SOURCE: https://api.flutter.dev/linux-embedder/fl__basic__message__channel_8cc_source

LANGUAGE: C
CODE:
```
G_MODULE_EXPORT gboolean fl_basic_message_channel_respond(FlBasicMessageChannel *self, FlBasicMessageChannelResponseHandle *response_handle, FlValue *message, GError **error)
```

----------------------------------------

TITLE: Replace Route Below Anchor with restorableReplaceRouteBelow (Flutter Navigator API)
DESCRIPTION: Replaces a route on the navigator that most tightly encloses the given context with a new route. The route to be replaced is the one below the given `anchorRoute`.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorableReplaceRouteBelow<T extends Object?>(
  context: BuildContext,
  {required anchorRoute: Route, required newRouteBuilder: RestorableRouteBuilder<T>, arguments: Object?}
) -> String
```

----------------------------------------

TITLE: Objective-C Extended FlutterStandardWriter for Custom Type Serialization
DESCRIPTION: Implements `ExtendedWriter`, a subclass of `FlutterStandardWriter`, to provide custom serialization logic for `NSDate` and `Pair` objects. The `writeValue:` method checks the type of the input `value`. For `NSDate`, it writes the `kDATE` identifier followed by the timestamp in milliseconds. For `Pair`, it writes `kPAIR` and then recursively serializes its `left` and `right` components. For other types, it defers to the superclass's implementation.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: Objective-C
CODE:
```
@interface ExtendedWriter : FlutterStandardWriter
- (void)writeValue:(id)value;
@end

@implementation ExtendedWriter
- (void)writeValue:(id)value {
 if ([value isKindOfClass:[NSDate class]]) {
 [self writeByte:kDATE];
 NSDate* date = value;
 NSTimeInterval time = date.timeIntervalSince1970;
 SInt64 ms = (SInt64)(time * 1000.0);
 [self writeBytes:&ms length:8];
 } else if ([value isKindOfClass:[Pair class]]) {
 Pair* pair = value;
 [self writeByte:kPAIR];
 [self writeValue:pair.left];
 [self writeValue:pair.right];
 } else {
 [super writeValue:value];
 }
}
@end
```

----------------------------------------

TITLE: Importing Core Flutter Framework Libraries
DESCRIPTION: Demonstrates the standard method for importing core Flutter framework libraries, such as `material.dart` and `services.dart`, using the `package:flutter/<library>.dart` syntax. These imports are fundamental for accessing Flutter's UI components and platform services.
SOURCE: https://api.flutter.dev/index

LANGUAGE: Dart
CODE:
```
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
```

----------------------------------------

TITLE: Android Activity Class Methods Reference
DESCRIPTION: A comprehensive list of methods available in the `android.app.Activity` class, detailing various ways to manage activity lifecycle, interactions, and UI.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragmentActivity

LANGUAGE: APIDOC
CODE:
```
android.app.Activity:
  showLockTaskEscapeMessage()
  startActionMode(android.view.ActionMode.Callback)
  startActionMode(android.view.ActionMode.Callback, int)
  startActivities(android.content.Intent[])
  startActivities(android.content.Intent[], android.os.Bundle)
  startActivity(android.content.Intent)
  startActivity(android.content.Intent, android.os.Bundle)
  startActivityFromChild(android.app.Activity, android.content.Intent, int)
  startActivityFromChild(android.app.Activity, android.content.Intent, int, android.os.Bundle)
  startActivityFromFragment(android.app.Fragment, android.content.Intent, int)
  startActivityFromFragment(android.app.Fragment, android.content.Intent, int, android.os.Bundle)
  startActivityIfNeeded(android.content.Intent, int)
  startActivityIfNeeded(android.content.Intent, int, android.os.Bundle)
  startIntentSender(android.content.IntentSender, android.content.Intent, int, int, int)
  startIntentSender(android.content.IntentSender, android.content.Intent, int, int, int, android.os.Bundle)
  startIntentSenderFromChild(android.app.Activity, android.content.IntentSender, int, android.content.Intent, int, int, int)
  startIntentSenderFromChild(android.app.Activity, android.content.IntentSender, int, android.content.Intent, int, int, int, android.os.Bundle)
  startLocalVoiceInteraction(android.os.Bundle)
  startLockTask()
  startManagingCursor(android.database.Cursor)
  startNextMatchingActivity(android.content.Intent)
  startNextMatchingActivity(android.content.Intent, android.os.Bundle)
  startPostponedEnterTransition()
  startSearch(java.lang.String, boolean, android.os.Bundle, boolean)
  stopLocalVoiceInteraction()
  stopLockTask()
  stopManagingCursor(android.database.Cursor)
```

----------------------------------------

TITLE: Flutter Binary Messenger C++ Header
DESCRIPTION: This C++ header file defines the core interfaces for binary messaging in the Flutter client wrapper. It includes typedefs for `BinaryReply` and `BinaryMessageHandler` callbacks, and the abstract `BinaryMessenger` class with methods for sending messages and setting message handlers.
SOURCE: https://api.flutter.dev/macos-embedder/binary__messenger_8h_source

LANGUAGE: cpp
CODE:
```
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_BINARY_MESSENGER_H_
#define FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_BINARY_MESSENGER_H_

#include <functional>
#include <string>

namespace flutter {

// A binary message reply callback.
//
// Used for submitting a binary reply back to a Flutter message sender.
typedef std::function<void(const uint8_t* reply, size_t reply_size)>
  BinaryReply;

// A message handler callback.
//
// Used for receiving messages from Flutter and providing an asynchronous reply.
typedef std::function<
  void(const uint8_t* message, size_t message_size, BinaryReply reply)>
  BinaryMessageHandler;

// A protocol for a class that handles communication of binary data on named
// channels to and from the Flutter engine.
class BinaryMessenger {
 public:
  virtual ~BinaryMessenger() = default;

  // Sends a binary message to the Flutter engine on the specified channel.
  //
  // If |reply| is provided, it will be called back with the response from the
  // engine.
  virtual void Send(const std::string& channel,
                    const uint8_t* message,
                    size_t message_size,
                    BinaryReply reply = nullptr) const = 0;

  // Registers a message handler for incoming binary messages from the Flutter
  // side on the specified channel.
  //
  // Replaces any existing handler. Provide a null handler to unregister the
  // existing handler.
  virtual void SetMessageHandler(const std::string& channel,
                                 BinaryMessageHandler handler) = 0;
};

} // namespace flutter

#endif // FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_BINARY_MESSENGER_H_
```

----------------------------------------

TITLE: Importing Dart Core Namespace Libraries
DESCRIPTION: Illustrates how to import essential Dart libraries from the `dart:` namespace, like `dart:async` and `dart:ui`. These libraries provide fundamental asynchronous programming capabilities and UI primitives for Flutter applications.
SOURCE: https://api.flutter.dev/index

LANGUAGE: Dart
CODE:
```
import 'dart:async';
import 'dart:ui';
```

----------------------------------------

TITLE: Create Custom Route with PageRouteBuilder in Flutter
DESCRIPTION: This example demonstrates how to create a custom route using `PageRouteBuilder` in Flutter. It defines a route that rotates and fades its child when appearing or disappearing. The route is set to be non-opaque, similar to a popup route, allowing the underlying content to show through. The `pageBuilder` defines the content of the route, while `transitionsBuilder` specifies the animation.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
Navigator.push(context, PageRouteBuilder<void>(
  opaque: false,
  pageBuilder: (BuildContext context, _, _) {
    return const Center(child: Text('My PageRoute'));
  },
  transitionsBuilder: (_, Animation<double> animation, _, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: RotationTransition(
        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: child,
      ),
    );
  }
));
```

----------------------------------------

TITLE: API: flutter::EncodableValue Class
DESCRIPTION: Represents an encodable value in Flutter, used for data serialization across platform channels. This class is fundamental for passing data between Dart and native code.
SOURCE: https://api.flutter.dev/macos-embedder/method__channel__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::EncodableValue
```

----------------------------------------

TITLE: Register a view factory for platform views
DESCRIPTION: Registers a `FlutterPlatformViewFactory` to enable the creation of platform views. Plugins use this mechanism to expose `NSView` instances for embedding within Flutter applications.
SOURCE: https://api.flutter.dev/macos-embedder/protocol_flutter_plugin_registrar-p

LANGUAGE: APIDOC
CODE:
```
- (void) registerViewFactory: (nonnull NSObject< FlutterPlatformViewFactory > *) factory
  withId: (nonnull NSString *) factoryId
  factory: The view factory that will be registered.
  factoryId: A unique identifier for the factory, which the Dart code of the Flutter app can use to request creation of an `NSView` by the registered factory.
```

----------------------------------------

TITLE: Navigator.pushNamed API Reference (Flutter)
DESCRIPTION: Pushes a named route onto the navigator that most tightly encloses the given context. This is a convenient way to navigate to a route defined by a string name.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
pushNamed<T extends Object?>(BuildContext context, String routeName, {Object? arguments}) -> Future<T?>
  Description: Push a named route onto the navigator that most tightly encloses the given context.
```

----------------------------------------

TITLE: Flutter Navigator.of Method API
DESCRIPTION: This API documentation explains the `Navigator.of` method, which retrieves the nearest ancestor `Navigator` from a given `BuildContext`. It emphasizes the importance of providing a `BuildContext` below the intended `Navigator` for correct operation, especially with nested navigators, and suggests using the `Builder` widget for accessing a `BuildContext` at a desired location.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
Navigator.of(BuildContext context)
  Operates on the nearest ancestor Navigator from the given BuildContext.
  Requires: BuildContext below the intended Navigator.
  Usage Tip: Use Builder widget to access a BuildContext at a desired location in the widget subtree.
```

----------------------------------------

TITLE: Flutter: Defining Named Routes in MaterialApp
DESCRIPTION: This example illustrates how to configure named routes within a Flutter application using the `routes` property of `MaterialApp`. It maps string names to `WidgetBuilder` functions, allowing for easy navigation to specific pages by name.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
void main() {
  runApp(MaterialApp(
    home: const MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => const MyPage(title: Text('page A')),
      '/b': (BuildContext context) => const MyPage(title: Text('page B')),
      '/c': (BuildContext context) => const MyPage(title: Text('page C')),
    },
  ));
}
```

----------------------------------------

TITLE: Flutter Desktop Plugin Registrar API Reference
DESCRIPTION: This section provides a structured API reference for the Flutter desktop plugin registrar, detailing its core types and functions. It includes definitions for opaque references, function pointer types, and methods to interact with the Flutter engine's messaging and rendering systems, as well as managing the plugin's lifecycle.
SOURCE: https://api.flutter.dev/ios-embedder/flutter__plugin__registrar_8h_source

LANGUAGE: APIDOC
CODE:
```
Types:
  FlutterDesktopPluginRegistrarRef:
    Description: Opaque reference to a plugin registrar.
    Definition: typedef struct FlutterDesktopPluginRegistrar* FlutterDesktopPluginRegistrarRef

  FlutterDesktopOnPluginRegistrarDestroyed:
    Description: Function pointer type for registrar destruction callback.
    Definition: typedef void (*FlutterDesktopOnPluginRegistrarDestroyed)(FlutterDesktopPluginRegistrarRef)

  FlutterDesktopMessengerRef:
    Description: Opaque reference to a messenger.
    Definition: struct FlutterDesktopMessenger * FlutterDesktopMessengerRef

Macros:
  FLUTTER_EXPORT:
    Description: Macro for export declarations.
    Definition: #define FLUTTER_EXPORT

Functions:
  FlutterDesktopPluginRegistrarGetMessenger:
    Description: Returns the engine messenger associated with this registrar.
    Signature: FLUTTER_EXPORT FlutterDesktopMessengerRef FlutterDesktopPluginRegistrarGetMessenger(FlutterDesktopPluginRegistrarRef registrar)
    Parameters:
      registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
    Returns: FlutterDesktopMessengerRef - The messenger reference.

  FlutterDesktopRegistrarGetTextureRegistrar:
    Description: Returns the texture registrar associated with this registrar.
    Signature: FLUTTER_EXPORT FlutterDesktopTextureRegistrarRef FlutterDesktopRegistrarGetTextureRegistrar(FlutterDesktopPluginRegistrarRef registrar)
    Parameters:
      registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
    Returns: FlutterDesktopTextureRegistrarRef - The texture registrar reference.

  FlutterDesktopPluginRegistrarSetDestructionHandler:
    Description: Registers a callback to be called when the plugin registrar is destroyed.
    Signature: FLUTTER_EXPORT void FlutterDesktopPluginRegistrarSetDestructionHandler(FlutterDesktopPluginRegistrarRef registrar, FlutterDesktopOnPluginRegistrarDestroyed callback)
    Parameters:
      registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
      callback: FlutterDesktopOnPluginRegistrarDestroyed - The callback function to be invoked on destruction.
    Returns: void
```

----------------------------------------

TITLE: API Reference for flutter::FlutterEngine Class
DESCRIPTION: Detailed API documentation for the `flutter::FlutterEngine` class, including its constructors, public methods, and inherited members from `flutter::PluginRegistry`. This class is central to embedding Flutter applications on Windows, providing functionalities for running, shutting down, processing messages, and managing plugins.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_engine

LANGUAGE: APIDOC
CODE:
```
flutter::FlutterEngine Class Reference

Inherits from: flutter::PluginRegistry

Public Member Functions:
  FlutterEngine(const DartProject &project)
    - Description: Constructor for FlutterEngine, initializing it with a Dart project.
    - Parameters:
      - project: const DartProject& - The Dart project to be run by the engine.
  virtual ~FlutterEngine()
    - Description: Destructor for FlutterEngine.
  FlutterEngine(FlutterEngine const &)=delete
    - Description: Deleted copy constructor to prevent copying of FlutterEngine instances.
  FlutterEngine &operator=(FlutterEngine const &)=delete
    - Description: Deleted copy assignment operator to prevent assignment of FlutterEngine instances.
  bool Run()
    - Description: Runs the Flutter engine with its default entry point.
    - Returns: bool - True if the engine started successfully, false otherwise.
  bool Run(const char *entry_point)
    - Description: Runs the Flutter engine with a specified entry point for the Dart application.
    - Parameters:
      - entry_point: const char* - The name of the Dart entry point function.
    - Returns: bool - True if the engine started successfully, false otherwise.
  void ShutDown()
    - Description: Shuts down the Flutter engine, releasing its resources.
  std::chrono::nanoseconds ProcessMessages()
    - Description: Processes pending messages for the engine, typically called in a message loop.
    - Returns: std::chrono::nanoseconds - The time duration until the next scheduled message processing.
  void ReloadSystemFonts()
    - Description: Reloads system fonts, useful for dynamic font changes.
  void ReloadPlatformBrightness()
    - Description: Reloads the platform brightness setting, useful for theme changes.
  FlutterDesktopPluginRegistrarRef GetRegistrarForPlugin(const std::string &plugin_name) override
    - Description: Retrieves a plugin registrar for a specific plugin, allowing it to register methods and channels.
    - Parameters:
      - plugin_name: const std::string& - The unique name of the plugin.
    - Returns: FlutterDesktopPluginRegistrarRef - A reference to the plugin registrar.
  BinaryMessenger *messenger()
    - Description: Gets the binary messenger associated with the engine, used for platform channel communication.
    - Returns: BinaryMessenger* - A pointer to the BinaryMessenger instance.
  void SetNextFrameCallback(std::function< void()> callback)
    - Description: Sets a callback function to be invoked before the next frame is rendered.
    - Parameters:
      - callback: std::function<void()> - The callback function to execute.
  std::optional< LRESULT > ProcessExternalWindowMessage(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)
    - Description: Processes an external Windows message for the engine's window.
    - Parameters:
      - hwnd: HWND - Handle to the window.
      - message: UINT - The message identifier.
      - wparam: WPARAM - The first message parameter.
      - lparam: LPARAM - The second message parameter.
    - Returns: std::optional<LRESULT> - An optional LRESULT if the message was handled by the engine.

Public Member Functions inherited from flutter::PluginRegistry:
  PluginRegistry()=default
    - Description: Default constructor for PluginRegistry.
  virtual ~PluginRegistry()=default
    - Description: Default destructor for PluginRegistry.
  PluginRegistry(PluginRegistry const &)=delete
    - Description: Deleted copy constructor for PluginRegistry.
  PluginRegistry &operator=(PluginRegistry const &)=delete
    - Description: Deleted copy assignment operator for PluginRegistry.

Friends:
  class FlutterViewController
    - Description: The FlutterViewController class is a friend of FlutterEngine, allowing it direct access to FlutterEngine's private members for integration.
```

----------------------------------------

TITLE: FlutterDesktopMessengerSendWithReply Function
DESCRIPTION: Sends a binary message to Flutter on a specified channel and expects a binary reply. A callback function is provided to handle the asynchronous response from Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__messenger_8h_source

LANGUAGE: APIDOC
CODE:
```
FLUTTER_EXPORT bool FlutterDesktopMessengerSendWithReply(FlutterDesktopMessengerRef messenger, const char *channel, const uint8_t *message, const size_t message_size, const FlutterDesktopBinaryReply reply, void *user_data)
```

----------------------------------------

TITLE: API: flutter::MethodChannel Class
DESCRIPTION: Represents a communication channel for invoking named methods between Flutter (Dart) and native platforms. It facilitates bidirectional communication using method calls and responses.
SOURCE: https://api.flutter.dev/macos-embedder/method__channel__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodChannel
```

----------------------------------------

TITLE: Override onSaveInstanceState() in Android Activity
DESCRIPTION: Overrides the standard Android Activity.onSaveInstanceState() method, which is called to save the activity's dynamic state in a Bundle.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
protected void onSaveInstanceState(Bundle outState)
Overrides: Activity.onSaveInstanceState(android.os.Bundle)
```

----------------------------------------

TITLE: Navigator.pushReplacement API Reference (Flutter)
DESCRIPTION: Replaces the current route with a new route on the navigator that most tightly encloses the given context. This is useful for scenarios where the current screen should not be accessible via the back button after navigation.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
pushReplacement<T extends Object?, TO extends Object?>(BuildContext context, Route<T> newRoute, {TO? result}) -> Future<T?>
  Description: Replaces the current route with a new route on the navigator that most tightly encloses the given context.
```

----------------------------------------

TITLE: Initialize FlutterEngine with Default Settings
DESCRIPTION: Provides the default initializer for a FlutterEngine instance. This method sets up the engine to run the default Flutter project and enables headless execution. The engine requires a subsequent call to `-runWithEntrypoint:` or `-runWithEntrypoint:libraryURI:` to begin execution.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
FlutterEngine Class:
  Method: init
  Signature: - (instancetype)init
  Description: Default initializer for a FlutterEngine.
  Returns: instancetype
  Notes:
    - Threads created by this FlutterEngine will appear as "FlutterEngine #" in Instruments.
    - The engine executes the project located in the bundle with the identifier "io.flutter.flutter.app".
    - A newly initialized engine will not run until -runWithEntrypoint: or -runWithEntrypoint:libraryURI: is called.
    - FlutterEngine created with this method will have allowHeadlessExecution set to YES.
```

LANGUAGE: Objective-C
CODE:
```
{
  return [self initWithName:@"FlutterEngine" project:nil allowHeadlessExecution:YES];
}
```

----------------------------------------

TITLE: MethodChannel Class API Reference
DESCRIPTION: Defines the structure, constructor, and properties of the Flutter MethodChannel class, used for inter-platform communication.
SOURCE: https://api.flutter.dev/flutter/services/MethodChannel-class

LANGUAGE: APIDOC
CODE:
```
MethodChannel class:
  Description: A named channel for communicating with platform plugins using asynchronous method calls. Method calls are encoded into binary before being sent, and binary results received are decoded into Dart values. The MethodCodec used must be compatible with the one used by the platform plugin. This can be achieved by creating a method channel counterpart of this channel on the platform side. The Dart type of arguments and results is dynamic, but only values supported by the specified MethodCodec can be used. The use of unsupported values should be considered programming errors, and will result in exceptions being thrown. The null value is supported for all codecs. The logical identity of the channel is given by its name. Identically named channels will interfere with each other's communication. All MethodChannels provided by the Flutter framework guarantee FIFO ordering. Applications can assume method calls sent via a built-in MethodChannel are received by the platform plugins in the same order as they're sent.
  See Also: flutter.dev/to/platform-channels/
  Implementers:
    - OptionalMethodChannel
  Available Extensions:
    - TestMethodChannelExtension

  Constructors:
    MethodChannel(String name, [MethodCodec codec = const StandardMethodCodec(), BinaryMessenger? binaryMessenger]):
      Description: Creates a MethodChannel with the specified name.

  Properties:
    binaryMessenger:
      Type: BinaryMessenger
      Description: The messenger which sends the bytes for this channel.
      Access: no setter
    codec:
      Type: MethodCodec
      Description: The message codec used by this channel, not null.
      Access: final
    hashCode:
      Type: int
      Description: The hash code for this object.
      Access: no setter (inherited)
    name:
      Type: String
      Description: The logical channel on which communication happens, not null.
      Access: final
    runtimeType:
      Type: Type
      Description: A representation of the runtime type of the object.
      Access: no setter (inherited)
```

----------------------------------------

TITLE: Send and Handle Flutter Platform Method Call (Objective-C)
DESCRIPTION: This Objective-C code demonstrates how to send a platform channel method call, specifically 'System.requestAppExit', using FlutterJSONMethodCodec to encode the call. It then sends the message via _engine and handles the asynchronous binary reply. The reply is decoded, checked for FlutterError instances, and processed based on the content of the NSDictionary response, determining if the app should exit or cancel termination.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: Objective-C
CODE:
```
FlutterJSONMethodCodec* codec = [FlutterJSONMethodCodec sharedInstance];
FlutterMethodCall* methodCall =
[FlutterMethodCall methodCallWithMethodName:@"System.requestAppExit" arguments:nil];
[_engine sendOnChannel:kFlutterPlatformChannel
message:[codec encodeMethodCall:methodCall]
binaryReply:^(NSData* _Nullable reply) {
NSAssert(_terminator, @"terminator shouldn't be nil");
id decoded_reply = [codec decodeEnvelope:reply];
if ([decoded_reply isKindOfClass:[FlutterError class]]) {
FlutterError* error = (FlutterError*)decoded_reply;
NSLog(@"Method call returned error[%@]: %@ %@", [error code], [error message],
[error details]);
_terminator(sender);
return;
}
if (![decoded_reply isKindOfClass:[NSDictionary class]]) {
NSLog(@"Call to System.requestAppExit returned an unexpected object: %@",
decoded_reply);
_terminator(sender);
return;
}
NSDictionary* replyArgs = (NSDictionary*)decoded_reply;
if ([replyArgs[@"response"] isEqual:@"exit"]) {
_terminator(sender);
} else if ([replyArgs[@"response"] isEqual:@"cancel"]) {
_shouldTerminate = NO;
}
if (result != nil) {
result(replyArgs);
}
}];
```

----------------------------------------

TITLE: Create Flutter Desktop View Controller
DESCRIPTION: Creates a view that hosts and displays a given Flutter engine instance. This function takes ownership of the engine, so FlutterDesktopEngineDestroy should no longer be called on it. If creating the view controller fails, the engine will be destroyed immediately. If the engine is not already running, the view controller will start it automatically before displaying the window. The caller owns the returned reference and is responsible for calling FlutterDesktopViewControllerDestroy. Returns a null pointer in the event of an error.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterDesktopViewControllerCreate(width: int, height: int, engine: FlutterDesktopEngineRef):
  width: The desired width of the view.
  height: The desired height of the view.
  engine: A reference to the Flutter desktop engine instance to host. Ownership is transferred to the view controller.
  Returns: FlutterDesktopViewControllerRef (A reference to the newly created FlutterDesktopViewControllerRef, or null on error.)
```

----------------------------------------

TITLE: Replace Specific Route with restorableReplace (Flutter Navigator API)
DESCRIPTION: Replaces a route on the navigator that most tightly encloses the given context with a new route.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorableReplace<T extends Object?>(
  context: BuildContext,
  {required oldRoute: Route, required newRouteBuilder: RestorableRouteBuilder<T>, arguments: Object?}
) -> String
```

----------------------------------------

TITLE: Navigator.restorablePush
DESCRIPTION: Push a new route onto the navigator that most tightly encloses the given context.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorablePush<T extends Object?>(BuildContext context, RestorableRouteBuilder<T> routeBuilder, {Object? arguments}) → String
```

----------------------------------------

TITLE: flutter::BinaryMessenger Class API Definition
DESCRIPTION: Defines the abstract interface for `flutter::BinaryMessenger`, including its destructor and pure virtual methods for sending binary messages and setting message handlers. This class is fundamental for inter-platform communication in Flutter's C++ embedder.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_binary_messenger

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger (abstract class)
  #include <binary_messenger.h>

  Public Member Functions:

    ~BinaryMessenger():
      Signature: virtual flutter::BinaryMessenger::~BinaryMessenger () = default
      Description: Default destructor for the BinaryMessenger class.

    Send(channel: const std::string &, message: const uint8_t *, message_size: size_t, reply: BinaryReply = nullptr):
      Signature: virtual void flutter::BinaryMessenger::Send (const std::string &channel, const uint8_t *message, size_t message_size, BinaryReply reply = nullptr) const = 0
      Parameters:
        channel: The name of the channel to send the message on.
        message: A pointer to the binary message data.
        message_size: The size of the message data in bytes.
        reply: An optional callback to be invoked with the reply from the receiver.
      Returns: void
      Description: Sends a binary message over the specified channel. This is a pure virtual function.
      Implemented in: flutter::BinaryMessengerImpl

    SetMessageHandler(channel: const std::string &, handler: BinaryMessageHandler):
      Signature: virtual void flutter::BinaryMessenger::SetMessageHandler (const std::string &channel, BinaryMessageHandler handler) = 0
      Parameters:
        channel: The name of the channel to set the handler for.
        handler: The message handler function to be invoked when a message is received on the channel.
      Returns: void
      Description: Sets a message handler for a specific channel. This handler will be called when messages are received on that channel. This is a pure virtual function.
      Implemented in: flutter::BinaryMessengerImpl
```

----------------------------------------

TITLE: flutter::BinaryMessenger::SetMessageHandler Method
DESCRIPTION: Sets a message handler for a specific channel. This pure virtual method enables the class to receive and process incoming binary messages on the designated channel.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_binary_messenger-members

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger::SetMessageHandler
  Parameters:
    channel: const std::string & - The channel name for which to set the handler.
    handler: BinaryMessageHandler - The callback function to be invoked when a message arrives on the channel.
  Return Type: void
  Description: Pure virtual method to set a message handler for a specified channel.
```

----------------------------------------

TITLE: Flutter BinaryMessenger SetMessageHandler Method API
DESCRIPTION: Documentation for the `SetMessageHandler` method of the `flutter::BinaryMessenger` class, used to register a handler for incoming binary messages on a specific channel.
SOURCE: https://api.flutter.dev/windows-embedder/event__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger::SetMessageHandler
```

----------------------------------------

TITLE: FlutterEngine() Category API Reference
DESCRIPTION: Detailed API documentation for the FlutterEngine() category, outlining its instance methods for interacting with Flutter views, handling engine callbacks, managing platform channels, and supporting accessibility features in macOS applications.
SOURCE: https://api.flutter.dev/macos-embedder/category_flutter_engine_07_08

LANGUAGE: APIDOC
CODE:
```
FlutterEngine() Category Reference

#import <FlutterEngine_Internal.h>

Instance Methods:
  - (nullable FlutterViewController *) viewControllerForIdentifier:
  - (void) registerViewController:forIdentifier:
  - (void) deregisterViewControllerForIdentifier:
  - (void) shutDownIfNeeded
  - (void) sendUserLocales
  - (void) engineCallbackOnPlatformMessage:
  - (void) engineCallbackOnPreEngineRestart
  - (void) postMainThreadTask:targetTimeInNanoseconds:
  - (void) loadAOTData:
  - (void) setUpPlatformViewChannel
  - (void) setUpAccessibilityChannel
  - (void) handleMethodCall:result:
  - (void) addViewController:
  - (void) viewControllerViewDidLoad:
  - (void) removeViewController:
  - (void) updateWindowMetricsForViewController:
  - (void) sendPointerEvent:
  - (BOOL) registerTextureWithID:
  - (BOOL) markTextureFrameAvailable:
  - (BOOL) unregisterTextureWithID:
  - (nonnull FlutterPlatformViewController *) platformViewController
  - (void) setApplicationState:
  - (void) dispatchSemanticsAction:toTarget:withData:
  - (void) handleAccessibilityEvent:
  - (void) announceAccessibilityMessage:withPriority:
  - (NSArray< NSScreen * > *) screens

Instance Methods inherited from <FlutterMouseCursorPluginDelegate>:
  - (void) didUpdateMouseCursor:

Instance Methods inherited from <FlutterKeyboardManagerDelegate>:
  - (void) sendKeyEvent:callback:userData:
  - (nonnull id< FlutterBinaryMessenger >) binaryMessenger

Class Methods:
  (No specific class methods listed)
```

----------------------------------------

TITLE: Objective-C: Spawn or Run Flutter Engine with Entrypoint
DESCRIPTION: This Objective-C code snippet demonstrates how to either run an existing FlutterEngine with specific entrypoint arguments or spawn a new FlutterEngine instance if no existing engine is available. It configures the engine with a given entrypoint, library URI, initial route, and arguments, then adds the engine to a collection and returns it.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_group_8mm_source

LANGUAGE: Objective-C
CODE:
```
[entrypointArgs]:entrypointArgs];
} else {
FlutterEngine* spawner = (__bridge FlutterEngine*)[self.engines pointerAtIndex:0];
engine = [spawner spawnWithEntrypoint:entrypoint
libraryURI:libraryURI
initialRoute:initialRoute
entrypointArgs:entrypointArgs];
}
[self.engines addPointer:(__bridge void*)engine];
return engine;
```

----------------------------------------

TITLE: BasicMessageChannel Class
DESCRIPTION: Provides a named channel for asynchronous message passing between Flutter and platform plugins, supporting basic data types.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
BasicMessageChannel<T>:
  A named channel for communicating with platform plugins using asynchronous message passing.
```

----------------------------------------

TITLE: Flutter BinaryMessenger API Definition
DESCRIPTION: Definition of the `BinaryMessenger` class, used for sending and receiving binary messages between the Flutter engine and platform plugins.
SOURCE: https://api.flutter.dev/windows-embedder/text__input__plugin_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger
  Definition: binary_messenger.h:28
```

----------------------------------------

TITLE: Android View Class Methods
DESCRIPTION: A comprehensive list of methods available in the `android.view.View` class, detailing their signatures and purposes for UI interaction and manipulation in Android applications. These methods allow developers to control visual properties, handle touch events, manage animations, and more.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterSurfaceView

LANGUAGE: APIDOC
CODE:
```
android.view.View Class Methods:
  setTouchDelegate(android.view.TouchDelegate)
  setTransitionAlpha(float)
  setTransitionName(java.lang.String)
  setTransitionVisibility(int)
  setTranslationX(float)
  setTranslationY(float)
  setTranslationZ(float)
  setVerticalFadingEdgeEnabled(boolean)
  setVerticalScrollBarEnabled(boolean)
  setVerticalScrollbarPosition(int)
  setVerticalScrollbarThumbDrawable(android.graphics.drawable.Drawable)
  setVerticalScrollbarTrackDrawable(android.graphics.drawable.Drawable)
  setViewTranslationCallback(android.view.translation.ViewTranslationCallback)
  setWillNotCacheDrawing(boolean)
  setWillNotDraw(boolean)
  setWindowInsetsAnimationCallback(android.view.WindowInsetsAnimation.Callback)
  setX(float)
  setY(float)
  setZ(float)
  showContextMenu()
  showContextMenu(float,float)
  startActionMode(android.view.ActionMode.Callback)
  startActionMode(android.view.ActionMode.Callback,int)
  startAnimation(android.view.animation.Animation)
  startDrag(android.content.ClipData,android.view.View.DragShadowBuilder,java.lang.Object,int)
  startDragAndDrop(android.content.ClipData,android.view.View.DragShadowBuilder,java.lang.Object,int)
  startNestedScroll(int)
  stopNestedScroll()
  toString()
  transformMatrixToGlobal(android.graphics.Matrix)
  transformMatrixToLocal(android.graphics.Matrix)
```

----------------------------------------

TITLE: Force Reset Forwarding Gesture Recognizer State (Objective-C)
DESCRIPTION: Provides a workaround for an issue where the gesture recognizer gets stuck in a 'failed' state, particularly when an iPad pencil is involved. It forces a reset by recreating and re-adding the ForwardingGestureRecognizer, ensuring subsequent touches are not blocked. This addresses a known issue documented on GitHub.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_views_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)forceResetForwardingGestureRecognizerState {
// When iPad pencil is involved in a finger touch gesture, the gesture is not reset to "possible"
// state and is stuck on "failed" state, which causes subsequent touches to be blocked. As a
// workaround, we force reset the state by recreating the forwarding gesture recognizer. See:
// https://github.com/flutter/flutter/issues/136244
ForwardingGestureRecognizer* oldForwardingRecognizer =
([ForwardingGestureRecognizer*)self.delayingRecognizer.forwardingRecognizer;
ForwardingGestureRecognizer* newForwardingRecognizer =
[oldForwardingRecognizer recreateRecognizerWithTarget:self];
s.delayingRecognizer.forwardingRecognizer = newForwardingRecognizer;
[self removeGestureRecognizer:oldForwardingRecognizer];
[self addGestureRecognizer:newForwardingRecognizer];
}
```

----------------------------------------

TITLE: Flutter StandardMessageCodec Class Definition
DESCRIPTION: Definition of the `StandardMessageCodec` class, a common message codec in Flutter for encoding and decoding standard data types.
SOURCE: https://api.flutter.dev/linux-embedder/standard__message__codec__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::StandardMessageCodec
Definition: standard_message_codec.h:18
```

----------------------------------------

TITLE: FlutterMethodCall Interface Members Overview
DESCRIPTION: This snippet details the properties and static methods of the FlutterMethodCall interface, which is fundamental for handling method invocations from Flutter to the native iOS side. It includes properties for accessing call arguments and method names, as well as a static constructor for creating new method call instances.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_method_call-members

LANGUAGE: APIDOC
CODE:
```
FlutterMethodCall Interface:
  Properties:
    arguments: (Type: FlutterMethodCall) Description: Arguments associated with the method call.
    method: (Type: FlutterMethodCall) Description: The name of the method being called.
  Static Methods:
    methodCallWithMethodName:arguments:(methodName: String, arguments: Any?) (Type: FlutterMethodCall) Description: Creates a new FlutterMethodCall instance with the specified method name and arguments.
```

----------------------------------------

TITLE: APIDOC: TextEditingValue
DESCRIPTION: The current text, selection, and composing state for editing a run of text.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
TextEditingValue
  The current text, selection, and composing state for editing a run of text.
```

----------------------------------------

TITLE: FlutterPlatformViewsController Class API Reference
DESCRIPTION: This section details the public API of the FlutterPlatformViewsController class, including its initializer and various methods for managing platform views within a Flutter application on iOS. It covers operations like registering view factories, handling frame rendering, managing touch events, and processing method calls.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_platform_views_controller

LANGUAGE: APIDOC
CODE:
```
Class: FlutterPlatformViewsController
Import: #import <FlutterPlatformViewsController.h>

Instance Methods:
- (instancetype) NS_DESIGNATED_INITIALIZER

- (void) registerViewFactory:(id)factory withId:(id)viewId gestureRecognizersBlockingPolicy:(id)policy
  Description: Set the factory used to construct embedded UI Views.

- (void) beginFrameWithSize:(CGSize)size
  Description: Mark the beginning of a frame and record the size of the onscreen.

- (void) cancelFrame
  Description: Cancel the current frame, indicating that no platform views are composited.

- (void) prerollCompositeEmbeddedView:(id)view withParams:(id)params
  Description: Record a platform view in the layer tree to be rendered, along with the positioning and mutator parameters.

- (FlutterTouchInterceptingView *) flutterTouchInterceptingViewForId:(long)viewId
  Description: Returns the FlutterTouchInterceptingView with the provided view_id.

- (flutter::PostPrerollResult) postPrerollActionWithThreadMerger:(id)threadMerger
  Description: Determine if thread merging is required after prerolling platform views.

- (void) endFrameWithResubmit:(BOOL)resubmit threadMerger:(id)threadMerger
  Description: Mark the end of a compositor frame.

- (flutter::DlCanvas *) compositeEmbeddedViewWithId:(long)viewId
  Description: Returns the Canvas for the overlay slice for the given platform view.

- (void) reset
  Description: Discards all platform views instances and auxiliary resources.

- (BOOL) submitFrame:(id)frame withIosContext:(id)context
  Description: Encode rendering for the Flutter overlay views and queue up perform platform view mutations.

- (void) onMethodCall:(id)call result:(id)result
  Description: Handler for platform view message channels.

- (long) firstResponderPlatformViewId
  Description: Returns the platform view id if the platform view (or any of its descendant view) is the first responder.

- (void) pushFilterToVisitedPlatformViews:(id)filter withRect:(CGRect)rect
  Description: Pushes backdrop filter mutation to the mutator stack of each visited platform view.
```

----------------------------------------

TITLE: API Reference: fl_method_channel_set_method_call_handler
DESCRIPTION: Defines the signature and parameters for the `fl_method_channel_set_method_call_handler` function. This function is used to register a callback handler for method calls originating from the Dart side of a Flutter method channel. It specifies the channel, the handler function, user data, and an optional destroy notification.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__channel_8cc

LANGUAGE: APIDOC
CODE:
```
G_MODULE_EXPORT void fl_method_channel_set_method_call_handler (
    FlMethodChannel *channel,
    FlMethodChannelMethodCallHandler handler,
    gpointer user_data,
    GDestroyNotify destroy_notify
)

Parameters:
- @channel: an #FlMethodChannel.
- @handler: function to call when a method call is received on this channel.
- @user_data: (closure): user data to pass to @handler.
- @destroy_notify: (allow-none): a function which gets called to free @user_data, or NULL.

Description:
Sets the function called when a method call is received from the Dart side of the channel. See #FlMethodChannelMethodCallHandler for details on how to respond to method calls.
The handler is removed if the channel is closed or is replaced by another handler, set @destroy_notify if you want to detect this.
```

----------------------------------------

TITLE: BasicMessageChannel Methods
DESCRIPTION: Methods available for sending messages, setting handlers, and managing channel overflow warnings within the `BasicMessageChannel` class.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/BasicMessageChannel

LANGUAGE: APIDOC
CODE:
```
void send(T message, BasicMessageChannel.Reply<T> callback)
  Sends the specified message to the Flutter application, optionally expecting a reply.
```

LANGUAGE: APIDOC
CODE:
```
void setMessageHandler(BasicMessageChannel.MessageHandler<T> handler)
  Registers a message handler on this channel for receiving messages sent from the Flutter application.
```

LANGUAGE: APIDOC
CODE:
```
void setWarnsOnChannelOverflow(boolean warns)
  Toggles whether the channel should show warning messages when discarding messages due to overflow.
```

LANGUAGE: APIDOC
CODE:
```
static void setWarnsOnChannelOverflow(BinaryMessenger messenger, String channel, boolean warns)
  Toggles whether the channel should show warning messages when discarding messages due to overflow.
```

LANGUAGE: APIDOC
CODE:
```
Methods inherited from class java.lang.Object:
  clone()
  equals(java.lang.Object)
  finalize()
  getClass()
  hashCode()
  notify()
  notifyAll()
  toString()
  wait()
  wait(long)
  wait(long, int)
```

----------------------------------------

TITLE: EventChannel
DESCRIPTION: A named channel for communicating with platform plugins using event streams.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
EventChannel:
  Description: A named channel for communicating with platform plugins using event streams.
```

----------------------------------------

TITLE: Dart Core Library: dart:collection
DESCRIPTION: Provides classes and utilities that supplement the collection support in dart:core.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Library: dart:collection
Description: Classes and utilities that supplement the collection support in dart:core.
```

----------------------------------------

TITLE: API Reference for FlutterEngine Class
DESCRIPTION: Documents the FlutterEngine class, which is central to embedding Flutter content into native applications. It provides methods for running Flutter entrypoints, managing scene lifecycle, setting up communication channels, and accessing various engine components.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine-members

LANGUAGE: APIDOC
CODE:
```
FlutterEngine:
  Methods:
    runWithEntrypoint:libraryURI:initialRoute:
    runWithEntrypoint:libraryURI:initialRoute:entrypointArgs:
    sceneDidEnterBackground:
    sceneWillEnterForeground:
    setBinaryMessenger:
    shell
    spawnWithEntrypoint:libraryURI:initialRoute:entrypointArgs:
    threadHost
    updateDisplays
    waitForFirstFrame:callback:
  Properties:
    settingsChannel
    systemChannel
    textInputChannel
    textureRegistry
    viewController
    vmServiceUrl
```

----------------------------------------

TITLE: Add UTF-16 or UTF-8 Text to Flutter TextInputModel
DESCRIPTION: Adds UTF-16 or UTF-8 text to the TextInputModel. It either appends the text after the cursor (when selection base and extent are the same) or deletes the selected text, replacing it with the given text.
SOURCE: https://api.flutter.dev/macos-embedder/text__input__model_8h_source

LANGUAGE: APIDOC
CODE:
```
TextInputModel::AddText(text: const std::u16string&) -> void
```

LANGUAGE: APIDOC
CODE:
```
TextInputModel::AddText(text: const std::string&) -> void
```

----------------------------------------

TITLE: flutter::MethodChannel<T> Class API Documentation
DESCRIPTION: Detailed API reference for the `flutter::MethodChannel<T>` class, outlining its public interface, including constructors, methods, and operators. This class is fundamental for communication between Flutter and the host platform.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_method_channel-members

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodChannel<T>
  Description: This is the complete list of members for flutter::MethodChannel< T >, including all inherited members.

  Methods:
    InvokeMethod(const std::string &method, std::unique_ptr< T > arguments, std::unique_ptr< MethodResult< T >> result=nullptr)
      Description: Invokes a method on the channel.
      Parameters:
        method: const std::string & - The name of the method to invoke.
        arguments: std::unique_ptr< T > - Arguments to pass with the method call.
        result: std::unique_ptr< MethodResult< T >> - Optional callback for the method result. Defaults to nullptr.
      Return Type: void

    MethodChannel(BinaryMessenger *messenger, const std::string &name, const MethodCodec< T > *codec)
      Description: Constructs a MethodChannel instance.
      Parameters:
        messenger: BinaryMessenger * - The binary messenger to use for communication.
        name: const std::string & - The name of the channel.
        codec: const MethodCodec< T > * - The method codec to use for encoding/decoding messages.

    MethodChannel(MethodChannel const &)=delete
      Description: Deleted copy constructor to prevent copying MethodChannel instances.

    operator=(MethodChannel const &)=delete
      Description: Deleted assignment operator to prevent assigning MethodChannel instances.

    Resize(int new_size)
      Description: Resizes the channel's internal buffer or related resource.
      Parameters:
        new_size: int - The new size.
      Return Type: void

    SetMethodCallHandler(MethodCallHandler< T > handler) const
      Description: Sets the method call handler for this channel.
      Parameters:
        handler: MethodCallHandler< T > - The handler to be invoked when a method call is received.
      Return Type: void

    SetWarnsOnOverflow(bool warns)
      Description: Sets whether the channel should warn on overflow.
      Parameters:
        warns: bool - True to enable warnings on overflow, false otherwise.
      Return Type: void

    ~MethodChannel()=default
      Description: Default destructor for MethodChannel.
```

----------------------------------------

TITLE: flutter::MethodChannel<T> Class API Reference
DESCRIPTION: Detailed API documentation for the `flutter::MethodChannel<T>` class, including its constructors, methods, and operators, as generated by Doxygen.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_method_channel-members

LANGUAGE: APIDOC
CODE:
```
flutter::MethodChannel<T> Class:
  Members:
    InvokeMethod(const std::string &method, std::unique_ptr< T > arguments, std::unique_ptr< MethodResult< T >> result=nullptr)
      Description: Invokes a method on the channel.
      Parameters:
        method: The name of the method to invoke.
        arguments: Optional arguments for the method.
        result: Optional callback for the method result.
      Return Type: void
    MethodChannel(BinaryMessenger *messenger, const std::string &name, const MethodCodec< T > *codec)
      Description: Constructor for MethodChannel.
      Parameters:
        messenger: The binary messenger to use.
        name: The name of the channel.
        codec: The method codec to use.
    MethodChannel(MethodChannel const &)=delete
      Description: Deleted copy constructor.
    operator=(MethodChannel const &)=delete
      Description: Deleted assignment operator.
    Resize(int new_size)
      Description: Resizes the channel.
      Parameters:
        new_size: The new size.
      Return Type: void
    SetMethodCallHandler(MethodCallHandler< T > handler) const
      Description: Sets the method call handler for the channel.
      Parameters:
        handler: The handler to set.
      Return Type: void
    SetWarnsOnOverflow(bool warns)
      Description: Sets whether the channel warns on overflow.
      Parameters:
        warns: True to warn on overflow, false otherwise.
      Return Type: void
    ~MethodChannel()=default
      Description: Default destructor.
```

----------------------------------------

TITLE: C++: Example of FlEventChannel Event Stream Usage
DESCRIPTION: Provides a comprehensive C++ example demonstrating how to set up and use `FlEventChannel` to send event streams to Dart. It includes functions for handling events (`event_occurs_cb`), listening to the stream (`listen_cb`), canceling the stream (`cancel_cb`), and initializing the channel (`setup_channel`). This example illustrates the integration with `FlStandardMethodCodec` and error handling.
SOURCE: https://api.flutter.dev/linux-embedder/fl__event__channel_8h

LANGUAGE: C++
CODE:
```
static FlEventChannel *channel = NULL; static gboolean send_events = FALSE;

static void event_occurs_cb (FooEvent *event) { if (send_events) { g_autoptr(FlValue) message = foo_event_to_value (event); g_autoptr(GError) error = NULL; if (!fl_event_channel_send (channel, message, NULL, &error)) { g_warning ("Failed to send event: %s", error->message); } } }

static FlMethodErrorResponse* listen_cb (FlEventChannel* channel, FlValue *args, gpointer user_data) { send_events = TRUE; return NULL; }

static FlMethodErrorResponse* cancel_cb (GObject *object, FlValue *args, gpointer user_data) { send_events = FALSE; return NULL; }

static void setup_channel () { g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new (); channel = fl_event_channel_new (messenger, "flutter/foo", FL_METHOD_CODEC (codec)); fl_event_channel_set_stream_handlers (channel, listen_cb, cancel_cb, NULL, NULL); }
```

----------------------------------------

TITLE: Initialize and Set Up Flutter Accessibility Plugin (C++)
DESCRIPTION: This snippet shows the constructor for `AccessibilityPlugin`, which takes a `FlutterWindowsEngine` pointer. The `SetUp` method demonstrates how the plugin registers a `BasicMessageChannel` with the `BinaryMessenger` using the defined accessibility channel name and a `StandardMessageCodec`. It then sets a message handler to process incoming messages via a lambda function, which internally calls the `HandleMessage` utility function.
SOURCE: https://api.flutter.dev/windows-embedder/accessibility__plugin_8cc_source

LANGUAGE: C++
CODE:
```
AccessibilityPlugin::AccessibilityPlugin(FlutterWindowsEngine* engine)
    : engine_(engine) {}

void AccessibilityPlugin::SetUp(BinaryMessenger* binary_messenger,
                                AccessibilityPlugin* plugin) {
  BasicMessageChannel<> channel{binary_messenger, kAccessibilityChannelName,
                                &StandardMessageCodec::GetInstance()};

  channel.SetMessageHandler(
      [plugin](const EncodableValue& message,
               const MessageReply<EncodableValue>& reply) {
```

----------------------------------------

TITLE: Flutter C++ MethodResult Class API Definition
DESCRIPTION: The `flutter::MethodResult` class is a C++ template class designed to encapsulate and send results from MethodCalls in the Flutter embedding layer. It ensures that only one response (success, error, or not-implemented) is sent per instance. 

**Class Definition:**
`template <typename T = EncodableValue> class MethodResult`

**Constructors & Operators:**
- `MethodResult()`: Default constructor.
- `~MethodResult()`: Default destructor.
- `MethodResult(MethodResult const&) = delete`: Copy constructor is deleted to prevent copying.
- `operator=(MethodResult const&) = delete`: Assignment operator is deleted to prevent copying.

**Public Methods:**
- `void Success(const T& result)`:
  - Description: Sends a success response with a given result.
  - Parameters:
    - `result`: The result of type `T` to send.
- `void Success()`:
  - Description: Sends a success response with no result.
- `void Error(const std::string& error_code, const std::string& error_message, const T& error_details)`:
  - Description: Sends an error response with a code, message, and optional details.
  - Parameters:
    - `error_code`: A string code describing the error.
    - `error_message`: A user-readable error message.
    - `error_details`: Arbitrary extra details about the error (type `T`).
- `void Error(const std::string& error_code, const std::string& error_message = "")`:
  - Description: Sends an error response with a code and optional message.
  - Parameters:
    - `error_code`: A string code describing the error.
    - `error_message`: A user-readable error message (optional).
- `void NotImplemented()`:
  - Description: Sends a not-implemented response, indicating the method was not recognized or not implemented.

**Protected Abstract Methods (for Subclass Implementation):**
- `virtual void SuccessInternal(const T* result) = 0`
- `virtual void ErrorInternal(const std::string& error_code, const std::string& error_message, const T* error_details) = 0`
- `virtual void NotImplementedInternal() = 0`
SOURCE: https://api.flutter.dev/windows-embedder/method__result_8h_source

LANGUAGE: C++
CODE:
```
#ifndef FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_METHOD_RESULT_H_
#define FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_METHOD_RESULT_H_

#include <string>

namespace flutter {

class EncodableValue;

// Encapsulates a result returned from a MethodCall. Only one method should be
// called on any given instance.
template <typename T = EncodableValue>
class MethodResult {
 public:
  MethodResult() = default;
  virtual ~MethodResult() = default;

  // Prevent copying.
  MethodResult(MethodResult const&) = delete;
  MethodResult& operator=(MethodResult const&) = delete;

  // Sends a success response, indicating that the call completed successfully
  // with the given result.
  void Success(const T& result) { SuccessInternal(&result); }

  // Sends a success response, indicating that the call completed successfully
  // with no result.
  void Success() { SuccessInternal(nullptr); }

  // Sends an error response, indicating that the call was understood but
  // handling failed in some way.
  //
  // error_code: A string error code describing the error.
  // error_message: A user-readable error message.
  // error_details: Arbitrary extra details about the error.
  void Error(const std::string& error_code,
             const std::string& error_message,
             const T& error_details) {
    ErrorInternal(error_code, error_message, &error_details);
  }

  // Sends an error response, indicating that the call was understood but
  // handling failed in some way.
  //
  // error_code: A string error code describing the error.
  // error_message: A user-readable error message (optional).
  void Error(const std::string& error_code,
             const std::string& error_message = "") {
    ErrorInternal(error_code, error_message, nullptr);
  }

  // Sends a not-implemented response, indicating that the method either was not
  // recognized, or has not been implemented.
  void NotImplemented() { NotImplementedInternal(); }

 protected:
  // Implementation of the public interface, to be provided by subclasses.
  virtual void SuccessInternal(const T* result) = 0;

  // Implementation of the public interface, to be provided by subclasses.
  virtual void ErrorInternal(const std::string& error_code,
                             const std::string& error_message,
                             const T* error_details) = 0;
  // Implementation of the public interface, to be provided by subclasses.
  virtual void NotImplementedInternal() = 0;
};

} // namespace flutter

#endif // FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_METHOD_RESULT_H_
```

----------------------------------------

TITLE: Flutter ActivityAware Plugin: onDetachedFromActivity Lifecycle
DESCRIPTION: This snippet describes the behavior and requirements when the `onDetachedFromActivity` method is invoked in an `ActivityAware` Flutter plugin. It emphasizes the need to clear references to the `Activity` and `ActivityPluginBinding` and to deregister any `Lifecycle` listeners to prevent memory leaks and other side effects.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityAware

LANGUAGE: APIDOC
CODE:
```
Method: onDetachedFromActivity()

Purpose:
  Indicates that an ActivityAware plugin has been detached from its FlutterView or FlutterEngine.

Behavior and Requirements:
  - The Activity that was made available in onAttachedToActivity(ActivityPluginBinding) is no longer valid.
  - Any references to the associated Activity or ActivityPluginBinding should be cleared.
  - Any Lifecycle listeners that were registered in onAttachedToActivity(ActivityPluginBinding) or onReattachedToActivityForConfigChanges(ActivityPluginBinding) should be deregistered here to avoid a possible memory leak and other side effects.
```

----------------------------------------

TITLE: FlutterEngine Class Member Reference
DESCRIPTION: Documents the full list of members (methods and properties) available in the FlutterEngine class, along with their originating or inherited classes/protocols. This reference is crucial for understanding the core functionalities of the Flutter iOS embedder.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine-members

LANGUAGE: APIDOC
CODE:
```
FlutterEngine Class:
  Description: Complete list of members for FlutterEngine, including inherited members.
  Members:
    - Type: Method
      Name: applicationDidEnterBackground:
      Inherited From: FlutterEngine(Test)
    - Type: Method
      Name: applicationWillEnterForeground:
      Inherited From: FlutterEngine(Test)
    - Type: Property
      Name: binaryMessenger
      Inherited From: FlutterEngine
    - Type: Method
      Name: destroyContext
      Inherited From: FlutterEngine
    - Type: Property
      Name: embedderAPI
      Inherited From: FlutterEngine(Test)
    - Type: Property
      Name: enableEmbedderAPI
      Inherited From: FlutterEngine(Test)
    - Type: Method
      Name: ensureSemanticsEnabled
      Inherited From: FlutterEngine
    - Type: Method
      Name: FLUTTER_DEPRECATED
      Inherited From: FlutterEngine
    - Type: Method
      Name: flutterTextInputView:performAction:withClient:
      Inherited From: FlutterEngine(Test)
    - Type: Method
      Name: hasPlugin:
      Inherited From: <FlutterPluginRegistry>
    - Type: Method
      Name: init
      Inherited From: FlutterEngine
    - Type: Method
      Name: initWithName:
      Inherited From: FlutterEngine
    - Type: Method
      Name: initWithName:project:
      Inherited From: FlutterEngine
    - Type: Method
      Name: initWithName:project:allowHeadlessExecution:
      Inherited From: FlutterEngine
    - Type: Method
      Name: initWithName:project:allowHeadlessExecution:restorationEnabled:
      Inherited From: FlutterEngine
    - Type: Property
      Name: isGpuDisabled
      Inherited From: FlutterEngine
    - Type: Property
      Name: isolateId
      Inherited From: FlutterEngine
    - Type: Property
      Name: keyEventChannel
      Inherited From: FlutterEngine
    - Type: Property
      Name: lifecycleChannel
      Inherited From: FlutterEngine
    - Type: Property
      Name: localizationChannel
      Inherited From: FlutterEngine
    - Type: Property
      Name: navigationChannel
      Inherited From: FlutterEngine
    - Type: Property
      Name: platformChannel
      Inherited From: FlutterEngine
    - Type: Method
      Name: platformView
      Inherited From: FlutterEngine(Test)
    - Type: Method
      Name: platformViewsRenderingAPI
      Inherited From: FlutterEngine(Test)
    - Type: Method
      Name: registrarForPlugin:
      Inherited From: <FlutterPluginRegistry>
    - Type: Property
      Name: restorationChannel
      Inherited From: FlutterEngine
    - Type: Method
      Name: run
      Inherited From: FlutterEngine
    - Type: Method
      Name: runWithEntrypoint:
      Inherited From: FlutterEngine
    - Type: Method
      Name: runWithEntrypoint:initialRoute:
      Inherited From: FlutterEngine
    - Type: Method
      Name: runWithEntrypoint:libraryURI:
      Inherited From: FlutterEngine
```

----------------------------------------

TITLE: Flutter Plugin: registerWithRegistrar: (Objective-C API)
DESCRIPTION: This static method registers the plugin using the context information and callback registration methods exposed by the given registrar. The registrar is obtained from a FlutterPluginRegistry and provides basic support for cross-plugin coordination. This method is typically called by an autogenerated plugin registrant to initialize the plugin and register callbacks with application objects.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_plugin-p

LANGUAGE: APIDOC
CODE:
```
+ (void) registerWithRegistrar: (NSObject< FlutterPluginRegistrar > *) registrar
  Parameters:
    registrar: NSObject<FlutterPluginRegistrar>* - A helper providing application context and methods for registering callbacks.
```

----------------------------------------

TITLE: FlutterEngine Class and Constants API Documentation
DESCRIPTION: Provides the API specification for the `FlutterEngine` class, including its purpose, behavior, and available initializers. It also documents the `FlutterDefaultDartEntrypoint` and `FlutterDefaultInitialRoute` constants, which are used to configure the Dart entry point and initial route for a Flutter application.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
Constants:
  FlutterDefaultDartEntrypoint: NSString* const
    Description: The dart entrypoint that is associated with `main()`. This is to be used as an argument to the `runWithEntrypoint*` methods.
  FlutterDefaultInitialRoute: NSString* const
    Description: The default Flutter initial route ("/").

Class: FlutterEngine : NSObject <FlutterPluginRegistry>
  Description: The FlutterEngine class coordinates a single instance of execution for a `FlutterDartProject`. It may have zero or one `FlutterViewController` at a time, which can be specified via `-setViewController:`. `FlutterViewController`'s `initWithEngine` initializer will automatically call `-setViewController:` for itself. A FlutterEngine can be created independently of a `FlutterViewController` for headless execution. It can also persist across the lifespan of multiple `FlutterViewController` instances to maintain state and/or asynchronous tasks (such as downloading a large file). A FlutterEngine can also be used to prewarm the Dart execution environment and reduce the latency of showing the Flutter screen when a `FlutterViewController` is created and presented. See http://flutter.dev/docs/development/add-to-app/performance for more details on loading performance. Alternatively, you can simply create a new `FlutterViewController` with only a `FlutterDartProject`. That `FlutterViewController` will internally manage its own instance of a FlutterEngine, but will not guarantee survival of the engine beyond the life of the ViewController. A newly initialized FlutterEngine will not actually run a Dart Isolate until either `-runWithEntrypoint:` or `-runWithEntrypoint:libraryURI` is invoked. One of these methods must be invoked before calling `-setViewController:`.

  Methods:
    - (instancetype)init
      Description: Default initializer for a FlutterEngine. Threads created by this FlutterEngine will appear as "FlutterEngine #" in Instruments. The prefix can be customized using `initWithName`. The engine will execute the project located in the bundle with the identifier "io.flutter.flutter.app" (the default for Flutter projects). A newly initialized engine will not run until either `-runWithEntrypoint:` or `-runWithEntrypoint:libraryURI:` is called. FlutterEngine created with this method will have allowHeadlessExecution set to `YES`. This means that the engine will continue to run regardless of whether a `FlutterViewController` is attached to it or not, until `-destroyContext:` is called or the process finishes.
```

----------------------------------------

TITLE: Flutter C++ EncodableValue Class and Usage Example
DESCRIPTION: The `EncodableValue` class is a C++ object designed to hold any value or collection type compatible with Flutter's standard method codec. It inherits from `internal::EncodableValueVariant` and provides constructors and operators for easy type handling. The example demonstrates how a Dart map structure translates to `EncodableValue` objects in C++.
SOURCE: https://api.flutter.dev/windows-embedder/encodable__value_8h_source

LANGUAGE: C++
CODE:
```
// An object that can contain any value or collection type supported by
// Flutter's standard method codec.
//
// For details, see:
// https://api.flutter.dev/flutter/services/StandardMessageCodec-class.html
//
// As an example, the following Dart structure:
// {
// 'flag': true,
// 'name': 'Thing',
// 'values': [1, 2.0, 4],
// }
// would correspond to:
// EncodableValue(EncodableMap{
// {EncodableValue("flag"), EncodableValue(true)},
// {EncodableValue("name"), EncodableValue("Thing")},
// {EncodableValue("values"), EncodableValue(EncodableList{
// EncodableValue(1),
// EncodableValue(2.0),
// EncodableValue(4),
// })},
// })
```

----------------------------------------

TITLE: Flutter Engine and Project API Definitions
DESCRIPTION: Defines core functions for creating and managing Flutter Dart projects and engine instances, along with an embedder API access point and a common error type used within the Flutter C/C++ API.
SOURCE: https://api.flutter.dev/linux-embedder/fl__scrolling__manager__test_8cc_source

LANGUAGE: APIDOC
CODE:
```
Function: fl_dart_project_new
  Signature: G_MODULE_EXPORT FlDartProject * fl_dart_project_new()
  Description: Creates a new Flutter Dart project instance.
  Returns: A pointer to a new FlDartProject object.

Function: fl_engine_get_embedder_api
  Signature: FlutterEngineProcTable * fl_engine_get_embedder_api(FlEngine *self)
  Description: Retrieves the embedder API table for a given Flutter engine instance.
  Parameters:
    self: A pointer to the FlEngine instance.
  Returns: A pointer to the FlutterEngineProcTable.

Function: fl_engine_start
  Signature: gboolean fl_engine_start(FlEngine *self, GError **error)
  Description: Starts the Flutter engine.
  Parameters:
    self: A pointer to the FlEngine instance.
    error: A pointer to a GError object to capture any errors.
  Returns: TRUE on success, FALSE on failure.

Function: fl_engine_new
  Signature: G_MODULE_EXPORT FlEngine * fl_engine_new(FlDartProject *project)
  Description: Creates a new Flutter engine instance associated with a Dart project.
  Parameters:
    project: A pointer to the FlDartProject instance.
  Returns: A pointer to a new FlEngine object.

Variable: error
  Type: const uint8_t uint32_t uint32_t GError **
  Description: A pointer to a GError object, typically used for error reporting in functions.
```

----------------------------------------

TITLE: FlutterEngine Class API Reference
DESCRIPTION: API documentation for the `flutter::FlutterEngine` class, which provides the interface for interacting with a Flutter engine instance. This class is used for running Dart projects, managing the engine's lifecycle, processing events, and integrating with the platform's plugin system.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__engine_8h_source

LANGUAGE: APIDOC
CODE:
```
class FlutterEngine : public PluginRegistry {
  // Constructor
  FlutterEngine(const DartProject& project)
    project: The Dart project to run with this engine.

  // Destructor
  virtual ~FlutterEngine()

  // Prevent copying
  FlutterEngine(FlutterEngine const&) = delete
  FlutterEngine& operator=(FlutterEngine const&) = delete

  // Methods
  bool Run()
    Description: Starts running the engine at the entrypoint function specified in the DartProject, or main() by default.
    Returns: true if the engine started successfully, false otherwise.

  bool Run(const char* entry_point)
    entry_point: The name of a top-level function from the same Dart library that contains the app's main() function. Must be decorated with `@pragma(vm:entry-point)`. If not provided, defaults to main().
    Description: Starts running the engine with an optional entry point.
    Returns: true if the engine started successfully, false otherwise.

  void ShutDown()
    Description: Terminates the running engine.

  std::chrono::nanoseconds ProcessMessages()
    Description: Processes any pending events in the Flutter engine. This should be called on every run of the application-level runloop.
    Returns: The nanosecond delay until the next scheduled event (or max, if none).

  void ReloadSystemFonts()
    Description: Tells the engine that the system font list has changed. Should be called by clients when OS-level font changes happen (e.g., WM_FONTCHANGE in a Win32 application).

  void ReloadPlatformBrightness()
    Description: Tells the engine that the platform brightness value has changed. Should be called by clients when OS-level theme changes happen (e.g., WM_DWMCOLORIZATIONCOLORCHANGED in a Win32 application).

  // Inherited from flutter::PluginRegistry
  FlutterDesktopPluginRegistrarRef GetRegistrarForPlugin(const std::string& plugin_name) override
    plugin_name: The name of the plugin.
    Description: Returns the messenger to use for creating channels to communicate with the Flutter engine.
    Returns: A reference to the plugin registrar.
```

----------------------------------------

TITLE: Run Dart Program on FlutterEngine Isolate
DESCRIPTION: Runs a Dart program on an Isolate from the main Dart library (i.e., the library that contains `main()`), using `main()` as the entrypoint and "/" as the initial route. The first call to this method creates a new Isolate; subsequent calls return immediately and have no effect. It returns YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
FlutterEngine:
  - (BOOL)run

Description:
  Runs a Dart program on an Isolate from the main Dart library (i.e. the library that contains main()), using main() as the entrypoint (the default for Flutter projects), and using "/" (the default route) as the initial route.
  The first call to this method will create a new Isolate. Subsequent calls will return immediately and have no effect.

Returns:
  YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

LANGUAGE: Objective-C
CODE:
```
{
  return [self runWithEntrypoint:FlutterDefaultDartEntrypoint
                        libraryURI:nil
                      initialRoute:FlutterDefaultInitialRoute];
}
```

----------------------------------------

TITLE: Flutter MethodResult Class API Reference
DESCRIPTION: Defines the `flutter::MethodResult` class, used to handle the result of a method call from the Flutter engine to the host platform.
SOURCE: https://api.flutter.dev/windows-embedder/platform__handler_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::MethodResult
  Definition: method_result.h:17
```

----------------------------------------

TITLE: Objective-C Extended FlutterStandardReader for Custom Type Deserialization
DESCRIPTION: Implements `ExtendedReader`, a subclass of `FlutterStandardReader`, to provide custom deserialization logic for `NSDate` and `Pair` objects. The `readValueOfType:` method uses a switch statement to handle custom type identifiers. For `kDATE`, it reads 8 bytes as a timestamp and reconstructs an `NSDate`. For `kPAIR`, it recursively reads the `left` and `right` components to construct a `Pair` object. For unknown types, it defers to the superclass's implementation.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: Objective-C
CODE:
```
@interface ExtendedReader : FlutterStandardReader
- (id)readValueOfType:(UInt8)type;
@end

@implementation ExtendedReader
- (id)readValueOfType:(UInt8)type {
 switch (type) {
 case kDATE: {
 SInt64 value;
 [self readBytes:&value length:8];
 NSTimeInterval time = [NSNumber numberWithLong:value].doubleValue / 1000.0;
 return [NSDate dateWithTimeIntervalSince1970:time];
 }
 case kPAIR: {
 return [[[Pair alloc] initWithLeft:[self readValue] right:[self readValue]]];
 }
 default:
 return [super readValueOfType:type];
 }
}
@end
```

----------------------------------------

TITLE: APIDOC: fl_engine_new Function
DESCRIPTION: Documentation for the `fl_engine_new` function, which creates a new `FlEngine` instance. The engine is the core component that runs the Flutter UI and logic.
SOURCE: https://api.flutter.dev/linux-embedder/fl__plugin__registrar__test_8cc_source

LANGUAGE: APIDOC
CODE:
```
Function: fl_engine_new
Signature: G_MODULE_EXPORT FlEngine * fl_engine_new(FlDartProject *project)
Parameters:
  project: Pointer to an FlDartProject instance.
Returns:
  FlEngine*: A new FlEngine instance.
Source: fl_engine.cc:584
```

----------------------------------------

TITLE: Control Android System UI Mode with Flutter
DESCRIPTION: The Flutter application would like the Android system to display the given `mode`. `PlatformChannel.SystemUiMode.LEAN_BACK` refers to a fullscreen experience that restores system bars upon tapping anywhere in the application. This tap gesture is not received by the application. `PlatformChannel.SystemUiMode.IMMERSIVE` refers to a fullscreen experience that restores system bars upon swiping from the edge of the viewport. This swipe gesture is not received by the application. `PlatformChannel.SystemUiMode.IMMERSIVE_STICKY` refers to a fullscreen experience that restores system bars upon swiping from the edge of the viewport. This swipe gesture is received by the application, in contrast to `PlatformChannel.SystemUiMode.IMMERSIVE`. `PlatformChannel.SystemUiMode.EDGE_TO_EDGE` refers to a layout configuration that will consume the full viewport. This full screen experience does not hide status bars. These status bars can be set to transparent, making the buttons and icons hover over the fullscreen application.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/PlatformChannel.PlatformMessageHandler

LANGUAGE: APIDOC
CODE:
```
void showSystemUiMode(@NonNull PlatformChannel.SystemUiMode mode)
```

----------------------------------------

TITLE: Dart Core Library: dart:convert
DESCRIPTION: Provides encoders and decoders for converting between different data representations, including JSON and UTF-8.
SOURCE: https://api.flutter.dev/index

LANGUAGE: APIDOC
CODE:
```
Library: dart:convert
Description: Encoders and decoders for converting between different data representations, including JSON and UTF-8.
```

----------------------------------------

TITLE: Flutter Engine Accessibility Toggle Test (C++)
DESCRIPTION: This comprehensive C++ test case verifies the Flutter engine's ability to toggle accessibility (semantics). It demonstrates how to set up a Flutter engine, mock embedder API callbacks (`Initialize`, `UpdateSemanticsEnabled`), create and configure a `FlutterViewController`, construct a sample semantics tree using `FlutterSemanticsNode2` objects, send semantics updates, and then verify the native accessibility tree's state. The test covers both enabling and disabling semantics, ensuring the view's accessibility children are correctly added and removed.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_test_8mm_source

LANGUAGE: C++
CODE:
```
TEST_F(FlutterEngineTest, CanToggleAccessibility) {
  FlutterEngine* engine = GetFlutterEngine();
  // Capture the update callbacks before the embedder API initializes.
  auto original_init = engine.embedderAPI.Initialize;
  std::function<void(const FlutterSemanticsUpdate2*, void*)> update_semantics_callback;
  engine.embedderAPI.Initialize = MOCK_ENGINE_PROC(
  Initialize, ([&update_semantics_callback, &original_init](
  size_t version, const FlutterRendererConfig* config,
  const FlutterProjectArgs* args, void* user_data, auto engine_out) {
  update_semantics_callback = args->update_semantics_callback2;
  return original_init(version, config, args, user_data, engine_out);
  }));
  EXPECT_TRUE(engine runWithEntrypoint:@"main"]);
  // Set up view controller.
  FlutterViewController* viewController = [[[FlutterViewController alloc] initWithEngine:engine
  nibName:nil
  bundle:nil];
  [viewController loadView];
  // Enable the semantics.
  bool enabled_called = false;
  engine.embedderAPI.UpdateSemanticsEnabled =
  MOCK_ENGINE_PROC(UpdateSemanticsEnabled, ([&enabled_called](auto engine, bool enabled) {
  enabled_called = enabled;
  return kSuccess;
  }));
  engine.semanticsEnabled = YES;
  EXPECT_TRUE(enabled_called);
  // Send flutter semantics updates.
  FlutterSemanticsNode2 root;
  root.id = 0;
  root.flags = static_cast<FlutterSemanticsFlag>(0);
  root.actions = static_cast<FlutterSemanticsAction>(0);
  root.text_selection_base = -1;
  root.text_selection_extent = -1;
  root.label = "root";
  root.hint = "";
  root.value = "";
  root.increased_value = "";
  root.decreased_value = "";
  root.tooltip = "";
  root.child_count = 1;
  int32_t children[] = {1};
  root.children_in_traversal_order = children;
  root.custom_accessibility_actions_count = 0;

  FlutterSemanticsNode2 child1;
  child1.id = 1;
  child1.flags = static_cast<FlutterSemanticsFlag>(0);
  child1.actions = static_cast<FlutterSemanticsAction>(0);
  child1.text_selection_base = -1;
  child1.text_selection_extent = -1;
  child1.label = "child 1";
  child1.hint = "";
  child1.value = "";
  child1.increased_value = "";
  child1.decreased_value = "";
  child1.tooltip = "";
  child1.child_count = 0;
  child1.custom_accessibility_actions_count = 0;

  FlutterSemanticsUpdate2 update;
  update.node_count = 2;
  FlutterSemanticsNode2* nodes[] = {&root, &child1};
  update.nodes = nodes;
  update.custom_action_count = 0;
  update_semantics_callback(&update, (__bridge void*)engine);

  // Verify the accessibility tree is attached to the flutter view.
  EXPECT_EQ(engine.viewController.flutterView.accessibilityChildren count], 1u);
  NSAccessibilityElement* native_root = engine.viewController.flutterView.accessibilityChildren[0];
  std::string root_label = [native_root.accessibilityLabel UTF8String];
  EXPECT_TRUE(root_label == "root");
  EXPECT_EQ(native_root.accessibilityRole, NSAccessibilityGroupRole);
  EXPECT_EQ([native_root.accessibilityChildren count], 1u);
  NSAccessibilityElement* native_child1 = native_root.accessibilityChildren[0];
  std::string child1_value = [native_child1.accessibilityValue UTF8String];
  EXPECT_TRUE(child1_value == "child 1");
  EXPECT_EQ(native_child1.accessibilityRole, NSAccessibilityStaticTextRole);
  EXPECT_EQ([native_child1.accessibilityChildren count], 0u);
  // Disable the semantics.
  bool semanticsEnabled = true;
  engine.embedderAPI.UpdateSemanticsEnabled =
  MOCK_ENGINE_PROC(UpdateSemanticsEnabled, ([&semanticsEnabled](auto engine, bool enabled) {
  semanticsEnabled = enabled;
  return kSuccess;
  }));
  engine.semanticsEnabled = NO;
  EXPECT_FALSE(semanticsEnabled);
  // Verify the accessibility tree is removed from the view.
}
```

----------------------------------------

TITLE: API Documentation: BasicMessageChannel.MessageHandler Interface
DESCRIPTION: Detailed API specification for the `BasicMessageChannel.MessageHandler<T>` interface, including its `onMessage` method signature, parameters, return type, and behavioral notes regarding message handling, replies, and exception management.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/BasicMessageChannel.MessageHandler

LANGUAGE: APIDOC
CODE:
```
Interface: BasicMessageChannel.MessageHandler<T>
  Enclosing class: BasicMessageChannel<T>
  Description: A handler of incoming messages.

  Method Summary:
    onMessage(T message, BasicMessageChannel.Reply<T> reply): void
      Description: Handles the specified message received from Flutter.

  Method Details:
    onMessage(@Nullable T message, @NonNull BasicMessageChannel.Reply<T> reply): void
      Description: Handles the specified message received from Flutter.
      Handler implementations must reply to all incoming messages, by submitting a single reply message to the given BasicMessageChannel.Reply. Failure to do so will result in lingering Flutter reply handlers. The reply may be submitted asynchronously and invoked on any thread.
      Any uncaught exception thrown by this method, or the preceding message decoding, will be caught by the channel implementation and logged, and a null reply message will be sent back to Flutter.
      Any uncaught exception thrown during encoding a reply message submitted to the BasicMessageChannel.Reply is treated similarly: the exception is logged, and a null reply is sent to Flutter.
      Parameters:
        message: T - the message, possibly null.
        reply: BasicMessageChannel.Reply<T> - a BasicMessageChannel.Reply for sending a single message reply back to Flutter.
```

----------------------------------------

TITLE: Platform Message Callback Signature (APIDOC)
DESCRIPTION: API definition for the static function signature of the platform message callback. This callback is responsible for processing incoming messages from the Flutter engine, including the channel, message data, and a response handle.
SOURCE: https://api.flutter.dev/linux-embedder/fl__binary__messenger_8cc_source

LANGUAGE: APIDOC
CODE:
```
static gboolean fl_binary_messenger_platform_message_cb(FlEngine *engine, const gchar *channel, GBytes *message, const FlutterPlatformMessageResponseHandle *response_handle, void *user_data)
```

----------------------------------------

TITLE: Flutter BinaryMessenger Class Reference (C++)
DESCRIPTION: Reference to the `flutter::BinaryMessenger` class, which is a core component in Flutter's platform channels, facilitating asynchronous message passing between Dart code and the host platform.
SOURCE: https://api.flutter.dev/macos-embedder/core__implementations_8cc_source

LANGUAGE: APIDOC
CODE:
```
binary_messenger_impl.h
flutter::BinaryMessenger
```

----------------------------------------

TITLE: Flutter MethodChannel Class API Reference
DESCRIPTION: Documents the `MethodChannel` class, a templated class within the `flutter` namespace, central to handling method calls between Flutter and the host platform in the C++ embedder.
SOURCE: https://api.flutter.dev/ios-embedder/method__channel_8h

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodChannel< T >
```

----------------------------------------

TITLE: Flutter Core API Reference
DESCRIPTION: This section provides a detailed reference for various Flutter core components, including macros, constants, interfaces, and their methods. It covers definitions, parameters, and return types for classes like `FlutterError`, `FlutterMethodCall`, `FlutterStandardMessageCodec`, and `FlutterStandardReader`, as well as utility functions and custom reader/writer interfaces.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: APIDOC
CODE:
```
FLUTTER_ASSERT_ARC:
  Definition: FlutterMacros.h:44
```

LANGUAGE: APIDOC
CODE:
```
kDATE:
  Type: static const UInt8
  Definition: flutter_standard_codec_unittest.mm:30
```

LANGUAGE: APIDOC
CODE:
```
TEST:
  Signature: TEST(FlutterStandardCodec, CanDecodeZeroLength)
  Definition: flutter_standard_codec_unittest.mm:119
```

LANGUAGE: APIDOC
CODE:
```
kPAIR:
  Type: static const UInt8
  Definition: flutter_standard_codec_unittest.mm:31
```

LANGUAGE: APIDOC
CODE:
```
CheckEncodeDecode:
  Signature: static void CheckEncodeDecode(id value, NSData *expectedEncoding)
  Definition: flutter_standard_codec_unittest.mm:92
```

LANGUAGE: APIDOC
CODE:
```
ExtendedReader:
  Definition: flutter_standard_codec_unittest.mm:57
```

LANGUAGE: APIDOC
CODE:
```
ExtendedReaderWriter:
  Definition: flutter_standard_codec_unittest.mm:79
```

LANGUAGE: APIDOC
CODE:
```
ExtendedWriter:
  Definition: flutter_standard_codec_unittest.mm:34
  Methods:
    writeValue:(id value)
      Definition: flutter_standard_codec_unittest.mm:38
```

LANGUAGE: APIDOC
CODE:
```
FlutterError:
  Definition: FlutterCodecs.h:247
  Methods:
    errorWithCode:message:details:(NSString *code, NSString *_Nullable message, id _Nullable details)
```

LANGUAGE: APIDOC
CODE:
```
FlutterMethodCall:
  Definition: FlutterCodecs.h:221
  Methods:
    methodCallWithMethodName:arguments:(NSString *method, id _Nullable arguments)
```

LANGUAGE: APIDOC
CODE:
```
FlutterStandardMessageCodec:
  Definition: FlutterCodecs.h:209
  Methods:
    codecWithReaderWriter:(FlutterStandardReaderWriter *readerWriter)
      Definition: FlutterStandardCodec.mm:24
```

LANGUAGE: APIDOC
CODE:
```
FlutterStandardMethodCodec:
  Definition: FlutterCodecs.h:469
```

LANGUAGE: APIDOC
CODE:
```
FlutterStandardReader:
  Definition: FlutterCodecs.h:133
  Methods:
    readValueOfType:(UInt8 type) -> nullable id
      Definition: FlutterStandardCodec.mm:429
    readBytes:length:(void *destination, NSUInteger length) -> void
      Definition: FlutterStandardCodec.mm:371
```

----------------------------------------

TITLE: Example: Setting up a Flutter View in a GTK Application
DESCRIPTION: This example demonstrates how to initialize a `FlDartProject`, create an `FlView` using `fl_view_new()`, add it to a GTK container, and set up binary messengers for channel and plugin communication.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8h

LANGUAGE: C
CODE:
```
FlDartProject *project = fl_dart_project_new ();
FlView *view = fl_view_new (project);
gtk_widget_show (GTK_WIDGET (view));
gtk_container_add (GTK_CONTAINER (parent), view);

FlBinaryMessenger *messenger = fl_engine_get_binary_messenger (fl_view_get_engine (view));
setup_channels_or_plugins (messenger);
```

----------------------------------------

TITLE: FlutterEngine Class API Reference
DESCRIPTION: Documents the FlutterEngine class, which encapsulates the core Flutter runtime and its various communication channels. It provides access to essential components like text input, navigation, and platform channels, as well as internal engine structures.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterEngine
  Definition: FlutterEngine.h:61
  Properties:
    textInputChannel: FlutterMethodChannel *
    navigationChannel: FlutterMethodChannel *
    keyEventChannel: FlutterBasicMessageChannel *
    lifecycleChannel: FlutterBasicMessageChannel *
    platformChannel: FlutterMethodChannel *
    localizationChannel: FlutterMethodChannel *
    isolateId: NSString *
    systemChannel: FlutterBasicMessageChannel *
    settingsChannel: FlutterBasicMessageChannel *
    restorationChannel: FlutterMethodChannel *
  Methods:
    platformView(): flutter::PlatformViewIOS *
    shell(): flutter::Shell &
```

----------------------------------------

TITLE: Flutter C++ MethodChannel Class API Reference
DESCRIPTION: API documentation for the `flutter::MethodChannel` class, which facilitates asynchronous method communication between the Flutter engine and the host platform. It includes details on its constructor and the `InvokeMethod` function.
SOURCE: https://api.flutter.dev/ios-embedder/method__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodChannel<T = EncodableValue>
  // A channel for communicating with the Flutter engine using invocation of asynchronous methods.

  // Constructor:
  MethodChannel(BinaryMessenger* messenger, const std::string& name, const MethodCodec<T>* codec)
    // Parameters:
    //   messenger: BinaryMessenger* - The messenger to dispatch messages through.
    //   name: const std::string& - The name of the channel.
    //   codec: const MethodCodec<T>* - The codec to use for encoding/decoding method calls.

  // Methods:
  void InvokeMethod(const std::string& method, std::unique_ptr<T> arguments, std::unique_ptr<MethodResult<T>> result = nullptr)
    // Sends a message to the Flutter engine on this channel.
    // Parameters:
    //   method: const std::string& - The name of the method to invoke.
    //   arguments: std::unique_ptr<T> - Optional arguments for the method call.
    //   result: std::unique_ptr<MethodResult<T>> - Optional result handler for the response.
    // Returns: void
```

----------------------------------------

TITLE: Initialize FlutterViewController with Dart Project
DESCRIPTION: A designated initializer that creates a new `FlutterViewController` and implicitly spins up a new `FlutterEngine` based on a provided `FlutterDartProject`. This method simplifies the setup process for embedding Flutter, with the newly created engine accessible via the `engine` property.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8h_source

LANGUAGE: Objective-C
CODE:
```
- (instancetype)initWithProject:(nullable FlutterDartProject*)project
 nibName:(nullable NSString*)nibName
 bundle:(nullable NSBundle*)nibBundle NS_DESIGNATED_INITIALIZER;
```

----------------------------------------

TITLE: Flutter C++ MethodChannel: SetMethodCallHandler
DESCRIPTION: This method sets a handler for incoming method calls on a `MethodChannel`. It decodes the raw binary message into a `MethodCall` object and dispatches it to the provided `MethodCallHandler`. It also manages unsetting the handler and handles decoding failures.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_method_channel

LANGUAGE: APIDOC
CODE:
```
template<typename T = EncodableValue>
void flutter::MethodChannel<T>::SetMethodCallHandler(MethodCallHandler<T> *handler) const
  handler: A pointer to the MethodCallHandler to set. If nullptr, the handler is unset.
```

LANGUAGE: C++
CODE:
```
{
  if (!handler) {
    messenger_->SetMessageHandler(name_, nullptr);
    return;
  }
  const auto* codec = codec_;
  std::string channel_name = name_;
  BinaryMessageHandler binary_handler = [handler, codec, channel_name](
    const uint8_t* message,
    size_t message_size,
    BinaryReply reply) {
    // Use this channel's codec to decode the call and build a result handler.
    auto result =
      std::make_unique<EngineMethodResult<T>>(std::move(reply), codec);
    std::unique_ptr<MethodCall<T>> method_call =
      codec->DecodeMethodCall(message, message_size);
    if (!method_call) {
      std::cerr << "Unable to construct method call from message on channel "
                << channel_name << std::endl;
      result->NotImplemented();
      return;
    }
    handler(*method_call, std::move(result));
  };
  messenger_->SetMessageHandler(name_, std::move(binary_handler));
}
```

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger::SetMessageHandler(const std::string &channel, BinaryMessageHandler handler)
  channel: The name of the channel.
  handler: The message handler to set.
  Returns: void
```

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessageHandler
  std::function<void(const uint8_t *message, size_t message_size, BinaryReply reply)>
```

----------------------------------------

TITLE: Run FlutterEngine Dart Program
DESCRIPTION: This method runs a Dart program on an Isolate from the main Dart library. It uses `main()` as the entrypoint and '/' as the initial route. The first call creates a new Isolate, and subsequent calls have no effect.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: Objective-C
CODE:
```
- (BOOL)run;
```

LANGUAGE: APIDOC
CODE:
```
Method: - (BOOL)run
Description: Runs a Dart program on an Isolate from the main Dart library (i.e. the library that contains main()), using main() as the entrypoint (the default for Flutter projects), and using "/" (the default route) as the initial route. The first call to this method will create a new Isolate. Subsequent calls will return immediately and have no effect.
Returns: BOOL - YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

----------------------------------------

TITLE: Open Web Search Query in iOS Default Browser
DESCRIPTION: This method constructs a search URL using a provided search term and opens it in the default browser via `UIApplication`. It includes a check to ensure the functionality is available outside of app extensions and properly URL-encodes the search term.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_plugin_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)searchWeb:(NSString*)searchTerm {
    UIApplication* flutterApplication = [FlutterSharedApplication application];
    if (flutterApplication == nil) {
        FML_LOG(WARNING) << "SearchWeb.invoke is not availabe in app extension.";
        return;
    }

    NSString* escapedText = [searchTerm
    stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
    URLHostAllowedCharacterSet]];
    NSString* searchURL = [NSString stringWithFormat:@"%@%@", kSearchURLPrefix, escapedText];

    [flutterApplication openURL:[NSURL URLWithString:searchURL] options:@{} completionHandler:nil];
}
```

----------------------------------------

TITLE: Initialize FlutterBasicMessageChannel with Task Queue
DESCRIPTION: The designated initializer for FlutterBasicMessageChannel, setting up the channel with a name, binary messenger, message codec, and an optional task queue for message handling.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (instancetype)initWithName:(NSString*)name
 binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
 codec:(NSObject<FlutterMessageCodec>*)codec
 taskQueue:(NSObject<FlutterTaskQueue>*)taskQueue {
 self = [super init];
 NSAssert(self, @"Super init cannot be nil");
 _name = [name copy];
 _messenger = messenger;
 _codec = codec;
 _taskQueue = taskQueue;
 return self;
}
```

----------------------------------------

TITLE: Pre-warm and Cache FlutterEngine for Performance
DESCRIPTION: This Java code snippet demonstrates how to create and initialize a FlutterEngine using FlutterEngineGroup, execute its default Dart entrypoint, and then store it in the FlutterEngineCache. This pre-warming and caching strategy helps reduce the startup delay when Flutter content is displayed, improving the user experience.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: Java
CODE:
```
 // Create and pre-warm a FlutterEngine.
 FlutterEngineGroup group = new FlutterEngineGroup(context);
 FlutterEngine flutterEngine = group.createAndRunDefaultEngine(context);
 flutterEngine.getDartExecutor().executeDartEntrypoint(DartEntrypoint.createDefault());

 // Cache the pre-warmed FlutterEngine in the FlutterEngineCache.
 FlutterEngineCache.getInstance().put("my_engine", flutterEngine);
```

----------------------------------------

TITLE: Invoke Flutter Method with Arguments and Asynchronous Result (Objective-C)
DESCRIPTION: Invokes a specified Flutter method with given arguments, expecting an asynchronous result. The callback handles the result, which can be a FlutterError, FlutterMethodNotImplemented, or a successful value.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_method_channel

LANGUAGE: Objective-C
CODE:
```
- (void) invokeMethod: (NSString *)method
             arguments: (id _Nullable)arguments
                result: (FlutterResult _Nullable)callback
```

LANGUAGE: APIDOC
CODE:
```
Parameters:
  method: The name of the method to invoke.
  arguments: The arguments. Must be a value supported by the codec of this channel.
  callback: A callback that will be invoked with the asynchronous result. The result will be a FlutterError instance, if the method call resulted in an error on the Flutter side. Will be FlutterMethodNotImplemented, if the method called was not implemented on the Flutter side. Any other value, including nil, should be interpreted as successful results.
```

----------------------------------------

TITLE: ARG_CACHED_ENGINE_ID
DESCRIPTION: This argument specifies the ID of a pre-cached `FlutterEngine` from `FlutterEngineCache` that should be used by the created `FlutterFragment`. This allows for faster startup times by reusing an existing engine instance.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: Java
CODE:
```
protected static final String ARG_CACHED_ENGINE_ID
```

----------------------------------------

TITLE: Objective-C FlutterBasicMessageChannel setMessageHandler:
DESCRIPTION: Registers a message handler with this channel. This handler will be invoked when messages are received from the Flutter side. Any existing handler will be replaced. Passing a `nil` handler will unregister the current handler.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_basic_message_channel

LANGUAGE: APIDOC
CODE:
```
Method: - (void) setMessageHandler:(FlutterMessageHandler _Nullable)handler
Parameters:
  handler: (FlutterMessageHandler _Nullable) The message handler.
```

----------------------------------------

TITLE: Android View Class Method Signatures
DESCRIPTION: A comprehensive list of method signatures from the `android.view.View` class, extracted from Android API documentation. This snippet serves as a quick reference for understanding the available functionalities and their parameter requirements.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformOverlayView

LANGUAGE: APIDOC
CODE:
```
Class: android.view.View

Methods:
- isScreenReaderFocusable()
- isScrollbarFadingEnabled()
- isScrollContainer()
- isSelected()
- isShowingLayoutBounds()
- isShown()
- isSoundEffectsEnabled()
- isTemporarilyDetached()
- isTextAlignmentResolved()
- isTextDirectionResolved()
- isVerticalFadingEdgeEnabled()
- isVerticalScrollBarEnabled()
- isVisibleToUserForAutofill(int)
- jumpDrawablesToCurrentState()
- keyboardNavigationClusterSearch(android.view.View, int)
- layout(int, int, int, int)
- measure(int, int)
- mergeDrawableStates(int[], int[])
- offsetLeftAndRight(int)
- offsetTopAndBottom(int)
- onAnimationEnd()
- onAnimationStart()
- onApplyWindowInsets(android.view.WindowInsets)
- onAttachedToWindow()
- onCancelPendingInputEvents()
- onCapturedPointerEvent(android.view.MotionEvent)
- onCheckIsTextEditor()
- onConfigurationChanged(android.content.res.Configuration)
- onCreateContextMenu(android.view.ContextMenu)
- onCreateDrawableState(int)
- onCreateInputConnection(android.view.inputmethod.EditorInfo)
- onCreateViewTranslationRequest(int[], java.util.function.Consumer)
- onCreateVirtualViewTranslationRequests(...) // Incomplete in source
```

----------------------------------------

TITLE: JSONMessageCodec
DESCRIPTION: MessageCodec with UTF-8 encoded JSON messages.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
JSONMessageCodec:
  Description: MessageCodec with UTF-8 encoded JSON messages.
```

----------------------------------------

TITLE: APIDOC: flutter::PluginRegistrar Class Definition
DESCRIPTION: Defines the `flutter::PluginRegistrar` class, which is central to managing plugins in Flutter desktop applications. It provides interfaces to the `BinaryMessenger` and `TextureRegistrar` for communication and texture management.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_plugin_registrar

LANGUAGE: APIDOC
CODE:
```
flutter::PluginRegistrar Class Reference
#include <plugin_registrar.h>

Public Member Functions:
  PluginRegistrar(FlutterDesktopPluginRegistrarRef core_registrar)
  virtual ~PluginRegistrar()
  PluginRegistrar(PluginRegistrar const &)=delete
  PluginRegistrar & operator=(PluginRegistrar const &)=delete
  BinaryMessenger * messenger()
  TextureRegistrar * texture_registrar()
  void AddPlugin(std::unique_ptr<Plugin> plugin)

Protected Member Functions:
  FlutterDesktopPluginRegistrarRef registrar() const
  void ClearPlugins()
```

----------------------------------------

TITLE: Creating a New Flutter Engine Instance with Full Configuration
DESCRIPTION: Constructs a new FlEngine instance with a specified FlDartProject and an optional FlBinaryMessenger. This function initializes core engine components such as the compositor, binary messenger, keyboard manager, mouse cursor handler, and windowing handler. It serves as the primary factory method for engine creation with comprehensive setup.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc_source

LANGUAGE: C++
CODE:
```
static FlEngine* fl_engine_new_full(FlDartProject* project,
FlBinaryMessenger* binary_messenger) {
g_return_val_if_fail(FL_IS_DART_PROJECT(project), nullptr);

FlEngine* self = FL_ENGINE(g_object_new(fl_engine_get_type(), nullptr));

self->project = FL_DART_PROJECT(g_object_ref(project));
self->compositor = FL_COMPOSITOR(fl_compositor_opengl_new(self));
if (binary_messenger != nullptr) {
self->binary_messenger =
FL_BINARY_MESSENGER(g_object_ref(binary_messenger));
} else {
self->binary_messenger = fl_binary_messenger_new(self);
}
self->keyboard_manager = fl_keyboard_manager_new(self);
self->mouse_cursor_handler =
fl_mouse_cursor_handler_new(self->binary_messenger);
self->windowing_handler = fl_windowing_handler_new(self);

return self;
}
```

----------------------------------------

TITLE: C++ BasicMessageChannel Handler Registration Test
DESCRIPTION: Unit test demonstrating the registration of a message handler for `BasicMessageChannel`. It verifies that `SetMessageHandler` correctly registers the handler with the `BinaryMessenger` and that incoming messages are properly decoded and processed by the registered callback, asserting the message content and reply availability.
SOURCE: https://api.flutter.dev/ios-embedder/basic__message__channel__unittests_8cc_source

LANGUAGE: C++
CODE:
```
TEST(BasicMessageChannelTest, Registration) {
  TestBinaryMessenger messenger;
  const std::string channel_name("some_channel");
  const StandardMessageCodec& codec = StandardMessageCodec::GetInstance();
  BasicMessageChannel channel(&messenger, channel_name, &codec);

  bool callback_called = false;
  const std::string message_value("hello");
  channel.SetMessageHandler(
      [&callback_called, message_value](const auto& message, auto reply) {
        callback_called = true;
        // Ensure that the wrapper received a correctly decoded message and a
        // reply.
        EXPECT_EQ(std::get<std::string>(message), message_value);
        EXPECT_NE(reply, nullptr);
      });
  EXPECT_EQ(messenger.last_message_handler_channel(), channel_name);
  EXPECT_NE(messenger.last_message_handler(), nullptr);
  // Send a test message to trigger the handler test assertions.
  auto message = codec.EncodeMessage(EncodableValue(message_value));

  messenger.last_message_handler()(
      message->data(), message->size(),
      [](const uint8_t* reply, const size_t reply_size) {});
  EXPECT_EQ(callback_called, true);
}
```

----------------------------------------

TITLE: FlutterMethodChannel Class Definition
DESCRIPTION: Definition of the 'FlutterMethodChannel' class. This class is crucial for platform channel communication, enabling Flutter applications to invoke platform-specific methods and receive results.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_app_delegate_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel
```

----------------------------------------

TITLE: FlutterEngine Class API Reference
DESCRIPTION: Documents the properties and methods of the FlutterEngine class, which manages the Flutter runtime and its communication channels within an iOS application. It includes various channels for different communication purposes and core engine functionalities.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterEngine:
  Properties:
    navigationChannel: FlutterMethodChannel *
    keyEventChannel: FlutterBasicMessageChannel *
    lifecycleChannel: FlutterBasicMessageChannel *
    platformChannel: FlutterMethodChannel *
    localizationChannel: FlutterMethodChannel *
    textureRegistry: NSObject< FlutterTextureRegistry > *
    isolateId: NSString *
    systemChannel: FlutterBasicMessageChannel *
    settingsChannel: FlutterBasicMessageChannel *
    observatoryUrl: NSURL * (DEPRECATED: Use vmServiceUrl instead)
    restorationChannel: FlutterMethodChannel *
    binaryMessenger: NSObject< FlutterBinaryMessenger > *
    isGpuDisabled: BOOL
  Methods:
    destroyContext(): void
    ensureSemanticsEnabled(): void
```

----------------------------------------

TITLE: TextInputType Class API Reference
DESCRIPTION: Detailed API documentation for the `TextInputType` class in Flutter's `services` library, including its constructors, properties, methods, operators, and constants.
SOURCE: https://api.flutter.dev/flutter/services/TextInputType-class

LANGUAGE: APIDOC
CODE:
```
TextInputType class
  Description: The type of information for which to optimize the text input control. On Android, behavior may vary across device and keyboard provider. This class stays as close to `Enum` interface as possible, and allows for additional flags for some input types. For example, numeric input can specify whether it supports decimal numbers and/or signed numbers.
  Annotations: @immutable

  Constructors:
    TextInputType.numberWithOptions({bool? signed = false, bool? decimal = false})
      Description: Optimize for numerical information.
      Modifiers: const

  Properties:
    decimal → bool?
      Description: The number is decimal, allowing a decimal point to provide fractional.
      Modifiers: final
    hashCode → int
      Description: The hash code for this object.
      Modifiers: no setter, override
    index → int
      Description: Enum value index, corresponds to one of the [values](services/TextInputType/values-constant.html).
      Modifiers: final
    runtimeType → Type
      Description: A representation of the runtime type of the object.
      Modifiers: no setter, inherited
    signed → bool?
      Description: The number is signed, allowing a positive or negative sign at the start.
      Modifiers: final

  Methods:
    noSuchMethod(Invocation invocation) → dynamic
      Description: Invoked when a nonexistent method or property is accessed.
      Modifiers: inherited
    toJson() → Map<String, dynamic>
      Description: Returns a representation of this object as a JSON object.
    toString() → String
      Description: A string representation of this object.
      Modifiers: override

  Operators:
    operator ==(Object other) → bool
      Description: The equality operator.
      Modifiers: override

  Constants:
    datetime → const TextInputType
      Description: Optimize for date and time information.
    emailAddress → const TextInputType
      Description: Optimize for email addresses.
    multiline → const TextInputType
      Description: Optimize for multiline textual information.
    name → const TextInputType
      Description: Optimized for a person's name.
    none → const TextInputType
      Description: Prevent the OS from showing the on-screen virtual keyboard.
    number → const TextInputType
      Description: Optimize for unsigned numerical information without a decimal point.
    phone → const TextInputType
      Description: Optimize for telephone numbers.
    streetAddress → const TextInputType
      Description: Optimized for postal mailing addresses.
    text → const TextInputType
      Description: Optimize for textual information.
    twitter → const TextInputType
      Description: Optimized for social media.
    url → const TextInputType
      Description: Optimize for URLs.
    values → const List<TextInputType>
      Description: All possible enum values.
    visiblePassword → const TextInputType
      Description: Optimize for passwords that are visible to the user.
    webSearch → const TextInputType
      Description: Optimized for web searches.
```

----------------------------------------

TITLE: Register Flutter Method Call Handler (Objective-C)
DESCRIPTION: Registers a handler for method calls originating from the Flutter side. This replaces any existing handler. Passing `nil` unregisters the current handler.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8h_source

LANGUAGE: Objective-C
CODE:
```
- (void)setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler;
```

----------------------------------------

TITLE: Flutter ModalRoute.of and Route.isCurrent API
DESCRIPTION: This API documentation details how to find the enclosing route using `ModalRoute.of` from inside a build method. It also explains how to check if the enclosing route is the active route using the `Route.isCurrent` property, which can be used to control UI elements like dimming when the route is not active.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
ModalRoute.of(BuildContext context)
  Obtains the enclosing modal route from inside a build method.

Route.isCurrent (property)
  Checks if the route is the active route.
  Usage: Determine if controls can be dimmed when the route is not active.
```

----------------------------------------

TITLE: Replace Current Route with restorablePushReplacement (Flutter Navigator API)
DESCRIPTION: Replaces the current route of the navigator that most tightly encloses the given context by pushing a new route and then disposing the previous route once the new route has finished animating in.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorablePushReplacement<T extends Object?, TO extends Object?>(
  context: BuildContext,
  routeBuilder: RestorableRouteBuilder<T>,
  {result: TO?, arguments: Object?}
) -> String
```

----------------------------------------

TITLE: Get FlutterEngine Dart Executor
DESCRIPTION: Retrieves the `DartExecutor` associated with this `FlutterEngine`. The `DartExecutor` is essential for executing Dart code and setting up message/method channels for communication between Android and Dart/Flutter.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine

LANGUAGE: APIDOC
CODE:
```
@NonNull
public DartExecutor getDartExecutor()
  Returns: The Dart execution context.
```

----------------------------------------

TITLE: Example: Create and Configure New Flutter Engine in Group Intent
DESCRIPTION: This Java code demonstrates how to initialize a `FlutterEngineGroup`, cache it, and then use `FlutterActivity.NewEngineInGroupIntentBuilder` to construct an `Intent` for launching a custom `FlutterActivity` subclass. It shows how to specify the Dart entrypoint, initial route, and background mode for the new Flutter engine.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity.NewEngineInGroupIntentBuilder

LANGUAGE: Java
CODE:
```
 // Create a FlutterEngineGroup, such as in the onCreate method of the Application.
 FlutterEngineGroup engineGroup = new FlutterEngineGroup(this);
 FlutterEngineGroupCache.getInstance().put("my_cached_engine_group_id", engineGroup);

 // Create a NewEngineInGroupIntentBuilder that would build an intent to start my custom FlutterActivity subclass.
 FlutterActivity.NewEngineInGroupIntentBuilder intentBuilder =
     new FlutterActivity.NewEngineInGroupIntentBuilder(
           MyFlutterActivity.class,
           app.engineGroupId);
 intentBuilder.dartEntrypoint("main")
     .initialRoute("/custom/route")
     .backgroundMode(BackgroundMode.transparent);
 startActivity(intentBuilder.build(context));
```

----------------------------------------

TITLE: Get Messenger for Flutter Desktop Engine
DESCRIPTION: Retrieves the messenger instance associated with the Flutter desktop engine. This messenger is used for sending and receiving messages between the Flutter engine and native code.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8h

LANGUAGE: APIDOC
CODE:
```
FlutterDesktopEngineGetMessenger(FlutterDesktopEngineRef engine) -> FlutterDesktopMessengerRef
```

----------------------------------------

TITLE: Flutter MethodChannel Class
DESCRIPTION: A channel for communicating with the Flutter engine using platform methods. It allows sending method calls to Flutter and receiving method calls from Flutter.
SOURCE: https://api.flutter.dev/windows-embedder/method__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodChannel
```

----------------------------------------

TITLE: Run Flutter Engine with Entrypoint and Configure Impeller (Objective-C/C++)
DESCRIPTION: This method attempts to run the Flutter engine with a specified entrypoint. It first checks if the engine is already running or if headless execution is disallowed without a view controller. It then adds internal plugins, prepares command-line arguments using `std::vector`, and conditionally enables Impeller based on project settings or command-line flags using `std::find`.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (BOOL)runWithEntrypoint:(NSString*)entrypoint {
  if (self.running) {
    return NO;
  }

  if (![_allowHeadlessExecution] && [[_viewControllers count] == 0]) {
    NSLog(@"Attempted to run an engine with no view controller without headless mode enabled.");
    return NO;
  }

  [self addInternalPlugins];

  // The first argument of argv is required to be the executable name.
  std::vector<const char*> argv = {[self.executableName UTF8String]};
  std::vector<std::string> switches = self.switches;

  // Enable Impeller only if specifically asked for from the project or cmdline arguments.
  if ([_project].enableImpeller ||
      std::find(switches.begin(), switches.end(), "--enable-impeller=true") != switches.end()) {
```

----------------------------------------

TITLE: Importing the Flutter Services Library
DESCRIPTION: This snippet shows the standard way to import the `services` library in a Dart file within a Flutter project, enabling access to platform-specific functionalities.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: Dart
CODE:
```
import 'package:flutter/services.dart';
```

----------------------------------------

TITLE: API Definition for flutter::BinaryMessenger Class
DESCRIPTION: Defines the abstract interface for the `flutter::BinaryMessenger` C++ class, including its destructor and pure virtual methods for sending binary messages and setting message handlers. This class is fundamental for communication between the Flutter engine and the host platform.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_binary_messenger

LANGUAGE: APIDOC
CODE:
```
class flutter::BinaryMessenger {
  // Header file
  #include <binary_messenger.h>

  // Public Member Functions

  // Destructor
  virtual ~BinaryMessenger() = default;
    // Description: Default virtual destructor for the BinaryMessenger class.

  // Method: Send
  virtual void Send(
    const std::string &channel,
    const uint8_t *message,
    size_t message_size,
    BinaryReply reply = nullptr
  ) const = 0;
    // Description: Sends a binary message over a specified channel.
    // Parameters:
    //   channel (const std::string &): The name of the channel to send the message on.
    //   message (const uint8_t *): Pointer to the raw binary message data.
    //   message_size (size_t): The size of the binary message data in bytes.
    //   reply (BinaryReply, optional): A callback function to be invoked with the reply from the receiver. Defaults to nullptr.
    // Returns: void
    // Constraints: Pure virtual, const method.
    // Implemented in: flutter::BinaryMessengerImpl

  // Method: SetMessageHandler
  virtual void SetMessageHandler(
    const std::string &channel,
    BinaryMessageHandler handler
  ) = 0;
    // Description: Sets a message handler for a specific channel to receive incoming binary messages.
    // Parameters:
    //   channel (const std::string &): The name of the channel to set the handler for.
    //   handler (BinaryMessageHandler): The callback function to handle incoming messages on the specified channel.
    // Returns: void
    // Constraints: Pure virtual.
    // Implemented in: flutter::BinaryMessengerImpl
}
```

----------------------------------------

TITLE: FlutterMethodChannel Class API Reference (Objective-C)
DESCRIPTION: Detailed API documentation for the `FlutterMethodChannel` class in Objective-C, which facilitates communication between Flutter and the host platform. It includes class properties, factory methods for channel creation, various initializers, and methods for invoking platform methods with or without result callbacks.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8mm_source

LANGUAGE: APIDOC
CODE:
```
@implementation FlutterMethodChannel
  Properties:
    _messenger: NSObject<FlutterBinaryMessenger>*
    _name: NSString*
    _codec: NSObject<FlutterMethodCodec>*
    _connection: FlutterBinaryMessengerConnection
    _taskQueue: NSObject<FlutterTaskQueue>*

  Class Methods:
    + methodChannelWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
      Description: Creates a FlutterMethodChannel with a default standard method codec.
      Parameters:
        name: NSString* - The name of the channel.
        messenger: NSObject<FlutterBinaryMessenger>* - The binary messenger.
      Returns: instancetype
      Code:
        NSObject<FlutterMethodCodec>* codec = [[FlutterStandardMethodCodec alloc] sharedInstance];
        return [FlutterMethodChannel methodChannelWithName:name binaryMessenger:messenger codec:codec];

    + methodChannelWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger codec:(NSObject<FlutterMethodCodec>*)codec
      Description: Creates a FlutterMethodChannel with a specified method codec.
      Parameters:
        name: NSString* - The name of the channel.
        messenger: NSObject<FlutterBinaryMessenger>* - The binary messenger.
        codec: NSObject<FlutterMethodCodec>* - The method codec to use.
      Returns: instancetype
      Code:
        return [[FlutterMethodChannel alloc] initWithName:name binaryMessenger:messenger codec:codec];

  Instance Methods:
    - initWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger codec:(NSObject<FlutterMethodCodec>*)codec
      Description: Initializes a FlutterMethodChannel with a specified codec and no task queue.
      Parameters:
        name: NSString* - The name of the channel.
        messenger: NSObject<FlutterBinaryMessenger>* - The binary messenger.
        codec: NSObject<FlutterMethodCodec>* - The method codec to use.
      Returns: instancetype
      Code:
        self = [self initWithName:name binaryMessenger:messenger codec:codec taskQueue:nil];
        return self;

    - initWithName:(NSString*)name binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger codec:(NSObject<FlutterMethodCodec>*)codec taskQueue:(NSObject<FlutterTaskQueue>*)taskQueue
      Description: Initializes a FlutterMethodChannel with a specified codec and task queue.
      Parameters:
        name: NSString* - The name of the channel.
        messenger: NSObject<FlutterBinaryMessenger>* - The binary messenger.
        codec: NSObject<FlutterMethodCodec>* - The method codec to use.
        taskQueue: NSObject<FlutterTaskQueue>* - The task queue for method calls.
      Returns: instancetype
      Code:
        self = [super init];
        NSAssert(self, @"Super init cannot be nil");
        _name = [name copy];
        _messenger = messenger;
        _codec = codec;
        _taskQueue = taskQueue;
        return self;

    - (void)invokeMethod:(NSString*)method arguments:(id)arguments
      Description: Invokes a method on the channel without expecting a result.
      Parameters:
        method: NSString* - The name of the method to invoke.
        arguments: id - The arguments for the method call.
      Returns: void
      Code:
        FlutterMethodCall* methodCall = [FlutterMethodCall methodCallWithMethodName:method arguments:arguments];
        NSData* message = [_codec encodeMethodCall:methodCall];
        [_messenger sendOnChannel:_name message:message];

    - (void)invokeMethod:(NSString*)method arguments:(id)arguments result:(FlutterResult)callback
      Description: Invokes a method on the channel and provides a callback for the result.
      Parameters:
        method: NSString* - The name of the method to invoke.
        arguments: id - The arguments for the method call.
        callback: FlutterResult - A block to be called with the method invocation result.
      Returns: void
      Code:
        FlutterMethodCall* methodCall = [FlutterMethodCall methodCallWithMethodName:method arguments:arguments];
        NSData* message = [_codec encodeMethodCall:methodCall];
        FlutterBinaryReply reply = ^(NSData* data) {
          if (callback) {
            callback((data == nil) ? FlutterMethodNotImplemented : [[_codec] decodeEnvelope:data]);
          }
        };
        [_messenger sendOnChannel:_name message:message binaryReply:reply];
@end
```

----------------------------------------

TITLE: Flutter: Register Binary Message Handler on Channel
DESCRIPTION: Registers a message handler for incoming binary messages from the Flutter side on the specified channel. This method replaces any existing handler. Passing a `nil` handler will unregister the existing one.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_binary_messenger-p

LANGUAGE: APIDOC
CODE:
```
Method: - (FlutterBinaryMessengerConnection) setMessageHandlerOnChannel:(NSString *)channel binaryMessageHandler:(FlutterBinaryMessageHandler _Nullable)handler
Parameters:
  channel: (NSString *) The channel name.
  handler: (FlutterBinaryMessageHandler _Nullable) The message handler.
Returns:
  (FlutterBinaryMessengerConnection) An identifier that represents the connection that was just created to the channel.
```

----------------------------------------

TITLE: Define FlutterViewController Interface
DESCRIPTION: The Objective-C interface definition for `FlutterViewController`, a `UIViewController` subclass designed to host Flutter content. It conditionally conforms to `UIGestureRecognizerDelegate` based on the iOS version, and always conforms to `FlutterTextureRegistry` and `FlutterPluginRegistry`.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8h_source

LANGUAGE: Objective-C
CODE:
```
#ifdef __IPHONE_13_4
@interface FlutterViewController
 : UIViewController <FlutterTextureRegistry, FlutterPluginRegistry, UIGestureRecognizerDelegate>
#else
@interface FlutterViewController : UIViewController <FlutterTextureRegistry, FlutterPluginRegistry>
#endif
```

----------------------------------------

TITLE: Encode and Decode Success Envelope with Single Result
DESCRIPTION: This example demonstrates encoding a single integer value into a success envelope using `FlutterStandardMethodCodec`. The encoded data is then decoded, and the original and decoded values are compared for equality.
SOURCE: https://api.flutter.dev/ios-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: Objective-C
CODE:
```
NSData* encoded = [codec encodeSuccessEnvelope:@42];
id decoded = [codec decodeEnvelope:encoded];
ASSERT_TRUE([decoded isEqual:@42]);
```

----------------------------------------

TITLE: Objective-C FlutterBasicMessageChannel sendMessage:reply:
DESCRIPTION: Sends a message from the native side to the Flutter side, expecting an asynchronous reply. The message must be supported by the channel's codec, and a callback is provided to handle the reply from Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_basic_message_channel

LANGUAGE: APIDOC
CODE:
```
Method: - (void) sendMessage:(id _Nullable)message reply:(FlutterReply _Nullable)callback
Parameters:
  message: (id _Nullable) The message. Must be supported by the codec of this channel.
  callback: (FlutterReply _Nullable) A callback to be invoked with the message reply from Flutter.
```

----------------------------------------

TITLE: Flutter MethodResult Class API Reference and Declarations
DESCRIPTION: This snippet provides the C++ declarations for key virtual methods within the `flutter::MethodResult` class, alongside a comprehensive structured API reference detailing all its public and internal members, including constructors, methods for success/error handling, and their parameters.
SOURCE: https://api.flutter.dev/linux-embedder/method__result_8h_source

LANGUAGE: C++
CODE:
```
virtual void ErrorInternal(const std::string& error_code,
  const std::string& error_message,
  const T* error_details) = 0;

// Implementation of the public interface, to be provided by subclasses.
virtual void NotImplementedInternal() = 0;
};
```

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodResult
  Definition: method_result.h:17

  Methods:
    ErrorInternal(const std::string &error_code, const std::string &error_message, const T *error_details)
      Type: virtual void
      Description: Internal virtual method to handle errors with a code, message, and optional details.

    NotImplementedInternal()
      Type: virtual void
      Description: Internal virtual method for subclasses to implement when a method is not implemented.

    SuccessInternal(const T *result)
      Type: virtual void
      Description: Internal virtual method to handle successful results with optional details.

    NotImplemented()
      Type: void
      Definition: method_result.h:59
      Description: Public method to indicate that a method call was not implemented.

    Error(const std::string &error_code, const std::string &error_message, const T &error_details)
      Type: void
      Definition: method_result.h:41
      Description: Public method to report an error with a specific code, message, and detailed error object.

    Error(const std::string &error_code, const std::string &error_message="")
      Type: void
      Definition: method_result.h:52
      Description: Public method to report an error with a specific code and an optional message.

    Success(const T &result)
      Type: void
      Definition: method_result.h:29
      Description: Public method to report a successful result with a return object.

    Success()
      Type: void
      Definition: method_result.h:33
      Description: Public method to report a successful result without a return object.

  Constructors:
    MethodResult(MethodResult const &) = delete
      Description: Deleted copy constructor to prevent copying.

    MethodResult() = default
      Description: Default constructor.

  Operators:
    operator=(MethodResult const &) = delete
      Description: Deleted assignment operator to prevent assignment.

  Destructor:
    ~MethodResult() = default
      Type: virtual
      Description: Default virtual destructor.
```

----------------------------------------

TITLE: FlutterMessageCodec encode: Instance Method
DESCRIPTION: Encodes the specified Objective-C object (id) into binary data (NSData). Returns nil if the input message is nil.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_message_codec-p

LANGUAGE: APIDOC
CODE:
```
Method: - (NSData* _Nullable) encode: (id _Nullable) message
  Description: Encodes the specified message into binary.
  Parameters:
    message: (id _Nullable) The message to encode.
  Returns:
    (NSData* _Nullable) The binary encoding, or nil, if message was nil.
```

----------------------------------------

TITLE: Run Flutter Windows Engine
DESCRIPTION: Initiates the execution of the Flutter Windows Engine, starting the Flutter UI and logic.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::FlutterWindowsEngine::Run() -> bool
```

----------------------------------------

TITLE: flutter::FlutterEngine Class Definition
DESCRIPTION: Defines the `FlutterEngine` class, which represents an instance of the Flutter engine. It provides core functionalities for managing the engine lifecycle and interacting with the Flutter runtime.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__engine_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::FlutterEngine {
  // Definition: flutter_engine.h:28
}
```

----------------------------------------

TITLE: Flutter: Popping the Current Route from Navigator
DESCRIPTION: This snippet demonstrates how to remove the current route from the navigation stack, revealing the previous route. The `Navigator.pop` method is used to achieve this, often triggered by a button press or the system back button.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
Navigator.pop(context);
```

----------------------------------------

TITLE: FlutterMessageCodec Protocol Definition
DESCRIPTION: Defines a generic message encoding/decoding mechanism for Flutter, providing methods to encode and decode messages between Dart and native platforms. It serves as a base for specific codec implementations.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_codecs_8h_source

LANGUAGE: APIDOC
CODE:
```
protocol FlutterMessageCodec:
  + (instancetype)sharedInstance
    Returns a shared instance of this `FlutterMessageCodec`.
  - (NSData* _Nullable)encode:(id _Nullable)message
    Encodes the specified message into binary.
    Parameters:
      message: The message.
    Returns: The binary encoding, or `nil`, if `message` was `nil`.
  - (id _Nullable)decode:(NSData* _Nullable)message
    Decodes the specified message from binary.
    Parameters:
      message: The message.
    Returns: The decoded message, or `nil`, if `message` was `nil`.
```

----------------------------------------

TITLE: Flutter: Basic App Setup with MaterialApp Home Route
DESCRIPTION: This snippet demonstrates the basic setup of a Flutter application using `MaterialApp`. The `home` property defines the initial route that appears when the app is launched, serving as the bottom of the Navigator's stack.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
void main() {
  runApp(const MaterialApp(home: MyAppHome()));
}
```

----------------------------------------

TITLE: Manage Back Press Events for FlutterFragment
DESCRIPTION: Configures whether the FlutterFragment should automatically process onBackPressed() events. If set to true, the fragment handles back presses internally; otherwise, explicit activity calls are required.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.NewEngineInGroupFragmentBuilder

LANGUAGE: APIDOC
CODE:
```
shouldAutomaticallyHandleOnBackPressed(shouldAutomaticallyHandleOnBackPressed: boolean)
```

----------------------------------------

TITLE: Flutter Navigator Pop and Route Handling
DESCRIPTION: This Dart code snippet demonstrates how to pop the current route using `Navigator.of(context).pop()` within a nested Navigator, effectively returning to a previous route like the home page. It also illustrates a `switch` statement for handling different route settings and returning a `MaterialPageRoute`.
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: Dart
CODE:
```
                    // nested Navigator that it created. Therefore, this pop()
                    // will pop the entire "sign up" journey and return to the
                    // "/" route, AKA HomePage.
                    Navigator.of(context).pop();
                  },
                );
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
```

----------------------------------------

TITLE: FlutterMethodChannel API Reference
DESCRIPTION: Documentation for the FlutterMethodChannel class, used for invoking methods between Flutter and platform.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel:
  + methodChannelWithName:binaryMessenger:codec:(NSString *name, NSObject<FlutterBinaryMessenger> *messenger, NSObject<FlutterMethodCodec> *codec): instancetype
```

----------------------------------------

TITLE: Offset Class
DESCRIPTION: An immutable 2D floating-point offset, commonly used to represent positions or translations in a 2D coordinate system.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
Offset: An immutable 2D floating-point offset.
```

----------------------------------------

TITLE: FlutterEngine Property: binaryMessenger
DESCRIPTION: The FlutterBinaryMessenger associated with this FlutterEngine, used for communicating with channels.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
Property: binaryMessenger
  Type: NSObject< FlutterBinaryMessenger > *
  Attributes: readnonatomicassign
```

----------------------------------------

TITLE: APIDOC: FlutterMethodChannel Interface
DESCRIPTION: Represents a communication channel for invoking methods on the host platform from Flutter, and vice-versa. It allows setting a handler for incoming method calls.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_restoration_plugin_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodChannel
  Definition: FlutterChannels.h:221
  Methods:
    setMethodCallHandler:(FlutterMethodCallHandler _Nullable handler)
      Description: Sets the method call handler for this channel.
      Parameters:
        handler: FlutterMethodCallHandler _Nullable - The handler to be invoked when a method call is received.
```

----------------------------------------

TITLE: flutter::BinaryMessenger::Send Method
DESCRIPTION: Sends a binary message over a specified channel. This is a pure virtual method that must be implemented by derived classes. It allows for an optional reply handler to process responses.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_binary_messenger-members

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger::Send
  Parameters:
    channel: const std::string & - The channel name to send the message on.
    message: const uint8_t * - A pointer to the binary message data.
    message_size: size_t - The size of the binary message data in bytes.
    reply: BinaryReply - An optional callback function to handle the reply (defaults to nullptr).
  Return Type: void
  Description: Pure virtual method to send a binary message over a channel.
```

----------------------------------------

TITLE: Run Dart Program on Flutter Isolate
DESCRIPTION: These methods initiate the execution of a Dart program on a new or existing Flutter Engine Isolate. The first invocation of any of these methods will create a new Isolate; subsequent calls will return immediately without further effect. They provide various options to specify the Dart entrypoint, the containing Dart library, and the initial navigation route within the Flutter application.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
- (BOOL)runWithEntrypoint:(nullable NSString*)entrypoint
  entrypoint: The name of a top-level function from the same Dart library that contains the app's main() function. If this is FlutterDefaultDartEntrypoint (or nil), it will default to `main()`. If it is not the app's main() function, that function must be decorated with `@pragma(vm:entry-point)` to ensure the method is not tree-shaken by the Dart compiler.
  Returns: YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

LANGUAGE: APIDOC
CODE:
```
- (BOOL)runWithEntrypoint:(nullable NSString*)entrypoint initialRoute:(nullable NSString*)initialRoute
  entrypoint: The name of a top-level function from the same Dart library that contains the app's main() function. If this is FlutterDefaultDartEntrypoint (or nil), it will default to `main()`. If it is not the app's main() function, that function must be decorated with `@pragma(vm:entry-point)` to ensure the method is not tree-shaken by the Dart compiler.
  initialRoute: The name of the initial Flutter `Navigator` `Route` to load. If this is FlutterDefaultInitialRoute (or nil), it will default to the "/" route.
  Returns: YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

LANGUAGE: APIDOC
CODE:
```
- (BOOL)runWithEntrypoint:(nullable NSString*)entrypoint libraryURI:(nullable NSString*)uri
  entrypoint: The name of a top-level function from a Dart library. If this is FlutterDefaultDartEntrypoint (or nil), this will default to `main()`. If it is not the app's main() function, that function must be decorated with `@pragma(vm:entry-point)` to ensure the method is not tree-shaken by the Dart compiler.
  uri: The URI of the Dart library which contains the entrypoint method (example "package:foo_package/main.dart"). If nil, this will default to the same library as the `main()` function in the Dart program.
  Returns: YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

LANGUAGE: APIDOC
CODE:
```
- (BOOL)runWithEntrypoint:(nullable NSString*)entrypoint libraryURI:(nullable NSString*)libraryURI initialRoute:(nullable NSString*)initialRoute
  entrypoint: The name of a top-level function from a Dart library. If this is FlutterDefaultDartEntrypoint (or nil), this will default to `main()`. If it is not the app's main() function, that function must be decorated with `@pragma(vm:entry-point)` to ensure the method is not tree-shaken by the Dart compiler.
  libraryURI: The URI of the Dart library which contains the entrypoint method (example "package:foo_package/main.dart"). If nil, this will default to the same library as the `main()` function in the Dart program.
  initialRoute: The name of the initial Flutter `Navigator` `Route` to load. If this is FlutterDefaultInitialRoute (or nil), it will default to the "/" route.
  Returns: YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

----------------------------------------

TITLE: Run Dart Program with Specific Library URI
DESCRIPTION: Runs a Dart program on an Isolate using a specified entrypoint and Dart library URI, which may differ from the main library. The first call creates a new Isolate; subsequent calls have no effect.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
Method: - (BOOL) runWithEntrypoint:(nullable NSString *)entrypoint libraryURI:(nullable NSString *)uri
Description: Runs a Dart program on an Isolate using the specified entrypoint and Dart library, which may not be the same as the library containing the Dart program's `main()` function. The first call to this method will create a new Isolate. Subsequent calls will return immediately and have no effect.
Parameters:
  entrypoint: (nullable NSString *) - The name of a top-level function from a Dart library. If this is FlutterDefaultDartEntrypoint (or nil); this will default to `main()`. If it is not the app's main() function, that function must be decorated with `@pragma(vm:entry-point)` to ensure the method is not tree-shaken by the Dart compiler.
  uri: (nullable NSString *) - The URI of the Dart library which contains the entrypoint method (example "package:foo_package/main.dart"). If nil, this will default to the same library as the `main()` function in the Dart program.
Returns: BOOL - YES if the call succeeds in creating and running a Flutter Engine instance; NO otherwise.
```

----------------------------------------

TITLE: EventChannel setStreamHandler Method
DESCRIPTION: Registers a stream handler for the EventChannel to manage incoming stream setup requests and event handling. This method overrides any existing handler and allows for deregistration by passing null.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/EventChannel

LANGUAGE: APIDOC
CODE:
```
EventChannel:
  Method: setStreamHandler
    @UiThread
    public void setStreamHandler(EventChannel.StreamHandler handler)
      handler: a EventChannel.StreamHandler, or null to deregister.
```

----------------------------------------

TITLE: APIDOC: FlutterEngine Class and runWithEntrypoint Method
DESCRIPTION: API documentation for the FlutterEngine class, which manages the Flutter runtime, and its runWithEntrypoint method, used to start the Flutter application.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_plugin_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterEngine:
  Definition: interface_flutter_engine.html
  Source: FlutterEngine.h:61
  Methods:
    runWithEntrypoint:
      Signature: BOOL runWithEntrypoint:(nullable NSString *entrypoint)
      Description: Runs the Flutter engine with an optional entrypoint.
      Source: interface_flutter_engine.html#a019d6b3037eff6cfd584fb2eb8e9035e
```

----------------------------------------

TITLE: io.flutter.plugin.common.StandardMethodCodec Class
DESCRIPTION: The `StandardMethodCodec` class provides a standard binary encoding for method calls and results, implementing the `MethodCodec` interface for communication between Flutter and the host platform.
SOURCE: https://api.flutter.dev/javadoc/overview-tree

LANGUAGE: APIDOC
CODE:
```
Class: io.flutter.plugin.common.StandardMethodCodec
Implements: io.flutter.plugin.common.MethodCodec
```

----------------------------------------

TITLE: FlutterBinaryMessenger Protocol Definition
DESCRIPTION: Defines the FlutterBinaryMessenger protocol, an interface for sending and receiving binary messages between Flutter and the host platform.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8mm_source

LANGUAGE: APIDOC
CODE:
```
protocol FlutterBinaryMessenger
```

----------------------------------------

TITLE: EventChannel Class API Documentation (Java)
DESCRIPTION: Detailed API documentation for the `io.flutter.plugin.common.EventChannel` class, including its purpose, nested interfaces, constructors, and methods for handling asynchronous event streams between Flutter and Java.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/EventChannel

LANGUAGE: APIDOC
CODE:
```
Class: EventChannel
  Package: io.flutter.plugin.common
  Extends: java.lang.Object

  Description: A named channel for communicating with the Flutter application using asynchronous event streams. Incoming requests for event stream setup are decoded from binary on receipt, and Java responses and events are encoded into binary before being transmitted back to Flutter. The MethodCodec used must be compatible with the one used by the Flutter application. This can be achieved by creating an EventChannel counterpart of this channel on the Dart side. The Java type of stream configuration arguments, events, and error details is Object, but only values supported by the specified MethodCodec can be used. The logical identity of the channel is given by its name. Identically named channels will interfere with each other's communication.

  Nested Classes:
    - EventChannel.EventSink (static interface)
      Description: Event callback.
    - EventChannel.StreamHandler (static interface)
      Description: Handler of stream setup and teardown requests.

  Constructors:
    - EventChannel(BinaryMessenger messenger, String name)
      Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and the standard MethodCodec.
      Parameters:
        - messenger: io.flutter.plugin.common.BinaryMessenger
        - name: java.lang.String

    - EventChannel(BinaryMessenger messenger, String name, MethodCodec codec)
      Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and MethodCodec.
      Parameters:
        - messenger: io.flutter.plugin.common.BinaryMessenger
        - name: java.lang.String
        - codec: io.flutter.plugin.common.MethodCodec

    - EventChannel(BinaryMessenger messenger, String name, MethodCodec codec, BinaryMessenger.TaskQueue taskQueue)
      Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and MethodCodec.
      Parameters:
        - messenger: io.flutter.plugin.common.BinaryMessenger
        - name: java.lang.String
        - codec: io.flutter.plugin.common.MethodCodec
        - taskQueue: io.flutter.plugin.common.BinaryMessenger.TaskQueue

  Methods:
    - setStreamHandler(EventChannel.StreamHandler handler): void
      Description: Registers a stream handler on this channel.
      Parameters:
        - handler: io.flutter.plugin.common.EventChannel.StreamHandler

  Inherited Methods:
    - From class java.lang.Object
```

----------------------------------------

TITLE: FlutterViewController Class API Reference
DESCRIPTION: Detailed API documentation for the `FlutterViewController` class, which serves as the primary `UIViewController` for embedding Flutter content within an iOS application. It outlines its core responsibilities, including managing Dart execution, channel communication, and plugin integration, all delegated to an underlying `FlutterEngine`.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterViewController:
  Inherits From: UIViewController
  Conforms To: FlutterTextureRegistry, FlutterPluginRegistry, UIGestureRecognizerDelegate (conditionally for iOS 13.4+)
  Description: A UIViewController implementation for Flutter views. It handles Dart execution, channel communication, texture registration, and plugin registration by proxying through to the FlutterEngine attached to it.
  Usage Notes: Can be initialized with an already-running FlutterEngine to reduce first-frame latency, or with a FlutterDartProject to implicitly spin up a new engine. Holding a FlutterEngine independently can preserve Dart-related state across UIViewController navigations.
```

----------------------------------------

TITLE: FlutterBinaryMessenger Protocol API Reference
DESCRIPTION: Defines the FlutterBinaryMessenger protocol, a fundamental interface in Flutter for facilitating asynchronous, bidirectional communication of binary messages between Dart code and the host platform (e.g., iOS/Android native code).
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_view_controller_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterBinaryMessenger-p
  Definition: FlutterBinaryMessenger.h:49
```

----------------------------------------

TITLE: Objective-C: Handle Flutter Platform Method Calls
DESCRIPTION: This Objective-C method `handleMethodCall:result:` is the entry point for method calls from the Flutter engine to the native platform. It dispatches calls based on the method name (e.g., 'SystemSound.play', 'Clipboard.getData') to corresponding native helper methods, and then returns the result (or nil) back to Flutter using the `result` callback. It handles a wide range of system interactions.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_platform_plugin

LANGUAGE: Objective-C
CODE:
```
107 :([FlutterMethodCall](interface_flutter_method_call.html)*)call result:([FlutterResult](_flutter_channels_8h.html#a176fc39d0995b8c56ee32265cf721b74))result {
108  NSString* method = call.[method](interface_flutter_method_call.html#adc8230a486a57c04d24b730f0631bacc);
109  id args = call.[arguments](interface_flutter_method_call.html#affc314ee5131dea76dd35df418f7dca5);
110  if ([method isEqualToString:@"SystemSound.play"]) {
111  [self playSystemSound:args];
112  result(nil);
113  } else if ([method isEqualToString:@"HapticFeedback.vibrate"]) {
114  [self vibrateHapticFeedback:args];
115  result(nil);
116  } else if ([method isEqualToString:@"SystemChrome.setPreferredOrientations"]) {
117  [self setSystemChromePreferredOrientations:args];
118  result(nil);
119  } else if ([method isEqualToString:@"SystemChrome.setApplicationSwitcherDescription"]) {
120  [self setSystemChromeApplicationSwitcherDescription:args];
121  result(nil);
122  } else if ([method isEqualToString:@"SystemChrome.setEnabledSystemUIOverlays"]) {
123  [self setSystemChromeEnabledSystemUIOverlays:args];
124  result(nil);
125  } else if ([method isEqualToString:@"SystemChrome.setEnabledSystemUIMode"]) {
126  [self setSystemChromeEnabledSystemUIMode:args];
127  result(nil);
128  } else if ([method isEqualToString:@"SystemChrome.restoreSystemUIOverlays"]) {
129  [self restoreSystemChromeSystemUIOverlays];
130  result(nil);
131  } else if ([method isEqualToString:@"SystemChrome.setSystemUIOverlayStyle"]) {
132  [self setSystemChromeSystemUIOverlayStyle:args];
133  result(nil);
134  } else if ([method isEqualToString:@"SystemNavigator.pop"]) {
135  NSNumber* isAnimated = args;
136  [self popSystemNavigator:isAnimated.boolValue];
137  result(nil);
138  } else if ([method isEqualToString:@"Clipboard.getData"]) {
139  result([self getClipboardData:args]);
140  } else if ([method isEqualToString:@"Clipboard.setData"]) {
141  [self setClipboardData:args];
142  result(nil);
143  } else if ([method isEqualToString:@"Clipboard.hasStrings"]) {
144  result([self clipboardHasStrings]);
145  } else if ([method isEqualToString:@"LiveText.isLiveTextInputAvailable"]) {
146  result(@([self isLiveTextInputAvailable]));
147  } else if ([method isEqualToString:@"SearchWeb.invoke"]) {
148  [self searchWeb:args];
149  result(nil);
150  } else if ([method isEqualToString:@"LookUp.invoke"]) {
151  [self showLookUpViewController:args];
152  result(nil);
153  } else if ([method isEqualToString:@"Share.invoke"]) {
154  [self showShareViewController:args];
155  result(nil);
156  } else if ([method isEqualToString:@"ContextMenu.showSystemContextMenu"]) {
157  [self showSystemContextMenu:args];
158  result(nil);
159  } else if ([method isEqualToString:@"ContextMenu.hideSystemContextMenu"]) {
160  [self hideSystemContextMenu];
161  result(nil);
162  } else {
163  result([FlutterMethodNotImplemented](_flutter_channels_8h.html#a1ea2e85e3d0d95aa5ebd2c2620f1a5e1));
164  }
165 }
```

----------------------------------------

TITLE: Set Message Handler for Flutter Binary Messenger
DESCRIPTION: This function sets a message handler for a specific channel on a Flutter binary messenger. It supports an optional FlutterTaskQueue for handling messages on a specific queue.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_channels_8mm_source

LANGUAGE: Objective-C
CODE:
```
static FlutterBinaryMessengerConnection SetMessageHandler(
 NSObject<FlutterBinaryMessenger>* messenger,
 NSString* name,
 FlutterBinaryMessageHandler handler,
 NSObject<FlutterTaskQueue>* taskQueue) {
 if (taskQueue) {
 NSCAssert([messenger respondsToSelector:@selector(setMessageHandlerOnChannel:
 binaryMessageHandler:taskQueue:)],
 @"");
 return [messenger setMessageHandlerOnChannel:name
 binaryMessageHandler:handler
 taskQueue:taskQueue];
 } else {
 return [messenger setMessageHandlerOnChannel:name binaryMessageHandler:handler];
 }
}
```

----------------------------------------

TITLE: FlutterViewController Class Definition
DESCRIPTION: Defines the FlutterViewController class, a core component for embedding Flutter content into a native view hierarchy.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterViewController
```

----------------------------------------

TITLE: Objective-C: Test Flutter TextInput Plugin with Mocked UI Interactions
DESCRIPTION: This comprehensive test method sets up various mocks for Flutter engine, binary messenger, view controller, view, and window to simulate UI interactions. It then tests the `FlutterTextInputPlugin` by handling `TextInput.setClient`, `TextInput.setEditableSizeAndTransform`, and `TextInput.setCaretRect` method calls, verifying the plugin's behavior in a controlled environment.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_plugin_test_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (bool)testFirstRectForCharacterRange {
 id engineMock = [flutter::testing::CreateMockFlutterEngine](@"");
 id binaryMessengerMock = OCMProtocolMock(@protocol([FlutterBinaryMessenger]));
 OCMStub( // NOLINT(google-objc-avoid-throwing-exception)
 [engineMock binaryMessenger])
 .andReturn(binaryMessengerMock);
 [FlutterViewController]* controllerMock =
 [[[TextInputTestViewController alloc] initWithEngine:engineMock nibName:nil bundle:nil];
 [controllerMock loadView];
 id viewMock = controllerMock.flutterView;
 OCMStub( // NOLINT(google-objc-avoid-throwing-exception)
 [viewMock bounds])
 .andReturn(NSMakeRect(0, 0, 200, 200));

 id windowMock = OCMClassMock([NSWindow class]);
 OCMStub( // NOLINT(google-objc-avoid-throwing-exception)
 [viewMock window])
 .andReturn(windowMock);

 OCMExpect( // NOLINT(google-objc-avoid-throwing-exception)
 [viewMock convertRect:NSMakeRect(28, 10, 2, 19) toView:nil])
 .andReturn(NSMakeRect(28, 10, 2, 19));

 OCMExpect( // NOLINT(google-objc-avoid-throwing-exception)
 [windowMock convertRectToScreen:NSMakeRect(28, 10, 2, 19)])
 .andReturn(NSMakeRect(38, 20, 2, 19));

 [FlutterTextInputPluginTestDelegate]* delegate =
 [[[FlutterTextInputPluginTestDelegate alloc] initWithBinaryMessenger:binaryMessengerMock
 viewController:controllerMock];

 [FlutterTextInputPlugin]* plugin = [[[FlutterTextInputPlugin alloc] initWithDelegate:delegate];

 NSDictionary* setClientConfig = @{
 @"viewId" : @([kViewId]),
 };
 [plugin handleMethodCall:[FlutterMethodCall methodCallWithMethodName:@"TextInput.setClient"
 [arguments]:@[ @(1), setClientConfig ]]
 [result]:^(id){
 }];

 [FlutterMethodCall]* call = [[FlutterMethodCall]
 methodCallWithMethodName:@"TextInput.setEditableSizeAndTransform"
 [arguments]:@{
 @"height" : @(20.0),
 @"transform" : @[
 @(1.0), @(0.0), @(0.0), @(0.0), @(0.0), @(1.0), @(0.0), @(0.0), @(0.0),
 @(0.0), @(1.0), @(0.0), @(20.0), @(10.0), @(0.0), @(1.0)
 ],
 @"width" : @(400.0),
 }];

 [plugin handleMethodCall:call
 [result]:^(id){
 }];

 call = [[FlutterMethodCall] methodCallWithMethodName:@"TextInput.setCaretRect"
 [arguments]:@{
 @"height" : @(19.0),
 @"width" : @(2.0),
 @"x" : @(8.0),
 @"y" : @(0.0),
 }];

 [plugin handleMethodCall:call
 [result]:^(id){
 }];
```

----------------------------------------

TITLE: Flutter Binary Messenger Callbacks
DESCRIPTION: Defines typedefs for `FlutterBinaryReply` (a callback for binary message replies) and `FlutterBinaryMessageHandler` (a handler for incoming binary messages). These are fundamental types for inter-platform communication in Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_keyboard_manager_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryReply
NS_ASSUME_NONNULL_BEGIN typedef void(^ FlutterBinaryReply)(NSData *_Nullable reply)

FlutterBinaryMessageHandler
void(^ FlutterBinaryMessageHandler)(NSData *_Nullable message, FlutterBinaryReply reply)
```

----------------------------------------

TITLE: Create Flutter Engine Shell with Entrypoint and Route
DESCRIPTION: Initializes a new Flutter shell, which is the core execution environment for a Flutter application. It allows specifying an entrypoint function, a library URI, and an initial route for the Flutter app.
SOURCE: https://api.flutter.dev/ios-embedder/category_flutter_engine_07_08

LANGUAGE: Objective-C
CODE:
```
- (BOOL) createShell: (NSString *) entrypoint
         libraryURI: (NSString *) libraryURI
       initialRoute: (NSString *) initialRoute

- (BOOL) createShell: (nullable NSString *) entrypoint
         libraryURI: (nullable NSString *) libraryOrNil
       initialRoute: (nullable NSString *) initialRoute
```

----------------------------------------

TITLE: Implement FlPluginRegistry Get Registrar for Plugin
DESCRIPTION: This function implements the `FlPluginRegistry::get_registrar_for_plugin` interface. It creates and returns a new `FlPluginRegistrar` instance for a given plugin name, using the `FlView`'s engine to obtain the binary messenger and texture registrar.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8cc_source

LANGUAGE: C++
CODE:
```
static FlPluginRegistrar* fl_view_get_registrar_for_plugin(
 FlPluginRegistry* registry,
 const gchar* name) {
 FlView* self = FL_VIEW(registry);
 return fl_plugin_registrar_new(self,
 fl_engine_get_binary_messenger(self->engine),
 fl_engine_get_texture_registrar(self->engine));
}
```

----------------------------------------

TITLE: Create FlutterBasicMessageChannel with custom codec (Objective-C)
DESCRIPTION: A static factory method to create a FlutterBasicMessageChannel instance, allowing a custom FlutterMessageCodec to be specified. This provides flexibility for handling different message formats.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8mm_source

LANGUAGE: Objective-C
CODE:
```
+ (instancetype)messageChannelWithName:(NSString*)name
 binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
 codec:(NSObject<FlutterMessageCodec>*)codec {
 return [[[FlutterBasicMessageChannel] alloc] initWithName:name
 binaryMessenger:messenger
 codec:codec];
}
```

----------------------------------------

TITLE: FlutterWindowsView Class API
DESCRIPTION: API for interacting with the Flutter view. It provides methods to retrieve the associated Flutter engine and the native Windows window handle.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8cc_source

LANGUAGE: APIDOC
CODE:
```
class flutter::FlutterWindowsView
  GetEngine() const -> FlutterWindowsEngine *
  GetWindowHandle() const -> virtual HWND
```

----------------------------------------

TITLE: Encode Message with StandardMessageCodec
DESCRIPTION: Encodes the specified message object into a binary ByteBuffer. This method is an implementation of the MessageCodec interface, crucial for converting messages into a format suitable for transmission or storage.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/StandardMessageCodec

LANGUAGE: APIDOC
CODE:
```
@Nullable public java.nio.ByteBuffer encodeMessage(@Nullable java.lang.Object message)
```

----------------------------------------

TITLE: FlutterMessageCodec Protocol Overview
DESCRIPTION: Defines the FlutterMessageCodec protocol, an Objective-C interface for message encoding and decoding mechanisms within the Flutter framework.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_message_codec-p

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterMessageCodec
  Description: A message encoding/decoding mechanism.
  Import: #import <FlutterCodecs.h>
  Inheritance: (Diagram reference: protocol_flutter_message_codec-p.png)
```

----------------------------------------

TITLE: Handle Method Call Errors with FlMethodChannel in C++
DESCRIPTION: This C++ test demonstrates how to set up an FlMethodChannel and handle errors when responding to method calls. It specifically checks for correct error handling when an unsupported argument type is provided in the fl_method_call_respond_error function, ensuring the GError is populated as expected.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__channel__test_8cc_source

LANGUAGE: C++
CODE:
```
// Checks error correctly handled if provide an unsupported arg in a method call
// response.
TEST(FlMethodChannelTest, ReceiveMethodCallRespondErrorError) {
  g_autoptr(FlMockBinaryMessenger) messenger = fl_mock_binary_messenger_new();

  g_autoptr(TestMethodCodec) codec = test_method_codec_new();
  g_autoptr(FlMethodChannel) channel = fl_method_channel_new(
      FL_BINARY_MESSENGER(messenger), "test", FL_METHOD_CODEC(codec));
  gboolean called = FALSE;
  fl_method_channel_set_method_call_handler(
      channel,
      [](FlMethodChannel* channel, FlMethodCall* method_call,
         gpointer user_data) {
        gboolean* called = static_cast<gboolean*>(user_data);
        *called = TRUE;

        g_autoptr(FlValue) details = fl_value_new_int(42);
        g_autoptr(GError) response_error = nullptr;
        EXPECT_FALSE(fl_method_call_respond_error(method_call, "error", "ERROR",
                                                  details, &response_error));
        EXPECT_NE(response_error, nullptr);
        EXPECT_STREQ(response_error->message, "Unsupported type");
      },
      &called, nullptr);

  // Trigger the engine to make a method call.
  fl_mock_binary_messenger_invoke_standard_method(messenger, "test", "Test",
                                                  nullptr, nullptr, nullptr);

  EXPECT_TRUE(called);
}
```

----------------------------------------

TITLE: APIDOC: Flutter BasicMessageChannel Class
DESCRIPTION: Documentation for the `BasicMessageChannel` class, a templated C++ class designed for asynchronous message communication with the Flutter engine. It provides methods for sending messages and managing channel lifecycle, including its constructor and copy prevention mechanisms.
SOURCE: https://api.flutter.dev/windows-embedder/basic__message__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
BasicMessageChannel<T = EncodableValue> Class:
  Description: A channel for communicating with the Flutter engine by sending asynchronous messages.

  Constructor:
    BasicMessageChannel(BinaryMessenger* messenger, const std::string& name, const MessageCodec<T>* codec)
      messenger: BinaryMessenger* - The messenger for dispatching messages.
      name: const std::string& - The name of the channel.
      codec: const MessageCodec<T>* - The codec for encoding and decoding messages.

  Methods:
    Send(const T& message)
      Description: Sends a message to the Flutter engine on this channel.
      Parameters:
        message: const T& - The message to send.
      Returns: void

  Special Members:
    ~BasicMessageChannel() = default; // Default destructor
    BasicMessageChannel(BasicMessageChannel const&) = delete; // Copy constructor deleted
    BasicMessageChannel& operator=(BasicMessageChannel const&) = delete; // Assignment operator deleted
```

----------------------------------------

TITLE: Implement TaskRunner::RunNowOrPostTask for Conditional Execution
DESCRIPTION: This code snippet provides the implementation for the `RunNowOrPostTask` method of the `TaskRunner` class. It checks if the current thread is the task runner's thread; if so, the task is executed immediately. Otherwise, the task is posted to the event loop for asynchronous processing, ensuring proper thread management.
SOURCE: https://api.flutter.dev/windows-embedder/task__runner_8h_source

LANGUAGE: C++
CODE:
```
void RunNowOrPostTask(TaskClosure task) {
  if (RunsTasksOnCurrentThread()) {
    task();
  } else {
    PostTask(std::move(task));
  }
}
```

----------------------------------------

TITLE: FlutterStreamHandler Protocol Definition
DESCRIPTION: The FlutterStreamHandler protocol defines the interface for handling stream events in Flutter applications. It includes methods for listening to and canceling event streams, typically used in platform channel implementations for macOS.
SOURCE: https://api.flutter.dev/macos-embedder/protocol_flutter_stream_handler-p-members

LANGUAGE: APIDOC
CODE:
```
protocol FlutterStreamHandler {
  // Called when a stream is canceled.
  // - Parameters:
  //   - arguments: (Any?) Optional arguments provided when the stream was canceled.
  func onCancelWithArguments(_ arguments: Any?)

  // Called when a stream is listened to.
  // - Parameters:
  //   - arguments: (Any?) Optional arguments provided when the stream was listened to.
  //   - eventSink: (FlutterEventSink) A sink to send events to the Flutter side.
  func onListenWithArguments(_ arguments: Any?, eventSink: FlutterEventSink)
}
```

----------------------------------------

TITLE: Define Flutter C++ App Lifecycle States Enum
DESCRIPTION: This enum defines the possible lifecycle states for a Flutter application in C++, mirroring the `AppLifecycleState` enum in the Flutter framework. It includes states like `kDetached`, `kResumed`, `kInactive`, `kHidden`, and `kPaused`. These states are passed to the embedder's `SetLifecycleState` function. The state machine is as follows:

+-----------+   +-----------+
| detached  |------------------>| resumed   |
+-----------+   +-----------+
    ^               ^
    |               |
    |               v
+-----------+   +--------------+   +-----------+
| paused    |<------>| hidden       |<----->| inactive  |
+-----------+   +--------------+   +-----------+
SOURCE: https://api.flutter.dev/linux-embedder/app__lifecycle__state_8h_source

LANGUAGE: C++
CODE:
```
enum class AppLifecycleState {
  /**
   * Corresponds to the Framework's AppLifecycleState.detached: The initial
   * state of the state machine. On Android, iOS, and web, also the final state
   * of the state machine when all views are detached. Other platforms do not
   * re-enter this state after initially leaving it.
   */
  kDetached,

  /**
   * Corresponds to the Framework's AppLifecycleState.resumed: The nominal
   * "running" state of the application. The application is visible, has input
   * focus, and is running.
   */
  kResumed,

  /**
   * Corresponds to the Framework's AppLifecycleState.inactive: At least one
   * view of the application is visible, but none have input focus. The
   * application is otherwise running normally.
   */
  kInactive,

  /**
   * Corresponds to the Framework's AppLifecycleState.hidden: All views of an
   * application are hidden, either because the application is being stopped (on
   * iOS and Android), or because it is being minimized or on a desktop that is
   * no longer visible (on desktop), or on a tab that is no longer visible (on
   * web).
   */
  kHidden,

  /**
   * Corresponds to the Framework's AppLifecycleState.paused: The application is
   * not running, and can be detached or started again at any time. This state
   * is typically only entered into on iOS and Android.
   */
  kPaused,
};
```

----------------------------------------

TITLE: Test Clipboard Set Data Reports Set Data Failure in C++
DESCRIPTION: This test case ensures that the `PlatformHandler` properly handles and reports errors when setting data to the clipboard fails. It uses a mock `ScopedClipboard` that succeeds in opening but is configured to return an arbitrary error code when `SetString` is called. The test then simulates a platform message and asserts that the correct 'Unable to set clipboard data' error is returned.
SOURCE: https://api.flutter.dev/windows-embedder/platform__handler__unittests_8cc_source

LANGUAGE: C++
CODE:
```
TEST_F(PlatformHandlerTest, ClipboardSetDataReportsSetDataFailure) {
  UseEngineWithView();
  TestBinaryMessenger messenger;
  PlatformHandler platform_handler(&messenger, engine(), []() {
    auto clipboard = std::make_unique<MockScopedClipboard>();
    EXPECT_CALL(*clipboard.get(), Open)
        .Times(1)
        .WillOnce(Return(kErrorSuccess));
    EXPECT_CALL(*clipboard.get(), SetString)
        .Times(1)
        .WillOnce(Return(kArbitraryErrorCode));
    return clipboard;
  });
  std::string result =
      SimulatePlatformMessage(&messenger, kClipboardSetDataMessage);
  EXPECT_EQ(result, "[\"Clipboard error\",\"Unable to set clipboard data\",1]");
}
```

----------------------------------------

TITLE: Get StandardMessageCodec Singleton Instance (C++)
DESCRIPTION: Retrieves a singleton instance of `StandardMessageCodec`, ensuring only one instance exists per `StandardCodecSerializer`. This method handles the creation of the codec if it doesn't already exist for the given serializer, preventing accidental temporary codec instances.
SOURCE: https://api.flutter.dev/ios-embedder/standard__codec_8cc_source

LANGUAGE: C++
CODE:
```
const StandardMessageCodec& StandardMessageCodec::GetInstance(
  const StandardCodecSerializer* serializer) {
  if (!serializer) {
    serializer = &StandardCodecSerializer::GetInstance();
  }
  static auto* sInstances = new std::map<const StandardCodecSerializer*,
    std::unique_ptr<StandardMessageCodec>>;
  auto it = sInstances->find(serializer);
  if (it == sInstances->end()) {
    // Uses new due to private constructor (to prevent API clients from
    // accidentally passing temporary codec instances to channels).
    // NOLINTNEXTLINE(clang-analyzer-cplusplus.NewDeleteLeaks)
    auto emplace_result = sInstances->emplace(
      serializer, std::unique_ptr<StandardMessageCodec>(
      new StandardMessageCodec(serializer)));
    it = emplace_result.first;
  }
  return *(it->second);
}
```

----------------------------------------

TITLE: FlutterEngine Interface Properties and Methods
DESCRIPTION: Defines the core properties and methods of the `FlutterEngine` interface, which manages the Flutter runtime, communication channels, and rendering context within an iOS application. Includes details on VM service URL, binary messaging, texture registration, UI isolate ID, and GPU state.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
interface FlutterEngine:
  // Properties
  vmServiceUrl: NSURL* (readonly, nullable)
    Description: The URL for the Dart VM Service. This is only set in debug and profile runtime modes, and only after the Dart VM Service is ready. In release mode or before the Dart VM Service has started, it returns nil.
  binaryMessenger: NSObject<FlutterBinaryMessenger>* (readonly)
    Description: The FlutterBinaryMessenger associated with this FlutterEngine (used for communicating with channels).
  textureRegistry: NSObject<FlutterTextureRegistry>* (readonly)
    Description: The FlutterTextureRegistry associated with this FlutterEngine (used to register textures).
  isolateId: NSString* (readonly, copy, nullable)
    Description: The UI Isolate ID of the engine. This property will be nil if the engine is not running.
  isGpuDisabled: BOOL (assign)
    Description: Whether or not GPU calls are allowed. Typically this is set when the app is backgrounded and foregrounded.
  textInputChannel: FlutterMethodChannel*
    Description: The FlutterMethodChannel for text input.
  navigationChannel: (Type not specified)
    Description: The channel for navigation.

  // Methods
  run(): BOOL
    Description: Runs the Flutter engine.
  init(): instancetype
    Description: Initializes a new FlutterEngine instance.
```

----------------------------------------

TITLE: Flutter MethodCodec Class API
DESCRIPTION: Represents the base class for method codecs used in Flutter method channels. Codecs are responsible for encoding and decoding method calls and results between Dart and platform-specific types.
SOURCE: https://api.flutter.dev/macos-embedder/method__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodCodec
```

----------------------------------------

TITLE: Send Flutter Platform Message Asynchronously in C++
DESCRIPTION: This function sends a platform message from the C++ embedder to the Flutter engine. It supports asynchronous operations by creating a GTask and a response handle. It handles cases where the engine is not available and includes error propagation for failed message sending or response handle creation.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc_source

LANGUAGE: C++
CODE:
```
void fl_engine_send_platform_message(FlEngine* self,
const gchar* channel,
GBytes* message,
GCancellable* cancellable,
GAsyncReadyCallback callback,
gpointer user_data) {
g_return_if_fail(FL_IS_ENGINE(self));

GTask* task = nullptr;
FlutterPlatformMessageResponseHandle* response_handle = nullptr;
if (callback != nullptr) {
task = g_task_new(self, cancellable, callback, user_data);

if (self->engine == nullptr) {
g_task_return_new_error(task, fl_engine_error_quark(),
FL_ENGINE_ERROR_FAILED, "No engine to send to");
return;
}

FlutterEngineResult result =
self->embedder_api.PlatformMessageCreateResponseHandle(
self->engine, fl_engine_platform_message_response_cb, task,
&response_handle);
if (result != kSuccess) {
g_task_return_new_error(task, fl_engine_error_quark(),
FL_ENGINE_ERROR_FAILED,
"Failed to create response handle");
g_object_unref(task);
return;
}
} else if (self->engine == nullptr) {
return;
}

FlutterPlatformMessage fl_message = {};
fl_message.struct_size = sizeof(fl_message);
fl_message.channel = channel;
fl_message.message =
message != nullptr
? static_cast<const uint8_t*>(g_bytes_get_data(message, nullptr))
: nullptr;
fl_message.message_size = message != nullptr ? g_bytes_get_size(message) : 0;
fl_message.response_handle = response_handle;
FlutterEngineResult result =
self->embedder_api.SendPlatformMessage(self->engine, &fl_message);

if (result != kSuccess && task != nullptr) {
g_task_return_new_error(task, fl_engine_error_quark(),
FL_ENGINE_ERROR_FAILED,
"Failed to send platform messages");
g_object_unref(task);
}

if (response_handle != nullptr) {
self->embedder_api.PlatformMessageReleaseResponseHandle(self->engine,
response_handle);
}
}
```

----------------------------------------

TITLE: Read Various Data Types from Byte Stream (Standard Codec C++)
DESCRIPTION: This snippet presents a portion of the `StandardCodecSerializer::ReadValueOfType` method in C++. It demonstrates how different `EncodableValue` types (like null, booleans, int32, int64, float64, strings, and various lists) are deserialized and read from a `ByteStreamReader`. It includes handling for alignment, size prefixes, and type-specific reading operations.
SOURCE: https://api.flutter.dev/macos-embedder/standard__codec_8cc_source

LANGUAGE: C++
CODE:
```
EncodableValue StandardCodecSerializer::ReadValueOfType(
uint8_t type,
ByteStreamReader* stream) const {
switch (static_cast<EncodedType>(type)) {
case EncodedType::kNull:
return EncodableValue();
case EncodedType::kTrue:
return EncodableValue(true);
case EncodedType::kFalse:
return EncodableValue(false);
case EncodedType::kInt32:
return EncodableValue(stream->ReadInt32());
case EncodedType::kInt64:
return EncodableValue(stream->ReadInt64());
case EncodedType::kFloat64:
stream->ReadAlignment(8);
return EncodableValue(stream->ReadDouble());
case EncodedType::kLargeInt:
case EncodedType::kString: {
size_t size = ReadSize(stream); // ReadSize is likely a helper function
std::string string_value;
string_value.resize(size);
stream->ReadBytes(reinterpret_cast<uint8_t*>(&string_value[0]), size);
return EncodableValue(string_value);
}
case EncodedType::kUInt8List:
return ReadVector<uint8_t>(stream);
case EncodedType::kInt32List:
return ReadVector<int32_t>(stream);
case EncodedType::kInt64List:
return ReadVector<int64_t>(stream);
case EncodedType::kFloat64List:
return ReadVector<double>(stream);
case EncodedType::kList: {
size_t length = ReadSize(stream);
EncodableList list_value;
// Further processing for list elements would typically follow here,
// e.g., iterating 'length' times and recursively calling ReadValue.
}

```

----------------------------------------

TITLE: flutter::MethodCodec::DecodeMethodCall Method
DESCRIPTION: Decodes a raw message buffer into a MethodCall object. Defined in method_codec.h.
SOURCE: https://api.flutter.dev/macos-embedder/standard__method__codec__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
std::unique_ptr< MethodCall< T > > DecodeMethodCall(const uint8_t *message, size_t message_size) const
  Definition: method_codec.h:32
```

----------------------------------------

TITLE: Flutter PluginRegistrarManager Class API Reference
DESCRIPTION: Documents the `flutter::PluginRegistrarManager` class, including its constructors, public member functions, and static public member functions. This class manages plugin registrars for Flutter desktop applications.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_plugin_registrar_manager

LANGUAGE: APIDOC
CODE:
```
flutter::PluginRegistrarManager Class Reference

#include <plugin_registrar.h>

Public Member Functions:
  - PluginRegistrarManager(PluginRegistrarManager const &) = delete
  - PluginRegistrarManager & operator=(PluginRegistrarManager const &) = delete
  - template<class T> T * GetRegistrar(FlutterDesktopPluginRegistrarRef registrar_ref)
  - void Reset()

Static Public Member Functions:
  - static PluginRegistrarManager * GetInstance()

Detailed Description:
  Definition at line 86 of file plugin_registrar.h.
```

----------------------------------------

TITLE: C++ Implementation of OnWindowStateEvent in FlutterWindow
DESCRIPTION: This C++ code snippet illustrates the implementation of the `OnWindowStateEvent` method within the `flutter::FlutterWindow` class. It uses a switch statement to handle different `WindowStateEvent` types (kShow, kHide, kFocus, kUnfocus), updating internal state variables (`restored_`, `focused_`). For focus/unfocus events, it invokes the `OnFocus` method on the `binding_handler_delegate_`. Finally, it delegates the window state event to the `binding_handler_delegate_` if a valid window handle exists.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_window

LANGUAGE: C++
CODE:
```
switch (event) {
case WindowStateEvent::kShow:
restored_ = true;
break;
case WindowStateEvent::kHide:
restored_ = false;
focused_ = false;
break;
case WindowStateEvent::kFocus:
focused_ = true;
if (binding_handler_delegate_) {
binding_handler_delegate_->OnFocus(
FlutterViewFocusState::kFocused,
FlutterViewFocusDirection::kUndefined);
}
break;
case WindowStateEvent::kUnfocus:
focused_ = false;
if (binding_handler_delegate_) {
binding_handler_delegate_->OnFocus(
FlutterViewFocusState::kUnfocused,
FlutterViewFocusDirection::kUndefined);
}
break;
}
HWND hwnd = GetWindowHandle();
if (hwnd && binding_handler_delegate_) {
binding_handler_delegate_->OnWindowStateEvent(hwnd, event);
}
```

----------------------------------------

TITLE: APIDOC flutter::EventChannel Class
DESCRIPTION: A Flutter platform channel for event streams, allowing continuous communication from the host platform to Flutter. Used for events like sensor updates or battery changes.
SOURCE: https://api.flutter.dev/macos-embedder/event__channel__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::EventChannel
Definition: event_channel.h:33
```

----------------------------------------

TITLE: Handle Surface Window Change in Hybrid Composition
DESCRIPTION: In hybrid composition scenarios, call this method when the underlying Surface has changed, for example, when the root surface switches between SurfaceHolder.getSurface() and ImageReader.getSurface() due to a platform view.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterJNI

LANGUAGE: Java
CODE:
```
@UiThread
public void onSurfaceWindowChanged(@NonNull
Surface surface)
```

----------------------------------------

TITLE: FlutterDesktopGpuSurfaceDescriptor Structure Definition
DESCRIPTION: Describes a GPU surface for Flutter desktop, providing details like size, handle, and dimensions. It supports different GPU surface types (e.g., D3D11Texture2D, DxgiSharedHandle) and includes a callback for resource release.
SOURCE: https://api.flutter.dev/linux-embedder/flutter__texture__registrar_8h_source

LANGUAGE: C
CODE:
```
typedef struct {
  size_t struct_size; // The size of this struct. Must be sizeof(FlutterDesktopGpuSurfaceDescriptor).
  void* handle; // The surface handle. The expected type depends on the |FlutterDesktopGpuSurfaceType|. Provide a |ID3D11Texture2D*| when using |kFlutterDesktopGpuSurfaceTypeD3d11Texture2D| or a |HANDLE| when using |kFlutterDesktopGpuSurfaceTypeDxgiSharedHandle|. The referenced resource needs to stay valid until it has been opened by Flutter. Consider incrementing the resource's reference count in the |FlutterDesktopGpuSurfaceTextureCallback| and registering a |release_callback| for decrementing the reference count once it has been opened.
  size_t width; // The physical width.
  size_t height; // The physical height.
  size_t visible_width; // The visible width. It might be less or equal to the physical |width|.
  size_t visible_height; // The visible height. It might be less or equal to the physical |height|.
  FlutterDesktopPixelFormat format; // The pixel format which might be optional depending on the surface type.
  void (*release_callback)(void* release_context); // An optional callback that gets invoked when the |handle| has been opened.
  void* release_context; // Opaque data passed to |release_callback|.
} FlutterDesktopGpuSurfaceDescriptor;
```

----------------------------------------

TITLE: Register Handler for Flutter Method Calls
DESCRIPTION: Registers a handler to process method calls originating from the Flutter side. This method replaces any existing handler; passing `nil` will unregister the current handler.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_method_channel

LANGUAGE: APIDOC
CODE:
```
- (void) setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler

Description: Registers a handler for method calls from the Flutter side. Replaces any existing handler. Use a `nil` handler for unregistering the existing handler.
Parameters:
  handler: The method call handler.
```

----------------------------------------

TITLE: Flutter Desktop Plugin Registrar Header and API
DESCRIPTION: This snippet provides the full C/C++ header file for `flutter_plugin_registrar.h` and its structured API documentation. It defines opaque types, functions to retrieve engine components (messenger, texture registrar), and a mechanism to register a destruction callback for the plugin registrar.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__plugin__registrar_8h_source

LANGUAGE: C++
CODE:
```
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_SHELL_PLATFORM_COMMON_PUBLIC_FLUTTER_PLUGIN_REGISTRAR_H_
#define FLUTTER_SHELL_PLATFORM_COMMON_PUBLIC_FLUTTER_PLUGIN_REGISTRAR_H_

#include <stddef.h>
#include <stdint.h>

#include "flutter_export.h"
#include "flutter_messenger.h"
#include "flutter_texture_registrar.h"

#if defined(__cplusplus)
extern "C" {
#endif // defined(__cplusplus)

// Opaque reference to a plugin registrar.
typedef struct FlutterDesktopPluginRegistrar* FlutterDesktopPluginRegistrarRef;

// Function pointer type for registrar destruction callback.
typedef void (*FlutterDesktopOnPluginRegistrarDestroyed)(
    FlutterDesktopPluginRegistrarRef);

// Returns the engine messenger associated with this registrar.
FLUTTER_EXPORT FlutterDesktopMessengerRef
FlutterDesktopPluginRegistrarGetMessenger(
    FlutterDesktopPluginRegistrarRef registrar);

// Returns the texture registrar associated with this registrar.
FLUTTER_EXPORT FlutterDesktopTextureRegistrarRef
FlutterDesktopRegistrarGetTextureRegistrar(
    FlutterDesktopPluginRegistrarRef registrar);

// Registers a callback to be called when the plugin registrar is destroyed.
FLUTTER_EXPORT void FlutterDesktopPluginRegistrarSetDestructionHandler(
    FlutterDesktopPluginRegistrarRef registrar,
    FlutterDesktopOnPluginRegistrarDestroyed callback);

#if defined(__cplusplus)
} // extern "C"
#endif

#endif // FLUTTER_SHELL_PLATFORM_COMMON_PUBLIC_FLUTTER_PLUGIN_REGISTRAR_H_
```

LANGUAGE: APIDOC
CODE:
```
flutter_plugin_registrar.h:
  Purpose: Defines the public API for interacting with the Flutter plugin registrar on desktop platforms.
  Includes:
    - flutter_export.h
    - flutter_messenger.h
    - flutter_texture_registrar.h
  Types:
    FlutterDesktopPluginRegistrarRef:
      Type: typedef struct FlutterDesktopPluginRegistrar*
      Description: Opaque reference to a plugin registrar.
    FlutterDesktopOnPluginRegistrarDestroyed:
      Type: typedef void (*)(FlutterDesktopPluginRegistrarRef)
      Description: Function pointer type for registrar destruction callback.
  Functions:
    FlutterDesktopPluginRegistrarGetMessenger:
      Description: Returns the engine messenger associated with this registrar.
      Signature: FLUTTER_EXPORT FlutterDesktopMessengerRef FlutterDesktopPluginRegistrarGetMessenger(FlutterDesktopPluginRegistrarRef registrar)
      Parameters:
        registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
      Returns: FlutterDesktopMessengerRef - The messenger for the engine.
    FlutterDesktopRegistrarGetTextureRegistrar:
      Description: Returns the texture registrar associated with this registrar.
      Signature: FLUTTER_EXPORT FlutterDesktopTextureRegistrarRef FlutterDesktopRegistrarGetTextureRegistrar(FlutterDesktopPluginRegistrarRef registrar)
      Parameters:
        registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
      Returns: FlutterDesktopTextureRegistrarRef - The texture registrar.
    FlutterDesktopPluginRegistrarSetDestructionHandler:
      Description: Registers a callback to be called when the plugin registrar is destroyed.
      Signature: FLUTTER_EXPORT void FlutterDesktopPluginRegistrarSetDestructionHandler(FlutterDesktopPluginRegistrarRef registrar, FlutterDesktopOnPluginRegistrarDestroyed callback)
      Parameters:
        registrar: FlutterDesktopPluginRegistrarRef - The plugin registrar reference.
        callback: FlutterDesktopOnPluginRegistrarDestroyed - The callback function to be invoked on destruction.
      Returns: void
  Macros:
    FLUTTER_EXPORT:
      Definition: #define FLUTTER_EXPORT
      Description: Macro used for exporting symbols from the Flutter library.
```

----------------------------------------

TITLE: FlutterStandardMessageCodec API Reference
DESCRIPTION: Documents the methods and properties of the FlutterStandardMessageCodec interface, including inherited members, for encoding and decoding messages within the Flutter iOS embedder.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_standard_message_codec-members

LANGUAGE: APIDOC
CODE:
```
interface FlutterStandardMessageCodec
  Inherits: <FlutterMessageCodec>

  Methods:
    + (FlutterStandardMessageCodec *)codecWithReaderWriter:
      Description: Static method to create a new FlutterStandardMessageCodec instance.

    - (id)decode:(NSData *)messageData
      Description: Decodes a message from NSData.
      Inherited from: <FlutterMessageCodec>

    - (NSData *)encode:(id)message
      Description: Encodes a message into NSData.
      Inherited from: <FlutterMessageCodec>

    + (id)sharedInstance
      Description: Returns the shared instance of the message codec.
      Inherited from: <FlutterMessageCodec>
```

----------------------------------------

TITLE: Convert Flutter Coordinates to macOS Coordinates
DESCRIPTION: This snippet demonstrates how to convert Flutter's top-left origin coordinate system to macOS's bottom-left origin coordinate system for a given rectangle. It flips the Y coordinate and then uses `convertRectFromBacking` and `convertRect` methods to get the final macOS view bounds.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_semantics_object_8mm_source

LANGUAGE: Objective-C++
CODE:
```
ns_local_bounds.origin.y = -ns_local_bounds.origin.y - ns_local_bounds.size.height;
NSRect ns_view_bounds = [[view_controller_].flutterView convertRectFromBacking:ns_local_bounds];
return [[view_controller_].flutterView convertRect:ns_view_bounds toView:nil];
```

----------------------------------------

TITLE: Retrieve Values and Properties from FlValue Objects
DESCRIPTION: Functions to access and retrieve data stored within FlValue objects. This includes looking up values by key in maps, getting primitive type values, and retrieving custom object properties.
SOURCE: https://api.flutter.dev/linux-embedder/fl__value_8h_source

LANGUAGE: APIDOC
CODE:
```
FlValue * fl_value_lookup(FlValue *value, FlValue *key)
```

LANGUAGE: APIDOC
CODE:
```
FlValue * fl_value_get_custom_value_object(FlValue *value)
```

LANGUAGE: APIDOC
CODE:
```
FlValue * fl_value_lookup_string(FlValue *value, const gchar *key)
```

LANGUAGE: APIDOC
CODE:
```
gconstpointer fl_value_get_custom_value(FlValue *value)
```

LANGUAGE: APIDOC
CODE:
```
int64_t fl_value_get_int(FlValue *value)
```

LANGUAGE: APIDOC
CODE:
```
int fl_value_get_custom_type(FlValue *value)
```

LANGUAGE: APIDOC
CODE:
```
FlValue * fl_value_get_map_key(FlValue *value, size_t index)
```

LANGUAGE: APIDOC
CODE:
```
const gchar * fl_value_get_string(FlValue *value)
```

----------------------------------------

TITLE: Flutter C++ Method: BasicMessageChannel::SetMessageHandler
DESCRIPTION: Sets the message handler for the BasicMessageChannel. The provided handler will be invoked when messages are received from the Flutter engine.
SOURCE: https://api.flutter.dev/ios-embedder/basic__message__channel__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
void SetMessageHandler(const MessageHandler< T > &handler) const
```

----------------------------------------

TITLE: FlStandardMessageCodec: read_value_of_type Virtual Method
DESCRIPTION: This virtual method is designed to read an `FlValue` object encoded using Flutter's Standard encoding. Codecs that need to support custom `FlValue` objects must override this method to provide their specific decoding logic. For standard, non-custom values, the implementation should delegate to the parent method. It returns an `FlValue` pointer upon successful decoding or `NULL` if an error occurs during the process.
SOURCE: https://api.flutter.dev/linux-embedder/fl__standard__message__codec_8h

LANGUAGE: APIDOC
CODE:
```
FlStandardMessageCodec:
  read_value_of_type:
    Description: Virtual method to read an FlValue in Flutter Standard encoding. If a codec needs to support custom FlValue objects it must override this method to decode those values. For non-custom values the parent method should be called.
    Parameters:
      codec: FlStandardMessageCodec* - The codec instance.
      buffer: GBytes* - The buffer containing the encoded value.
      offset: size_t* - The current offset in the buffer, updated after reading.
      type: int - The type of the value to read.
      error: GError** - Pointer to an error object if an error occurs.
    Returns: FlValue* - An FlValue object or NULL on error.
```

----------------------------------------

TITLE: FlutterViewController Class Definition
DESCRIPTION: Defines the FlutterViewController class, an iOS UIViewController subclass that hosts a Flutter view and manages the Flutter engine's lifecycle within a native iOS application.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterViewController: Class
```

----------------------------------------

TITLE: FlutterLoader startInitialization Method
DESCRIPTION: Initiates the native system initialization for Flutter, loading the engine's native library and unpacking Dart resources. Can be called with or without specific settings.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/loader/FlutterLoader

LANGUAGE: APIDOC
CODE:
```
public void startInitialization(@NonNull Context applicationContext)
  Starts initialization of the native system.
  Parameters:
    applicationContext - The Android application context.

public void startInitialization(@NonNull Context applicationContext, @NonNull FlutterLoader.Settings settings)
  Starts initialization of the native system.
  This loads the Flutter engine's native library to enable subsequent JNI calls. This also starts locating and unpacking Dart resources packaged in the app's APK.
  Calling this method multiple times has no effect.
  Parameters:
    applicationContext - The Android application context.
    settings - Configuration settings.
```

----------------------------------------

TITLE: Extend FlutterStandardWriter for Custom Type Serialization
DESCRIPTION: Implements `ExtendedWriter` by subclassing `FlutterStandardWriter` to handle custom serialization of `NSDate` and `Pair` objects. It writes a custom type byte (`kDATE` or `kPAIR`) followed by the serialized data for these types, otherwise delegates to the superclass for standard types.
SOURCE: https://api.flutter.dev/ios-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: Objective-C
CODE:
```
@interface ExtendedWriter : FlutterStandardWriter
- (void)writeValue:(id)value;
@end

@implementation ExtendedWriter
- (void)writeValue:(id)value {
 if ([value isKindOfClass:[NSDate class]]) {
 [self writeByte:kDATE];
 NSDate* date = value;
 NSTimeInterval time = date.timeIntervalSince1970;
 SInt64 ms = (SInt64)(time * 1000.0);
 [self writeBytes:&ms length:8];
 } else if ([value isKindOfClass:[Pair class]]) {
 Pair* pair = value;
 [self writeByte:kPAIR];
 [self writeValue:pair.left];
 [self writeValue:pair.right];
 } else {
 [super writeValue:value];
 }
}
@end
```

----------------------------------------

TITLE: Get Dart Entrypoint Library URI
DESCRIPTION: Returns the library URI of the Dart method that this `FlutterFragment` should execute to start a Flutter app. Defaults to null (example value: "package:foo/bar.dart"). This method is used by this `FlutterFragment`'s `FlutterActivityAndFragmentDelegate.Host`.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: Java
CODE:
```
@Nullable
public String getDartEntrypointLibraryUri()
```

LANGUAGE: APIDOC
CODE:
```
Method: getDartEntrypointLibraryUri
  Returns: String (nullable)
  Description: Returns the library URI of the Dart method that this `FlutterFragment` should execute to start a Flutter app.
  Default: null (example value: "package:foo/bar.dart")
  Usage: Used by this `FlutterFragment`'s `FlutterActivityAndFragmentDelegate.Host`
```

----------------------------------------

TITLE: popSystemNavigator Method
DESCRIPTION: Allows the implementer to customize the behavior needed when the Flutter framework calls to pop the Android-side navigation stack.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: APIDOC
CODE:
```
boolean popSystemNavigator()
```

----------------------------------------

TITLE: Flutter API Core Classes and Structs Reference
DESCRIPTION: This snippet lists the essential classes and structs available in the Flutter API, categorized by their type (Class or Struct) and including brief descriptions where available. These components are fundamental for interacting with the Flutter engine, handling user input, managing windows, and facilitating inter-plugin communication.
SOURCE: https://api.flutter.dev/windows-embedder/annotated

LANGUAGE: APIDOC
CODE:
```
Classes and Structs:
- TaskRunner (Class)
- TaskRunnerWindow (Class)
- Delegate (Class)
- ImmContext (Class)
- TextInputManager (Class)
- TextInputPlugin (Class)
- TextInputPluginModifier (Class)
- PhysicalWindowBounds (Struct)
- PointerLocation (Struct)
- WindowBindingHandler (Class)
- WindowBindingHandlerDelegate (Class)
- WindowProcDelegateManager (Class)
- ThreadSnapshot (Class)
- WindowsLifecycleManager (Class)
- WindowsProcTable (Class)
- AccessibilityBridge (Class)
- AlertPlatformNodeDelegate (Class)
- BinaryMessengerImpl (Class)
- ByteBufferStreamReader (Class)
- ByteBufferStreamWriter (Class)
- TestCustomValue (Class)
- BasicMessageChannel (Class)
- BinaryMessenger (Class)
- ByteStreamReader (Class)
- ByteStreamWriter (Class)
- CustomEncodableValue (Class)
- EncodableValue (Class)
- EngineMethodResult (Class)
- EventChannel (Class)
- EventSink (Class)
- StreamHandlerError (Struct)
- StreamHandler (Class)
- StreamHandlerFunctions (Class)
- MessageCodec (Class)
- MethodCall (Class)
- MethodChannel (Class)
- MethodCodec (Class)
- MethodResult (Class)
- MethodResultFunctions (Class)
- PluginRegistrar (Class)
- Plugin (Class)
- PluginRegistrarManager (Class)
- PluginRegistry (Class)
- StandardCodecSerializer (Class)
- StandardMessageCodec (Class)
- StandardMethodCodec (Class)
- PixelBufferTexture (Class)
- GpuSurfaceTexture (Class)
- TextureRegistrar (Class)
- TextureRegistrarImpl (Class)
- FlutterPlatformNodeDelegate (Class)
- OwnerBridge (Class)
- Point (Class)
- Size (Class)
- Rect (Class)
- IncomingMessageDispatcher (Class)
- JsonMessageCodec (Class)
- JsonMethodCodec (Class)
- TestAccessibilityBridge (Class)
- TextEditingDelta (Struct): A change in the state of an input field
- TextInputModel (Class)
- TextRange (Class)
- FlutterDesktopEngineProperties (Struct)
- FlutterDesktopGpuSurfaceDescriptor (Struct)
- FlutterDesktopGpuSurfaceTextureConfig (Struct)
- FlutterDesktopMessage (Struct)
- FlutterDesktopPixelBuffer (Struct)
- FlutterDesktopPixelBufferTextureConfig (Struct)
```

----------------------------------------

TITLE: flutter::MethodChannel Class Template API Reference
DESCRIPTION: Detailed API documentation for the `flutter::MethodChannel` class template, including its constructors, public member functions, and their parameters. This class is fundamental for handling method calls between Flutter and the host platform.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_method_channel

LANGUAGE: APIDOC
CODE:
```
Class: flutter::MethodChannel<T = EncodableValue>
  #include <method_channel.h>

  Constructors:
    MethodChannel(BinaryMessenger* messenger, const std::string& name, const MethodCodec<T>* codec)
      messenger: Pointer to BinaryMessenger for message passing.
      name: The channel name, a unique string identifier.
      codec: Pointer to MethodCodec<T> for encoding/decoding messages.

    ~MethodChannel() = default
      Default destructor.

    MethodChannel(MethodChannel const&) = delete
      Deleted copy constructor to prevent copying.

  Operators:
    operator=(MethodChannel const&) = delete
      Deleted assignment operator to prevent assignment.

  Public Member Functions:
    void InvokeMethod(const std::string& method, std::unique_ptr<T> arguments, std::unique_ptr<MethodResult<T>> result = nullptr)
      method: The name of the method to invoke on the platform side.
      arguments: A unique pointer to the arguments for the method call.
      result: An optional unique pointer to a MethodResult object to handle the method call's result.

    void SetMethodCallHandler(MethodCallHandler<T> handler) const
      handler: The handler function to be invoked when a method call is received from the platform.

    void Resize(int new_size)
      new_size: The new size for an internal buffer or resource (specific context not provided).

    void SetWarnsOnOverflow(bool warns)
      warns: A boolean indicating whether to warn on overflow conditions (specific context not provided).
```

----------------------------------------

TITLE: Unlock FlutterDesktopMessenger (C/C++ API)
DESCRIPTION: Unlocks the `FlutterDesktopMessengerRef`, releasing the lock acquired by `FlutterDesktopMessengerLock`. This operation is thread-safe and should always be called after a corresponding lock to prevent resource contention and deadlocks.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__messenger_8h_source

LANGUAGE: C
CODE:
```
FLUTTER_EXPORT void FlutterDesktopMessengerUnlock(
  FlutterDesktopMessengerRef messenger);
```

----------------------------------------

TITLE: FlutterWindowsEngine Class API Reference
DESCRIPTION: Provides a comprehensive overview of the `flutter::FlutterWindowsEngine` class, detailing its public, static public, protected member functions, and friend classes. This class manages the Flutter engine's lifecycle, window interactions, and various platform-specific functionalities on Windows.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_windows_engine

LANGUAGE: APIDOC
CODE:
```
Class: flutter::FlutterWindowsEngine

Public Member Functions:
  RequestApplicationQuit(HWND hwnd, WPARAM wparam, LPARAM lparam, AppExitType exit_type): void
  OnDwmCompositionChanged(): void
  OnWindowStateEvent(HWND hwnd, WindowStateEvent event): void
  ProcessExternalWindowMessage(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam): std::optional< LRESULT >
  lifecycle_manager(): WindowsLifecycleManager *
  windows_proc_table(): std::shared_ptr< WindowsProcTable >
  UpdateFlutterCursor(const std::string &cursor_name) const: void
  SetFlutterCursor(HCURSOR cursor) const: void

Static Public Member Functions:
  GetEngineForId(int64_t engine_id): static FlutterWindowsEngine *

Protected Member Functions:
  CreateKeyboardKeyHandler(BinaryMessenger *messenger, KeyboardKeyEmbedderHandler::GetKeyStateHandler get_key_state, KeyboardKeyEmbedderHandler::MapVirtualKeyToScanCode map_vk_to_scan): virtual std::unique_ptr< KeyboardHandlerBase >
  CreateTextInputPlugin(BinaryMessenger *messenger): virtual std::unique_ptr< TextInputPlugin >
  OnPreEngineRestart(): void
  OnChannelUpdate(std::string name, bool listening): virtual void
  OnViewFocusChangeRequest(const FlutterViewFocusChangeRequest *request): virtual void

Friends:
  class EngineModifier
```

----------------------------------------

TITLE: Implement EventSink for Flutter EventChannel in C++
DESCRIPTION: This C++ class `EventSinkImplementation` inherits from `EventSink<T>` and provides the concrete implementation for sending success, error, and end-of-stream events back to Flutter. It uses a `BinaryMessenger` and `MethodCodec` to encode and send the event data over the channel.
SOURCE: https://api.flutter.dev/ios-embedder/event__channel_8h_source

LANGUAGE: C++
CODE:
```
class EventSinkImplementation : public EventSink<T> {
public:
EventSinkImplementation(const BinaryMessenger* messenger,
const std::string& name,
const MethodCodec<T>* codec)
: messenger_(messenger), name_(name), codec_(codec) {}
~EventSinkImplementation() = default;

// Prevent copying.
EventSinkImplementation(EventSinkImplementation const&) = delete;
EventSinkImplementation& operator=(EventSinkImplementation const&) = delete;

private:
const BinaryMessenger* messenger_;
const std::string name_;
const MethodCodec<T>* codec_;

protected:
void SuccessInternal(const T* event = nullptr) override {
auto result = codec_->EncodeSuccessEnvelope(event);
messenger_->Send(name_, result->data(), result->size());
}

void ErrorInternal(const std::string& error_code,
const std::string& error_message,
const T* error_details) override {
auto result =
codec_->EncodeErrorEnvelope(error_code, error_message, error_details);
messenger_->Send(name_, result->data(), result->size());
}

void EndOfStreamInternal() override { messenger_->Send(name_, nullptr, 0); }
};
```

----------------------------------------

TITLE: onTrimMemory Callback Method
DESCRIPTION: A default callback method invoked when the system memory is low. This method should be called from `Activity.onTrimMemory(int)` to inform the Flutter engine about memory pressure.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/view/TextureRegistry

LANGUAGE: APIDOC
CODE:
```
default void onTrimMemory(int level)

Callback invoked when memory is low.

Invoke this from `Activity.onTrimMemory(int)`.
```

----------------------------------------

TITLE: API Definition: Send Event on Flutter Channel (fl_event_channel_send)
DESCRIPTION: Documents the `fl_event_channel_send` function, which facilitates sending an event on a Flutter event channel. It requires an `FlEventChannel` instance, an `FlValue` representing the event, an optional `GCancellable` for operation cancellation, and an optional `GError` pointer for error reporting. Events should only be sent when the channel is actively being listened to. Returns `TRUE` upon successful event transmission.
SOURCE: https://api.flutter.dev/linux-embedder/fl__event__channel_8h

LANGUAGE: APIDOC
CODE:
```
gboolean fl_event_channel_send (
    FlEventChannel *channel,
    FlValue *event,
    GCancellable *cancellable,
    GError **error
)
@channel: an #FlEventChannel.
@event: event to send, must match what the #FlMethodCodec supports.
@cancellable: (allow-none): a #GCancellable or NULL.
@error: (allow-none): #GError location to store the error occurring, or NULL to ignore.
Returns: TRUE if successful.
```

----------------------------------------

TITLE: Flutter C++ BinaryMessenger Class API
DESCRIPTION: Defines the `BinaryMessenger` abstract class, which provides an interface for sending and receiving binary messages between Flutter and host platforms. It serves as a low-level communication primitive.
SOURCE: https://api.flutter.dev/windows-embedder/basic__message__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger
  Methods:
    virtual void Send(const std::string &channel, const uint8_t *message, size_t message_size, BinaryReply reply=nullptr) const =0
    virtual void SetMessageHandler(const std::string &channel, BinaryMessageHandler handler)=0
```

----------------------------------------

TITLE: FlutterPluginRegistrar Protocol
DESCRIPTION: Provides a registration context for a FlutterPlugin, allowing access to contextual information and enabling registration of callbacks for various application events. It facilitates cross-plugin coordination.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_plugin_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterPluginRegistrar Protocol:
  - (NSObject<FlutterBinaryMessenger>*)messenger
    Description: Returns a FlutterBinaryMessenger for creating Dart/iOS communication channels.
    Return Type: NSObject<FlutterBinaryMessenger>*

  - (NSObject<FlutterTextureRegistry>*)textures
    Description: Returns a FlutterTextureRegistry for registering textures provided by the plugin.
    Return Type: NSObject<FlutterTextureRegistry>*

  - (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory withId:(NSString*)factoryId
    Description: Registers a FlutterPlatformViewFactory for creating platform views (UIViews) to be embedded in Flutter apps.
    Parameters:
      factory: The view factory to be registered.
      factoryId: A unique identifier for the factory, used by Dart code to request view creation.
    Return Type: void
```

----------------------------------------

TITLE: Flutter MethodChannel: Registering a Method Call Handler
DESCRIPTION: This C++ code illustrates how to register a handler for method calls received on a specific channel. It shows how a null handler can be used to unregister any previously set handler. The registered handler is responsible for decoding the incoming message into a MethodCall object and then invoking the user-provided handler with the decoded call and a result object.
SOURCE: https://api.flutter.dev/linux-embedder/method__channel_8h_source

LANGUAGE: C++
CODE:
```
void SetMethodCallHandler(MethodCallHandler<T> handler) const {
if (!handler) {
messenger_->SetMessageHandler(name_, nullptr);
return;
}
const auto* codec = codec_;
std::string channel_name = name_;
BinaryMessageHandler binary_handler = [handler, codec, channel_name](
const uint8_t* message,
size_t message_size,
BinaryReply reply) {
// Use this channel's codec to decode the call and build a result handler.
auto result =
std::make_unique<EngineMethodResult<T>>(std::move(reply), codec);
std::unique_ptr<MethodCall<T>> method_call =
codec->DecodeMethodCall(message, message_size);
if (!method_call) {
std::cerr << "Unable to construct method call from message on channel "
<< channel_name << std::endl;
result->NotImplemented();
return;
}
handler(*method_call, std::move(result));
};
messenger_->SetMessageHandler(name_, std::move(binary_handler));
}
```

----------------------------------------

TITLE: Add Application Lifecycle Delegate
DESCRIPTION: Registers an object that conforms to the FlutterAppLifecycleDelegate protocol to receive application lifecycle events. This allows custom logic to be executed during specific lifecycle stages.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_app_delegate_8mm_source

LANGUAGE: Objective-C++
CODE:
```
- (void)addApplicationLifecycleDelegate:(NSObject<FlutterAppLifecycleDelegate>*)delegate {
  [self.lifecycleRegistrar addDelegate:delegate];
}
```

----------------------------------------

TITLE: Flutter Windows Embedder Core API Functions
DESCRIPTION: Defines a set of static utility functions for managing Flutter engine, view, view controller, and texture registrar objects by converting between their internal C++ pointers and public desktop API handles, and for creating new view controllers.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8cc

LANGUAGE: APIDOC
CODE:
```
static flutter::FlutterWindowsEngine* EngineFromHandle(FlutterDesktopEngineRef ref)
```

LANGUAGE: APIDOC
CODE:
```
static FlutterDesktopEngineRef HandleForEngine(flutter::FlutterWindowsEngine* engine)
```

LANGUAGE: APIDOC
CODE:
```
static flutter::FlutterWindowsViewController* ViewControllerFromHandle(FlutterDesktopViewControllerRef ref)
```

LANGUAGE: APIDOC
CODE:
```
static FlutterDesktopViewControllerRef HandleForViewController(flutter::FlutterWindowsViewController* view_controller)
```

LANGUAGE: APIDOC
CODE:
```
static flutter::FlutterWindowsView* ViewFromHandle(FlutterDesktopViewRef ref)
```

LANGUAGE: APIDOC
CODE:
```
static FlutterDesktopViewRef HandleForView(flutter::FlutterWindowsView* view)
```

LANGUAGE: APIDOC
CODE:
```
static flutter::FlutterWindowsTextureRegistrar* TextureRegistrarFromHandle(FlutterDesktopTextureRegistrarRef ref)
```

LANGUAGE: APIDOC
CODE:
```
static FlutterDesktopTextureRegistrarRef HandleForTextureRegistrar(flutter::FlutterWindowsTextureRegistrar* registrar)
```

LANGUAGE: APIDOC
CODE:
```
static FlutterDesktopViewControllerRef CreateViewController(FlutterDesktopEngineRef engine_ref, int width, int height, bool owns_engine)
```

LANGUAGE: APIDOC
CODE:
```
FlutterDesktopViewControllerRef FlutterDesktopViewControllerCreate(int width, int height, FlutterDesktopEngineRef engine)
```

----------------------------------------

TITLE: Flutter iOS Embedder Core Headers Import
DESCRIPTION: This Objective-C header file (`Flutter.h`) acts as a master convenience header for the Flutter iOS embedder. It imports all core Flutter framework headers, including those for app delegation, binary messaging, plugin management, engine control, and UI integration, making it easier to include all necessary Flutter components in an iOS project.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_8h_source

LANGUAGE: Objective-C
CODE:
```
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_SHELL_PLATFORM_DARWIN_IOS_FRAMEWORK_HEADERS_FLUTTER_H_
#define FLUTTER_SHELL_PLATFORM_DARWIN_IOS_FRAMEWORK_HEADERS_FLUTTER_H_

#import "FlutterAppDelegate.h"
#import "FlutterBinaryMessenger.h"
#import "FlutterCallbackCache.h"
#import "FlutterChannels.h"
#import "FlutterCodecs.h"
#import "FlutterDartProject.h"
#import "FlutterEngine.h"
#import "FlutterEngineGroup.h"
#import "FlutterHeadlessDartRunner.h"
#import "FlutterMacros.h"
#import "FlutterPlatformViews.h"
#import "FlutterPlugin.h"
#import "FlutterPluginAppLifeCycleDelegate.h"
#import "FlutterTexture.h"
#import "FlutterViewController.h"

#endif // FLUTTER_SHELL_PLATFORM_DARWIN_IOS_FRAMEWORK_HEADERS_FLUTTER_H_
```

----------------------------------------

TITLE: FlutterEventChannel API Reference
DESCRIPTION: Documentation for the FlutterEventChannel class, which enables continuous communication from the host platform to Flutter, typically used for streams of events.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterEventChannel:
  Class Definition
```

----------------------------------------

TITLE: FlutterView Class API Reference
DESCRIPTION: Comprehensive API documentation for the `FlutterView` class, outlining its structure, instance methods, class methods, parameters, and return types.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_view

LANGUAGE: APIDOC
CODE:
```
Class: FlutterView
  Description: Represents a view that hosts Flutter content within an iOS application.
  Import: #import <FlutterView.h>

  Instance Methods:
    - (instancetype) NS_UNAVAILABLE
      Description: Unavailable initializer.

    - (instancetype) initWithFrame:(CGRect)frame
      Description: Unavailable initializer. FlutterView must be initialized with a delegate.
      Parameters:
        frame: (CGRect) NS_UNAVAILABLE - The frame rectangle for the view.

    - (instancetype) initWithCoder:(NSCoder*)aDecoder
      Description: Unavailable initializer. FlutterView must be initialized with a delegate.
      Parameters:
        aDecoder: (NSCoder*) NS_UNAVAILABLE - An unarchiver object.

    - (instancetype) initWithDelegate:(id<FlutterViewEngineDelegate>)delegate opaque:(BOOL)opaque enableWideGamut:(BOOL)isWideGamutEnabled
      Description: Initializes a new FlutterView instance with a delegate and rendering options.
      Parameters:
        delegate: (id<FlutterViewEngineDelegate>) The delegate for the Flutter engine view.
        opaque: (BOOL) A boolean indicating whether the view is opaque.
        isWideGamutEnabled: (BOOL) A boolean indicating whether wide gamut rendering is enabled.
      Return Type: (instancetype) The initialized FlutterView instance.
      Notes: NS_DESIGNATED_INITIALIZER

    - (UIScreen *) screen
      Description: Returns the UIScreen associated with the FlutterView.
      Return Type: (UIScreen *) The screen object.

    - (MTLPixelFormat) pixelFormat
      Description: Returns the Metal pixel format used by the FlutterView's layer.
      Return Type: (MTLPixelFormat) The pixel format.

  Class Methods:
    + (instancetype) NS_UNAVAILABLE
      Description: Unavailable class method.
```

----------------------------------------

TITLE: Flutter EventChannel Class Definition
DESCRIPTION: API documentation for the flutter::EventChannel class, which facilitates continuous communication streams from the host platform to Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/event__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::EventChannel
  Definition: event_channel.h:33
```

----------------------------------------

TITLE: FlutterFragmentActivity: Provide Custom FlutterEngine
DESCRIPTION: A hook for subclasses to easily provide a custom FlutterEngine instance. This method is part of the FlutterEngineProvider interface and is called with the current Android Context.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragmentActivity

LANGUAGE: APIDOC
CODE:
```
provideFlutterEngine(context: Context):
  @Nullable
  public FlutterEngine provideFlutterEngine(@NonNull Context context)
  Description: Hook for subclasses to easily provide a custom FlutterEngine.
  Specified by: provideFlutterEngine in interface FlutterEngineProvider
  Parameters:
    context: The current context. e.g. An activity.
  Returns: The Flutter engine.
```

----------------------------------------

TITLE: Dispose Flutter Keyboard Manager Resources
DESCRIPTION: Disposes of resources held by the FlKeyboardManager object. It cancels pending operations, resets internal data structures, clears object references, and disconnects signal handlers to prevent memory leaks. This method is typically called during object destruction.
SOURCE: https://api.flutter.dev/linux-embedder/fl__keyboard__manager_8cc

LANGUAGE: APIDOC
CODE:
```
static void fl_keyboard_manager_dispose(
  GObject *object
)
```

LANGUAGE: C++
CODE:
```
{
  FlKeyboardManager* self = FL_KEYBOARD_MANAGER(object);

  g_cancellable_cancel(self->cancellable);

  self->keycode_to_goals.reset();
  self->logical_to_mandatory_goals.reset();

  g_clear_pointer(&self->redispatched_key_events, g_ptr_array_unref);
  g_clear_object(&self->key_embedder_responder);
  g_clear_object(&self->key_channel_responder);
  g_clear_object(&self->derived_layout);
  if (self->keymap_keys_changed_cb_id != 0) {
    g_signal_handler_disconnect(self->keymap, self->keymap_keys_changed_cb_id);
    self->keymap_keys_changed_cb_id = 0;
  }
  g_clear_object(&self->cancellable);

  G_OBJECT_CLASS(fl_keyboard_manager_parent_class)->dispose(object);
}
```

----------------------------------------

TITLE: FlutterFragment Methods
DESCRIPTION: Details the methods available in FlutterFragment for engine management, lifecycle hooks, and view attachment.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: APIDOC
CODE:
```
Method: attachToEngineAutomatically()
  Returns: boolean
  Description: Whether to automatically attach the FlutterView to the engine.
Method: cleanUpFlutterEngine(FlutterEngine flutterEngine)
  Returns: void
  Parameters:
    flutterEngine: io.flutter.embedding.engine.FlutterEngine
  Description: Hook for the host to cleanup references that were established in configureFlutterEngine(FlutterEngine) before the host is destroyed or detached.
Method: configureFlutterEngine(FlutterEngine flutterEngine)
  Returns: void
  Parameters:
    flutterEngine: io.flutter.embedding.engine.FlutterEngine
  Description: Configures a FlutterEngine after its creation.
```

----------------------------------------

TITLE: Set Render Mode for FlutterFragment
DESCRIPTION: Specifies how Flutter content should be rendered, either as a RenderMode.surface or a RenderMode.texture. RenderMode.surface is generally recommended for performance, while RenderMode.texture offers more flexibility for display beneath other Android Views and animations, albeit with a significant performance impact.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.NewEngineInGroupFragmentBuilder

LANGUAGE: APIDOC
CODE:
```
renderMode(renderMode: @NonNull RenderMode): FlutterFragment.NewEngineInGroupFragmentBuilder
  renderMode: The desired rendering mode (RenderMode.surface or RenderMode.texture).
```

----------------------------------------

TITLE: API Definition: fl_method_call_respond
DESCRIPTION: This API function is used to send a response back to the Flutter method call. It takes the method call object, the response to send, and an optional GError pointer for error handling.
SOURCE: https://api.flutter.dev/linux-embedder/fl__text__input__channel_8cc

LANGUAGE: APIDOC
CODE:
```
G_MODULE_EXPORT gboolean fl_method_call_respond(
  FlMethodCall *self,
  FlMethodResponse *response,
  GError **error
)
```

----------------------------------------

TITLE: C API: Create New Method Error Response
DESCRIPTION: Creates a new Flutter method error response. This response type indicates that a method call failed due to an error, providing a code, message, and optional details.
SOURCE: https://api.flutter.dev/linux-embedder/fl__mouse__cursor__channel_8cc_source

LANGUAGE: APIDOC
CODE:
```
fl_method_error_response_new(const gchar *code, const gchar *message, FlValue *details) -> FlMethodErrorResponse *
  Parameters:
    code: An error code string.
    message: A human-readable error message.
    details: Optional FlValue containing additional error details.
  Returns: FlMethodErrorResponse * (A new error response instance).
```

----------------------------------------

TITLE: flutter::TextInputModel Class API Reference
DESCRIPTION: Defines the public interface for the `flutter::TextInputModel` class, used for managing and manipulating text input state within Flutter applications on Linux. It provides methods for setting and retrieving text, managing text selection and composing regions, and performing common text editing operations.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_text_input_model

LANGUAGE: APIDOC
CODE:
```
Class: flutter::TextInputModel
  Description: Manages text input state, including text content, selection, and composing ranges.
  Header: text_input_model.h

  Constructors:
    TextInputModel()
      Description: Default constructor.

  Destructor:
    ~TextInputModel()
      Description: Destructor for TextInputModel.

  Public Member Functions:
    SetText(const std::string &text, const TextRange &selection=TextRange(0), const TextRange &composing_range=TextRange(0)) -> bool
      Description: Sets the current text content, selection, and composing range.
      Parameters:
        text: The new text content.
        selection: The new selection range (defaults to TextRange(0)).
        composing_range: The new composing range (defaults to TextRange(0)).
      Returns: bool - True if successful.

    SetSelection(const TextRange &range) -> bool
      Description: Sets the current text selection range.
      Parameters:
        range: The new selection range.
      Returns: bool - True if successful.

    SetComposingRange(const TextRange &range, size_t cursor_offset) -> bool
      Description: Sets the current composing range and cursor offset within it.
      Parameters:
        range: The new composing range.
        cursor_offset: The cursor offset within the composing range.
      Returns: bool - True if successful.

    BeginComposing() -> void
      Description: Initiates a composing session.

    UpdateComposingText(const std::u16string &text, const TextRange &selection) -> void
      Description: Updates the composing text with a 16-bit Unicode string and selection.
      Parameters:
        text: The new composing text (UTF-16).
        selection: The selection within the composing text.

    UpdateComposingText(const std::u16string &text) -> void
      Description: Updates the composing text with a 16-bit Unicode string.
      Parameters:
        text: The new composing text (UTF-16).

    UpdateComposingText(const std::string &text) -> void
      Description: Updates the composing text with an 8-bit string.
      Parameters:
        text: The new composing text (UTF-8).

    CommitComposing() -> void
      Description: Commits the current composing text to the main text content.

    EndComposing() -> void
      Description: Ends the current composing session without committing.

    AddCodePoint(char32_t c) -> void
      Description: Adds a Unicode code point to the text at the current cursor position.
      Parameters:
        c: The Unicode code point to add.

    AddText(const std::u16string &text) -> void
      Description: Adds a 16-bit Unicode string to the text at the current cursor position.
      Parameters:
        text: The text to add (UTF-16).

    AddText(const std::string &text) -> void
      Description: Adds an 8-bit string to the text at the current cursor position.
      Parameters:
        text: The text to add (UTF-8).

    Delete() -> bool
      Description: Deletes the selected text or the character after the cursor if no selection.
      Returns: bool - True if text was deleted.

    DeleteSurrounding(int offset_from_cursor, int count) -> bool
      Description: Deletes a specified number of characters surrounding the cursor.
      Parameters:
        offset_from_cursor: Offset from the cursor to start deletion (negative for before, positive for after).
        count: Number of characters to delete.
      Returns: bool - True if text was deleted.

    Backspace() -> bool
      Description: Deletes the character before the cursor.
      Returns: bool - True if a character was deleted.

    MoveCursorBack() -> bool
      Description: Moves the cursor one position backward.
      Returns: bool - True if the cursor moved.

    MoveCursorForward() -> bool
      Description: Moves the cursor one position forward.
      Returns: bool - True if the cursor moved.

    MoveCursorToBeginning() -> bool
      Description: Moves the cursor to the beginning of the text.
      Returns: bool - True if the cursor moved.

    MoveCursorToEnd() -> bool
      Description: Moves the cursor to the end of the text.
      Returns: bool - True if the cursor moved.

    SelectToBeginning() -> bool
      Description: Extends the selection to the beginning of the text.
      Returns: bool - True if selection changed.

    SelectToEnd() -> bool
      Description: Extends the selection to the end of the text.
      Returns: bool - True if selection changed.

    GetText() const -> std::string
      Description: Retrieves the current text content.
      Returns: std::string - The current text.

    GetCursorOffset() const -> int
      Description: Retrieves the current cursor offset within the text.
      Returns: int - The cursor offset.

    text_range() const -> TextRange
      Description: Retrieves the full range of the text content.
      Returns: TextRange - The text range.

    selection() const -> TextRange
      Description: Retrieves the current selection range.
      Returns: TextRange - The selection range.

    composing_range() const -> TextRange
      Description: Retrieves the current composing range.
      Returns: TextRange - The composing range.

    composing() const -> bool
      Description: Checks if a composing session is active.
      Returns: bool - True if composing, false otherwise.
```

----------------------------------------

TITLE: FlutterView Class API Documentation
DESCRIPTION: Comprehensive API documentation for the FlutterView class, detailing its purpose, instance methods, and properties. This class is fundamental for integrating Flutter content and handling user input within a macOS application.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_view

LANGUAGE: APIDOC
CODE:
```
FlutterView Class Reference

Description: View capable of acting as a rendering target and input source for the Flutter engine.

Methods:
  - (nullable instancetype)initWithMTLDevice:(nonnull id< MTLDevice >)device commandQueue:(nonnull id< MTLCommandQueue >)commandQueue delegate:(nonnull id< FlutterViewDelegate >)delegate viewIdentifier:(FlutterViewIdentifier)viewIdentifier
    Description: Initialize a FlutterView that will be rendered to using Metal rendering apis.
    Parameters:
      device: (nonnull id< MTLDevice >)
      commandQueue: (nonnull id< MTLCommandQueue >)
      delegate: (nonnull id< FlutterViewDelegate >)
      viewIdentifier: (FlutterViewIdentifier)
    Return Type: (nullable instancetype)

  - (nullable instancetype)initWithFrame:(NSRect)frameRect pixelFormat:(nullable NSOpenGLPixelFormat *)NS_UNAVAILABLE
    Parameters:
      frameRect: (NSRect)
      pixelFormat: (nullable NSOpenGLPixelFormat *) NS_UNAVAILABLE
    Return Type: (nullable instancetype)

  - (nonnull instancetype)initWithFrame:(NSRect)NS_UNAVAILABLE
    Parameters:
      NS_UNAVAILABLE: (NSRect)
    Return Type: (nonnull instancetype)

  - (nullable instancetype)initWithCoder:(nonnull NSCoder *)NS_UNAVAILABLE
    Parameters:
      NS_UNAVAILABLE: (nonnull NSCoder *)
    Return Type: (nullable instancetype)

  - (nonnull instancetype)NS_UNAVAILABLE
    Return Type: (nonnull instancetype)

  - (void)setBackgroundColor:(nonnull NSColor *)color
    Description: By default, the `FlutterSurfaceManager` creates two layers to manage Flutter content, the content layer and containing layer. To set the native background color, onto which the Flutter content is drawn, call this method with the NSColor which you would like to override the default, black background color with.
    Parameters:
      color: (nonnull NSColor *)
    Return Type: (void)

  - (void)didUpdateMouseCursor:(nonnull NSCursor *)cursor
    Description: Called from the engine to notify the view that mouse cursor was updated while the mouse is over the view. The view is responsible from restoring the cursor when the mouse enters the view from another subview.
    Parameters:
      cursor: (nonnull NSCursor *)
    Return Type: (void)

  - (void)shutDown
    Description: Called from the controller to unblock resize synchronizer when shutting down.
    Return Type: (void)

Properties:
  surfaceManager: FlutterSurfaceManager *
```

----------------------------------------

TITLE: Handle Incoming Flutter Method Calls
DESCRIPTION: This method is a placeholder for handling incoming method calls from the Flutter engine. It receives a `FlutterMethodCall` object and a `FlutterResult` callback to send responses back to Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_platform_view_controller_8mm_source

LANGUAGE: Objective-C++
CODE:
```
- (void)handleMethodCall:(nonnull FlutterMethodCall*)call result:(nonnull FlutterResult)result {
```

----------------------------------------

TITLE: Register Message Handler (C++)
DESCRIPTION: Registers a handler to be invoked when a message is received on this channel. A null handler removes any previously registered handler. The caller is responsible for unregistering the handler to prevent dangling pointers, as the channel does not own it. The method internally decodes incoming binary messages and encodes outgoing responses using the channel's codec.
SOURCE: https://api.flutter.dev/macos-embedder/basic__message__channel_8h_source

LANGUAGE: cpp
CODE:
```
void SetMessageHandler(const MessageHandler<T>& handler) const {
  if (!handler) {
    messenger_->SetMessageHandler(name_, nullptr);
    return;
  }
  const auto* codec = codec_;
  std::string channel_name = name_;
  BinaryMessageHandler binary_handler = [handler, codec, channel_name](
  const uint8_t* binary_message,
  const size_t binary_message_size,
  const BinaryReply& binary_reply) {
  // Use this channel's codec to decode the message and build a reply
  // handler.
  std::unique_ptr<T> message =
  codec->DecodeMessage(binary_message, binary_message_size);
  if (!message) {
  std::cerr << "Unable to decode message on channel " << channel_name
  << std::endl;
  binary_reply(nullptr, 0);
  return;
  }

  MessageReply<T> unencoded_reply = [binary_reply,
  codec](const T& unencoded_response) {
  auto binary_response = codec->EncodeMessage(unencoded_response);
  binary_reply(binary_response->data(), binary_response->size());
  };
  handler(*message, std::move(unencoded_reply));
  };
  messenger_->SetMessageHandler(name_, std::move(binary_handler));
}
```

----------------------------------------

TITLE: FlutterTexture Protocol Member List
DESCRIPTION: Lists the methods available in the `FlutterTexture` protocol, an interface for objects that provide pixel buffers to Flutter textures. It includes methods for copying pixel data and handling texture unregistration.
SOURCE: https://api.flutter.dev/macos-embedder/protocol_flutter_texture-p-members

LANGUAGE: APIDOC
CODE:
```
protocol FlutterTexture {
  // Method to copy pixel data from the texture's buffer.
  // Signature: - (void)copyPixelBuffer;
  func copyPixelBuffer()

  // Method called when the texture is unregistered from the Flutter engine.
  // The trailing colon in 'onTextureUnregistered:' indicates it takes a parameter.
  // Signature: - (void)onTextureUnregistered:(id<FlutterTexture>)texture;
  func onTextureUnregistered(texture: Any?)
}
```

----------------------------------------

TITLE: Test Disabling Autocomplete for Password Autofill Fields
DESCRIPTION: This comprehensive test method sets up a mock Flutter environment, initializes FlutterTextInputPlugin, and configures an input client with an autofill dictionary containing a 'password' hint. It then calls TextInput.setClient and asserts that the plugin correctly disables automatic text completion and, on macOS 11.0+, sets the content type to NSTextContentTypePassword.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_plugin_test_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (bool)testAutocompleteDisabledWhenPasswordAutofillSet {
 // Set up FlutterTextInputPlugin.
 id engineMock = [flutter::testing::CreateMockFlutterEngine](@"");
 id binaryMessengerMock = OCMProtocolMock(@protocol([FlutterBinaryMessenger]));
 OCMStub( // NOLINT(google-objc-avoid-throwing-exception)
 [engineMock binaryMessenger])
 .andReturn(binaryMessengerMock);
 FlutterViewController* viewController = [[[FlutterViewController alloc] initWithEngine:engineMock
 nibName:@""
 bundle:nil];
 FlutterTextInputPluginTestDelegate* delegate =
 [[[FlutterTextInputPluginTestDelegate alloc] initWithBinaryMessenger:binaryMessengerMock
 viewController:viewController];

 FlutterTextInputPlugin* plugin = [[[FlutterTextInputPlugin alloc] initWithDelegate:delegate];

 // Set input client 1.
 NSDictionary* setClientConfig = @{
 @"viewId" : @(kViewId),
 @"inputAction" : @"action",
 @"inputType" : @{@"name" : @"inputName"},
 @"autofill" : @{
 @"uniqueIdentifier" : @"field1",
 @"hints" : @[ @"password" ],
 @"editingValue" : @{@"text" : @""},
 }
 };
 [plugin handleMethodCall:[FlutterMethodCall methodCallWithMethodName:@"TextInput.setClient"
 arguments:@[ @(1), setClientConfig ]]
 result:^(id){
 }];

 // Verify autocomplete is disabled.
 EXPECT_FALSE([plugin isAutomaticTextCompletionEnabled]);

 // Verify content type is password.
 if (@available(macOS 11.0, *)) {
 EXPECT_EQ([plugin contentType], NSTextContentTypePassword);
 }
 return true;
}
```

----------------------------------------

TITLE: Register Flutter Platform View Type
DESCRIPTION: Registers a custom platform view type with a Flutter desktop engine. This allows embedding native UI components into Flutter applications by associating a view type name with a factory and user data.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows__internal_8h_source

LANGUAGE: APIDOC
CODE:
```
FLUTTER_EXPORT void FlutterDesktopEngineRegisterPlatformViewType(
  FlutterDesktopEngineRef engine,
  const char* view_type_name,
  FlutterPlatformViewTypeEntry view_type
)
```

----------------------------------------

TITLE: MethodChannel Class API Reference
DESCRIPTION: Comprehensive API documentation for the `io.flutter.plugin.common.MethodChannel` class, detailing its purpose, nested interfaces, constructors, and instance methods for managing asynchronous communication channels between Flutter and Java.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodChannel

LANGUAGE: APIDOC
CODE:
```
Class: io.flutter.plugin.common.MethodChannel
Extends: java.lang.Object
Description: A named channel for communicating with the Flutter application using asynchronous method calls. Incoming method calls are decoded from binary on receipt, and Java results are encoded into binary before being transmitted back to Flutter. The MethodCodec used must be compatible with the one used by the Flutter application. This can be achieved by creating a MethodChannel counterpart of this channel on the Dart side. The Java type of method call arguments and results is Object, but only values supported by the specified MethodCodec can be used. The logical identity of the channel is given by its name. Identically named channels will interfere with each other's communication.

Nested Classes:
  - MethodChannel.MethodCallHandler (static interface)
    Description: A handler of incoming method calls.
  - MethodChannel.Result (static interface)
    Description: Method call result callback.

Constructors:
  - MethodChannel(BinaryMessenger messenger, String name)
    Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and the standard MethodCodec.
    Parameters:
      - messenger: BinaryMessenger
      - name: String
  - MethodChannel(BinaryMessenger messenger, String name, MethodCodec codec)
    Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and MethodCodec.
    Parameters:
      - messenger: BinaryMessenger
      - name: String
      - codec: MethodCodec
  - MethodChannel(BinaryMessenger messenger, String name, MethodCodec codec, BinaryMessenger.TaskQueue taskQueue)
    Description: Creates a new channel associated with the specified BinaryMessenger and with the specified name and MethodCodec.
    Parameters:
      - messenger: BinaryMessenger
      - name: String
      - codec: MethodCodec
      - taskQueue: BinaryMessenger.TaskQueue

Methods:
  - invokeMethod(String method, Object arguments)
    Description: Invokes a method on this channel, expecting no result.
    Parameters:
      - method: String
      - arguments: Object
    Returns: void
  - invokeMethod(String method, Object arguments, MethodChannel.Result callback)
    Description: Invokes a method on this channel, optionally expecting a result.
    Parameters:
      - method: String
      - arguments: Object
      - callback: MethodChannel.Result
    Returns: void
  - resizeChannelBuffer(int newSize)
    Description: Adjusts the number of messages that will get buffered when sending messages to channels that aren't fully set up yet.
    Parameters:
      - newSize: int
    Returns: void
```

----------------------------------------

TITLE: Flutter BinaryMessenger API Definition
DESCRIPTION: Definition of the `flutter::BinaryMessenger` class, which facilitates sending and receiving binary messages between Flutter and the host platform.
SOURCE: https://api.flutter.dev/windows-embedder/plugin__registrar_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger
Definition: binary_messenger.h:28
```

----------------------------------------

TITLE: API Documentation for KeyEventChannel Class
DESCRIPTION: Detailed API documentation for the `KeyEventChannel` class in Flutter's embedding engine, including its nested classes, fields, constructors, and methods for handling key events.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/KeyEventChannel

LANGUAGE: APIDOC
CODE:
```
Class: KeyEventChannel
Package: io.flutter.embedding.engine.systemchannels
Extends: java.lang.Object
Description: Event message channel for key events to/from the Flutter framework. Sends key up/down events to the framework, and receives asynchronous messages from the framework about whether or not the key was handled.

Nested Classes:
  - KeyEventChannel.EventResponseHandler (static interface):
      Description: A handler of incoming key handling messages.
  - KeyEventChannel.FlutterKeyEvent (static class):
      Description: A key event as defined by Flutter.

Fields:
  - channel:
      Type: final BasicMessageChannel<Object>
      Description: The message channel used for key events.

Constructors:
  - KeyEventChannel(BinaryMessenger binaryMessenger):
      Description: A constructor that creates a KeyEventChannel with the default message handler.
      Parameters:
        - binaryMessenger:
            Type: BinaryMessenger
            Description: The binary messenger used to send messages on this channel.

Methods:
  - sendFlutterKeyEvent(KeyEventChannel.FlutterKeyEvent keyEvent, boolean isKeyUp, KeyEventChannel.EventResponseHandler responseHandler):
      Return Type: void
      Description: Sends a Flutter key event to the framework, indicating whether it's a key up or down event, and provides a handler for the response.
      Parameters:
        - keyEvent:
            Type: KeyEventChannel.FlutterKeyEvent
            Description: The key event to send.
        - isKeyUp:
            Type: boolean
            Description: True if the key is up, false if down.
        - responseHandler:
            Type: KeyEventChannel.EventResponseHandler
            Description: A handler to receive the response from the framework.

Inherited Methods from java.lang.Object:
  - clone()
  - equals(Object)
  - finalize()
  - getClass()
  - hashCode()
  - notify()
  - notifyAll()
  - toString()
  - wait()
  - wait(long)
  - wait(long, int)
```

----------------------------------------

TITLE: APIDOC: flutter::MethodCodec< T > Class Reference
DESCRIPTION: This API documentation entry refers to the `MethodCodec` class, a templated class within the `flutter` namespace. It is central to the serialization and deserialization of method calls and results, facilitating communication between Flutter and the host platform.
SOURCE: https://api.flutter.dev/macos-embedder/method__codec_8h

LANGUAGE: APIDOC
CODE:
```
Class: flutter::MethodCodec< T >
```

----------------------------------------

TITLE: Add Plugin to flutter::PluginRegistrar
DESCRIPTION: Adds a unique pointer to a `Plugin` to the `PluginRegistrar`. This transfers ownership of the plugin to the registrar.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_plugin_registrar

LANGUAGE: APIDOC
CODE:
```
void flutter::PluginRegistrar::AddPlugin ( std::unique_ptr< Plugin > *plugin )
```

LANGUAGE: C++
CODE:
```
plugins_.insert(std::move(plugin));
```

----------------------------------------

TITLE: Android View Class Callback Methods
DESCRIPTION: Detailed listing of callback methods from the "android.view.View" class, including their signatures, used for responding to system events, user interactions, and managing view state.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterSurfaceView

LANGUAGE: APIDOC
CODE:
```
android.view.View Class Methods:
  - onFilterTouchEventForSecurity(android.view.MotionEvent)
  - onFinishInflate()
  - onFinishTemporaryDetach()
  - onGenericMotionEvent(android.view.MotionEvent)
  - onHoverChanged(boolean)
  - onHoverEvent(android.view.MotionEvent)
  - onInitializeAccessibilityEvent(android.view.accessibility.AccessibilityEvent)
  - onInitializeAccessibilityNodeInfo(android.view.accessibility.AccessibilityNodeInfo)
  - onKeyDown(int,android.view.KeyEvent)
  - onKeyLongPress(int,android.view.KeyEvent)
  - onKeyMultiple(int,int,android.view.KeyEvent)
  - onKeyPreIme(int,android.view.KeyEvent)
  - onKeyShortcut(int,android.view.KeyEvent)
  - onKeyUp(int,android.view.KeyEvent)
  - onLayout(boolean,int,int,int,int)
  - onOverScrolled(int,int,boolean,boolean)
  - onPointerCaptureChange(boolean)
  - onPopulateAccessibilityEvent(android.view.accessibility.AccessibilityEvent)
  - onProvideAutofillStructure(android.view.ViewStructure,int)
  - onProvideAutofillVirtualStructure(android.view.ViewStructure,int)
  - onProvideContentCaptureStructure(android.view.ViewStructure,int)
  - onProvideStructure(android.view.ViewStructure)
  - onProvideVirtualStructure(android.view.ViewStructure)
  - onReceiveContent(android.view.ContentInfo)
  - onResolvePointerIcon(android.view.MotionEvent,int)
  - onRestoreInstanceState(android.os.Parcelable)
  - onRtlPropertiesChanged(int)
  - onSaveInstanceState()
  - onScreenStateChanged(int)
  - onScrollCaptureSearch(...)
```

----------------------------------------

TITLE: APIDOC: FlBasicMessageChannelMessageHandler Callback
DESCRIPTION: Documentation for the `FlBasicMessageChannelMessageHandler` function signature, which is called when a message is received on an `FlBasicMessageChannel`. It details the parameters and the requirement to call `fl_basic_message_channel_respond()`.
SOURCE: https://api.flutter.dev/linux-embedder/fl__basic__message__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
FlBasicMessageChannelMessageHandler:
  Parameters:
    @channel: an #FlBasicMessageChannel.
    @message: message received.
    @response_handle: a handle to respond to the message with.
    @user_data: (closure): data provided when registering this handler.
  Description: Function called when a message is received. Call fl_basic_message_channel_respond() to respond to this message. If the response is not occurring in this callback take a reference to @response_handle and release that once it has been responded to. Failing to
```

----------------------------------------

TITLE: Perform Platform View Submission and Mutation (iOS)
DESCRIPTION: Updates the buffers and applies mutations to platform views within a CATransaction on the platform thread. This method orchestrates the rendering and transformation of platform views based on their current composition parameters, views requiring recomposition, and surface frames.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_views_controller_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)performSubmit:(const LayersMap&)platformViewLayers currentCompositionParams:(std::unordered_map<int64_t, flutter::EmbeddedViewParams>&)currentCompositionParams viewsToRecomposite:(const std::unordered_set<int64_t>&)viewsToRecomposite compositionOrder:(const std::vector<int64_t>&)compositionOrder unusedLayers:(const std::vector<std::shared_ptr<flutter::OverlayLayer>>&)unusedLayers surfaceFrames:(const std::vector<std::unique_ptr<flutter::SurfaceFrame>>&)surfaceFrames;
```

----------------------------------------

TITLE: Flutter AccessibilityBridge Class API Reference
DESCRIPTION: Defines the interface and internal members of the `flutter::AccessibilityBridge` class, which manages accessibility interactions between the Flutter engine and the iOS platform. This includes methods for dispatching semantics actions, handling focus changes, and accessing platform views, along with its private state variables and helper functions.
SOURCE: https://api.flutter.dev/ios-embedder/darwin_2ios_2framework_2_source_2accessibility__bridge_8h_source

LANGUAGE: APIDOC
CODE:
```
class flutter::AccessibilityBridge {
  // Public Methods
  void DispatchSemanticsAction(int32_t id, flutter::SemanticsAction action) override;
  void DispatchSemanticsAction(int32_t id, flutter::SemanticsAction action, fml::MallocMapping args) override;
  void AccessibilityObjectDidBecomeFocused(int32_t id) override;
  void AccessibilityObjectDidLoseFocus(int32_t id) override;
  UIView<UITextInput>* textInputView() override;
  UIView* view() const override;
  bool isVoiceOverRunning() const override;
  fml::WeakPtr<AccessibilityBridge> GetWeakPtr();
  FlutterPlatformViewsController* GetPlatformViewsController() const override;
  void clearState();

  // Private Members and Methods
  private:
    SemanticsObject* GetOrCreateObject(int32_t id, flutter::SemanticsNodeUpdates& updates);
    SemanticsObject* FindNextFocusableIfNecessary();
    SemanticsObject* FindFirstFocusable(SemanticsObject* parent);
    void VisitObjectsRecursivelyAndRemove(SemanticsObject* object, NSMutableArray<NSNumber*>* doomed_uids);

    FlutterViewController* view_controller_;
    PlatformViewIOS* platform_view_;
    __weak FlutterPlatformViewsController* platform_views_controller_;
    int32_t last_focused_semantics_object_id_;
    NSMutableDictionary<NSNumber*, SemanticsObject*>* objects_;
    FlutterBasicMessageChannel* accessibility_channel_;
    int32_t previous_route_id_;
    std::unordered_map<int32_t, flutter::CustomAccessibilityAction> actions_;
    std::vector<int32_t> previous_routes_;
    std::unique_ptr<IosDelegate> ios_delegate_;
    fml::WeakPtrFactory<AccessibilityBridge> weak_factory_;
    // FML_DISALLOW_COPY_AND_ASSIGN(AccessibilityBridge) - Macro for preventing copy/assign
}
```

----------------------------------------

TITLE: FlutterMethodCall Interface and Properties
DESCRIPTION: Represents a method call from the Flutter engine to the host platform, encapsulating the method name and its arguments.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_codecs_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodCall:
  method: NSString *
  arguments: id
```

----------------------------------------

TITLE: Flutter TextInput Channel Method Constants
DESCRIPTION: Defines the constant string literals for methods invoked on the 'TextInput' channel from the Flutter engine to the Windows embedder. These methods control the state and behavior of the text input client, such as setting editing state, managing client focus, and showing/hiding the software keyboard.
SOURCE: https://api.flutter.dev/windows-embedder/text__input__plugin_8cc_source

LANGUAGE: C++
CODE:
```
static constexpr char kSetEditingStateMethod[] = "TextInput.setEditingState";
static constexpr char kClearClientMethod[] = "TextInput.clearClient";
static constexpr char kSetClientMethod[] = "TextInput.setClient";
static constexpr char kShowMethod[] = "TextInput.show";
static constexpr char kHideMethod[] = "TextInput.hide";
static constexpr char kSetMarkedTextRect[] = "TextInput.setMarkedTextRect";
static constexpr char kSetEditableSizeAndTransform[] = "TextInput.setEditableSizeAndTransform";
static constexpr char kMultilineInputType[] = "TextInputType.multiline";
```

LANGUAGE: APIDOC
CODE:
```
TextInput Channel Methods:
  TextInput.setEditingState: Sets the current editing state of the text input client.
  TextInput.clearClient: Clears the current text input client.
  TextInput.setClient: Sets the active text input client.
  TextInput.show: Requests to show the software keyboard.
  TextInput.hide: Requests to hide the software keyboard.
  TextInput.setMarkedTextRect: Sets the rectangle for marked text.
  TextInput.setEditableSizeAndTransform: Sets the size and transform of the editable region.
  TextInputType.multiline: Constant for multiline input type.
```

----------------------------------------

TITLE: FlEngine Class Methods and Properties
DESCRIPTION: This section outlines the public API of the FlEngine, detailing the functions available for interacting with a Flutter engine instance. It includes methods for initialization, retrieving associated components, managing views, and handling platform messages.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc

LANGUAGE: APIDOC
CODE:
```
FlEngine Class/Interface:
  - fl_engine_new_with_binary_messenger(binary_messenger: FlBinaryMessenger*): FlEngine*
    Description: Creates a new FlEngine instance, initialized with a binary messenger.
  - fl_engine_new_headless(project: FlDartProject*): FlEngine*
    Description: Creates a new headless FlEngine instance from a Dart project.
  - fl_engine_get_compositor(self: FlEngine*): FlCompositor*
    Description: Retrieves the compositor associated with the engine.
  - fl_engine_get_opengl_manager(self: FlEngine*): FlOpenGLManager*
    Description: Retrieves the OpenGL manager associated with the engine.
  - fl_engine_get_display_monitor(self: FlEngine*): FlDisplayMonitor*
    Description: Retrieves the display monitor associated with the engine.
  - fl_engine_start(self: FlEngine*, error: GError**): gboolean
    Description: Starts the Flutter engine.
  - fl_engine_get_embedder_api(self: FlEngine*): FlutterEngineProcTable*
    Description: Retrieves the embedder API table for the engine.
  - fl_engine_notify_display_update(self: FlEngine*, displays: const FlutterEngineDisplay*, displays_length: size_t): void
    Description: Notifies the engine about display updates.
  - fl_engine_set_implicit_view(self: FlEngine*, renderable: FlRenderable*): void
    Description: Sets an implicit view for the engine.
  - fl_engine_add_view(self: FlEngine*, renderable: FlRenderable*, width: size_t, height: size_t, pixel_ratio: double, cancellable: GCancellable*, callback: GAsyncReadyCallback, user_data: gpointer): FlutterViewId
    Description: Adds a new view to the engine.
  - fl_engine_add_view_finish(self: FlEngine*, result: GAsyncResult*, error: GError**): gboolean
    Description: Finishes the asynchronous operation of adding a view.
  - fl_engine_get_renderable(self: FlEngine*, view_id: FlutterViewId): FlRenderable*
    Description: Retrieves the renderable object for a given view ID.
  - fl_engine_remove_view(self: FlEngine*, view_id: FlutterViewId, cancellable: GCancellable*, callback: GAsyncReadyCallback, user_data: gpointer): void
    Description: Removes a view from the engine.
  - fl_engine_remove_view_finish(self: FlEngine*, result: GAsyncResult*, error: GError**): gboolean
    Description: Finishes the asynchronous operation of removing a view.
  - fl_engine_set_platform_message_handler(self: FlEngine*, handler: FlEnginePlatformMessageHandler, user_data: gpointer, destroy_notify: GDestroyNotify): void
    Description: Sets the platform message handler for the engine.
  - fl_engine_send_platform_message_response(self: FlEngine*, handle: const FlutterPlatformMessageResponseHandle*, response: GBytes*, error: GError**): gboolean
    Description: Sends a response to a platform message.
  - fl_engine_send_platform_message(self: FlEngine*, channel: const gchar*, message: GBytes*, cancellable: GCancellable*, callback: GAsyncReadyCallback, user_data: gpointer): void
    Description: Sends a platform message to the Flutter engine.
  - fl_engine_send_platform_message_finish(self: FlEngine*, result: GAsyncResult*, error: GError**): GBytes*
    Description: Finishes the asynchronous operation of sending a platform message.
  - fl_engine_send_window_metrics_event(self: FlEngine*, display_id: FlutterEngineDisplayId, view_id: FlutterViewId, width: size_t, height: size_t, pixel_ratio: double): void
    Description: Sends a window metrics event to the engine.
```

----------------------------------------

TITLE: Flutter EventChannel: Set and Unset Stream Handler
DESCRIPTION: This snippet demonstrates how to register a stream handler with an EventChannel and then unregister it by setting the handler to nullptr. It includes assertions to verify the state of the binary messenger after these operations.
SOURCE: https://api.flutter.dev/linux-embedder/event__channel__unittests_8cc_source

LANGUAGE: C++
CODE:
```
-> std::unique_ptr<StreamHandlerError<>> { return nullptr; },
[](const EncodableValue* arguments)
-> std::unique_ptr<StreamHandlerError<>> { return nullptr; });
channel.SetStreamHandler(std::move(handler));
EXPECT_EQ(messenger.last_message_handler_channel(), channel_name);
EXPECT_NE(messenger.last_message_handler(), nullptr);

channel.SetStreamHandler(nullptr);
EXPECT_EQ(messenger.last_message_handler_channel(), channel_name);
EXPECT_EQ(messenger.last_message_handler(), nullptr);
```

----------------------------------------

TITLE: API Documentation for flutter::EncodableValue Class
DESCRIPTION: This snippet provides a structured overview of the `flutter::EncodableValue` class, detailing its constructors, public member functions, type definitions, and friend functions. It serves as a fundamental class for handling various encodable data types within the Flutter Linux Embedder.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_encodable_value

LANGUAGE: APIDOC
CODE:
```
flutter::EncodableValue Class Reference

#include <encodable_value.h>

Inheritance Diagram:
  - Inherits from internal::EncodableValueVariant (via 'super' typedef)

Public Types:
  - using super = internal::EncodableValueVariant
    - Definition: encodable_value.h:168

Public Member Functions:
  - EncodableValue(): default constructor
  - EncodableValue(const char *string)
    - Parameters:
      - string: const char*
    - Definition: encodable_value.h:176 (super(std::string(string)))
  - EncodableValue(const CustomEncodableValue &v)
    - Parameters:
      - v: const CustomEncodableValue&
    - Definition: encodable_value.h:188 (super(v))
  - template<class T> constexpr EncodableValue(T &&t) noexcept
    - Parameters:
      - t: T&&
    - Definition: encodable_value.h:199 (super(t))
  - EncodableValue& operator=(const char *other)
    - Parameters:
      - other: const char*
  - bool IsNull() const
  - int64_t LongValue() const

Friends:
  - bool operator<(const EncodableValue &lhs, const EncodableValue &rhs)
    - Parameters:
      - lhs: const EncodableValue&
      - rhs: const EncodableValue&
```

----------------------------------------

TITLE: Process Key Event and Synchronize Modifiers
DESCRIPTION: This Objective-C code snippet demonstrates the core logic for processing a key event. It determines the target modifier flag, handles special keys like Caps Lock, synchronizes modifier states, and sends appropriate modifier events based on the key's pressed state. It includes assertions for state consistency.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_embedder_key_responder_8mm_source

LANGUAGE: Objective-C
CODE:
```
NSNumber* targetModifierFlagObj = [flutter::keyCodeToModifierFlag @(event.keyCode)];
NSUInteger targetModifierFlag =
targetModifierFlagObj == nil ? 0 : [targetModifierFlagObj unsignedLongValue];
uint64_t targetKey = GetPhysicalKeyForKeyCode(event.keyCode);
if (targetKey == flutter::kCapsLockPhysicalKey) {
return [self handleCapsLockEvent:event callback:callback];
}
[self synchronizeModifiers:event.modifierFlags
ignoringFlags:targetModifierFlag
timestamp:event.timestamp
guard:callback];
NSNumber* pressedLogicalKey = [_pressingRecords objectForKey:@(targetKey)];
BOOL lastTargetPressed = pressedLogicalKey != nil;
NSAssert(targetModifierFlagObj == nil ||
(_lastModifierFlagsOfInterest & targetModifierFlag) != 0 == lastTargetPressed,
@"Desynchronized state between lastModifierFlagsOfInterest (0x%lx) on bit 0x%lx "
@"for keyCode 0x%hx, whose pressing state is %@.",
_lastModifierFlagsOfInterest, targetModifierFlag, event.keyCode,
lastTargetPressed
? [NSString stringWithFormat:@"0x%llx", [pressedLogicalKey unsignedLongLongValue]]
: @"empty");
BOOL shouldBePressed = (event.modifierFlags & targetModifierFlag) != 0;
if (lastTargetPressed == shouldBePressed) {
[callback resolveTo:TRUE];
return;
}
_lastModifierFlagsOfInterest = _lastModifierFlagsOfInterest ^ targetModifierFlag;
[self sendModifierEventOfType:shouldBePressed
timestamp:event.timestamp
keyCode:event.keyCode
synthesized:false
callback:callback];
```

----------------------------------------

TITLE: Create Background Task Queue (With Options)
DESCRIPTION: Creates a `TaskQueue` that executes tasks serially on a background thread, with configurable options. `BinaryMessenger.TaskQueueOptions` can enable concurrent task execution, which is more performant but requires thread-safe handlers.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/BinaryMessenger

LANGUAGE: APIDOC
CODE:
```
BinaryMessenger.TaskQueue makeBackgroundTaskQueue(BinaryMessenger.TaskQueueOptions options)
  Parameters:
    options: BinaryMessenger.TaskQueueOptions - Options to configure the task queue to execute tasks concurrently.
  Description: Creates a TaskQueue that executes the tasks serially on a background thread.
  Notes: Doing so can be more performant, though users need to ensure that the task handlers are thread-safe.
```

----------------------------------------

TITLE: Pop Flutter Navigator Route
DESCRIPTION: Instructs the Flutter Navigator (if any) to go back, removing the top route from the navigation stack.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8h_source

LANGUAGE: APIDOC
CODE:
```
Method Signature:
  - (void)popRoute;
```

----------------------------------------

TITLE: Get Initial Route
DESCRIPTION: Returns the initial route that should be rendered within Flutter, once the Flutter app starts. Defaults to `null`, which signifies a route of "/" in Flutter. This method is used by this `FlutterFragment`'s `FlutterActivityAndFragmentDelegate.Host`.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: Java
CODE:
```
@Nullable
public String getInitialRoute()
```

LANGUAGE: APIDOC
CODE:
```
Method: getInitialRoute
  Returns: String (nullable)
  Description: Returns the initial route that should be rendered within Flutter, once the Flutter app starts.
  Default: null (signifies "/" in Flutter)
  Usage: Used by this `FlutterFragment`'s `FlutterActivityAndFragmentDelegate.Host`
```

----------------------------------------

TITLE: FlutterAppDelegate Class Member List
DESCRIPTION: Documents the complete list of members (methods and properties) for the `FlutterAppDelegate` class, including inherited members from protocols like `FlutterAppLifecycleProvider`, relevant for Flutter macOS applications.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_app_delegate-members

LANGUAGE: APIDOC
CODE:
```
FlutterAppDelegate Class:
  Description: Complete list of members for FlutterAppDelegate, including inherited members.

  Members:
    - Method: addApplicationLifecycleDelegate:
      Inherited From: <FlutterAppLifecycleDelegate>
      Description: Adds an application lifecycle delegate.

    - Property: applicationMenu
      Defined In: FlutterAppDelegate
      Description: The application's main menu.

    - Property: mainFlutterWindow
      Defined In: FlutterAppDelegate
      Description: The main Flutter window.

    - Method: removeApplicationLifecycleDelegate:
      Inherited From: <FlutterAppLifecycleDelegate>
      Description: Removes an application lifecycle delegate.
```

----------------------------------------

TITLE: FlutterBinaryMessenger Instance Methods
DESCRIPTION: Details the instance methods inherited from the FlutterBinaryMessenger protocol, which facilitates asynchronous message passing between Flutter and the host platform, including creating background task queues and sending/receiving messages on channels.
SOURCE: https://api.flutter.dev/ios-embedder/category_flutter_engine_07_08

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryMessenger:
  - (NSObject<FlutterTaskQueue> *)makeBackgroundTaskQueue; // TODO(gaaclarke): Remove optional when macos supports Background Platform Channels.
  - (FlutterBinaryMessengerConnection)setMessageHandlerOnChannel:(id)channel binaryMessageHandler:(id)handler taskQueue:(id)queue;
  - (void)sendOnChannel:(id)channel message:(id)message;
  - (void)sendOnChannel:(id)channel message:(id)message binaryReply:(id)reply;
  - (FlutterBinaryMessengerConnection)setMessageHandlerOnChannel:(id)channel binaryMessageHandler:(id)handler;
  - (void)cleanUpConnection:(id)connection;
```

----------------------------------------

TITLE: APIDOC: fl_method_channel_set_method_call_handler - Set Method Call Handler
DESCRIPTION: Sets a handler function for incoming method calls on a specified method channel. This handler will be invoked whenever a method call is received from the Flutter side. It allows the host application to respond to specific method invocations.
SOURCE: https://api.flutter.dev/linux-embedder/fl__windowing__channel_8cc_source

LANGUAGE: C
CODE:
```
G_MODULE_EXPORT void fl_method_channel_set_method_call_handler(FlMethodChannel *self, FlMethodChannelMethodCallHandler handler, gpointer user_data, GDestroyNotify destroy_notify)
```

----------------------------------------

TITLE: io.flutter.plugin.platform Package Classes and Interfaces
DESCRIPTION: Overview of the classes and interfaces available in the `io.flutter.plugin.platform` package, detailing their purpose and functionality for integrating Android platform views into Flutter applications.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/package-summary

LANGUAGE: APIDOC
CODE:
```
Package: io.flutter.plugin.platform

Classes and Interfaces:
  ImageReaderPlatformViewRenderTarget: class in io.flutter.plugin.platform
  PlatformOverlayView: A host view for Flutter content displayed over a platform view.
  PlatformPlugin: Android implementation of the platform plugin.
  PlatformPlugin.PlatformPluginDelegate: The PlatformPlugin generally has default behaviors implemented for platform functionalities requested by the Flutter framework.
  PlatformView: A handle to an Android view to be embedded in the Flutter hierarchy.
  PlatformViewFactory: class in io.flutter.plugin.platform
  PlatformViewRegistry: Registry for platform view factories.
  PlatformViewRegistryImpl: class in io.flutter.plugin.platform
  PlatformViewRenderTarget: A PlatformViewRenderTarget interface allows an Android Platform View to be rendered into an offscreen buffer (usually a texture is involved) that the engine can compose into the FlutterView.
  PlatformViewsAccessibilityDelegate: Facilitates interaction between the accessibility bridge and embedded platform views.
  PlatformViewsController: Manages platform views.
  PlatformViewsController2: Manages platform views.
  PlatformViewWrapper: Wraps a platform view to intercept gestures and project this view onto a PlatformViewRenderTarget.
  SurfaceProducerPlatformViewRenderTarget: class in io.flutter.plugin.platform
  SurfaceTexturePlatformViewRenderTarget: class in io.flutter.plugin.platform
```

----------------------------------------

TITLE: FlutterView
DESCRIPTION: Displays a Flutter UI on an Android device.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/package-summary

LANGUAGE: APIDOC
CODE:
```
class io.flutter.embedding.android.FlutterView
```

----------------------------------------

TITLE: FlutterPluginBinding Constructor API
DESCRIPTION: Initializes a new instance of FlutterPluginBinding, providing access to essential Flutter engine and Android context dependencies for plugin development.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.FlutterPluginBinding

LANGUAGE: APIDOC
CODE:
```
public FlutterPluginBinding(
  @NonNull Context applicationContext,
  @NonNull FlutterEngine flutterEngine,
  @NonNull BinaryMessenger binaryMessenger,
  @NonNull TextureRegistry textureRegistry,
  @NonNull PlatformViewRegistry platformViewRegistry,
  @NonNull FlutterPlugin.FlutterAssets flutterAssets,
  @Nullable FlutterEngineGroup group
)
```

----------------------------------------

TITLE: Implement KeyboardHook for Flutter Keyboard Event Handling in C++
DESCRIPTION: This C++ function `KeyboardHook` processes raw keyboard input (key, scancode, action, character, extended, was_down) and a callback. It constructs a `rapidjson::Document` representing the keyboard event, populating it with key details, scancode (with extended flag), character code point, key map (Windows), and modifiers. It then determines the event type (KeyDown or KeyUp) based on Windows messages (WM_SYSKEYDOWN, WM_KEYDOWN, WM_SYSKEYUP, WM_KEYUP) and sends the event through a channel. The callback is invoked with `true` if the event was handled, `false` otherwise.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_keyboard_key_channel_handler

LANGUAGE: C++
CODE:
```
void flutter::KeyboardKeyChannelHandler::KeyboardHook(
  int key,
  int scancode,
  int action,
  char32_t character,
  bool extended,
  bool was_down,
  std::function<void(bool)> callback
) {
  // TODO: Translate to a cross-platform key code system rather than passing
  // the native key code.
  rapidjson::Document event(rapidjson::kObjectType);
  auto& allocator = event.GetAllocator();
  event.AddMember(kKeyCodeKey, key, allocator);
  event.AddMember(kScanCodeKey, scancode | (extended ? kScancodeExtended : 0),
  allocator);
  event.AddMember(kCharacterCodePointKey, UndeadChar(character), allocator);
  event.AddMember(kKeyMapKey, kWindowsKeyMap, allocator);
  event.AddMember(kModifiersKey, GetModsForKeyState(), allocator);

  switch (action) {
  case WM_SYSKEYDOWN:
  case WM_KEYDOWN:
  event.AddMember(kTypeKey, kKeyDown, allocator);
  break;
  case WM_SYSKEYUP:
  case WM_KEYUP:
  event.AddMember(kTypeKey, kKeyUp, allocator);
  break;
  default:
  FML_LOG(WARNING) << "Unknown key event action: " << action;
  callback(false);
  return;
  }
  channel_->Send(event, [callback = std::move(callback)](const uint8_t* reply,
  size_t reply_size) {
  auto decoded = flutter::JsonMessageCodec::GetInstance().DecodeMessage(
  reply, reply_size);
  bool handled = decoded ? (*decoded)[kHandledKey].GetBool() : false;
  callback(handled);
  });
}
```

----------------------------------------

TITLE: Navigator.restorablePushNamedAndRemoveUntil
DESCRIPTION: Push the route with the given name onto the navigator that most tightly encloses the given context, and then remove all the previous routes until
SOURCE: https://api.flutter.dev/flutter/widgets/Navigator-class

LANGUAGE: APIDOC
CODE:
```
restorablePushNamedAndRemoveUntil<T extends Object?>(BuildContext context, String newRouteName, RoutePredicate predicate, {Object? arguments}) → String
```

----------------------------------------

TITLE: APIDOC: flutter::BinaryMessenger::SetMessageHandler Method
DESCRIPTION: Virtual method to set a message handler for a specific channel. This handler will be invoked when binary messages are received on the specified channel, allowing custom processing and replies.
SOURCE: https://api.flutter.dev/linux-embedder/classflutter_1_1_event_channel

LANGUAGE: APIDOC
CODE:
```
flutter::BinaryMessenger::SetMessageHandler:
  virtual void SetMessageHandler(const std::string &channel, BinaryMessageHandler handler) = 0
  Parameters:
    channel: The name of the channel to set the handler for.
    handler: The BinaryMessageHandler callback to be invoked for messages on the channel.
```

----------------------------------------

TITLE: FlutterMethodCall Interface API
DESCRIPTION: Describes the `FlutterMethodCall` interface, which encapsulates a method call from the Flutter engine to the host platform, including the method name and its arguments.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_plugin_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterMethodCall:
  Properties:
    NSString * method
    id arguments
```

----------------------------------------

TITLE: Serialize EncodableValue types to a byte stream (StandardCodecSerializer::WriteValue)
DESCRIPTION: This C++ code snippet demonstrates how the `StandardCodecSerializer::WriteValue` method serializes different `EncodableValue` types (integers, doubles, strings, lists, maps, and various vectors) into a `ByteStreamWriter`. It includes type-specific serialization logic, such as size prefixes for strings, lists, and maps, and alignment for doubles. The snippet also indicates that custom types require codec extensions.
SOURCE: https://api.flutter.dev/ios-embedder/standard__codec_8cc_source

LANGUAGE: C++
CODE:
```
stream->WriteInt64(std::get<int64_t>(value));
break;
case 4:
stream->WriteAlignment(8);
stream->WriteDouble(std::get<double>(value));
break;
case 5: {
const auto& string_value = std::get<std::string>(value);
size_t size = string_value.size();
WriteSize(size, stream);
if (size > 0) {
stream->WriteBytes(
reinterpret_cast<const uint8_t*>(string_value.data()), size);
}
break;
}
case 6:
WriteVector(std::get<std::vector<uint8_t>>(value), stream);
break;
case 7:
WriteVector(std::get<std::vector<int32_t>>(value), stream);
break;
case 8:
WriteVector(std::get<std::vector<int64_t>>(value), stream);
break;
case 9:
WriteVector(std::get<std::vector<double>>(value), stream);
break;
case 10: {
const auto& list = std::get<EncodableList>(value);
WriteSize(list.size(), stream);
for (const auto& item : list) {
WriteValue(item, stream);
}
break;
}
case 11: {
const auto& map = std::get<EncodableMap>(value);
WriteSize(map.size(), stream);
for (const auto& pair : map) {
WriteValue(pair.first, stream);
WriteValue(pair.second, stream);
}
break;
}
case 12:
std::cerr
<< "Unhandled custom type in StandardCodecSerializer::WriteValue. "
<< "Custom types require codec extensions." << std::endl;
break;
case 13: {
WriteVector(std::get<std::vector<float>>(value), stream);
break;
}
}
```

----------------------------------------

TITLE: Handle Flutter Key Down Event (AZERTY Keyboard)
DESCRIPTION: This snippet demonstrates handling a key press event for the 'A' key on an AZERTY keyboard, which logically maps to 'Q'. It initializes an FlKeyEvent, processes it with fl_key_embedder_responder_handle_event, and includes assertions to verify event properties such as timestamp, type (kFlutterKeyEventTypeDown), physical key (kPhysicalKeyA), logical key (kLogicalKeyQ), and the resulting character ('q'). The test flow includes running a GMainLoop and clearing records.
SOURCE: https://api.flutter.dev/linux-embedder/fl__key__embedder__responder__test_8cc_source

LANGUAGE: C++
CODE:
```
// On an AZERTY keyboard, press key Q (physically key A), and release.
// Key down
g_autoptr(FlKeyEvent) event3 =
fl_key_event_new(12347, kPress, kKeyCodeKeyA, GDK_KEY_q,
static_cast<GdkModifierType>(0), 0);
g_autoptr(GMainLoop) loop3 = g_main_loop_new(nullptr, 0);
fl_key_embedder_responder_handle_event(
responder, event3, 0, nullptr,
[](GObject* object, GAsyncResult* result, gpointer user_data) {
gboolean handled;
EXPECT_TRUE(fl_key_embedder_responder_handle_event_finish(
FL_KEY_EMBEDDER_RESPONDER(object), result, &handled, nullptr));
EXPECT_EQ(handled, TRUE);

g_main_loop_quit(static_cast<GMainLoop*>(user_data));
},
loop3);

EXPECT_EQ(call_records->len, 1u);
record = FL_KEY_EMBEDDER_CALL_RECORD(g_ptr_array_index(call_records, 0));
EXPECT_EQ(record->event->struct_size, sizeof(FlutterKeyEvent));
EXPECT_EQ(record->event->timestamp, 12347000);
EXPECT_EQ(record->event->type, kFlutterKeyEventTypeDown);
EXPECT_EQ(record->event->physical, kPhysicalKeyA);
EXPECT_EQ(record->event->logical, kLogicalKeyQ);
EXPECT_STREQ(record->event->character, "q");
EXPECT_EQ(record->event->synthesized, false);

invoke_record_callback(record, TRUE);
g_main_loop_run(loop3);
clear_records(call_records);
```

----------------------------------------

TITLE: FlutterBinaryMessenger-p Protocol Methods
DESCRIPTION: Details the methods available within the FlutterBinaryMessenger-p protocol, including how to send messages, set message handlers, and create background task queues for asynchronous operations.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_binary_messenger_relay_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterBinaryMessenger-p
  sendOnChannel:message:binaryReply:
    Description: Sends a binary message on a specified channel with an optional binary reply callback.
    Signature: void sendOnChannel:(NSString *channel) message:(NSData *_Nullable message) binaryReply:(FlutterBinaryReply _Nullable callback)
    Parameters:
      channel: NSString * - The name of the channel.
      message: NSData *_Nullable - The binary message data to send.
      callback: FlutterBinaryReply _Nullable - An optional callback to receive a binary reply.
    Return Type: void

  setMessageHandlerOnChannel:binaryMessageHandler:taskQueue:
    Description: Sets a binary message handler for a specific channel, optionally associating it with a task queue.
    Signature: FlutterBinaryMessengerConnection setMessageHandlerOnChannel:(NSString *channel) binaryMessageHandler:(FlutterBinaryMessageHandler _Nullable handler) taskQueue:(NSObject< FlutterTaskQueue > *_Nullable taskQueue)
    Parameters:
      channel: NSString * - The name of the channel.
      handler: FlutterBinaryMessageHandler _Nullable - The handler to process incoming binary messages.
      taskQueue: NSObject< FlutterTaskQueue > *_Nullable - An optional task queue to dispatch handler calls.
    Return Type: FlutterBinaryMessengerConnection

  makeBackgroundTaskQueue
    Description: Creates and returns a new background task queue.
    Signature: NSObject< FlutterTaskQueue > * makeBackgroundTaskQueue()
    Parameters: None
    Return Type: NSObject< FlutterTaskQueue > * - A new task queue for background operations.
```

----------------------------------------

TITLE: Create FlutterBasicMessageChannel Instance
DESCRIPTION: A class method of 'FlutterBasicMessageChannel' to create a new message channel with a specified name, binary messenger, and message codec.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: APIDOC
CODE:
```
APIDOC:
  Type: Class Method
  Interface: FlutterBasicMessageChannel
  Name: messageChannelWithName:binaryMessenger:codec:
  Signature: instancetype messageChannelWithName:(NSString *name) binaryMessenger:(NSObject<FlutterBinaryMessenger> *messenger) codec:(NSObject<FlutterMessageCodec> *codec)
```

----------------------------------------

TITLE: C++ Return std::unique_ptr Error Object
DESCRIPTION: A C++ snippet demonstrating the return of a `std::unique_ptr` named `error` using `std::move`. This pattern is common in methods that return unique pointers, ensuring efficient resource transfer.
SOURCE: https://api.flutter.dev/windows-embedder/event__stream__handler__functions_8h_source

LANGUAGE: C++
CODE:
```
return std::move(error);
```

----------------------------------------

TITLE: FlutterJSONMethodCodec Class Definition
DESCRIPTION: A `FlutterMethodCodec` implementation using UTF-8 encoded JSON for method calls and result envelopes. It ensures compatibility with `JSONMethodCodec` on the Dart side and supports values compatible with `FlutterJSONMessageCodec` for seamless data serialization.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_codecs_8h_source

LANGUAGE: Objective-C
CODE:
```
FLUTTER_DARWIN_EXPORT
@interface FlutterJSONMethodCodec : NSObject <FlutterMethodCodec>
@end
```

LANGUAGE: APIDOC
CODE:
```
FlutterJSONMethodCodec:
  Inherits from: NSObject <FlutterMethodCodec>
  Description: A `FlutterMethodCodec` using UTF-8 encoded JSON method calls and result envelopes. Guaranteed compatible with Dart's `JSONMethodCodec`. Supports values compatible with `FlutterJSONMessageCodec`.
```

----------------------------------------

TITLE: TextInputPlugin Class API Reference
DESCRIPTION: Detailed API reference for the `TextInputPlugin` class, which provides the Android-specific implementation for handling text input within Flutter applications. It includes the class definition, constructor, and all public methods for managing input connections, autofill, and keyboard events.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/editing/TextInputPlugin

LANGUAGE: APIDOC
CODE:
```
Class: TextInputPlugin
  Extends: java.lang.Object
  Package: io.flutter.plugin.editing
  Description: Android implementation of the text input plugin.

  Constructor Summary:
    TextInputPlugin(
      View view,
      TextInputChannel textInputChannel,
      ScribeChannel scribeChannel,
      PlatformViewsController platformViewsController,
      PlatformViewsController2 platformViewsController2
    )

  Method Summary:
    void autofill(SparseArray<AutofillValue> values)

    void clearPlatformViewClient(int platformViewId)
      Description: Clears a platform view text input client if it is the current input target.

    InputConnection createInputConnection(
      View view,
      KeyboardManager keyboardManager,
      EditorInfo outAttrs
    )

    void destroy()
      Description: Detaches the text input plugin from the platform views controller.

    void didChangeEditingState(
      boolean textChanged,
      boolean selectionChanged,
      boolean composingRegionChanged
    )

    InputMethodManager getInputMethodManager()

    InputConnection getLastInputConnection()

    boolean handleKeyEvent(KeyEvent keyEvent)

    void lockPlatformViewInputConnection()
      Description: Use the current platform view input connection until unlockPlatformViewInputConnection is called.

    void onProvideAutofillVirtualStructure(
      ViewStructure structure,
      int flags
    )

    void sendTextInputAppPrivateCommand(
      String action,
      Bundle data
    )

    void unlockPlatformViewInputConnection()
      Description: Unlocks the input connection.

  Methods inherited from class java.lang.Object: (e.g., equals, hashCode, toString, etc.)
```

----------------------------------------

TITLE: C++ Implementation for Registering Flutter Desktop Textures
DESCRIPTION: This C++ code snippet shows the `RegisterTexture` method's implementation, which registers either a `PixelBufferTexture` or a `GpuSurfaceTexture` with the Flutter desktop engine. It configures the `FlutterDesktopTextureInfo` struct based on the texture type and uses callbacks to retrieve pixel or GPU surface data. An error is logged if an unknown texture variant is encountered.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_texture_registrar_impl

LANGUAGE: C++
CODE:
```
{
FlutterDesktopTextureInfo info = {};
if (auto pixel_buffer_texture = std::get_if<PixelBufferTexture>(texture)) {
info.type = kFlutterDesktopPixelBufferTexture;
info.pixel_buffer_config.user_data = pixel_buffer_texture;
info.pixel_buffer_config.callback =
[](size_t width, size_t height,
void* user_data) -> const FlutterDesktopPixelBuffer* {
auto texture = static_cast<PixelBufferTexture*>(user_data);
return texture->CopyPixelBuffer(width, height);
};
} else if (auto gpu_surface_texture =
std::get_if<GpuSurfaceTexture>(texture)) {
info.type = kFlutterDesktopGpuSurfaceTexture;
info.gpu_surface_config.struct_size =
sizeof(FlutterDesktopGpuSurfaceTextureConfig);
info.gpu_surface_config.type = gpu_surface_texture->surface_type();
info.gpu_surface_config.user_data = gpu_surface_texture;
info.gpu_surface_config.callback =
[](size_t width, size_t height,
void* user_data) -> const FlutterDesktopGpuSurfaceDescriptor* {
auto texture = static_cast<GpuSurfaceTexture*>(user_data);
return texture->ObtainDescriptor(width, height);
};
} else {
std::cerr << "Attempting to register unknown texture variant." << std::endl;
return -1;
}

int64_t texture_id = FlutterDesktopTextureRegistrarRegisterExternalTexture(
texture_registrar_ref_, &info);
return texture_id;
}
```

----------------------------------------

TITLE: Objective-C++ AccessibilityBridge Object Did Become Focused
DESCRIPTION: Handles the event when an accessibility object gains focus. It updates the `last_focused_semantics_object_id_` and sends a 'didGainFocus' message to the Flutter accessibility channel, notifying the Flutter engine of the focus change.
SOURCE: https://api.flutter.dev/ios-embedder/accessibility__bridge_8mm_source

LANGUAGE: Objective-C++
CODE:
```
void AccessibilityBridge::AccessibilityObjectDidBecomeFocused(int32_t id) {
 last_focused_semantics_object_id_ = id;
 [accessibility_channel_ sendMessage:@{@"type" : @"didGainFocus", @"nodeId" : @(id)}];
}
```

----------------------------------------

TITLE: Create Flutter Windows View Controller
DESCRIPTION: This static function creates a `FlutterDesktopViewControllerRef` instance, which manages a Flutter engine and its view. It initializes a window binding, optionally takes ownership of the provided engine, creates a view, launches the engine if not running, sends initial bounds, and updates accessibility features. The `owns_engine` parameter determines if the controller deallocates the engine upon its destruction.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8cc_source

LANGUAGE: C++
CODE:
```
static FlutterDesktopViewControllerRef CreateViewController(
  FlutterDesktopEngineRef engine_ref,
  int width,
  int height,
  bool owns_engine) {
  flutter::FlutterWindowsEngine* engine_ptr = EngineFromHandle(engine_ref);
  std::unique_ptr<flutter::WindowBindingHandler> window_wrapper =
  std::make_unique<flutter::FlutterWindow>(
  width, height, engine_ptr->windows_proc_table());

  std::unique_ptr<flutter::FlutterWindowsEngine> engine;
  if (owns_engine) {
  engine = std::unique_ptr<flutter::FlutterWindowsEngine>(engine_ptr);
  }

  std::unique_ptr<flutter::FlutterWindowsView> view =
  engine_ptr->CreateView(std::move(window_wrapper));
  if (!view) {
  return nullptr;
  }

  auto controller = std::make_unique<flutter::FlutterWindowsViewController>(
  std::move(engine), std::move(view));

  // Launch the engine if it is not running already.
  if (!controller->engine()->running()) {
  if (!controller->engine()->Run()) {
  return nullptr;
  }
  }

  // Must happen after engine is running.
  controller->view()->SendInitialBounds();

  // The Windows embedder listens to accessibility updates using the
  // view's HWND. The embedder's accessibility features may be stale if
  // the app was in headless mode.
  controller->engine()->UpdateAccessibilityFeatures();

  return HandleForViewController(controller.release());
}
```

----------------------------------------

TITLE: Flutter BinaryMessenger C++ SetMessageHandler API
DESCRIPTION: Documents the `SetMessageHandler` method of `flutter::BinaryMessenger`, an abstract method for setting a handler for binary messages on a specific channel. It takes the channel name and a `BinaryMessageHandler` as parameters.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_method_channel

LANGUAGE: APIDOC
CODE:
```
virtual void SetMessageHandler(const std::string &channel, BinaryMessageHandler handler)=0
```

----------------------------------------

TITLE: Flutter Binary Messenger API Reference
DESCRIPTION: Comprehensive API documentation for the Flutter binary messaging system, including typedefs for message handling and the core FlutterBinaryMessenger protocol.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_binary_messenger_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryReply:
  Type: typedef void (^FlutterBinaryReply)(NSData* _Nullable reply);
  Description: A message reply callback. Used for submitting a binary reply back to a Flutter message sender or for handling a binary message reply received from Flutter.
  Parameters:
    reply: The reply data (NSData* _Nullable).
```

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryMessageHandler:
  Type: typedef void (^FlutterBinaryMessageHandler)(NSData* _Nullable message, FlutterBinaryReply reply);
  Description: A strategy for handling incoming binary messages from Flutter and to send asynchronous replies back to Flutter.
  Parameters:
    message: The message data (NSData* _Nullable).
    reply: A callback for submitting an asynchronous reply to the sender (FlutterBinaryReply).
```

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryMessengerConnection:
  Type: typedef int64_t FlutterBinaryMessengerConnection;
  Description: An identifier that represents a connection to a Flutter binary channel.
```

LANGUAGE: APIDOC
CODE:
```
FlutterTaskQueue Protocol:
  Definition: @protocol FlutterTaskQueue <NSObject>
  Description: A protocol for managing tasks, potentially for background platform channels. Currently an empty protocol.
```

LANGUAGE: APIDOC
CODE:
```
FlutterBinaryMessenger Protocol:
  Definition: @protocol FlutterBinaryMessenger <NSObject>
  Description: A facility for communicating with the Flutter side using asynchronous message passing with binary messages. Implemented by FlutterBasicMessageChannel, FlutterMethodChannel, and FlutterEventChannel.
  Methods:
    makeBackgroundTaskQueue:
      Description: Creates a background task queue. This method is optional and currently relevant for macOS background platform channels.
      Signature: - (NSObject<FlutterTaskQueue>*)makeBackgroundTaskQueue;
      Return Type: NSObject<FlutterTaskQueue>*
    setMessageHandlerOnChannel:binaryMessageHandler:taskQueue:
      Description: Registers a message handler for incoming binary messages from the Flutter side on the specified channel. Replaces any existing handler. Use a nil handler for unregistering the existing handler.
      Signature: - (FlutterBinaryMessengerConnection)setMessageHandlerOnChannel:(NSString*)channel binaryMessageHandler:(FlutterBinaryMessageHandler _Nullable)handler taskQueue:(NSObject<FlutterTaskQueue>* _Nullable)taskQueue;
      Parameters:
        channel: The channel name (NSString*).
        handler: The message handler (FlutterBinaryMessageHandler _Nullable).
        taskQueue: An optional task queue for the handler (NSObject<FlutterTaskQueue>* _Nullable).
      Return Type: FlutterBinaryMessengerConnection
    sendOnChannel:message:
      Description: Sends a binary message to the Flutter side on the specified channel, expecting no reply.
      Signature: - (void)sendOnChannel:(NSString*)channel message:(NSData* _Nullable)message;
      Parameters:
        channel: The channel name (NSString*).
        message: The message data (NSData* _Nullable).
      Return Type: void
    sendOnChannel:message:binaryReply:
      Description: Sends a binary message to the Flutter side on the specified channel, expecting an asynchronous reply.
      Signature: - (void)sendOnChannel:(NSString*)channel message:(NSData* _Nullable)message binaryReply:(FlutterBinaryReply _Nullable)callback;
      Parameters:
        channel: The channel name (NSString*).
        message: The message data (NSData* _Nullable).
        callback: A callback for receiving a reply (FlutterBinaryReply _Nullable).
      Return Type: void
```

----------------------------------------

TITLE: APIDOC: Flutter StandardMessageCodec Class Overview
DESCRIPTION: Provides an overview of the `StandardMessageCodec` class and related types, including their definition locations and key methods. This codec is used for binary message encoding/decoding between the Flutter engine and the client.
SOURCE: https://api.flutter.dev/ios-embedder/standard__message__codec_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::EncodableValue
  Definition: encodable_value.h:165

flutter::MessageCodec
  Definition: message_codec.h:17

flutter::StandardCodecSerializer
  Definition: standard_codec_serializer.h:18

flutter::StandardMessageCodec
  Definition: standard_message_codec.h:18
  Methods:
    ~StandardMessageCodec()
    GetInstance(serializer: const StandardCodecSerializer* = nullptr): static const StandardMessageCodec&
```

----------------------------------------

TITLE: FlWindowingChannel API Reference
DESCRIPTION: API documentation for the FlWindowingChannel, including its structure and associated functions for managing Flutter application windows on Linux. This section details the classes and functions available for windowing operations.
SOURCE: https://api.flutter.dev/linux-embedder/fl__windowing__channel_8cc

LANGUAGE: APIDOC
CODE:
```
Classes:
  struct _FlWindowingChannel

Functions:
  static gboolean is_valid_size_argument (FlValue *value)
  static FlWindowingSize * parse_size_value (FlValue *value)
  static gboolean parse_window_state_value (FlValue *value, FlWindowState *state)
  static const gchar * window_state_to_string (FlWindowState state)
  static FlMethodResponse * create_regular (FlWindowingChannel *self, FlValue *args)
  static FlMethodResponse * modify_regular (FlWindowingChannel *self, FlValue *args)
  static FlMethodResponse * destroy_window (FlWindowingChannel *self, FlValue *args)
  static void method_call_cb (FlMethodChannel *channel, FlMethodCall *method_call, gpointer user_data)
  static void fl_windowing_channel_dispose (GObject *object)
  static void fl_windowing_channel_class_init (FlWindowingChannelClass *klass)
  static void fl_windowing_channel_init (FlWindowingChannel *self)
  FlWindowingChannel * fl_windowing_channel_new (FlBinaryMessenger *messenger, FlWindowingChannelVTable *vtable, gpointer user_data)
  FlMethodResponse * fl_windowing_channel_make_create_regular_response (int64_t view_id, FlWindowingSize *size, FlWindowState state)
  FlMethodResponse * fl_windowing_channel_make_modify_regular_response ()
  FlMethodResponse * fl_windowing_channel_make_destroy_window_response ()
```

----------------------------------------

TITLE: C++ StandardMethodCodec Custom Type Handling
DESCRIPTION: This C++ test case illustrates how StandardMethodCodec handles custom type arguments, specifically a Point object. It demonstrates encoding a MethodCall with a CustomEncodableValue containing a Point, then decoding it and verifying that the original Point data is correctly retrieved.
SOURCE: https://api.flutter.dev/macos-embedder/standard__method__codec__unittests_8cc_source

LANGUAGE: C++
CODE:
```
TEST(StandardMethodCodec, HandlesCustomTypeArguments) {
  const StandardMethodCodec& codec = StandardMethodCodec::GetInstance(
  &PointExtensionSerializer::GetInstance());
  Point point(7, 9);
  MethodCall<> call(
  "hello", std::make_unique<EncodableValue>(CustomEncodableValue(point)));
  auto encoded = codec.EncodeMethodCall(call);
  ASSERT_NE(encoded.get(), nullptr);
  std::unique_ptr<MethodCall<>> decoded = codec.DecodeMethodCall(*encoded);
  ASSERT_NE(decoded.get(), nullptr);

  const Point& decoded_point = std::any_cast<Point>(
  std::get<CustomEncodableValue>(*decoded->arguments()));
  EXPECT_EQ(point, decoded_point);
};
```

----------------------------------------

TITLE: Create FlEngine Instance (fl_engine_new)
DESCRIPTION: This function creates a new Flutter engine instance. It acts as a wrapper around `fl_engine_new_full`, passing a null binary messenger. It requires an `FlDartProject` object as input and returns a new `FlEngine` instance.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc

LANGUAGE: APIDOC
CODE:
```
G_MODULE_EXPORT FlEngine* fl_engine_new(FlDartProject* project)
  project: An FlDartProject object.
Returns: A new FlEngine instance.
```

LANGUAGE: C
CODE:
```
{
  return fl_engine_new_full(project, nullptr);
}
```

----------------------------------------

TITLE: FlutterMessageCodec Protocol API Reference
DESCRIPTION: Detailed API documentation for the FlutterMessageCodec protocol, which defines the interface for message encoding and decoding between Flutter and native code. It includes methods for converting messages to and from binary data.
SOURCE: https://api.flutter.dev/macos-embedder/protocol_flutter_message_codec-p

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterMessageCodec
Description: A message encoding/decoding mechanism.

Instance Methods:
  - (NSData *_Nullable) encode:(id _Nullable)message
    Description: Encodes the specified message into binary.
    Parameters:
      message: (id _Nullable) The message.
    Returns: The binary encoding, or `nil`, if `message` was `nil`.

  - (id _Nullable) decode:(NSData *_Nullable)message
    Description: Decodes the specified message from binary.
    Parameters:
      message: (NSData *_Nullable) The message.
    Returns: The decoded message, or `nil`, if `message` was `nil`.

Class Methods:
  + (instancetype) sharedInstance
    Description: Returns a shared instance of this FlutterMessageCodec.
    Parameters: None
    Returns: instancetype
```

----------------------------------------

TITLE: Set Mock Method Call Handler in Flutter Test
DESCRIPTION: Sets a mock callback for receiving method calls on a MethodChannel, provided by the TestMethodChannelExtension. This is a shim for TestDefaultBinaryMessenger.setMockMethodCallHandler.
SOURCE: https://api.flutter.dev/flutter/services/MethodChannel-class

LANGUAGE: APIDOC
CODE:
```
setMockMethodCallHandler(Future? handler(MethodCall call)?) → void
```

----------------------------------------

TITLE: Flutter MethodResult Class API
DESCRIPTION: Represents the result of a method call on a Flutter method channel. It provides mechanisms to report success, error, or not implemented status back to the caller.
SOURCE: https://api.flutter.dev/macos-embedder/method__channel_8h_source

LANGUAGE: APIDOC
CODE:
```
class flutter::MethodResult< T >
```

----------------------------------------

TITLE: Configure Flutter Normal Theme in AndroidManifest.xml
DESCRIPTION: This XML snippet defines the 'NormalTheme' for 'FlutterActivity' in the AndroidManifest.xml, ensuring Flutter uses the specified theme after initialization. This helps avoid jarring visual changes during app startup.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: XML
CODE:
```
<meta-data android:name="io.flutter.embedding.android.NormalTheme"
android:resource="@style/YourNormalTheme" />
```

----------------------------------------

TITLE: Handle Flutter TextInputChannel Method Calls in C++
DESCRIPTION: This snippet demonstrates how a FlTextInputChannel processes incoming method calls from Flutter. It uses a series of 'else if' statements to match method names like 'kHideMethod', 'kSetEditableSizeAndTransform', and 'kSetMarkedTextRect' to corresponding C++ functions. If a method is not recognized, it returns a 'not implemented' response. It also includes error handling for sending the response back to Flutter.
SOURCE: https://api.flutter.dev/linux-embedder/fl__text__input__channel_8cc_source

LANGUAGE: C++
CODE:
```
response = clear_client(self);

} else if (strcmp(method, kHideMethod) == 0) {

response = hide(self);

} else if (strcmp(method, kSetEditableSizeAndTransform) == 0) {

response = set_editable_size_and_transform(self, args);

} else if (strcmp(method, kSetMarkedTextRect) == 0) {

response = set_marked_text_rect(self, args);

} else {

response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());

}

g_autoptr(GError) error = nullptr;

if (!fl_method_call_respond(method_call, response, &error)) {

g_warning("Failed to send method call response: %s", error->message);

}
```

----------------------------------------

TITLE: C++ Test: Initialize and Manage Secondary Flutter View
DESCRIPTION: This C++ test function TEST(FlViewTest, SecondaryView) demonstrates the initialization of a Flutter project, creation of an implicit FlView, retrieval of its FlEngine, and the addition of a secondary view. It mocks the AddView embedder API call to capture the view_id and verifies that the secondary view's ID matches the captured ID after engine start. It uses g_autoptr for automatic memory management and EXPECT_TRUE/EXPECT_EQ for assertions.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view__test_8cc

LANGUAGE: C++
CODE:
```
{
  flutter::testing::fl_ensure_gtk_init();

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  FlView* implicit_view = fl_view_new(project);

  FlEngine* engine = fl_view_get_engine(implicit_view);

  FlutterViewId view_id = -1;
  fl_engine_get_embedder_api(engine)->AddView = MOCK_ENGINE_PROC(
  AddView, ([&view_id](auto engine, const FlutterAddViewInfo* info) {
  view_id = info->view_id;
  FlutterAddViewResult result = {
  .struct_size = sizeof(FlutterAddViewResult),
  .added = true,
  .user_data = info->user_data};
  info->add_view_callback(&result);
  return kSuccess;
  }));

  g_autoptr(GError) error = nullptr;
  EXPECT_TRUE(fl_engine_start(engine, &error));

  FlView* secondary_view = fl_view_new_for_engine(engine);
  EXPECT_EQ(view_id, fl_view_get_id(secondary_view));
}
```

----------------------------------------

TITLE: Flutter Internal EncodableValueVariant Definition
DESCRIPTION: Defines `EncodableValueVariant` as a `std::variant` that can hold various primitive types (monostate, bool, int32_t, int64_t, double, string, vectors of primitives) as well as complex types like `EncodableList`, `EncodableMap`, and `CustomEncodableValue`. This variant is the core mechanism for `EncodableValue`'s flexibility.
SOURCE: https://api.flutter.dev/linux-embedder/encodable__value_8h_source

LANGUAGE: APIDOC
CODE:
```
std::variant< std::monostate, bool, int32_t, int64_t, double, std::string, std::vector< uint8_t >, std::vector< int32_t >, std::vector< int64_t >, std::vector< double >, EncodableList, EncodableMap, CustomEncodableValue, std::vector< float > > EncodableValueVariant
```

----------------------------------------

TITLE: Flutter EncodableValue and Related API Definitions
DESCRIPTION: This section provides API documentation for key classes and types within the Flutter framework, including EncodableValue, CustomEncodableValue, TestCustomValue, EncodableList, and EncodableMap. It details their definitions, methods, and properties, along with their source file locations.
SOURCE: https://api.flutter.dev/windows-embedder/encodable__value__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::CustomEncodableValue
  Definition: encodable_value.h:60

flutter::EncodableValue
  Definition: encodable_value.h:165

flutter::EncodableValue::IsNull
  Method: bool IsNull() const
  Definition: encodable_value.h:203

flutter::EncodableValue::LongValue
  Method: int64_t LongValue() const
  Definition: encodable_value.h:212

flutter::TestCustomValue
  Definition: encodable_value_unittests.cc:287
  Methods:
    int y() const
      Definition: encodable_value_unittests.cc:294
    TestCustomValue()
      Definition: encodable_value_unittests.cc:289
    int x() const
      Definition: encodable_value_unittests.cc:293
    TestCustomValue(int x, int y)
      Definition: encodable_value_unittests.cc:290
    ~TestCustomValue()=default

flutter::EncodableList
  Type: std::vector< EncodableValue >
  Definition: encodable_value.h:94

flutter::EncodableMap
  Type: std::map< EncodableValue, EncodableValue >
  Definition: encodable_value.h:95
```

----------------------------------------

TITLE: Objective-C: Encode and Decode NSArray with FlutterStandardCodec
DESCRIPTION: This test validates the `FlutterStandardCodec`'s capability to encode and decode an `NSArray` containing a mix of data types, including `NSNull`, strings, doubles, integers, and a nested dictionary. It uses a helper function `CheckEncodeDecode` to perform the round-trip encoding and decoding.
SOURCE: https://api.flutter.dev/ios-embedder/flutter__standard__codec__unittest_8mm

LANGUAGE: Objective-C
CODE:
```
{
NSArray* value = @[ [NSNull null], @"hello", @3.14, @47, @{@42 : @"nested"} ];
CheckEncodeDecode(value);
}
```

----------------------------------------

TITLE: flutter::StandardMethodCodec
DESCRIPTION: The standard binary codec used for encoding and decoding method calls and responses in Flutter's method channels, supporting a predefined set of types and extensible for custom types.
SOURCE: https://api.flutter.dev/windows-embedder/standard__method__codec__unittests_8cc_source

LANGUAGE: APIDOC
CODE:
```
flutter::StandardMethodCodec
```

----------------------------------------

TITLE: Flutter API: stopRenderingToSurface Method
DESCRIPTION: Notifies Flutter that a surface previously registered with startRenderingToSurface(Surface, boolean) has been destroyed and needs to be released and cleaned up on the Flutter side.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/renderer/FlutterRenderer

LANGUAGE: APIDOC
CODE:
```
void stopRenderingToSurface()
```

----------------------------------------

TITLE: API Definition: fl_method_call_respond Function
DESCRIPTION: Function signature for `fl_method_call_respond`, which allows a `FlMethodCall` to respond with a `FlMethodResponse`, handling potential errors.
SOURCE: https://api.flutter.dev/linux-embedder/fl__windowing__channel_8cc_source

LANGUAGE: APIDOC
CODE:
```
G_MODULE_EXPORT gboolean fl_method_call_respond(FlMethodCall *self, FlMethodResponse *response, GError **error)
```

----------------------------------------

TITLE: FlutterViewController Instance Methods
DESCRIPTION: Details the instance methods available on the FlutterViewController category, including various gesture recognizers, internal plugin management, and lifecycle callbacks.
SOURCE: https://api.flutter.dev/ios-embedder/category_flutter_view_controller_07_08

LANGUAGE: APIDOC
CODE:
```
FlutterViewController Category Reference:
  #import <FlutterViewController_Internal.h>

  Instance Methods:
    - (UIHoverGestureRecognizer *) hoverGestureRecognizer (API_AVAILABLE)
    - (UIPanGestureRecognizer *) discreteScrollingPanGestureRecognizer (API_AVAILABLE)
    - (UIPanGestureRecognizer *) continuousScrollingPanGestureRecognizer (API_AVAILABLE)
    - (UIPinchGestureRecognizer *) pinchGestureRecognizer (API_AVAILABLE)
    - (UIRotationGestureRecognizer *) rotationGestureRecognizer (API_AVAILABLE)
    - (void) addInternalPlugins
      Description: Creates and registers plugins used by this view controller.
    - (void) deregisterNotifications
    - (void) onFirstFrameRendered
      Description: Called when the first frame has been rendered. Invokes any registered first-frame callback.
    - (void) handleKeyboardAnimationCallbackWithTargetTime:
      Description: Handles updating viewport metrics on keyboard animation.
    - (FlutterRestorationPlugin *) restorationPlugin
    - (void) handlePressEvent:nextAction:
    - (void) sendDeepLinkToFramework:completionHandler:
    - (int32_t) accessibilityFlags
    - (BOOL) supportsShowingSystemContextMenu
    - (BOOL) stateIsActive
    - (BOOL) stateIsBackground
```

----------------------------------------

TITLE: Retrieve Windows Modifier Key States for Flutter
DESCRIPTION: Implements the `GetModsForKeyState` utility function, which queries the current state of all standard modifier keys (Shift, Control, Alt, Win, Caps Lock, Num Lock, Scroll Lock) using `GetKeyState()` and packs them into a single integer bitmask. The bitmask uses Flutter-compatible modifier definitions for seamless integration with the framework's `RawKeyEventDataWindows`.
SOURCE: https://api.flutter.dev/windows-embedder/keyboard__key__channel__handler_8cc_source

LANGUAGE: C++
CODE:
```
int GetModsForKeyState() {
  int mods = 0;

  if (GetKeyState(VK_SHIFT) < 0)
    mods |= kShift;
  if (GetKeyState(VK_LSHIFT) < 0)
    mods |= kShiftLeft;
  if (GetKeyState(VK_RSHIFT) < 0)
    mods |= kShiftRight;
  if (GetKeyState(VK_CONTROL) < 0)
    mods |= kControl;
  if (GetKeyState(VK_LCONTROL) < 0)
    mods |= kControlLeft;
  if (GetKeyState(VK_RCONTROL) < 0)
    mods |= kControlRight;
  if (GetKeyState(VK_MENU) < 0)
    mods |= kAlt;
  if (GetKeyState(VK_LMENU) < 0)
    mods |= kAltLeft;
  if (GetKeyState(VK_RMENU) < 0)
    mods |= kAltRight;
  if (GetKeyState(VK_LWIN) < 0)
    mods |= kWinLeft;
  if (GetKeyState(VK_RWIN) < 0)
    mods |= kWinRight;
  if (GetKeyState(VK_CAPITAL) < 0)
    mods |= kCapsLock;
  if (GetKeyState(VK_NUMLOCK) < 0)
    mods |= kNumLock;
  if (GetKeyState(VK_SCROLL) < 0)
    mods |= kScrollLock;
  return mods;
}
```

----------------------------------------

TITLE: shouldAttachEngineToActivity Method
DESCRIPTION: Provides a hook for subclasses to determine if the FlutterFragment should automatically attach its FlutterEngine to the host Activity. This allows for custom control over engine attachment.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
shouldAttachEngineToActivity()
Returns: boolean
```

----------------------------------------

TITLE: Initialize FlutterEventChannel with Name, Binary Messenger, and Codec (Objective-C)
DESCRIPTION: Documents the instance method for initializing a FlutterEventChannel object. This method takes the channel name, binary messenger, and an optional method codec for custom message handling.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_event_channel

LANGUAGE: APIDOC
CODE:
```
- (instancetype) initWithName:(NSString *)name
binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger
codec:(NSObject<FlutterMethodCodec> *)codec

Description: Initializes a FlutterEventChannel with the specified name, binary messenger, and method codec. The channel name logically identifies the channel; identically named channels interfere with each other's communication. The binary messenger is a facility for sending raw, binary messages to the Flutter side. This protocol is implemented by FlutterEngine and FlutterViewController.

Parameters:
  name: The channel name.
  messenger: The binary messenger.
  codec: The method codec.
```

----------------------------------------

TITLE: Handle Error Envelopes with FlutterStandardMethodCodec (Objective-C++)
DESCRIPTION: This test ensures FlutterStandardMethodCodec correctly encodes and decodes FlutterError objects within method call envelopes. It creates a FlutterError with a code, message, and details, encodes it, then decodes it, asserting that the decoded object is identical to the original error.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__standard__codec__unittest_8mm

LANGUAGE: Objective-C++
CODE:
```
{
FlutterStandardMethodCodec* codec = [[FlutterStandardMethodCodec sharedInstance];
NSDictionary* details = @{@"a" : @42, @42 : @"a"};
FlutterError* error = [[FlutterError errorWithCode:@"errorCode"
message:@"something failed"
details:details];
NSData* encoded = [codec encodeErrorEnvelope:error];
id decoded = [codec decodeEnvelope:encoded];
ASSERT_TRUE([decoded isEqual:error]);
}
```

----------------------------------------

TITLE: Flutter Android Host API Reference
DESCRIPTION: Detailed API reference for methods and properties used by FlutterActivityAndFragmentDelegate.Host to manage Flutter engine lifecycle, UI rendering, and interaction with Android system events.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
protected OnBackInvokedCallback getOnBackInvokedCallback()
RenderMode getRenderMode() - FlutterActivityAndFragmentDelegate.Host method that is used by FlutterActivityAndFragmentDelegate to obtain the desired RenderMode that should be used when instantiating a FlutterView.
TransparencyMode getTransparencyMode() - FlutterActivityAndFragmentDelegate.Host method that is used by FlutterActivityAndFragmentDelegate to obtain the desired TransparencyMode that should be used when instantiating a FlutterView.
protected void onActivityResult(int requestCode, int resultCode, Intent data)
void onBackPressed()
protected void onCreate(Bundle savedInstanceState)
protected void onDestroy()
void onFlutterSurfaceViewCreated(FlutterSurfaceView flutterSurfaceView)
void onFlutterTextureViewCreated(FlutterTextureView flutterTextureView)
void onFlutterUiDisplayed()
void onFlutterUiNoLongerDisplayed()
protected void onNewIntent(Intent intent)
protected void onPause()
void onPostResume()
void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults)
protected void onResume()
protected void onSaveInstanceState(Bundle outState)
protected void onStart()
protected void onStop()
void onTrimMemory(int level)
void onUserLeaveHint()
void onWindowFocusChanged(boolean hasFocus)
boolean popSystemNavigator() - Allow implementer to customize the behavior needed when the Flutter framework calls to pop the Android-side navigation stack.
FlutterEngine provideFlutterEngine(Context context) - Hook for subclasses to easily provide a custom FlutterEngine.
PlatformPlugin providePlatformPlugin(Activity activity, FlutterEngine flutterEngine)
void registerOnBackInvokedCallback() - Registers the callback with OnBackInvokedDispatcher to capture back navigation gestures and pass them to the framework.
void release() - Irreversibly release this activity's control of the FlutterEngine and its subcomponents.
```

----------------------------------------

TITLE: FlutterMethodCodec Protocol Methods for Encoding/Decoding
DESCRIPTION: Defines methods for encoding successful results, error envelopes, and decoding binary envelopes into result values or `FlutterError` instances. This protocol is fundamental for communication between Flutter and native platforms, enabling structured data exchange.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_codecs_8h_source

LANGUAGE: Objective-C
CODE:
```
- (NSData*)encodeSuccessEnvelope:(id _Nullable)result;
- (NSData*)encodeErrorEnvelope:(FlutterError*)error;
- (id _Nullable)decodeEnvelope:(NSData*)envelope;
```

LANGUAGE: APIDOC
CODE:
```
FlutterMethodCodec Protocol:
  - encodeSuccessEnvelope(result: id _Nullable) -> NSData*
    @param result: The result. Must be a value supported by this codec.
    @return: The binary encoding.

  - encodeErrorEnvelope(error: FlutterError*) -> NSData*
    @param error: The error object. The error details value must be supported by this codec.
    @return: The binary encoding.

  - decodeEnvelope(envelope: NSData*) -> id _Nullable
    @param envelope: The error object.
    @return: The result value, if the envelope represented a successful result, or a `FlutterError` instance, if not.
```

----------------------------------------

TITLE: FlutterPlugin handleMethodCall:result: Method
DESCRIPTION: Defines the method signature for handling incoming method calls from the Flutter engine within a plugin. This method is crucial for dispatching Flutter-side calls to native platform code.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8mm_source

LANGUAGE: Objective-C
CODE:
```
void handleMethodCall:result:(FlutterMethodCall *call, FlutterResult result)
```

----------------------------------------

TITLE: Handle Surface Creation for Flutter Painting
DESCRIPTION: Call this method when an Android Surface has been created onto which Flutter should paint. This is commonly invoked from SurfaceHolder.Callback's surfaceCreated method.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterJNI

LANGUAGE: Java
CODE:
```
@UiThread
public void onSurfaceCreated(@NonNull
Surface surface)
```

----------------------------------------

TITLE: FlutterEngine: viewController Property
DESCRIPTION: Documents the 'viewController' property of the FlutterEngine, which allows setting or replacing the associated FlutterViewController. This property controls the engine's rendering state (animations and drawing) but does not affect the Dart program's execution state. It emphasizes that an engine can only have one view controller at a time and requires the engine to be running.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine

LANGUAGE: APIDOC
CODE:
```
FlutterEngine:
  Property: viewController
    Type: FlutterViewController*
    Access: readwrite, nonatomic, weak
    Description: Sets the FlutterViewController for this instance. The FlutterEngine must be running (e.g. a successful call to -runWithEntrypoint: or -runWithEntrypoint:libraryURI) before calling this method. Callers may pass nil to remove the viewController and have the engine run headless in the current process. A FlutterEngine can only have one FlutterViewController at a time. If there is already a FlutterViewController associated with this instance, this method will replace the engine's current viewController with the newly specified one. Setting the viewController will signal the engine to start animations and drawing, and unsetting it will signal the engine to stop animations and drawing. However, neither will impact the state of the Dart program's execution.
```

----------------------------------------

TITLE: Send Binary Message via Flutter Desktop Messenger
DESCRIPTION: Sends a binary message over a specified channel using the Flutter desktop messenger. This function allows sending raw byte data to the Flutter engine.
SOURCE: https://api.flutter.dev/linux-embedder/flutter__messenger_8h

LANGUAGE: C
CODE:
```
FLUTTER_EXPORT bool FlutterDesktopMessengerSend (FlutterDesktopMessengerRef messenger, const char *channel, const uint8_t *message, const size_t message_size)
```

----------------------------------------

TITLE: Verify Flutter Standard Message Codec Encoding and Decoding with Expected Data
DESCRIPTION: This static helper function `CheckEncodeDecode` tests the `FlutterStandardMessageCodec`'s ability to encode and decode a given value. It asserts that the encoded data matches an `expectedEncoding` and the decoded value matches the original, handling `nil` and `NSNull` cases.
SOURCE: https://api.flutter.dev/macos-embedder/flutter__standard__codec__unittest_8mm_source

LANGUAGE: Objective-C
CODE:
```
static void CheckEncodeDecode(id value, NSData* expectedEncoding) {
 FlutterStandardMessageCodec* codec = [[FlutterStandardMessageCodec sharedInstance] ];
 NSData* encoded = [codec encode:value];
 if (expectedEncoding == nil) {
 ASSERT_TRUE(encoded == nil);
 } else {
 ASSERT_TRUE([encoded isEqual:expectedEncoding]);
 }
 id decoded = [codec decode:encoded];
 if (value == nil || value == [NSNull null]) {
 ASSERT_TRUE(decoded == nil);
 } else {
 ASSERT_TRUE([value isEqual:decoded]);
 }
}
```

----------------------------------------

TITLE: C API: Create Custom FlValue
DESCRIPTION: Creates a new `FlValue` with a custom type and value. It allows specifying a `GDestroyNotify` callback for custom memory management.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__channel__test_8cc_source

LANGUAGE: C
CODE:
```
G_MODULE_EXPORT FlValue * fl_value_new_custom(int type, gconstpointer value, GDestroyNotify destroy_notify)
```

----------------------------------------

TITLE: Implement NSTextInputClient Methods for Text Input (Objective-C)
DESCRIPTION: Implements NSTextInputClient protocol methods. insertTab: is overridden to prevent AppKit from sending tab as insertText with '\t'. insertText:replacementRange: handles text insertion, marking that output was produced and checking for active models and valid ranges.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_plugin_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)insertTab:(id)sender {
  // Implementing insertTab: makes AppKit send tab as command, instead of
  // insertText with '\t'.
}

- (void)insertText:(id)string replacementRange:(NSRange)range {
  if (_activeModel == nullptr) {
    return;
  }

  _eventProducedOutput |= true;

  if (range.location != NSNotFound) {
    // The selected range can actually have negative numbers, since it can start
    // at the end of the range if the user selected the text going backwards.
    // Cast to a signed type to determine whether or not the selection is reversed.

```

----------------------------------------

TITLE: Create New Full Flutter Engine Instance
DESCRIPTION: Creates a new, fully initialized `FlEngine` instance. It requires a `FlDartProject` and a `FlBinaryMessenger` for its operation.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc_source

LANGUAGE: C
CODE:
```
static FlEngine * fl_engine_new_full(FlDartProject *project, FlBinaryMessenger *binary_messenger)
```

----------------------------------------

TITLE: TextInputChannel.Configuration.Autofill.fromJson Method
DESCRIPTION: This static method is responsible for parsing a JSON object into an instance of 'TextInputChannel.Configuration.Autofill'. It requires a non-null JSONObject as input and may throw 'JSONException' if the JSON is malformed or 'NoSuchFieldException' if expected fields are missing.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/TextInputChannel.Configuration.Autofill

LANGUAGE: APIDOC
CODE:
```
Method Details:
  fromJson:
    Signature: @NonNull public static TextInputChannel.Configuration.Autofill fromJson(@NonNull JSONObject json)
    Parameters:
      json: @NonNull JSONObject - The JSON object to parse.
    Returns: TextInputChannel.Configuration.Autofill
    Throws:
      - JSONException
      - NoSuchFieldException
```

----------------------------------------

TITLE: Invoke Method Without Response in C++
DESCRIPTION: This test case illustrates how to invoke a method on a Flutter MethodChannel when no response is expected. It verifies that the message was successfully sent and that no reply handler was registered for this invocation.
SOURCE: https://api.flutter.dev/ios-embedder/method__channel__unittests_8cc_source

LANGUAGE: C++
CODE:
```
TEST(MethodChannelTest, InvokeWithoutResponse) {
  TestBinaryMessenger messenger;
  const std::string channel_name("some_channel");
  MethodChannel channel(&messenger, channel_name,
  &StandardMethodCodec::GetInstance());

  channel.InvokeMethod("foo", nullptr);
  EXPECT_TRUE(messenger.send_called());
  EXPECT_EQ(messenger.last_reply_handler(), nullptr);
}
```

----------------------------------------

TITLE: APIDOC: flutter::TextureRegistrar::RegisterTexture() Method
DESCRIPTION: Registers a new texture with the registrar, assigning and returning a unique 64-bit integer ID. This is a pure virtual method that must be implemented by concrete subclasses.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_texture_registrar

LANGUAGE: APIDOC
CODE:
```
Method: RegisterTexture()
  Description: Registers a new texture with the registrar, returning a unique texture ID.
  Signature: virtual int64_t flutter::TextureRegistrar::RegisterTexture(TextureVariant *texture) = 0
  Parameters:
    texture: TextureVariant* - Pointer to the TextureVariant to register.
  Returns:
    int64_t: The unique ID assigned to the registered texture.
```

----------------------------------------

TITLE: FlutterStreamHandler-p Protocol API
DESCRIPTION: API documentation for the FlutterStreamHandler-p protocol, which defines the interface for handling stream events from Flutter event channels.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_channels_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterStreamHandler-p
```

----------------------------------------

TITLE: io.flutter.view Package Classes and Interfaces Reference
DESCRIPTION: This section provides an overview of the core classes and interfaces within the `io.flutter.view` package, detailing their purpose and functionality for integrating Flutter views with Android's system services, accessibility, and rendering pipeline.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/view/package-summary

LANGUAGE: APIDOC
CODE:
```
AccessibilityBridge
  Bridge between Android's OS accessibility system and Flutter's accessibility system.
```

LANGUAGE: APIDOC
CODE:
```
AccessibilityBridge.Action
```

LANGUAGE: APIDOC
CODE:
```
AccessibilityBridge.OnAccessibilityChangeListener
  Listener that can be set on a AccessibilityBridge, which is invoked any time accessibility is turned on/off, or touch exploration is turned on/off.
```

LANGUAGE: APIDOC
CODE:
```
FlutterCallbackInformation
  A class representing information for a callback registered using `PluginUtilities` from `dart:ui`.
```

LANGUAGE: APIDOC
CODE:
```
FlutterRunArguments
  A class containing arguments for entering a FlutterNativeView's isolate for the first time.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry
  Registry of backend textures used with a single `FlutterView` instance.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.GLTextureConsumer
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.ImageConsumer
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.ImageTextureEntry
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.OnFrameConsumedListener
  Listener invoked when the most recent image has been consumed.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.OnTrimMemoryListener
  Listener invoked when a memory pressure warning was forward.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.SurfaceLifecycle
  How a `TextureRegistry.SurfaceProducer` created by `TextureRegistry.createSurfaceProducer()` manages the lifecycle of the created surface.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.SurfaceProducer
  Uses a Surface to populate the texture.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.SurfaceProducer.Callback
  Callback invoked by `TextureRegistry.SurfaceProducer.setCallback(Callback)`.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.SurfaceTextureEntry
  A registry entry for a managed SurfaceTexture.
```

LANGUAGE: APIDOC
CODE:
```
TextureRegistry.TextureEntry
  An entry in the texture registry.
```

LANGUAGE: APIDOC
CODE:
```
VsyncWaiter
```

----------------------------------------

TITLE: Handle Resume Event
DESCRIPTION: A lifecycle method invoked when the associated Flutter activity or engine resumes, allowing the controller to re-initialize or restore state.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewsController

LANGUAGE: APIDOC
CODE:
```
onResume(): void
  Description: Invoked when the associated Flutter activity or engine resumes.
```

----------------------------------------

TITLE: Remove On User Leave Hint Listener
DESCRIPTION: Removes a previously added PluginRegistry.UserLeaveHintListener from the ActivityPluginBinding. This listener is invoked when the user indicates they are leaving the activity (e.g., by pressing Home).
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityPluginBinding

LANGUAGE: APIDOC
CODE:
```
void removeOnUserLeaveHintListener(PluginRegistry.UserLeaveHintListener listener)
```

----------------------------------------

TITLE: Android View Class Set Methods API
DESCRIPTION: This section details a collection of 'set' methods from the `android.view.View` class. These methods are used to modify the state, appearance, and interaction properties of a View object, such as its dimensions, accessibility flags, and event handling capabilities. Each method typically takes one or more parameters to define the new property value.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewWrapper

LANGUAGE: APIDOC
CODE:
```
Class: android.view.View
Methods:
  setHandwritingDelegateFlags(flags: int)
  setHandwritingDelegatorCallback(callback: java.lang.Runnable)
  setHapticFeedbackEnabled(enabled: boolean)
  setHasTransientState(hasTransientState: boolean)
  setHorizontalFadingEdgeEnabled(enabled: boolean)
  setHorizontalScrollBarEnabled(enabled: boolean)
  setHorizontalScrollbarThumbDrawable(drawable: android.graphics.drawable.Drawable)
  setHorizontalScrollbarTrackDrawable(drawable: android.graphics.drawable.Drawable)
  setHovered(hovered: boolean)
  setId(id: int)
  setImportantForAccessibility(mode: int)
  setImportantForAutofill(mode: int)
  setImportantForContentCapture(mode: int)
  setIsCredential(isCredential: boolean)
  setIsHandwritingDelegate(isHandwritingDelegate: boolean)
  setKeepScreenOn(keepScreenOn: boolean)
  setKeyboardNavigationCluster(isCluster: boolean)
  setLabelFor(labeledId: int)
  setLayerPaint(paint: android.graphics.Paint)
  setLayerType(layerType: int, paint: android.graphics.Paint)
  setLayoutDirection(layoutDirection: int)
  setLayoutParams(params: android.view.ViewGroup.LayoutParams)
  setLeft(left: int)
  setLeftTopRightBottom(left: int, top: int, right: int, bottom: int)
  setLongClickable(longClickable: boolean)
  setMeasuredDimension(measuredWidth: int, measuredHeight: int)
  setMinimumHeight(minHeight: int)
  setMinimumWidth(minWidth: int)
  setNestedScrollingEnabled(enabled: boolean)
  setNextClusterForwardId(id: int)
  setNextFocusDownId(id: int)
  setNextFocusForwardId(id: int)
```

----------------------------------------

TITLE: Set Up Internal Flutter Channels
DESCRIPTION: This section initializes various internal plugins and handlers that facilitate communication and functionality within the Flutter engine. These include the internal plugin registrar, accessibility plugin, cursor handler, platform handler, and settings plugin, all linked via the messenger wrapper.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows__engine_8cc_source

LANGUAGE: C++
CODE:
```
internal_plugin_registrar_ =
std::make_unique<PluginRegistrar>(plugin_registrar_.get());

accessibility_plugin_ = std::make_unique<AccessibilityPlugin>(this);
AccessibilityPlugin::SetUp(messenger_wrapper_.get(),
accessibility_plugin_.get());

cursor_handler_ =
std::make_unique<CursorHandler>(messenger_wrapper_.get(), this);
platform_handler_ =
std::make_unique<PlatformHandler>(messenger_wrapper_.get(), this);
settings_plugin_ = std::make_unique<SettingsPlugin>(messenger_wrapper_.get(),
task_runner_.get());
```

----------------------------------------

TITLE: Flutter C++ StandardMethodCodec Class API Documentation
DESCRIPTION: API documentation for the `flutter::StandardMethodCodec` class, which handles binary serialization for method calls and results in Flutter's C++ client wrapper. It provides static methods to get an instance and protected methods for encoding and decoding various communication envelopes.
SOURCE: https://api.flutter.dev/linux-embedder/standard__method__codec_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::StandardMethodCodec Class
  Description: An implementation of MethodCodec that uses a binary serialization.
  Inherits: flutter::MethodCodec<EncodableValue>

  Public Methods:
    GetInstance(serializer: const StandardCodecSerializer* = nullptr) -> const StandardMethodCodec&
      Description: Returns an instance of the codec, optionally using a custom serializer to add support for more types. If provided, |serializer| must be long-lived. If no serializer is provided, the default will be used. The instance returned for a given |extension| will be shared, and any instance returned from this will be long-lived, and can be safely passed to, e.g., channel constructors.
      Parameters:
        serializer: const StandardCodecSerializer* (optional) - Custom serializer for additional types.
    ~StandardMethodCodec()
      Description: Destructor for StandardMethodCodec.
    StandardMethodCodec(StandardMethodCodec const&) = delete
      Description: Deleted copy constructor to prevent copying.
    operator=(StandardMethodCodec const&) = delete
      Description: Deleted assignment operator to prevent copying.

  Protected Methods (Overrides from MethodCodec):
    DecodeMethodCallInternal(message: const uint8_t*, message_size: size_t) -> std::unique_ptr<MethodCall<EncodableValue>>
      Description: Decodes a method call from a binary message.
      Parameters:
        message: const uint8_t* - Pointer to the message data.
        message_size: size_t - Size of the message data.
    EncodeMethodCallInternal(method_call: const MethodCall<EncodableValue>&) -> std::unique_ptr<std::vector<uint8_t>>
      Description: Encodes a method call into a binary message.
      Parameters:
        method_call: const MethodCall<EncodableValue>& - The method call to encode.
    EncodeSuccessEnvelopeInternal(result: const EncodableValue*) -> std::unique_ptr<std::vector<uint8_t>>
      Description: Encodes a successful method result into a binary envelope.
      Parameters:
        result: const EncodableValue* - The result value to encode.
    EncodeErrorEnvelopeInternal(error_code: const std::string&, error_message: const std::string&, error_details: const EncodableValue*) -> std::unique_ptr<std::vector<uint8_t>>
      Description: Encodes an error result into a binary envelope.
      Parameters:
        error_code: const std::string& - The error code.
        error_message: const std::string& - The error message.
        error_details: const EncodableValue* - Optional error details.
    DecodeAndProcessResponseEnvelopeInternal(response: const uint8_t*, response_size: size_t, result: MethodResult<EncodableValue>*) -> bool
      Description: Decodes and processes a binary response envelope.
      Parameters:
        response: const uint8_t* - Pointer to the response data.
        response_size: size_t - Size of the response data.
        result: MethodResult<EncodableValue>* - Pointer to the method result object to populate.

  Private Members:
    serializer_: const StandardCodecSerializer* - The serializer instance used by the codec.
```

----------------------------------------

TITLE: Set Binary Message Handler for a Channel in BinaryMessengerImpl
DESCRIPTION: Registers a handler for incoming binary messages on a specific channel. If the handler is null, it removes any existing handler for that channel. The handler is saved to ensure its lifetime and an adaptor callback is set for the underlying messenger.
SOURCE: https://api.flutter.dev/ios-embedder/core__implementations_8cc_source

LANGUAGE: C++
CODE:
```
void BinaryMessengerImpl::SetMessageHandler(const std::string& channel,
 BinaryMessageHandler handler) {
 if (!handler) {
 handlers_.erase(channel);
 FlutterDesktopMessengerSetCallback(messenger_, channel.c_str(), nullptr,
 nullptr);
 return;
 }
 // Save the handler, to keep it alive.
 handlers_[channel] = std::move(handler);
 BinaryMessageHandler* message_handler = &handlers_[channel];
 // Set an adaptor callback that will invoke the handler.
 FlutterDesktopMessengerSetCallback(messenger_, channel.c_str(),
 ForwardToHandler, message_handler);
}
```

----------------------------------------

TITLE: API: flutter::FlutterWindowsEngine::RegisterExternalTexture
DESCRIPTION: Registers an external texture with the Flutter engine using its texture ID. This allows Flutter to render content from external sources.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows__engine_8h_source

LANGUAGE: APIDOC
CODE:
```
bool RegisterExternalTexture(int64_t texture_id)
```

----------------------------------------

TITLE: FlutterViewController Class API Reference
DESCRIPTION: Reference for the `FlutterViewController` class, which is a UIViewController subclass responsible for hosting and displaying Flutter content within a native macOS application.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_engine_8h_source

LANGUAGE: APIDOC
CODE:
```
FlutterViewController Class
  Definition: FlutterViewController.h:73
```

----------------------------------------

TITLE: Preroll and Composite Embedded View
DESCRIPTION: Prepares an embedded view for composition within the Flutter rendering pipeline. It creates a view slice and updates the view's composition parameters. If the parameters have not changed since the last preroll, no action is taken to optimize performance.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_views_controller_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)prerollCompositeEmbeddedView:(int64_t)viewId
 withParams:(std::unique_ptr<[flutter](namespaceflutter.html)::EmbeddedViewParams>)params {
 SkRect viewBounds = SkRect::Make(self.frameSize);
 std::unique_ptr<flutter::EmbedderViewSlice> view;
 view = std::make_unique<flutter::DisplayListEmbedderViewSlice>(viewBounds);
 self.slices.insert_or_assign(viewId, std::move(view));

 self.compositionOrder.push_back(viewId);

 if (self.currentCompositionParams.count(viewId) == 1 &&
 self.currentCompositionParams[viewId] == *params.get()) {
 // Do nothing if the params didn't change.
 return;
 }
 self.currentCompositionParams[viewId] = flutter::EmbeddedViewParams(*params.get());
 self.viewsToRecomposite.insert(viewId);
}
```

----------------------------------------

TITLE: Handle Exit Application Method Call in C++
DESCRIPTION: Processes the `kExitApplicationMethod` call. It parses `exit_type` and `exit_code` from the method arguments, validating their types. If arguments are invalid, an error is returned. Otherwise, `SystemExitApplication` is called to perform the exit.
SOURCE: https://api.flutter.dev/windows-embedder/platform__handler_8cc_source

LANGUAGE: C++
CODE:
```
if (method.compare(kExitApplicationMethod) == 0) {
  const rapidjson::Value& arguments = method_call.arguments()[0];

  rapidjson::Value::ConstMemberIterator itr =
  arguments.FindMember(kExitTypeKey);
  if (itr == arguments.MemberEnd() || !itr->value.IsString()) {
    result->Error(kExitRequestError, kInvalidExitRequestMessage);
    return;
  }
  const std::string& exit_type = itr->value.GetString();

  itr = arguments.FindMember(kExitCodeKey);
  if (itr == arguments.MemberEnd() || !itr->value.IsInt()) {
    result->Error(kExitRequestError, kInvalidExitRequestMessage);
    return;
  }
  UINT exit_code = arguments[kExitCodeKey].GetInt();

  SystemExitApplication(StringToAppExitType(exit_type), exit_code,
  std::move(result));
}
```

----------------------------------------

TITLE: Flutter StandardMessageCodec Class API Reference
DESCRIPTION: Defines the StandardMessageCodec class, responsible for encoding and decoding messages using Flutter's standard binary message format. This includes methods for internal message processing and instance management.
SOURCE: https://api.flutter.dev/ios-embedder/standard__codec_8cc_source

LANGUAGE: APIDOC
CODE:
```
class StandardMessageCodec {
  ~StandardMessageCodec();
  static const StandardMessageCodec & GetInstance(const StandardCodecSerializer *serializer=nullptr);
  std::unique_ptr< EncodableValue > DecodeMessageInternal(const uint8_t *binary_message, const size_t message_size) const override;
  StandardMessageCodec(StandardMessageCodec const &)=delete;
  std::unique_ptr< std::vector< uint8_t > > EncodeMessageInternal(const EncodableValue &message) const override;
}
```

----------------------------------------

TITLE: Decode Method Response using FlMethodCodec
DESCRIPTION: Documents the `fl_method_codec_decode_response` function, which decodes a method response message from a GBytes buffer. If the message is empty, it returns a 'not implemented' response. Returns an FlMethodResponse object or nullptr on failure with an error. Includes related definition for `fl_method_not_implemented_response_new`.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__codec_8cc

LANGUAGE: APIDOC
CODE:
```
Function: fl_method_codec_decode_response
  Return Type: FlMethodResponse*
  Parameters:
    self: FlMethodCodec * - The method codec instance.
    message: GBytes * - The message bytes to decode.
    error: GError ** - Output parameter for error information.

Related Definitions:
  fl_method_not_implemented_response_new:
    Signature: G_MODULE_EXPORT FlMethodNotImplementedResponse * fl_method_not_implemented_response_new()
    Definition: fl_method_response.cc:179
```

LANGUAGE: C++
CODE:
```
{
  g_return_val_if_fail(FL_IS_METHOD_CODEC(self), nullptr);
  g_return_val_if_fail(message != nullptr, nullptr);

  if (g_bytes_get_size(message) == 0) {
    return FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  return FL_METHOD_CODEC_GET_CLASS(self)->decode_response(self, message, error);
}
```

----------------------------------------

TITLE: Flutter Rect Class API Reference
DESCRIPTION: API documentation for the `flutter::Rect` class, representing an immutable rectangle defined by an origin point and a size. It includes constructors, methods for accessing geometric properties (left, top, right, bottom, width, height), and operators for comparison and assignment.
SOURCE: https://api.flutter.dev/linux-embedder/geometry_8h_source

LANGUAGE: C++
CODE:
```
class flutter::Rect {
  Rect(const Point& origin, const Size& size) : origin_(origin), size_(size) {}
  Rect(const Rect& rect) = default;
  Rect& operator=(const Rect& other) = default;
  double left() const { return origin_.x(); }
  double top() const { return origin_.y(); }
  double right() const { return origin_.x() + size_.width(); }
  double bottom() const { return origin_.y() + size_.height(); }
  double width() const { return size_.width(); }
  double height() const { return size_.height(); }
  Point origin() const { return origin_; }
  Size size() const { return size_; }
  bool operator==(const Rect& other) const {
    return origin_ == other.origin_ && size_ == other.size_;
  }
private:
  Point origin_;
  Size size_;
};
```

----------------------------------------

TITLE: APIDOC: MessageCodec.encodeMessage Method
DESCRIPTION: Documents the `encodeMessage` method of the `MessageCodec` interface, which is responsible for encoding a generic message type `T` into a `ByteBuffer`.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/BinaryCodec

LANGUAGE: APIDOC
CODE:
```
encodeMessage(message: T) -> ByteBuffer
  message: The T message, possibly null.
  Returns: A ByteBuffer containing the encoding between position 0 and the current position, or null, if message is null.
```

----------------------------------------

TITLE: Simulating and Verifying a Keyboard Key Down Event in Flutter (Objective-C)
DESCRIPTION: This Objective-C code snippet demonstrates how to simulate a keyboard key down event (specifically for the '.' key) within a Flutter application's test environment. It initializes a FlutterViewController, sets up mock responders and a binary messenger, encodes a key event as JSON, sends it on the 'flutter/keyevent' channel, and then verifies that the event was processed as expected, including the reply from the Flutter engine. It uses OCMock for mocking and verification.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_view_controller_test_8mm_source

LANGUAGE: Objective-C
CODE:
```
FlutterViewController* viewController = [[[FlutterViewController alloc] initWithEngine:engineMock
nibName:@""
bundle:nil];
id responderMock = flutter::testing::mockResponder();
id responderWrapper = [[[FlutterResponderWrapper alloc] initWithResponder:responderMock];
viewController.nextResponder = responderWrapper;
NSDictionary* expectedEvent = @{
@"keymap" : @"macos",
@"type" : @"keydown",
@"keyCode" : @(65),
@"modifiers" : @(538968064),
@"characters" : @".",
@"charactersIgnoringModifiers" : @".",
};
NSData* encodedKeyEvent = [[[FlutterJSONMessageCodec sharedInstance] encode:expectedEvent];
CGEventRef cgEvent = CGEventCreateKeyboardEvent(NULL, 65, TRUE);
NSEvent* event = [NSEvent eventWithCGEvent:cgEvent];
OCMExpect( // NOLINT(google-objc-avoid-throwing-exception)
[binaryMessengerMock sendOnChannel:@"flutter/keyevent"
message:encodedKeyEvent
binaryReply:[OCMArg any]])
.andDo((^(NSInvocation* invocation) {
FlutterBinaryReply handler;
[invocation getArgument:&handler atIndex:4];
NSDictionary* reply = @{
@"handled" : @(true),
};
NSData* encodedReply = [[[FlutterJSONMessageCodec sharedInstance] encode:reply];
handler(encodedReply);
}));
[viewController viewWillAppear]; // Initializes the event channel.
[viewController keyDown:event];
@try {
OCMVerify( // NOLINT(google-objc-avoid-throwing-exception)
never(), [responderMock keyDown:[OCMArg any]]);
OCMVerify( // NOLINT(google-objc-avoid-throwing-exception)
[binaryMessengerMock sendOnChannel:@"flutter/keyevent"
message:encodedKeyEvent
binaryReply:[OCMArg any]]);
} @catch (...) {
return false;
}
return true;
}
```

----------------------------------------

TITLE: Deallocate Flutter Engine Resources (Objective-C)
DESCRIPTION: Handles the deallocation of Flutter engine resources. It notifies plugins to detach from the engine, nils out weak references to registrars, binary messenger, and texture registry, and removes observers from the notification center to prevent memory leaks.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)dealloc {
 /// Notify plugins of dealloc. This should happen first in dealloc since the
 /// plugins may be talking to things like the binaryMessenger.
 [_pluginPublications enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL* stop) {
 if ([object respondsToSelector:@selector(detachFromEngineForRegistrar:)]) {
 NSObject<FlutterPluginRegistrar>* registrar = self.registrars[key];
 [object detachFromEngineForRegistrar:registrar];
 }
 }];

 // nil out weak references.
 // TODO(cbracken): https://github.com/flutter/flutter/issues/156222
 // Ensure that FlutterEngineRegistrar is using weak pointers, then eliminate this code.
 [_registrars
 enumerateKeysAndObjectsUsingBlock:^(id key, FlutterEngineRegistrar* registrar, BOOL* stop) {
 registrar.flutterEngine = nil;
 }];

 [_binaryMessenger](_flutter_engine_8mm.html#af5791c1f1bcd773b87e75e2cd0fe78fd).[parent](interface_flutter_binary_messenger_relay.html#a53f5cf68774d325fb5e604bbfce03879) = nil;
 [_textureRegistry](_flutter_engine_8mm.html#aad14432aa9a42613b03342c584aad12b).[parent](interface_flutter_texture_registry_relay.html#a28a46ee361311ee1c563da9d96b6b80d) = nil;

 NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
 if (_flutterViewControllerWillDeallocObserver) {
 [center removeObserver:_flutterViewControllerWillDeallocObserver];
 }
 [center removeObserver:self];
}
```

----------------------------------------

TITLE: Flutter Plugin Class API Definition
DESCRIPTION: Definition of the `flutter::Plugin` class, representing a plugin instance.
SOURCE: https://api.flutter.dev/windows-embedder/plugin__registrar_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::Plugin
Definition: plugin_registrar.h:77
```

----------------------------------------

TITLE: Initialize FlutterBasicMessageChannel with Full Configuration
DESCRIPTION: This method initializes a FlutterBasicMessageChannel instance with a specified name, binary messenger, message codec, and an optional task queue. It provides granular control over the channel's setup, allowing custom codecs and execution queues.
SOURCE: https://api.flutter.dev/macos-embedder/interface_flutter_basic_message_channel

LANGUAGE: APIDOC
CODE:
```
Method: - (instancetype) initWithName:(NSString *)name binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger codec:(NSObject<FlutterMessageCodec> *)codec taskQueue:(NSObject<FlutterTaskQueue> *_Nullable)taskQueue
Description: Initializes a FlutterBasicMessageChannel with the specified name, binary messenger, and message codec. The channel name logically identifies the channel; identically named channels interfere with each other's communication. The binary messenger is a facility for sending raw, binary messages to the Flutter side. This protocol is implemented by FlutterEngine and FlutterViewController.
Parameters:
  name: The channel name.
  messenger: The binary messenger.
  codec: The message codec.
  taskQueue: The FlutterTaskQueue that executes the handler (see -[FlutterBinaryMessenger makeBackgroundTaskQueue]).
```

----------------------------------------

TITLE: PlatformViewRegistryImpl Class API Documentation
DESCRIPTION: This snippet provides the API documentation for the `PlatformViewRegistryImpl` class, which extends `java.lang.Object` and implements `PlatformViewRegistry`. It includes details about its methods, specifically `registerViewFactory`, its parameters, and return types.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewRegistryImpl

LANGUAGE: APIDOC
CODE:
```
Class: PlatformViewRegistryImpl
Package: io.flutter.plugin.platform
Extends: java.lang.Object
Implements: PlatformViewRegistry

Methods:
  registerViewFactory(viewTypeId: String, factory: PlatformViewFactory)
    Description: Registers a factory for a platform view.
    Parameters:
      viewTypeId: String - unique identifier for the platform view's type.
      factory: PlatformViewFactory - factory for creating platform views of the specified type.
    Returns: boolean - true if succeeded, false if a factory is already registered for viewTypeId.

Inherited Methods from java.lang.Object:
  clone(), equals(Object), finalize(), getClass(), hashCode(), notify(), notifyAll(), toString(), wait(), wait(long), wait(long, int)
```

----------------------------------------

TITLE: Show Edit Menu (Objective-C)
DESCRIPTION: Displays an edit menu for the active view, typically a text input field. This method calculates the local target rectangle for the menu based on global coordinates provided in the arguments and then invokes `showEditMenuWithTargetRect:items:` on the active view. It requires iOS 16.0 or later and returns `YES` if the menu was shown, `NO` otherwise.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_text_input_plugin

LANGUAGE: APIDOC
CODE:
```
- (BOOL) showEditMenu: (ios(16.0)) API_AVAILABLE
```

LANGUAGE: Objective-C
CODE:
```
:(NSDictionary*)args API_AVAILABLE(ios(16.0)) {
 if (!self.activeView.isFirstResponder) {
 return NO;
 }
 NSDictionary<NSString*, NSNumber*>* encodedTargetRect = args[@"targetRect"];
 CGRect globalTargetRect = CGRectMake(
 [encodedTargetRect[@"x"] doubleValue], [encodedTargetRect[@"y"] doubleValue],
 [encodedTargetRect[@"width"] doubleValue], [encodedTargetRect[@"height"] doubleValue]);
 CGRect localTargetRect = [self.hostView convertRect:globalTargetRect toView:self.activeView];
 [self.activeView showEditMenuWithTargetRect:localTargetRect items:args[@"items"]];
 return YES;
}
```

----------------------------------------

TITLE: APIDOC: _FlBinaryMessengerInterface Struct Definition
DESCRIPTION: Defines the `_FlBinaryMessengerInterface` struct, which serves as the interface for binary message communication in the Flutter Linux Embedder. It includes function pointers for setting message handlers, sending responses, sending and finishing messages on channels, resizing channel buffers, managing overflow warnings, and shutting down the messenger.
SOURCE: https://api.flutter.dev/linux-embedder/struct___fl_binary_messenger_interface

LANGUAGE: APIDOC
CODE:
```
Struct _FlBinaryMessengerInterface {
  GTypeInterface parent_iface;
  void (*set_message_handler_on_channel)(
    FlBinaryMessenger *messenger,
    const gchar *channel,
    FlBinaryMessengerMessageHandler handler,
    gpointer user_data,
    GDestroyNotify destroy_notify
  );
  gboolean (*send_response)(
    FlBinaryMessenger *messenger,
    FlBinaryMessengerResponseHandle *response_handle,
    GBytes *response,
    GError **error
  );
  void (*send_on_channel)(
    FlBinaryMessenger *messenger,
    const gchar *channel,
    GBytes *message,
    GCancellable *cancellable,
    GAsyncReadyCallback callback,
    gpointer user_data
  );
  GBytes* (*send_on_channel_finish)(
    FlBinaryMessenger *messenger,
    GAsyncResult *result,
    GError **error
  );
  void (*resize_channel)(
    FlBinaryMessenger *messenger,
    const gchar *channel,
    int64_t new_size
  );
  void (*set_warns_on_channel_overflow)(
    FlBinaryMessenger *messenger,
    const gchar *channel,
    bool warns
  );
  void (*shutdown)(
    FlBinaryMessenger *messenger
  );
}
```

----------------------------------------

TITLE: Generate Encoded Text Editing State JSON
DESCRIPTION: This function constructs a `rapidjson::Document` that encapsulates the current text editing state. It includes the text content, selection range (base and extent), selection affinity, directional flag, and composing range. This data is crucial for synchronizing text input states between the Flutter UI and the underlying platform.
SOURCE: https://api.flutter.dev/windows-embedder/text__input__plugin__unittest_8cc_source

LANGUAGE: C++
CODE:
```
static std::unique_ptr<rapidjson::Document> EncodedEditingState(
  std::string text,
  TextRange selection) {
  auto model = std::make_unique<TextInputModel>();
  model->SetText(text);
  model->SetSelection(selection);

  auto arguments = std::make_unique<rapidjson::Document>(rapidjson::kArrayType);
  auto& allocator = arguments->GetAllocator();
  arguments->PushBack(kDefaultClientId, allocator);

  rapidjson::Value editing_state(rapidjson::kObjectType);
  editing_state.AddMember(kSelectionAffinityKey, kAffinityDownstream,
  allocator);
  editing_state.AddMember(kSelectionBaseKey, selection.base(), allocator);
  editing_state.AddMember(kSelectionExtentKey, selection.extent(), allocator);
  editing_state.AddMember(kSelectionIsDirectionalKey, false, allocator);

  int composing_base =
  model->composing() ? model->composing_range().base() : -1;
  int composing_extent =
  model->composing() ? model->composing_range().extent() : -1;
  editing_state.AddMember(kComposingBaseKey, composing_base, allocator);
  editing_state.AddMember(kComposingExtentKey, composing_extent, allocator);
  editing_state.AddMember(kTextKey,
  rapidjson::Value(model->GetText(), allocator).Move(),
  allocator);
  arguments->PushBack(editing_state, allocator);

  return arguments;
}
```

----------------------------------------

TITLE: Set On Accessibility Change Listener
DESCRIPTION: Registers a listener with this AccessibilityBridge that will be notified whenever accessibility activation or touch exploration activation changes. This allows external components to react to changes in accessibility state.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/view/AccessibilityBridge

LANGUAGE: APIDOC
CODE:
```
void setOnAccessibilityChangeListener(io.flutter.view.AccessibilityBridge.OnAccessibilityChangeListener listener)
```

----------------------------------------

TITLE: API: Encode Flutter Value to Message Bytes (C)
DESCRIPTION: Encodes a Flutter `FlValue` into a `GBytes` object using the specified message codec. This is essential for serializing Flutter data types for transmission over binary channels.
SOURCE: https://api.flutter.dev/linux-embedder/fl__basic__message__channel_8cc_source

LANGUAGE: C
CODE:
```
G_MODULE_EXPORT GBytes * fl_message_codec_encode_message(FlMessageCodec *self, FlValue *message, GError **error)
```

----------------------------------------

TITLE: Flutter AccessibilityBridge Class Overview
DESCRIPTION: Defines the `flutter::AccessibilityBridge` class, its purpose, and how it integrates with Flutter's semantics and native accessibility systems. It explains the need for subclassing and its lifecycle, consuming semantics updates and producing a native accessibility tree.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_accessibility_bridge

LANGUAGE: APIDOC
CODE:
```
class flutter::AccessibilityBridge

An accessibility instance is bound to one `FlutterViewController` and `FlutterView` instance.
It helps populate the UIView's accessibilityElements property from Flutter's semantics nodes.
Use this class to maintain an accessibility tree. This class consumes semantics updates from the embedder API and produces an accessibility tree in the native format.
The bridge creates an AXTree to hold the semantics data that comes from Flutter semantics updates. The tree holds AXNode[s] which contain the semantics information for semantics node. The AXTree resemble the Flutter semantics tree in the Flutter framework. The bridge also uses `FlutterPlatformNodeDelegate` to wrap each AXNode in order to provide an accessibility tree in the native format.
To use this class, one must subclass this class and provide their own implementation of `FlutterPlatformNodeDelegate`.
`AccessibilityBridge` must be created as a shared_ptr, since some methods acquires its weak_ptr.
```

----------------------------------------

TITLE: Flutter StandardCodecSerializer WriteValue Method API
DESCRIPTION: This virtual method, part of the `StandardCodecSerializer` class, is responsible for serializing an `EncodableValue` to a byte stream. It takes the `EncodableValue` to be written and a `ByteStreamWriter` as input.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_standard_message_codec

LANGUAGE: APIDOC
CODE:
```
virtual void WriteValue(const EncodableValue &value, ByteStreamWriter *stream) const

Parameters:
  value: The EncodableValue to be written.
  stream: A pointer to the ByteStreamWriter to which the value will be written.
```

----------------------------------------

TITLE: Check and Get EncodableValue Type in C++
DESCRIPTION: Shows how to safely check the underlying type of an `EncodableValue` using `std::holds_alternative` and retrieve its value using `std::get` in C++. This is crucial for handling polymorphic data received from Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/encodable__value_8h_source

LANGUAGE: C++
CODE:
```
if (std::holds_alternative<std::string>(value)) {
std::string some_string = std::get<std::string>(value);
}
```

----------------------------------------

TITLE: Execute Dart Entrypoint from Bundle and Snapshot
DESCRIPTION: Executes a Dart entrypoint within the Flutter engine. This operation can only be performed once per JNI attachment because a Dart isolate can only be entered once, making it crucial for initial setup.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterJNI

LANGUAGE: APIDOC
CODE:
```
runBundleAndSnapshotFromLibrary(
  @NonNull String bundlePath,
  @Nullable String entrypointFunctionName,
  @Nullable String pathToEntrypointFunction,
  @NonNull AssetManager assetManager,
  @Nullable List<String> entrypointArgs,
  long engineId
)
  Description: Executes a Dart entrypoint.
  Parameters:
    bundlePath: String - The path to the Dart bundle.
    entrypointFunctionName: String (nullable) - The name of the Dart entrypoint function.
    pathToEntrypointFunction: String (nullable) - The path to the file containing the entrypoint function.
    assetManager: AssetManager - The Android AssetManager for resources.
    entrypointArgs: List<String> (nullable) - Optional list of arguments for the entrypoint function.
    engineId: long - The ID of the Flutter engine.
  Returns: void
  Annotations: @UiThread
  Notes: This can only be done once per JNI attachment because a Dart isolate can only be entered once.
```

----------------------------------------

TITLE: FlutterDesktopMessage Struct Members
DESCRIPTION: This snippet documents the members of the `FlutterDesktopMessage` struct, which is a core component for passing messages between the Flutter engine and the native iOS desktop embedder. Each member plays a role in defining the message's channel, content, size, and response handling.
SOURCE: https://api.flutter.dev/ios-embedder/struct_flutter_desktop_message-members

LANGUAGE: APIDOC
CODE:
```
struct FlutterDesktopMessage:
  channel: Member of FlutterDesktopMessage, typically a string identifier for the message channel.
  message: Member of FlutterDesktopMessage, pointer to the message data.
  message_size: Member of FlutterDesktopMessage, size of the message data in bytes.
  response_handle: Member of FlutterDesktopMessage, a handle used for sending a response back to Flutter.
  struct_size: Member of FlutterDesktopMessage, the size of the FlutterDesktopMessage struct itself.
```

----------------------------------------

TITLE: Handle IME Composing End (C++)
DESCRIPTION: Notifies the delegate that IME composing mode has ended. This is triggered when composing ends, for example, when the user presses ESC or commits the composing text while using a multi-step input method, such as for CJK text input.
SOURCE: https://api.flutter.dev/windows-embedder/window__binding__handler__delegate_8h_source

LANGUAGE: C++
CODE:
```
flutter::WindowBindingHandlerDelegate::OnComposeEnd() -> void
```

----------------------------------------

TITLE: Flutter Desktop Texture Information Struct
DESCRIPTION: Contains comprehensive information about a texture to be registered with Flutter. This includes its type and specific configurations for either GPU surface textures or pixel buffer textures, serving as the primary definition for a texture.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_texture_registrar_impl

LANGUAGE: APIDOC
CODE:
```
struct FlutterDesktopTextureInfo
```

----------------------------------------

TITLE: flutter::PlatformViewIOS Class API Reference
DESCRIPTION: API documentation for the `flutter::PlatformViewIOS` class, detailing its constructor, destructor, and key methods for managing platform views on iOS, including handling messages, view ownership, and texture registration.
SOURCE: https://api.flutter.dev/ios-embedder/platform__view__ios_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::PlatformViewIOS::PlatformViewIOS(PlatformView::Delegate &delegate, const std::shared_ptr< IOSContext > &context, __weak FlutterPlatformViewsController *platform_views_controller, const flutter::TaskRunners &task_runners)
```

LANGUAGE: APIDOC
CODE:
```
std::shared_ptr< PlatformMessageHandlerIos > flutter::PlatformViewIOS::GetPlatformMessageHandlerIos() const
```

LANGUAGE: APIDOC
CODE:
```
FlutterViewController * flutter::PlatformViewIOS::GetOwnerViewController() const __attribute__((cf_audited_transfer))
```

LANGUAGE: APIDOC
CODE:
```
void flutter::PlatformViewIOS::OnPreEngineRestart() const override
```

LANGUAGE: APIDOC
CODE:
```
void flutter::PlatformViewIOS::SetOwnerViewController(__weak FlutterViewController *owner_controller)
```

LANGUAGE: APIDOC
CODE:
```
void flutter::PlatformViewIOS::RegisterExternalTexture(int64_t id, NSObject< FlutterTexture > *texture)
```

LANGUAGE: APIDOC
CODE:
```
flutter::PlatformViewIOS::~PlatformViewIOS() override
```

LANGUAGE: APIDOC
CODE:
```
std::unique_ptr< std::vector< std::string > > flutter::PlatformViewIOS::ComputePlatformResolvedLocales(const std::vector< std::string > &supported_locale_data) override
```

----------------------------------------

TITLE: FlutterJSONMethodCodec Class
DESCRIPTION: A codec for encoding and decoding method calls and results using JSON format in Flutter.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_text_input_plugin_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
FlutterJSONMethodCodec
```

----------------------------------------

TITLE: API Documentation for PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode Enum
DESCRIPTION: Defines the display modes that can be requested for platform views at creation time within the Flutter embedding engine. It provides options for different rendering strategies, including Hybrid Composition and Texture Layer with various fallbacks.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode

LANGUAGE: APIDOC
CODE:
```
Enum: PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode
Package: io.flutter.embedding.engine.systemchannels

Description: Platform view display modes that can be requested at creation time.

Inherits from:
  - java.lang.Enum<PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode>

Implemented Interfaces:
  - Serializable
  - Comparable<PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode>
  - java.lang.constant.Constable

Enclosing Class:
  - PlatformViewsChannel.PlatformViewCreationRequest

Enum Constants:
  - HYBRID_ONLY:
      Description: Use Hybrid Composition in all cases.
  - TEXTURE_WITH_HYBRID_FALLBACK:
      Description: Use Texture Layer if possible, falling back to Hybrid Composition if not.
  - TEXTURE_WITH_VIRTUAL_FALLBACK:
      Description: Use Texture Layer if possible, falling back to Virtual Display if not.

Methods:
  - valueOf(String name):
      Modifier and Type: static PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode
      Description: Returns the enum constant of this type with the specified name.
      Parameters:
        - name: String - The name of the enum constant to return.
  - values():
      Modifier and Type: static PlatformViewsChannel.PlatformViewCreationRequest.RequestedDisplayMode[]
      Description: Returns an array containing the constants of this enum type, in the order they are declared.
```

----------------------------------------

TITLE: Flutter Engine Group and Related API Documentation
DESCRIPTION: Comprehensive API documentation for Flutter's core engine components, including classes like FlutterEngineGroup, FlutterDartProject, and FlutterEngine, along with their methods, properties, and definitions.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_group_test_8mm_source

LANGUAGE: APIDOC
CODE:
```
Variable: engine
  Type: id
  Definition: FlutterTextInputPluginTest.mm:92

Class: FlutterDartProject
  Definition: FlutterDartProject.mm:255

Class: FlutterEngineGroup
  Definition: FlutterEngineGroup.h:57
  Methods:
    makeEngineWithEntrypoint:libraryURI:initialRoute:
      Return Type: FlutterEngine *
      Parameters:
        entrypoint: nullable NSString *
        libraryURI: nullable NSString *
        initialRoute: nullable NSString *
      Definition: FlutterEngineGroup.mm:37
    makeEngineWithEntrypoint:libraryURI:
      Return Type: FlutterEngine *
      Parameters:
        entrypoint: nullable NSString *
        libraryURI: nullable NSString *
      Definition: FlutterEngineGroup.mm:32
    makeEngineWithOptions:
      Return Type: FlutterEngine *
      Parameters:
        options: nullable FlutterEngineGroupOptions *
      Definition: FlutterEngineGroup.mm:47

Class: FlutterEngineGroupOptions
  Definition: FlutterEngineGroup.h:17
  Properties:
    entrypointArgs:
      Type: NSArray< NSString * > *
      Definition: FlutterEngineGroup.h:41

Class: FlutterEngineGroupTest
  Definition: FlutterEngineGroupTest.mm:18

Class: FlutterEngine
  Definition: FlutterEngine.h:61
  Methods:
    threadHost:
      Return Type: const flutter::ThreadHost &
  Properties:
    isGpuDisabled:
      Type: BOOL
      Definition: FlutterEngine.h:456

Namespace: FLUTTER_ASSERT_ARC
  Definition: FlutterChannelKeyResponder.mm:13
```

----------------------------------------

TITLE: APIDOC: flutter::JsonMessageCodec Class Reference
DESCRIPTION: Detailed API reference for the `flutter::JsonMessageCodec` class, outlining its definition, inheritance, and member functions for handling JSON message encoding and decoding within the Flutter engine's communication channels.
SOURCE: https://api.flutter.dev/macos-embedder/json__message__codec_8h_source

LANGUAGE: APIDOC
CODE:
```
flutter::JsonMessageCodec Class
  Description: A message encoding/decoding mechanism for communications to/from the Flutter engine via JSON channels.
  Inherits: flutter::MessageCodec<rapidjson::Document>
  Definition: json_message_codec.h:16

  Public Methods:
    static const JsonMessageCodec & GetInstance()
      Description: Returns the shared instance of the codec.
      Definition: json_message_codec.cc:17

    ~JsonMessageCodec() = default
      Description: Default destructor for JsonMessageCodec.
      Definition: json_message_codec.h:21

    JsonMessageCodec(JsonMessageCodec const &) = delete
      Description: Deleted copy constructor to prevent copying of JsonMessageCodec instances.
      Definition: json_message_codec.h:24

    JsonMessageCodec & operator=(JsonMessageCodec const &) = delete
      Description: Deleted assignment operator to prevent copying of JsonMessageCodec instances.
      Definition: json_message_codec.h:25

  Protected Methods:
    JsonMessageCodec() = default
      Description: Default constructor. Instances should be obtained via GetInstance to ensure singleton pattern.
      Definition: json_message_codec.h:29

    std::unique_ptr<rapidjson::Document> DecodeMessageInternal(const uint8_t *binary_message, const size_t message_size) const override
      Description: Decodes a binary message into a rapidjson::Document. This method implements the flutter::MessageCodec interface.
      Parameters:
        binary_message: Pointer to the raw binary message data.
        message_size: The size of the binary message in bytes.
      Returns: A unique_ptr containing the decoded rapidjson::Document.
      Definition: json_message_codec.cc:35

    std::unique_ptr<std::vector<uint8_t>> EncodeMessageInternal(const rapidjson::Document &message) const override
      Description: Encodes a rapidjson::Document into a binary message. This method implements the flutter::MessageCodec interface.
      Parameters:
        message: The rapidjson::Document object to be encoded.
      Returns: A unique_ptr containing a vector of uint8_t representing the encoded binary message.
      Definition: json_message_codec.cc:22
```

----------------------------------------

TITLE: Convert NSData to fml::Mapping Pointer
DESCRIPTION: A utility function to convert an `NSData` object (Objective-C data buffer) into a `std::unique_ptr<fml::Mapping>` (C++ memory-mapped buffer). This is crucial for interoperability between the Objective-C and C++ layers of the Flutter engine.
SOURCE: https://api.flutter.dev/ios-embedder/classflutter_1_1_platform_message_handler_ios

LANGUAGE: C++
CODE:
```
Function: flutter::ConvertNSDataToMappingPtr
Return Type: std::unique_ptr<fml::Mapping>
Parameters:
  - data: NSData * (The NSData object to convert)
```

----------------------------------------

TITLE: Define Callback for Handling Incoming Flutter Desktop Messages
DESCRIPTION: This typedef defines the signature for a callback function used to handle incoming messages from Flutter on a specific channel. It receives the messenger reference, the message details, and user-defined data.
SOURCE: https://api.flutter.dev/linux-embedder/flutter__messenger_8h_source

LANGUAGE: C
CODE:
```
typedef void (*FlutterDesktopMessageCallback)(
    FlutterDesktopMessengerRef /* messenger */,
    const FlutterDesktopMessage* /* message*/,
    void* /* user data */);
```

----------------------------------------

TITLE: Initialize FlViewClass for GTK Widget Integration (C++)
DESCRIPTION: This function initializes the `FlViewClass`, setting up essential GObject and GtkWidget class methods such as `notify`, `dispose`, `realize`, and various key event handlers. It also defines a custom 'first-frame' signal, crucial for managing the lifecycle and interaction of a Flutter view within a GTK application.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8cc

LANGUAGE: C++
CODE:
```
GObjectClass* object_class = G_OBJECT_CLASS(klass);
object_class->notify = fl_view_notify;
object_class->dispose = fl_view_dispose;

GtkWidgetClass* widget_class = GTK_WIDGET_CLASS(klass);
widget_class->realize = fl_view_realize;
widget_class->focus_in_event = fl_view_focus_in_event;
widget_class->key_press_event = fl_view_key_press_event;
widget_class->key_release_event = fl_view_key_release_event;

fl_view_signals[SIGNAL_FIRST_FRAME] =
g_signal_new("first-frame", fl_view_get_type(), G_SIGNAL_RUN_LAST, 0,
NULL, NULL, NULL, G_TYPE_NONE, 0);

gtk_widget_class_set_accessible_type(GTK_WIDGET_CLASS(klass),
fl_socket_accessible_get_type());
```

LANGUAGE: APIDOC
CODE:
```
fl_view_realize:
  Signature: static void fl_view_realize(GtkWidget *widget)
  Definition File: fl_view.cc:588
```

LANGUAGE: APIDOC
CODE:
```
fl_view_key_release_event:
  Signature: static gboolean fl_view_key_release_event(GtkWidget *widget, GdkEventKey *key_event)
  Definition File: fl_view.cc:650
```

LANGUAGE: APIDOC
CODE:
```
fl_view_dispose:
  Signature: static void fl_view_dispose(GObject *object)
  Definition File: fl_view.cc:546
```

LANGUAGE: APIDOC
CODE:
```
fl_view_key_press_event:
  Signature: static gboolean fl_view_key_press_event(GtkWidget *widget, GdkEventKey *key_event)
  Definition File: fl_view.cc:643
```

LANGUAGE: APIDOC
CODE:
```
fl_view_notify:
  Signature: static void fl_view_notify(GObject *object, GParamSpec *pspec)
  Definition File: fl_view.cc:534
```

LANGUAGE: APIDOC
CODE:
```
fl_view_signals:
  Signature: static guint fl_view_signals[LAST_SIGNAL]
  Definition File: fl_view.cc:76
```

LANGUAGE: APIDOC
CODE:
```
fl_view_focus_in_event:
  Signature: static gboolean fl_view_focus_in_event(GtkWidget *widget, GdkEventFocus *event)
  Definition File: fl_view.cc:634
```

----------------------------------------

TITLE: Implement FlMessageCodec for Flutter Linux Embedder
DESCRIPTION: This C++ code defines the `FlMessageCodec` class, responsible for encoding and decoding messages within the Flutter Linux embedder. It includes the `encode_message` function to serialize `FlValue` objects into `GBytes` and the `decode_message` function to deserialize `GBytes` back into `FlValue` objects, handling null message cases and error propagation.
SOURCE: https://api.flutter.dev/linux-embedder/fl__message__codec_8cc_source

LANGUAGE: C++
CODE:
```
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "flutter/shell/platform/linux/public/flutter_linux/fl_message_codec.h"

#include <gmodule.h>

G_DEFINE_QUARK(fl_message_codec_error_quark, fl_message_codec_error)

G_DEFINE_TYPE(FlMessageCodec, fl_message_codec, G_TYPE_OBJECT)

static void fl_message_codec_class_init(FlMessageCodecClass* klass) {}

static void fl_message_codec_init(FlMessageCodec* self) {}

G_MODULE_EXPORT GBytes* fl_message_codec_encode_message(FlMessageCodec* self,
                                 FlValue* message,
                                 GError** error) {
  g_return_val_if_fail(FL_IS_MESSAGE_CODEC(self), nullptr);

  // If the user provided NULL, then make a temporary FlValue object for this to
  // make it simpler for the subclasses.
  g_autoptr(FlValue) null_value = nullptr;
  if (message == nullptr) {
    null_value = fl_value_new_null();
    message = null_value;
  }

  return FL_MESSAGE_CODEC_GET_CLASS(self)->encode_message(self, message, error);
}

G_MODULE_EXPORT FlValue* fl_message_codec_decode_message(FlMessageCodec* self,
                                 GBytes* message,
                                 GError** error) {
  g_return_val_if_fail(FL_IS_MESSAGE_CODEC(self), nullptr);
  g_return_val_if_fail(message != nullptr, nullptr);

  return FL_MESSAGE_CODEC_GET_CLASS(self)->decode_message(self, message, error);
}
```

----------------------------------------

TITLE: Flutter C++ Encodable Value API Reference
DESCRIPTION: This section provides a reference for the core data types and structures defined in `encodable_value.h` for handling encodable values within the Flutter Windows embedder. It includes type definitions for lists, maps, and a comprehensive variant type supporting various primitive and custom encodable values.
SOURCE: https://api.flutter.dev/windows-embedder/encodable__value_8h

LANGUAGE: C++
CODE:
```
#include <any>
#include <cassert>
#include <cstdint>
#include <map>
#include <string>
#include <utility>
#include <variant>
#include <vector>
```

LANGUAGE: APIDOC
CODE:
```
Classes:
- flutter::CustomEncodableValue: Represents a custom encodable value.
- flutter::EncodableValue: Represents a generic encodable value.
```

LANGUAGE: APIDOC
CODE:
```
Namespaces:
- flutter: The primary Flutter namespace.
- flutter::internal: Internal Flutter namespace.
```

LANGUAGE: APIDOC
CODE:
```
Typedefs:
- flutter::EncodableList: std::vector< EncodableValue >
  Description: A vector of EncodableValue objects, representing an encodable list.
- flutter::EncodableMap: std::map< EncodableValue, EncodableValue >
  Description: A map from EncodableValue to EncodableValue, representing an encodable map.
- flutter::internal::EncodableValueVariant: std::variant< std::monostate, bool, int32_t, int64_t, double, std::string, std::vector< uint8_t >, std::vector< int32_t >, std::vector< int64_t >, std::vector< double >, EncodableList, EncodableMap, CustomEncodableValue, std::vector< float > >
  Description: A variant type that can hold any of the supported encodable value types, including primitives, vectors, lists, maps, and custom values.
```

----------------------------------------

TITLE: C++ Flutter Event Channel Method Call Dispatcher
DESCRIPTION: This C++ code snippet implements a message handler for a Flutter method channel. It decodes incoming method calls, specifically handling 'listen' and 'cancel' events for an event stream. It manages the stream's listening state and dispatches calls to a StreamHandler, encoding success or error responses back to Flutter.
SOURCE: https://api.flutter.dev/linux-embedder/event__channel_8h_source

LANGUAGE: C++
CODE:
```
constexpr char kOnCancelMethod[] = "cancel";

std::unique_ptr<MethodCall<T>> method_call =
codec->DecodeMethodCall(message, message_size);
if (!method_call) {
std::cerr
<< "Unable to construct method call from message on channel: "
<< channel_name << std::endl;
reply(nullptr, 0);
return;
}

const std::string& method = method_call->method_name();
if (method.compare(kOnListenMethod) == 0) {
if (is_listening) {
std::unique_ptr<StreamHandlerError<T>> error =
shared_handler->OnCancel(nullptr);
if (error) {
std::cerr << "Failed to cancel existing stream: "
<< (error->error_code) << ", "
<< (error->error_message) << ", "
<< (error->error_details);
}
}
is_listening = true;

std::unique_ptr<std::vector<uint8_t>> result;
auto sink = std::make_unique<EventSinkImplementation>(
messenger, channel_name, codec);
std::unique_ptr<StreamHandlerError<T>> error =
shared_handler->OnListen(method_call->arguments(),
std::move(sink));
if (error) {
result = codec->EncodeErrorEnvelope(error->error_code,
error->error_message,
error->error_details.get());
} else {
result = codec->EncodeSuccessEnvelope();
}
reply(result->data(), result->size());
} else if (method.compare(kOnCancelMethod) == 0) {
std::unique_ptr<std::vector<uint8_t>> result;
if (is_listening) {
std::unique_ptr<StreamHandlerError<T>> error =
shared_handler->OnCancel(method_call->arguments());
if (error) {
result = codec->EncodeErrorEnvelope(error->error_code,
error->error_message,
error->error_details.get());
} else {
result = codec->EncodeSuccessEnvelope();
}
is_listening = false;
} else {
result = codec->EncodeErrorEnvelope(
"error", "No active stream to cancel", nullptr);
}
reply(result->data(), result->size());
} else {
reply(nullptr, 0);
}
};
messenger_->SetMessageHandler(name_, std::move(binary_handler));
```

----------------------------------------

TITLE: TextInputChannel.Configuration.Autofill Class
DESCRIPTION: The Autofill class is nested within Configuration and TextInputChannel. It specifically handles autofill-related settings and behaviors for text input fields, allowing the platform to provide suggestions and complete user input.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/package-summary

LANGUAGE: APIDOC
CODE:
```
class TextInputChannel.Configuration.Autofill
```

----------------------------------------

TITLE: Wrap Nil Value for JSON Serialization (Objective-C)
DESCRIPTION: Converts `nil` Objective-C values to `[NSNull null]` for proper JSON serialization. This ensures that `nil` values are represented explicitly as JSON nulls rather than being omitted or causing errors.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_codecs_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (id)wrapNil:(id)value {
  return value == nil ? [NSNull null] : value;
}
```

----------------------------------------

TITLE: Send Platform Message Response in Flutter Engine
DESCRIPTION: This function sends a response back to a platform message that was received by the Flutter engine. It requires the original message handle and the response data, allowing for an empty response if needed.
SOURCE: https://api.flutter.dev/linux-embedder/fl__engine_8cc

LANGUAGE: APIDOC
CODE:
```
gboolean fl_engine_send_platform_message_response (
  FlEngine *engine,
  const FlutterPlatformMessageResponseHandle *handle,
  GBytes *response,
  GError **error
)

Parameters:
  engine: An FlEngine instance.
  handle: The FlutterPlatformMessageResponseHandle provided in FlEnginePlatformMessageHandler.
  response: (allow-none) The GBytes containing the response data to send, or NULL for an empty response.
  error: (allow-none) GError location to store any error that occurs, or NULL to ignore.

Returns:
  gboolean: TRUE on success, FALSE on failure.

Description:
  Responds to a platform message received by the Flutter engine.
```

LANGUAGE: C++
CODE:
```
{
  g_return_val_if_fail(FL_IS_ENGINE(self), FALSE);
  g_return_val_if_fail(handle != nullptr, FALSE);

  if (self->engine == nullptr) {
    g_set_error(error, fl_engine_error_quark(), FL_ENGINE_ERROR_FAILED,
                "No engine to send response to");
    return FALSE;
  }

  gsize data_length = 0;
  const uint8_t* data = nullptr;
  if (response != nullptr) {
    data =
        static_cast<const uint8_t*>(g_bytes_get_data(response, &data_length));
  }
  FlutterEngineResult result = self->embedder_api.SendPlatformMessageResponse(
      self->engine, handle, data, data_length);

  if (result != kSuccess) {
    g_set_error(error, fl_engine_error_quark(), FL_ENGINE_ERROR_FAILED,
                "Failed to send platform message response");
    return FALSE;
  }

  return TRUE;
}
```

----------------------------------------

TITLE: Flutter TextInputModel: Delete Operations Test Cases
DESCRIPTION: Documents test cases for deleting text within the Flutter TextInputModel. This covers various deletion scenarios such as deleting at the start, middle, or end of text, handling wide characters, deleting selections, and managing deletions within composing regions (e.g., DeleteSurroundingAtCursor, DeleteSurroundingBeforeCursor, DeleteSurroundingAfterCursor, and their 'Composing', 'All', 'Greedy' variants).
SOURCE: https://api.flutter.dev/macos-embedder/text__input__model__unittests_8cc

LANGUAGE: APIDOC
CODE:
```
flutter::TEST cases for TextInputModel (Delete Operations):
  - DeleteStart
  - DeleteMiddle
  - DeleteEnd
  - DeleteWideCharacters
  - DeleteSelection
  - DeleteReverseSelection
  - DeleteStartComposing
  - DeleteStartReverseComposing
  - DeleteMiddleComposing
  - DeleteMiddleReverseComposing
  - DeleteEndComposing
  - DeleteEndReverseComposing
  - DeleteSurroundingAtCursor
  - DeleteSurroundingAtCursorComposing
  - DeleteSurroundingAtCursorAll
  - DeleteSurroundingAtCursorAllComposing
  - DeleteSurroundingAtCursorGreedy
  - DeleteSurroundingAtCursorGreedyComposing
  - DeleteSurroundingBeforeCursor
  - DeleteSurroundingBeforeCursorComposing
  - DeleteSurroundingBeforeCursorAll
  - DeleteSurroundingBeforeCursorAllComposing
  - DeleteSurroundingBeforeCursorGreedy
  - DeleteSurroundingBeforeCursorGreedyComposing
  - DeleteSurroundingAfterCursor
  - DeleteSurroundingAfterCursorComposing
  - DeleteSurroundingAfterCursorAll
  - DeleteSurroundingAfterCursorAllComposing
  - DeleteSurroundingAfterCursorGreedy
  - DeleteSurroundingAfterCursorGreedyComposing
  - DeleteSurroundingSelection
```

----------------------------------------

TITLE: Initialize Flutter Settings Interface (C++)
DESCRIPTION: This C++ function initializes the `FlSettingsInterface` by assigning various getter functions to its corresponding members. These functions include `get_clock_format`, `get_color_scheme`, `get_enable_animations`, `get_high_contrast`, and `get_text_scaling_factor`, linking the interface methods to their implementations.
SOURCE: https://api.flutter.dev/linux-embedder/fl__settings__portal_8cc

LANGUAGE: C++
CODE:
```
iface->get_clock_format = fl_settings_portal_get_clock_format;
iface->get_color_scheme = fl_settings_portal_get_color_scheme;
iface->get_enable_animations = fl_settings_portal_get_enable_animations;
iface->get_high_contrast = fl_settings_portal_get_high_contrast;
iface->get_text_scaling_factor = fl_settings_portal_get_text_scaling_factor;
```

----------------------------------------

TITLE: Encode successful method call response in C++
DESCRIPTION: This function encodes a successful method call result into a JSON array envelope. It takes a pointer to a RapidJSON Document representing the result and wraps it in an array before encoding the entire message.
SOURCE: https://api.flutter.dev/macos-embedder/json__method__codec_8cc_source

LANGUAGE: C++
CODE:
```
JsonMethodCodec::EncodeSuccessEnvelopeInternal(
  const rapidjson::Document* result) const {
  rapidjson::Document envelope;
  envelope.SetArray();
  rapidjson::Value result_value;
  if (result) {
    result_value.CopyFrom(*result, envelope.GetAllocator());
  }
  envelope.PushBack(result_value, envelope.GetAllocator());

  return JsonMessageCodec::GetInstance().EncodeMessage(envelope);
}
```

----------------------------------------

TITLE: Send Deep Link URL to Flutter Framework (Objective-C)
DESCRIPTION: This method sends a deep link URL to the Flutter framework's navigation channel. It waits for the first frame to render (with a 3-second timeout) before invoking the `pushRouteInformation` method with the URL's absolute string. It includes error logging for timeouts or failed route handling and calls a completion handler with the success status.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_view_controller_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)sendDeepLinkToFramework:(NSURL*)url completionHandler:(void (^)(BOOL success))completion {
  __weak [FlutterViewController]* weakSelf = self;
  [self.engine
  waitForFirstFrame:3.0
  callback:^(BOOL didTimeout) {
    if (didTimeout) {
      FML_LOG(ERROR) << "Timeout waiting for the first frame when launching an URL.";
      completion(NO);
    } else {
      // invove the method and get the result
      [weakSelf.engine.navigationChannel
      invokeMethod:@"pushRouteInformation"
      arguments:@{
        @"location" : url.absoluteString ?: [NSNull null],
      }
      result:^(id _Nullable result) {
        BOOL success =
        [result isKindOfClass:[NSNumber class]] && [result boolValue];
        if (!success) {
          // Logging the error if the result is not successful
          FML_LOG(ERROR) << "Failed to handle route information in Flutter.";
        }
        completion(success);
      }];
    }
  }];
}
```

----------------------------------------

TITLE: API: onTrimMemory(int level) method
DESCRIPTION: Callback invoked when the system requests to trim memory. The 'level' parameter indicates the severity of the memory trim request, allowing for appropriate resource release.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewsController

LANGUAGE: APIDOC
CODE:
```
onTrimMemory(level: int): void
```

----------------------------------------

TITLE: Implement fl_mouse_cursor_channel_new Function in C++
DESCRIPTION: This C++ code snippet provides the implementation for fl_mouse_cursor_channel_new. It initializes a new FlMouseCursorChannel, sets its vtable and user data, creates a standard method codec, and establishes a method channel with a handler for incoming calls.
SOURCE: https://api.flutter.dev/linux-embedder/fl__mouse__cursor__channel_8cc

LANGUAGE: C++
CODE:
```
{
g_return_val_if_fail(FL_IS_BINARY_MESSENGER(messenger), nullptr);

FlMouseCursorChannel* self = FL_MOUSE_CURSOR_CHANNEL(
g_object_new(fl_mouse_cursor_channel_get_type(), nullptr));

self->vtable = vtable;
self->user_data = user_data;

g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
self->channel =
fl_method_channel_new(messenger, kChannelName, FL_METHOD_CODEC(codec));
fl_method_channel_set_method_call_handler(self->channel, method_call_cb, self,
nullptr);

return self;
}
```

----------------------------------------

TITLE: Set Method Call Handler for FlMethodChannel in C
DESCRIPTION: This function allows setting a custom method call handler for an FlMethodChannel. It takes the handler function, user data, and a destroy notification callback. It includes a check to prevent setting a handler on a channel that has already been closed, issuing a warning if attempted.
SOURCE: https://api.flutter.dev/linux-embedder/fl__method__channel_8cc_source

LANGUAGE: C
CODE:
```
G_MODULE_EXPORT void fl_method_channel_set_method_call_handler(
  FlMethodChannel* self,
  FlMethodChannelMethodCallHandler handler,
  gpointer user_data,
  GDestroyNotify destroy_notify) {
  g_return_if_fail(FL_IS_METHOD_CHANNEL(self));

  // Don't set handler if channel closed.
  if (self->channel_closed) {
    if (handler != nullptr) {
      g_warning(
      "Attempted to set method call handler on a closed FlMethodChannel");
    }
    if (destroy_notify != nullptr) {
      destroy_notify(user_data);
    }
    return;
  }

  if (self->method_call_handler_destroy_notify != nullptr) {
```

----------------------------------------

TITLE: Initialize FlutterViewController with Project and NIB
DESCRIPTION: Initializes a new `FlutterViewController` and `FlutterEngine` with a specified `FlutterDartProject`. This method implicitly creates a new `FlutterEngine` accessible via the `engine` property after initialization. Parameters include the project, NIB name, and NIB bundle.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_view_controller

LANGUAGE: Objective-C
CODE:
```
- (instancetype) initWithProject:(nullable [FlutterDartProject](class_flutter_dart_project.html) *) *project*
nibName:(nullable NSString *) *nibName*
bundle:(nullable NSBundle *) *NS_DESIGNATED_INITIALIZER*
```

LANGUAGE: APIDOC
CODE:
```
Parameters:
  project: The `[FlutterDartProject](class_flutter_dart_project.html)` to initialize the `[FlutterEngine](interface_flutter_engine.html)` with.
  nibName: The NIB name to initialize this UIViewController with.
  nibBundle: The NIB bundle.
```

----------------------------------------

TITLE: Create SurfaceControl Transaction
DESCRIPTION: Creates a new `SurfaceControl.Transaction` object, used for atomically applying changes to display surfaces. Requires API level 34 or higher.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewsController2

LANGUAGE: APIDOC
CODE:
```
createTransaction(): SurfaceControl.Transaction
```

----------------------------------------

TITLE: FlutterWindowsEngine Constructor Implementation
DESCRIPTION: C++ implementation of the `FlutterWindowsEngine` constructor, detailing the initialization of member variables, setting up the EGL procurement table, configuring the Flutter embedder API, creating a `TaskRunner`, and initializing various messengers, registrars, and internal plugins like `AccessibilityPlugin`, `CursorHandler`, `PlatformHandler`, and `SettingsPlugin`. It also includes logic for checking Impeller support and registering a top-level window procedure delegate.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_flutter_windows_engine

LANGUAGE: C++
CODE:
```
: project_(std::make_unique<FlutterProjectBundle>(project)),
windows_proc_table_(std::move(windows_proc_table)),
aot_data_(nullptr, nullptr),
lifecycle_manager_(std::make_unique<WindowsLifecycleManager>(this)) {
if (windows_proc_table_ == nullptr) {
windows_proc_table_ = std::make_shared<WindowsProcTable>();
}

gl_ = egl::ProcTable::Create();

embedder_api_.struct_size = sizeof(FlutterEngineProcTable);
FlutterEngineGetProcAddresses(&embedder_api_);

task_runner_ =
std::make_unique<TaskRunner>(
embedder_api_.GetCurrentTime, [this](const auto* task) {
if (!engine_) {
FML_LOG(ERROR)
<< "Cannot post an engine task when engine is not running.";
return;
}
if (embedder_api_.RunTask(engine_, task) != kSuccess) {
FML_LOG(ERROR) << "Failed to post an engine task.";
}
});

// Set up the legacy structs backing the API handles.
messenger_ =
fml::RefPtr<FlutterDesktopMessenger>(new FlutterDesktopMessenger());
messenger_->SetEngine(this);
plugin_registrar_ = std::make_unique<FlutterDesktopPluginRegistrar>();
plugin_registrar_->engine = this;

messenger_wrapper_ =
std::make_unique<BinaryMessengerImpl>(messenger_->ToRef());
message_dispatcher_ =
std::make_unique<IncomingMessageDispatcher>(messenger_->ToRef());

texture_registrar_ =
std::make_unique<FlutterWindowsTextureRegistrar>(this, gl_);

// Check for impeller support.
auto& switches = project_->GetSwitches();
enable_impeller_ = std::find(switches.begin(), switches.end(),
"--enable-impeller=true") != switches.end();

egl_manager_ = egl::Manager::Create(
static_cast<egl::GpuPreference>(project_->gpu_preference()));
window_proc_delegate_manager_ = std::make_unique<WindowProcDelegateManager>();
window_proc_delegate_manager_->RegisterTopLevelWindowProcDelegate(
[](HWND hwnd, UINT msg, WPARAM wpar, LPARAM lpar, void* user_data,
LRESULT* result) {
BASE_DCHECK(user_data);
FlutterWindowsEngine* that =
static_cast<FlutterWindowsEngine*>(user_data);
BASE_DCHECK(that->lifecycle_manager_);
return that->lifecycle_manager_->WindowProc(hwnd, msg, wpar, lpar,
result);
},
static_cast<void*>(this));

// Set up internal channels.
// TODO: Replace this with an embedder.h API. See
// https://github.com/flutter/flutter/issues/71099
internal_plugin_registrar_ =
std::make_unique<PluginRegistrar>(plugin_registrar_.get());

accessibility_plugin_ = std::make_unique<AccessibilityPlugin>(this);
AccessibilityPlugin::SetUp(messenger_wrapper_.get(),
accessibility_plugin_.get());

cursor_handler_ =
std::make_unique<CursorHandler>(messenger_wrapper_.get(), this);
platform_handler_ =
std::make_unique<PlatformHandler>(messenger_wrapper_.get(), this);
settings_plugin_ = std::make_unique<SettingsPlugin>(messenger_wrapper_.get(),
task_runner_.get());
}
```

----------------------------------------

TITLE: Flutter Basic Message Channel API Reference
DESCRIPTION: Comprehensive API documentation for `basic_message_channel.h`, detailing the `BasicMessageChannel` class, associated namespaces, typedefs for message handling, and internal utility functions for channel management.
SOURCE: https://api.flutter.dev/macos-embedder/basic__message__channel_8h

LANGUAGE: APIDOC
CODE:
```
Classes:
  - Name: flutter::BasicMessageChannel< T >
    Description: Represents a basic message channel for sending and receiving messages between Flutter and the host platform.

Namespaces:
  - Name: flutter
    Description: The primary namespace for Flutter-related utilities.
  - Name: flutter::internal
    Description: Internal namespace for Flutter-specific functionalities.

Typedefs:
  - Name: flutter::MessageReply< T >
    Definition: std::function< void(const T &reply)>
    Description: A callback function type used to send a reply to a message.
    Parameters:
      - Name: reply
        Type: const T &
        Description: The reply message to be sent.

  - Name: flutter::MessageHandler< T >
    Definition: std::function< void(const T &message, const MessageReply< T > &reply)>
    Description: A callback function type for handling incoming messages from a Flutter channel.
    Parameters:
      - Name: message
        Type: const T &
        Description: The incoming message from the Flutter channel.
      - Name: reply
        Type: const MessageReply< T > &
        Description: A callback to send a reply back to the Flutter channel.

Functions:
  - Name: flutter::internal::ResizeChannel
    Signature: void (BinaryMessenger *messenger, std::string name, int new_size)
    Description: Resizes an internal message channel's buffer.
    Parameters:
      - Name: messenger
        Type: BinaryMessenger *
        Description: The binary messenger instance associated with the channel.
      - Name: name
        Type: std::string
        Description: The name of the channel to resize.
      - Name: new_size
        Type: int
        Description: The new desired size for the channel's buffer.
    Return: void

  - Name: flutter::internal::SetChannelWarnsOnOverflow
    Signature: void (BinaryMessenger *messenger, std::string name, bool warns)
    Description: Sets whether a message channel should issue warnings when its buffer overflows.
    Parameters:
      - Name: messenger
        Type: BinaryMessenger *
        Description: The binary messenger instance associated with the channel.
      - Name: name
        Type: std::string
        Description: The name of the channel to configure.
      - Name: warns
        Type: bool
        Description: True to enable overflow warnings, false to disable them.
    Return: void
```

----------------------------------------

TITLE: C++ Test: Simulate Flutter Key Events with FlKeyEmbedderResponder
DESCRIPTION: This C++ code snippet defines a Google Test case that verifies the functionality of `FlKeyEmbedderResponder` in a Flutter engine context. It initializes a Flutter project and engine, then mocks the `SendKeyEvent` API to capture key events. The test simulates a 'Q' key press (physical 'A') and release, asserting that the events are correctly processed and propagated through the embedder API. It uses `GMainLoop` for asynchronous event handling.
SOURCE: https://api.flutter.dev/linux-embedder/fl__key__embedder__responder__test_8cc

LANGUAGE: C++
CODE:
```
{
  g_autoptr(FlDartProject) project = fl_dart_project_new();
  g_autoptr(FlEngine) engine = fl_engine_new(project);
  EXPECT_TRUE(fl_engine_start(engine, nullptr));

  g_autoptr(FlKeyEmbedderResponder) responder =
  fl_key_embedder_responder_new(engine);

  g_autoptr(GPtrArray) call_records =
  g_ptr_array_new_with_free_func(g_object_unref);
  fl_engine_get_embedder_api(engine)->SendKeyEvent = MOCK_ENGINE_PROC(
  SendKeyEvent,
  ([&call_records](auto engine, const FlutterKeyEvent* event,
  FlutterKeyEventCallback callback, void* user_data) {
  g_ptr_array_add(call_records, fl_key_embedder_call_record_new(
  event, callback, user_data));
  return kSuccess;
  }));

  // On a QWERTY keyboard, press key Q (physically key A), and release.
  // Key down
  g_autoptr(FlKeyEvent) event1 =
  fl_key_event_new(12345, kPress, kKeyCodeKeyA, GDK_KEY_a,
  static_cast<GdkModifierType>(0), 0);
  g_autoptr(GMainLoop) loop1 = g_main_loop_new(nullptr, 0);
  fl_key_embedder_responder_handle_event(
  responder, event1, 0, nullptr,
  [](GObject* object, GAsyncResult* result, gpointer user_data) {
  gboolean handled;
  EXPECT_TRUE(fl_key_embedder_responder_handle_event_finish(
  FL_KEY_EMBEDDER_RESPONDER(object), result, &handled, nullptr));
  EXPECT_EQ(handled, TRUE);

  g_main_loop_quit(static_cast<GMainLoop*>(user_data));
  },
  loop1);

  EXPECT_EQ(call_records->len, 1u);
  FlKeyEmbedderCallRecord* record =
  FL_KEY_EMBEDDER_CALL_RECORD(g_ptr_array_index(call_records, 0));
  EXPECT_EQ(record->event->struct_size, sizeof(FlutterKeyEvent));
  EXPECT_EQ(record->event->timestamp, 12345000);
  EXPECT_EQ(record->event->type, kFlutterKeyEventTypeDown);
  EXPECT_EQ(record->event->physical, kPhysicalKeyA);
  EXPECT_EQ(record->event->logical, kLogicalKeyA);
  EXPECT_STREQ(record->event->character, "a");
  EXPECT_EQ(record->event->synthesized, false);

  invoke_record_callback(record, TRUE);
  g_main_loop_run(loop1);
  clear_records(call_records);

  // Key up
  g_autoptr(FlKeyEvent) event2 =
  fl_key_event_new(12346, kRelease, kKeyCodeKeyA, GDK_KEY_a,
  static_cast<GdkModifierType>(0), 0);
  g_autoptr(GMainLoop) loop2 = g_main_loop_new(nullptr, 0);
  fl_key_embedder_responder_handle_event(
  responder, event2, 0, nullptr,
  [](GObject* object, GAsyncResult* result, gpointer user_data) {
  gboolean handled;
  EXPECT_TRUE(fl_key_embedder_responder_handle_event_finish(
  FL_KEY_EMBEDDER_RESPONDER(object), result, &handled, nullptr));
  EXPECT_EQ(handled, FALSE);

  g_main_loop_quit(static_cast<GMainLoop*>(user_data));
  },
  loop2);
}
```

----------------------------------------

TITLE: Flutter C++ MethodCodec Class API Definition
DESCRIPTION: The `MethodCodec` class serves as a base for codecs that translate binary messages to and from `MethodCall` and response/error objects. It provides methods for decoding incoming method calls, encoding outgoing method calls, and encoding success or error responses. This class is templated to support different data types for method arguments and results.
SOURCE: https://api.flutter.dev/macos-embedder/method__codec_8h_source

LANGUAGE: APIDOC
CODE:
```
namespace flutter {
  template <typename T>
  class MethodCodec {
    // Description: Translates between a binary message and higher-level method call and response/error objects.

    public:
      // Constructor
      MethodCodec(): Default constructor.

      // Destructor
      virtual ~MethodCodec(): Default virtual destructor.

      // Copy Prevention
      MethodCodec(MethodCodec<T> const&): Deleted copy constructor.
      MethodCodec& operator=(MethodCodec<T> const&): Deleted copy assignment operator.

      // Method: DecodeMethodCall (Overload 1)
      // Description: Returns the MethodCall encoded in |message|, or nullptr if it cannot be decoded.
      // Signature: std::unique_ptr<MethodCall<T>> DecodeMethodCall(const uint8_t* message, size_t message_size) const
      // Parameters:
      //   - message (const uint8_t*): The binary message data.
      //   - message_size (size_t): The size of the message data.
      // Returns: std::unique_ptr<MethodCall<T>> - The decoded MethodCall, or nullptr on failure.

      // Method: DecodeMethodCall (Overload 2)
      // Description: Returns the MethodCall encoded in |message|, or nullptr if it cannot be decoded.
      // Signature: std::unique_ptr<MethodCall<T>> DecodeMethodCall(const std::vector<uint8_t>& message) const
      // Parameters:
      //   - message (const std::vector<uint8_t>&): The binary message as a vector.
      // Returns: std::unique_ptr<MethodCall<T>> - The decoded MethodCall, or nullptr on failure.

      // Method: EncodeMethodCall
      // Description: Returns a binary encoding of the given |method_call|, or nullptr if the method call cannot be serialized by this codec.
      // Signature: std::unique_ptr<std::vector<uint8_t>> EncodeMethodCall(const MethodCall<T>& method_call) const
      // Parameters:
      //   - method_call (const MethodCall<T>&): The method call to encode.
      // Returns: std::unique_ptr<std::vector<uint8_t>> - The binary encoding of the method call, or nullptr on failure.

      // Method: EncodeSuccessEnvelope
      // Description: Returns a binary encoding of |result|. |result| must be a type supported by the codec.
      // Signature: std::unique_ptr<std::vector<uint8_t>> EncodeSuccessEnvelope(const T* result = nullptr) const
      // Parameters:
      //   - result (const T* = nullptr): The result to encode (optional).
      // Returns: std::unique_ptr<std::vector<uint8_t>> - The binary encoding of the success envelope.

      // Method: EncodeErrorEnvelope
      // Description: Returns a binary encoding of |error|. The |error_details| must be a type supported by the codec.
      // Signature: std::unique_ptr<std::vector<uint8_t>> EncodeErrorEnvelope(const std::string& error_code, const std::string& error_message = "", const T* error_details = nullptr) const
      // Parameters:
      //   - error_code (const std::string&): The error code.
      //   - error_message (const std::string& = ""): The error message (optional).
      //   - error_details (const T* = nullptr): Details about the error (optional).
      // Returns: std::unique_ptr<std::vector<uint8_t>> - The binary encoding of the error envelope.

      // Method: DecodeResponseEnvelope
      // Description: Decodes the response envelope encoded in |response|, calling the appropriate method on |result|.
      // Note: Full signature and parameters not provided in the source snippet.
  };
}
```

----------------------------------------

TITLE: MethodCall Class
DESCRIPTION: A command object representing the invocation of a named method, typically used for platform channel communication.
SOURCE: https://api.flutter.dev/flutter/services/index

LANGUAGE: APIDOC
CODE:
```
MethodCall: A command object representing the invocation of a named method.
```

----------------------------------------

TITLE: Apply Flutter Platform View Layer Transformations and Clipping in Objective-C
DESCRIPTION: This Objective-C method, `applyFlutterLayer:`, processes a `flutter::PlatformViewLayer` to apply its transformations, compute its final bounding rectangle, opacity, and clipping paths. It handles the conversion between Flutter's physical pixels and Cocoa's logical points, updates the view's frame and opacity, and manages complex clipping scenarios using `CAShapeLayer`s. It also updates associated platform view containers and tracking areas.
SOURCE: https://api.flutter.dev/macos-embedder/_flutter_mutator_view_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)applyFlutterLayer:(const flutter::PlatformViewLayer*)layer {
  // Compute the untransformed bounding rect for the platform view in logical pixels.
  // FlutterLayer.size is in physical pixels but Cocoa uses logical points.
  CGFloat scale = [self contentsScale];
  MutationVector mutations = MutationsForPlatformView(layer->mutations(), scale);

  CATransform3D finalTransform = CATransformFromMutations(mutations);

  // Compute the untransformed bounding rect for the platform view in logical pixels.
  // FlutterLayer.size is in physical pixels but Cocoa uses logical points.
  CGRect untransformedBoundingRect =
  CGRectMake(0, 0, layer->size().width / scale, layer->size().height / scale);
  CGRect finalBoundingRect = CGRectApplyAffineTransform(
  untransformedBoundingRect, CATransform3DGetAffineTransform(finalTransform));
  self.frame = finalBoundingRect;

  // Compute the layer opacity.
  self.layer.opacity = OpacityFromMutations(mutations);

  // Compute the master clip in global logical coordinates.
  CGRect masterClip = MasterClipFromMutations(finalBoundingRect, mutations);
  if (CGRectIsNull(masterClip)) {
  self.hidden = YES;
  return;
  }
  self.hidden = NO;

  /// Paths in global logical coordinates that need to be clipped to.
  NSMutableArray* paths = ClipPathFromMutations(masterClip, mutations);
  [self updatePathClipViewsWithPaths:paths];

  /// Update PlatformViewContainer, PlatformView, and apply transforms and axis-aligned clip rect.
  [self updatePlatformViewWithBounds:untransformedBoundingRect
  transformedBounds:finalBoundingRect
  transform:finalTransform
  clipRect:masterClip];

  [self addSubview:_trackingAreaContainer positioned:(NSWindowAbove)relativeTo:nil];
  _trackingAreaContainer.frame = self.bounds;
}
```

----------------------------------------

TITLE: DartExecutor Class Definition and Overview
DESCRIPTION: Defines the `DartExecutor` class, its inheritance from `java.lang.Object`, and its implementation of the `io.flutter.plugin.common.BinaryMessenger` interface. It also provides a high-level overview of its purpose in executing Dart code.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/dart/DartExecutor

LANGUAGE: APIDOC
CODE:
```
Class: DartExecutor
Package: io.flutter.embedding.engine.dart

Extends: java.lang.Object
Implements: io.flutter.plugin.common.BinaryMessenger

Description:
  Configures, bootstraps, and starts executing Dart code.
  To specify a top-level Dart function to execute, use a DartExecutor.DartEntrypoint to tell DartExecutor where to find the Dart code to execute, and which Dart function to use as the entrypoint. To execute the entrypoint, pass the DartExecutor.DartEntrypoint to executeDartEntrypoint(DartEntrypoint).
  To specify a Dart callback to execute, use a DartExecutor.DartCallback. A given Dart callback must be registered with the Dart VM to be invoked by a DartExecutor. To execute the callback, pass the DartExecutor.DartCallback to executeDartCallback(DartCallback).
  Once started, a DartExecutor cannot be stopped. The associated Dart code will execute until it completes, or until the FlutterEngine that owns this DartExecutor is destroyed.
```

----------------------------------------

TITLE: Create New Flutter Engine Instance
DESCRIPTION: Creates a new instance of the Flutter engine, initialized with a given Dart project. This is the entry point for engine creation.
SOURCE: https://api.flutter.dev/linux-embedder/fl__view_8cc_source

LANGUAGE: C++
CODE:
```
G_MODULE_EXPORT FlEngine * fl_engine_new(FlDartProject *project)
```

----------------------------------------

TITLE: Android View Class: Common Getter Methods
DESCRIPTION: A comprehensive list of getter methods available in the `android.view.View` class, used to retrieve various properties and states of a UI component. Each method is typically used to query the current configuration or status of the View.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/mutatorsstack/FlutterMutatorView

LANGUAGE: APIDOC
CODE:
```
android.view.View Class Methods:
  - getScrollBarFadeDuration()
  - getScrollBarSize()
  - getScrollBarStyle()
  - getScrollCaptureHint()
  - getScrollIndicators()
  - getScrollX()
  - getScrollY()
  - getSolidColor()
  - getSourceLayoutResId()
  - getStateDescription()
  - getStateListAnimator()
  - getSuggestedMinimumHeight()
  - getSuggestedMinimumWidth()
  - getSystemGestureExclusionRects()
  - getSystemUiVisibility()
  - getTag()
  - getTag(int)
  - getTextAlignment()
  - getTextDirection()
  - getTooltipText()
  - getTop()
  - getTopFadingEdgeStrength()
  - getTopPaddingOffset()
  - getTouchables()
  - getTouchDelegate()
  - getTransitionAlpha()
  - getTransitionName()
  - getTranslationX()
  - getTranslationY()
  - getTranslationZ()
  - getUniqueDrawingId()
  - getVerticalFadingEdgeLength()
  - getVerticalScrollbarPosition()
  - getVerticalScrollbarThumbDrawable()
  - getVerticalScrollbarTrackDrawable()
```

----------------------------------------

TITLE: GetNativeHandleForId Method in Flutter PlatformViewPlugin
DESCRIPTION: Retrieves the native window handle (HWND) associated with a given platform view ID. It returns an `std::optional<HWND>`, which will be empty if no corresponding handle is found.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_platform_view_plugin

LANGUAGE: APIDOC
CODE:
```
Method: GetNativeHandleForId
Signature: std::optional< HWND > flutter::PlatformViewPlugin::GetNativeHandleForId(PlatformViewId *id) const
Parameters:
  id: PlatformViewId* - Identifier for the platform view.
Returns: std::optional<HWND> - The native window handle, if found.
```

LANGUAGE: C++
CODE:
```
{
return std::nullopt;
}
```

----------------------------------------

TITLE: Flutter WindowBindingHandlerDelegate Pure Virtual Methods Overview
DESCRIPTION: An overview of the pure virtual methods that must be implemented by classes inheriting from `flutter::WindowBindingHandlerDelegate`. These methods define the interface for various window management, accessibility, and input handling functionalities.
SOURCE: https://api.flutter.dev/windows-embedder/classflutter_1_1_window_binding_handler_delegate

LANGUAGE: APIDOC
CODE:
```
virtual void OnUpdateSemanticsEnabled(bool enabled)=0
virtual gfx::NativeViewAccessible GetNativeViewAccessible()=0
virtual void OnHighContrastChanged()=0
virtual ui::AXFragmentRootDelegateWin * GetAxFragmentRootDelegate()=0
virtual void OnWindowStateEvent(HWND hwnd, WindowStateEvent event)=0
```

----------------------------------------

TITLE: FlutterPlatformViewFactory Protocol API Reference
DESCRIPTION: Detailed API documentation for the `FlutterPlatformViewFactory` protocol, used by Flutter macOS plugins to create and manage native `NSView` instances embedded within Flutter applications. It includes methods for view instantiation and argument decoding.
SOURCE: https://api.flutter.dev/macos-embedder/protocol_flutter_platform_view_factory-p

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterPlatformViewFactory
Import: #import <FlutterPlatformViews.h>

Description: Definition at line 13 of file FlutterPlatformViews.h.

Instance Methods:

1. - (nonnull NSView *)createWithViewIdentifier:(int64_t)viewId arguments:(nullable id)args
   Description: Create a Platform View which is an NSView. A MacOS plugin should implement this method and return an NSView, which can be embedded in a Flutter App. The implementation of this method should create a new NSView.
   Parameters:
     viewId (int64_t): A unique identifier for this view.
     args (nullable id): Parameters for creating the view sent from the Dart side of the Flutter app. If createArgsCodec is not implemented, or if no creation arguments were sent from the Dart code, this will be null. Otherwise this will be the value sent from the Dart code as decoded by createArgsCodec.

2. - (nullable NSObject<FlutterMessageCodec> *)createArgsCodec
   Description: Returns the FlutterMessageCodec for decoding the args parameter of createWithFrame. Only implement this if createWithFrame needs an arguments parameter.
   Optional: Yes
```

----------------------------------------

TITLE: Flutter iOS API Component Index
DESCRIPTION: A comprehensive list of Flutter API components available for iOS development, categorized by their type (Protocol, Interface, Class, Category, Struct). Each entry represents a distinct API element with a link to its full documentation.
SOURCE: https://api.flutter.dev/ios-embedder/annotated

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterTaskQueue
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterTaskQueueDispatch
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterTextInputDelegate
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextInputPlugin
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterTextInputPlugin()
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextInputPluginTest
```

LANGUAGE: APIDOC
CODE:
```
Class: FlutterTextInputView
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterTextInputView()
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextInputViewAccessibilityHider
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextInputViewSpy
```

LANGUAGE: APIDOC
CODE:
```
Class: FlutterTextPlaceholder
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextPosition
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextRange
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextSelectionRect
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTexture
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterTexture
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterTextureRegistry
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextureRegistryRelay
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTextureRegistryRelayTest
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTimerProxy
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterTokenizer
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterTokenizer()
```

LANGUAGE: APIDOC
CODE:
```
Class: FlutterTouchInterceptingView
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterTouchInterceptingView()
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterTouchInterceptingView(Tests)
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterUIPressProxy
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterUIPressProxy()
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterUndoManagerDelegate
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterUndoManagerPlugin
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterUndoManagerPlugin()
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterUndoManagerPluginTest
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterView
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterView()
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterViewController
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterViewController()
```

LANGUAGE: APIDOC
CODE:
```
Category: FlutterViewController(Tests)
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterViewControllerTest
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterViewEngineDelegate
```

LANGUAGE: APIDOC
CODE:
```
Protocol: FlutterViewResponder
```

LANGUAGE: APIDOC
CODE:
```
Interface: FlutterViewTest
```

LANGUAGE: APIDOC
CODE:
```
Class: ForwardingGestureRecognizer
```

LANGUAGE: APIDOC
CODE:
```
Interface: IOSContextNoopTest
```

LANGUAGE: APIDOC
CODE:
```
Interface: IOSSurfaceNoopTest
```

LANGUAGE: APIDOC
CODE:
```
Struct: LayerData
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockBinaryMessenger
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockEngine
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockFlutterPlatformFactory
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockFlutterPlatformView
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockPlatformView
```

LANGUAGE: APIDOC
CODE:
```
Interface: MockTextChecker
```

LANGUAGE: APIDOC
CODE:
```
Struct: MouseState
```

LANGUAGE: APIDOC
CODE:
```
Interface: Pair
```

LANGUAGE: APIDOC
CODE:
```
Interface: PlatformMessageHandlerIosTest
```

LANGUAGE: APIDOC
CODE:
```
Struct: PlatformViewData
```

LANGUAGE: APIDOC
CODE:
```
Class: PlatformViewFilter
```

LANGUAGE: APIDOC
CODE:
```
Category: PlatformViewFilter()
```

LANGUAGE: APIDOC
CODE:
```
Interface: SemanticsObject
```

LANGUAGE: APIDOC
CODE:
```
Category: SemanticsObject()
```

LANGUAGE: APIDOC
CODE:
```
Category: SemanticsObject(Tests)
```

LANGUAGE: APIDOC
CODE:
```
Category: SemanticsObject(UIFocusSystem)
```

LANGUAGE: APIDOC
CODE:
```
Interface: SemanticsObjectContainer
```

LANGUAGE: APIDOC
CODE:
```
Interface: SemanticsObjectTest
```

LANGUAGE: APIDOC
CODE:
```
Interface: TestCompositor
```

LANGUAGE: APIDOC
CODE:
```
Interface: TestFlutterMetalLayerView
```

LANGUAGE: APIDOC
CODE:
```
Interface: TestKeyEvent
```

LANGUAGE: APIDOC
CODE:
```
Interface: TextInputSemanticsObject
```

LANGUAGE: APIDOC
CODE:
```
Category: TextInputSemanticsObject(Test)
```

LANGUAGE: APIDOC
CODE:
```
Category: UITouch()
```

----------------------------------------

TITLE: Handle New Intent
DESCRIPTION: Call this method from the Activity that is attached to this ActivityControlSurface's FlutterEngine and the associated method in the Activity is invoked.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityControlSurface

LANGUAGE: APIDOC
CODE:
```
boolean onNewIntent(Intent intent)
```

----------------------------------------

TITLE: Flutter StandardMethodCodec Class API Reference
DESCRIPTION: Comprehensive API documentation for the `flutter::StandardMethodCodec` class, including its public member functions and constructors/destructors. This codec is fundamental for method channel communication in Flutter, handling the serialization and deserialization of method calls and responses.
SOURCE: https://api.flutter.dev/macos-embedder/classflutter_1_1_standard_method_codec

LANGUAGE: APIDOC
CODE:
```
Class: flutter::StandardMethodCodec

  Constructors & Destructors:
    ~StandardMethodCodec()
      Signature: flutter::StandardMethodCodec::~StandardMethodCodec()
      Description: Default destructor for StandardMethodCodec.

    StandardMethodCodec(StandardMethodCodec const &)
      Signature: flutter::StandardMethodCodec::StandardMethodCodec(StandardMethodCodec const &)
      Description: Deleted copy constructor. Referenced by GetInstance().

  Member Functions:
    EncodeSuccessEnvelopeInternal(const EncodableValue *result) const override
      Return Type: std::unique_ptr< std::vector< uint8_t > >
      Parameters:
        result: const EncodableValue *
      Description: Encodes a success envelope for method call results.

    EncodeErrorEnvelopeInternal(const std::string &error_code, const std::string &error_message, const EncodableValue *error_details) const override
      Return Type: std::unique_ptr< std::vector< uint8_t > >
      Parameters:
        error_code: const std::string &
        error_message: const std::string &
        error_details: const EncodableValue *
      Description: Encodes an error envelope for method call failures.

    DecodeAndProcessResponseEnvelopeInternal(const uint8_t *response, size_t response_size, MethodResult< EncodableValue > *result) const override
      Return Type: bool
      Parameters:
        response: const uint8_t *
        response_size: size_t
        result: MethodResult< EncodableValue > *
      Description: Decodes and processes a response envelope, updating the provided MethodResult.
```

----------------------------------------

TITLE: C: Implement resize_channel for Flutter Binary Messenger
DESCRIPTION: This C function resizes a Flutter binary messenger channel. It constructs a method call using `FlStandardMethodCodec`, encodes the channel name and new size into `FlValue` arguments, and then sends the message via `fl_binary_messenger_send_on_channel`. It includes error checking for `new_size`.
SOURCE: https://api.flutter.dev/linux-embedder/fl__binary__messenger_8cc

LANGUAGE: C
CODE:
```
FML_DCHECK(new_size >= 0);
g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
g_autoptr(FlValue) args = fl_value_new_list();
fl_value_append_take(args, fl_value_new_string(channel));
fl_value_append_take(args, fl_value_new_int(new_size));
g_autoptr(GBytes) message = fl_method_codec_encode_method_call(
FL_METHOD_CODEC(codec), kResizeMethod, args, nullptr);
fl_binary_messenger_send_on_channel(messenger, kControlChannelName, message,
nullptr, resize_channel_response_cb,
nullptr);
```

----------------------------------------

TITLE: Processing Specific Windows Messages in FlutterWindow
DESCRIPTION: This C++ code snippet implements the `HandleMessage` method of the `FlutterWindow` class, which dispatches various Windows messages to appropriate handlers. It covers DPI changes (`kWmDpiChangedBeforeParent`), window resizing (`WM_SIZE`), painting (`WM_PAINT`), touch input (`WM_TOUCH`), mouse movement (`WM_MOUSEMOVE`), and mouse leave events (`WM_MOUSELEAVE`), translating them into Flutter-specific actions.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__window_8cc_source

LANGUAGE: C++
CODE:
```
LRESULT
FlutterWindow::HandleMessage(UINT const message,
 WPARAM const wparam,
 LPARAM const lparam) noexcept {
 LPARAM result_lparam = lparam;
 int xPos = 0, yPos = 0;
 UINT width = 0, height = 0;
 UINT button_pressed = 0;
 FlutterPointerDeviceKind device_kind;

 switch (message) {
 case kWmDpiChangedBeforeParent:
 current_dpi_ = GetDpiForHWND(window_handle_);
 OnDpiScale(current_dpi_);
 return 0;
 case WM_SIZE:
 width = LOWORD(lparam);
 height = HIWORD(lparam);

 current_width_ = width;
 current_height_ = height;
 HandleResize(width, height);

 OnWindowStateEvent(width == 0 && height == 0 ? WindowStateEvent::kHide
 : WindowStateEvent::kShow);
 break;
 case WM_PAINT:
 OnPaint();
 break;
 case WM_TOUCH: {
 UINT num_points = LOWORD(wparam);
 touch_points_.resize(num_points);
 auto touch_input_handle = reinterpret_cast<HTOUCHINPUT>(lparam);
 if (GetTouchInputInfo(touch_input_handle, num_points,
 touch_points_.data(), sizeof(TOUCHINPUT))) {
 for (const auto& touch : touch_points_) {
 // Generate a mapped ID for the Windows-provided touch ID
 auto touch_id = touch_id_generator_.GetGeneratedId(touch.dwID);

 POINT pt = {TOUCH_COORD_TO_PIXEL(touch.x),
 TOUCH_COORD_TO_PIXEL(touch.y)};
 ScreenToClient(window_handle_, &pt);
 auto x = static_cast<double>(pt.x);
 auto y = static_cast<double>(pt.y);

 if (touch.dwFlags & TOUCHEVENTF_DOWN) {
 OnPointerDown(x, y, kFlutterPointerDeviceKindTouch, touch_id,
 WM_LBUTTONDOWN);
 } else if (touch.dwFlags & TOUCHEVENTF_MOVE) {
 OnPointerMove(x, y, kFlutterPointerDeviceKindTouch, touch_id, 0);
 } else if (touch.dwFlags & TOUCHEVENTF_UP) {
 OnPointerUp(x, y, kFlutterPointerDeviceKindTouch, touch_id,
 WM_LBUTTONDOWN);
 OnPointerLeave(x, y, kFlutterPointerDeviceKindTouch, touch_id);
 touch_id_generator_.ReleaseNumber(touch.dwID);
 }
 }
 CloseTouchInputHandle(touch_input_handle);
 }
 return 0;
 }
 case WM_MOUSEMOVE:
 device_kind = GetFlutterPointerDeviceKind();
 if (device_kind == kFlutterPointerDeviceKindMouse) {
 TrackMouseLeaveEvent(window_handle_);

 xPos = GET_X_LPARAM(lparam);
 yPos = GET_Y_LPARAM(lparam);
 mouse_x_ = static_cast<double>(xPos);
 mouse_y_ = static_cast<double>(yPos);

 int mods = 0;
 if (wparam & MK_CONTROL) {
 mods |= kControl;
 }
 if (wparam & MK_SHIFT) {
 mods |= kShift;
 }
 OnPointerMove(mouse_x_, mouse_y_, device_kind, kDefaultPointerDeviceId,
 mods);
 }
 break;
 case WM_MOUSELEAVE:
 device_kind = GetFlutterPointerDeviceKind();
 if (device_kind == kFlutterPointerDeviceKindMouse) {
 OnPointerLeave(mouse_x_, mouse_y_, device_kind,
 kDefaultPointerDeviceId);
 }

 // Once the tracked event is received, the TrackMouseEvent function
```

----------------------------------------

TITLE: Perform Action for Shortcut Item (iOS UIApplicationDelegate)
DESCRIPTION: This callback method is invoked when the user selects a shortcut item from the app's Home screen quick actions. It's part of the `UIApplicationDelegate` protocol and should return `YES` if the request is handled.
SOURCE: https://api.flutter.dev/ios-embedder/protocol_flutter_application_life_cycle_delegate-p

LANGUAGE: APIDOC
CODE:
```
Method Signature: - (BOOL) application: (UIApplication *)application performActionForShortcutItem: (UIApplicationShortcutItem *)shortcutItem completionHandler: (ios(9.0))API_AVAILABLE
Parameters:
  application: (UIApplication *)
  shortcutItem: (UIApplicationShortcutItem *)
  API_AVAILABLE: (ios(9.0))
Return Value: BOOL
```

----------------------------------------

TITLE: Override onActivityResult() in Android Activity
DESCRIPTION: Overrides the standard Android Activity.onActivityResult() method, which is called when an activity launched with startActivityForResult() exits and returns a result.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity

LANGUAGE: APIDOC
CODE:
```
protected void onActivityResult(int requestCode,
int resultCode,
Intent data)
Overrides: Activity.onActivityResult(int,int,android.content.Intent)
```

----------------------------------------

TITLE: Write Various Data Types to Byte Stream (Standard Codec C++)
DESCRIPTION: This snippet illustrates a portion of the `StandardCodecSerializer::WriteValue` method in C++. It shows how different `EncodableValue` types (like int64, double, string, various vectors, lists, and maps) are serialized and written to a `ByteStreamWriter`. It includes handling for alignment, size prefixes for collections, and recursive calls for nested structures.
SOURCE: https://api.flutter.dev/macos-embedder/standard__codec_8cc_source

LANGUAGE: C++
CODE:
```
case 3: // Assuming kInt64
stream->WriteInt64(std::get<int64_t>(value));
break;
case 4: // Assuming kFloat64
stream->WriteAlignment(8);
stream->WriteDouble(std::get<double>(value));
break;
case 5: { // Assuming kString
const auto& string_value = std::get<std::string>(value);
size_t size = string_value.size();
WriteSize(size, stream); // WriteSize is likely a helper function
if (size > 0) {
stream->WriteBytes(
reinterpret_cast<const uint8_t*>(string_value.data()), size);
}
break;
}
case 6: // Assuming kUInt8List
WriteVector(std::get<std::vector<uint8_t>>(value), stream);
break;
case 7: // Assuming kInt32List
WriteVector(std::get<std::vector<int32_t>>(value), stream);
break;
case 8: // Assuming kInt64List
WriteVector(std::get<std::vector<int64_t>>(value), stream);
break;
case 9: // Assuming kFloat64List
WriteVector(std::get<std::vector<double>>(value), stream);
break;
case 10: { // Assuming kList
const auto& list = std::get<EncodableList>(value);
WriteSize(list.size(), stream);
for (const auto& item : list) {
WriteValue(item, stream); // Recursive call to WriteValue
}
break;
}
case 11: { // Assuming kMap
const auto& map = std::get<EncodableMap>(value);
WriteSize(map.size(), stream);
for (const auto& pair : map) {
WriteValue(pair.first, stream); // Recursive call for key
WriteValue(pair.second, stream); // Recursive call for value
}
break;
}
case 12: // Assuming kCustom
std::cerr
<< "Unhandled custom type in StandardCodecSerializer::WriteValue. "
<< "Custom types require codec extensions." << std::endl;
break;
case 13: { // Assuming kFloat32List
WriteVector(std::get<std::vector<float>>(value), stream);
break;
}

```

----------------------------------------

TITLE: Add Request Permissions Result Listener for Flutter Activity
DESCRIPTION: Adds a listener that is invoked whenever the associated `Activity`'s `onRequestPermissionsResult(...)` method is invoked.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityPluginBinding

LANGUAGE: APIDOC
CODE:
```
void addRequestPermissionsResultListener(@NonNull PluginRegistry.RequestPermissionsResultListener listener)
```

----------------------------------------

TITLE: ARG_DART_ENTRYPOINT_ARGS
DESCRIPTION: This argument specifies the Dart entrypoint arguments that are executed upon the initialization of the Flutter engine within the fragment. It allows passing custom arguments to the Dart application.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment

LANGUAGE: Java
CODE:
```
protected static final String ARG_DART_ENTRYPOINT_ARGS
```

----------------------------------------

TITLE: SettingsChannel Class for System Settings
DESCRIPTION: The SettingsChannel class is a platform channel used by the Flutter framework to manage and communicate system settings. It enables the application to interact with and retrieve configuration details from the host platform.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/package-summary

LANGUAGE: APIDOC
CODE:
```
class SettingsChannel
```

----------------------------------------

TITLE: Send a message using Flutter Desktop Messenger
DESCRIPTION: Sends a message over a specified channel using the Flutter Desktop Messenger. This function allows native code to send data to the Flutter engine.
SOURCE: https://api.flutter.dev/windows-embedder/flutter__windows_8cc

LANGUAGE: APIDOC
CODE:
```
bool FlutterDesktopMessengerSend(FlutterDesktopMessengerRef messenger, const char *channel, const uint8_t *message, const size_t message_size)
```

----------------------------------------

TITLE: API Reference: PlatformViewsChannel2.PlatformViewsHandler Interface
DESCRIPTION: Detailed API documentation for the `PlatformViewsChannel2.PlatformViewsHandler` interface, which defines the contract for handling platform view messages between Flutter and Android. This interface is used to register a handler with `PlatformViewsChannel2` to process requests from the Flutter application.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/PlatformViewsChannel2.PlatformViewsHandler

LANGUAGE: APIDOC
CODE:
```
Interface: PlatformViewsChannel2.PlatformViewsHandler
  Enclosing class: PlatformViewsChannel2
  Description: Handler that receives platform view messages sent from Flutter to Android through a given PlatformViewsChannel.
  Methods:
    clearFocus(int viewId)
      Description: Clears the focus from the platform view with a give id if it is currently focused.
      Parameters:
        viewId: int
      Returns: void
    createPlatformView(@NonNull PlatformViewsChannel2.PlatformViewCreationRequest request)
      Description: The Flutter application would like to display a new Android View, i.e., platform view.
      Parameters:
        request: @NonNull PlatformViewsChannel2.PlatformViewCreationRequest
      Returns: void
    dispose(int viewId)
      Description: The Flutter application would like to dispose of an existing Android View.
      Parameters:
        viewId: int
      Returns: void
    isSurfaceControlEnabled()
      Description: Whether the SurfaceControl swapchain is enabled.
      Returns: boolean
    onTouch(@NonNull PlatformViewsChannel2.PlatformViewTouch touch)
      Description: The user touched a platform view within Flutter. Touch data is reported in touch.
      Parameters:
        touch: @NonNull PlatformViewsChannel2.PlatformViewTouch
      Returns: void
    setDirection(int viewId, int direction)
      Description: The Flutter application would like to change the layout direction of an existing Android View, i.e., platform view.
      Parameters:
        viewId: int
        direction: int
      Returns: void
```

----------------------------------------

TITLE: Flutter C++ EventChannel SetStreamHandler Method Implementation
DESCRIPTION: Registers a stream handler on this channel. If no handler is registered, any incoming stream setup requests will be handled silently by providing an empty stream. This implementation shows how the `BinaryMessageHandler` is set up using a lambda that captures the `StreamHandler` and other channel details, preparing to handle 'listen' and 'cancel' events from the Flutter side.
SOURCE: https://api.flutter.dev/ios-embedder/event__channel_8h_source

LANGUAGE: C++
CODE:
```
void SetStreamHandler(std::unique_ptr<StreamHandler<T>> handler) {
  if (!handler) {
    messenger_->SetMessageHandler(name_, nullptr);
    return;
  }

  // std::function requires a copyable lambda, so convert to a shared pointer.
  // This is safe since only one copy of the shared_pointer will ever be
  // accessed.
  std::shared_ptr<StreamHandler<T>> shared_handler(handler.release());
  const MethodCodec<T>* codec = codec_;
  const std::string channel_name = name_;
  const BinaryMessenger* messenger = messenger_;
  BinaryMessageHandler binary_handler =
      [shared_handler, codec, channel_name, messenger,
       // Mutable state to track the handler's listening status.
       is_listening = false](const uint8_t* message,
                             const size_t message_size,
                             const BinaryReply& reply) mutable {
        constexpr char kOnListenMethod[] = "listen";

```

----------------------------------------

TITLE: Define Flutter EventSink Class for Native-to-Flutter Communication
DESCRIPTION: Defines the `EventSink` template class, an abstract interface for sending events (success, error, end-of-stream) from native C++ code to a Flutter application. It prevents copying and provides virtual methods for subclasses to implement event handling.
SOURCE: https://api.flutter.dev/linux-embedder/event__sink_8h_source

LANGUAGE: C++
CODE:
```
#ifndef FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_EVENT_SINK_H_
#define FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_EVENT_SINK_H_

namespace flutter {

class EncodableValue;

// Event callback. Events to be sent to Flutter application
// act as clients of this interface for sending events.
template <typename T = EncodableValue>
class EventSink {
 public:
  EventSink() = default;
  virtual ~EventSink() = default;

  // Prevent copying.
  EventSink(EventSink const&) = delete;
  EventSink& operator=(EventSink const&) = delete;

  // Consumes a successful event
  void Success(const T& event) { SuccessInternal(&event); }

  // Consumes a successful event.
  void Success() { SuccessInternal(nullptr); }

  // Consumes an error event.
  void Error(const std::string& error_code,
             const std::string& error_message,
             const T& error_details) {
    ErrorInternal(error_code, error_message, &error_details);
  }

  // Consumes an error event.
  void Error(const std::string& error_code,
             const std::string& error_message = "") {
    ErrorInternal(error_code, error_message, nullptr);
  }

  // Consumes end of stream. Ensuing calls to Success() or
  // Error(), if any, are ignored.
  void EndOfStream() { EndOfStreamInternal(); }

 protected:
  // Implementation of the public interface, to be provided by subclasses.
  virtual void SuccessInternal(const T* event = nullptr) = 0;

  // Implementation of the public interface, to be provided by subclasses.
  virtual void ErrorInternal(const std::string& error_code,
                             const std::string& error_message,
                             const T* error_details) = 0;

  // Implementation of the public interface, to be provided by subclasses.
  virtual void EndOfStreamInternal() = 0;
};

} // namespace flutter

#endif // FLUTTER_SHELL_PLATFORM_COMMON_CLIENT_WRAPPER_INCLUDE_FLUTTER_EVENT_SINK_H_
```

----------------------------------------

TITLE: Configure iOS Platform Thread Priority
DESCRIPTION: Configures the priority of the current thread on iOS using platform-specific APIs. This function sets the thread name and adjusts the QoS class and thread priority based on the provided thread configuration, supporting background, normal, raster, and display priorities.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_engine_8mm

LANGUAGE: Objective-C
CODE:
```
static FLUTTER_ASSERT_ARC void IOSPlatformThreadConfigSetter(const fml::Thread::ThreadConfig & config) {
    // set thread name
    fml::Thread::SetCurrentThreadName(config);

    // set thread priority
    switch (config.priority) {
        case fml::Thread::ThreadPriority::kBackground: {
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0);
            [[NSThread currentThread] setThreadPriority:0];
            break;
        }
        case fml::Thread::ThreadPriority::kNormal: {
            pthread_set_qos_class_self_np(QOS_CLASS_DEFAULT, 0);
            [[NSThread currentThread] setThreadPriority:0.5];
            break;
        }
        case fml::Thread::ThreadPriority::kRaster:
        case fml::Thread::ThreadPriority::kDisplay: {
            pthread_set_qos_class_self_np(QOS_CLASS_USER_INTERACTIVE, 0);
            [[NSThread currentThread] setThreadPriority:1.0];
            sched_param param;
            int policy;
            pthread_t thread = pthread_self();
            if (!pthread_getschedparam(thread, &policy, &param)) {
                param.sched_priority = 50;
                pthread_setschedparam(thread, policy, &param);
            }
            break;
        }
    }
}
```

----------------------------------------

TITLE: Manage iOS System Context Menus for Flutter Text Input
DESCRIPTION: These methods control the visibility of the native iOS system context menu (edit menu) for text input. `showSystemContextMenu` attempts to display the menu for an active text input connection, while `hideSystemContextMenu` dismisses it. Both methods are conditional on iOS 16.0 or later and depend on `FlutterTextInputPlugin`.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_platform_plugin_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)showSystemContextMenu:(NSDictionary*)args {
    if (@available(iOS 16.0, *)) {
        FlutterTextInputPlugin* textInputPlugin = [self.engine textInputPlugin];
        BOOL shownEditMenu = [textInputPlugin showEditMenu:args];
        if (!shownEditMenu) {
            FML_LOG(ERROR) << "Only text input supports system context menu for now. Ensure the system "
            "context menu is shown with an active text input connection. See "
            "https://github.com/flutter/flutter/issues/143033.";
        }
    }
}

- (void)hideSystemContextMenu {
    if (@available(iOS 16.0, *)) {
        FlutterTextInputPlugin* textInputPlugin = [self.engine textInputPlugin];
        [textInputPlugin hideEditMenu];
    }
}
```

----------------------------------------

TITLE: Flutter Embedding Engine Activity Plugin Interfaces Hierarchy
DESCRIPTION: This documentation snippet details the interface hierarchy for the `io.flutter.embedding.engine.plugins.activity` package. These interfaces are crucial for developing Flutter plugins that require interaction with Android Activity lifecycle events and plugin binding mechanisms, such as managing activity results or saving instance state.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/activity/package-tree

LANGUAGE: APIDOC
CODE:
```
Package: io.flutter.embedding.engine.plugins.activity

Interface Hierarchy:
  - io.flutter.embedding.engine.plugins.activity.ActivityAware
  - io.flutter.embedding.engine.plugins.activity.ActivityControlSurface
  - io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
  - io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding.OnSaveInstanceStateListener
```

----------------------------------------

TITLE: Handle Remote Notifications Device Token Registration (Objective-C)
DESCRIPTION: This method is called when the application successfully registers for remote notifications and receives a device token. It forwards the 'application:didRegisterForRemoteNotificationsWithDeviceToken:' call to all registered Flutter application lifecycle delegates that respond to the selector, allowing Flutter plugins to use the device token for push notifications.
SOURCE: https://api.flutter.dev/ios-embedder/_flutter_plugin_app_life_cycle_delegate_8mm_source

LANGUAGE: Objective-C
CODE:
```
- (void)application:(UIApplication*)application
 didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
 for (NSObject<FlutterApplicationLifeCycleDelegate>* delegate in _delegates) {
 if (!delegate) {
 continue;
 }
 if ([delegate respondsToSelector:_cmd]) {
 [delegate application:application
 didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
 }
 }
}
```

----------------------------------------

TITLE: Encode Success Envelope API for Flutter
DESCRIPTION: Encodes a successful result into a binary envelope message. This method takes an optional result object and returns a ByteBuffer containing the encoded message.
SOURCE: https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodCodec

LANGUAGE: APIDOC
CODE:
```
encodeSuccessEnvelope(result: Object | null): ByteBuffer
  Parameters:
    result: Object | null - The result value, possibly null.
  Returns:
    ByteBuffer - a ByteBuffer containing the encoding between position 0 and the current position.
```

----------------------------------------

TITLE: Create FlutterEngine with Entrypoint and Library URI
DESCRIPTION: Creates a running `FlutterEngine` instance that shares components with this group. The `entrypoint` specifies a top-level Dart function (defaults to `main()`), and `libraryURI` indicates the Dart library containing the entrypoint (defaults to the `main()` function's library). The entrypoint function must be decorated with `@pragma(vm:entry-point)` if it's not `main()`.
SOURCE: https://api.flutter.dev/ios-embedder/interface_flutter_engine_group

LANGUAGE: APIDOC
CODE:
```
method makeEngineWithEntrypoint:libraryURI:
  signature: - (FlutterEngine *) makeEngineWithEntrypoint:(nullable NSString*)entrypoint libraryURI:(nullable NSString*)libraryURI
  parameters:
    entrypoint: (nullable NSString*) The name of a top-level function from a Dart library. If this is FlutterDefaultDartEntrypoint (or nil); this will default to main(). If it is not the app's main() function, that function must be decorated with @pragma(vm:entry-point) to ensure the method is not tree-shaken by the Dart compiler.
    libraryURI: (nullable NSString*) The URI of the Dart library which contains the entrypoint method. IF nil, this will default to the same library as the main() function in the Dart program.
  return_type: FlutterEngine *
```

LANGUAGE: Objective-C
CODE:
```
:(nullable NSString*)entrypoint
libraryURI:(nullable NSString*)libraryURI {
  return [self makeEngineWithEntrypoint:entrypoint libraryURI:libraryURI initialRoute:nil];
}
```

----------------------------------------

TITLE: Flutter MessageCodec Class Definition
DESCRIPTION: This entry defines the `flutter::MessageCodec<T>` template class, a fundamental component for handling message encoding and decoding operations within the Flutter framework. It serves as a base for various message serialization formats.
SOURCE: https://api.flutter.dev/linux-embedder/message__codec_8h

LANGUAGE: APIDOC
CODE:
```
class flutter::MessageCodec< T >
```

----------------------------------------

TITLE: Flutter Binary Messenger API Definitions
DESCRIPTION: API definitions for the `flutter::BinaryMessenger` class, `flutter` namespace, and related typedefs (`BinaryReply`, `BinaryMessageHandler`) found in `binary_messenger.h`.
SOURCE: https://api.flutter.dev/linux-embedder/binary__messenger_8h

LANGUAGE: APIDOC
CODE:
```
Classes:
  class flutter::BinaryMessenger

Namespaces:
  flutter

Typedefs:
  flutter::BinaryReply:
    typedef std::function< void(const uint8_t *reply, size_t reply_size)>
  flutter::BinaryMessageHandler:
    typedef std::function< void(const uint8_t *message, size_t message_size, BinaryReply reply)>
```