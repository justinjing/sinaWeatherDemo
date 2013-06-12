//
//  RootViewController.m
//  PASiteMap
//
//  Created by Tiger on 5/18/13.
//  Copyright (c) 2013 Tiger. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>


#define  TableButtonHeight 49
#define  TableButtonWidth  49


@interface RootViewController ()

@end

@implementation RootViewController

static RootViewController *seh = NULL;
+ (RootViewController *)share {
    return seh;
}

- (id)init {
    self = [super init];
    if (self) {
        // Custom initialization]
        seh = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      _buttonArray=[[NSMutableArray alloc]initWithCapacity:5];
      _allViewArray=[[NSMutableArray alloc]initWithCapacity:5];

     allview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:allview];
    
    
    paSystemMapView=[[PASystemMapView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [paSystemMapView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"snow.jpg"]]];
    [allview addSubview:paSystemMapView];
     [_allViewArray addObject:paSystemMapView];
    

    paStockView=[[PAStockView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [paStockView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nightcloud.jpg"]]];
    [_allViewArray addObject:paStockView];
    
    
    paSettingView=[[PASettingView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [paSettingView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"night.jpg"]]];
    [_allViewArray addObject:paSettingView];

    
    paNewsView=[[PANewsView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [paNewsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"index_bg.jpg"]]];
    [_allViewArray addObject:paNewsView];
    
    organizationListMapView=[[OrganizationListMapView  alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [_allViewArray addObject:organizationListMapView];
    
    
    
    NSArray *buttonNormalPNG=[[NSArray alloc]initWithObjects:@"buttonBar_menu_weather_normal.png",@"buttonBar_menu_airport_normal.png",@"buttonBar_menu_curve_normal.png",@"buttonBar_menu_index_normal.png",@"buttonBar_menu_side_normal.png",nil];
                             
    NSArray *buttonHighlightPNG=[[NSArray alloc] initWithObjects:@"buttonBar_menu_weather_press.png",@"buttonBar_menu_airport_press.png",@"buttonBar_menu_curve_press.png",@"buttonBar_menu_index_press.png",@"buttonBar_menu_side_press.png",nil];
 
    
    for (int i=0; i<5; i++) {
        UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchbutton.frame = CGRectMake(10, i*TableButtonHeight+30+204,TableButtonWidth,TableButtonHeight);
        [searchbutton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
        [searchbutton setBackgroundImage:[UIImage imageNamed:[buttonNormalPNG objectAtIndex:i]] forState:UIControlStateNormal];
        [searchbutton setBackgroundImage:[UIImage imageNamed:[buttonHighlightPNG objectAtIndex:i]] forState:UIControlStateSelected];
        [searchbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        searchbutton.tag=i;
        [_buttonArray addObject:searchbutton];
        [self.view addSubview:searchbutton];
        
        if (i==0) {
            [searchbutton  setSelected:YES];
        }
    }
    
     [buttonNormalPNG release];
     [buttonHighlightPNG release];
    
    UIView* arrowView=[[UIImageView alloc]initWithFrame:CGRectMake(4+TableButtonWidth+10,238,10,240)];
    [arrowView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:arrowView];
    [arrowView setClipsToBounds:YES];
    
    arrowIndexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,10,240)];
    [arrowIndexImageView setBackgroundColor:[UIColor clearColor]];
    [arrowView addSubview:arrowIndexImageView];
    
    UILabel *uplabel=[[UILabel alloc]initWithFrame:CGRectMake(4,-200,1,200)];
    uplabel.backgroundColor=[UIColor blackColor];
    [arrowIndexImageView addSubview:uplabel];
    
    UIView *CenterimageView=[[UIView alloc]initWithFrame:CGRectMake(0,0,1,49)];
    CenterimageView.backgroundColor=[UIColor clearColor];
    [arrowIndexImageView addSubview:CenterimageView];
    
    UIImageView *pointOutImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,20,9,13)];
    pointOutImageView.image=[UIImage imageNamed:@"buttonBar_menu_pointout.png"];
    [CenterimageView addSubview:pointOutImageView];
    
    UILabel *downlabel=[[UILabel alloc]initWithFrame:CGRectMake(4,49,1,200)];
    downlabel.backgroundColor=[UIColor blackColor];
    [downlabel setClipsToBounds:YES];
    [arrowIndexImageView addSubview:downlabel];
    
}

-(void)searchButton:(UIButton*)sender{
    
      int tag=sender.tag;
   
      [UIView beginAnimations:nil context:nil];
      [UIView setAnimationDuration:0.3];
      arrowIndexImageView.center=CGPointMake(5,tag*48+120);
      [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
      [UIView setAnimationDelegate:self];
      [UIView commitAnimations];
    
  
    
    for (int i=0; i<5; i++) {
         
        UIButton *tempbutton=[_buttonArray objectAtIndex:i];
        if (i==tag) {
          [tempbutton setSelected:YES];
            [allview  addSubview:[_allViewArray objectAtIndex:tag]];
            
        }else{
               [[_allViewArray objectAtIndex:i] removeFromSuperview];
           [tempbutton setSelected:NO];
        }
        
    }
    
}
 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_buttonArray release];
    [super dealloc];
}

@end
