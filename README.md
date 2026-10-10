# Chapter — Flutter Capstone

Chapter is a cozy autumn-inspired book discovery app focused on classic literature.

## Features
- Discover classic books and browse by genre
- Search books by title or author
- Open a book details screen
- Save and remove favorites
- Add a book to cart (demo interaction)
- Responsive scrolling layouts

## Run the app
1. Install Flutter and set up an emulator or connect a device.
2. Open this project folder in VS Code or Android Studio.
3. Run `flutter pub get`.
4. Run `flutter run`.

## Project structure
- `lib/main.dart` — app entry point and theme
- `lib/models/book.dart` — local book data
- `lib/screens/discover_screen.dart` — discovery screen
- `lib/screens/book_details_screen.dart` — details screen
- `lib/widgets/` — reusable UI components

Book cover images are loaded from Open Library. If a cover cannot load, a designed fallback cover is shown.
