#include "gtest/gtest.h"
#include "a.h"

TEST(test1, ttt1) {
    ASSERT_TRUE(1==1);
}

TEST(test1, ttt2) {
    ASSERT_FALSE(1==2);
}

TEST(test, ttt3) {
    ASSERT_TRUE(0==hello());
}
