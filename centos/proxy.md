proxy() {
	export ALL_PROXY=socks5://10.211.55.2:1080
	echo "ALL Proxy on"
}

disproxy() {
	unset ALL_PROXY
	echo "ALL Proxy off"
}


