
public struct Capabilities {
    
    public var capabilities: [Capability] = []
    
    public init() { }
    
    init? (contentRhs: String) {
        guard contentRhs.hasPrefix("* ACK :")
        else { return nil }
        let capabilityStrings = contentRhs.dropFirst(7).components(separatedBy: " ")
        self.capabilities = capabilityStrings.compactMap { capString in
            if let capability = Capability.allCases.first(where: {
                $0.twitchDescription == capString
            }) {
                return capability
            } else {
                return .unknown(String(capString))
            }
        }
    }
}
