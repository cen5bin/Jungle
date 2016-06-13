#include "gtest/gtest.h"

TEST(test1, ttt1) {
    ASSERT_TRUE(1==1);
}

TEST(test1, ttt2) {
    ASSERT_FALSE(1==2);
}
