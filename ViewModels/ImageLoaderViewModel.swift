import Foundation
import Combine

class ImageLoaderViewModel: ObservableObject
{
	let dataService = ImageModelDataService.instance

	var cancellables = Set<AnyCancellable>()
	
	@Published var images: [ImageModel] = []

	init()
	{
		// Subscribe to dataservice
		
		dataService.$images
		.sink { [weak self] images in self?.images = images }
		.store(in: &cancellables)
	}
}
