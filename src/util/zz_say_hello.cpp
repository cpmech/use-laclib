#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"
#include "say_hello.h"

TEST_CASE("say_hello")
{
    CHECK(say_hello() == 0);
}
