# Tudee

A simple Flutter app for creating and managing tasks, with a UI based on a Figma design.

## Features

- Save your name and show a personalized welcome message.
- Add new tasks and edit their titles.
- Tap the task status badge to switch between To-Do and Done.
- View the number of Done and To-Do tasks.
- Keep your name and tasks saved after restarting the app.

## Local Storage

- SharedPreferences stores the user's name.
- Hive CE stores task titles and their status.

## Project Structure

- lib/screens/ — App screens.
- lib/widgets/ — Reusable UI widgets.
- lib/models/ — Task model.
- lib/database/ — Hive initialization and task storage methods.
- assets/icons/ — Icons exported from Figma.
- fonts/ — Local Cherry Bomb, Inter, and Nunito fonts.

## Run the App

Make sure Flutter is installed, then run:

flutter pub get
flutter run

## iOS Build

GitHub Actions builds the app for the iOS Simulator on a macOS runner after each push to main.

The build is available as an artifact and can be uploaded to Appetize for testing.