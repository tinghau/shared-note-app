# shared-note-app

### Description
Simple Android, iOS and web clients that connect to a shared note session and has a text area for viewing and editing a block of text. 
Multiple clients can view and edit the same piece of text collaboratively in real-time.
This project uses flutter for building natively compiled applications for Android, iOS and web from a single codebase.

### Installation
The Android 10 and web clients build using: 
* flutter 1.19.0-4.2.pre
* Android Studio 4.0 / IntelliJ 2020.2

For additional flutter install details: <https://flutter.dev/docs/get-started/install/windows>

The iOS 14 client builds using:
* flutter 1.22.0-12.1.pre
* Xcode 12.0.1

For additional flutter install details: <https://flutter.dev/docs/get-started/install/macos>

Run `flutter doctor` to identify any issues with the flutter environment setup.

### Usage
Flutter run commands:
* Android: `flutter run lib/main-mobile.dart`
* iOS: `flutter run lib/main-mobile.dart`
* Web (Chrome): `flutter run lib/main-chrome.dart`

The mobile apps and web app do not share the same code because the web-socket library was not compatible with the web-app, 
so a custom one had to be built.

### Details
Clients connect to a desired session, as defined by a ‘Session Id’ text string. 
Once the ‘Session Id’ has been entered, click ‘Connect’ to open a session on that Id.
The service then serves up the text for that session, which can be edited.

Another client can then connect to the same session, by entering the same ‘Session Id’ text string.
Now both clients can view and edit the same piece of text.

### To Do
* More UI testing to ensure a satisfying user experience in high-latency environments. 