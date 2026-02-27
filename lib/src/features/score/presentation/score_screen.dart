import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/scoreboard_provider.dart';

class ScoreScreen extends ConsumerStatefulWidget {
  const ScoreScreen({super.key});

  @override
  ConsumerState<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends ConsumerState<ScoreScreen> {
  final _nameController = TextEditingController();
  final List<int> _deltaOptions = const [1, 2, 3, 5, 8, 10, 12, 15];
  int _selectedDelta = 5;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addPlayer(ScoreBoardNotifier notifier) {
    final name = _nameController.text;
    if (name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donne un nom au joueur.')),
      );
      return;
    }
    notifier.addPlayer(name);
    _nameController.clear();
  }

  void _resetBoard(ScoreBoardNotifier notifier) {
    notifier.resetBoard();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardProvider);
    final notifier = ref.read(scoreBoardProvider.notifier);

    final bestScore = state.players.isEmpty
        ? 0
        : state.players.map((player) => player.score).reduce(max);
    final leaders = state.players
        .where((player) => player.score == bestScore)
        .map((player) => player.name)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compteur de points'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Réinitialiser le tableau',
            onPressed:
                state.players.isEmpty ? null : () => _resetBoard(notifier),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummary(state, bestScore, leaders),
            const SizedBox(height: 16),
            _buildAddPlayerRow(context, notifier),
            const SizedBox(height: 12),
            _buildDeltaSelector(),
            const SizedBox(height: 16),
            Expanded(
              child: state.players.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      itemCount: state.players.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final player = state.players[index];
                        final isLeader = leaders.contains(player.name);
                        return _buildPlayerTile(player, isLeader, notifier);
                      },
                    ),
            ),
            if (state.lastAction != null) ...[
              const SizedBox(height: 12),
              Text(
                'Dernière action : ${state.lastAction}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(
      ScoreBoardState state, int bestScore, List<String> leaders) {
    final totalPoints =
        state.players.fold<int>(0, (total, player) => total + player.score);
    final leaderLabel = leaders.isEmpty ? 'Pas encore' : leaders.join(' & ');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatChip(label: 'Joueurs', value: state.players.length.toString()),
        _StatChip(label: 'Total', value: '$totalPoints pts'),
        _StatChip(label: 'Leader', value: leaderLabel),
      ],
    );
  }

  Widget _buildAddPlayerRow(BuildContext context, ScoreBoardNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nom du joueur',
              hintText: 'ex. Alice',
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: () => _addPlayer(notifier),
          icon: const Icon(Icons.add),
          label: const Text('Ajouter'),
        ),
      ],
    );
  }

  Widget _buildDeltaSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _deltaOptions.map((delta) {
        return ChoiceChip(
          label: Text('+${delta}'),
          selected: _selectedDelta == delta,
          onSelected: (_) => setState(() => _selectedDelta = delta),
        );
      }).toList(),
    );
  }

  Widget _buildPlayerTile(
    PlayerScore player,
    bool highlight,
    ScoreBoardNotifier notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: highlight ? 6 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: highlight ? colorScheme.primary : Colors.transparent,
          width: highlight ? 1.8 : 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  child: Text(
                    player.name.isEmpty ? '?' : player.name[0].toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            player.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (highlight) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.star,
                                size: 18, color: colorScheme.primary),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('${player.score} pts',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Supprimer',
                  onPressed: () => notifier.removePlayer(player.id),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton.icon(
                  icon: const Icon(Icons.remove),
                  label: Text('-$_selectedDelta'),
                  onPressed: () =>
                      notifier.adjustScore(player.id, -_selectedDelta),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.remove_circle_outline),
                  label: const Text('−1'),
                  onPressed: () => notifier.adjustScore(player.id, -1),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('+1'),
                  onPressed: () => notifier.adjustScore(player.id, 1),
                ),
                const Spacer(),
                FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text('+$_selectedDelta'),
                  onPressed: () =>
                      notifier.adjustScore(player.id, _selectedDelta),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Opacity(
        opacity: 0.6,
        child: Text(
          'Ajoute un joueur pour commencer le suivi des points.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(letterSpacing: 0.5)),
          const SizedBox(height: 2),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
