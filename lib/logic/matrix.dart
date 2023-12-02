import 'dart:math';
import 'package:match_box/logic/icon_selection.dart';
import 'package:flutter/material.dart';

final ranGene = Random();
final timer = Stopwatch();
List<IconData> globalSeletedIcons = [];

Set<IconData> generateIconBox(int iconCount) {
  List<IconData> selectedIcons = [];
  int counter = 0;
  while (counter < iconCount) {
    final value = icons[ranGene.nextInt(20)];
    if (!selectedIcons.contains(value)) {
      selectedIcons.addAll([value, value]);
      counter++;
    }
  }
  globalSeletedIcons = selectedIcons;
  return globalSeletedIcons.toSet();
}

List<IconData> selection(List<IconData> removeValue) {
  List<IconData> temp = [];
  IconData? value;

  while (temp.length <= 4) {
    List<IconData> processedList = List.from(globalSeletedIcons);
    if (temp.isEmpty) {
      processedList.removeWhere(
          (element) => removeValue.sublist(0, 2).contains(element));
      value = processedList[ranGene.nextInt(processedList.length)];
    } else if (temp.length == 4) {
      processedList.removeWhere((element) =>
          removeValue.sublist(3).contains(element) || value == element);
      if (processedList.isEmpty) {
        value = globalSeletedIcons[ranGene.nextInt(globalSeletedIcons.length)];
      } else {
        value = processedList[ranGene.nextInt(processedList.length)];
      }
    } else {
      processedList.removeWhere((element) => [
            removeValue[temp.length - 1],
            removeValue[temp.length],
            removeValue[temp.length + 1],
            value
          ].contains(element));
      if (processedList.isEmpty) {
        value = globalSeletedIcons[ranGene.nextInt(globalSeletedIcons.length)];
      } else {
        value = processedList[ranGene.nextInt(processedList.length)];
      }
    }
    globalSeletedIcons.remove(value);
    temp.add(value);
  }
  return temp;
}

List<IconData> firstRow() {
  List<IconData> temp = [];

  IconData? value;

  while (temp.length < 5) {
    List<IconData> processedList = List.from(globalSeletedIcons);
    if (value != null) {
      processedList.removeWhere((element) => element == value);
    }
    value = processedList[ranGene.nextInt(processedList.length)];
    globalSeletedIcons.remove(value);
    temp.add(value);
  }

  return temp;
}

List<List<IconData>> calculate() {
  List<List<IconData>> result = [firstRow()];
  int iterationCount = globalSeletedIcons.length;
  for (int iconListCount = 1;
      iconListCount <= iterationCount / 5;
      iconListCount++) {
    result.add(selection(result[iconListCount - 1]));
  }

  return result;
}
