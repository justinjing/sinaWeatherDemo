//
//  OrganizationListMapView.h
//  PASiteMap
//
//  Created by da zhan on 13-5-20.
//  Copyright (c) 2013年 Tiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface OrganizationListMapView : UIView< MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    MKMapView* myMapView;
    CLLocationManager *locationManager;
    NSMutableArray *_annotationList;
    NSMutableArray *annotationsArray;           //加入大头针的数组
    NSMutableArray *LocationCoordinateArray;    //所有经纬度数组
}

+(OrganizationListMapView *)share;

@end
