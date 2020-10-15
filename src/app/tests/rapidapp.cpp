#include "module/feature.h"

#include "gtest/gtest.h"
#include <rapidcheck/gtest.h>

using namespace ::testing;

/*
Rapidcheck example with Gtest - note: does not show in TestMate
*/
// If you don't have any arguments, you have to have empty parentheses
RC_GTEST_PROP(RapidcheckTest, inRangeValueIsInRange, ()) {
  const auto range = *rc::gen::arbitrary<std::pair<int, int>>();
  const auto x = *rc::gen::inRange(range.first, range.second);
  RC_ASSERT(x >= range.first);
  RC_ASSERT(x < range.second);
}