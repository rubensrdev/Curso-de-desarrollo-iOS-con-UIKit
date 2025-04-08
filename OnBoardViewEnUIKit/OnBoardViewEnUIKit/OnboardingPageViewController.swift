//
//  OnboardingPageViewController.swift
//  OnBoardViewEnUIKit
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	
	private var pages: [OnboardingContentViewController] = []
	private let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
		dataSource = self
		delegate = self
		pages = crearPaginas()
		setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
		configurarControlDePagina()
    }
	
	private func crearPaginas() -> [OnboardingContentViewController] {
		   let storyboard = UIStoryboard(name: "Main", bundle: nil)

		   let pagina1 = storyboard.instantiateViewController(identifier: "Onboarding1") as! OnboardingContentViewController
		   pagina1.imagen = "onboarding1"
		   pagina1.titulo = "Bienvenido"
		   pagina1.descripcion = "Explora la app fácilmente"
		   pagina1.esUltimaPagina = false

		   let pagina2 = storyboard.instantiateViewController(identifier: "Onboarding2") as! OnboardingContentViewController
		   pagina2.imagen = "onboarding2"
		   pagina2.titulo = "Funciones"
		   pagina2.descripcion = "Descubre sus funcionalidades"
		   pagina2.esUltimaPagina = false

		   let pagina3 = storyboard.instantiateViewController(identifier: "Onboarding3") as! OnboardingContentViewController
		   pagina3.imagen = "onboarding3"
		   pagina3.titulo = "Comencemos"
		   pagina3.descripcion = "¡Disfruta la experiencia!"
		   pagina3.esUltimaPagina = true

		   return [pagina1, pagina2, pagina3]
	   }

	   private func configurarControlDePagina() {
		   pageControl.numberOfPages = pages.count
		   pageControl.currentPage = 0
		   pageControl.translatesAutoresizingMaskIntoConstraints = false
		   view.addSubview(pageControl)

		   NSLayoutConstraint.activate([
			   pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
			   pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		   ])
	   }
	
	func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerBefore viewController: UIViewController) -> UIViewController? {
			guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController),
				  index > 0 else { return nil }
			return pages[index - 1]
		}

		func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerAfter viewController: UIViewController) -> UIViewController? {
			guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController),
				  index < pages.count - 1 else { return nil }
			return pages[index + 1]
		}

		func pageViewController(_ pageViewController: UIPageViewController,
								didFinishAnimating finished: Bool,
								previousViewControllers: [UIViewController],
								transitionCompleted completed: Bool) {
			if let currentVC = viewControllers?.first as? OnboardingContentViewController,
			   let index = pages.firstIndex(of: currentVC) {
				pageControl.currentPage = index
			}
		}

}
