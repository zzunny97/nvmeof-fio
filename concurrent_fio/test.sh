NODE=$1  # SSD NUMBER

for i in 1 2 4 8 16 
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/eternity$j/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/rand_read.sh $TEST_DIR $THREAD_NUM > /mnt-nvmeof/nvme$NODE/eternity$j/fio_result/rand_read/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/read*
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/write*
	done
done
