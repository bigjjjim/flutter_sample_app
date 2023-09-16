enum ShirtSize { xs, s, m, l, xl, xxl }

// function to determine size from height and weight
ShirtSize determineShirtSize({required int height, required int weight}) {
  if (height < 150 && weight < 50) return ShirtSize.xs;
  if (height < 160 && weight < 60) return ShirtSize.s;
  if (height < 170 && weight < 70) return ShirtSize.m;
  if (height < 180 && weight < 80) return ShirtSize.l;
  if (height < 190 && weight < 90) return ShirtSize.xl;
  return ShirtSize.xxl;
}
