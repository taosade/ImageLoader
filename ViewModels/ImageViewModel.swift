import Foundation
import SwiftUI
import Combine

class ImageViewModel: ObservableObject
{
	@Published var image: UIImage? = nil

	let model: ImageModel

	private var cancellables = Set<AnyCancellable>()

	init(model: ImageModel)
	{
		self.model = model

		load()
	}

	func load()
	{
		// Check if image is cached

		if let cachedImage = ImageModelCacheManager.instance.get(id: model.id)
		{
			print("Got image from cache")

			image = cachedImage

			return
		}

		// Check if image is saved

		if let savedImage = ImageModelFileManager.instance.get(id: model.id)
		{
			print("Got image from file manager")

			image = savedImage

			// Cache image

			ImageModelCacheManager.instance.set(id: self.model.id, image: savedImage)

			return
		}

		print("Downloading image...")

		guard let url = URL(string: model.url) else { return }

		URLSession.shared.dataTaskPublisher(for: url).map
		{
			(data, response) -> UIImage? in return UIImage(data: data)
		}
		.receive(on: DispatchQueue.main)
		.sink { _ in }
		receiveValue:
		{
			[weak self] image in guard
				let self = self,
				let image = image
			else { return }

			self.image = image

			// Cache image

			ImageModelCacheManager.instance.set(id: self.model.id, image: image)

			// Save image

			ImageModelFileManager.instance.set(id: self.model.id, image: image)
		}
		.store(in: &cancellables)
	}
}
