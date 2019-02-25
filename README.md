# CARAssetsAnalyzer

There are several great plugins and posts for how to analyze your `Assets.car` from your App's `.ipa`.

https://blog.timac.org/2018/1112-quicklook-plugin-to-visualize-car-files/
https://blog.timac.org/2018/1018-reverse-engineering-the-car-file-format/

https://github.com/tinymind/LSUnusedResources - for finding unused assets in your Xcode project, which is what I was trying to do in the first place (find unused + large assets)

I also wanted to see all the images from my project with size info and show how they would appear on device without constraints.

## How To

First you need to generate the `.ipa` for your App, there's info on how to do that here: https://developer.apple.com/library/archive/qa/qa1795/_index.html

Or if you use fastlane: https://docs.fastlane.tools/actions/gym/

Once you have the `.car` file for your assets, save the ouptut below to a `.json` file

`assetutil -I Assets.car > assets.json`

In the Xcode project from here, replace the info in `assets.json`, add the assets from your project and run. There may be a more obvious / automated/ better way to do this. If you know of one let me know :sunglasses:

![Screenshot](https://github.com/longhorn499/CARAssetsAnalyzer/raw/master/screenshot.png)  
