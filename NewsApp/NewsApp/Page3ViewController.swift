import UIKit
import SegementSlide

class Page3ViewController: UITableViewController, SegementSlideContentScrollViewDelegate, XMLParserDelegate {
    
    //XMLparserのインスタンスを作成
    var parser = XMLParser()
    
    var newsItems = [NewsItems]()
    
    //RSSのパース中の現在の要素名
    var currentElementName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //画像を貼る
        let image = UIImage(named: "2.jpg")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        imageView.image = image
        self.tableView.backgroundView = imageView

        let urlString:String = "https://headlines.yahoo.co.jp/rss/aptsushinv-c_int.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        
        //解析スタート(XMLデリゲートメソッドが呼ばれる)
        parser.parse()
    }
    
    @objc var scrollView: UIScrollView {
        return tableView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.view.frame.size.height/5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        let newsItem = self.newsItems[indexPath.row]
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        
        currentElementName = nil
        if elementName == "item" {
            self.newsItems.append(NewsItems())
        }else{
            
            currentElementName = elementName
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.newsItems.count > 0{
            
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName {
                
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
                print(lastItem.pubDate as Any)
            default:break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //webViewに取得したURLを表示したい（画面遷移した先で）
        let webViewController:UIViewController = WebViewController()
        
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        
        self.present(webViewController, animated: true, completion: nil)
    }

}
