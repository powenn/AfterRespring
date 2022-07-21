// https://hbang.github.io/libcephei/Classes/HBPreferences.html
import Cephei

class Preferences {
	static let shared = Preferences()
	
	private let preferences               = HBPreferences(identifier: "com.powen.afterrespring")
	private(set) var enabled: ObjCBool    = false

	private init() { // various cephei stuff
		preferences.register(defaults: [
            "enabled"    : false
		])
	
		preferences.register(_Bool: &enabled, default: false, forKey: "enabled")
	}
}
