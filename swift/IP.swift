import Foundation

// Obscure magic, thanks https://stackoverflow.com/questions/25626117/how-to-get-ip-address-in-swift
func getLocalIpAddress() -> String? {
    var address: String?
    
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }

    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee

        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) {

            let name = String(cString: interface.ifa_name)
            if name == "en0" || name == "en2" ||
               name == "en3" || name == "en4" || 
               name == "pdp_ip0" || name == "pdp_ip1" ||
               name == "pdp_ip2" || name == "pdp_ip3" {

                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(
                    interface.ifa_addr,
                    socklen_t(interface.ifa_addr.pointee.sa_len),
                    &hostname,
                    socklen_t(hostname.count),
                    nil,
                    socklen_t(0),
                    NI_NUMERICHOST
                )
                address = String(cString: hostname)
            }
        }
    }
    
    freeifaddrs(ifaddr)
    
    return address
}

