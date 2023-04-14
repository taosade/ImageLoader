import Foundation
import Combine

class ImageModelDataService
{
	static let instance = ImageModelDataService() // Singleton

	private init()
	{
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
		else { return }

		URLSession.shared.dataTaskPublisher(for: url)
		.subscribe(on: DispatchQueue.global(qos: .background))
		.receive(on: DispatchQueue.main)
		.tryMap(handleOutput)
		.decode(type: [ImageModel].self, decoder: JSONDecoder())
		.sink
		{
			completion in switch completion
			{
				case .finished: break
				case .failure(let error): print(error.localizedDescription)
			}
		}
		receiveValue: { [weak self] images in self?.images = images }
		.store(in: &cancellables)
	}

	@Published var images: [ImageModel] = []

	var cancellables = Set<AnyCancellable>()

	private func handleOutput(_ output: URLSession.DataTaskPublisher.Output) throws -> Data
	{
		guard
			let response = output.response as? HTTPURLResponse,
			(200...299).contains(response.statusCode)
		else { throw URLError(.badServerResponse) }

		return output.data
	}
}
