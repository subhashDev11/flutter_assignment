import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/number.dart';
import '../../providers/repo/search_repo.dart';
import '../../utils/timer.dart';

class RepoPageTextField extends StatefulHookConsumerWidget {
  const RepoPageTextField({super.key});

  @override
  ConsumerState<RepoPageTextField> createState() => _RepoPageTextFieldState();
}

class _RepoPageTextFieldState extends ConsumerState<RepoPageTextField> {
  late TextEditingController _textEditingController;
  final debounce = Debounce(duration: minSearchApiCallPeriodDuration);

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchRepoStateNotifierProvider);
    final notifier = ref.read(searchRepoStateNotifierProvider.notifier);
    return TextField(
      controller: _textEditingController,
      onChanged: (q) => debounce.run(
        () => notifier.updateSearchWord(q),
      ),
      maxLines: 1,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          fillColor: const Color.fromARGB(251, 248, 248, 255),
          filled: true,
          hintText: 'Search some user',
          suffixIcon: Visibility(
            visible: state.q.isNotEmpty,
            child: IconButton(
              onPressed: () {
                notifier.updateSearchWord('');
                _textEditingController.text = '';
              },
              icon: const Icon(Icons.close),
            ),
          )),
    );
  }
}
