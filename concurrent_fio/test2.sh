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
