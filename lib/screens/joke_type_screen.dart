import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';

class JokeTypeScreen extends StatelessWidget {
  final String jokeType;

  const JokeTypeScreen({Key? key, required this.jokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$jokeType Jokes')),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: Text('ID: ${joke.id}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
