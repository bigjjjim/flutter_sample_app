import 'package:flutter_test/flutter_test.dart';
import 'package:sample_app/services/shirt_sizes.dart';

void main() {
  test('Should return correct T-shirt size based on height and weight', () {
    expect(determineShirtSize(height: 148, weight: 49), ShirtSize.xs);
    expect(determineShirtSize(height: 155, weight: 58), ShirtSize.s);
    expect(determineShirtSize(height: 165, weight: 68), ShirtSize.m);
    expect(determineShirtSize(height: 175, weight: 78), ShirtSize.l);
    expect(determineShirtSize(height: 185, weight: 88), ShirtSize.xl);
    expect(determineShirtSize(height: 195, weight: 95), ShirtSize.xxl);
  });
}
