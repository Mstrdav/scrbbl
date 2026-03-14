import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/scoreboard_provider.dart';

class ScoreScreen extends ConsumerStatefulWidget {
  const ScoreScreen({super.key});

  @override
  ConsumerState<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends ConsumerState<ScoreScreen> {
  void _showAddDialog(ScoreBoardNotifier notifier) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un joueur'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Nom du joueur'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  notifier.addPlayer(name);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showRenameDialog(PlayerScore player, ScoreBoardNotifier notifier) {
    final controller = TextEditingController(text: player.name);
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Renommer le joueur'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Nouveau nom'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () {
                final newName = controller.text.trim();
                if (newName.isNotEmpty) {
                  notifier.renamePlayer(player.id, newName);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAmountDialog({
    required PlayerScore player,
    required ScoreBoardNotifier notifier,
    required bool positive,
  }) async {
    final controller = TextEditingController(text: '1');
    final result = await showDialog<int?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(positive ? 'Ajouter des points' : 'Soustraire des points'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Valeur à appliquer'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () {
                final value = int.tryParse(controller.text);
                Navigator.of(context).pop(value);
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );

    if (result != null && result != 0) {
      final delta = positive ? result : -result;
      notifier.adjustScore(player.id, delta);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardProvider);
    final notifier = ref.read(scoreBoardProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compteur de points'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Ajouter un joueur',
            onPressed: () => _showAddDialog(notifier),
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Réinitialiser le tableau',
            onPressed: state.players.isEmpty ? null : notifier.resetBoard,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: state.players.isEmpty
            ? _buildEmptyState()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildPlayersList(state.players, notifier)),
                  const SizedBox(height: 16),
                  Text('Historique',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  _buildHistory(state.history),
                ],
              ),
      ),
    );
  }

  Widget _buildPlayersList(
      List<PlayerScore> players, ScoreBoardNotifier notifier) {
    return ListView.separated(
      itemCount: players.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final player = players[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                        player.name.isEmpty
                            ? '?'
                            : player.name[0].toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => _showRenameDialog(player, notifier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text('${player.score} pts',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => notifier.removePlayer(player.id),
                      tooltip: 'Supprimer',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _ActionButton(
                      icon: Icons.remove_circle_outline,
                      tooltip: '−1',
                      onPressed: () => notifier.adjustScore(player.id, -1),
                      onLongPress: () => _showAmountDialog(
                        player: player,
                        notifier: notifier,
                        positive: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: Icons.add_circle_outline,
                      tooltip: '+1',
                      onPressed: () => notifier.adjustScore(player.id, 1),
                      onLongPress: () => _showAmountDialog(
                        player: player,
                        notifier: notifier,
                        positive: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistory(List<String> entries) {
    if (entries.isEmpty) {
      return const Text('Aucune action enregistrée.');
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 160),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Divider(height: 12),
        itemBuilder: (context, index) {
          return Text(entries[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.timer, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aucun compteur pour l’instant.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Ajoute ton premier joueur avec le + en haut à droite',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.onLongPress,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }
}
