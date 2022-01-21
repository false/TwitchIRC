@testable import TwitchIRC
import XCTest

final class IncomingMessagesTests: XCTestCase {
    
    func testFindingCorrectMessageCase() throws {
        
        // globalUserState
        do {
            let string = "@badge-info=subscriber/8;badges=subscriber/6;color=#0D4200;display-name=dallas;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;turbo=0;user-id=1337;user-type=admin :tmi.twitch.tv GLOBALUSERSTATE"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .globalUserState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // privateMessage
        do {
            let string = "@badge-info=;badges=global_mod/1,turbo/1;color=#0D4200;display-name=ronni;emotes=25:0-4,12-16/1902:6-10;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=global_mod :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :Kappa Keepo Kappa"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .privateMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // privateMessage 2
        do {
            let string = "@badge-info=;badges=staff/1,bits/1000;bits=100;color=;display-name=ronni;emotes=;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :cheer100"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .privateMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // join
        do {
            let string = ":ronni!ronni@ronni.tmi.twitch.tv JOIN #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .join: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // part
        do {
            let string = ":ronni!ronni@ronni.tmi.twitch.tv PART #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .part: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat
        do {
            let string = ":tmi.twitch.tv CLEARCHAT #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat 2
        do {
            let string = ":tmi.twitch.tv CLEARCHAT #dallas :ronni"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat 3
        do {
            let string = "@ban-duration=3600 :tmi.twitch.tv CLEARCHAT #goodvibes :toxicity"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearMessage
        do {
            let string = "@login=ronni;target-msg-id=abc-123-def :tmi.twitch.tv CLEARMSG #dallas :HeyGuys"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch 1"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 2
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :- 130"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 3
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 4
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :-"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // notice
        do {
            let string = "@msg-id=slow_off :tmi.twitch.tv NOTICE #dallas :This room is no longer in slow mode."
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .notice: break
            default:
                XCTFail("Wrong messages case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // reconnect
        do {
            let string = ":tmi.twitch.tv RECONNECT"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .reconnect: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // roomState
        do {
            let string = "@emote-only=0;followers-only=0;r9k=0;slow=0;subs-only=0 :tmi.twitch.tv ROOMSTATE #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .roomState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice
        do {
            let string = #"@badge-info=;badges=staff/1,broadcaster/1,turbo/1;color=#008000;display-name=ronni;emotes=;id=db25007f-7a18-43eb-9379-80131e44d633;login=ronni;mod=0;msg-id=resub;msg-param-cumulative-months=6;msg-param-streak-months=2;msg-param-should-share-streak=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Prime;room-id=1337;subscriber=1;system-msg=ronni\shas\ssubscribed\sfor\s6\smonths!;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :tmi.twitch.tv USERNOTICE #dallas :Great stream -- keep it up!"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 2
        do {
            let string = #"@badge-info=;badges=staff/1,premium/1;color=#0000FF;display-name=TWW2;emotes=;id=e9176cd8-5e22-4684-ad40-ce53c2561c5e;login=tww2;mod=0;msg-id=subgift;msg-param-months=1;msg-param-recipient-display-name=Mr_Woodchuck;msg-param-recipient-id=89614178;msg-param-recipient-name=mr_woodchuck;msg-param-sub-plan-name=House\sof\sNyoro~n;msg-param-sub-plan=1000;room-id=19571752;subscriber=0;system-msg=TWW2\sgifted\sa\sTier\s1\ssub\sto\sMr_Woodchuck!;tmi-sent-ts=1521159445153;turbo=0;user-id=13405587;user-type=staff :tmi.twitch.tv USERNOTICE #forstycup"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 3
        do {
            let string = #"@badge-info=;badges=broadcaster/1,subscriber/6;color=;display-name=qa_subs_partner;emotes=;flags=;id=b1818e3c-0005-490f-ad0a-804957ddd760;login=qa_subs_partner;mod=0;msg-id=anonsubgift;msg-param-months=3;msg-param-recipient-display-name=TenureCalculator;msg-param-recipient-id=135054130;msg-param-recipient-user-name=tenurecalculator;msg-param-sub-plan-name=t111;msg-param-sub-plan=1000;room-id=196450059;subscriber=1;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sTenureCalculator!\s;tmi-sent-ts=1542063432068;turbo=0;user-id=196450059;user-type= :tmi.twitch.tv USERNOTICE #qa_subs_partner"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 4
        do {
            let string = #"@badge-info=;badges=turbo/1;color=#9ACD32;display-name=TestChannel;emotes=;id=3d830f12-795c-447d-af3c-ea05e40fbddb;login=testchannel;mod=0;msg-id=raid;msg-param-displayName=TestChannel;msg-param-login=testchannel;msg-param-viewerCount=15;room-id=56379257;subscriber=0;system-msg=15\sraiders\sfrom\sTestChannel\shave\sjoined\n!;tmi-sent-ts=1507246572675;tmi-sent-ts=1507246572675;turbo=1;user-id=123456;user-type= :tmi.twitch.tv USERNOTICE #othertestchannel"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 5
        do {
            let string = #"@badge-info=;badges=;color=;display-name=SevenTest1;emotes=30259:0-6;id=37feed0f-b9c7-4c3a-b475-21c6c6d21c3d;login=seventest1;mod=0;msg-id=ritual;msg-param-ritual-name=new_chatter;room-id=6316121;subscriber=0;system-msg=Seventoes\sis\snew\shere!;tmi-sent-ts=1508363903826;turbo=0;user-id=131260580;user-type= :tmi.twitch.tv USERNOTICE #seventoes :HeyGuys"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userState
        do {
            let string = "@badge-info=;badges=staff/1;color=#0D4200;display-name=ronni;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;mod=1;subscriber=1;turbo=1;user-type=staff :tmi.twitch.tv USERSTATE #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
    }
    
}
