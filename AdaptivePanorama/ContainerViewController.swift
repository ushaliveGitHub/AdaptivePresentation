/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ContainerViewController: UIViewController {
  var panorama: Panorama?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let panorama = panorama {
      title = panorama.title

      if let child = self.childViewControllers.first as? ImageViewController {
        child.title = panorama.title
        child.imageName = panorama.imageName
      }
    }
  }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    guard let child = self.childViewControllers.first as? ImageViewController else { return }

        let currentOverride = overrideTraitCollection(forChildViewController: child)
        if !traitCollection.containsTraits(in: currentOverride) {
      setOverrideTraitCollection(nil, forChildViewController: child)
    }
  }

  @IBAction func toggleImageMode(sender: AnyObject) {
    guard let child = self.childViewControllers.first as? ImageViewController else { return }
    
    let overrideTraitCollection = UITraitCollection(verticalSizeClass: child.traitCollection.verticalSizeClass == .compact ? .regular : .compact)
    setOverrideTraitCollection(overrideTraitCollection, forChildViewController: child)
    child.view.setNeedsLayout()
  }
}
