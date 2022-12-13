import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../services/api_client.dart';
import '../providers/common/github_access_token.dart';
import '../utils/exceptions/base.dart';

final issueRepositoryProvider = Provider.autoDispose(
  (ref) => IssueRepository(
    client: ref.read(apiClientProvider),
    accessToken: ref.read(gitHubAccessTokenProvider),
  ),
);

class IssueRepository {
  IssueRepository({
    required ApiClient client,
    required String accessToken,
  })  : _client = client,
        _accessToken = accessToken;

  final ApiClient _client;
  final String _accessToken;


  
}
