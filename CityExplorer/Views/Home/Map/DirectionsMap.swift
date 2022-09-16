//
//  DirectionsMap.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/16/22.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    var business: Businesses
    
    var start:CLLocationCoordinate2D {
        
        return model.location.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end:CLLocationCoordinate2D {
        
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        map.delegate = context.coordinator
        
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        let directions = MKDirections(request: request)
        
        // get route
        directions.calculate { (response, error) in
            
            if error == nil && response != nil {
                
                // add route
                for route in response!.routes {
                    
                    map.addOverlay(route.polyline)
                    
                    // zoom map
                    map.setVisibleMapRect(route.polyline.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                                          animated: true)
                }
            }
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = end
        destinationAnnotation.title = business.name ?? ""
        map.addAnnotation(destinationAnnotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
}
