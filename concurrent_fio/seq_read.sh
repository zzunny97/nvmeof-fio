# SEQUENTIAL READ
	sudo fio --name=read_throughput --directory=$1 --numjobs=$2 \
	--size=25G --time_based --runtime=60s --ramp_time=2s --ioengine=libaio \
	--direct=1 --verify=0 --bs=1M --iodepth=64 --rw=read \
	--group_reporting=1
