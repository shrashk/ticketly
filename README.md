# Ticketly
This Flutter mobile application assists users in journey planning by allowing them to search for a starting point. The app sends user queries to an EFA server and displays journey matches based on the search results. It features a simple and intuitive user interface with a search field for entering queries.

## Table of Contents

- [Design Principles](#Design_Principles)
- [Testing](#testing)
- [Packages Used](#Packages_Used)
- [Installation](#installation)

## Design_Principles

- Modular Design: Structured the project using modular components for scalability and maintainability.
- Cubit Implementation: Cubit preferred over BLoC - because of its simplicity, ease of use, reduced boilerplate, and clear focus on managing state with minimal overhead. It allows developers to achieve effective state management while maintaining a clean and maintainable codebase, which is crucial for smaller projects with limited scope and complexity.
- Named Routes: Utilized named routes for efficient navigation throughout the app.

## Testing

- Bloc Tests: Conducted bloc tests to ensure states are being properly emitted.
- Integration Tests: Ran integration tests to validate end-to-end functionality of key features. 
- Widget Tests: Implemented widget tests for testing functionalities of a widget.
  
Helpful links for testing walkthrough
[The Ultimate Guide to Flutter Bloc: State Management and Testing][1]
[Flutter Testing Guide - Reso Coder][2]

[1]: https://hackernoon.com/the-ultimate-guide-to-flutter-bloc-state-management-and-testing
[2]: https://www.youtube.com/watch?v=hUAUAkIZmX0

<summary>Run Tests</summary>

To run tests for this project, execute the following command in your terminal:

```bash
flutter test test/cubit_tests/dashboard_cubit_test.dart
```
```bash
flutter test test/integration_tests/dashboard_integration_test.dart
```
```bash
flutter test test/widget_tests/search_input_test.dart
```

## Packages_Used
- Dio
  A powerful HTTP client for Dart and Flutter applications.

- pretty_dio_logger
  A Dio interceptor for logging HTTP requests and responses in a readable format.

- flutter_bloc
  State management library for Flutter applications based on the BLoC (Business Logic Component) pattern.

- json_annotation
  Provides JSON serialization and deserialization for Dart classes.

- json_serializable
  Code generation library for converting JSON to Dart classes.

- mocktail
  Mocking library for Dart, designed for testing.

- bloc_test
  Testing utilities for the bloc library, simplifying unit and widget testing.

- build_runner
  Provides a way to generate files using Dart code, such as JSON serialization or code generation.

## Installation

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/)


### Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/your-project.git

2. Navigate to the Project Root:

   ```bash
   cd <project-directory>

3. Install Dependencies

   ```bash
   flutter pub get

4. Run the app

   ```bash
   flutter run