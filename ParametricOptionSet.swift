import Foundation


enum ParametricOption {
	case owner(String?)
	case receiver(String?)
	case fileName(String?)
	case apiPath(String?)
	case width(CGFloat)
	case mimeType(String?)
}

typealias ParametricOptionsInfo = [ParametricOption]

func == (lhs: ParametricOption, rhs: ParametricOption) -> Bool {
	switch (lhs, rhs) {
	case (.owner(_), .owner(_)) : return true
	case (.receiver(_), .receiver(_)) : return true
	case (.fileName(_), .fileName(_)) : return true
	case (.headerName(_), .headerName(_)) : return true
	case (.apiPath(_), .apiPath(_)) : return true
	case (.width(_), .width(_)) : return true
	case (.mimeType(_), .mimeType(_)) : return true
	default: return false
	}
}

extension CollectionType where Generator.Element == ParametricOption {
	var apiPath: String? {
		if let idx = self.indexOf({
			switch $0 { case .apiPath(_): return true; default: return false } }) {
			if case .apiPath(let path) = self[idx] {
				return path
			}
		}
		return nil
	}
	
	func firstMatchIgnoringValue(target: Generator.Element) -> Generator.Element? {
		return indexOf { $0 == target }.flatMap { self[$0] }
	}
	
	var owner: String? {
		if let item = firstMatchIgnoringValue(.owner(nil)),
			case .owner(let mOwner) = item { return mOwner }
		return nil
	}
	var receiver: String? {
		if let item = firstMatchIgnoringValue(.receiver(nil)),
			case .receiver(let value) = item { return value }
		return nil
	}
	var fileName: String? {
		if let item = firstMatchIgnoringValue(.fileName(nil)),
			case .fileName(let value) = item { return value }
		return nil
	}
	var headerName: String? {
		if let item = firstMatchIgnoringValue(.headerName(nil)),
			case .headerName(let value) = item { return value }
		return nil
	}
	var width: CGFloat? {
		if let item = firstMatchIgnoringValue(.width(0)),
			case .width(let value) = item { return value }
		return nil
	}
	var mimeType: String? {
		if let item = firstMatchIgnoringValue(.mimeType(nil)),
			case .mimeType(let value) = item { return value }
		return nil
	}
}