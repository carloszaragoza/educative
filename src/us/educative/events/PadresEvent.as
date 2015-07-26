package us.educative.events
{
	import flash.events.Event;
	
	import us.educative.VO.FamiliaVO;
	
	public class PadresEvent extends Event
	{
		public static const PADRES_UPDATE:String = "padresUpdate";
		public static const PADRES_SAVE:String = "padresSave";
		public static const PADRES_BUSQUEDA_POR_FILTRO:String = "padresBusquedaPorFiltro";
		public static const PADRES_DELETE:String = "padresDelete";
		public static const PADRES_LIMPIA_FORMULARIO_UPDATE:String = "padresLimpiaFormularioUpdate";
		public static const PADRES_LIMPIA_FORMULARIO:String = "padresLimpiaFormulario";
		
		public var familia:FamiliaVO;
		public var busqueda:String;
		public var datagrid:Object;
		
		public function PadresEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}