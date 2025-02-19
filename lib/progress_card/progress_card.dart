import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomExpansionCard extends StatefulWidget {
  final String sectionTitle;
  final List<String> topics;
  final String userId;

  CustomExpansionCard({required this.sectionTitle, required this.topics, required this.userId});

  @override
  _CustomExpansionCardState createState() => _CustomExpansionCardState();
}

class _CustomExpansionCardState extends State<CustomExpansionCard> with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _progressAnimationCompleted = false;
  Map<String, dynamic> userProgress = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _progressController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _progressAnimationCompleted = true;
      }
    });
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    if (!_progressAnimationCompleted) {
      _progressController.forward();
    }

    _subscribeToUserProgress();
  }

  void _subscribeToUserProgress() {
    FirebaseFirestore.instance
        .collection('userProgress')
        .doc(widget.userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          userProgress = snapshot.data() as Map<String, dynamic>;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = widget.topics.where((topic) {
      String topicKey;
      if (topic == 'Lead Positioning') {
        topicKey = 'completedTopics.leadPositioning';
      } else if (topic == 'Axis Calculation') {
        topicKey = 'completedTopics.axisCalculation';
      } else if (topic == 'QRS Complex') {
        topicKey = 'completedTopics.qrsComplex';
      } else if (topic == 'T-wave') {
        topicKey = 'completedTopics.tWave';
      } else if (topic == 'P-wave') {
        topicKey = 'completedTopics.pWave';
      } else if (topic == 'R-wave') {
        topicKey = 'completedTopics.rWave';
      } else if (topic == 'Q-wave') {
        topicKey = 'completedTopics.qWave';
      } else if (topic == 'S-wave') {
        topicKey = 'completedTopics.sWave';
      } else if (topic == 'J-wave') {
        topicKey = 'completedTopics.jWave';
      } else if (topic == 'PR interval') {
        topicKey = 'completedTopics.prInterval';
      } else if (topic == 'ST segment') {
        topicKey = 'completedTopics.stSegment';
      } else if (topic == 'PR segment') {
        topicKey = 'completedTopics.prSegment';
      } else if (topic == 'QT interval') {
        topicKey = 'completedTopics.qtInterval';
      } else {
        topicKey = 'completedTopics.${topic.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}';
      }
      return userProgress[topicKey] == true;
    }).length;

    double progress = completedCount / widget.topics.length;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade900,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: _toggleExpansion,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(  // Ensure section title doesn't overflow
                          child: Text(
                            widget.sectionTitle,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis, // Avoid text overflow
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return CircularPercentIndicator(
                              radius: 25.0,
                              lineWidth: 3.0,
                              percent: progress * (_progressAnimationCompleted ? 1 : _progressAnimation.value),
                              center: Text(
                                '${(progress * (_progressAnimationCompleted ? 1 : _progressAnimation.value) * 100).toStringAsFixed(0)}%',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              progressColor: Colors.green,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                    SizeTransition(
                      sizeFactor: _animation,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: widget.topics.map((topic) {
                            String topicKey;
                            if (topic == 'Lead Positioning') {
                              topicKey = 'completedTopics.leadPositioning';
                            } else if (topic == 'Axis Calculation') {
                              topicKey = 'completedTopics.axisCalculation';
                            } else if (topic == 'QRS Complex') {
                              topicKey = 'completedTopics.qrsComplex';
                            } else if (topic == 'T-wave') {
                              topicKey = 'completedTopics.tWave';
                            } else if (topic == 'P-wave') {
                              topicKey = 'completedTopics.pWave';
                            } else if (topic == 'R-wave') {
                              topicKey = 'completedTopics.rWave';
                            } else if (topic == 'Q-wave') {
                              topicKey = 'completedTopics.qWave';
                            } else if (topic == 'S-wave') {
                              topicKey = 'completedTopics.sWave';
                            } else if (topic == 'J-wave') {
                              topicKey = 'completedTopics.jWave';
                            } else if (topic == 'PR interval') {
                              topicKey = 'completedTopics.prInterval';
                            } else if (topic == 'ST segment') {
                              topicKey = 'completedTopics.stSegment';
                            } else if (topic == 'PR segment') {
                              topicKey = 'completedTopics.prSegment';
                            } else if (topic == 'QT interval') {
                              topicKey = 'completedTopics.qtInterval';
                            } else {
                              topicKey = 'completedTopics.${topic.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}';
                            }
                            bool isCompleted = userProgress[topicKey] ?? false;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Less padding
                                  visualDensity: VisualDensity.compact, // Makes ListTile shorter

                                  title: Text(
                                    topic,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(
                                    isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: isCompleted ? Colors.green : Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}