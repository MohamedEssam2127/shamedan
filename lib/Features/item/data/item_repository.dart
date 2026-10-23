import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shamedan/Features/item/data/item_model.dart';

class ItemRepository {
  List<ItemModel>? _cachedItems;
  List<CharacterModel>? _cachedCharacters;

  Future<Map<String, dynamic>> _loadJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/mock_backend/items.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  Future<List<ItemModel>> getItems() async {
    if (_cachedItems != null) return _cachedItems!;

    final data = await _loadJson();
    _cachedItems = (data['items'] as List)
        .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return _cachedItems!;
  }

  Future<ItemModel?> getItemById(String id) async {
    final items = await getItems();
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<ItemModel?> getItemBySlug(String slug) async {
    final items = await getItems();
    try {
      return items.firstWhere((item) => item.slug == slug);
    } catch (_) {
      return null;
    }
  }

  Future<List<ItemModel>> getItemsByCategory(String category) async {
    final items = await getItems();
    return items.where((item) => item.category == category).toList();
  }

  Future<List<CharacterModel>> getCharacters() async {
    if (_cachedCharacters != null) return _cachedCharacters!;

    final data = await _loadJson();
    _cachedCharacters = (data['characters'] as List)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return _cachedCharacters!;
  }

  Future<CharacterModel?> getCharacterById(String id) async {
    final characters = await getCharacters();
    try {
      return characters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
