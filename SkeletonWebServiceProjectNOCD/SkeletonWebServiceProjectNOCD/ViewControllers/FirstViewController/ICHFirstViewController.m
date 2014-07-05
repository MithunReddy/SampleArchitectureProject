//
//  ICHFirstViewController.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 6/27/14.
//  Copyright (c) 2014 idev. All rights reserved.
//

#import "ICHFirstViewController.h"
#import "ICHPersonFetcher.h"
#import "ICHPerson.h"
#import "ICHObjectPrinter.h"
#import "ICHPersonCustomCell.h"

@interface ICHFirstViewController ()

@end

@implementation ICHFirstViewController
{
    NSMutableArray *_personArray;
    int _pageCount;
    UIRefreshControl *_refreshControl;
    BOOL _noMoreDataToFetch;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageCount = 1;
    _noMoreDataToFetch = NO;
    _personArray = [NSMutableArray array];
    [self addRefreshController];
    
    [self fetChPersonWithIndicator:YES];
    
}

-(void)addRefreshController
{
    _refreshControl = [[UIRefreshControl alloc]init];
    _refreshControl.tintColor = [UIColor darkGrayColor];
    [_refreshControl addTarget:self action:@selector(refreshList:) forControlEvents:UIControlEventValueChanged];
    [self.personTableView addSubview:_refreshControl];
    _refreshControl.layer.zPosition = self.personTableView.backgroundView.layer.zPosition - 1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshList:(UIRefreshControl *)refreshControll
{
    _pageCount = 1;
    _noMoreDataToFetch = NO;
    [_refreshControl beginRefreshing];
    [self fetChPersonWithIndicator:NO];
}

- (void)fetChPersonWithIndicator:(BOOL)showIndicator
{
    if ([_refreshControl isRefreshing])
    {
        [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    }
    
    [ICHPersonFetcher fetchPersonsWithPageID:[NSString stringWithFormat:@"%d",_pageCount] withCompletionBlock:^(NSArray *personArray)
    {
        if (personArray.count > 0)
        {
            _pageCount ++;
        }
        else
        {
            _noMoreDataToFetch = YES;
        }
        
        if ([_refreshControl isRefreshing])
        {
            [_refreshControl endRefreshing];
            _personArray = [NSMutableArray arrayWithArray:personArray];
            [self.personTableView scrollsToTop];
        }
        else
        {
            [_personArray addObjectsFromArray:personArray];
        }
        
        [self.personTableView reloadData];
        
        if ([[UIApplication sharedApplication]isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication]endIgnoringInteractionEvents];
        }
        
    } failureBlock:^(id object)
    {
        if ([_refreshControl isRefreshing])
        {
            [_refreshControl endRefreshing];
        }
        if ([[UIApplication sharedApplication]isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication]endIgnoringInteractionEvents];
        }
    } showIndicator:showIndicator];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _personArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PersonCell";
    ICHPerson *person;
    
    ICHPersonCustomCell *cell = (ICHPersonCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ICHPersonCustomCell" owner:self options:nil];
        cell = [nib firstObject];
    }
    
    person = _personArray[indexPath.row];
    cell.person = person;
    [cell layoutNibItems];
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    BOOL shouldRefresh = YES;
    
    if (self.personTableView.contentSize.height < self.personTableView.frame.size.height || _noMoreDataToFetch == YES)
    {
        shouldRefresh = NO;
    }
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height-2 && shouldRefresh && !_refreshControl.isRefreshing)//-2 to compensate footer
    {
        [self fetChPersonWithIndicator:YES];
    }
}

@end
