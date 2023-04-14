import Foundation
import SwiftUI

class ImageModelFileManager
{
	static let instance = ImageModelFileManager() // Singleton

	private init() { createDirectory() }

	private func createDirectory()
	{
		guard
			let url = getDirectoryURL(),
			!FileManager.default.fileExists(atPath: url.path)
		else { return }

		do
		{
			try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)

			print("Directory created")
		}
		catch let error { print(error.localizedDescription) }
	}

	private func getDirectoryURL() -> URL? // .../downloadedImages
	{
		FileManager
		.default
		.urls(for: .cachesDirectory, in: .userDomainMask)
		.first?
		.appendingPathComponent("downloadedImages")
	}

	private func getImageURL(id: Int) -> URL? // .../downloadedImages/***.png
	{
		guard let directory = getDirectoryURL() else { return nil }

		return directory.appendingPathComponent("\(id).png")
	}

	func get(id: Int) -> UIImage?
	{
		guard
			let url = getImageURL(id: id),
			FileManager.default.fileExists(atPath: url.path)
		else { return nil }

		return UIImage(contentsOfFile: url.path)
	}

	func set(id: Int, image: UIImage)
	{
		guard
			let data = image.pngData(),
			let url = getImageURL(id: id)
		else { return }

		do { try data.write(to: url) }
		catch let error { print(error.localizedDescription) }
	}
}
