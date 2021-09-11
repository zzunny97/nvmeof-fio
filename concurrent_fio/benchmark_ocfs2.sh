NODE=$1  # SSD NUMBER

rm -rf /mnt-nvmeof/nvme$NODE/*

for i in 1 2
do
	mkdir -p /mnt-nvmeof/nvme$NODE/eternity$i/fiotest
	mkdir -p /mnt-nvmeof/nvme$NODE/eternity$i/fio_result/rand_read
	mkdir -p /mnt-nvmeof/nvme$NODE/eternity$i/fio_result/rand_write
	mkdir -p /mnt-nvmeof/nvme$NODE/eternity$i/fio_result/seq_read
	mkdir -p /mnt-nvmeof/nvme$NODE/eternity$i/fio_result/seq_write
done


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

for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/eternity$j/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/rand_write.sh $TEST_DIR $THREAD_NUM > /mnt-nvmeof/nvme$NODE/eternity$j/fio_result/rand_write/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/read*
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/write*
	done
done

for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/eternity$j/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/seq_read.sh $TEST_DIR $THREAD_NUM > /mnt-nvmeof/nvme$NODE/eternity$j/fio_result/seq_read/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/read*
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/write*
	done
done

for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/eternity$j/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/seq_write.sh $TEST_DIR $THREAD_NUM > /mnt-nvmeof/nvme$NODE/eternity$j/fio_result/seq_write/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/read*
		rm -rf /mnt-nvmeof/nvme$NODE/eternity$j/fiotest/write*
	done
done
