import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class _ShimmerBox extends StatelessWidget {
  final double width, height;
  final double radius;
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

Widget _shimmerWrap(Widget child) => Shimmer.fromColors(
      baseColor: AppColors.darkCard,
      highlightColor: AppColors.darkSurface,
      child: child,
    );

// ── News card skeleton ────────────────────────────────────────────────────────
class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerWrap(
      ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, __) => const Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ShimmerBox(width: double.infinity, height: 160, radius: 12),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerBox(width: 80, height: 20),
                    SizedBox(height: 8),
                    _ShimmerBox(width: double.infinity, height: 18),
                    SizedBox(height: 6),
                    _ShimmerBox(width: double.infinity, height: 14),
                    SizedBox(height: 4),
                    _ShimmerBox(width: 200, height: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Heritage timeline skeleton ────────────────────────────────────────────────
class HeritageShimmer extends StatelessWidget {
  const HeritageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerWrap(
      ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _ShimmerBox(width: 16, height: 16, radius: 8),
                  SizedBox(height: 4),
                  _ShimmerBox(width: 2, height: 100),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(width: 80, height: 12),
                        SizedBox(height: 8),
                        _ShimmerBox(width: double.infinity, height: 16),
                        SizedBox(height: 6),
                        _ShimmerBox(width: double.infinity, height: 12),
                        SizedBox(height: 4),
                        _ShimmerBox(width: 180, height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Dictionary list skeleton ──────────────────────────────────────────────────
class DictionaryShimmer extends StatelessWidget {
  const DictionaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerWrap(
      ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ShimmerBox(width: 120, height: 20),
              SizedBox(height: 6),
              _ShimmerBox(width: 200, height: 14),
              SizedBox(height: 4),
              _ShimmerBox(width: 180, height: 14),
              SizedBox(height: 10),
              _ShimmerBox(width: double.infinity, height: 1),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Generic error state ───────────────────────────────────────────────────────
class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 64, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
