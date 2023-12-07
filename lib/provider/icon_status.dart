import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class IconStatusNotifier extends StateNotifier<Map<String, bool>> {
  IconStatusNotifier() : super({});
  IconData? firstIcon;
  int? firstId;

  void setIconMap(Set<IconData> iconSet) {
    Map<String, bool> iconMap = {};
    for (final element in iconSet) {
      iconMap.addEntries({element.toString(): false}.entries);
    }
    state = iconMap;
  }

  bool iconMatchStatus(IconData icon, int id) {
    if (firstIcon == null) {
      firstIcon = icon;
      firstId = id;
      return false;
    } else if (firstId != id && firstIcon == icon) {
      state = {...state, icon.toString(): true};
      firstIcon = null;
      firstId = null;
      return true;
    }

    firstIcon = icon;
    firstId = id;
    return false;
  }

  bool iconCurrentStatus(IconData icon) {
    return state[icon.toString()]!;
  }

  bool timerStoptrigger() {
    return state.values.toSet().length == 1 &&
        state.values.toSet().elementAt(0) == true;
  }
}

final iconStatusProvider =
    StateNotifierProvider<IconStatusNotifier, Map<String, bool>>(
        (ref) => IconStatusNotifier());
