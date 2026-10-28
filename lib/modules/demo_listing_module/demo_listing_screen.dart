import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'demo_listing_bloc.dart';
import 'demo_listing_events.dart';
import 'demo_listing_states.dart';

/// Screen for displaying the demo listing.
class DemoListingScreen extends StatelessWidget {
  const DemoListingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Demo listing'),
      actions: [
        IconButton(
          tooltip: 'Refresh list',
          onPressed: () => context.read<DemoListingBloc>().add(
            const DemoListingRefreshRequested(),
          ),
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: BlocBuilder<DemoListingBloc, DemoListingState>(
      builder: (context, state) {
        return switch (state) {
          DemoListingInitial() || DemoListingLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          DemoListingFailure(:final error) => _FailureView(
            message: error.message,
            onRetry: () => context.read<DemoListingBloc>().add(
              const DemoListingRefreshRequested(),
            ),
          ),
          DemoListingLoaded(:final items) when items.isEmpty => const Center(
            child: Text('No items found.'),
          ),
          DemoListingLoaded(:final items) => RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<DemoListingBloc>();
              final completion = bloc.stream.firstWhere(
                (state) =>
                    state is DemoListingLoaded || state is DemoListingFailure,
              );
              bloc.add(const DemoListingRefreshRequested());
              await completion;
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${item.id}')),
                    title: Text(item.title),
                    subtitle: Text(
                      item.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
        };
      },
    ),
  );
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 42),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    ),
  );
}
