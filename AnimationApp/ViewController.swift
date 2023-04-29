import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labelOutletArray: [UILabel]!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let tableViewArray: [[String]] = [
        ["Apricots",
         "Artichokes",
         "Arugula",
         "Asparagus",
         "Avocados",
         "Basil"],
        ["Beets",
         "Black-eyed Peas",
         "Blood Oranges",
         "Broccoli",
         "Carrots",
         "Cauliflower"],["Beets",
                         "Black-eyed Peas",
                         "Blood Oranges",
                         "Broccoli",
                         "Carrots",
                         "Cauliflower"],
        ["Chard",
         "Cherries",
         "Corn",
         "Cucumber",
         "Eggplant"],
        ["Fava Beans",
         "Fennel",
         "Fiddleheads",
         "Garlic",
         "Figs"],["Fava Beans",
                  "Fennel",
                  "Fiddleheads",
                  "Garlic",
                  "Figs"],["Fava Beans",
                           "Fennel",
                           "Fiddleheads",
                           "Garlic",
                           "Figs"],["Fava Beans",
                                    "Fennel",
                                    "Fiddleheads",
                                    "Garlic",
                                    "Figs"]]
    var collectionDataSource = [
        ("Grapefruits", false),
        ("Green Onions", false),
        ("Kohlrabi", false),
        ("Kumquats",false),
         ("Medjool Dates", false),
          ("Morels",false),
           ("Mushrooms",false),
            ("Navel Oranges Oranges", false)
    ]
    
    var transform = CATransform3DIdentity
    var afflineTransform: CGAffineTransform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLabels()
    }
    
    func animateLabels() {
        transform.m34 = -1.0 / 500.0
        transform = CATransform3DRotate(transform, 90 * CGFloat.pi / 180, 0, 1, 0)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: [.curveEaseInOut] ) {
            self.labelOutletArray[3].layer.transform = self.transform
            self.labelOutletArray[5].layer.transform =  self.transform
        } completion: { bool in
            self.labelOutletArray[3].text = ""
            self.labelOutletArray[5].text = ""
            
            self.labelOutletArray[5].text = "O"
            self.labelOutletArray[5].transform =  .identity
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell
        let vegetable = self.tableViewArray[indexPath.section][indexPath.row]
        cell?.textLabel?.text = vegetable
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70))
        uiview.addSubview(label)
        label.text = self.collectionDataSource[section].0
        return uiview
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        collectionView.scrollToItem(at: IndexPath(item: section, section: 0), at: .centeredHorizontally, animated: false)
        clearAll()
        self.collectionDataSource[section].1 = !self.collectionDataSource[section].1
        collectionView.reloadData()

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as? CollectionCell
        item?.label.text = self.collectionDataSource[indexPath.item].0
        if self.collectionDataSource[indexPath.item].1 {
            item?.label.textColor = .red
        } else {
            item?.label.textColor = .black
        }
        return item ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.item), at: .none, animated: true)
        self.collectionView.reloadSections([indexPath.section])
    }
    
    func clearAll() {
        for i in self.collectionDataSource.indices {
            self.collectionDataSource[i].1 = false
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}


