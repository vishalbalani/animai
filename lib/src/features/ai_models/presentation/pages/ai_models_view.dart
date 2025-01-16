import 'package:animai/src/features/ai_models/presentation/widgets/ai_models_data.dart';
import 'package:animai/src/features/ai_models/presentation/widgets/featured_template_card.dart';
import 'package:animai/src/features/ai_models/presentation/widgets/other_templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiModelsView extends StatefulWidget {
  const AiModelsView({super.key});

  @override
  State<AiModelsView> createState() => _AiModelsViewState();
}

class _AiModelsViewState extends State<AiModelsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = AiModelsData.mainAiModels(context)[0];
    final otherModels = AiModelsData.otherAiModels;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Featured Template with fade animation
          SliverFadeTransition(
            opacity: _fadeInAnimation,
            sliver: SliverToBoxAdapter(
              child: FeaturedTemplateCard(model: mainModel),
            ),
          ),

          // Other templates with staggered animations
          ...otherTemplates(context, otherModels, _controller),

          SliverPadding(padding: EdgeInsets.only(bottom: 16.h)),
        ],
      ),
    );
  }
}
