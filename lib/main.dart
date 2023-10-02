import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class Book {
  final String title;
  final String author;
  final String genre;
  final String summary;

  Book(this.title, this.author, this.genre, this.summary);
}

class SearchRank {
  final Book book;
  final int rank;

  SearchRank(this.book, this.rank);
}

final books = [
  Book('The Hobbit', 'J.R.R. Tolkien', 'Fantasy',
      'The classic fantasy novel about Bilbo Baggins and his adventures with dwarves and a dragon.'),
  Book('Nineteen Eighty-Four', 'George Orwell', 'Dystopian',
      'The dystopian novel set in a totalitarian society where Big Brother is always watching and history is constantly rewritten.'),
  Book('To Kill a Mockingbird', 'Harper Lee', 'Classic',
      'A story of racial injustice and moral growth in the American South.'),
  Book('Pride and Prejudice', 'Jane Austen', 'Romance',
      'The classic novel about love, class, and society in 19th-century England.'),
  Book('The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-age',
      'Follow the adventures of Holden Caulfield as he navigates the challenges of adolescence.'),
  Book('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic',
      'A tale of love, wealth, and the American Dream during the Roaring Twenties.'),
  Book('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy',
      'Epic fantasy trilogy following the quest to destroy the One Ring and defeat Sauron.'),
  Book('Brave New World', 'Aldous Huxley', 'Dystopian',
      'A futuristic society controlled by technology, where individuality is suppressed.'),
  Book('Crime and Punishment', 'Fyodor Dostoevsky', 'Psychological Thriller',
      'Exploration of morality, guilt, and redemption in the mind of a tormented student.'),
  Book('1984', 'George Orwell', 'Dystopian',
      'Winston Smith\'s struggle against the oppressive regime of Oceania and the omnipresent Big Brother.'),
  Book('The Da Vinci Code', 'Dan Brown', 'Mystery',
      'A gripping mystery involving art, religion, and secret societies.'),
  Book('The Hunger Games', 'Suzanne Collins', 'Dystopian',
      'A young girl\'s journey in a dystopian world where she must fight to survive in a brutal game.')
];

List<String> findBooks(String term) {
  var searchRanks = <SearchRank>[];
  for (var book in books) {
    String textToSearch =
        ('${book.title} ${book.author} ${book.genre} ${book.summary}')
            .toLowerCase();

    int ranking = partialRatio(textToSearch, term.toLowerCase());
    ;
    searchRanks.add(SearchRank(book, ranking));
  }
  searchRanks.sort((a, b) => b.rank.compareTo(a.rank));
  var maxResults = 5;
  var resultCount = 0;
  var results = <String>[];
  for (var rank in searchRanks) {
    // print('>> book: ${rank.book.title}');
    // print('>> rank: ${rank.rank}');
    results.add(rank.book.title);
    resultCount++;
    if (resultCount >= maxResults) {
      break;
    }
    // return results;
  }
  return results;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.deepPurpleAccent,
          onPrimary: Colors.purple,
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: Text(
          'simple search',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final Widget title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var searchItems = List.generate(60, (index) => 'Item $index');
  // var allItems = List.generate(60, (index) => 'Item $index');
  var allItems = <String>[];
  var items = [];
  var searchHistory = [];
  void queryListener() {
    search(searchController.text);
  }

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      setState(() {
        // items = searchItems
        //     .where((element) =>
        //         element.toLowerCase().contains(query.toLowerCase()))
        //     .toList();
        items = findBooks(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Search app',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              SearchBar(
                controller: searchController,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                hintText: 'Search',
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.isEmpty ? allItems.length : items.length,
                  itemBuilder: (context, index) {
                    final item = items.isEmpty ? allItems[index] : items[index];

                    return Card(
                        child: Column(
                      children: [
                        Text('name: $item'),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(item),
                      ],
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
