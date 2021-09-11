NODE=$1  # SSD NUMBER
rm -rf /mnt-nvmeof/nvme$NODE/fio_result
mkdir -p /mnt-nvmeof/nvme$NODE/fiotest
mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/rand_read
mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/rand_write
mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/seq_read
mkdir -p /mnt-nvmeof/nvme$NODE/fio_result/seq_write

TEST_DIR=/mnt-nvmeof/nvme$NODE/fiotest

# RANDOM READ
for i in 1 2 4 8 16 32
do
	sudo fio --name=read_iops --directory=$TEST_DIR --size=25G --numjobs=$i \
	--time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
	--verify=0 --bs=4K --iodepth=64 --rw=randread --group_reporting=1 > /mnt-nvmeof/nvme$NODE/fio_result/rand_read/result_$i.txt
	sudo rm -rf $TEST_DIR/write* $TEST_DIR/read*
done

# RANDOM WRITE
for i in 1 2 4 8 16 32
do
	sudo fio --name=write_iops --directory=$TEST_DIR --size=25G --numjobs=$i \
	--time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
	--verify=0 --bs=4K --iodepth=64 --rw=randwrite --group_reporting=1 > /mnt-nvmeof/nvme$NODE/fio_result/rand_write/result_$i.txt
	sudo rm -rf $TEST_DIR/write* $TEST_DIR/read*
done

# SEQUENTIAL READ
for i in 1 2 4 8 16 32
do
	sudo fio --name=read_throughput --directory=$TEST_DIR --numjobs=$i \
	--size=25G --time_based --runtime=60s --ramp_time=2s --ioengine=libaio \
	--direct=1 --verify=0 --bs=1M --iodepth=64 --rw=read \
	--group_reporting=1 > /mnt-nvmeof/nvme$NODE/fio_result/seq_read/result_$i.txt
	sudo rm -rf $TEST_DIR/write* $TEST_DIR/read*
done


# SEQUENTIAL WRITE
for i in 1 2 4 8 16 32
do
	sudo fio --name=write_throughput --directory=$TEST_DIR --numjobs=$i \
	--size=25G --time_based --runtime=60s --ramp_time=2s --ioengine=libaio \
	--direct=1 --verify=0 --bs=1M --iodepth=64 --rw=write \
	--group_reporting=1 > /mnt-nvmeof/nvme$NODE/fio_result/seq_write/result_$i.txt
	sudo rm -rf $TEST_DIR/write* $TEST_DIR/read*
done
