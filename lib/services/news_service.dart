// lib/services/news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

/// NewsService handles API calls to fetch news articles
class NewsService {
  static const String _apiKey = '64994707781b4d80a29a2838af640c4b';
  static const String _baseUrl = 'https://newsapi.org/v2';

  /// Fetch top headlines from the US
  Future<List<Article>> fetchTopHeadlines() async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the API responded with an error despite HTTP 200
        if (data['status'] == 'error') {
          throw Exception('API Error: ${data['message']}');
        }

        final List<dynamic> articlesJson = data['articles'];

        // Map each article JSON to an Article object
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('News fetch failed: $e');
    }
  }
}
