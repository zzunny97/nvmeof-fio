# RANDOM WRITE	
	sudo fio --name=write_iops --directory=$1 --size=25G --numjobs=$2 \
	--time_based --runtime=60s --ramp_time=2s --ioengine=libaio --direct=1 \
	--verify=0 --bs=4K --iodepth=64 --rw=randwrite --group_reporting=1
