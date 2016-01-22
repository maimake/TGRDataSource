//
//  TGRDicDataSource.h
//  Langland
//
//  Created by mai on 15/4/13.
//  Copyright (c) 2015年 langland. All rights reserved.
//

#import "TGRDataSource.h"

@interface TGRDicDataSource : TGRDataSource

@property (nonatomic, strong) NSDictionary* sectionTitleMap;
@property (nonatomic, copy) NSComparator sectionsComparator;

@property (nonatomic, strong) NSDictionary* indices;
@property (nonatomic, strong, readonly) NSArray* sections;

@property (nonatomic, copy) BOOL(^equalBlock)(id item1, id item2);

-(id)initWithCellReuseIdentifier:(NSString *)defaultReuseIdentifier
              configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
                         indices:(NSDictionary*)indices
                 sectionTitleMap:(NSDictionary*)sectionTitleMap
    sortedSectionUsingComparator:(NSComparator)sectionsComparator;

-(id)initWithReuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
                          indices:(NSDictionary*)indices
                  sectionTitleMap:(NSDictionary*)sectionTitleMap
     sortedSectionUsingComparator:(NSComparator)sectionsComparator;


-(id)initWithCellReuseIdentifier:(NSString *)defaultReuseIdentifier
              configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
                         indices:(NSDictionary*)indices;

-(id)initWithReuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
                          indices:(NSDictionary*)indices;

@end
