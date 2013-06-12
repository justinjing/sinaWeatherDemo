//
//  RootViewController.h
//  PASiteMap
//
//  Created by Tiger on 5/18/13.
//  Copyright (c) 2013 Tiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PANewsView.h"
#import "PASettingView.h"
#import "PASystemMapView.h"
#import "PAStockView.h"
#import "OrganizationListMapView.h"

@interface RootViewController : UIViewController {
    UIView *allview;
    PANewsView *paNewsView;
    PASettingView* paSettingView;
    PASystemMapView* paSystemMapView;
    PAStockView* paStockView;
    OrganizationListMapView* organizationListMapView;
    UIImageView *GloabView;
    NSMutableArray * _buttonArray;
    NSMutableArray * _allViewArray;
    UIImageView *arrowIndexImageView;
}

+ (RootViewController *)share;

@end
