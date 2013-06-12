//
//  OrganizationListMapView.m
//  PASiteMap
//
//  Created by da zhan on 13-5-20.
//  Copyright (c) 2013年 Tiger. All rights reserved.
//

#import "OrganizationListMapView.h"
#import "BasicMapAnnotation.h"
#import "RootViewController.h"
#define spanaa 380000
@implementation OrganizationListMapView


static OrganizationListMapView *sh=nil;

+(OrganizationListMapView*)share{
    
    return sh;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        sh=self;
        myMapView =[[[MKMapView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width,self.frame.size.height-19)] autorelease];
        myMapView.delegate=self;
        myMapView.autoresizingMask= (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        [self  addSubview:myMapView];
        [myMapView setZoomEnabled:YES];
        [myMapView setScrollEnabled:YES];
        
       // 22.6,114.1
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(83.615352,115.1397105);
        float zoomLevel = 0.02;
        MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
        region.center = coords;
        [myMapView setRegion:[myMapView regionThatFits:region] animated:YES];
        
        
        if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter=0.5;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation]; // 开始定位
        }
        
        annotationsArray = [[NSMutableArray alloc] init];
        LocationCoordinateArray=[[NSMutableArray alloc] initWithCapacity:1];
        [self initdata];
    }
    return self;
}

-(void)initdata{
    
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.73121],@"latitude",[NSString stringWithFormat:@"%lf",114.6897105],@"longitude",nil];

    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.55121],@"latitude",[NSString stringWithFormat:@"%lf",114.63552],@"longitude",nil];

    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",24.55121],@"latitude",[NSString stringWithFormat:@"%lf",116.168352],@"longitude",nil];

    NSDictionary *dic4=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",22.61121],@"latitude",[NSString stringWithFormat:@"%lf",113.068352],@"longitude",nil];

    NSDictionary *dic5=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",24.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic6=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",25.39121],@"latitude",[NSString stringWithFormat:@"%lf",117.69352],@"longitude",nil];
    NSDictionary *dic7=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic8=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.29121],@"latitude",[NSString stringWithFormat:@"%lf",116.90352],@"longitude",nil];
    NSDictionary *dic9=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic10=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.19121],@"latitude",[NSString stringWithFormat:@"%lf",116.19352],@"longitude",nil];
    NSDictionary *dic11=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic12=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.91121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic13=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.19121],@"latitude",[NSString stringWithFormat:@"%lf",116.29352],@"longitude",nil];
    NSDictionary *dic14=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.19121],@"latitude",[NSString stringWithFormat:@"%lf",115.99352],@"longitude",nil];
    NSDictionary *dic15=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];
    NSDictionary *dic16=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lf",23.39121],@"latitude",[NSString stringWithFormat:@"%lf",116.69352],@"longitude",nil];

    NSMutableArray *array = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13, dic14,dic15,dic16,nil];
  
    [LocationCoordinateArray addObjectsFromArray:array];
}


#pragma mark -
#pragma mark MKMapViewDelegate



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    /// 判断是否是自己
    if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
        MKAnnotationView *annotationView = [myMapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"CustomAnnotation"] autorelease];
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.image = [UIImage imageNamed:@"pin.png"];
            annotationView.leftCalloutAccessoryView.frame = CGRectMake(0,0,37,36);
        }
		return annotationView;
    }else {
        
        return nil;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
      [self setAnnotionsWithList];
      [locationManager stopUpdatingLocation];
}

 
-(void)setAnnotionsWithList 
{
 
    NSArray* array=[NSArray arrayWithObjects:@"广东分公司河源公司",
                    @"广东分公司江门中心支公司",
                    @"广东分公司揭阳中心支公司",
                    @"广东分公司茂名中心支公司",
                    @"广东分公司河源中心支公司",
                    @"广东分公司江门中心支公司",
                    @"广东分公司揭阳中心支公司",
                    @"广东分公司茂名中心支公司",
                    @"广东分公司梅州中心支公司",
                    @"广东分公司清远中心支公司",
                    @"广东分公司汕头中心支公司",
                    @"广东分公司汕尾中心支公司",
                    @"广东分公司韶关中心支公司",
                    @"广东分公司阳江中心支公司",
                    @"广东分公司云浮中心支公司",
                    @"广东分公司湛江中心支公司",
                    @"广东分公司肇庆中心支公司",
                    @"广东分公司中山中心支公司",
                    nil];
    
    for (int i=0; i<[LocationCoordinateArray count]; i++) {
        CLLocationDegrees latitude=[[[LocationCoordinateArray objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[[LocationCoordinateArray objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(23.615352,114.1397105);
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,spanaa ,spanaa);
        //设置地图显示的中心及范围
        region.center = coords;
      
        MKCoordinateRegion adjustedRegion = [myMapView regionThatFits:region];
        [myMapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[[BasicMapAnnotation alloc] initWithLatitude:latitude andLongitude:longitude]  autorelease];
        annotation.tag=i;
        annotation.title = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        [annotationsArray addObject:annotation];
    }
    // [myMapView   addAnnotation:[annotationsArray objectAtIndex:0]];
     [myMapView   addAnnotations:annotationsArray];
    
}

#pragma mark - 
#pragma mark 地图切换

-(void)updateAnnotions:(int)index
{
    NSArray* temp=myMapView.annotations;
    if ([temp count]!=0) {
        [myMapView removeAnnotations:temp];
    }
    
    [myMapView addAnnotation:[annotationsArray objectAtIndex:index]];
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)contro{
	
    NSLog(@"---zhaoqingjie---");
 
    
}

-(void)dealloc{
    
    [locationManager release];
    [super dealloc];
}

@end
