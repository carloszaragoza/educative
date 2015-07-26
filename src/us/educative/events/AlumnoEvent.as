package us.educative.events
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import us.educative.VO.AlumnoVO;
	import us.educative.VO.FileVO;
	
	public class AlumnoEvent extends Event
	{
		public static const ALUMNO_TRY_SAVE:String = "alumnoTrySave";
		public static const ALUMNO_ENCONTRO_FAMILIA:String = "alumnoEncontroFamilia";
		public static const ALUMNO_BUSQUEDA_FILTRADA:String = "alumnoBusquedaFiltrada";
		public static const ALUMNO_BORRAR:String =  "alumnoBorrar";
		public static const ALUMNO_ACTUALIZAR:String =  "alumnoActualizar";
		public static const ALUMNO_LIMPIAR_FORMULARIO:String =  "alumnoLimpiarFormulario";
		public static const ALUMNO_CLEAR_CONTROLS:String = "alumnoClearControls";
		public static const ALUMNO_SUBIR_FOTO:String = "alumnoSubirFoto";

		public var familia:Object;
		public var alumno:AlumnoVO;
		public var textoBusqueda:String;
		public var dataGrid:Object;
		public var fotografia:FileVO;
		
		public function AlumnoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}