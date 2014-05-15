//
//  RootViewController.m
//  ACJSONPath
//
//  Created by Albert Chu on 14-5-15.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "RootViewController.h"

#import "ACJSONUtil.h"

#import "ACJSONPath.h"
#import "UILabel+ACJSONPath.h"


@interface RootViewController ()

@property (strong, nonatomic) UILabel *testLabel;

@end


@implementation RootViewController

- (void)testButtonClicked:(UIButton *)sender
{
    //-- 发送请求 -----------------------------------------------------------------------------------
    NSURL *theURL = [NSURL URLWithString:@"http://www.battlenet.com.cn/api/wow/battlePet/species/258"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (!error) /** 请求成功，处理返回结果 */
         {
             NSString *responseString = [[NSString alloc] initWithData:data
                                                              encoding:NSUTF8StringEncoding];
             
             NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
             id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             
             
             // 更新 UI
             [self.testLabel ac_setTextWithJSON:json andPath:@"abilities[0].name"];
             
         }
         else
         {
             NSLog(@"error");
         }
         
     }];
    //----------------------------------------------------------------------------------------------
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"RootVC";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //-- testButton --------------------------------------------------------------------------------
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(80.0, 100.0, 160.0, 40.0);
    testButton.backgroundColor = [UIColor orangeColor];
    
    [testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testButton setTitle:@"request for data" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testButton];
    //---------------------------------------------------------------------------------------------;
    
    
    //-- testLabel ---------------------------------------------------------------------------------
    self.testLabel = [[UILabel alloc] init];
    self.testLabel.frame = CGRectMake(40.0, 300.0, 240.0, 40.0);
    self.testLabel.backgroundColor = [UIColor grayColor];
    self.testLabel.textColor = [UIColor whiteColor];
    
    self.testLabel.text = @"empty";
    
    [self.view addSubview:self.testLabel];
    //---------------------------------------------------------------------------------------------;
    

    [self testParsing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method

- (void)testParsing
{
    /** 测试解析本地文件 ******************************************************************************
     
     [[ACJSONUtil sharedInstance]
     parsingJSONDataFromMainBundleByFile:@"test.json"
     
     success:^(id responseObj) {
     NSData *test = [[ACJSONPath sharedInstance]
     getDataFromJSONObject:responseObj
     byPath:@"template.test[2][1][2]"];
     
     NSLog(@"%@ == %@", test, [test class]);
     }
     
     failure:^(NSString *failureString) {
     NSLog(@"%@", failureString);
     }
     
     ];
     
     
     [[ACJSONUtil sharedInstance]
     parsingJSONDataFromMainBundleByFile:@"test.json"
     
     success:^(id responseObj) {
     NSData *test = [[ACJSONPath sharedInstance]
     getDataFromJSONObject:responseObj
     byPath:@"template.test[1][0].one[0][0].te"];
     
     NSLog(@"%@ == %@", test, [test class]);
     }
     
     failure:^(NSString *failureString) {
     NSLog(@"%@", failureString);
     }
     
     ];
     
     **********************************************************************************************/
    
    
    
    /*
     
    [[ACJSONUtil sharedInstance]
     parsingJSONDataFromMainBundleByFile:@"test.json"
     
     success:^(id responseObj) {
         
         NSString *testStr = ((NSDictionary *)responseObj)[@"template"][@"test"][1][0][@"one"][0][0][@"te"];
         
         NSLog(@"%@", testStr);
     }
     
     failure:^(NSString *failureString) {
         NSLog(@"%@", failureString);
     }
     
     ];
     
     **/
    
    
}

@end
