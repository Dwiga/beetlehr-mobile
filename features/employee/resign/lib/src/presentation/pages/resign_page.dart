import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../resign.dart';
import '../blocs/blocs.dart';
import '../component/component.dart';

class ResignPage extends StatefulWidget {
  const ResignPage({Key? key}) : super(key: key);

  @override
  _ResignPageState createState() => _ResignPageState();
}

class _ResignPageState extends State<ResignPage> {
  final _bloc = GetIt.I<ResignBloc>();

  @override
  void initState() {
    _bloc.add(FetchResignEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).resign_application),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ResignBloc, ResignState>(
      builder: (context, state) {
        if (state is ResignSuccess) {
          return _SuccessContent(
            data: state.data,
            onRefresh: () => _bloc.add(FetchResignEvent()),
          );
        } else if (state is ResignFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: () => _bloc.add(FetchResignEvent()),
          );
        }
        return _LoadingContent();
      },
    );
  }
}

class _SuccessContent extends StatelessWidget {
  final ResignEntity? data;
  final VoidCallback? onRefresh;
  const _SuccessContent({
    Key? key,
    required this.data,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).message_empty_resign_application),
            const SizedBox(height: Dimens.dp24),
            PrimaryButton(
              onPressed: () => _navigateToAdd(context),
              child: Text(S.of(context).create_resign_application),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () => _navigateToDetail(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
            child: ResignItemCard(
              data: data!,
            ),
          ),
        );
      },
      separatorBuilder: (_, i) {
        return const Divider(height: Dimens.dp24);
      },
      itemCount: 1,
    );
  }

  void _navigateToDetail(BuildContext context) async {
    final result = await Navigator.pushNamed(
        context, '/resign-application/detail',
        arguments: {
          'data': data,
        });
    if (result == true) {
      onRefresh?.call();
    }
  }

  void _navigateToAdd(BuildContext context) async {
    final result =
        await Navigator.pushNamed(context, '/resign-application/add');
    if (result == true) {
      onRefresh?.call();
    }
  }
}

class _LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return const ResignItemSkeleton();
      },
      itemCount: 16,
    );
  }
}

class _FailureContent extends StatelessWidget {
  final String? message;
  final VoidCallback? onRefresh;

  const _FailureContent({Key? key, this.message, this.onRefresh})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ErrorMessageWidget(
        message: message,
        onPress: onRefresh,
      ),
    );
  }
}
