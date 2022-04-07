//
//  ViewController.swift
//  Zalo
//
//  Created by AnhLe on 03/04/2022.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    // MARK: - Subview
    private let pageViewController: UIPageViewController
    private var pages: [UIViewController] = []
    private var pageControl: UIPageControl!
    var currentVC: UIViewController{
        didSet{
        }
    }
    static let zaloLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.zaloImg
        imageView.clipsToBounds = true
        
        return imageView
    }()
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal,
                                                       options: nil)
        let page_1 = OnboardingViewController(contentLabel: "Gọi video ổn định",
                                              contenSublabel: "Trò chuyện thật đã với hình ảnh sắc nét, tiếng chất, âm chuẩn dưới mọi điều kiện mạng",
                                              image: Image.onboardingImg1,
                                              textColor: .lightGray)
        
        let page_2 = OnboardingViewController(contentLabel: "Gọi video ổn định",
                                              contenSublabel: "Trò chuyện thật đã với hình ảnh sắc nét, tiếng chất, âm chuẩn dưới mọi điều kiện mạng",
                                              image: Image.onboardingImg2,
                                              textColor: .lightGray)
        
        let page_3 = OnboardingViewController(contentLabel: "Gọi video ổn định",
                                              contenSublabel: "Trò chuyện thật đã với hình ảnh sắc nét, tiếng chất, âm chuẩn dưới mọi điều kiện mạng",
                                              image: Image.onboardingImg3,
                                              textColor: .lightGray)
        
        let page_4 = NoImageOnboardingViewController()
        
        pages.append(page_1)
        pages.append(page_2)
        pages.append(page_3)
        pages.append(page_4)
        currentVC = pages.first!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
        
        pageViewController.setViewControllers([pages.first!],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        configurePageControl()
        
        layout()
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    private func configurePageControl(){
        pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .graySecondaryZalo
        pageControl.currentPageIndicatorTintColor = .blueZalo
    }
}
// MARK: - Extension
extension OnboardingContainerViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        
    }
    func layout(){
        view.addSubview(pageControl)
        view.addSubview(pageViewController.view)
        view.addSubview(OnboardingContainerViewController.zaloLogo)
        
        //zalo img
        NSLayoutConstraint.activate([
            OnboardingContainerViewController.zaloLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            OnboardingContainerViewController.zaloLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            OnboardingContainerViewController.zaloLogo.heightAnchor.constraint(equalToConstant: 72),
            OnboardingContainerViewController.zaloLogo.widthAnchor.constraint(equalToConstant: 72)
            
        ])
        
        //pagecontrol
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        //
        //pageViewController
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageControl.topAnchor)
            
        ])
    }
}
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0  else {return nil}
        currentVC = pages[index-1]
   
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count  else {return nil}
        currentVC = pages[index+1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
extension OnboardingContainerViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            if let currentViewController = pageViewController.viewControllers![0] as? OnboardingViewController{
                pageControl.currentPage = pages.firstIndex(of: currentViewController)!

               
            }else if let currentViewController = pageViewController.viewControllers![0] as? NoImageOnboardingViewController {
                pageControl.currentPage = pages.firstIndex(of: currentViewController)!
    
                self.view.layoutIfNeeded()
                
            }
        }
    }
}
