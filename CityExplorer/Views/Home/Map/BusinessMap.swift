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
    @Binding var selectedBusiness: Businesses?
    
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
        
        map.delegate = context.coordinator.self
        
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //uiView.removeAnnotation(uiView.annotations)
        
        uiView.showAnnotations(self.location, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // ignore if user blue dot
            if annotation is MKUserLocation {
                return nil
            }
            

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationID)
            
            // create new as none exists
            if annotationView == nil {
                
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationID)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            // reuse older annotation
            else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        // Handel user tap
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            for business in map.model.restaurants + map.model.arts {
                if business.name == view.annotation?.title {
                    
                    map.selectedBusiness = business
                    return
                    
                }
            }
            
        }
        
    }
    
}
