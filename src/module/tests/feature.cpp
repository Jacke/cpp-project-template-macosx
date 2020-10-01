#include "module/feature.h"

#include "gtest/gtest.h"
#include <rapidcheck/gtest.h>

using namespace ::testing;

/*
Gtest example
*/
TEST(FeatureTest, run) {
  Module::Feature feature;
  EXPECT_EQ(feature.run(2, 10), 12);
  EXPECT_EQ(feature.run(20, 10), 200);
}

/*
Rapidcheck example
*/
// If you don't have any arguments, you have to have empty parentheses
RC_GTEST_PROP(MyTestCase, inRangeValueIsInRange, ()) {
  const auto range = *rc::gen::arbitrary<std::pair<int, int>>();
  const auto x = *rc::gen::inRange(range.first, range.second);
  RC_ASSERT(x >= range.first);
  RC_ASSERT(x < range.second);
}