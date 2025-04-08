//
//  OnboardingPageViewController.swift
//  OnBoardViewEnUIKit
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

/// Controlador principal del flujo de onboarding.
/// Hereda de `UIPageViewController` para gestionar varias pantallas desplazables.
/// Implementa los protocolos `UIPageViewControllerDataSource` y `UIPageViewControllerDelegate` para controlar la navegación entre páginas.
class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	
	/// Array con las pantallas del onboarding. Cada una es una instancia de `OnboardingContentViewController`.
	private var pages: [OnboardingContentViewController] = []
	/// Control visual que indica en qué página está el usuario.
	private let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
		dataSource = self
		delegate = self
		pages = crearPaginas()
		setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
		configurarControlDePagina()
    }
	
	/// Método que crea e instancia las tres pantallas del onboarding desde el storyboard.
	/// Cada pantalla se configura con su imagen, título, descripción y si es la última.
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

	/// Configura el `UIPageControl` (los puntitos) en la parte inferior del `PageViewController`.
	/// Se posiciona con constraints directamente en la vista del controlador.
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
	
	/// Devuelve la vista anterior en el carrusel de onboarding.
	func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerBefore viewController: UIViewController) -> UIViewController? {
			guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController),
				  index > 0 else { return nil }
			return pages[index - 1]
		}

	/// Devuelve la vista siguiente en el carrusel de onboarding.
	func pageViewController(_ pageViewController: UIPageViewController,
								viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController),
				index < pages.count - 1 else { return nil }
		return pages[index + 1]
	}
	
	/// Actualiza el `pageControl` cuando el usuario termina de hacer scroll entre pantallas.
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
