import SwiftUI

struct ImageView: View
{
	@StateObject var vm: ImageViewModel

	init(model: ImageModel)
	{
		_vm = StateObject(wrappedValue: ImageViewModel(model: model))
	}

	var body: some View
	{
		ZStack
		{
			Circle().foregroundColor(.secondary)

			if let image = vm.image
			{
				Image(uiImage: image)
				.resizable()
				.clipShape(Circle())
			}
			else { ProgressView() }
		}
		.frame(width: 80, height: 80)
	}
}

struct ImageView_Previews: PreviewProvider
{
	static var previews: some View
	{
		Group
		{
			ImageView(model: ImageModel.sample)
			.preferredColorScheme(.light)

			ImageView(model: ImageModel.sample)
			.preferredColorScheme(.dark)
		}
		.previewLayout(.sizeThatFits)
	}
}
