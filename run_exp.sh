#!/bin/bash

set +x

dir=$(pwd)

mkdir -p ${dir}/output

for n in {3..6}; do
    echo "INFO: running with ${n} agents."
    cd ${dir}/build
    git checkout exp_n${n}
    echo "INFO: compiling.."
    make -j4
    cd ${dir}/build/src/HyP_examples/ma_rock_sample
    echo "INFO: running n=7, k=8"
    ./hyp_despot_mars --size 7 --number 8 --runs 100 -d 25 -g 0.95 -t 15 -r 1337 -s 40 -v 0 --explore 0 --exp true | tee ${dir}/output/exp_n${n}_7_8.tee.log
    echo "INFO: done with n=7, k=8"
    echo "INFO: running n=11, k=11"
    ./hyp_despot_mars --size 11 --number 11 --runs 100 -d 25 -g 0.95 -t 15 -r 1337 -s 40 -v 0 --explore 0 --exp true | tee ${dir}/output/exp_n${n}_11_11.tee.log
    echo "INFO: done with n=11, k=11"
done

echo "Done."
