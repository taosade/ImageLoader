import SwiftUI

struct ImageLoaderView: View
{
	@StateObject var vm = ImageLoaderViewModel()
	
	var body: some View
	{
		NavigationView
		{
			if vm.images.count == 0
			{
				ProgressView()
			}
			else
			{
				List
				{
					ForEach(vm.images)
					{
						image in RowImageView(model: image)
					}
				}
				.navigationTitle("Image List")
			}
		}
	}
}

struct Downloader_Previews: PreviewProvider
{
	static var previews: some View
	{
		ImageLoaderView()
	}
}
