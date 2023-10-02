# Flutter Book Search App

This is a Flutter app that allows users to search for books by title, author, or genre. The app uses the fuzzywuzzy package to perform fuzzy string matching on the user's search query, returning a list of books that match the query.

It is based upon a gist at 

https://gist.github.com/marshyon/87a5f4ede8fe3930d5b8a38dc6125a6a

which is a CLI that also uses a Dart port of the Python fuzzywuzzy package which has in tests seems to have worked better as a replacement for fuse.js in JavaScript apps.

# Getting Started

To use this app, you will need to have Flutter installed on your machine. You can download Flutter from the official website: https://flutter.dev/docs/get-started/install

Once you have Flutter installed, you can clone this repository and run the app using the following commands:

This will launch the app in an emulator or on a connected device.

# Usage

To search for a book, simply enter a search query in the search bar at the top of the screen. The app will return a list of books that match the query, sorted by relevance.

You can tap on a book in the list to view more details about the book, including the author, genre, and summary.

# Contributing

If you would like to contribute to this app, feel free to submit a pull request with your changes. We welcome contributions from the community!

# License

This app is licensed under the MIT License. See the LICENSE file for more information.

This is just an example, so feel free to modify it to fit your specific app and needs.

<!-- language: lang-dart -->