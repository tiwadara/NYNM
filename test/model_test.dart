import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/models/task.dart';

main() {
  group('ResolutionModel Test -', () {
    Resolution resolution = Resolution();

    test('Constructor should load model', () {
      expect(resolution != null, true);
    });

    group('Convert modet to and from json -', () {
      Resolution testModel = Resolution(year: 2020, motto: "test motto");
      Map<String, dynamic> testJson = {"year": 2020, "motto": "test motto"};
      test('expect exact value  when Model is passed  as json', () {
        var newResolutionObjectFromTestJson = Resolution.fromJson(testJson);
        expect(newResolutionObjectFromTestJson.toJson(), testJson);
      });
      test('check if any value in a model is null', () {
        bool isNull = testModel.checkIfAnyIsNull();
        expect(isNull, false);
      });
    });
  });

  group('TaskModel Test -', () {
    Task task = Task();

    test('Constructor should load model', () {
      expect(task != null, true);
    });

    group('Convert model to and from json -', () {
      Task monthlyTestModel = Task(
          done: true,
          name: "test task name",
          description: "test description",
          interval: "MONTHLY");
      Task weeklyTestModel = Task(
          done: true,
          name: "test task name",
          description: "test description",
          interval: "WEEKLY");
      Task dailyTestModel = Task(
          done: true,
          name: "test task name",
          description: "test description",
          interval: "DAILY");
      Map<String, dynamic> testTaskJson = {
        "done": true,
        "name": "test task name",
        "description": "test description",
        "interval": "test Interval"
      };
      test('expect exact value  when Model is passed  as json', () {
        var newTaskObjectFromTestJson = Task.fromJson(testTaskJson);
        expect(newTaskObjectFromTestJson.toJson(), testTaskJson);
      });
      test('check if any value in a model is null', () {
        bool isNull = monthlyTestModel.checkIfAnyIsNull();
        expect(isNull, false);
      });
      test('Interval matches expected Notification Repeat Monthly', () {
        var returnedInterval = monthlyTestModel.getInterval();
        expect(returnedInterval, RepeatInterval.everyMinute);
      });
      test('Interval matches expected Notification Repeat Daily', () {
        var returnedInterval = dailyTestModel.getInterval();
        expect(returnedInterval, RepeatInterval.daily);
      });
      test('Interval matches expected Notification Repeat Weekly', () {
        var returnedInterval = weeklyTestModel.getInterval();
        expect(returnedInterval, RepeatInterval.weekly);
      });
    });
  });
}
