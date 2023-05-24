#!/bin/bash

set +x

dir=$(pwd)
output_dir=${dir}/output-supp

mkdir -p ${output_dir}

cp run_exp.sh ${output_dir}/

for n in {3..6}; do
    echo "INFO: running with ${n} agents."
    cd ${dir}/build
    git checkout exp_n${n}
    echo "INFO: compiling.."
    make -j4
    cd ${dir}/build/src/HyP_examples/ma_rock_sample
    echo "INFO: running n=7, k=8"
    bash -c 'ulimit -St 20000 -v 16000000 ; ./hyp_despot_mars --size 7 --number 8 --runs 100 -d 25 -g 0.95 -t 5 -r 1337 -s 40 -v 0 --silence --max-policy-simlen 25 --exp 1 --explore 0' | tee ${output_dir}/exp_n${n}_7_8.tee.log &
    # echo "INFO: done with n=7, k=8"
    echo "INFO: running n=11, k=11"
    bash -c 'ulimit -St 20000 -v 16000000 ; ./hyp_despot_mars --size 11 --number 11 --runs 100 -d 25 -g 0.95 -t 5 -r 1337 -s 40 -v 0 --silence --max-policy-simlen 25 --exp 1 --explore 0' | tee ${output_dir}/exp_n${n}_11_11.tee.log &
    # echo "INFO: done with n=11, k=11"
    echo "INFO: running n=15, k=15"
    bash -c 'ulimit -St 20000 -v 16000000 ; ./hyp_despot_mars --size 15 --number 15 --runs 100 -d 25 -g 0.95 -t 5 -r 1337 -s 40 -v 0 --silence --max-policy-simlen 25 --exp 1 --explore 0' | tee ${output_dir}/exp_n${n}_15_15.tee.log &
    echo "INFO: done with $n agents."
    sleep 15
done

wait

echo "Done."
