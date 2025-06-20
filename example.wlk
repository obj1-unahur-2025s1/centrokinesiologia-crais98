class Paciente {
  const aparatosRutina = []
  const edad
  var fortalezaMuscular
  var dolor

  method puedeUsar(unAparato) = unAparato.puedeSerUsado(self)
  method disminuirDolor(unaCantidad) {
    dolor -= 0.max(unaCantidad)
  }
  method aumentarFortaleza(unaCantidad) {
    fortalezaMuscular += unaCantidad
  }

  method edad() = edad
  method fortalezaMuscular() = fortalezaMuscular 
  method dolor() = dolor
  method usar(unAparato) {
    if(self.puedeUsar(unAparato)){
      unAparato.esUsadoPor(self)
    }
    else self.error("el paciente no puede usar el aparato")
  }
  method puedeRealizarLaRutina() = aparatosRutina.all({p=>p.puedeSerUsado(self)})
  method realizarRutinaCompleta() {
    if(self.puedeRealizarLaRutina()){
      aparatosRutina.forEach({p=>p.esUsadoPor(self)})
    }
  }
  method añadirAparatos(unalista){
    aparatosRutina.addAll(unalista)
  }
  method cantidadAparatos() = aparatosRutina.size()
}



class Aparato {
  method esUsadoPor(unPaciente)
  method puedeSerUsado(unaPaciente) 
}

class Magneto inherits Aparato{
  override method esUsadoPor(unPaciente) { unPaciente.disminuirDolor(unPaciente.dolor()*0.1) }
  override method puedeSerUsado(unPaciente) = true
}
class Bicicleta inherits Aparato {
  override method esUsadoPor(unPaciente) { 
    if(self.puedeSerUsado(unPaciente)){
      unPaciente.disminuirDolor(4) 
      unPaciente.aumentarFortaleza(3)
    }
  }
  override method puedeSerUsado(unPaciente) = unPaciente.edad()>8
}
class Minitramp inherits Aparato {
  override method esUsadoPor(unPaciente) {
    if(self.puedeSerUsado(unPaciente)){
      unPaciente.aumentarFortaleza(unPaciente.edad()*0.1)
    }
  }
  override method puedeSerUsado(unPaciente) = unPaciente.dolor()<20
}

class Resistente inherits Paciente{
  override method usar(unAparato){
    super()
    self.aumentarFortalezaMuscular(self.cantidadAparatos())
    
  }

}

class Caprichoso inherits Paciente{
 override method puedeRealizarLaRutina(){
    super and
    

}

class RapidaRecuperacion{


}