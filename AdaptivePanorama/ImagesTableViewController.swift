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

struct Panorama {
  let title: String
  let imageName: String
  let caption: String

  var description: String {
    var returnString = "\(title)\n\n\(caption)"
    if let image = UIImage(named: imageName) {
      returnString += "\n\nImage dimensions: \(image.size)"
    }
    return returnString
  }
}

class ImagesTableViewController: UITableViewController {
  let panoramas = [
    Panorama(title: "Felipe's vista", imageName: "felipe.jpg", caption: "A lovely view from the top of the world in Ecuador."),
    Panorama(title: "Greg on the roof", imageName: "greg.jpg", caption: "Get a feel for the big city from the roof of this downtown Toronto building."),
    Panorama(title: "Jamie's balcony", imageName: "jamie.jpg", caption: "Buildings, blue sky, and a construction crane here in this balcony panorama."),
    Panorama(title: "Marin's balcony", imageName: "marin.jpg", caption: "Marin gets plenty of greenery and scenery from the view off his balcony."),
    Panorama(title: "Matt at the coast", imageName: "matt.jpg", caption: "The UK is not just rainy cities after all. Check out the beach and the birds in this view from the coast."),
  ]
  let panoramaSegueIdentifier = "showPanoramaSegue"
  let randomSegueIdentifier = "randomSegue"

  // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return panoramas.count
  }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as UITableViewCell

    cell.textLabel?.text = panoramas[indexPath.row].title

    return cell
  }

override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let photo = panoramas[indexPath.row]

    let vc = storyboard!.instantiateViewController(withIdentifier: "PhotoInfo") as! PhotoInfoViewController
    vc.photoInfoText = photo.description
    vc.title = photo.title
    vc.popoverPresentationController?.sourceView = tableView
    vc.popoverPresentationController?.sourceRect = tableView.rectForRow(at: indexPath)
    present(vc, animated: true, completion: nil)
  }

  // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == panoramaSegueIdentifier {
        guard let destination = segue.destination as? ContainerViewController,
        let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
      
      let panorama = panoramas[selectedIndexPath.row]
      destination.panorama = panorama
    } else if segue.identifier == randomSegueIdentifier {
        guard let destination = segue.destination as? RandomViewController else { return }
      
      destination.panoramas = panoramas
    }
  }
}
