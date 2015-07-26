package us.educative.events
{
	import flash.events.Event;
	
	public class PlanDePagosEvent extends Event
	{
		public static const PLAN_TRAER_TODOS_LOS_ALUMNOS:String = "planTraerTodosLosAlumnos";
		public static const PLAN_LISTAR_PLANES:String = "planListarPlanes";
		public static const PLAN_BUSCA_CONCEPTOS_POR_ALUMNO:String = "planBuscaConceptosPorAlumno";
		public static const PLAN_BORRAR_CONCEPTO_DE_PAGO:String = "planBorrarConceptoDePago";
		public static const PLAN_VIEW_ALUMNO_SELECCIONADO:String = "planViewAlumnoSeleccionado";
		public static const PLAN_LISTAR_PRODUCTO_SERVICIO:String = "planListarProductoServicio";
		public static const PLAN_AGREGAR_CONCEPTO:String = "planAgregarConcepto";
		public static const PLAN_APLICAR:String = "planAplicar";

		
		
		public var id_registro_pago:int;
		public var alumno:Object;
		public var busqueda:Object;
		public var concepto:Object;
		public var objeto:Object;
		
		

		public function PlanDePagosEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}