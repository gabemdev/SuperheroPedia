//
//  ViewController.m
//  Superheropedia
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *superheroTableView;
@property NSArray *superheroes;
@property int numberOfLines;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.superheroes = @[@{@"Superman":@"name", @32: @"age"}];
//    self.superheroes = [NSArray arrayWithObjects:
//                        [NSDictionary dictionaryWithObjectsAndKeys:
//                         @"Superman", @"name",
//                         [NSNumber numberWithInt:32], @"age", nil],
//
//                        [NSDictionary dictionaryWithObjectsAndKeys:
//                         @"Green Lantern", @"name",
//                         [NSNumber numberWithInt:28], @"age", nil]
//
//                        , nil];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.superheroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.superheroTableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.superheroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *superhero = [self.superheroes objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];

    cell.textLabel.text = [superhero objectForKey:@"name"];
    cell.detailTextLabel.text = [superhero objectForKey:@"description"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];

    return cell;
}

@end
