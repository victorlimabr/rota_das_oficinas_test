import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_2/game_of_life_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_2/game_of_life_state.dart';
import 'package:rota_das_oficinas_test/ui/common/amount_picker.dart';

class GameOfLifePage extends StatelessWidget {
  const GameOfLifePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conway: Jogo da Vida')),
      body: Center(
        child: BlocProvider(
          create: (context) => GameOfLifeBloc(),
          child: BlocBuilder<GameOfLifeBloc, GameOfLifeState>(
            builder: (context, state) => _gameContent(state, context),
          ),
        ),
      ),
    );
  }

  Column _gameContent(GameOfLifeState state, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Text('Número de linhas'),
                _heightControl(state, context),
              ],
            ),
            const SizedBox(width: 32),
            Column(
              children: [
                const Text('Número de colunas'),
                _widthControl(state, context),
              ],
            ),
          ],
        ),
        SizedBox(
          width: state.width.value * 40,
          height: state.height.value * 40,
          child: _gridView(state),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _playPauseButton(state, context),
              const SizedBox(width: 32),
              IconButton.filledTonal(
                onPressed: () => context.gameBloc.nextGeneration(),
                icon: const Icon(Icons.skip_next_rounded, size: 40),
              )
            ],
          ),
        )
      ],
    );
  }

  GridView _gridView(GameOfLifeState state) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: state.width.value,
      ),
      itemCount: state.width.value * state.height.value,
      itemBuilder: (context, index) => _toggleCell(index, state, context),
    );
  }

  ToggleButtons _toggleCell(
      int index, GameOfLifeState state, BuildContext context) {
    final line = index ~/ state.width.value;
    final column = index % state.width.value;
    final isSelected = state.cells[line][column];
    return ToggleButtons(
      isSelected: [isSelected],
      renderBorder: false,
      onPressed: (_) {
        if (state.playing) return;
        context.gameBloc.toggleCell(line, column);
      },
      constraints: const BoxConstraints(
        maxWidth: 40,
        maxHeight: 40,
      ),
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
        )
      ],
    );
  }

  IconButton _playPauseButton(GameOfLifeState state, BuildContext context) {
    return IconButton.filled(
      onPressed: state.playing
          ? () => context.gameBloc.pause()
          : () => context.gameBloc.play(),
      icon: Icon(
        state.playing ? Icons.pause : Icons.play_arrow,
        size: 40,
      ),
    );
  }

  AmountPicker _widthControl(GameOfLifeState state, BuildContext context) {
    return AmountPicker(
      input: state.width,
      minLimit: 10,
      onIncrement:
          state.playing ? null : () => context.gameBloc.incrementWidth(),
      onDecrement:
          state.playing ? null : () => context.gameBloc.decrementWidth(),
    );
  }

  AmountPicker _heightControl(GameOfLifeState state, BuildContext context) {
    return AmountPicker(
      input: state.height,
      minLimit: 10,
      onIncrement:
          state.playing ? null : () => context.gameBloc.incrementHeight(),
      onDecrement:
          state.playing ? null : () => context.gameBloc.decrementHeight(),
    );
  }
}

extension on BuildContext {
  GameOfLifeBloc get gameBloc => read<GameOfLifeBloc>();
}
