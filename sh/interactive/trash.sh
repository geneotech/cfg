cpu_off() {
	for var in "$@"
	do
		echo 0 | sudo tee /sys/devices/system/cpu/cpu$var/online
	done
}

cpu_on() {
	for var in "$@"
	do
		echo 1 | sudo tee /sys/devices/system/cpu/cpu$var/online
	done
}

stat_cpu() {
	for var in "$@"
	do
		cat /sys/devices/system/cpu/cpu$var/online
	done
}

inst_mali() {
	pushd /usr/include
	sudo mkdir gl_bak
	sudo cp -r EGL GLES GLES2 GLES3 KHR gl_bak
	popd

	sudo cp -r EGL GLES GLES2 GLES3 KHR /usr/include

	pushd /usr/lib/aarch64-linux-gnu
	sudo mkdir gl_bak
	sudo cp EGL GLES GLES2 GLES3 KHR gl_bak
	popd
}

uninst_mali() {

}
