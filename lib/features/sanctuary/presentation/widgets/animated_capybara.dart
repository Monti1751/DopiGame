import 'package:flutter/material.dart';

class AnimatedCapybara extends StatefulWidget {
  const AnimatedCapybara({Key? key}) : super(key: key);

  @override
  State<AnimatedCapybara> createState() => _AnimatedCapybaraState();
}

class _AnimatedCapybaraState extends State<AnimatedCapybara> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<_Heart> _hearts = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _addHeart() {
    setState(() {
      _hearts.add(_Heart(
        controller: AnimationController(
          duration: const Duration(seconds: 2),
          vsync: this,
        )..forward().then((_) {
            if (mounted) {
              setState(() => _hearts.removeWhere((h) => h.controller.isCompleted));
            }
          }),
        offset: Offset((DateTime.now().millisecond % 100) - 50, -50),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var heart in _hearts) {
      heart.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addHeart,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          ..._hearts.map((heart) => _AnimatedHeart(heart: heart)),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: SizedBox(
                  width: 150,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Body
                      Container(
                        width: 120,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8D6E63), // Capybara brown
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5)),
                          ],
                        ),
                      ),
                      // Head
                      Positioned(
                        right: 15,
                        top: 10,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8D6E63),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      // Nose/Muzzle
                      Positioned(
                        right: 10,
                        top: 25,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6D4C41),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Eye
                      Positioned(
                        right: 35,
                        top: 20,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Ear
                      Positioned(
                        right: 45,
                        top: 5,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6D4C41),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Heart {
  final AnimationController controller;
  final Offset offset;
  _Heart({required this.controller, required this.offset});
}

class _AnimatedHeart extends StatelessWidget {
  final _Heart heart;
  const _AnimatedHeart({required this.heart});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heart.controller,
      builder: (context, child) {
        final double progress = heart.controller.value;
        return Positioned(
          bottom: 50 + progress * 100,
          left: 50 + heart.offset.dx * (1 + progress),
          child: Opacity(
            opacity: 1 - progress,
            child: const Icon(Icons.favorite, color: Colors.redAccent, size: 30),
          ),
        );
      },
    );
  }
}
