package us.educative.models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PlanDePagosModel
	{
		public var productoServicioList:ArrayCollection;
		public var conceptosDePagoList:ArrayCollection;
		public var planesList:ArrayCollection;
		public var alumnosList:ArrayCollection;
		public var planDePagosList:ArrayCollection;
		
		public var listadoMeses:ArrayCollection = new ArrayCollection([{label:"Enero", data:"1"},
			{label:"Febrero", data:"2"},
			{label:"Marzo", data:"3"},
			{label:"Abril", data:"4"},
			{label:"Mayo", data:"5"},
			{label:"Junio", data:"6"},
			{label:"Julio", data:"7"},
			{label:"Agosto", data:"8"},
			{label:"Septiembre", data:"9"},
			{label:"Octubre", data:"10"},
			{label:"Noviembre", data:"11"},
			{label:"Diciembre", data:"12"},])
			
			
		public function PlanDePagosModel()
		{
		}
	}
}