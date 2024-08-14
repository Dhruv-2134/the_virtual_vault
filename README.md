# The Virtual Vault (E-commerce Flutter App)

This is a Flutter-based e-commerce application that demonstrates various features such as product listing, search, cart functionality, and user authentication.

## Features

- Display a list of products with infinite scrolling
- Product detail page
- Search functionality
- User authentication (login/register)
- Shopping cart
- Sort and filter products
- User profile
- Checkout process

## Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Visual Studio Code
- Flutter and Dart extensions for VS Code

## Getting Started

1. Clone the repository: git clone https://github.com/Dhruv-2134/the_virtual_vault.git

2. Open Visual Studio Code

3. Open the project folder:
- Click on "File" > "Open Folder"
- Navigate to the cloned `ecommerce_flutter_app` directory and select it

4. Install dependencies:
- Open the VS Code integrated terminal (View > Terminal)
- Run the following command:
  ```
  flutter pub get
  ```

5. Set up device/emulator:
- Connect a physical device via USB with USB debugging enabled, or
- Set up an Android emulator through Android Studio, or
- Set up an iOS simulator (on macOS)

6. Run the app:
- In VS Code, open the command palette (View > Command Palette or Cmd/Ctrl + Shift + P)
- Type "Flutter: Select Device" and choose your connected device or emulator
- Press F5 or go to Run > Start Debugging to launch the app

## Project Structure

- `lib/`: Contains the main Dart code for the application
- `main.dart`: Entry point of the application
- `config/`: Configuration files
- `models/`: Data models
- `services/`: API and authentication services
- `providers/`: State management using Provider
- `screens/`: UI screens
- `widgets/`: Reusable UI components
- `utils/`: Utility functions and helpers

## Dependencies

This project uses the following packages:

- provider: ^6.0.0
- http: ^0.13.3
- flutter_rating_bar: ^4.0.0

To add or update dependencies, modify the `pubspec.yaml` file and run `flutter pub get`.

## API

This app uses the [Fake Store API](https://fakestoreapi.com/) for demonstration purposes. In a production environment, you would replace this with your own backend API.

## VS Code Setup Tips

1. Install Flutter and Dart extensions:
- Open VS Code
- Go to View > Extensions
- Search for "Flutter" and "Dart"
- Install both extensions

2. Configure Flutter SDK path:
- Go to File > Preferences > Settings
- Search for "Flutter SDK Path"
- Enter the path to your Flutter SDK installation

3. Use Flutter commands in VS Code:
- Open the command palette (View > Command Palette or Cmd/Ctrl + Shift + P)
- Type "Flutter" to see available Flutter commands

4. Debugging:
- Set breakpoints by clicking on the left side of the code editor
- Use the Debug view (View > Debug) to control debugging sessions

5. Flutter DevTools:
- While debugging, you can access Flutter DevTools from the Debug Console
- Click on the "Open DevTools" link that appears when you start debugging

6. Code formatting:
- Use the keyboard shortcut (Alt + Shift + F on Windows/Linux, Option + Shift + F on macOS) to format your code
- You can also set up format on save in VS Code settings

7. Flutter Outline:
- Use the Flutter Outline view (View > Flutter Outline) to navigate and refactor your widget tree easily

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).