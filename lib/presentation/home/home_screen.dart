import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/core/theme_mode_cubit/theme_mode_cubit.dart';
import 'package:minesweeper/data/repositories/board_repository_impl.dart';
import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/domain/enums/level.dart';
import 'package:minesweeper/presentation/extensions/build_context_extension.dart';
import 'package:minesweeper/presentation/home/cubit/home_screen_cubit.dart';
import 'package:minesweeper/presentation/home/cubit/home_screen_state.dart';
import 'package:minesweeper/presentation/home/widgets/cell_tile.dart';
import 'package:minesweeper/presentation/home/widgets/reset_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeScreenCubit(
          boardRepository: BoardRepositoryImpl(),
        );
      },
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late final HomeScreenCubit cubit;

  final ScrollController mainScrollController = ScrollController();
  final ScrollController boardScrollController = ScrollController();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeScreenCubit>();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.ready();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    mainScrollController.dispose();
    boardScrollController.dispose();
    super.dispose();
  }

  void listener(BuildContext context, HomeScreenState state) {
    switch (state.status) {
      case HomeScreenStatus.initial:
        break;
      case HomeScreenStatus.playing:
        timer?.cancel();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          cubit.addOneSecond();
        });
        break;
      case HomeScreenStatus.ready:
      case HomeScreenStatus.gameOver:
      case HomeScreenStatus.victory:
        timer?.cancel();
        timer = null;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, HomeScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: listener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minesweeper'),
          centerTitle: true,
          actions: [
            _buildThemeModeButton(),
            const SizedBox(width: 24),
          ],
        ),
        body: Scrollbar(
          controller: mainScrollController,
          child: SingleChildScrollView(
            controller: mainScrollController,
            child: Center(
              child: Column(
                children: [
                  const SizedBox.shrink(
                    child: Text('🚩💣😵😎'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildLevelSelector(),
                  ),
                  _buildBoard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeModeButton() {
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return IconButton(
          tooltip: themeMode == ThemeMode.dark
              ? 'Switch to light mode'
              : 'Switch to dark mode',
          onPressed: () {
            context.read<ThemeModeCubit>().toggle();
          },
          icon: Icon(
            themeMode == ThemeMode.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
        );
      },
    );
  }

  Widget _buildLevelSelector() {
    return BlocSelector<HomeScreenCubit, HomeScreenState, Level>(
      selector: (state) => state.level,
      builder: (context, level) {
        return Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: Level.values.map((e) {
            final selected = e == level;
            return ChoiceChip(
              label: Text(e.name.toUpperCase()),
              selected: selected,
              onSelected: (selected) {
                if (selected) {
                  cubit.ready(level: e);
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBoard() {
    return Scrollbar(
      controller: boardScrollController,
      child: SingleChildScrollView(
        controller: boardScrollController,
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: context.appColors.background,
            border: buildOutSideBorder(width: 6),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withValues(alpha: 0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: buildInSideBorder(width: 6),
                ),
                child: _buildHeader(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: buildInSideBorder(width: 6),
                ),
                child: _buildMinesweeperGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocSelector<HomeScreenCubit, HomeScreenState, Level>(
      selector: (state) => state.level,
      builder: (context, level) {
        return SizedBox(
          width: level.columns * level.cellSize,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                BlocSelector<HomeScreenCubit, HomeScreenState, int>(
                  selector: (state) => state.flagsLeft,
                  builder: (context, flagsLeft) {
                    return _buildCountText(flagsLeft);
                  },
                ),
                Expanded(
                  child: Center(
                    child:
                        BlocSelector<HomeScreenCubit, HomeScreenState, String>(
                          selector: (state) {
                            switch (state.status) {
                              case HomeScreenStatus.initial:
                              case HomeScreenStatus.ready:
                              case HomeScreenStatus.playing:
                                return '🙂';
                              case HomeScreenStatus.gameOver:
                                return '😵';
                              case HomeScreenStatus.victory:
                                return '😎';
                            }
                          },
                          builder: (context, emoji) {
                            return ResetButton(
                              emoji: emoji,
                              onPressed: () {
                                timer?.cancel();
                                cubit.ready();
                              },
                            );
                          },
                        ),
                  ),
                ),
                BlocSelector<HomeScreenCubit, HomeScreenState, int>(
                  selector: (state) => state.seconds,
                  builder: (context, seconds) {
                    return _buildCountText(seconds);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountText(int value) {
    return Container(
      width: 44,
      color: Colors.black,
      child: Text(
        value.toString().padLeft(3, '0'),
        style: const TextStyle(
          fontSize: 24,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildMinesweeperGrid() {
    return BlocSelector<HomeScreenCubit, HomeScreenState, Level>(
      selector: (state) => state.level,
      builder: (context, level) {
        return SizedBox(
          width: level.columns * level.cellSize,
          child:
              BlocSelector<
                HomeScreenCubit,
                HomeScreenState,
                (bool, List<Cell>)
              >(
                selector: (state) {
                  final absorbing = [
                    HomeScreenStatus.gameOver,
                    HomeScreenStatus.victory,
                  ].contains(state.status);
                  return (absorbing, state.board);
                },
                builder: (context, args) {
                  final (absorbing, board) = args;
                  return AbsorbPointer(
                    absorbing: absorbing,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: level.columns,
                      ),
                      itemCount: board.length,
                      itemBuilder: (context, index) {
                        final cell = board[index];
                        return _buildCell(cell);
                      },
                    ),
                  );
                },
              ),
        );
      },
    );
  }

  Widget _buildCell(Cell cell) {
    return CellTile(
      cell: cell,
      onRevealed: () {
        cubit.onRevealCell(cell);
      },
      onFlagToggled: () {
        cubit.onFlagToggled(cell);
      },
    );
  }

  Border buildInSideBorder({required double width}) {
    return Border(
      top: BorderSide(
        color: context.appColors.borderShadow,
        width: width,
      ),
      left: BorderSide(
        color: context.appColors.borderShadow,
        width: width,
      ),
      right: BorderSide(
        color: context.appColors.borderHighlight,
        width: width,
      ),
      bottom: BorderSide(
        color: context.appColors.borderHighlight,
        width: width,
      ),
    );
  }

  Border buildOutSideBorder({required double width}) {
    return Border(
      top: BorderSide(
        color: context.appColors.borderHighlight,
        width: width,
      ),
      left: BorderSide(
        color: context.appColors.borderHighlight,
        width: width,
      ),
      right: BorderSide(
        color: context.appColors.borderShadow,
        width: width,
      ),
      bottom: BorderSide(
        color: context.appColors.borderShadow,
        width: width,
      ),
    );
  }
}
