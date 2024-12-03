//
//  ArgsTest.m
//  DSBridgeTest
//
//  Created by xuyunshi on 2022/4/14.
//  Copyright © 2022 杜文. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ntl_dsbridge.h"

@interface ArgsTest : XCTestCase
@property (nonatomic, strong) NTLDWKWebView* webView;
@end

@implementation ArgsTest

static NSTimeInterval kTimeout = 30;

- (void)setUp
{
    NTLDWKWebView * webview = [[NTLDWKWebView alloc] initWithFrame:CGRectMake(0, 25, 100, 100)];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"html"];
    NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [webview loadHTMLString:htmlContent baseURL:baseURL];
    self.webView = webview;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.webView];
}

- (void)tearDown
{
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)testEnableArgs {
    XCTestExpectation* exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.webView callHandler:@"asyn.addValue" arguments:@[@5,@6] completionHandler:^(id  _Nullable value) {
        XCTAssertTrue([value intValue] == 11);
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) { NSLog(@"%@", [error localizedDescription]); }
    }];
}

- (void)testIllegalArgs {
    XCTestExpectation* exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray* args = @[@(1.0/0.0), @(6)];
        XCTAssertThrows([self.webView callHandler:@"test" arguments:args completionHandler:nil]);
        [exp fulfill];
    });
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) { NSLog(@"%@", [error localizedDescription]); }
    }];
}
@end
