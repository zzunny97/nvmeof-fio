NODE=$1  # SSD NUMBER

for i in 1 2
do
	ssh eternity$i rm -rf /mnt-nvmeof/nvme$NODE/*
	ssh eternity$i mkdir -p /mnt-nvmeof/nvme$NODE/fiotest
	ssh eternity$i mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/rand_read
	ssh eternity$i mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/rand_write
	ssh eternity$i mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/seq_read
	ssh eternity$i mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/seq_write
done

for k in 1 2 3 4 5
do
for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/rand_read.sh $TEST_DIR $THREAD_NUM > /home/zzunny/ocfs2_fio_result/trial_$k/eternity$j/rand_read/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/read*
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/write*
	done
done
done

for k in 1 2 3 4 5
do
for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/rand_write.sh $TEST_DIR $THREAD_NUM > /home/zzunny/ocfs2_fio_result/trial_$k/eternity$j/rand_write/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/read*
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/write*
	done
done
done

for k in 1 2 3 4 5
do
for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/seq_read.sh $TEST_DIR $THREAD_NUM > /home/zzunny/ocfs2_fio_result/trial_$k/eternity$j/seq_read/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/read*
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/write*
	done
done
done

for k in 1 2 3 4 5
do
for i in 1 2 4 8 16
do
	THREAD_NUM=$i
	for j in 1 2
	do
		TEST_DIR=/mnt-nvmeof/nvme$NODE/fiotest
		ssh eternity$j sudo /home/zzunny/fio_script/concurrent_fio/seq_write.sh $TEST_DIR $THREAD_NUM > /home/zzunny/ocfs2_fio_result/trial_$k/eternity$j/seq_write/result_$i.txt &
	done
	wait
	for j in 1 2
	do
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/read*
		ssh eternity$j rm -rf /mnt-nvmeof/nvme$NODE/fiotest/write*
	done
done
done
