import SwiftUI

struct RowImageView: View
{
	let model: ImageModel

	var body: some View
	{
		HStack(alignment: .top, spacing: 20)
		{
			ImageView(model: model)

			VStack(alignment: .leading)
			{
				Text(model.title).font(.title2)

				Text(model.url)
				.font(.caption)
				.foregroundColor(.secondary)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}

struct RowImageView_Previews: PreviewProvider
{
	static var previews: some View
	{
		Group
		{
			RowImageView(model: ImageModel.sample)
			.preferredColorScheme(.light)

			RowImageView(model: ImageModel.sample)
			.preferredColorScheme(.dark)
		}
		.previewLayout(.sizeThatFits)
	}
}
