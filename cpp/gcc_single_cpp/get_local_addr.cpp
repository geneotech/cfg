#include <iostream>     ///< cout
#include <cstring>      ///< memset
#include <errno.h>      ///< errno
#include <sys/socket.h> ///< socket
#include <netinet/in.h> ///< sockaddr_in
#include <arpa/inet.h>  ///< getsockname
#include <unistd.h>     ///< close

#include <string>

std::string get_internal_ip() {
	const char* google_dns_server = "8.8.8.8";
	int dns_port = 53;

	struct sockaddr_in serv;
	int sock = socket(AF_INET, SOCK_DGRAM, 0);

	if (sock < 0)
	{
		return "";
	}

	memset(&serv, 0, sizeof(serv));
	serv.sin_family = AF_INET;
	serv.sin_addr.s_addr = inet_addr(google_dns_server);
	serv.sin_port = htons(dns_port);

	int err = connect(sock, (const struct sockaddr*)&serv, sizeof(serv));

	if (err < 0)
	{
		return "";
	}

	struct sockaddr_in name;
	socklen_t namelen = sizeof(name);
	err = getsockname(sock, (struct sockaddr*)&name, &namelen);

	char buffer[80];
	const char* p = inet_ntop(AF_INET, &name.sin_addr, buffer, 80);

	if (p != NULL)
	{
		return buffer;
	}

	close(sock);
	return "";
}

int main()
{
	std::cout<<get_internal_ip();

}

