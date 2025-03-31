//
//  Tarea.swift
//  Ejercicio1-TODO-App
//
//  Created by Rubén Segura Romo on 31/3/25.
//

import Foundation

struct Tarea {
	let id: UUID
	var titulo: String
	var descripcion: String
	var fechaCreacion: Date
	var estaCompletada: Bool
}
