import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<Article> _articles = [];
  bool _isLoading = true;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  NewsProvider(){
    fetchNews();
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines();
    } catch (e) {
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}