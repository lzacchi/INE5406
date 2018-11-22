#include <iostream>

#define ITERATIONS 2147483647  // Maximum signed number representation in 32 bits


int main() {
    double x_coordinate, y_coordinate, origin_distance, pi;
    int inside_circle, inside_square = 0;

    srand(time(NULL));  // Seeding the pseudo-number generator.

    for (int i = 0; i < ITERATIONS; ++i) {
        x_coordinate = double(rand() % ITERATIONS) / ITERATIONS;
        y_coordinate = double(rand() % ITERATIONS) / ITERATIONS;

        origin_distance = x_coordinate * x_coordinate + y_coordinate * y_coordinate;

        if (origin_distance <= 1) {
            ++inside_circle;
        }
        ++inside_square;

        pi = double(4 * inside_circle)/inside_square;
        std::cout <<"\nIteration nº: " << i << ": Parcial estimation of pi: " << pi <<"\n";
    }

    std::cout << "\nFinal estimation of pi = " << pi;
    return 0;
}







