//
//  Tweet.m
//  Twitter
//
//  Created by Dan Hipschman on 2/21/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.ident = [dictionary[@"id"] stringValue];
        self.text = dictionary[@"text"];
        if ([dictionary objectForKey:@"user"] != nil) {
            self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        } else {
            self.user = [[User alloc] initWithDictionary:dictionary[@"sender"]];
        }
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
    }
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
