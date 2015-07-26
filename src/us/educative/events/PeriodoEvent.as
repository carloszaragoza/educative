package us.educative.events
{
	import flash.events.Event;
	
	import us.educative.VO.PeriodoVO;
	
	public class PeriodoEvent extends Event
	{
		public static const PERIODO_LIMPIA_FORMULARIO:String = "periodoLimpiaFormulario";
		public static const PERIODO_LIMPIA_FORMULARIO_UPDATE:String = "periodoLimpiaFormularioUpdate";
		public static const PERIODO_VISTA_BUSCA:String = "periodoVistaBusca";
		public static const PERIODO_BUSQUEDA_POR_FILTRO:String = "periodoBusquedaPorFiltro";
		public static const PERIODO_UPDATE:String = "periodoUpdate";
		public static const PERIODO_SAVE:String = "periodoSave";
		public static const PERIODO_DELETE:String = "periodoDelete";
		
		
		public var busqueda:String;
		public var periodo:PeriodoVO;
		public var datagrid:Object;
		
		public function PeriodoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}