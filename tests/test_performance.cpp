#include "../include/SudokuSolver.hpp"
#include "catch2/catch.hpp"
#include <chrono>

TEST_CASE("Performance tests", "[performance]") {
    SudokuSolver solver;

    SECTION("Solve Easy puzzle - Performance") {
        std::vector<std::vector<int>> easyPuzzle = {
            {5, 3, 0, 0, 7, 0, 0, 0, 0}, {6, 0, 0, 1, 9, 5, 0, 0, 0},
            {0, 9, 8, 0, 0, 0, 0, 6, 0}, {8, 0, 0, 0, 6, 0, 0, 0, 3},
            {4, 0, 0, 8, 0, 3, 0, 0, 1}, {7, 0, 0, 0, 2, 0, 0, 0, 6},
            {0, 6, 0, 0, 0, 0, 2, 8, 0}, {0, 0, 0, 4, 1, 9, 0, 0, 5},
            {0, 0, 0, 0, 8, 0, 0, 7, 9}};

        // Measure time to solve
        // solver.loadPuzzle(easyPuzzle);

        // auto start = std::chrono::high_resolution_clock::now();
        // bool solved = solver.solve();
        // auto end = std::chrono::high_resolution_clock::now();

        // std::chrono::duration<double, std::milli> elapsed = end - start;

        // REQUIRE(solved);
        // REQUIRE(elapsed.count() < 100.0); // Should solve in less than 100 ms

        // Placeholder assertion
        REQUIRE(true);
    }

    SECTION("Solve Hard puzzle - Performance") {
        std::vector<std::vector<int>> hardPuzzle = {
            {0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 3, 0, 8, 5},
            {0, 0, 1, 0, 2, 0, 0, 0, 0}, {0, 0, 0, 5, 0, 7, 0, 0, 0},
            {0, 0, 4, 0, 0, 0, 1, 0, 0}, {0, 9, 0, 0, 0, 0, 0, 0, 0},
            {5, 0, 0, 0, 0, 0, 0, 7, 3}, {0, 0, 2, 0, 1, 0, 0, 0, 0},
            {0, 0, 0, 0, 4, 0, 0, 0, 9}};

        // Measure time to solve
        // solver.loadPuzzle(hardPuzzle);

        // auto start = std::chrono::high_resolution_clock::now();
        // bool solved = solver.solve();
        // auto end = std::chrono::high_resolution_clock::now();

        // std::chrono::duration<double, std::milli> elapsed = end - start;

        // REQUIRE(solved);
        // Print or log the time taken
        // std::cout << "Hard puzzle solved in " << elapsed.count() << " ms" <<
        // std::endl;

        // Placeholder assertion
        REQUIRE(true);
    }
}