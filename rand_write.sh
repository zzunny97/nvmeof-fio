TEST_DIR=/mnt-nvmeof/nvme8/fiotest
for i in {1,2,4,8,16,32}
do
	sudo fio --name=write_iops --directory=$TEST_DIR --size=10G --numjobs=$i \
	--time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
	--verify=0 --bs=4K --iodepth=64 --rw=randwrite --group_reporting=1 > /mnt-nvmeof/nvme8/fio_result/rand_write/result_$i.txt
	sudo rm $TEST_DIR/write* $TEST_DIR/read*
done
