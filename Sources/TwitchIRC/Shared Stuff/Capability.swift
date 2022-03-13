
/// Additional capabilities you can ask from Twitch.
public enum Capability: CaseIterable {
    case membership
    case tags
    case commands
    /// At this time there are no capabilities other than the 3 above,
    /// this is just a fallback if Twitch adds a new capability someday.
    case unknown(String)
    
    public static var allCases: [Self] = [
        .membership,
        .tags,
        .commands
    ]
    
    var twitchDescription: String {
        switch self {
        case .membership: return "twitch.tv/membership"
        case .tags: return "twitch.tv/tags"
        case .commands: return "twitch.tv/commands"
        case let .unknown(string): return string
        }
    }
}

// MARK: - Sendable conformance
#if swift(>=5.5)
extension Capability: Sendable { }
#endif
