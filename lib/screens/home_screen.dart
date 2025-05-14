import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
          final article = newsProvider.articles[index];
          return ListTile(
            leading: article.urlToImage.isNotEmpty
                ? Image.network(
              article.urlToImage,
              width: 100,
              fit: BoxFit.cover,
            )
                : null,
            title: Text(article.title),
            subtitle: Text(article.description),
            onTap: () async {
              final url = Uri.parse(article.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
          );
        },
      ),
    );
  }
}
