for i in 1 2 3 4
do
	echo "trial_$i"
	sudo /home/zzunny/fio_script/concurrent_fio/benchmark_ext4.sh 9
	for j in 1 2
	do
		echo "copying"
		mkdir -p /home/zzunny/ocfs2_fio_result/trial_$i/eternity$j
		ssh eternity$j cp -r /mnt-nvmeof/nvme9/fio_result/* /home/zzunny/ocfs2_fio_result/trial_$i/eternity$j
		ssh eternity$j rm -rf /mnt-nvmeof/nvme9/*
		echo "copying complete"
	done
done
