import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class GameOfLifeState extends Equatable {
  final GameOfLifeDimension width;
  final GameOfLifeDimension height;
  final List<List<bool>> cells;
  final bool playing;

  const GameOfLifeState({
    this.width = const GameOfLifeDimension.pure(),
    this.height = const GameOfLifeDimension.pure(),
    required this.cells,
    this.playing = false,
  });

  GameOfLifeState.initial()
      : this(cells: List.filled(10, List.filled(10, false)));

  @override
  List<Object?> get props => [width, height, cells, playing];

  GameOfLifeState copyWith({
    GameOfLifeDimension? width,
    GameOfLifeDimension? height,
    List<List<bool>>? cells,
    bool? playing,
  }) {
    return GameOfLifeState(
      width: width ?? this.width,
      height: height ?? this.height,
      cells: cells ?? this.cells,
      playing: playing ?? this.playing,
    );
  }
}

enum GameOfLifeDimensionErrorCause { lessThanTen }

class GameOfLifeDimensionError extends FormInputError {
  const GameOfLifeDimensionError.lessThanTen()
      : super(GameOfLifeDimensionErrorCause.lessThanTen);

  @override
  String? get text {
    if (cause == GameOfLifeDimensionErrorCause.lessThanTen) {
      return 'Não pode ser menor que 10';
    }
    return null;
  }
}

class GameOfLifeDimension extends FormzInput<int, GameOfLifeDimensionError> {
  const GameOfLifeDimension.pure() : super.pure(10);

  const GameOfLifeDimension.dirty(super.value) : super.dirty();

  @override
  GameOfLifeDimensionError? validator(int value) {
    if (value < 10) return const GameOfLifeDimensionError.lessThanTen();
    return null;
  }
}
