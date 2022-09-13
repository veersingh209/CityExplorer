//
//  BusinessMap.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/13/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var location:[MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation] ()
        
        for business in model.arts + model.restaurants {
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //uiView.removeAnnotation(uiView.annotations)
        
        uiView.showAnnotations(self.location, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
    }
    
}
