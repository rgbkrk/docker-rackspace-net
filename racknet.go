//

// peekaboo registers the current machine (or provided IP) to a Rackspace load
// balancer, enabling (or disabling) itself.

package main

import (
	"errors"
	"fmt"
	"log"
	"net"
	"strings"
)

// GetIP attempts to determine which IP to work with.
//
// The IP address is determined by, in order:
// * ServiceNet environment variable: $RAX_SERVICENET_IPV4
// * PublicNet environment variable: $RAX_PUBLICNET_IPV4
// * Locating a 10 dot address from the network interfaces, likely ServiceNet.
// * eth0
func GetIP() (string, error) {
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return "", err
	}

	for _, addr := range addrs {
		cidr := addr.String()
		ip := strings.Split(cidr, "/")[0]

		if strings.HasPrefix(ip, "10.") {
			return ip, nil
		}
	}

	// Find eth0
	eth0, err := net.InterfaceByName("eth0")
	if err != nil {
		return "", fmt.Errorf("trouble finding eth0: %v", err)
	}

	addrs, err = eth0.Addrs()
	if err != nil {
		return "", err
	}

	for _, addr := range addrs {
		cidr := addr.String()
		ip := strings.Split(cidr, "/")[0]

		// Pick out IPv4
		if strings.ContainsRune(ip, '.') {
			return ip, err
		}
	}

	return "", errors.New("no IP found")
}

func main() {
	var err error

	// Determine the IP Address
	nodeAddress, err := GetIP()
	if err != nil {
		log.Fatalf("Unable to determine IP address: %v", err)
	}

	fmt.Println(nodeAddress)

}
