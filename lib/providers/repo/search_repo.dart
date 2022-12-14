import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/repo/repo.dart';
import '../../models/response_data/search_repo_response/search_repo_response.dart';
import '../../repositories/search_repo.dart';
import '../../utils/api.dart';
import '../../utils/exceptions/api_exceptions.dart';
import 'search_repo_state.dart';

final searchRepoStateNotifierProvider = StateNotifierProvider.autoDispose<SearchRepoStateNotifier, SearchRepoState>(
  (ref) => SearchRepoStateNotifier(ref.read),
);

class SearchRepoStateNotifier extends StateNotifier<SearchRepoState> {
  SearchRepoStateNotifier(this._read) : super(const SearchRepoState()) {
    _searchRepositories();
  }

  final Reader _read;

  final scrollController = ScrollController();

  Future<void> _searchRepositories() async {
    if (state.q.isEmpty) {
      state = state.copyWith(loading: false, error: FetchResponseError.emptyQ);
      return;
    }
    if (state.currentPage < 1) {
      state = state.copyWith(loading: false, error: FetchResponseError.pageNotValid);
      return;
    }
    if (state.perPage < 1) {
      state = state.copyWith(loading: false, error: FetchResponseError.perPageNotValid);
      return;
    }
    try {
      state = state.copyWith(loading: true);
      final response = await _read(searchRepoRepositoryProvider).fetchRepositories(
        q: state.q,
        page: state.currentPage,
        perPage: state.perPage,
      );
      _updateStateByResponse(response);
    } on ApiException {
      state = state.copyWith(error: FetchResponseError.apiError);
    } on Exception {
      state = state.copyWith(error: FetchResponseError.other);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void updateSearchWord(String q) {
    state = state.copyWith(q: q, currentPage: 1, repos: <Repo>[]);
    _resetPagerStatus();
    _animateToTop();
    _searchRepositories();
  }

  void showPreviousPage() {
    if (state.currentPage < 2) {
      return;
    }
    state = state.copyWith(currentPage: state.currentPage - 1);
    _resetPagerStatus();
    _animateToTop();
    _searchRepositories();
  }

  void showNextPage() {
    if (state.currentPage >= state.maxPage) {
      return;
    }
    state = state.copyWith(currentPage: state.currentPage + 1);
    _resetPagerStatus();
    _animateToTop();
    _searchRepositories();
  }

  void _updateStateByResponse(SearchRepoResponse response) {
    state = state.copyWith(
      totalCount: response.totalCount,
      maxPage: (response.totalCount / state.perPage).ceil(),
      repos: response.repos,
    );
    _resetPagerStatus();
  }

  void _resetPagerStatus() {
    state = state.copyWith(
      canShowPreviousPage: state.currentPage > 1,
      canShowNextPage: state.currentPage < state.maxPage,
    );
  }

  void _animateToTop() {
    if (!scrollController.hasClients) {
      return;
    }
    scrollController.animateTo(
      0,
      duration: const Duration(microseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
