#include "gtest/gtest.h"
#include <rapidcheck/gtest.h>

using namespace ::testing;

/*
Rapidcheck example
*/
// If you don't have any arguments, you have to have empty parentheses
RC_GTEST_PROP(RapidCheckModuleTest, inRangeValueIsInRange, ()) {
  const auto range = *rc::gen::arbitrary<std::pair<int, int>>();
  const auto x = *rc::gen::inRange(range.first, range.second);
  RC_ASSERT(x >= range.first);
  RC_ASSERT(x < range.second);
}