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

  PlayerScore copyWith({String? name, int? score}) {
    return PlayerScore(
      id: id,
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }
}

@immutable
class ScoreBoardState {
  final List<PlayerScore> players;
  final List<String> history;

  const ScoreBoardState({this.players = const [], this.history = const []});

  ScoreBoardState copyWith(
      {List<PlayerScore>? players, List<String>? history}) {
    return ScoreBoardState(
      players: players ?? this.players,
      history: history ?? this.history,
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

    _pushHistory('Joueur ${player.name} ajouté.');
    state = state.copyWith(players: [...state.players, player]);
  }

  void adjustScore(String id, int delta) {
    if (delta == 0) return;
    final players = state.players;
    final index = players.indexWhere((player) => player.id == id);
    if (index == -1) return;

    final updatedPlayer =
        players[index].copyWith(score: players[index].score + delta);
    final updated = List<PlayerScore>.from(players)..[index] = updatedPlayer;

    final action = delta > 0
        ? '+$delta pts pour ${updatedPlayer.name}'
        : '$delta pts pour ${updatedPlayer.name}';
    _pushHistory('$action (total ${updatedPlayer.score}).');
    state = state.copyWith(players: updated);
  }

  void renamePlayer(String id, String newName) {
    final players = state.players;
    final index = players.indexWhere((player) => player.id == id);
    if (index == -1) return;

    final updatedPlayer = players[index].copyWith(
        name: newName.trim().isEmpty ? players[index].name : newName.trim());
    final updated = List<PlayerScore>.from(players)..[index] = updatedPlayer;
    _pushHistory(
        'Joueur ${players[index].name} renommé en ${updatedPlayer.name}.');
    state = state.copyWith(players: updated);
  }

  void removePlayer(String id) {
    final players = state.players;
    final index = players.indexWhere((player) => player.id == id);
    if (index == -1) return;
    final removed = players[index];
    final updated = players.where((player) => player.id != id).toList();
    _pushHistory('Joueur ${removed.name} supprimé.');
    state = state.copyWith(players: updated);
  }

  void resetBoard() {
    _pushHistory('Tableau réinitialisé.');
    state = const ScoreBoardState(history: ['Tableau réinitialisé.']);
  }

  void _pushHistory(String entry) {
    final history = [entry, ...state.history];
    if (history.length > 10) history.removeLast();
    state = state.copyWith(history: history);
  }
}
