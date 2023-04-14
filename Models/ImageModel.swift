import Foundation

struct ImageModel: Identifiable, Codable
{
	let id: Int
	let albumId: Int
	let title: String
	let url: String
	let thumbnailUrl: String

	static let sample = ImageModel(
		id: 0,
		albumId: 0,
		title: "Image title",
		url: "https://via.placeholder.com/600/92c952",
		thumbnailUrl: "https://via.placeholder.com/600/771796")
}
