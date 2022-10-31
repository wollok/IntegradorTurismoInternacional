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
		sitios.filter{s=>s.pais() == pais && s.puedeSerVisitado(turista)}
	
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
}


class Sitio {
	
	var precio
	var property pais
	
	
	method puedeSerVisitado(turista) = 
		turista.puedePagar(self.importe(turista))
	
	method importe(turista) = precio
}

class SitioInfantil inherits Sitio{
	
	override method puedeSerVisitado(turista) = 
		super(turista) &&
		turista.menor()
	
}

class SitioMayores inherits Sitio{
	var descuento
	
	override method importe(turista) = 
		if(turista.adultoMayor()) 
			precio*(1-descuento) 
		else 
			precio
	
}	


