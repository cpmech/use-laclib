#include <vector>
#include "laclib.h"
#include "./util/doctest_mpi.h"
using namespace std;

MPI_TEST_CASE("testing sparse solver MUMPS (NP2)", 2)
{
    auto mpi = MpiAux::make_new();
    set_num_threads(1);

    auto rhs = vector<double>{8.0, 45.0, -3.0, 3.0, 19.0};
    auto x = vector<double>{0, 0, 0, 0, 0};
    auto x_correct = vector<double>{1, 2, 3, 4, 5};

    bool onebased = true;
    std::unique_ptr<SparseTriplet> trip;
    trip = SparseTriplet::make_new(5, 5, 13, onebased);
    trip->put(0, 0, +1.0); // << duplicated
    trip->put(0, 0, +1.0); // << duplicated
    trip->put(1, 0, +3.0);
    trip->put(0, 1, +3.0);
    trip->put(2, 1, -1.0);
    trip->put(4, 1, +4.0);
    trip->put(1, 2, +4.0);
    trip->put(2, 2, -3.0);
    trip->put(3, 2, +1.0);
    trip->put(4, 2, +2.0);
    trip->put(2, 3, +2.0);
    trip->put(1, 4, +6.0);
    trip->put(4, 4, +1.0);

    auto options = MumpsOptions::make_new();
    auto solver = SolverMumps::make_new(mpi, options);
    CHECK(solver.get()->factorized == false);

    solver->analyze_and_factorize(trip);
    CHECK(solver.get()->analyzed == true);
    CHECK(solver.get()->factorized == true);

    solver->solve(x, rhs);
    CHECK(equal_vectors_tol(x, x_correct, 1e-14) == true);
}
