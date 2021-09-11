# ssh eternity1 sudo /home/zzunny/fio_script/test.sh 8 &
# ssh eternity2 sudo /home/zzunny/fio_script/test.sh 9 &
ssh eternity1 sudo /home/zzunny/fio_script/real_benchmark.sh 8 &
ssh eternity2 sudo /home/zzunny/fio_script/real_benchmark.sh 8 &
wait
