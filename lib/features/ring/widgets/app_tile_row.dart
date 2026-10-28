import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import 'showcase_row.dart';
import 'showcase_tile.dart';

/// Home-screen style row of app icons with the Velia app in the middle.
class AppTileRow extends StatelessWidget {
  const AppTileRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseRow(
      leading: _SideTile(),
      center: ShowcaseTile(child: _Logo()),
      trailing: _SideTile(),
    );
  }
}

/// Side tiles are the same tile scaled down, so radius and border match.
class _SideTile extends StatelessWidget {
  const _SideTile();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: SizedBox.square(
        dimension: ShowcaseTile.size,
        child: ShowcaseTile(),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.logo,
      width: 112,
      colorFilter: const ColorFilter.mode(Color(0x1FFFFFFF), BlendMode.srcIn),
    );
  }
}
