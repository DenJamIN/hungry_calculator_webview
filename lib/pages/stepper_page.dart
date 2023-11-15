import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_calculator/widget/group_widget.dart';
import 'package:hungry_calculator/widget/receipt_widget.dart';

import '../widget/confirm_receipts_widget.dart';
import '../widget/split_widget.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key}) : super(key: key);

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  List<String> groups = [];
  List<Map<String, dynamic>> items = [];
  Map<String, List<Map<String, dynamic>>> receipts = {};

  int activeStep = 0;
  int reachedStep = 0;
  int upperBound = 3;
  Set<int> reachedSteps = <int>{0, 1, 2, 3};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              steps(),
              const SizedBox(height: 40),
              content(),
            ],
          ),
        ),
      ),
    );
  }

  Widget steps() {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: _previousStep(StepEnabling.sequential)),
          Expanded(
            flex: 15,
            child: EasyStepper(
              activeStep: activeStep,
              maxReachedStep: reachedStep,
              lineStyle: LineStyle(
                lineLength: 100,
                lineSpace: 4,
                lineType: LineType.normal,
                unreachedLineColor: Colors.grey.withOpacity(0.5),
                finishedLineColor: const Color.fromRGBO(46, 46, 229, 100),
                activeLineColor: Colors.grey.withOpacity(0.5),
              ),
              activeStepBorderColor: const Color.fromRGBO(46, 46, 229, 100),
              activeStepIconColor: const Color.fromRGBO(46, 46, 229, 100),
              activeStepTextColor: const Color.fromRGBO(46, 46, 229, 100),
              activeStepBackgroundColor: Colors.white,
              unreachedStepBackgroundColor: Colors.grey.withOpacity(0.5),
              unreachedStepBorderColor: Colors.grey.withOpacity(0.5),
              unreachedStepIconColor: Colors.grey,
              unreachedStepTextColor: Colors.grey.withOpacity(0.5),
              finishedStepBackgroundColor:
              const Color.fromRGBO(46, 46, 229, 100),
              finishedStepBorderColor: Colors.grey.withOpacity(0.5),
              finishedStepIconColor: Colors.white,
              finishedStepTextColor: const Color.fromRGBO(46, 46, 229, 100),
              borderThickness: 10,
              internalPadding: 15,
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  icon: const Icon(CupertinoIcons.group),
                  title: 'Группа',
                  lineText: 'Создание группы',
                  enabled: _allowTabStepping(0, StepEnabling.sequential),
                ),
                EasyStep(
                  icon: const Icon(Icons.document_scanner),
                  title: 'Чек',
                  lineText: 'Заполнение позиций',
                  enabled: _allowTabStepping(1, StepEnabling.sequential),
                ),
                EasyStep(
                  icon:
                  const Icon(CupertinoIcons.arrow_down_right_arrow_up_left),
                  title: 'Счёт',
                  lineText: 'Разделение счёта',
                  enabled: _allowTabStepping(2, StepEnabling.sequential),
                ),
                EasyStep(
                  icon: const Icon(CupertinoIcons.money_dollar),
                  title: 'Готово',
                  enabled: _allowTabStepping(3, StepEnabling.sequential),
                ),
              ],
              onStepReached: (index) =>
                  setState(() {
                    activeStep = index;
                  }),
            ),
          ),
          Expanded(flex: 1, child: _nextStep(StepEnabling.sequential)),
        ],
      ),
    );
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  /// Returns the next button.
  Widget _nextStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep < upperBound) {
          setState(() {
            if (enabling == StepEnabling.sequential) {
              ++activeStep;
              if (reachedStep < activeStep) {
                reachedStep = activeStep;
              }
            } else {
              activeStep =
                  reachedSteps.firstWhere((element) => element > activeStep);
            }
          });
        }
      },
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() =>
          enabling == StepEnabling.sequential
              ? --activeStep
              : activeStep =
              reachedSteps.lastWhere((element) => element < activeStep));
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget content() {
    if (activeStep == 0) {
      return group();
    }

    if (activeStep == 1) {
      return receipt();
    }

    if (activeStep == 2) {
      return splitReceipt();
    }

    if (activeStep == 3) {
      return done();
    }

    return Container();
  }

  Widget group() {
    return SizedBox(width: 400, height: 500, child: GroupWidget(groups: groups));
  }

  Widget receipt() {
    return SizedBox(width: 400, height: 500, child: ReceiptScannerWidget(items: items));
  }

  Widget splitReceipt() {
    return SizedBox(width: 400, height: 500, child: GuestSelectionWidget(items: items, groups: groups, receipts: receipts,));
  }

  Widget done() {
    return SizedBox(width: 400, height: 500, child: GuestSummaryWidget(receipts: receipts));
  }
}

enum StepEnabling { sequential }
