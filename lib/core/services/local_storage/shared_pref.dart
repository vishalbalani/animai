// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Static class containing all SharedPreferences keys used in the application
class SharedPrefKey {
  SharedPrefKey._(); // Private constructor

  /// User's selected language preference (e.g., 'en' for English, 'hi' for Hindi)
  static const SharedPrefKeyModel SP_USER_LANGUAGE =
      SharedPrefKeyModel("SP_USER_LANGUAGE", String);

  /// User's premium status (true if premium user, false otherwise)
  static const SharedPrefKeyModel SP_USER_PREMIUM_PLAN =
      SharedPrefKeyModel("SP_USER_PREMIUM_PLAN", bool);

  /// User's preferred theme mode (0 for Light mode, 1 for Dark mode)
  static const SharedPrefKeyModel SP_USER_PREFERRED_MODE =
      SharedPrefKeyModel("SP_USER_PREFERRED_MODE", int);

  /* Example of how to add new keys:
   * static const SharedPrefKeyModel NEW_KEY =
   *     SharedPrefKeyModel("NEW_KEY", DataType);
   *
   * Usage:
   * Reading: final value = await sharedPref.readSharedPrefData<DataType>(SharedPrefKey.NEW_KEY);
   * Writing: await sharedPref.writeSharedPrefData(SharedPrefKey.NEW_KEY, value);
   */
}

/// Interface defining the contract for SharedPreferences operations
abstract interface class SharedPref {
  /// Read data from SharedPreferences for the given key
  /// Returns null if key doesn't exist or on error
  Future<T?> readSharedPrefData<T>(SharedPrefKeyModel prefKey);

  /// Write data to SharedPreferences for the given key
  /// Returns true if successful, false otherwise
  Future<bool> writeSharedPrefData<T>(SharedPrefKeyModel prefKey, T value);

  /// Delete specific key from SharedPreferences
  /// Returns true if successful, false otherwise
  Future<bool> deleteSharedPrefData(SharedPrefKeyModel prefKey);

  /// Clear all data from SharedPreferences
  /// Returns true if successful, false otherwise
  Future<bool> clearSharedPrefData();
}

/// Implementation of SharedPreferences operations using Singleton pattern
@immutable
class SharedPrefImpl implements SharedPref {
  final SharedPreferences prefs;
  const SharedPrefImpl(this.prefs);

  @override
  Future<T?> readSharedPrefData<T>(SharedPrefKeyModel prefKey) async {
    try {
      // Verify that the requested type matches the key's defined type
      if (prefKey.type != T) {
        throw ArgumentError(
          'Type mismatch: Expected ${prefKey.type} but got $T',
        );
      }

      // Handle different data types
      if (T == String) {
        return prefs.getString(prefKey.key) as T?;
      } else if (T == int) {
        return prefs.getInt(prefKey.key) as T?;
      } else if (T == bool) {
        return prefs.getBool(prefKey.key) as T?;
      } else {
        // Handle complex objects by parsing JSON
        final value = prefs.getString(prefKey.key);
        if (value == null) return null;
        return jsonDecode(value) as T?;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> writeSharedPrefData<T>(
    SharedPrefKeyModel prefKey,
    T value,
  ) async {
    try {
      // Verify that the value type matches the key's defined type
      if (prefKey.type != T) {
        throw ArgumentError(
          'Type mismatch: Expected ${prefKey.type} but got $T',
        );
      }

      // Handle different data types using pattern matching
      switch (value) {
        case String _:
          await prefs.setString(prefKey.key, value as String);
          return true;
        case int _:
          await prefs.setInt(prefKey.key, value as int);
          return true;
        case bool _:
          await prefs.setBool(prefKey.key, value as bool);
          return true;
        default:
          // Handle complex objects by converting to JSON
          await prefs.setString(prefKey.key, jsonEncode(value));
          return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteSharedPrefData(SharedPrefKeyModel prefKey) async {
    try {
      await prefs.remove(prefKey.key);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearSharedPrefData() async {
    try {
      await prefs.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Model class to define SharedPreferences key with its expected data type
class SharedPrefKeyModel {
  /// The key used to store/retrieve data in SharedPreferences
  final String key;

  /// The expected data type for this key (String, int, bool, etc.)
  final Type type;

  const SharedPrefKeyModel(this.key, this.type);
}
