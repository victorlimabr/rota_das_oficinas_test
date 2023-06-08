import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_2/game_of_life_state.dart';

class GameOfLifeBloc extends Cubit<GameOfLifeState> {
  GameOfLifeBloc() : super(GameOfLifeState.initial());

  Timer? timer;

  void play() {
    emit(state.copyWith(playing: true));
    timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (timer) => nextGeneration(),
    );
  }

  void pause() {
    timer?.cancel();
    emit(state.copyWith(playing: false));
  }

  void incrementWidth() {
    _changeWidth(state.width.value + 1);
  }

  void decrementWidth() {
    _changeWidth(state.width.value - 1);
  }

  void _changeWidth(int width) {
    emit(state.copyWith(
      width: GameOfLifeDimension.dirty(width),
      cells: state.cells.map((line) => [...line, false]).toList(),
    ));
  }

  void incrementHeight() {
    _changeHeight(state.height.value + 1);
  }

  void decrementHeight() {
    _changeHeight(state.height.value - 1);
  }

  void _changeHeight(int height) {
    emit(state.copyWith(
        height: GameOfLifeDimension.dirty(height),
        cells: [...state.cells, List.filled(state.width.value, false)]));
  }

  void toggleCell(int line, int column) {
    emit(state.copyWith(cells: state.cells.toggleCell(line, column)));
  }

  void nextGeneration() {
    var next =
        List.filled(state.height.value, List.filled(state.width.value, false));
    for (var line = 0; line < state.height.value; line++) {
      for (var column = 0; column < state.width.value; column++) {
        var aliveNeighbours = 0;
        for (var i = -1; i < 2; i++) {
          for (var j = -1; j < 2; j++) {
            if ((line + i >= 0 && line + i < state.height.value) &&
                (column + j >= 0 && column + j < state.width.value)) {
              aliveNeighbours += state.cells[line + i][column + j] ? 1 : 0;
            }
          }
        }
        if (state.cells[line][column]) {
          aliveNeighbours--;
        }
        if (state.cells[line][column] && (aliveNeighbours < 2)) {
          next = next.toggleCell(line, column, value: false);
        } else if (state.cells[line][column] && (aliveNeighbours > 3)) {
          next = next.toggleCell(line, column, value: false);
        } else if (!state.cells[line][column] && (aliveNeighbours == 3)) {
          next = next.toggleCell(line, column, value: true);
        } else {
          next = next.toggleCell(
            line,
            column,
            value: state.cells[line][column],
          );
        }
      }
    }
    emit(state.copyWith(cells: next));
  }
}

extension on List<List<bool>> {
  List<List<bool>> toggleCell(int line, int column, {bool? value}) =>
      mapIndexed(
        (i, cellsLine) => cellsLine.mapIndexed((j, cell) {
          if (line == i && column == j) return value ?? (!cell == true);
          return cell == true;
        }).toList(),
      ).toList();
}
