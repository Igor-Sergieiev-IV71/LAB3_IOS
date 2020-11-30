//
//  ViewController.swift
//  Dolfin
//
//  Created by igor on 08.11.2020.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesFromTheFile: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillArrayWithParsedDataFromFile(fileName: "MoviesList")
        
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "txt"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) -> MoviesFeed? {
        do {
            let decodedData = try JSONDecoder().decode(MoviesFeed.self, from: jsonData)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
    private func fillArrayWithParsedDataFromFile(fileName: String?){
        if let localData = self.readLocalFile(forName: fileName!) {
            let decodedData = self.parse(jsonData: localData)
            decodedData?.Search.forEach {
                let pic = UIImage(named: "\($0.Poster)")
                moviesFromTheFile.append(Movie(title: $0.Title, year: $0.Year, type: $0.type, poster: $0.Poster.count.isMultiple(of: 0) ? UIImage() : pic!))
            }
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFromTheFile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesFromTheFile[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MovieTableViewCell
        if movie.poster.isEqual(nil) {
            cell.insertNewMovieWithoutPoster(movie: movie)
        } else {
            cell.insertNewMovie(movie: movie)
        }
        return cell
    }
    
    
}
