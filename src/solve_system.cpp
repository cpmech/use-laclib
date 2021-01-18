#include "laclib.h"
#include "check.h"
using namespace std;

void run(int argc, char **argv)
{
    // allocate mpi
    auto mpi = MpiAux::make_new();
    auto mpi_size = mpi->size();

    // get arguments from command line
    vector<string> defaults{
        "bfwb62", // default matrix_name
        "0",      // default omp_num_threads: 0 means ignore OMP
        "metis",  // default ordering
    };
    auto args = extract_arguments_or_use_defaults(argc, argv, defaults);
    auto matrix_name = args[0];
    auto omp_num_threads = std::atoi(args[1].c_str());
    auto ordering = mumps_string_to_ordering(args[2]);

    // read matrix
    auto filename = "data/" + matrix_name + ".mtx";
    auto onebased = true;
    auto trip = read_matrix_market(filename, onebased);

    // number of threads
    auto ignore_omp = omp_num_threads == 0;
    auto num_threads = ignore_omp ? 1 : omp_num_threads;
    set_num_threads(num_threads);

    // set options
    auto options = MumpsOptions::make_new(trip->symmetric);
    options->omp_num_threads = num_threads;
    options->ordering = ordering;
    options->max_work_memory = 30000 / mpi_size;

    // allocate solver
    auto solver = SolverMumps::make_new(mpi, options);
    auto verbose = true;

    // set right-hand-side and solution vector
    auto rhs = vector<double>(trip->n, 1.0);
    auto x = vector<double>(trip->n, 0.0);

    // solve system
    solver->analyze(trip, verbose);
    solver->factorize(verbose);
    solver->solve(x, rhs, verbose);

    // check results
    check_x(mpi, matrix_name, x);
}

int main(int argc, char **argv)
{
    MPI_Init(&argc, &argv);
    try
    {
        run(argc, argv);
    }
    CATCH_ALL
    MPI_Finalize();
    return 0;
}
