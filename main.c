#include <assert.h>
#include <stdint.h>
#include <stdio.h>

// Assume division is defined elsewhere
extern int64_t division(int64_t *x, size_t n, int64_t y);

void run_test(size_t n, int64_t *x, int64_t y, int64_t *expected_quotient, int64_t expected_remainder) {
    int64_t remainder = division(x, n, y);
    for (size_t i = 0; i < n; i++)
        assert(x[i] == expected_quotient[i]);
    assert(remainder == expected_remainder);
}

int main() {
    // Test cases
    // {n, (int64_t[x]), y, (int64_t[expected_quotient]), expected_remainder}

    int64_t test1[] = {13};
    int64_t expected1[] = {2};
    run_test(1, test1, 5, expected1, 3);

    int64_t test2[] = {-13};
    int64_t expected2[] = {-2};
    run_test(1, test2, 5, expected2, -3);

    int64_t test3[] = {13};
    int64_t expected3[] = {-2};
    run_test(1, test3, -5, expected3, 3);

    int64_t test4[] = {-13};
    int64_t expected4[] = {2};
    run_test(1, test4, -5, expected4, -3);

    int64_t test5[] = {0, 13};
    int64_t expected5[] = {0x9999999999999999, 2};
    run_test(2, test5, 5, expected5, 3);

    int64_t test6[] = {0, -13};
    int64_t expected6[] = {0x6666666666666667, -3};
    run_test(2, test6, 5, expected6, -3);

    int64_t test7[] = {0, 13};
    int64_t expected7[] = {0x6666666666666667, -3};
    run_test(2, test7, -5, expected7, 3);

    int64_t test8[] = {0, -13};
    int64_t expected8[] = {0x9999999999999999, 2};
    run_test(2, test8, -5, expected8, -3);

    int64_t test9[] = {1, 1, 1};
    int64_t expected9[] = {0x8000000000000000, 0x8000000000000000, 0};
    run_test(3, test9, 2, expected9, 1);

    int64_t test10[] = {0};
    int64_t expected10[] = {0};
    run_test(1, test10, 1, expected10, 0);

    int64_t test11[] = {INT64_MAX};
    int64_t expected11[] = {INT64_MAX};
    run_test(1, test11, 1, expected11, 0);

    int64_t test12[] = {1};
    int64_t expected12[] = {1};
    // Uncomment to test division by zero (this should raise SIGFPE)
    // run_test(1, test12, 0, expected12, 0);

    int64_t test13[] = {INT64_MIN};
    int64_t expected13[] = {INT64_MAX};
    // Uncomment to test overflow (this should raise SIGFPE)
    // run_test(1, test13, -1, expected13, 0);

    printf("All tests passed!\n");
    return 0;
}
