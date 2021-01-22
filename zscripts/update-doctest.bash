#!/bin/bash

curl https://raw.githubusercontent.com/onqtam/doctest/master/doctest/doctest.h -o ./src/util/doctest.h
curl https://raw.githubusercontent.com/onqtam/doctest/master/doctest/extensions/doctest_mpi.h -o ./src/util/doctest_mpi.h
curl https://raw.githubusercontent.com/onqtam/doctest/master/doctest/extensions/mpi_reporter.h -o ./src/util/doctest_mpi_reporter.h

sed -i 's#"doctest/doctest.h"#"doctest.h"#g' ./src/util/doctest_mpi.h
sed -i 's#"mpi_reporter.h"#"doctest_mpi_reporter.h"#g' ./src/util/doctest_mpi.h
