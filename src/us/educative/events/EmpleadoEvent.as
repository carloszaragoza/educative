package us.educative.events
{
	import flash.events.Event;
	
	import us.educative.VO.EmpleadoVO;
	
	public class EmpleadoEvent extends Event
	{
		
		public static const EMPLEADO_GUARDAR:String = "empleadGuardar";
		public static const EMPLEADO_BUSQUEDA_POR_FILTRO:String = "empleadoBusquedaPorFiltro";
		public static const EMPLEADO_LIMPIA_FORMULARIO_UPDATE:String = "empleadoLimpiaFormularioUpdate";
		public static const EMPLEADO_LIMPIA_FORMULARIO:String = "empleadoLimpiaFormulario";
		public static const EMPLEADO_DELETE:String = "empleadoDelete";
		public static const EMPLEADO_UPDATE:String = "empleadoUpdate";
		public static const EMPLEADO_VISTA_BUSCA:String = "empleadoVistaBusca";
		public var empleado:EmpleadoVO;
		
		public var busqueda:String;
		
		public var objeto:Object;
        public static const EMPLEADO_GET_PROFESORES:String = "empleadoGetProfesores";
		
		public function EmpleadoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}