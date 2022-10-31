object sistemaTurismo {
	var property cotizacion = 100
	const turistas = []
	const sitios = []
	
	method agregarTurista(t){
		turistas.add(t)
	}
	
	method agregarSitio(s){
		sitios.add(s)
	}

	
	method pasoUnAnio(){
		turistas.forEach{t=> t.cumplirAnios()}
	}
	
	method sitiosVisitables(turista,pais) =
		self.sitioDelPais(pais).filter{s=>s.puedeSerVisitado(turista)}
	
	method sitioMasVisitadoPorMenores() = 
		sitios.max{s=>s.cantidadVisitasMenores()}
		
	method visitoAlgoEnPais(turista,pais) = 
		self.sitioDelPais(pais).any{s=>s.fueVisitadoPor(turista)}
	
	method sitioDelPais(pais) =
		sitios.filter{s=>s.pais() == pais} 
} 


class Turista{
	var edad
	var millas
	
	method puedePagar(importe) =
		millas * sistemaTurismo.cotizacion() >= importe
	
	method menor() = edad < 18
	method adultoMayor() = edad >= 70
	
	method cumplirAnios(){
		edad += 1
	}
	
	method pagar(importe) {
		millas -= importe / sistemaTurismo.cotizacion()
	}
	method premio(millasPremio){
		millas += millasPremio
	}

//	method visitar(sitio) {
//		if(sitio.puedeSerVisitado(self)){
//			sitios.add(sitio)
//			self.pagar(sitio.importe(self))
//		}
//	}

}


class Sitio {
	
	var precio
	var property pais
	const visitantes = []
	
	
	method puedeSerVisitado(turista) = 
		turista.puedePagar(self.importe(turista))
	
	method importe(turista) = precio
	
	method visitado(turista) {
		if(self.puedeSerVisitado(turista)){
			visitantes.add(turista)
			turista.pagar(self.importe(turista))
			self.darBonificacion(turista)
		}
	}
	
	method darBonificacion(turista) {}
	
	method cantidadVisitasMenores() = 
		visitantes.count{t=>t.menor()}
	
	method fueVisitadoPor(turista) = visitantes.contains(turista)
}

class SitioInfantil inherits Sitio{
	
	override method puedeSerVisitado(turista) = 
		super(turista) &&
		turista.menor()
	
	override method darBonificacion(turista){ 
	 	turista.premio(10)
	 }
}

class SitioMayores inherits Sitio{
	var descuento
	
	override method importe(turista) = 
		if(turista.adultoMayor()) 
			precio*(1-descuento) 
		else 
			precio
	
}	


