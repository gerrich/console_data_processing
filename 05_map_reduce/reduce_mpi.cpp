#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char** argv) {
    int size, rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int localsum[1] = {0};
    int globalsum[1] = {0};

    if (rank > 0) {
        localsum[0] = rank;
    }

    MPI_Reduce(localsum, globalsum, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank==0) {
        printf("globalsum = %d \n", globalsum[0]);
    }

    MPI_Finalize();
    return (EXIT_SUCCESS);
}
