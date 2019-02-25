# CARAssetsAnalyzer

![Screenshot](https://github.com/longhorn499/CARAssetsAnalyzer/raw/master/screenshot.png)  

There are several great plugins and posts for how to analyze `Assets.car` from your App's `.ipa`.

https://blog.timac.org/2018/1112-quicklook-plugin-to-visualize-car-files/

https://blog.timac.org/2018/1018-reverse-engineering-the-car-file-format/

https://github.com/tinymind/LSUnusedResources - for finding unused assets in your Xcode project, which is what I was trying to do in the first place (find unused + large assets)

I wanted to see all the images from my project with size info and show how they would appear on device without constraints.

## How To

First you need to generate the `.ipa` for your App, there's info from Apple on how to do this: https://developer.apple.com/library/archive/qa/qa1795/_index.html

Or if you use fastlane: https://docs.fastlane.tools/actions/gym/

By changing the extension from `.ipa` to `.zip`, extracting, and opening package contents for your App, you can find your assets, frameworks, storyboards, etc.

Once you have the `Assets.car` file for your assets, save the ouptut below to a `.json` file

```sh
assetutil -I Assets.car > assets.json`
```

In this Xcode project, replace the info in `assets.json` with wht was generated, add / duplicate the assets from your project here -> run. There's probably an obvious/automated/better way to do this. If you know of one let me know :sunglasses:
