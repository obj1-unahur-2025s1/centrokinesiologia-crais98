class Paciente {
  const aparatosRutina = []
  const edad
  var fortalezaMuscular
  var dolor

  method puedeUsar(unAparato) = unAparato.puedeSerUsado(self)
  method disminuirDolor(unaCantidad) {
    dolor = 0.max(dolor - unaCantidad)
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

  method hayAparatoDeColor(unColor) = aparatosRutina.any({p=>p.color()== unColor})
}


class Aparato {
  const color = "blanco" // si esta seteado, como lo cambió?
  method esUsadoPor(unPaciente)
  method puedeSerUsado(unaPaciente) 
  //method esDeColor(unColor) = unColor == color
  method color() = color
  method hacerMantenimiento()
  method necesitaMantenimiento()
}

class Magneto inherits Aparato{
 var imantacion = 800
  override method esUsadoPor(unPaciente) { unPaciente.disminuirDolor(unPaciente.dolor()*0.1)
    imantacion = 0.max(imantacion - 1)
}
  override method puedeSerUsado(unPaciente) = true

 override method hacerMantenimiento(){
    imantacion = (imantacion + 500).min(800)
 }
 override method necesitaMantenimiento() = imantacion < 100
}
class Bicicleta inherits Aparato {
 var cantDesajuste = 0
 var cantAceite = 0
  override method esUsadoPor(unPaciente) { 
    if(self.puedeSerUsado(unPaciente)){
      cantDesajuste = if(unPaciente.dolor()>30) cantDesajuste+1 else cantDesajuste
      cantAceite= if(unPaciente.edad()>=30 && unPaciente.edad()<=50) cantAceite+1 else cantAceite
      unPaciente.disminuirDolor(4) 
      unPaciente.aumentarFortaleza(3)

    }
  }
  override method puedeSerUsado(unPaciente) = unPaciente.edad()>8

  override method necesitaMantenimiento() = cantDesajuste>=10 or cantAceite >=5

  override method hacerMantenimiento() {
    cantDesajuste= 0
    cantAceite= 0
  }
}
class Minitramp inherits Aparato {
  override method esUsadoPor(unPaciente) {
    if(self.puedeSerUsado(unPaciente)){
      unPaciente.aumentarFortaleza(unPaciente.edad()*0.1)
    }
  }
  override method puedeSerUsado(unPaciente) = unPaciente.dolor()<20
  override method necesitaMantenimiento() = false
  override method hacerMantenimiento() {}
}

class Resistente inherits Paciente{
  override method realizarRutinaCompleta(){
    super()
    self.aumentarFortaleza(self.cantidadAparatos())
    
  }

}

class Caprichoso inherits Paciente{
  override method puedeRealizarLaRutina() =
     super() and
     self.hayAparatoDeColor("rojo")
  
  override method realizarRutinaCompleta(){
     super()
     super()
  }
}

class RapidaRecuperacion inherits Paciente {
  override method realizarRutinaCompleta(){
    super()
    self.disminuirDolor(configuracionDolor.decremento())
 }

}

object configuracionDolor{
 var valor = 3
 method decrementar(unValor){
  valor = unValor
 }
 method decremento() = valor

}

object centro {
 const aparatos= []
 const pacientes= []
 method coloresDeAparatos()= aparatos.map({p=>p.color()}).asSet()
 method pacientesMenoresDe8años()= pacientes.filter({p=>p.edad() < 8})
 method cantPacientesQueNoCumplenSesion() = pacientes.count({p=>!p.puedeRealizarLaRutina()})
 method estaOptimo() = aparatos.all({p=>!p.necesitaMantenimiento()})
 method estaComplicado() = self.cantidadAparatosAReparar() >= aparatos.size()/2
 method cantidadAparatosAReparar() = aparatos.count({p=>p.necesitaMantenimiento()})
 method aparatosAMantener() = aparatos.filter({p=>p.necesitaMantenimiento()})
 method visitaTecnica(){
    self.aparatosAMantener().forEach({p=>p.hacerMantenimiento()})

 }

 method agregarAparato(unAparato){
    aparatos.add(unAparato)
 }
 method agregarPaciente(unPaciente){
    aparatos.add(unPaciente)
 }
}