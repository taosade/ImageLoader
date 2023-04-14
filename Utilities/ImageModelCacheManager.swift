import Foundation
import SwiftUI

class ImageModelCacheManager
{
	static let instance = ImageModelCacheManager() // Singleton

	private init() {}

	private let cache: NSCache<NSString, UIImage> =
	{
		var cache = NSCache<NSString, UIImage>()

		cache.countLimit = 1000
		cache.totalCostLimit = 1024 * 1024 * 256

		return cache
	}()

	func get(id: Int) -> UIImage?
	{
		return cache.object(forKey: "\(id)" as NSString)
	}

	func set(id: Int, image: UIImage)
	{
		cache.setObject(image, forKey: "\(id)" as NSString)
	}
}
