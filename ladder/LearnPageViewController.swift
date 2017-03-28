//
//  LearnPageContentViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/27/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class LearnPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var arrPageLabel = [
        "Ladder is a city-wide tennis ladder exclusive in the Boston area",
        "To get ranked you need to complete 5 total matches on Ladder", "After you complete a match you can enter the match results in the matches tab. Winners of each match should enter the scores in.",
        "To climb the ladder you need to beat higher level players. You can easily find players in the Search Tab and track your progress in the Ladder Tab",
        "The season ends July 31st. Prizes will be awarded to the top players in each level.",
        ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.BLUE
        
        self.dataSource = self
        self.setViewControllers([self.getViewControllerAtIndex(index: 0, btnIsHidden: true)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.arrPageLabel.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: LearnPageContentViewController = viewController as! LearnPageContentViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1;
        return getViewControllerAtIndex(index: index, btnIsHidden: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: LearnPageContentViewController = viewController as! LearnPageContentViewController
        var index = pageContent.pageIndex
        var btnIsHidden = true
        
        if (index == NSNotFound)
        {
            return nil
        }
        index += 1;
        
        if (index == arrPageLabel.count - 1) {
            btnIsHidden = false
        }
        
        if (index == arrPageLabel.count)
        {
            return nil
        }
        return getViewControllerAtIndex(index: index, btnIsHidden: btnIsHidden)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getViewControllerAtIndex(index: Int, btnIsHidden: Bool) -> LearnPageContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "LearnPageContentViewController") as! LearnPageContentViewController
        pageContentViewController.strLabel = "\(arrPageLabel[index])"
        pageContentViewController.btnIsHidden = btnIsHidden
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
}
