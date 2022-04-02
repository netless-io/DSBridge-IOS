//
//  MemoryLeakTest.m
//  DSBridgeTest
//
//  Created by xuyunshi on 2022/4/2.
//  Copyright © 2022 杜文. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "dsbridge.h"

@interface MemoryLeakTest: XCTestCase

@property (nonatomic, strong) DWKWebView* webView;

@end

@implementation MemoryLeakTest

static NSTimeInterval kTimeout = 30;

- (void)setUp
{
    DWKWebView * webview = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 25, 100, 100)];
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

- (void)testSyncHandMapLeak
{
    XCTestExpectation* exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    __block int callId = [[self.webView valueForKey:@"callId"] intValue];
    [self.webView callHandler:@"syn.getInfo" completionHandler:^(id  _Nullable value) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary* dic = [self.webView valueForKey:@"handerMap"];
            XCTAssert(dic[@(callId)] == nil);
            [exp fulfill];
        });
    }];
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) { NSLog(@"%@", [error localizedDescription]); }
    }];
}

- (void)testAsyncHandMapLeak
{
    XCTestExpectation* exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    __block int callId = [[self.webView valueForKey:@"callId"] intValue];
    [self.webView callHandler:@"asyn.getInfo" completionHandler:^(id  _Nullable value) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary* dic = [self.webView valueForKey:@"handerMap"];
            XCTAssert(dic[@(callId)] == nil);
            [exp fulfill];
        });
    }];
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) { NSLog(@"%@", [error localizedDescription]); }
    }];
}

@end
