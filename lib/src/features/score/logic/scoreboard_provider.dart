import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoreBoardProvider =
    StateNotifierProvider<ScoreBoardNotifier, ScoreBoardState>((ref) {
  return ScoreBoardNotifier();
});

@immutable
class PlayerScore {
  final String id;
  final String name;
  final int score;

  const PlayerScore(
      {required this.id, required this.name, required this.score});

  PlayerScore copyWith({int? score}) {
    return PlayerScore(id: id, name: name, score: score ?? this.score);
  }
}

@immutable
class ScoreBoardState {
  final List<PlayerScore> players;
  final String? lastAction;

  const ScoreBoardState({this.players = const [], this.lastAction});

  ScoreBoardState copyWith({List<PlayerScore>? players, String? lastAction}) {
    return ScoreBoardState(
      players: players ?? this.players,
      lastAction: lastAction ?? this.lastAction,
    );
  }
}

class ScoreBoardNotifier extends StateNotifier<ScoreBoardState> {
  ScoreBoardNotifier() : super(const ScoreBoardState());

  void addPlayer(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final player = PlayerScore(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: trimmed,
      score: 0,
    );

    state = state.copyWith(
      players: [...state.players, player],
      lastAction: 'Joueur ${player.name} ajouté.',
    );
  }

  void adjustScore(String id, int delta) {
    if (delta == 0) return;
    final players = state.players;
    if (players.where((player) => player.id == id).isEmpty) return;

    final updated = players
        .map((player) => player.id == id
            ? player.copyWith(score: player.score + delta)
            : player)
        .toList();

    final playerName = players.firstWhere((player) => player.id == id).name;

    state = state.copyWith(
      players: updated,
      lastAction: '${delta > 0 ? '+' : ''}$delta pts pour $playerName.',
    );
  }

  void removePlayer(String id) {
    final players = state.players;
    final existing = players.where((player) => player.id == id).toList();
    if (existing.isEmpty) return;
    final updated = players.where((player) => player.id != id).toList();
    state = state.copyWith(
      players: updated,
      lastAction: 'Joueur ${existing.first.name} supprimé.',
    );
  }

  void resetBoard() {
    state = const ScoreBoardState(lastAction: 'Tableau réinitialisé.');
  }
}
