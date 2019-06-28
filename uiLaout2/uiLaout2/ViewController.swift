//
//  ViewController.swift
//  uiLaout2
//
//  Created by yilin luo on 6/17/19.
//  Copyright © 2019 yilin luo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    @IBAction func mapSearchButton(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //activity indicator
        let activityIndicator = UIActivityIndicatorView(); activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
       // self.view.addSubview(<#T##view: UIView##UIView#>)
        
        //hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create the search request: user type in a word and use the word to find place
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start{(response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response  == nil
            {
                print ("Error")
            }
            else
            {
                //remove annotation
                let annotations = self.myMapView.annotations
                self.myMapView.removeAnnotations(annotations)
                
                //getting data, the latitude and longitude of the typed word's matching location
                let latitude = response?.boundingRegion.center.latitude
                
                 let longitude = response?.boundingRegion.center.longitude
                
                //create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //zooming in on annotation
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet var feedButtonPressed: [UITabBar]!
    

}

